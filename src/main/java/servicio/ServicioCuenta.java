package servicio;

import conexion.DaoCuenta;
import conexion.DaoEmbargo; // Nuevo import
import entidad.CuentasBancarias;
import entidad.Embargo; // Nuevo import
import utilitarios.Utiles;
import java.math.BigDecimal;
import java.util.List;

public class ServicioCuenta {

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
        String cci = "002" + numCuenta + "15";

        CuentasBancarias c = new CuentasBancarias(); // <--- Uso de la nueva clase
        c.setNumCuenta(numCuenta);
        c.setCodCliente(codCliente);
        c.setCodTipoCuenta(tipoCuenta);
        c.setCodMoneda(moneda);
        c.setSalIni(new BigDecimal(saldo));
        c.setCci(cci);
        c.setCodUsuCre(codUsuario);

        if (saldo < 0) {
            return "El saldo inicial no puede ser negativo.";
        }

        return DaoCuenta.crearCuenta(c, interes, plazo, 0.0);
    }

    // Lógica para Cerrar Cuenta
    public String cerrarCuenta(String numCuenta) {
        // Regla: No se puede cerrar si tiene saldo (opcional, depende del banco)
        // Aquí asumimos cierre directo a estado 'S0005' (Cerrado)
        String res = DaoCuenta.cambiarEstado(numCuenta, "S0005");
        return res == null ? "Cuenta cerrada correctamente." : "Error al cerrar cuenta.";
    }

    // Lógica para Inactivar Cuenta
    public String inactivarCuenta(String numCuenta) {
        // Estado 'S0002' (Inactivo)
        String res = DaoCuenta.cambiarEstado(numCuenta, "S0002");
        return res == null ? "Cuenta inactivada correctamente." : "Error al inactivar cuenta.";
    }

    // Lógica para Embargar (Compleja: Inserta embargo + Cambia estado cuenta)
    public String ejecutarEmbargo(String numCuenta, double monto, String expediente, String motivo, String usuario) {

        // 1. Registrar el embargo en el historial
        Embargo e = new Embargo();
        e.setNumCuenta(numCuenta);
        e.setMonto(new BigDecimal(monto));
        e.setExpediente(expediente);
        e.setDescripcion(motivo);
        e.setCodUsuCre(usuario);

        String codEmbargo = DaoEmbargo.registrarEmbargo(e);

        if (codEmbargo != null) {
            // 2. Cambiar estado de la cuenta a 'S0006' (Embargado)
            DaoCuenta.cambiarEstado(numCuenta, "S0006");
            return "OK";
        } else {
            return "Error al registrar el embargo en base de datos.";
        }
    }

    // Método para obtener detalles JSON (para el modal)
    public CuentasBancarias obtenerDetalle(String numCuenta) {
        // Usamos una conexión temporal solo para lectura rápida
        java.sql.Connection cn = conexion.Acceso.getConexion();
        CuentasBancarias cb = DaoCuenta.obtenerCuenta(numCuenta, cn);
        try {
            cn.close();
        } catch (Exception ex) {
        }
        return cb;
    }

    // Obtener embargos activos para mostrar en el modal
    public List<Object[]> listarEmbargos(String numCuenta) {
        return DaoEmbargo.listarPorCuenta(numCuenta);
    }
}
