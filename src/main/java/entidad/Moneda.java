package entidad;

public class Moneda {

    private String codMoneda;
    private String descMoneda;
    private String simbolo;
    private String codEstado; // S0001 (Activo), S0002 (Inactivo)

    public Moneda() {
    }

    public Moneda(String codMoneda, String descMoneda, String simbolo, String codEstado) {
        this.codMoneda = codMoneda;
        this.descMoneda = descMoneda;
        this.simbolo = simbolo;
        this.codEstado = codEstado;
    }

    // Getters y Setters
    public String getCodMoneda() {
        return codMoneda;
    }

    public void setCodMoneda(String codMoneda) {
        this.codMoneda = codMoneda;
    }

    public String getDescMoneda() {
        return descMoneda;
    }

    public void setDescMoneda(String descMoneda) {
        this.descMoneda = descMoneda;
    }

    public String getSimbolo() {
        return simbolo;
    }

    public void setSimbolo(String simbolo) {
        this.simbolo = simbolo;
    }

    public String getCodEstado() {
        return codEstado;
    }

    public void setCodEstado(String codEstado) {
        this.codEstado = codEstado;
    }
}
