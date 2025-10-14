
package servicio;

import utilitarios.Encriptacion;
import conexion.DaoLogin;
import entidad.Usuario;

public class ServicioLogin {
    public static Usuario loginUsuario(String username, String pass){
        Usuario log = new Usuario(username, pass);
        Object[]ua = DaoLogin.login(log);
        Usuario usuAut;
        if (ua!=null) {
            for (int i = 0; i < ua.length; i++) {
                System.out.println("i = "+ i + "info:" + ua[i]);
            }
            //Genera el usuario con el usn, el perfil y el estado para usar en la sesión
            usuAut = new Usuario(ua[1].toString(), ua[6].toString(), ua[7].toString());
        } else {
            usuAut = null;
        }
        return usuAut;
    }
}
