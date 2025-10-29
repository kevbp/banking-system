package conexion;

import entidad.Cuenta;
import entidad.Cliente;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

public class DaoCuenta {

    /**
     * Obtiene los datos de la cuenta y su cliente asociado. No cierra la conexión.
     * @param numCuenta El número de cuenta a buscar.
     * @param cn Conexión activa para la BD (para uso transaccional).
     * @return Objeto Cuenta completo, o null si no se encuentra.
     */
    public static Cuenta obtenerCuenta(String numCuenta, Connection cn) {
        Cuenta cuenta = null;
        
        String sql = "SELECT c.*, tc.descTipo AS desTipCuenta, m.descMoneda, e.des AS desEstado, " +
                     "cl.codCliente, cl.nomCompleto, cl.ape, cl.tipoDoc, cl.numDoc, cl.fecNac, cl.dir, cl.codUbigeo, cl.tel, cl.cel, cl.email, cl.fecReg, cl.codEstado AS estadoCliente " +
                     "FROM t_cuentas c " +
                     "INNER JOIN t_tipocuenta tc ON c.codTipCuenta = tc.codTipCuenta " +
                     "INNER JOIN t_moneda m ON c.codMoneda = m.codMoneda " +
                     "INNER JOIN t_estado e ON c.codEstado = e.codEstado " +
                     "INNER JOIN t_cliente cl ON c.codCliente = cl.codCliente " +
                     "WHERE c.numCuenta = ?";
        
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Se usa la conexión recibida
            ps = cn.prepareStatement(sql); 
            ps.setString(1, numCuenta);
            rs = ps.executeQuery();

            if (rs.next()) {
                cuenta = new Cuenta();
                
                // Mapeo de datos de la CUENTA
                cuenta.setNumCuenta(rs.getString("numCuenta"));
                cuenta.setCodCliente(rs.getString("codCliente"));
                cuenta.setCodTipoCuenta(rs.getString("codTipCuenta"));
                cuenta.setCodMoneda(rs.getString("codMoneda"));
                cuenta.setSalAct(rs.getBigDecimal("salAct")); 
                cuenta.setFecApe(rs.getTimestamp("fecApe")); 
                cuenta.setCodEstado(rs.getString("codEstado"));
                
                // Datos de JOINs (descripciones)
                cuenta.setDesTipoCuenta(rs.getString("desTipCuenta"));
                cuenta.setDesMoneda(rs.getString("descMoneda"));
                cuenta.setDesEstado(rs.getString("desEstado"));

                // Mapeo de datos del CLIENTE (SOLUCIONA EL ERROR EN ROJO)
                Cliente cliente = new Cliente();
                cliente.setCodigo(rs.getString("codCliente")); // Asume que este setter existe en Cliente.java
                cliente.setNombre(rs.getString("nomCompleto"));       // Asume que este setter existe en Cliente.java
                cliente.setTipoDoc(rs.getString("tipoDoc"));
                cliente.setNumDocumento(rs.getString("numDoc"));
                cliente.setFechaNac(rs.getString("fecNac")); // Usas String en Cliente.java
                cliente.setDireccion(rs.getString("dir"));
                cliente.setCodUbigeo(rs.getString("codUbigeo"));
                cliente.setTelefono(rs.getString("tel"));
                cliente.setCelular(rs.getString("cel"));
                cliente.setEmail(rs.getString("email"));
                cliente.setFechaReg(rs.getString("fecReg"));
                cliente.setEstado(rs.getString("estadoCliente")); // Columna renombrada en SQL
                
                cuenta.setCliente(cliente); // SOLUCIONA EL ERROR EN ROJO
            }
        } catch (SQLException e) {
            System.err.println("❌ Error DAO al obtener cuenta: " + e.getMessage());
        } finally {
            // Importante: Solo cerramos ResultSet y PreparedStatement. La Conexión (cn) queda abierta para el servicio.
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
            } catch (SQLException e) {
                System.err.println("❌ Error al cerrar recursos del DAO: " + e.getMessage());
            }
        }
        return cuenta;
    }

    /**
     * Actualiza el saldo de una cuenta. Usa la conexión transaccional.
     * @param numCuenta Cuenta a modificar.
     * @param monto El nuevo saldo de la cuenta.
     * @param codUsuarioMod Código del usuario que modifica.
     * @param cn Conexión activa bajo control transaccional (NO hace COMMIT).
     * @return true si se actualizó una fila, false si no.
     */
    public static boolean actualizarSaldo(String numCuenta, BigDecimal monto, String codUsuarioMod, Connection cn) throws SQLException {
        
        String sql = "UPDATE t_cuentas SET salAct = ?, codUsuMod = ?, fecUsuMod = NOW(), fecUltMov = NOW() WHERE numCuenta = ?";
        PreparedStatement ps = null;

        try {
            // Se usa la conexión recibida
            ps = cn.prepareStatement(sql); 
            ps.setBigDecimal(1, monto);
            ps.setString(2, codUsuarioMod);
            ps.setString(3, numCuenta);
            
            int filasAfectadas = ps.executeUpdate();
            
            return filasAfectadas == 1;

        } finally {
            // Importante: Solo cerramos PreparedStatement. La Conexión (cn) queda abierta para el servicio.
            if (ps != null) ps.close();
        }
    }

    public static boolean actualizarSaldo(String numCuentaOrigen, BigDecimal negate, Connection cn) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
