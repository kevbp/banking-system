
package servicio;

import utilitarios.Encriptacion;
import conexion.DaoLogin;
import entidad.Usuario;
import entidad.LoginRespuesta;

public class ServicioLogin {

    public static LoginRespuesta loginUsuario(String username, String pass) {
        // 1️⃣ Verificar si el usuario existe
        Object[] u = DaoLogin.validarUsuario(username);
        if (u == null) {
            return new LoginRespuesta(null, "Usuario no encontrado.");
        }

        // 2️⃣ Cargar los datos del usuario existente
        Usuario usuExis = new Usuario();
        usuExis.setCodUsuario(u[0].toString());
        usuExis.setUsername(u[1].toString());
        usuExis.setPass(u[2].toString());
        usuExis.setRol(u[6].toString());
        usuExis.setEst(u[7].toString());
        usuExis.setIntentos(u[8].toString());

        // 3️⃣ Validar si está bloqueado
        if (usuExis.getEst().equalsIgnoreCase("S0003")) {
            return new LoginRespuesta(null, "Tu cuenta está bloqueada. Contacta al administrador.");
        }

        // 4️⃣ Encriptar la contraseña ingresada
//        String passEnc = Encriptacion.encriptar(pass);

        // 5️⃣ Validar login (usuario + contraseña encriptada)
        Usuario log = new Usuario(username, pass);
        Object[] ua = DaoLogin.validarLogin(log);

        if (ua != null) {
            // ✅ Login exitoso → reiniciar intentos
            DaoLogin.reiniciarIntentos(username);
            Usuario usuAut = new Usuario(ua[1].toString(), ua[6].toString(), ua[7].toString(), ua[8].toString());
            usuAut.setPass(null);
            return new LoginRespuesta(usuAut, "Inicio de sesión exitoso.");
        } else {
            // ❌ Contraseña incorrecta → incrementar intentos
            int intentosActuales = Integer.parseInt(usuExis.getIntentos());
            int nuevosIntentos = intentosActuales + 1;

            if (nuevosIntentos >= 4) {
                DaoLogin.bloquearUsuario(username);
                return new LoginRespuesta(null, "Cuenta bloqueada por múltiples intentos fallidos.");
            } else {
                DaoLogin.actualizarIntentos(username, nuevosIntentos);
                return new LoginRespuesta(null, "Contraseña incorrecta. \n Intento " + nuevosIntentos + " de 3.");
            }
        }
    }
}
