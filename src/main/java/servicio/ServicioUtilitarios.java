/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servicio;

import conexion.DaoUtilitarios;
import entidad.Ubigeo;
import java.util.List;

/**
 *
 * @author broncake
 */
public class ServicioUtilitarios {

    public static List<String> listarRegion() {
        return DaoUtilitarios.listarRegion();
    }

    public static List<String> listarProvincias(String nomDep) {
        return DaoUtilitarios.listarProvincias(nomDep);
    }

    public static List<String> listarDistritos(String nomPro) {
        return DaoUtilitarios.listarDistritos(nomPro);
    }
    
    public static String obtenerUbigeo(String reg, String pro, String dis){
        Ubigeo ubi = new Ubigeo(reg, pro, dis);
        
        Object[] u = DaoUtilitarios.obtenerUbigeo(ubi);
        String codUbigeo = u[0].toString();
        
        return codUbigeo;
    }
}
