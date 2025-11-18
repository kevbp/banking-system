package entidad;

public class TipoCambio {

    private int idTipoCambio;
    private String monedaOrigen;
    private String monedaDestino;
    private double tasaCompra;
    private double tasaVenta;
    private String fecha; // Para mostrar "13/11/2025"
    private String hora;  // Para mostrar "09:15"

    public TipoCambio() {
    }

    public TipoCambio(int id, String origen, String destino, double compra, double venta, String fecha, String hora) {
        this.idTipoCambio = id;
        this.monedaOrigen = origen;
        this.monedaDestino = destino;
        this.tasaCompra = compra;
        this.tasaVenta = venta;
        this.fecha = fecha;
        this.hora = hora;
    }

    // Getters y Setters
    public int getIdTipoCambio() {
        return idTipoCambio;
    }

    public void setIdTipoCambio(int idTipoCambio) {
        this.idTipoCambio = idTipoCambio;
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

    public double getTasaCompra() {
        return tasaCompra;
    }

    public void setTasaCompra(double tasaCompra) {
        this.tasaCompra = tasaCompra;
    }

    public double getTasaVenta() {
        return tasaVenta;
    }

    public void setTasaVenta(double tasaVenta) {
        this.tasaVenta = tasaVenta;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }
}
