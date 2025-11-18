package entidad;

public class TipoMovimiento {

    private String codTipMovimiento;
    private String des;
    private String signo;
    private String codEstado;

    public TipoMovimiento() {
    }

    public TipoMovimiento(String codTipMovimiento, String des, String signo, String codEstado) {
        this.codTipMovimiento = codTipMovimiento;
        this.des = des;
        this.signo = signo;
        this.codEstado = codEstado;
    }

    // Getters y Setters...
    public String getCodTipMovimiento() {
        return codTipMovimiento;
    }

    public void setCodTipMovimiento(String codTipMovimiento) {
        this.codTipMovimiento = codTipMovimiento;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }

    public String getSigno() {
        return signo;
    }

    public void setSigno(String signo) {
        this.signo = signo;
    }

    public String getCodEstado() {
        return codEstado;
    }

    public void setCodEstado(String codEstado) {
        this.codEstado = codEstado;
    }
}
