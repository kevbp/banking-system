package entidad;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Movimiento {

    private String codMovimiento;
    private String codTransaccion;
    private String numCuenta; // Cuenta afectada por el movimiento
    private Timestamp fec;
    private String codTipMovimiento;
    private BigDecimal monto;
    private BigDecimal salFin; // Saldo final después del movimiento
    private String des;
    private String numCueDes; // Cuenta destino/origen de la contraparte
    private String codEstado;
    private String signo;

    public Movimiento() {
    }

    // --- Getters y Setters ---
    public String getSigno() {
        return signo;
    }

    public void setSigno(String signo) {
        this.signo = signo;
    }

    public String getCodMovimiento() {
        return codMovimiento;
    }

    public void setCodMovimiento(String codMovimiento) {
        this.codMovimiento = codMovimiento;
    }

    public String getCodTransaccion() {
        return codTransaccion;
    }

    public void setCodTransaccion(String codTransaccion) {
        this.codTransaccion = codTransaccion;
    }

    public String getNumCuenta() {
        return numCuenta;
    }

    public void setNumCuenta(String numCuenta) {
        this.numCuenta = numCuenta;
    }

    public Timestamp getFec() {
        return fec;
    }

    public void setFec(Timestamp fec) {
        this.fec = fec;
    }

    public String getCodTipMovimiento() {
        return codTipMovimiento;
    }

    public void setCodTipMovimiento(String codTipMovimiento) {
        this.codTipMovimiento = codTipMovimiento;
    }

    public BigDecimal getMonto() {
        return monto;
    }

    public void setMonto(BigDecimal monto) {
        this.monto = monto;
    }

    public BigDecimal getSalFin() {
        return salFin;
    }

    public void setSalFin(BigDecimal salFin) {
        this.salFin = salFin;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }

    public String getNumCueDes() {
        return numCueDes;
    }

    public void setNumCueDes(String numCueDes) {
        this.numCueDes = numCueDes;
    }

    public String getCodEstado() {
        return codEstado;
    }

    public void setCodEstado(String codEstado) {
        this.codEstado = codEstado;
    }
}
