package conexion;

import entidad.*;
import java.util.ArrayList;
import java.util.List;
import entidad.TipoCambio;

public class DaoParametros {

    // --- MONEDAS ---
    public static List<Moneda> listarMonedas() {
        List<Moneda> lista = new ArrayList<>();
        String sql = "SELECT codMoneda, descMoneda, simbolo, codEstado FROM t_moneda";
        List<Object[]> filas = Acceso.listar(sql);
        if (filas != null) {
            for (Object[] f : filas) {
                lista.add(new Moneda(f[0].toString(), f[1].toString(), f[2].toString(), f[3].toString()));
            }
        }
        return lista;
    }

    public static String gestionarMoneda(Moneda m, String accion) {
        String sql;
        if ("agregar".equals(accion)) {
            sql = "INSERT INTO t_moneda(codMoneda, descMoneda, simbolo, codEstado) VALUES('"
                    + m.getCodMoneda() + "','" + m.getDescMoneda() + "','" + m.getSimbolo() + "','S0001')";
        } else {
            sql = "UPDATE t_moneda SET descMoneda='" + m.getDescMoneda() + "', simbolo='" + m.getSimbolo()
                    + "' WHERE codMoneda='" + m.getCodMoneda() + "'";
        }
        return Acceso.ejecutar(sql);
    }

    // --- TIPOS DE CUENTA ---
    public static List<TipoCuenta> listarTiposCuenta() {
        List<TipoCuenta> lista = new ArrayList<>();
        // Traemos los datos. Nota: Podrías hacer JOIN con t_moneda para mostrar el nombre de la moneda
        String sql = "SELECT codTipCuenta, descTipo, codMoneda, tasaInt, codEstado FROM t_tipocuenta";
        List<Object[]> filas = Acceso.listar(sql);
        if (filas != null) {
            for (Object[] f : filas) {
                lista.add(new TipoCuenta(f[0].toString(), f[1].toString(), f[2].toString(),
                        Double.parseDouble(f[3].toString()), f[4].toString()));
            }
        }
        return lista;
    }

    public static String agregarTipoCuenta(TipoCuenta t) {
        String nuevoCodigo = generarCodigo("t_tipocuenta", "codTipCuenta", "TC");
        String sql = "INSERT INTO t_tipocuenta(codTipCuenta, descTipo, codMoneda, tasaInt, codEstado) VALUES('"
                + nuevoCodigo + "','" + t.getDescTipo() + "','" + t.getCodMoneda() + "'," + t.getTasaInt() + ",'S0001')";
        return Acceso.ejecutar(sql);
    }

    public static String editarTipoCuenta(TipoCuenta t) {
        String sql = "UPDATE t_tipocuenta SET descTipo='" + t.getDescTipo() + "', codMoneda='" + t.getCodMoneda()
                + "', tasaInt=" + t.getTasaInt() + " WHERE codTipCuenta='" + t.getCodTipCuenta() + "'";
        return Acceso.ejecutar(sql);
    }

    // --- TIPOS DE MOVIMIENTO ---
    public static List<TipoMovimiento> listarTiposMovimiento() {
        List<TipoMovimiento> lista = new ArrayList<>();
        String sql = "SELECT codTipMovimiento, des, signo, codEstado FROM t_tipomovimiento";
        List<Object[]> filas = Acceso.listar(sql);
        if (filas != null) {
            for (Object[] f : filas) {
                lista.add(new TipoMovimiento(f[0].toString(), f[1].toString(),
                        f[2] != null ? f[2].toString() : "", f[3].toString()));
            }
        }
        return lista;
    }

    public static String agregarTipoMovimiento(TipoMovimiento t) {
        String nuevoCodigo = generarCodigo("t_tipomovimiento", "codTipMovimiento", "TM");
        String sql = "INSERT INTO t_tipomovimiento(codTipMovimiento, des, signo, codEstado) VALUES('"
                + nuevoCodigo + "','" + t.getDes() + "','" + t.getSigno() + "','" + t.getCodEstado() + "')";
        return Acceso.ejecutar(sql);
    }

    public static String editarTipoMovimiento(TipoMovimiento t) {
        String sql = "UPDATE t_tipomovimiento SET des='" + t.getDes() + "', signo='" + t.getSigno()
                + "', codEstado='" + t.getCodEstado() + "' WHERE codTipMovimiento='" + t.getCodTipMovimiento() + "'";
        return Acceso.ejecutar(sql);
    }

    // --- TIPO DE CAMBIO (Registro rápido) ---
    public static String registrarTipoCambio(String monedaOrigen, double compra, double venta) {
        // Insertamos un NUEVO registro histórico (no hacemos UPDATE para guardar historial)
        String sql = "INSERT INTO t_tipocambio(fecha, horaRegistro, monedaOrigen, monedaDestino, tasaCompra, tasaVenta, codUsuCre, fecUsuCre) "
                + "VALUES(CURDATE(), CURTIME(), '" + monedaOrigen + "', 'PEN', " + compra + ", " + venta + ", 'U0001', NOW())";
        return Acceso.ejecutar(sql);
    }

    public static List<TipoCambio> listarUltimosTiposCambio() {
        List<TipoCambio> lista = new ArrayList<>();
        // Esta consulta obtiene la última tasa registrada para cada moneda origen (vs PEN)
        String sql = "SELECT t.idTipoCambio, t.monedaOrigen, t.monedaDestino, t.tasaCompra, t.tasaVenta, "
                + "DATE_FORMAT(t.fecha, '%d/%m/%Y'), DATE_FORMAT(t.horaRegistro, '%H:%i') "
                + "FROM t_tipocambio t "
                + "INNER JOIN ("
                + "    SELECT monedaOrigen, MAX(idTipoCambio) as max_id "
                + "    FROM t_tipocambio "
                + "    WHERE monedaDestino = 'PEN' "
                + "    GROUP BY monedaOrigen"
                + ") tm ON t.monedaOrigen = tm.monedaOrigen AND t.idTipoCambio = tm.max_id "
                + "ORDER BY t.monedaOrigen";

        List<Object[]> filas = Acceso.listar(sql);
        if (filas != null) {
            for (Object[] f : filas) {
                lista.add(new TipoCambio(
                        Integer.parseInt(f[0].toString()),
                        f[1].toString(),
                        f[2].toString(),
                        Double.parseDouble(f[3].toString()),
                        Double.parseDouble(f[4].toString()),
                        f[5].toString(),
                        f[6].toString()
                ));
            }
        }
        return lista;
    }

    // --- Helper para generar códigos (Ej: TC001, TC002) ---
    private static String generarCodigo(String tabla, String campoID, String prefijo) {
        String sql = "SELECT MAX(" + campoID + ") FROM " + tabla;
        List<Object[]> filas = Acceso.listar(sql);
        int numero = 1;
        if (filas != null && !filas.isEmpty() && filas.get(0)[0] != null) {
            String ultimo = filas.get(0)[0].toString(); // Ej: TC005
            try {
                numero = Integer.parseInt(ultimo.substring(2)) + 1;
            } catch (Exception e) {
                numero = 1;
            }
        }
        return prefijo + String.format("%03d", numero);
    }

}
