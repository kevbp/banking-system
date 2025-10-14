
package entidad;

public class Cliente{
    private String codigo;
    private String nombre;
    private String apellido;
    private String tipoDoc;
    private String numDocumento;
    private String fechaNac;
    private String direccion;
    private String codUbigeo;
    private String telefono;
    private String celular;
    private String email;
    private String fechaReg;
    private String estado;
    private String codUsuarioCre;
    private String fechaUsuarioCre;

    public Cliente() {
    }

    public Cliente(String codigo, String nombre, String apellido, String tipoDoc, String numDocumento, String fechaNac, String direccion, String codUbigeo, String telefono, String celular, String email, String fechaReg, String estado, String codUsuarioCre, String fechaUsuarioCre) {
        this.codigo = codigo;
        this.nombre = nombre;
        this.apellido = apellido;
        this.tipoDoc = tipoDoc;
        this.numDocumento = numDocumento;
        this.fechaNac = fechaNac;
        this.direccion = direccion;
        this.codUbigeo = codUbigeo;
        this.telefono = telefono;
        this.celular = celular;
        this.email = email;
        this.fechaReg = fechaReg;
        this.estado = estado;
        this.codUsuarioCre = codUsuarioCre;
        this.fechaUsuarioCre = fechaUsuarioCre;
    }

    public String getCodigo() {
        return codigo;
    }

    public String getNombre() {
        return nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public String getTipoDoc() {
        return tipoDoc;
    }

    public String getNumDocumento() {
        return numDocumento;
    }

    public String getFechaNac() {
        return fechaNac;
    }

    public String getDireccion() {
        return direccion;
    }

    public String getCodUbigeo() {
        return codUbigeo;
    }

    public String getTelefono() {
        return telefono;
    }

    public String getCelular() {
        return celular;
    }

    public String getEmail() {
        return email;
    }

    public String getFechaReg() {
        return fechaReg;
    }

    public String getEstado() {
        return estado;
    }

    public String getCodUsuarioCre() {
        return codUsuarioCre;
    }

    public String getFechaUsuarioCre() {
        return fechaUsuarioCre;
    }
    
    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public void setTipoDoc(String tipoDoc) {
        this.tipoDoc = tipoDoc;
    }

    public void setNumDocumento(String numDocumento) {
        this.numDocumento = numDocumento;
    }

    public void setFechaNac(String fechaNac) {
        this.fechaNac = fechaNac;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public void setCodUbigeo(String codUbigeo) {
        this.codUbigeo = codUbigeo;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public void setCelular(String celular) {
        this.celular = celular;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setFechaReg(String fechaReg) {
        this.fechaReg = fechaReg;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public void setCodUsuarioCre(String codUsuarioCre) {
        this.codUsuarioCre = codUsuarioCre;
    }

    public void setFechaUsuarioCre(String fechaUsuarioCre) {
        this.fechaUsuarioCre = fechaUsuarioCre;
    }
    
    public void setCodUsuMod(String codUsuarioCre) {
        this.codUsuarioCre = codUsuarioCre;
    }

    public void setFecUsuMod(String fechaUsuarioCre) {
        this.fechaUsuarioCre = fechaUsuarioCre;
    }

}
