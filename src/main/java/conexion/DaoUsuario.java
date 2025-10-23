
package conexion;

import entidad.Usuario;
import java.util.List;

public class DaoUsuario {

    public static String crear(Usuario usu) {
        String sql = "INSERT INTO t_usuario (`codUsuario`, "
                + "`usn`, "
                + "`psw`, "
                + "`nom`, "
                + "`ape`, "
                + "`carg`, "
                + "`idRol`, "
                + "`codEstado`, "
                + "`intentos`, "
                + "`codUsuCre`, "
                + "`fecUsuCre`) "
                + "VALUES ('" + usu.getCodUsuario() + "', "
                + "'" + usu.getUsername() + "', "
                + "'" + usu.getPass() + "', "
                + "'" + usu.getNom() + "', "
                + "'" + usu.getApe() + "', "
                + "'" + usu.getCar() + "', "
                + "'" + usu.getRol() + "', "
                + "'" + usu.getEst() + "', "
                + "'" + usu.getIntentos() + "', "
                + "'" + usu.getCodUsuCre() + "', "
                + "'" + usu.getFecUsuCre() + "');";
        return Acceso.ejecutar(sql);
    }

    public static Object[] ultCod() {
        String sql = "select max(codUsuario) codUsuario from t_usuario";
        return Acceso.buscar(sql);
    }

    public static List listar() {
        String sql = "SELECT codUsuario, nom, ape, usn, e.codEstado, e.des, r.codRol, r.des, carg FROM t_usuario AS U " +
                    "INNER JOIN t_estado AS E on u.codEstado = e.codEstado " +
                    "INNER JOIN t_rol AS R on u.idRol = r.codRol order by codUsuario;";
        return Acceso.listar(sql);
    }
    
    public static String eliminar(Usuario usu) {
        String sql = "delete from t_usuario where codUsuario='"+usu.getCodUsuario()+"';";
        return Acceso.ejecutar(sql);
    }

    public static String actualizar(Usuario usu) {
        String sql = "UPDATE t_usuario SET " +
                    "psw = '"+usu.getPass()+"', " +
                    "nom = '"+usu.getNom()+"', " +
                    "ape = '"+usu.getApe()+"', " +
                    "carg = '"+usu.getCar()+"', " +
                    "idRol = '"+usu.getRoll().getCodRol()+"', " +
                    "codEstado = '"+usu.getEstado().getCodEstado()+"', " +
                    "intentos = '"+usu.getIntentos()+"', " +
                    "codUsuMod = '"+usu.getCodUsuCre()+"', " +
                    "fecUsuMod = '"+usu.getFecUsuCre()+"' " +
                    "WHERE codUsuario = '"+usu.getCodUsuario()+"';";
        return Acceso.ejecutar(sql);
    }   
}
