package entidad;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Embargo {

    private String codEmbargo;
    private String numCuenta;
    private BigDecimal monto;
    private String expediente;
    private String descripcion;
    private BigDecimal montoLiberado;
    private String codEstado;
    private String codUsuCre;
    private Timestamp fecUsuCre;

    public Embargo() {
    }

    // Getters y Setters
    public String getCodEmbargo() {
        return codEmbargo;
    }

    public void setCodEmbargo(String codEmbargo) {
        this.codEmbargo = codEmbargo;
    }

    public String getNumCuenta() {
        return numCuenta;
    }

    public void setNumCuenta(String numCuenta) {
        this.numCuenta = numCuenta;
    }

    public BigDecimal getMonto() {
        return monto;
    }

    public void setMonto(BigDecimal monto) {
        this.monto = monto;
    }

    public String getExpediente() {
        return expediente;
    }

    public void setExpediente(String expediente) {
        this.expediente = expediente;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public BigDecimal getMontoLiberado() {
        return montoLiberado;
    }

    public void setMontoLiberado(BigDecimal montoLiberado) {
        this.montoLiberado = montoLiberado;
    }

    public String getCodEstado() {
        return codEstado;
    }

    public void setCodEstado(String codEstado) {
        this.codEstado = codEstado;
    }

    public String getCodUsuCre() {
        return codUsuCre;
    }

    public void setCodUsuCre(String codUsuCre) {
        this.codUsuCre = codUsuCre;
    }

    public Timestamp getFecUsuCre() {
        return fecUsuCre;
    }

    public void setFecUsuCre(Timestamp fecUsuCre) {
        this.fecUsuCre = fecUsuCre;
    }
}
