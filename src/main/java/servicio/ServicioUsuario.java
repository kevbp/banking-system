/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servicio;

import conexion.Acceso;
import conexion.DaoUsuario;
import entidad.Usuario;
import java.util.List;
import utilitarios.Encriptacion;
import utilitarios.Utiles;

/**
 *
 * @author broncake
 */
public class ServicioUsuario {

    public static String crearUsuario(String username,
            String pass,
            String confPass,
            String nom,
            String ape,
            String car,
            String rol,
            String est,
            String codUsuCre,
            String fecUsuCre) {
        
        String msg = null;
        if (pass.equals(confPass)) {
            Object[] ultCod = DaoUsuario.ultCod();
            System.out.println(ultCod[0].toString());
            String codUsuario = Utiles.newCod(ultCod[0].toString());
            
            Usuario usu = new Usuario(codUsuario, username, Encriptacion.encriptar(pass), nom, ape, car, rol, est, "0", codUsuCre, fecUsuCre);
            msg = DaoUsuario.crear(usu);
            if (msg == null) {
                msg = "1";
            }
        } else {
            msg = "2";
        }

        return msg;
    }


}
