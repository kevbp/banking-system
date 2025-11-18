package servicio;

import conexion.Acceso; // Necesario para gestionar la conexión
import conexion.DaoCuenta;
import conexion.DaoEmbargo;
import entidad.CuentasBancarias; // Importante: Usar la nueva entidad
import entidad.Embargo;
import utilitarios.Utiles;
import java.math.BigDecimal;
import java.sql.Connection;
import java.util.List;

public class ServicioCuenta {

    // --- 1. APERTURA DE CUENTAS ---
    public String crearNumeroCuentaUnico() {
        String nuevoNumeroCuenta;
        boolean existe;
        do {
            nuevoNumeroCuenta = Utiles.generarNumeroCuenta();
            Object[] cuenta = DaoCuenta.verificarExistencia(nuevoNumeroCuenta);
            existe = (cuenta != null);
        } while (existe);
        return nuevoNumeroCuenta;
    }

    public String registrarCuenta(String codCliente, String tipoCuenta, String moneda, double saldo,
            int plazo, double interes, String codUsuario) {

        String numCuenta = crearNumeroCuentaUnico();
        String cci = "002" + numCuenta + "15"; // Generación simple de CCI

        CuentasBancarias c = new CuentasBancarias();
        c.setNumCuenta(numCuenta);
        c.setCodCliente(codCliente);
        c.setCodTipoCuenta(tipoCuenta);
        c.setCodMoneda(moneda);
        c.setSalIni(new BigDecimal(saldo));
        c.setCci(cci);
        c.setCodUsuCre(codUsuario);

        if (saldo < 0) {
            return "Error: El saldo inicial no puede ser negativo.";
        }

        return DaoCuenta.crearCuenta(c, interes, plazo, 0.0);
    }

    // --- 2. GESTIÓN DE CUENTAS (Estos métodos faltaban) ---
    // Obtener detalle para el Modal (Conexión segura)
    public CuentasBancarias obtenerDetalle(String numCuenta) {
        Connection cn = null;
        CuentasBancarias cb = null;
        try {
            cn = Acceso.getConexion();
            cb = DaoCuenta.obtenerCuenta(numCuenta, cn);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception e) {
            }
        }
        return cb;
    }

    public String cerrarCuenta(String numCuenta) {
        String res = DaoCuenta.cambiarEstado(numCuenta, "S0005"); // Cerrado
        return res == null ? "Cuenta CERRADA correctamente." : "Error al cerrar.";
    }

    public String activarCuenta(String numCuenta) {
        String res = DaoCuenta.cambiarEstado(numCuenta, "S0001"); // S0001 = Activo
        return res == null ? "Cuenta ACTIVADA correctamente." : "Error al activar cuenta.";
    }

    public String inactivarCuenta(String numCuenta) {
        String res = DaoCuenta.cambiarEstado(numCuenta, "S0002"); // Inactivo
        return res == null ? "Cuenta INACTIVADA correctamente." : "Error al inactivar.";
    }

    public String ejecutarEmbargo(String num, double monto, String exp, String mot, String user) {
        Embargo e = new Embargo();
        e.setNumCuenta(num);
        e.setMonto(new BigDecimal(monto));
        e.setExpediente(exp);
        e.setDescripcion(mot);
        e.setCodUsuCre(user);

        if (DaoEmbargo.registrarEmbargo(e) != null) {
            DaoCuenta.cambiarEstado(num, "S0006"); // Embargado
            return "Embargo registrado correctamente.";
        }
        return "Error al registrar embargo.";
    }

    public List<Embargo> listarEmbargos(String numCuenta) {
        return DaoEmbargo.listarEmbargos(numCuenta);
    }
}
