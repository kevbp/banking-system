package entidad;

public class TipoCuenta {

    private String codTipCuenta;
    private String descTipo;
    private String codMoneda;
    private double tasaInt;
    private String codEstado;

    public TipoCuenta() {
    }

    public TipoCuenta(String codTipCuenta, String descTipo, String codMoneda, double tasaInt, String codEstado) {
        this.codTipCuenta = codTipCuenta;
        this.descTipo = descTipo;
        this.codMoneda = codMoneda;
        this.tasaInt = tasaInt;
        this.codEstado = codEstado;
    }

    // Getters y Setters (Omite el código estándar, genéralos en tu IDE)
    public String getCodTipCuenta() {
        return codTipCuenta;
    }

    public void setCodTipCuenta(String codTipCuenta) {
        this.codTipCuenta = codTipCuenta;
    }

    public String getDescTipo() {
        return descTipo;
    }

    public void setDescTipo(String descTipo) {
        this.descTipo = descTipo;
    }

    public String getCodMoneda() {
        return codMoneda;
    }

    public void setCodMoneda(String codMoneda) {
        this.codMoneda = codMoneda;
    }

    public double getTasaInt() {
        return tasaInt;
    }

    public void setTasaInt(double tasaInt) {
        this.tasaInt = tasaInt;
    }

    public String getCodEstado() {
        return codEstado;
    }

    public void setCodEstado(String codEstado) {
        this.codEstado = codEstado;
    }
}
