
package entidad;

public class Usuario {
    private String codUsuario;
    private String username;
    private String pass;
    private String nom;
    private String ape;
    private String car;
    private String rol;
    private String est;
    private String codUsuCre;
    private String fecUsuCre;
    private String codUsuMod;
    private String fecUsuMod;

    public Usuario() {
    }

    public Usuario(String username, String pass) {
        this.username = username;
        this.pass = pass;
    }

    public Usuario(String username, String rol, String est) {
        this.username = username;
        this.rol = rol;
        this.est = est;
    }

    public String getCodUsuario() {
        return codUsuario;
    }

    public void setCodUsuario(String codUsuario) {
        this.codUsuario = codUsuario;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getApe() {
        return ape;
    }

    public void setApe(String ape) {
        this.ape = ape;
    }

    public String getCar() {
        return car;
    }

    public void setCar(String car) {
        this.car = car;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public String getEst() {
        return est;
    }

    public void setEst(String est) {
        this.est = est;
    }

    public String getCodUsuCre() {
        return codUsuCre;
    }

    public void setCodUsuCre(String codUsuCre) {
        this.codUsuCre = codUsuCre;
    }

    public String getFecUsuCre() {
        return fecUsuCre;
    }

    public void setFecUsuCre(String fecUsuCre) {
        this.fecUsuCre = fecUsuCre;
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
