
package entidad;

public class UsuarioCliente {
    private int codUsuarioCliente; 
    private String codCliente;
    private String nomUsuario;
    private String claveWeb;
    private String palabraRecuperacion;
    private String estado;

    public UsuarioCliente() {}

    public UsuarioCliente(String codCliente, String nomUsuario, String claveWeb, String palabraRecuperacion) {
        this.codCliente = codCliente;
        this.nomUsuario = nomUsuario;
        this.claveWeb = claveWeb;
        this.palabraRecuperacion = palabraRecuperacion;
        this.estado = "ACTIVO";
    }

    // Getters y Setters
    public int getCodUsuarioCliente() { return codUsuarioCliente; }
    public void setCodUsuarioCliente(int codUsuarioCliente) { this.codUsuarioCliente = codUsuarioCliente; }

    public String getCodCliente() { return codCliente; }
    public void setCodCliente(String codCliente) { this.codCliente = codCliente; }

    public String getNomUsuario() { return nomUsuario; }
    public void setNomUsuario(String nomUsuario) { this.nomUsuario = nomUsuario; }

    public String getClaveWeb() { return claveWeb; }
    public void setClaveWeb(String claveWeb) { this.claveWeb = claveWeb; }

    public String getPalabraRecuperacion() { return palabraRecuperacion; }
    public void setPalabraRecuperacion(String palabraRecuperacion) { this.palabraRecuperacion = palabraRecuperacion; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
}
