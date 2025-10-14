package conexion;

import entidad.Usuario;

public class DaoLogin {
    
    public static Object[] validarLogin(Usuario usu){
        String sql = "SELECT * FROM t_usuario WHERE usn='"+usu.getUsername()+"' AND psw='"+usu.getPass()+"'";
        System.out.println(sql);
        return Acceso.buscar(sql);
    }
    
    // Busca el usuario completo (por username)
    public static Object[] validarUsuario(String username){
        String sql = "SELECT * FROM t_usuario WHERE usn='" + username + "'";
        System.out.println(sql);
        return Acceso.buscar(sql);
    }

    // Actualiza los intentos fallidos del usuario
    public static String actualizarIntentos(String username, int nuevosIntentos){
        String sql = "UPDATE t_usuario SET intentos = " + nuevosIntentos + " WHERE usn = '" + username + "'";
        System.out.println(sql);
        return Acceso.ejecutar(sql);
    }

    // Bloquea al usuario (S0003 = Bloqueado)
    public static String bloquearUsuario(String username){
        String sql = "UPDATE t_usuario SET codEstado = 'S0003', fechaBloqueo = NOW() WHERE usn = '" + username + "'";
        System.out.println(sql);
        return Acceso.ejecutar(sql);
    }

    // Reinicia los intentos fallidos tras login exitoso
    public static String reiniciarIntentos(String username){
        String sql = "UPDATE t_usuario SET intentosFallidos = 0, ultimoLogin = NOW() WHERE usn = '" + username + "'";
        System.out.println(sql);
        return Acceso.ejecutar(sql);
    }
}
