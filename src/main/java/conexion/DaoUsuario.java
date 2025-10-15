/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package conexion;

import entidad.Usuario;
import java.util.List;

/**
 *
 * @author broncake
 */
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
                + "VALUES ('U0003', "
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

    public static List ultCod() {
        String sql = "select max(codUsuario) codUsuario from t_usuario";
        return Acceso.listar(sql);
    }
}
