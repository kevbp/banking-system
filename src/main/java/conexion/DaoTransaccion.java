package conexion;

import entidad.Transaccion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.UUID;

public class DaoTransaccion {
    /**
     * Registra la transacción en la BD usando la conexión transaccional.
     */
    public static boolean insertarTransaccion(Transaccion t, Connection cn) throws SQLException {
        String sql = "INSERT INTO t_transaccion (codTransaccion, numCuentaOrigen, numCuentaDestino, codTipMovimiento, fec, monto, canal, codEstado) "
                + "VALUES (?, ?, ?, ?, NOW(), ?, ?, ?)";

        try (PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, t.getCodTransaccion());

            // Manejo de nulos para cuentas origen/destino
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
        // No cerramos la conexión (cn) aquí porque es compartida
    }
}
