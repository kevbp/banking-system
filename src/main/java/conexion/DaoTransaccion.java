package conexion;

import entidad.Transaccion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.math.BigDecimal;

public class DaoTransaccion {

    // =========================================================================
    // 1. MÉTODO EXISTENTE (USADO POR EMPLEADOS / SERVICIO CUENTA)
    // =========================================================================
    // ¡NO TOCAR! Este método es utilizado por ServicioCuenta.java para el flujo de empleados.
    public static boolean insertarTransaccion(Transaccion t, Connection cn) throws SQLException {
        String sql = "INSERT INTO t_transaccion (codTransaccion, numCuentaOrigen, numCuentaDestino, codTipMovimiento, fec, monto, canal, codEstado) "
                + "VALUES (?, ?, ?, ?, NOW(), ?, ?, ?)";

        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, t.getCodTransaccion());

            if (t.getNumCuentaOrigen() != null) {
                ps.setString(2, t.getNumCuentaOrigen());
            } else {
                ps.setNull(2, java.sql.Types.VARCHAR);
            }

            if (t.getNumCuentaDestino() != null) {
                ps.setString(3, t.getNumCuentaDestino());
            } else {
                ps.setNull(3, java.sql.Types.VARCHAR);
            }

            ps.setString(4, t.getCodTipMovimiento());
            ps.setBigDecimal(5, t.getMonto());
            ps.setString(6, t.getCanal());
            ps.setString(7, t.getCodEstado());

            return ps.executeUpdate() > 0;
        }
    }

    // =========================================================================
    // 2. NUEVO MÉTODO (USADO POR CLIENTES / CONTROL DEPOSITO CLIENTE)
    // =========================================================================
    // Este método encapsula toda la lógica de depósito (saldo, transaccion, movimiento)
    // en una sola transacción de BD para el portal web.
    // --- MÉTODO DEPOSITO CORREGIDO (Sin error de parámetros) ---
    public static String realizarDeposito(String numCuenta, BigDecimal monto, String origenFondos) {
        Connection cn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String resultado = null;

        try {
            cn = Acceso.getConexion();
            cn.setAutoCommit(false);

            // A. Validar Cuenta y Saldo
            String sqlCuenta = "SELECT salAct, codEstado FROM t_cuentas WHERE numCuenta = ?";
            ps = cn.prepareStatement(sqlCuenta);
            ps.setString(1, numCuenta);
            rs = ps.executeQuery();

            BigDecimal saldoActual;
            if (rs.next()) {
                if (!"S0001".equals(rs.getString("codEstado"))) {
                    throw new SQLException("La cuenta no se encuentra Activa.");
                }
                saldoActual = rs.getBigDecimal("salAct");
            } else {
                throw new SQLException("Cuenta no encontrada.");
            }
            rs.close();
            ps.close();

            // B. Generar IDs
            String idTransaccion = "TR" + System.currentTimeMillis();
            String idMovimiento = "MV" + System.currentTimeMillis();

            // C. Insertar Transacción (3 parámetros)
            String sqlTran = "INSERT INTO t_transaccion (codTransaccion, numCuentaDestino, codTipMovimiento, fec, monto, canal, codEstado) "
                    + "VALUES (?, ?, 'TM001', NOW(), ?, 'WEB', 'S0008')";

            ps = cn.prepareStatement(sqlTran);
            ps.setString(1, idTransaccion);
            ps.setString(2, numCuenta);
            ps.setBigDecimal(3, monto);
            ps.executeUpdate();
            ps.close();

            // D. Insertar Movimiento (6 parámetros)
            String descripcion = "DEPOSITO WEB";
            if (origenFondos != null && !origenFondos.isEmpty()) {
                descripcion += " - Origen: " + origenFondos;
            }

            // OJO: Aquí hay exactamente 6 signos de interrogación '?'
            String sqlMov = "INSERT INTO t_movimiento (codMovimiento, codTransaccion, numCuenta, codTipMovimiento, fec, monto, salFin, des, codEstado) "
                    + "VALUES (?, ?, ?, 'TM001', NOW(), ?, ?, ?, 'S0008')";

            BigDecimal nuevoSaldo = saldoActual.add(monto);

            ps = cn.prepareStatement(sqlMov);
            ps.setString(1, idMovimiento);
            ps.setString(2, idTransaccion);
            ps.setString(3, numCuenta);
            ps.setBigDecimal(4, monto);
            ps.setBigDecimal(5, nuevoSaldo);
            ps.setString(6, descripcion);
            // ps.setString(7, "S0008"); <-- ¡ESTA ERA LA LÍNEA CULPABLE! YA LA QUITAMOS.

            ps.executeUpdate();
            ps.close();

            // E. Actualizar Saldo
            String sqlUpdate = "UPDATE t_cuentas SET salAct = ?, fecUltMov = NOW(), codUsuMod = 'CLIENTE' WHERE numCuenta = ?";
            ps = cn.prepareStatement(sqlUpdate);
            ps.setBigDecimal(1, nuevoSaldo);
            ps.setString(2, numCuenta);
            ps.executeUpdate();

            cn.commit();
            resultado = "OK";

        } catch (SQLException e) {
            try {
                if (cn != null) {
                    cn.rollback();
                }
            } catch (SQLException ex) {
            }
            e.printStackTrace();
            resultado = "Error en Depósito: " + e.getMessage();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (cn != null) {
                    cn.close();
                }
            } catch (SQLException ex) {
            }
        }
        return resultado;
    }
}
