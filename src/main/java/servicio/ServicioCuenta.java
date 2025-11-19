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

    // --- TRANSFERENCIAS ---
    public String realizarTransferencia(String ctaOrigen, String ctaDestino, double monto, String codUsuario, String obs) {
        Connection cn = null;
        String msg = null;

        try {
            cn = Acceso.getConexion();
            cn.setAutoCommit(false); // INICIO TRANSACCIÓN

            // -------------------------------------------------------
            // 1. VALIDAR CUENTAS (Origen y Destino)
            // -------------------------------------------------------
            CuentasBancarias ori = DaoCuenta.obtenerCuenta(ctaOrigen, cn);
            CuentasBancarias des = DaoCuenta.obtenerCuenta(ctaDestino, cn);

            if (ori == null) {
                throw new Exception("La cuenta de origen no existe.");
            }
            if (des == null) {
                throw new Exception("La cuenta de destino no existe.");
            }
            if (ctaOrigen.equals(ctaDestino)) {
                throw new Exception("No puede transferir a la misma cuenta.");
            }

            // Validar Estados
            if (!"S0001".equals(ori.getCodEstado())) {
                throw new Exception("Cuenta origen no está activa.");
            }
            if (!"S0001".equals(des.getCodEstado())) {
                throw new Exception("Cuenta destino no está activa.");
            }

            // Validar Tipo (NO PLAZO FIJO - TC003)
            if ("TC003".equals(ori.getCodTipoCuenta())) {
                throw new Exception("No se permiten transferencias desde Cuentas a Plazo.");
            }
            if ("TC003".equals(des.getCodTipoCuenta())) {
                throw new Exception("No se permiten transferencias hacia Cuentas a Plazo.");
            }

            // -------------------------------------------------------
            // 2. CÁLCULO DE MONTOS Y TIPO DE CAMBIO
            // -------------------------------------------------------
            BigDecimal montoSalida = new BigDecimal(monto); // Lo que sale de Origen
            BigDecimal montoEntrada = montoSalida;          // Lo que entra a Destino (inicialmente igual)
            String infoCambio = "";

            // Si las monedas son diferentes, aplicar conversión
            if (!ori.getCodMoneda().equals(des.getCodMoneda())) {
                // Obtener tasas (asumimos cambio con Dólares USD)
                String monedaExtranjera = ori.getCodMoneda().equals("PEN") ? des.getCodMoneda() : ori.getCodMoneda();
                double[] tasas = conexion.DaoParametros.obtenerTasaCambio(monedaExtranjera);
                double compra = tasas[0];
                double venta = tasas[1];

                if (compra == 0 || venta == 0) {
                    throw new Exception("No hay tipo de cambio registrado para hoy.");
                }

                if (ori.getCodMoneda().equals("USD") && des.getCodMoneda().equals("PEN")) {
                    // Dólares a Soles -> Banco Compra Dólares
                    montoEntrada = montoSalida.multiply(new BigDecimal(compra));
                    infoCambio = " (T.C. Compra: " + compra + ")";
                } else if (ori.getCodMoneda().equals("PEN") && des.getCodMoneda().equals("USD")) {
                    // Soles a Dólares -> Banco Vende Dólares
                    // Entrada = Salida / Venta
                    montoEntrada = montoSalida.divide(new BigDecimal(venta), 2, java.math.RoundingMode.HALF_DOWN);
                    infoCambio = " (T.C. Venta: " + venta + ")";
                }
            }

            // -------------------------------------------------------
            // 3. VALIDAR FONDOS EN ORIGEN (Con Sobregiro)
            // -------------------------------------------------------
            boolean esCorriente = "TC002".equals(ori.getCodTipoCuenta()) || "TC005".equals(ori.getCodTipoCuenta());
            BigDecimal capacidadTotal = esCorriente ? ori.getSalAct().add(ori.getSobregiro()) : ori.getSalAct();

            if (capacidadTotal.compareTo(montoSalida) < 0) {
                throw new Exception("Fondos insuficientes en cuenta origen.");
            }

            // -------------------------------------------------------
            // 4. EJECUTAR OPERACIONES
            // -------------------------------------------------------
            // A. Descontar de Origen
            BigDecimal nuevoSaldoOri = ori.getSalAct().subtract(montoSalida);
            if (!DaoCuenta.actualizarSaldo(ctaOrigen, nuevoSaldoOri, codUsuario, cn)) {
                throw new Exception("Error al actualizar saldo origen.");
            }

            // B. Abonar a Destino
            BigDecimal nuevoSaldoDes = des.getSalAct().add(montoEntrada);
            if (!DaoCuenta.actualizarSaldo(ctaDestino, nuevoSaldoDes, codUsuario, cn)) {
                throw new Exception("Error al actualizar saldo destino.");
            }

            // C. Registrar Transacción (Padre)
            String idTransaccion = utilitarios.Utiles.generarIdTransaccion();
            entidad.Transaccion tran = new entidad.Transaccion();
            tran.setCodTransaccion(idTransaccion);
            tran.setNumCuentaOrigen(ctaOrigen);
            tran.setNumCuentaDestino(ctaDestino);
            tran.setCodTipMovimiento("TM003"); // TM003 = TRANSFERENCIA SALIDA (Principal)
            tran.setMonto(montoSalida);
            tran.setCanal("VENTANILLA");
            tran.setCodEstado("S0008"); // Procesado

            if (!conexion.DaoTransaccion.insertarTransaccion(tran, cn)) {
                throw new Exception("Error al registrar transacción.");
            }

            // D. Registrar Movimiento 1 (SALIDA - DEBITO)
            entidad.Movimiento movSal = new entidad.Movimiento();
            movSal.setCodMovimiento(conexion.DaoMovimiento.generarCodigoMovimiento());
            movSal.setCodTransaccion(idTransaccion);
            movSal.setNumCuenta(ctaOrigen);
            movSal.setCodTipMovimiento("TM003"); // TM003 = SALIDA
            movSal.setMonto(montoSalida);
            movSal.setSalFin(nuevoSaldoOri);
            movSal.setDes("TRANSF. A " + ctaDestino + infoCambio + " - " + obs);
            movSal.setNumCueDes(ctaDestino);
            movSal.setCodEstado("S0008");
            if (!conexion.DaoMovimiento.insertarMovimiento(movSal, cn)) {
                throw new Exception("Error mov salida.");
            }

            // E. Registrar Movimiento 2 (ENTRADA - ABONO)
            entidad.Movimiento movEnt = new entidad.Movimiento();
            movEnt.setCodMovimiento(conexion.DaoMovimiento.generarCodigoMovimiento());
            movEnt.setCodTransaccion(idTransaccion);
            movEnt.setNumCuenta(ctaDestino);
            movEnt.setCodTipMovimiento("TM004"); // TM004 = ENTRADA (Asegúrate que exista en BD)
            movEnt.setMonto(montoEntrada);
            movEnt.setSalFin(nuevoSaldoDes);
            movEnt.setDes("TRANSF. DE " + ctaOrigen + " - " + obs);
            movEnt.setNumCueDes(ctaOrigen);
            movEnt.setCodEstado("S0008");
            if (!conexion.DaoMovimiento.insertarMovimiento(movEnt, cn)) {
                throw new Exception("Error mov entrada.");
            }

            cn.commit();
            msg = "Transferencia exitosa. Código: " + idTransaccion;

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
