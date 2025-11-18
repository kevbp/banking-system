package conexion;

import entidad.Embargo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class DaoEmbargo {

    // 1. LISTAR EMBARGOS POR CUENTA
    public static List<Embargo> listarEmbargos(String numCuenta) {
        List<Embargo> lista = new ArrayList<>();
        // Consulta que trae historial completo (sin filtrar solo activos) y mapea columnas correctas
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
                    e.setMonto(rs.getBigDecimal("mon")); // Mapeo exacto a tu BD
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

    // 2. REGISTRAR NUEVO EMBARGO
    public static String registrarEmbargo(Embargo e) {
        Connection cn = null;
        PreparedStatement ps = null;
        String msg = "";

        try {
            cn = Acceso.getConexion();
            cn.setAutoCommit(false); // Transacción

            // A. Generar Código (Ej: EM0001)
            String sqlGen = "SELECT CONCAT('EM', LPAD(IFNULL(MAX(SUBSTRING(codEmbargo, 3)), 0) + 1, 4, '0')) FROM t_embargo";
            ps = cn.prepareStatement(sqlGen);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                e.setCodEmbargo(rs.getString(1));
            }
            ps.close();

            // B. Insertar Embargo (Estado S0001 = Activo)
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

            // C. Actualizar Estado Cuenta a 'S0006' (Embargado)
            String sqlUpdCta = "UPDATE t_cuentas SET codEstado = 'S0006' WHERE numCuenta = ?";
            ps = cn.prepareStatement(sqlUpdCta);
            ps.setString(1, e.getNumCuenta());
            ps.executeUpdate();

            cn.commit();
            msg = "Embargo registrado correctamente. Código: " + e.getCodEmbargo();

        } catch (SQLException ex) {
            try {
                if (cn != null) {
                    cn.rollback();
                }
            } catch (SQLException i) {
            }
            ex.printStackTrace();
            msg = "Error al registrar embargo.";
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

    // 3. LEVANTAR EMBARGO (Cambiar estado a S0007 = Liberado)
    public static String levantarEmbargo(String codEmbargo, BigDecimal montoLiberado, String numCuenta) {
        Connection cn = null;
        PreparedStatement ps = null;
        String msg = "";

        try {
            cn = Acceso.getConexion();
            cn.setAutoCommit(false);

            // A. Actualizar Embargo
            String sql = "UPDATE t_embargo SET codEstado='S0007', montoLiberado=?, fecUsuMod=NOW() WHERE codEmbargo=?";
            ps = cn.prepareStatement(sql);
            ps.setBigDecimal(1, montoLiberado);
            ps.setString(2, codEmbargo);
            ps.executeUpdate();
            ps.close();

            // B. Verificar si quedan embargos activos en la cuenta
            // Si no hay más embargos activos (S0001), devolvemos la cuenta a Activa (S0001)
            String sqlCheck = "SELECT COUNT(*) FROM t_embargo WHERE numCuenta=? AND codEstado='S0001'";
            ps = cn.prepareStatement(sqlCheck);
            ps.setString(1, numCuenta);
            ResultSet rs = ps.executeQuery();
            boolean hayMasEmbargos = false;
            if (rs.next()) {
                hayMasEmbargos = rs.getInt(1) > 0;
            }
            ps.close();

            if (!hayMasEmbargos) {
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
            msg = "Error al actualizar.";
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
}
