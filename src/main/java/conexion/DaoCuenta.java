package conexion;

import entidad.CuentasBancarias; // Importante: Tu nueva clase
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
    // AGREGA ESTE MÉTODO NUEVO:
    public static List<CuentasBancarias> listarCuentas(String numCuenta, String docCliente, String tipoCuenta, String estado) {
        List<CuentasBancarias> lista = new ArrayList<>();

        // Construimos la consulta SQL dinámicamente según los filtros
        StringBuilder sql = new StringBuilder(
                "SELECT c.numCuenta, cl.nomCompleto, tc.descTipo, m.descMoneda, c.salAct, e.des as estadoDes, c.fecApe "
                + "FROM t_cuentas c "
                + "INNER JOIN t_cliente cl ON c.codCliente = cl.codCliente "
                + "INNER JOIN t_tipocuenta tc ON c.codTipCuenta = tc.codTipCuenta "
                + "INNER JOIN t_moneda m ON c.codMoneda = m.codMoneda "
                + "INNER JOIN t_estado e ON c.codEstado = e.codEstado "
                + "WHERE 1=1 ");

        // Aplicamos filtros si no son nulos ni vacíos
        if (numCuenta != null && !numCuenta.isEmpty()) {
            sql.append(" AND c.numCuenta LIKE '%").append(numCuenta).append("%'");
        }
        if (docCliente != null && !docCliente.isEmpty()) {
            sql.append(" AND cl.numDoc LIKE '%").append(docCliente).append("%'");
        }
        if (tipoCuenta != null && !tipoCuenta.isEmpty()) {
            sql.append(" AND tc.descTipo LIKE '%").append(tipoCuenta).append("%'"); // Asegúrate que coincida con los valores del <select>
        }
        if (estado != null && !estado.isEmpty()) {
            sql.append(" AND e.des = '").append(estado).append("'");
        }

        sql.append(" ORDER BY c.fecApe DESC");

        // Ejecutamos la consulta usando tu clase Acceso
        List<Object[]> filas = (List<Object[]>) Acceso.listar(sql.toString());

        if (filas != null) {
            for (Object[] f : filas) {
                CuentasBancarias c = new CuentasBancarias();

                // Mapeamos los resultados del Object[] a la entidad CuentasBancarias
                c.setNumCuenta(f[0] != null ? f[0].toString() : "");

                // Creamos un cliente temporal solo para transportar el nombre a la vista
                Cliente cli = new Cliente();
                cli.setNombre(f[1] != null ? f[1].toString() : "");
                c.setCliente(cli);

                c.setDesTipoCuenta(f[2] != null ? f[2].toString() : "");
                c.setDesMoneda(f[3] != null ? f[3].toString() : "");

                // Conversión segura de BigDecimal para el saldo
                if (f[4] != null) {
                    c.setSalAct(new BigDecimal(f[4].toString()));
                } else {
                    c.setSalAct(BigDecimal.ZERO);
                }

                c.setDesEstado(f[5] != null ? f[5].toString() : "");

                // Conversión de fecha
                if (f[6] != null) {
                    try {
                        c.setFecApe(java.sql.Timestamp.valueOf(f[6].toString()));
                    } catch (Exception e) {
                        c.setFecApe(null);
                    }
                }

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
            } else if ("TC002".equals(c.getCodTipoCuenta())) { // Corriente
                sqlHija = "INSERT INTO t_cuentas_corriente (numCuenta, limSobregiro) VALUES (?, ?)";
                ps = cn.prepareStatement(sqlHija);
                ps.setString(1, c.getNumCuenta());
                ps.setDouble(2, sobregiro);
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

    // Obtener una sola cuenta (usado en Detalle/Operaciones)
    public static CuentasBancarias obtenerCuenta(String numCuenta, Connection cn) {
        CuentasBancarias cuenta = null;

        // CORRECCIÓN: Eliminamos 'cl.ape' y usamos LEFT JOIN para evitar errores si faltan datos relacionados
        String sql = "SELECT c.numCuenta, c.codCliente, c.codTipCuenta, c.codMoneda, c.salAct, c.fecApe, c.codEstado, "
                + "tc.descTipo AS desTipCuenta, m.descMoneda, e.des AS desEstado, "
                + "cl.nomCompleto, cl.numDoc "
                + "FROM t_cuentas c "
                + "LEFT JOIN t_tipocuenta tc ON c.codTipCuenta = tc.codTipCuenta "
                + "LEFT JOIN t_moneda m ON c.codMoneda = m.codMoneda "
                + "LEFT JOIN t_estado e ON c.codEstado = e.codEstado "
                + "LEFT JOIN t_cliente cl ON c.codCliente = cl.codCliente "
                + "WHERE c.numCuenta = ?";

        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            ps = cn.prepareStatement(sql);
            ps.setString(1, numCuenta);
            rs = ps.executeQuery();

            if (rs.next()) {
                cuenta = new CuentasBancarias();

                // Mapeo seguro de datos (validando nulos)
                cuenta.setNumCuenta(rs.getString("numCuenta"));
                cuenta.setCodCliente(rs.getString("codCliente"));
                cuenta.setCodTipoCuenta(rs.getString("codTipCuenta"));
                cuenta.setCodMoneda(rs.getString("codMoneda"));
                cuenta.setSalAct(rs.getBigDecimal("salAct"));
                cuenta.setFecApe(rs.getTimestamp("fecApe"));
                cuenta.setCodEstado(rs.getString("codEstado"));

                cuenta.setDesTipoCuenta(rs.getString("desTipCuenta"));
                cuenta.setDesMoneda(rs.getString("descMoneda"));
                cuenta.setDesEstado(rs.getString("desEstado"));

                // Mapeo del Cliente
                entidad.Cliente cliente = new entidad.Cliente();
                cliente.setCodigo(rs.getString("codCliente"));
                cliente.setNombre(rs.getString("nomCompleto")); // Solo usamos nomCompleto
                cliente.setNumDocumento(rs.getString("numDoc"));

                cuenta.setCliente(cliente);
            }
        } catch (SQLException e) {
            System.err.println("❌ Error CRÍTICO en DaoCuenta.obtenerCuenta: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
            }
        }
        return cuenta;
    }

    public static Object[] verificarExistencia(String num) {
        return Acceso.buscar("SELECT numCuenta FROM t_cuentas WHERE numCuenta='" + num + "'");
    }

    // Método para actualizar saldo (usado en Operaciones)
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

}
