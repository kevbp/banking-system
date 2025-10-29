
package conexion;

import entidad.TipoCambio;

public class DaoTipoCambio {
    public static String registrar(TipoCambio tc) 
    {
        String sql = "INSERT INTO t_tipocambio (fecha,horaRegistro,monedaOrigen,monedaDestino,tasaCompra,tasaVenta,codUsuCre,fecUsuCre,codUsuMod,fecUsuMod) VALUES " +
                    "('"+tc.getFecha()+"', " +
                    "'"+tc.getHoraRegistro()+"', " +
                    "'"+tc.getMonedaOrigen()+"', " +
                    "'"+tc.getMonedaDestino()+"', " +
                    "'"+tc.getTasaCompra()+"', " +
                    "'"+tc.getTasaVenta()+"', " +
                    "'"+tc.getCodUsuCre()+"', " +
                    "'"+tc.getFecUsuCre()+"', " +
                    "'"+tc.getCodUsuCre()+"', " +
                    "'"+tc.getFecUsuCre()+"');";
        return Acceso.ejecutar(sql);
    }
    
    public static Object[] buscar(String fecha) {
        String sql = "SELECT tasaVenta FROM t_tipocambio where fecha = '"+fecha+"'";
        return Acceso.buscar(sql);
    }
}
