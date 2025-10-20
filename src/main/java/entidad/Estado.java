/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entidad;

/**
 *
 * @author broncake
 */
public class Estado {
    private String codEstado;
    private String des;
    private String tipoEntidad;

    public Estado() {
    }

    public Estado(String codEstado) {
        this.codEstado = codEstado;
    }

    public Estado(String codEstado, String des) {
        this.codEstado = codEstado;
        this.des = des;
    }
    
    public Estado(String codEstado, String des, String tipoEntidad) {
        this.codEstado = codEstado;
        this.des = des;
        this.tipoEntidad = tipoEntidad;
    }

    public String getCodEstado() {
        return codEstado;
    }

    public void setCodEstado(String codEstado) {
        this.codEstado = codEstado;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }

    public String getTipoEntidad() {
        return tipoEntidad;
    }

    public void setTipoEntidad(String tipoEntidad) {
        this.tipoEntidad = tipoEntidad;
    }
    
    
}
