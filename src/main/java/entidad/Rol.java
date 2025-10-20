/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entidad;

/**
 *
 * @author broncake
 */
public class Rol {
    private String codRol;
    private String des;

    public Rol() {
    }

    public Rol(String codRol) {
        this.codRol = codRol;
    }

    public Rol(String codRol, String des) {
        this.codRol = codRol;
        this.des = des;
    }

    public String getCodRol() {
        return codRol;
    }

    public void setCodRol(String codRol) {
        this.codRol = codRol;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }
    
    
}
