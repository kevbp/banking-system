
package conexion;

import entidad.Usuario;

public class DaoLogin {
    public static Object[] login(Usuario usu){
        String sql = "SELECT * FROM t_usuario WHERE usn='"+usu.getUsername()+"' AND psw='"+usu.getPass()+"'";
        System.out.println(sql);
        return Acceso.buscar(sql);
    }
}