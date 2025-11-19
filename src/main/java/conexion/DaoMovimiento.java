package conexion;

import entidad.Movimiento;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.UUID;

public class DaoMovimiento {

    public static String generarCodigoMovimiento() {
        return "M" + UUID.randomUUID().toString().substring(0, 18).toUpperCase();
    }

    /**
     * Registra un movimiento de cuenta (débito o crédito) usando la conexión
     * transaccional.
     */
    public static boolean insertarMovimiento(Movimiento mov, Connection cn) throws SQLException {

        String sql = "INSERT INTO t_movimiento (codMovimiento, codTransaccion, numCuenta, fec, codTipMovimiento, monto, salFin, des, numCueDes, codEstado) "
                + "VALUES (?, ?, ?, NOW(), ?, ?, ?, ?, ?, ?)";
        PreparedStatement ps = null;

        try {
            ps = cn.prepareStatement(sql);
            ps.setString(1, mov.getCodMovimiento());
            ps.setString(2, mov.getCodTransaccion());
            ps.setString(3, mov.getNumCuenta());
            ps.setString(4, mov.getCodTipMovimiento());
            ps.setBigDecimal(5, mov.getMonto());
            ps.setBigDecimal(6, mov.getSalFin());
            ps.setString(7, mov.getDes());
            ps.setString(8, mov.getNumCueDes());
            ps.setString(9, mov.getCodEstado());

            return ps.executeUpdate() == 1;

        } finally {
            if (ps != null) {
                ps.close();
            }
            // LA CONEXIÓN (cn) NO SE CIERRA
        }
    }

    public static String generarCodigoMovimiento(Connection cn) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public static java.util.List<Movimiento> listarUltimosMovimientos(String numCuenta) {
        java.util.List<Movimiento> lista = new java.util.ArrayList<>();

        // JOIN con t_tipomovimiento para saber si es + o -
        String sql = "SELECT m.codMovimiento, m.fec, m.des, m.monto, tm.signo, m.codTransaccion, m.salFin "
                + "FROM t_movimiento m "
                + "INNER JOIN t_tipomovimiento tm ON m.codTipMovimiento = tm.codTipMovimiento "
                + "WHERE m.numCuenta = ? "
                + "ORDER BY m.fec DESC LIMIT 20";

        try (Connection cn = Acceso.getConexion(); PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, numCuenta);
            try (java.sql.ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Movimiento m = new Movimiento();
                    m.setCodMovimiento(rs.getString("codMovimiento"));
                    m.setFec(rs.getTimestamp("fec"));
                    m.setDes(rs.getString("des"));
                    m.setMonto(rs.getBigDecimal("monto"));
                    m.setSigno(rs.getString("signo")); // Usamos el campo auxiliar que agregamos a la Entidad
                    m.setCodTransaccion(rs.getString("codTransaccion"));
                    m.setSalFin(rs.getBigDecimal("salFin"));
                    lista.add(m);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
