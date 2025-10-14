package servicio;

import entidad.Cuenta;
import entidad.Movimiento;
import entidad.Transaccion;
import conexion.Acceso;
import conexion.DaoCuenta; // Se asume que estos DAOs existen e implementan los métodos necesarios.
import conexion.DaoMovimiento;
import conexion.DaoTransaccion;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;

public class ServicioOperaciones {

    // Códigos de las Tablas Maestras (Catálogos) - ¡CONFIRMAR ESTOS CÓDIGOS EN TU DB!
    private static final String ESTADO_ACTIVO = "S0001";
    
    // Tipos de Transacción (t_transaccion.codTipMovimiento)
    private static final String TIPO_TRANSACCION_TRANSFERENCIA = "T0001";
    private static final String TIPO_TRANSACCION_DEPOSITO = "T0002"; // Asumido
    private static final String TIPO_TRANSACCION_RETIRO = "T0003"; // Asumido

    // Tipos de Movimiento (t_movimiento.codTipMovimiento)
    private static final String MOV_DEPOSITO = "M0001"; // Asumido (Crédito)
    private static final String MOV_TRANSFERENCIA_DEBITO = "M0002"; 
    private static final String MOV_TRANSFERENCIA_CREDITO = "M0003";
    private static final String MOV_RETIRO = "M0004"; // Asumido (Débito)

    // =========================================================================
    // 1. MÉTODO PARA REALIZAR DEPÓSITO (IMPACTO SIMPLE: CRÉDITO)
    // =========================================================================

    public String realizarDeposito(String numCuenta, BigDecimal monto, String codUsuario, String canal) {
        if (monto.compareTo(BigDecimal.ZERO) <= 0) {
            return "El monto a depositar debe ser mayor a cero.";
        }
        
        Connection cn = null;
        String resultado = "Error desconocido al procesar el depósito.";
        Timestamp now = new Timestamp(new Date().getTime());

        try {
            cn = Acceso.getConexion();
            if (cn == null) return "Error de conexión con la base de datos.";
            cn.setAutoCommit(false); // Iniciar transacción

            Cuenta cuenta = DaoCuenta.obtenerCuenta(numCuenta, cn);
            if (cuenta == null || !cuenta.getCodEstado().equals(ESTADO_ACTIVO)) {
                return "Cuenta no encontrada o inactiva.";
            }

            // 1. Registrar Transacción General (t_transaccion)
            Transaccion transaccion = new Transaccion();
            String codT = DaoTransaccion.generarCodigoTransaccion(cn);

            transaccion.setCodTransaccion(codT);
            transaccion.setNumCuentaOrigen(null); // No aplica
            transaccion.setNumCuentaDestino(numCuenta); // Destino es la cuenta del depósito
            transaccion.setCodTipMovimiento(TIPO_TRANSACCION_DEPOSITO);
            transaccion.setFec(now);
            transaccion.setMonto(monto);
            transaccion.setCanal(canal);
            transaccion.setCodEstado(ESTADO_ACTIVO);

            if (!DaoTransaccion.insertarTransaccion(transaccion, cn)) {
                throw new SQLException("Fallo al insertar la transacción general.");
            }

            // 2. Registrar Movimiento de CRÉDITO (Depósito)
            Movimiento mov = new Movimiento();
            mov.setCodMovimiento(DaoMovimiento.generarCodigoMovimiento(cn));
            mov.setCodTransaccion(codT);
            mov.setNumCuenta(numCuenta);
            mov.setFec(now);
            mov.setCodTipMovimiento(MOV_DEPOSITO);
            mov.setMonto(monto); // Monto en positivo
            mov.setDes("Depósito en efectivo/cheque. Canal: " + canal + ". Usuario: " + codUsuario); 
            mov.setNumCueDes(null); // No aplica contraparte
            mov.setCodEstado(ESTADO_ACTIVO);
            
            if (!DaoMovimiento.insertarMovimiento(mov, cn)) {
                throw new SQLException("Fallo al insertar el movimiento de depósito.");
            }
            
            // 3. Actualizar Saldo de Cuenta (SUMAR)
            if (!DaoCuenta.actualizarSaldo(numCuenta, monto, cn)) {
                throw new SQLException("Fallo al actualizar el saldo de la cuenta.");
            }

            cn.commit(); 
            resultado = "OK"; 

        } catch (SQLException e) {
            resultado = "Error de DB o fallo en el depósito: " + e.getMessage();
            if (cn != null) { try { cn.rollback(); } catch (SQLException rollbackEx) {} }
        } finally {
            if (cn != null) { try { cn.setAutoCommit(true); cn.close(); } catch (SQLException closeEx) {} }
        }
        return resultado;
    }

    // =========================================================================
    // 2. MÉTODO PARA REALIZAR RETIRO (IMPACTO SIMPLE: DÉBITO)
    // =========================================================================

    public String realizarRetiro(String numCuenta, BigDecimal monto, String codUsuario, String canal) {
        if (monto.compareTo(BigDecimal.ZERO) <= 0) {
            return "El monto a retirar debe ser mayor a cero.";
        }
        
        Connection cn = null;
        String resultado = "Error desconocido al procesar el retiro.";
        Timestamp now = new Timestamp(new Date().getTime());

        try {
            cn = Acceso.getConexion();
            if (cn == null) return "Error de conexión con la base de datos.";
            cn.setAutoCommit(false); // Iniciar transacción

            Cuenta cuenta = DaoCuenta.obtenerCuenta(numCuenta, cn);

            if (cuenta == null || !cuenta.getCodEstado().equals(ESTADO_ACTIVO)) {
                return "Cuenta no encontrada o inactiva.";
            }
            
            // Validación de Saldo (Usando getSalAct() según tu entidad Cuenta)
            if (cuenta.getSalAct().compareTo(monto) < 0) {
                return "Saldo insuficiente en la cuenta.";
            }

            // 1. Registrar Transacción General (t_transaccion)
            Transaccion transaccion = new Transaccion();
            String codT = DaoTransaccion.generarCodigoTransaccion(cn);

            transaccion.setCodTransaccion(codT);
            transaccion.setNumCuentaOrigen(numCuenta); // Origen es la cuenta del retiro
            transaccion.setNumCuentaDestino(null); // No aplica
            transaccion.setCodTipMovimiento(TIPO_TRANSACCION_RETIRO);
            transaccion.setFec(now);
            transaccion.setMonto(monto);
            transaccion.setCanal(canal);
            transaccion.setCodEstado(ESTADO_ACTIVO);

            if (!DaoTransaccion.insertarTransaccion(transaccion, cn)) {
                throw new SQLException("Fallo al insertar la transacción general.");
            }

            // 2. Registrar Movimiento de DÉBITO (Retiro)
            Movimiento mov = new Movimiento();
            mov.setCodMovimiento(DaoMovimiento.generarCodigoMovimiento(cn));
            mov.setCodTransaccion(codT);
            mov.setNumCuenta(numCuenta);
            mov.setFec(now);
            mov.setCodTipMovimiento(MOV_RETIRO);
            mov.setMonto(monto.negate()); // Monto negativo
            mov.setDes("Retiro en efectivo/cheque. Canal: " + canal + ". Usuario: " + codUsuario); 
            mov.setNumCueDes(null); // No aplica contraparte
            mov.setCodEstado(ESTADO_ACTIVO);
            
            if (!DaoMovimiento.insertarMovimiento(mov, cn)) {
                throw new SQLException("Fallo al insertar el movimiento de retiro.");
            }
            
            // 3. Actualizar Saldo de Cuenta (RESTAR)
            if (!DaoCuenta.actualizarSaldo(numCuenta, monto.negate(), cn)) {
                throw new SQLException("Fallo al actualizar el saldo de la cuenta.");
            }

            cn.commit(); 
            resultado = "OK"; 

        } catch (SQLException e) {
            resultado = "Error de DB o fallo en el retiro: " + e.getMessage();
            if (cn != null) { try { cn.rollback(); } catch (SQLException rollbackEx) {} }
        } finally {
            if (cn != null) { try { cn.setAutoCommit(true); cn.close(); } catch (SQLException closeEx) {} }
        }
        return resultado;
    }


    // =========================================================================
    // 3. MÉTODO PARA REALIZAR TRANSFERENCIA (IMPACTO DOBLE: DÉBITO Y CRÉDITO)
    // =========================================================================
    
    /**
     * Ejecuta una transferencia de fondos entre dos cuentas de forma atómica.
     * Requiere setAutoCommit(false), commit() y rollback().
     */
    public String realizarTransferencia(String numCuentaOrigen, String numCuentaDestino, BigDecimal monto, String codUsuario, String canal) {
        
        // 1. Validaciones iniciales
        if (numCuentaOrigen.equals(numCuentaDestino)) {
            return "Las cuentas de origen y destino deben ser diferentes.";
        }
        if (monto.compareTo(BigDecimal.ZERO) <= 0) {
            return "El monto a transferir debe ser mayor a cero.";
        }
        
        Connection cn = null;
        String resultado = "Error desconocido al procesar la transacción.";
        Timestamp now = new Timestamp(new Date().getTime());

        try {
            // **INICIO DE LA TRANSACCIÓN**
            cn = Acceso.getConexion();
            if (cn == null) return "Error de conexión con la base de datos.";
            cn.setAutoCommit(false); 

            // 2. Obtener y Validar Cuentas
            Cuenta cuentaOrigen = DaoCuenta.obtenerCuenta(numCuentaOrigen, cn);
            Cuenta cuentaDestino = DaoCuenta.obtenerCuenta(numCuentaDestino, cn);

            if (cuentaOrigen == null || !cuentaOrigen.getCodEstado().equals(ESTADO_ACTIVO)) {
                return "Cuenta de origen no encontrada o inactiva.";
            }
            if (cuentaDestino == null || !cuentaDestino.getCodEstado().equals(ESTADO_ACTIVO)) {
                return "Cuenta de destino no encontrada o inactiva.";
            }
            
            // Validación de Saldo
            if (cuentaOrigen.getSalAct().compareTo(monto) < 0) {
                return "Saldo insuficiente en la cuenta de origen.";
            }
            
            // 3. Registrar la Transacción General (t_transaccion)
            Transaccion transaccion = new Transaccion();
            String codT = DaoTransaccion.generarCodigoTransaccion(cn);

            transaccion.setCodTransaccion(codT);
            transaccion.setNumCuentaOrigen(numCuentaOrigen); 
            transaccion.setNumCuentaDestino(numCuentaDestino); 
            transaccion.setCodTipMovimiento(TIPO_TRANSACCION_TRANSFERENCIA);
            transaccion.setFec(now); 
            transaccion.setMonto(monto); 
            transaccion.setCanal(canal); 
            transaccion.setCodEstado(ESTADO_ACTIVO);
            // No se usa setCodUsuario aquí porque no está en tu entidad Transaccion.

            if (!DaoTransaccion.insertarTransaccion(transaccion, cn)) {
                throw new SQLException("Fallo al insertar la transacción general.");
            }

            // 4. Registrar Movimiento de DÉBITO (Salida de Origen)
            Movimiento movDebito = new Movimiento();
            movDebito.setCodMovimiento(DaoMovimiento.generarCodigoMovimiento(cn));
            movDebito.setCodTransaccion(transaccion.getCodTransaccion());
            movDebito.setNumCuenta(numCuentaOrigen);
            movDebito.setFec(now);
            movDebito.setCodTipMovimiento(MOV_TRANSFERENCIA_DEBITO);
            movDebito.setMonto(monto.negate()); 
            movDebito.setDes("Transferencia enviada a: " + numCuentaDestino + " / Medio: " + canal); 
            movDebito.setNumCueDes(numCuentaDestino); 
            movDebito.setCodEstado(ESTADO_ACTIVO);
            
            if (!DaoMovimiento.insertarMovimiento(movDebito, cn)) {
                throw new SQLException("Fallo al insertar el movimiento de débito.");
            }

            // 5. Actualizar Saldo de Cuenta Origen (Restar)
            if (!DaoCuenta.actualizarSaldo(numCuentaOrigen, monto.negate(), cn)) {
                throw new SQLException("Fallo al actualizar el saldo de la cuenta origen.");
            }

            // 6. Registrar Movimiento de CRÉDITO (Entrada a Destino)
            Movimiento movCredito = new Movimiento();
            movCredito.setCodMovimiento(DaoMovimiento.generarCodigoMovimiento(cn));
            movCredito.setCodTransaccion(transaccion.getCodTransaccion());
            movCredito.setNumCuenta(numCuentaDestino);
            movCredito.setFec(now);
            movCredito.setCodTipMovimiento(MOV_TRANSFERENCIA_CREDITO);
            movCredito.setMonto(monto); 
            movCredito.setDes("Transferencia recibida desde: " + numCuentaOrigen + " / Medio: " + canal); 
            movCredito.setNumCueDes(numCuentaOrigen); 
            movCredito.setCodEstado(ESTADO_ACTIVO);
            
            if (!DaoMovimiento.insertarMovimiento(movCredito, cn)) {
                throw new SQLException("Fallo al insertar el movimiento de crédito.");
            }
            
            // 7. Actualizar Saldo de Cuenta Destino (Sumar)
            if (!DaoCuenta.actualizarSaldo(numCuentaDestino, monto, cn)) {
                throw new SQLException("Fallo al actualizar el saldo de la cuenta destino.");
            }

            // **FIN DE LA TRANSACCIÓN EXITOSA**
            cn.commit(); 
            resultado = "OK"; 

        } catch (SQLException e) {
            // **MANEJO DE ERROR Y ROLLBACK**
            resultado = "Error de base de datos o fallo en una operación: " + e.getMessage();
            if (cn != null) {
                try {
                    cn.rollback(); 
                    System.err.println("Transacción revertida (ROLLBACK). Error: " + e.getMessage());
                } catch (SQLException rollbackEx) {
                    System.err.println("Error al intentar hacer ROLLBACK: " + rollbackEx.getMessage());
                }
            }
        } finally {
            // **CIERRE DE RECURSOS**
            if (cn != null) {
                try {
                    cn.setAutoCommit(true); 
                    cn.close();
                } catch (SQLException closeEx) {
                    System.err.println("Error al cerrar la conexión: " + closeEx.getMessage());
                }
            }
        }
        return resultado;
    }
}