
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
    
}
