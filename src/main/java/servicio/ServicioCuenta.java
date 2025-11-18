package servicio;

import conexion.Acceso; // Necesario para gestionar la conexión
import conexion.DaoCuenta;
import conexion.DaoEmbargo;
import conexion.DaoMovimiento;
import conexion.DaoTransaccion;
import entidad.CuentasBancarias; // Importante: Usar la nueva entidad
import entidad.Embargo;
import entidad.Movimiento;
import entidad.Transaccion;
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

    // --- 3. OPERACIONES BANCARIAS ---
    public String realizarDeposito(String numCuenta, double monto, String medioPago, String origenFondos, String codUsuario, String observacion) {
        Connection cn = null;
        String msg = null;

        try {
            cn = Acceso.getConexion();
            cn.setAutoCommit(false); // INICIO DE TRANSACCIÓN

            // 1. Validar Cuenta y Estado
            CuentasBancarias cuenta = DaoCuenta.obtenerCuenta(numCuenta, cn);
            if (cuenta == null) {
                throw new Exception("La cuenta no existe.");
            }
            if (!"Activo".equals(cuenta.getDesEstado()) && !"Activa".equals(cuenta.getDesEstado())) {
                throw new Exception("Cuenta no activa. Estado: " + cuenta.getDesEstado());
            }

            // 2. Calcular Nuevo Saldo
            BigDecimal montoBD = new BigDecimal(monto);
            if (montoBD.compareTo(BigDecimal.ZERO) <= 0) {
                throw new Exception("El monto debe ser mayor a 0.");
            }
            BigDecimal nuevoSaldo = cuenta.getSalAct().add(montoBD);

            // 3. Actualizar Saldo en Cuenta
            if (!DaoCuenta.actualizarSaldo(numCuenta, nuevoSaldo, codUsuario, cn)) {
                throw new Exception("No se pudo actualizar el saldo.");
            }

            // ---------------------------------------------------------
            // 4. REGISTRAR TRANSACCIÓN (CABECERA) - ¡ESTO FALTABA!
            // ---------------------------------------------------------
            String idTransaccion = utilitarios.Utiles.generarIdTransaccion(); // Generamos el ID aquí

            Transaccion tran = new Transaccion();
            tran.setCodTransaccion(idTransaccion);
            tran.setNumCuentaOrigen(null); // En depósito efectivo no hay cuenta origen del sistema
            tran.setNumCuentaDestino(numCuenta); // El dinero va a esta cuenta
            tran.setCodTipMovimiento("TM001"); // Código para DEPÓSITO (Verifica tu tabla t_tipomovimiento)
            tran.setMonto(montoBD);
            tran.setCanal("VENTANILLA"); // O "WEB" según corresponda
            tran.setCodEstado("S0008"); // Procesado

            if (!DaoTransaccion.insertarTransaccion(tran, cn)) {
                throw new Exception("Error al registrar la transacción.");
            }

            // ---------------------------------------------------------
            // 5. REGISTRAR MOVIMIENTO (DETALLE)
            // ---------------------------------------------------------
            Movimiento mov = new Movimiento();
            mov.setCodMovimiento(DaoMovimiento.generarCodigoMovimiento());
            mov.setCodTransaccion(idTransaccion); // ¡USAMOS EL ID DE LA TRANSACCIÓN CREADA!
            mov.setNumCuenta(numCuenta);
            mov.setCodTipMovimiento("TM001");
            mov.setMonto(montoBD);
            mov.setSalFin(nuevoSaldo);
            mov.setDes("DEPÓSITO (" + medioPago + ") - " + (observacion != null ? observacion : ""));
            mov.setNumCueDes(numCuenta); // Cuenta afectada
            mov.setCodEstado("S0008"); // Procesado

            // Agregar origen de fondos a la descripción si existe (Regla de negocio > 2000)
            if (origenFondos != null && !origenFondos.isEmpty()) {
                mov.setDes(mov.getDes() + " | Origen: " + origenFondos);
            }

            if (!DaoMovimiento.insertarMovimiento(mov, cn)) {
                throw new Exception("Error al registrar el movimiento.");
            }

            cn.commit(); // CONFIRMAR TODO
            msg = "Depósito realizado con éxito. Nuevo Saldo: " + nuevoSaldo;

        } catch (Exception e) {
            try {
                if (cn != null) {
                    cn.rollback();
                }
            } catch (Exception ex) {
            }
            e.printStackTrace();
            msg = "Error: " + e.getMessage();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception ex) {
            }
        }
        return msg;
    }

    // ... (métodos anteriores) ...
    public String realizarRetiro(String numCuenta, double monto, String codUsuario, String observacion) {
        Connection cn = null;
        String msg = null;

        try {
            cn = Acceso.getConexion();
            cn.setAutoCommit(false); // INICIO DE TRANSACCIÓN

            // 1. Validar Cuenta
            CuentasBancarias cuenta = DaoCuenta.obtenerCuenta(numCuenta, cn);
            if (cuenta == null) {
                throw new Exception("La cuenta no existe.");
            }

            if (!"S0001".equals(cuenta.getCodEstado())) { // S0001 = Activo
                throw new Exception("No se puede retirar. La cuenta no está activa.");
            }

            BigDecimal montoBD = new BigDecimal(monto);
            if (montoBD.compareTo(BigDecimal.ZERO) <= 0) {
                throw new Exception("El monto debe ser mayor a 0.");
            }

            // 2. VALIDAR FONDOS (Lógica Ahorros vs Corriente)
            // TC002 = Corriente Soles, TC005 = Corriente Dólares (Según tu BD)
            boolean esCorriente = "TC002".equals(cuenta.getCodTipoCuenta()) || "TC005".equals(cuenta.getCodTipoCuenta());

            if (esCorriente) {
                // CORRIENTE: Saldo + Sobregiro >= Monto
                BigDecimal capacidadTotal = cuenta.getSalAct().add(cuenta.getSobregiro());

                if (capacidadTotal.compareTo(montoBD) < 0) {
                    throw new Exception("Fondos insuficientes (incluyendo sobregiro). Capacidad: " + capacidadTotal);
                }
            } else {
                // AHORROS: Solo Saldo >= Monto
                if (cuenta.getSalAct().compareTo(montoBD) < 0) {
                    throw new Exception("Saldo insuficiente. Disponible: " + cuenta.getSalAct());
                }
            }

            // 3. ACTUALIZAR SALDO (Resta)
            BigDecimal nuevoSaldo = cuenta.getSalAct().subtract(montoBD);
            if (!DaoCuenta.actualizarSaldo(numCuenta, nuevoSaldo, codUsuario, cn)) {
                throw new Exception("No se pudo actualizar el saldo.");
            }

            // 4. REGISTRAR TRANSACCIÓN
            String idTransaccion = utilitarios.Utiles.generarIdTransaccion();
            entidad.Transaccion tran = new entidad.Transaccion();
            tran.setCodTransaccion(idTransaccion);
            tran.setNumCuentaOrigen(numCuenta);
            tran.setCodTipMovimiento("TM002"); // <--- CORREGIDO: TM002
            tran.setMonto(montoBD);
            tran.setCanal("VENTANILLA");
            tran.setCodEstado("S0008");

            if (!conexion.DaoTransaccion.insertarTransaccion(tran, cn)) {
                throw new Exception("Error al registrar la transacción.");
            }

            // 5. REGISTRAR MOVIMIENTO
            entidad.Movimiento mov = new entidad.Movimiento();
            mov.setCodMovimiento(conexion.DaoMovimiento.generarCodigoMovimiento());
            mov.setCodTransaccion(idTransaccion);
            mov.setNumCuenta(numCuenta);
            mov.setCodTipMovimiento("TM002"); // <--- CORREGIDO: TM002
            mov.setMonto(montoBD);
            mov.setSalFin(nuevoSaldo);
            mov.setDes("RETIRO VENTANILLA - " + (observacion != null ? observacion : ""));
            mov.setCodEstado("S0008");

            if (!conexion.DaoMovimiento.insertarMovimiento(mov, cn)) {
                throw new Exception("Error al registrar el movimiento.");
            }

            cn.commit();
            msg = "Retiro realizado con éxito. Nuevo Saldo: " + nuevoSaldo;

        } catch (Exception e) {
            try {
                if (cn != null) {
                    cn.rollback();
                }
            } catch (Exception ex) {
            }
            e.printStackTrace();
            msg = "Error: " + e.getMessage();
        } finally {
            try {
                if (cn != null) {
                    cn.close();
                }
            } catch (Exception ex) {
            }
        }
        return msg;
    }
}
