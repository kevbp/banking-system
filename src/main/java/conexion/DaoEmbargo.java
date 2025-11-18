package conexion;

import entidad.Embargo;
import java.util.List;

public class DaoEmbargo {

    public static String registrarEmbargo(Embargo e) {
        String nuevoCodigo = generarCodigo();
        e.setCodEmbargo(nuevoCodigo);

        String sql = "INSERT INTO t_embargo (codEmbargo, numCuenta, mon, expedienteJudicial, descripcion, montoLiberado, codEstado, codUsuCre, fecUsuCre) "
                + "VALUES ('" + e.getCodEmbargo() + "', '" + e.getNumCuenta() + "', " + e.getMonto() + ", '"
                + e.getExpediente() + "', '" + e.getDescripcion() + "', 0.00, 'S0001', '" + e.getCodUsuCre() + "', NOW())";

        // Ejecutamos la inserción
        String res = Acceso.ejecutar(sql);

        // Si sale bien, retornamos el código generado, si no, el error (o null según tu lógica de Acceso)
        return (res == null) ? nuevoCodigo : null;
    }

    public static List<Object[]> listarPorCuenta(String numCuenta) {
        String sql = "SELECT codEmbargo, mon, expedienteJudicial, descripcion, fecUsuCre FROM t_embargo WHERE numCuenta = '" + numCuenta + "' AND codEstado = 'S0001'";
        return Acceso.listar(sql);
    }

    private static String generarCodigo() {
        String sql = "SELECT MAX(codEmbargo) FROM t_embargo";
        Object[] res = Acceso.buscar(sql);
        int num = 1;
        if (res != null && res[0] != null) {
            try {
                // Asume formato EMB0001
                num = Integer.parseInt(res[0].toString().substring(3)) + 1;
            } catch (Exception ex) {
                num = 1;
            }
        }
        return "EMB" + String.format("%04d", num);
    }
}
