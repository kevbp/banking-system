package conexion;

import entidad.Transaccion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.UUID; 

public class DaoTransaccion {
    
    public static String generarCodigoTransaccion() {
        return "T" + UUID.randomUUID().toString().substring(0, 18).toUpperCase();
    }

    /**
     * Registra la transacción en la BD usando la conexión transaccional.
     */
    public static boolean insertarTransaccion(Transaccion tran, Connection cn) throws SQLException {
        
        String sql = "INSERT INTO t_transaccion (codTransaccion, numCuentaOrigen, numCuentaDestino, codTipMovimiento, fec, monto, canal, codEstado) " +
                     "VALUES (?, ?, ?, ?, NOW(), ?, ?, ?)";
        PreparedStatement ps = null;

        try {
            ps = cn.prepareStatement(sql);
            ps.setString(1, tran.getCodTransaccion());
            ps.setString(2, tran.getNumCuentaOrigen());
            ps.setString(3, tran.getNumCuentaDestino());
            ps.setString(4, tran.getCodTipMovimiento());
            ps.setBigDecimal(5, tran.getMonto()); 
            ps.setString(6, tran.getCanal());
            ps.setString(7, tran.getCodEstado());
            
            return ps.executeUpdate() == 1;

        } finally {
            if (ps != null) ps.close();
            // LA CONEXIÓN (cn) NO SE CIERRA
        }
    }

    public static String generarCodigoTransaccion(Connection cn) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}