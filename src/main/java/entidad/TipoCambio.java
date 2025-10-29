
package entidad;

public class TipoCambio {
    private Integer idTipoCambio;
    private String fecha;
    private String horaRegistro;
    private String monedaOrigen;
    private String monedaDestino;
    private Double tasaCompra;
    private Double tasaVenta;
    private String codUsuCre;
    private String fecUsuCre;

    public TipoCambio() {
    }

    public TipoCambio(String fecha, String horaRegistro, String monedaOrigen, String monedaDestino, Double tasaCompra, Double tasaVenta, String codUsuCre, String fecUsuCre) {
        this.fecha = fecha;
        this.horaRegistro = horaRegistro;
        this.monedaOrigen = monedaOrigen;
        this.monedaDestino = monedaDestino;
        this.tasaCompra = tasaCompra;
        this.tasaVenta = tasaVenta;
        this.codUsuCre = codUsuCre;
        this.fecUsuCre = fecUsuCre;
    }

    public String getFecUsuCre() {
        return fecUsuCre;
    }

    public void setFecUsuCre(String fecUsuCre) {
        this.fecUsuCre = fecUsuCre;
    }

    public Integer getIdTipoCambio() {
        return idTipoCambio;
    }

    public void setIdTipoCambio(Integer idTipoCambio) {
        this.idTipoCambio = idTipoCambio;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getHoraRegistro() {
        return horaRegistro;
    }

    public void setHoraRegistro(String horaRegistro) {
        this.horaRegistro = horaRegistro;
    }

    public String getMonedaOrigen() {
        return monedaOrigen;
    }

    public void setMonedaOrigen(String monedaOrigen) {
        this.monedaOrigen = monedaOrigen;
    }

    public String getMonedaDestino() {
        return monedaDestino;
    }

    public void setMonedaDestino(String monedaDestino) {
        this.monedaDestino = monedaDestino;
    }

    public Double getTasaCompra() {
        return tasaCompra;
    }

    public void setTasaCompra(Double tasaCompra) {
        this.tasaCompra = tasaCompra;
    }

    public Double getTasaVenta() {
        return tasaVenta;
    }

    public void setTasaVenta(Double tasaVenta) {
        this.tasaVenta = tasaVenta;
    }

    public String getCodUsuCre() {
        return codUsuCre;
    }

    public void setCodUsuCre(String codUsuCre) {
        this.codUsuCre = codUsuCre;
    }
    
}
