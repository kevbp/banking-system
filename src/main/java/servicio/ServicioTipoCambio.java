
package servicio;

import conexion.DaoTipoCambio;
import entidad.TipoCambio;

public class ServicioTipoCambio {
    public static String registrarTC(String fecha, String horaRegistro, String monedaOrigen, String monedaDestino, String compra, String venta,
                                    String codUsuario, String fechaReg){
        TipoCambio tc = new TipoCambio(fecha, horaRegistro, monedaOrigen, monedaDestino, Double.parseDouble(compra), Double.parseDouble(venta), codUsuario, fechaReg);
        return DaoTipoCambio.registrar(tc);
    }
    
    public static Object[] buscarTC(String fecha){
        return DaoTipoCambio.buscar(fecha);
    }
}
