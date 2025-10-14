/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entidad;

/**
 *
 * @author broncake
 */
public class Ubigeo {
    private String codUbigeo;
    private String reg;
    private String pro;
    private String dis;
    private String codUsuMod;
    private String fecUsuMod;

    public Ubigeo() {
    }
    
    //Crear y modificar UBIGEO
    public Ubigeo(String codUbigeo, String reg, String pro, String dis, String codUsuMod, String fecUsuMod) {
        this.codUbigeo = codUbigeo;
        this.reg = reg;
        this.pro = pro;
        this.dis = dis;
        this.codUsuMod = codUsuMod;
        this.fecUsuMod = fecUsuMod;
    }
    
    //Obtener UBIGEO a partir de sus registros
    public Ubigeo(String reg, String pro, String dis) {
        this.reg = reg;
        this.pro = pro;
        this.dis = dis;
    }

    public String getCodUbigeo() {
        return codUbigeo;
    }

    public void setCodUbigeo(String codUbigeo) {
        this.codUbigeo = codUbigeo;
    }

    public String getReg() {
        return reg;
    }

    public void setReg(String reg) {
        this.reg = reg;
    }

    public String getPro() {
        return pro;
    }

    public void setPro(String pro) {
        this.pro = pro;
    }

    public String getDis() {
        return dis;
    }

    public void setDis(String dis) {
        this.dis = dis;
    }

    public String getCodUsuMod() {
        return codUsuMod;
    }

    public void setCodUsuMod(String codUsuMod) {
        this.codUsuMod = codUsuMod;
    }

    public String getFecUsuMod() {
        return fecUsuMod;
    }

    public void setFecUsuMod(String fecUsuMod) {
        this.fecUsuMod = fecUsuMod;
    }
    
    
    
}
