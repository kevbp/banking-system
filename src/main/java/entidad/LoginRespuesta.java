
package entidad;

public class LoginRespuesta {
    private Usuario usuario;
    private String mensaje;

    public LoginRespuesta(Usuario usuario, String mensaje) {
        this.usuario = usuario;
        this.mensaje = mensaje;
    }

    public Usuario getUsuario() { return usuario; }
    public String getMensaje() { return mensaje; }
}
