/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servicio;

import entidad.Usuario;

/**
 *
 * @author broncake
 */
public class ServicioUsuario {
    
        public static String crearUsuario(String username, String pass, String nom, String ape, String car, String rol, String est, String codUsuCre, String fecUsuCre) {
        
            
        Usuario usu = new Usuario("",username, pass, nom, ape, car, rol, est, 0, codUsuCre, fecUsuCre); //Ultimos 3: intentos, codUsuCre, fecUsuCre
        String msg = DaoUsuario.crear(usu);
        if (msg == null) {
            msg = "1";
        }
        return msg;
    }
}
