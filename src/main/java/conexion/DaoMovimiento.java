package conexion;

import entidad.Movimiento;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.UUID;

public class DaoMovimiento {
    
    public static String generarCodigoMovimiento() {
        return "M" + UUID.randomUUID().toString().substring(0, 18).toUpperCase();
    }

    /**
     * Registra un movimiento de cuenta (débito o crédito) usando la conexión transaccional.
     */
    public static boolean insertarMovimiento(Movimiento mov, Connection cn) throws SQLException {
        
        String sql = "INSERT INTO t_movimiento (codMovimiento, codTransaccion, numCuenta, fec, codTipMovimiento, monto, salFin, des, numCueDes, codEstado) " +
                     "VALUES (?, ?, ?, NOW(), ?, ?, ?, ?, ?, ?)";
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
            if (ps != null) ps.close();
            // LA CONEXIÓN (cn) NO SE CIERRA
        }
    }

    public static String generarCodigoMovimiento(Connection cn) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}