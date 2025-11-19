package conexion;

import entidad.CuentasBancarias;
import entidad.Cliente;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DaoCuenta {

    // --- LISTADO CON FILTROS ---
    public static List<CuentasBancarias> listarCuentas(String numCuenta, String docCliente, String tipoCuenta, String estado) {
        List<CuentasBancarias> lista = new ArrayList<>();

        // Agregamos c.codMoneda a la consulta para evitar nulos en la entidad
        StringBuilder sql = new StringBuilder(
                "SELECT c.numCuenta, cl.nomCompleto, tc.descTipo, m.descMoneda, c.salAct, e.des as estadoDes, c.fecApe, c.codMoneda "
                + "FROM t_cuentas c "
                + "LEFT JOIN t_cliente cl ON c.codCliente = cl.codCliente "
                + "LEFT JOIN t_tipocuenta tc ON c.codTipCuenta = tc.codTipCuenta "
                + "LEFT JOIN t_moneda m ON c.codMoneda = m.codMoneda "
                + "LEFT JOIN t_estado e ON c.codEstado = e.codEstado "
                + "WHERE 1=1 ");

        if (numCuenta != null && !numCuenta.isEmpty()) {
            sql.append(" AND c.numCuenta LIKE '%").append(numCuenta).append("%'");
        }
        if (docCliente != null && !docCliente.isEmpty()) {
            sql.append(" AND cl.numDoc LIKE '%").append(docCliente).append("%'");
        }
        if (tipoCuenta != null && !tipoCuenta.isEmpty()) {
            sql.append(" AND tc.descTipo LIKE '%").append(tipoCuenta).append("%'");
        }
        if (estado != null && !estado.isEmpty()) {
            sql.append(" AND e.des = '").append(estado).append("'");
        }

        sql.append(" ORDER BY c.fecApe DESC");

        List<Object[]> filas = Acceso.listar(sql.toString());
        if (filas != null) {
            for (Object[] f : filas) {
                CuentasBancarias c = new CuentasBancarias();
                c.setNumCuenta(validarNull(f[0]));

                Cliente cli = new Cliente();
                cli.setNombre(validarNull(f[1]));
                c.setCliente(cli);

                c.setDesTipoCuenta(validarNull(f[2]));
                c.setDesMoneda(validarNull(f[3]));
                c.setSalAct(f[4] != null ? new BigDecimal(f[4].toString()) : BigDecimal.ZERO);
                c.setDesEstado(validarNull(f[5]));

                try {
                    c.setFecApe(f[6] != null ? java.sql.Timestamp.valueOf(f[6].toString()) : null);
                } catch (Exception e) {
                }

                // Asignar código de moneda (Posición 7 en este array)
                c.setCodMoneda(validarNull(f[7]));

                lista.add(c);
            }
        }
        return lista;
    }

    // --- CREACIÓN TRANSACCIONAL ---
    public static String crearCuenta(CuentasBancarias c, double interes, int plazo, double sobregiro) {
        Connection cn = null;
        PreparedStatement ps = null;
        String msg = null;

        try {
            cn = Acceso.getConexion();
            cn.setAutoCommit(false); // Iniciar Transacción

            // 1. Tabla Padre
            String sqlPadre = "INSERT INTO t_cuentas (numCuenta, codTipCuenta, codCliente, codMoneda, fecApe, salIni, salAct, cci, codEstado, codUsuCre, fecUsuCre) "
                    + "VALUES (?, ?, ?, ?, NOW(), ?, ?, ?, 'S0001', ?, NOW())";

            ps = cn.prepareStatement(sqlPadre);
            ps.setString(1, c.getNumCuenta());
            ps.setString(2, c.getCodTipoCuenta());
            ps.setString(3, c.getCodCliente());
            ps.setString(4, c.getCodMoneda());
            ps.setBigDecimal(5, c.getSalIni());
            ps.setBigDecimal(6, c.getSalIni());
            ps.setString(7, c.getCci());
            ps.setString(8, c.getCodUsuCre());
            ps.executeUpdate();
            ps.close();

            // 2. Tabla Hija
            String sqlHija = "";
            if ("TC001".equals(c.getCodTipoCuenta()) || "TC004".equals(c.getCodTipoCuenta())) { // Ahorros
                sqlHija = "INSERT INTO t_cuentas_ahorro (numCuenta, tasaInt) VALUES (?, ?)";
                ps = cn.prepareStatement(sqlHija);
                ps.setString(1, c.getNumCuenta());
                ps.setDouble(2, interes);
            } else if ("TC002".equals(c.getCodTipoCuenta()) || "TC005".equals(c.getCodTipoCuenta())) { // Corriente
                sqlHija = "INSERT INTO t_cuentas_corriente (numCuenta, limSobregiro) VALUES (?, ?)";
                ps = cn.prepareStatement(sqlHija);
                ps.setString(1, c.getNumCuenta());
                ps.setDouble(2, sobregiro); // Usamos el sobregiro
            } else if ("TC003".equals(c.getCodTipoCuenta())) { // Plazo Fijo
                BigDecimal intFinal = c.getSalIni().multiply(new BigDecimal(interes / 100)).multiply(new BigDecimal(plazo));
                sqlHija = "INSERT INTO t_cuentas_plazos (numCuenta, tasaInt, plazoMeses, fecVenc, intFinal) VALUES (?, ?, ?, DATE_ADD(NOW(), INTERVAL ? MONTH), ?)";
                ps = cn.prepareStatement(sqlHija);
                ps.setString(1, c.getNumCuenta());
                ps.setDouble(2, interes);
                ps.setInt(3, plazo);
                ps.setInt(4, plazo);
                ps.setBigDecimal(5, intFinal);
            }

            if (ps != null) {
                ps.executeUpdate();
            }
            cn.commit(); // Confirmar
            msg = "Cuenta creada con éxito. N°: " + c.getNumCuenta();

        } catch (SQLException e) {
            try {
                if (cn != null) {
                    cn.rollback();
                }
            } catch (SQLException ex) {
            }
            msg = "Error al crear cuenta: " + e.getMessage();
            e.printStackTrace();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
                if (cn != null) {
                    cn.close();
                }
            } catch (SQLException ex) {
            }
        }
        return msg;
    }

    // --- OBTENER CUENTA INDIVIDUAL (PARA OPERACIONES) ---
    public static CuentasBancarias obtenerCuenta(String numCuenta, Connection cn) {
        CuentasBancarias cuenta = null;

        // Consulta completa incluyendo Limite Sobregiro y CODIGO MONEDA
        String sql = "SELECT c.numCuenta, c.salAct, c.fecApe, "
                + "cl.nomCompleto, cl.numDoc, "
                + "tc.descTipo, m.descMoneda, e.des, c.codEstado, c.codTipCuenta, "
                + "cc.limSobregiro, c.codMoneda " // <--- Posición 12: IMPORTANTE
                + "FROM t_cuentas c "
                + "LEFT JOIN t_cliente cl ON c.codCliente = cl.codCliente "
                + "LEFT JOIN t_tipocuenta tc ON c.codTipCuenta = tc.codTipCuenta "
                + "LEFT JOIN t_moneda m ON c.codMoneda = m.codMoneda "
                + "LEFT JOIN t_estado e ON c.codEstado = e.codEstado "
                + "LEFT JOIN t_cuentas_corriente cc ON c.numCuenta = cc.numCuenta "
                + "WHERE c.numCuenta = ?";

        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, numCuenta);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    cuenta = new CuentasBancarias();
                    cuenta.setNumCuenta(rs.getString(1));
                    cuenta.setSalAct(rs.getBigDecimal(2));
                    cuenta.setFecApe(rs.getTimestamp(3));

                    Cliente cli = new Cliente();
                    cli.setNombre(rs.getString(4));
                    cli.setNumDocumento(rs.getString(5));
                    cuenta.setCliente(cli);

                    cuenta.setDesTipoCuenta(rs.getString(6));
                    cuenta.setDesMoneda(rs.getString(7));
                    cuenta.setDesEstado(rs.getString(8));
                    cuenta.setCodEstado(rs.getString(9));
                    cuenta.setCodTipoCuenta(rs.getString(10));

                    // Asignar Sobregiro (Si es null será 0 por lógica en Entidad o BigDecimal)
                    cuenta.setSobregiro(rs.getBigDecimal(11));

                    // Asignar Código de Moneda (Fundamental para validaciones)
                    cuenta.setCodMoneda(rs.getString(12));
                }
            }
        } catch (SQLException e) {
            System.err.println("ERROR SQL Detalle: " + e.getMessage());
        }
        return cuenta;
    }

    public static Object[] verificarExistencia(String num) {
        return Acceso.buscar("SELECT numCuenta FROM t_cuentas WHERE numCuenta='" + num + "'");
    }

    public static boolean actualizarSaldo(String numCuenta, BigDecimal monto, String codUsuarioMod, Connection cn) throws SQLException {
        String sql = "UPDATE t_cuentas SET salAct = ?, codUsuMod = ?, fecUsuMod = NOW(), fecUltMov = NOW() WHERE numCuenta = ?";
        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setBigDecimal(1, monto);
            ps.setString(2, codUsuarioMod);
            ps.setString(3, numCuenta);
            return ps.executeUpdate() == 1;
        }
    }

    public static String cambiarEstado(String numCuenta, String nuevoEstado) {
        String sql = "UPDATE t_cuentas SET codEstado = '" + nuevoEstado + "', fecUsuMod = NOW() WHERE numCuenta = '" + numCuenta + "'";
        return Acceso.ejecutar(sql);
    }

    private static String validarNull(Object obj) {
        return obj != null ? obj.toString() : "";
    }

    public static List<CuentasBancarias> listarPorClientePaginado(String docCliente, int limit, int offset) {
        List<CuentasBancarias> lista = new ArrayList<>();

        String sql = "SELECT c.numCuenta, cl.nomCompleto, tc.descTipo, m.descMoneda, c.salAct, e.des as estadoDes, c.fecApe, c.codMoneda "
                + "FROM t_cuentas c "
                + "LEFT JOIN t_cliente cl ON c.codCliente = cl.codCliente "
                + "LEFT JOIN t_tipocuenta tc ON c.codTipCuenta = tc.codTipCuenta "
                + "LEFT JOIN t_moneda m ON c.codMoneda = m.codMoneda "
                + "LEFT JOIN t_estado e ON c.codEstado = e.codEstado "
                + "WHERE cl.numDoc = '" + docCliente + "' "
                + "ORDER BY c.fecApe DESC "
                + "LIMIT " + limit + " OFFSET " + offset;

        List<Object[]> filas = Acceso.listar(sql);
        if (filas != null) {
            for (Object[] f : filas) {
                CuentasBancarias c = new CuentasBancarias();
                c.setNumCuenta(validarNull(f[0]));

                Cliente cli = new Cliente();
                cli.setNombre(validarNull(f[1]));
                cli.setNumDocumento(docCliente);
                c.setCliente(cli);

                c.setDesTipoCuenta(validarNull(f[2]));
                c.setDesMoneda(validarNull(f[3]));
                c.setSalAct(f[4] != null ? new BigDecimal(f[4].toString()) : BigDecimal.ZERO);
                c.setDesEstado(validarNull(f[5]));
                try {
                    c.setFecApe(f[6] != null ? java.sql.Timestamp.valueOf(f[6].toString()) : null);
                } catch (Exception e) {
                }
                c.setCodMoneda(validarNull(f[7]));

                lista.add(c);
            }
        }
        return lista;
    }

    public static int contarCuentasPorCliente(String docCliente) {
        String sql = "SELECT COUNT(*) FROM t_cuentas c "
                + "LEFT JOIN t_cliente cl ON c.codCliente = cl.codCliente "
                + "WHERE cl.numDoc = '" + docCliente + "'";

        List<Object[]> filas = Acceso.listar(sql);
        if (filas != null && !filas.isEmpty()) {
            return Integer.parseInt(filas.get(0)[0].toString());
        }
        return 0;
    }

    public static List<CuentasBancarias> listarPorCliente(String codCliente) {
        List<CuentasBancarias> lista = new ArrayList<>();
        String sql = "SELECT c.numCuenta, tc.descTipo, m.descMoneda, c.salAct, e.des, c.codMoneda "
                + "FROM t_cuentas c "
                + "INNER JOIN t_tipocuenta tc ON c.codTipCuenta = tc.codTipCuenta "
                + "INNER JOIN t_moneda m ON c.codMoneda = m.codMoneda "
                + "INNER JOIN t_estado e ON c.codEstado = e.codEstado "
                + "WHERE c.codCliente = ? AND c.codEstado = 'S0001' "
                + // Solo cuentas activas
                "ORDER BY c.fecApe DESC";

        try (Connection cn = Acceso.getConexion(); PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, codCliente);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CuentasBancarias c = new CuentasBancarias();
                    c.setNumCuenta(rs.getString(1));
                    c.setDesTipoCuenta(rs.getString(2));
                    c.setDesMoneda(rs.getString(3));
                    c.setSalAct(rs.getBigDecimal(4));
                    c.setDesEstado(rs.getString(5));
                    c.setCodMoneda(rs.getString(6)); // Útil para símbolos
                    lista.add(c);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
