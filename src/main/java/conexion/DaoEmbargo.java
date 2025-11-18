package conexion;

import entidad.Embargo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DaoEmbargo {

    // 1. LISTAR EMBARGOS (Con mapeo correcto a tu BD)
    public static List<Embargo> listarEmbargos(String numCuenta) {
        List<Embargo> lista = new ArrayList<>();
        String sql = "SELECT codEmbargo, numCuenta, mon, expedienteJudicial, descripcion, "
                + "montoLiberado, codEstado, fecUsuCre "
                + "FROM t_embargo WHERE numCuenta = ? ORDER BY fecUsuCre DESC";

        try (Connection cn = Acceso.getConexion(); PreparedStatement ps = cn.prepareStatement(sql)) {

            ps.setString(1, numCuenta);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Embargo e = new Embargo();
                    e.setCodEmbargo(rs.getString("codEmbargo"));
                    e.setNumCuenta(rs.getString("numCuenta"));
                    e.setMonto(rs.getBigDecimal("mon"));
                    e.setExpediente(rs.getString("expedienteJudicial"));
                    e.setDescripcion(rs.getString("descripcion"));
                    e.setMontoLiberado(rs.getBigDecimal("montoLiberado"));
                    e.setCodEstado(rs.getString("codEstado"));
                    e.setFecUsuCre(rs.getTimestamp("fecUsuCre"));
                    lista.add(e);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // 2. REGISTRAR NUEVO EMBARGO (Transaccional)
    public static String registrarEmbargo(Embargo e) {
        Connection cn = null;
        PreparedStatement ps = null;
        String msg = "";

        try {
            cn = Acceso.getConexion();
            cn.setAutoCommit(false); // INICIAR TRANSACCIÓN

            // A. Generar Código en Java (Más seguro)
            String nuevoCod = generarCodigo(cn);
            e.setCodEmbargo(nuevoCod);

            // B. Insertar Embargo
            String sqlInsert = "INSERT INTO t_embargo (codEmbargo, numCuenta, mon, expedienteJudicial, descripcion, montoLiberado, codEstado, codUsuCre, fecUsuCre) "
                    + "VALUES (?, ?, ?, ?, ?, 0, 'S0001', ?, NOW())";

            ps = cn.prepareStatement(sqlInsert);
            ps.setString(1, e.getCodEmbargo());
            ps.setString(2, e.getNumCuenta());
            ps.setBigDecimal(3, e.getMonto());
            ps.setString(4, e.getExpediente());
            ps.setString(5, e.getDescripcion());
            ps.setString(6, e.getCodUsuCre());
            ps.executeUpdate();
            ps.close();

            // C. Actualizar Estado Cuenta
            String sqlUpdCta = "UPDATE t_cuentas SET codEstado = 'S0006' WHERE numCuenta = ?";
            ps = cn.prepareStatement(sqlUpdCta);
            ps.setString(1, e.getNumCuenta());
            ps.executeUpdate();
            ps.close();

            cn.commit(); // CONFIRMAR CAMBIOS
            msg = "Embargo registrado correctamente. Código: " + e.getCodEmbargo();

        } catch (SQLException ex) {
            try {
                if (cn != null) {
                    cn.rollback();
                }
            } catch (SQLException i) {
            }
            ex.printStackTrace();
            // ¡AQUÍ EL CAMBIO! Devolvemos el error real para verlo en pantalla
            msg = "Error SQL: " + ex.getMessage();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (SQLException i) {
            }
        }
        return msg;
    }

    // 3. LEVANTAR EMBARGO
    public static String levantarEmbargo(String codEmbargo, java.math.BigDecimal montoLiberado, String numCuenta) {
        Connection cn = null;
        PreparedStatement ps = null;
        String msg = "";

        try {
            cn = Acceso.getConexion();
            cn.setAutoCommit(false);

            // Actualizar Embargo
            String sql = "UPDATE t_embargo SET codEstado='S0007', montoLiberado=?, fecUsuMod=NOW() WHERE codEmbargo=?";
            ps = cn.prepareStatement(sql);
            ps.setBigDecimal(1, montoLiberado);
            ps.setString(2, codEmbargo);
            ps.executeUpdate();
            ps.close();

            // Verificar si quedan activos
            String sqlCheck = "SELECT COUNT(*) FROM t_embargo WHERE numCuenta=? AND codEstado='S0001'";
            ps = cn.prepareStatement(sqlCheck);
            ps.setString(1, numCuenta);
            ResultSet rs = ps.executeQuery();
            boolean hayMas = false;
            if (rs.next()) {
                hayMas = rs.getInt(1) > 0;
            }
            ps.close();

            if (!hayMas) {
                String sqlUpdCta = "UPDATE t_cuentas SET codEstado = 'S0001' WHERE numCuenta = ?";
                ps = cn.prepareStatement(sqlUpdCta);
                ps.setString(1, numCuenta);
                ps.executeUpdate();
            }

            cn.commit();
            msg = "Embargo levantado correctamente.";

        } catch (SQLException ex) {
            try {
                if (cn != null) {
                    cn.rollback();
                }
            } catch (SQLException i) {
            }
            msg = "Error al actualizar: " + ex.getMessage();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (SQLException i) {
            }
        }
        return msg;
    }

    // MÉTODO AUXILIAR PARA GENERAR CÓDIGO (Ej: EM0001)
    // MÉTODO AUXILIAR ROBUSTO PARA GENERAR CÓDIGO
    private static String generarCodigo(Connection cn) throws SQLException {
        // 1. Buscamos el código más alto QUE CUMPLA con el formato 'EM%' y tenga el largo correcto (6 caracteres)
        // Esto evita que datos basura rompan la generación.
        String sql = "SELECT codEmbargo FROM t_embargo "
                + "WHERE codEmbargo LIKE 'EM%' AND LENGTH(codEmbargo) = 6 "
                + "ORDER BY codEmbargo DESC LIMIT 1";

        PreparedStatement ps = cn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        String codigo = "EM0001"; // Valor por defecto si no hay registros válidos

        if (rs.next()) {
            String max = rs.getString("codEmbargo");
            if (max != null) {
                try {
                    // Extraer parte numérica (EM0001 -> 0001)
                    int num = Integer.parseInt(max.substring(2));
                    // Generar el siguiente (0001 + 1 = 0002 -> EM0002)
                    codigo = "EM" + String.format("%04d", num + 1);
                } catch (NumberFormatException e) {
                    // Si falla el parseo, usamos un código de seguridad basado en timestamp para no chocar
                    codigo = "EM" + (System.currentTimeMillis() % 10000);
                }
            }
        }
        rs.close();
        ps.close();

        return codigo;
    }
}
