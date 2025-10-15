/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package servicio;

import conexion.DaoUtilitarios;
import entidad.Estado;
import entidad.Rol;
import entidad.Ubigeo;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author broncake
 */
public class ServicioUtilitarios {

    //UBIGEO
    public static List<String> listarRegion() {
        return DaoUtilitarios.listarRegion();
    }

    public static List<String> listarProvincias(String nomDep) {
        return DaoUtilitarios.listarProvincias(nomDep);
    }

    public static List<String> listarDistritos(String nomPro) {
        return DaoUtilitarios.listarDistritos(nomPro);
    }

    public static String obtenerUbigeo(String reg, String pro, String dis) {
        Ubigeo ubi = new Ubigeo(reg, pro, dis);

        Object[] u = DaoUtilitarios.obtenerUbigeo(ubi);
        String codUbigeo = u[0].toString();

        return codUbigeo;
    }

    //ROLES
    public static List<Rol> listarRoles() {
        List lista = DaoUtilitarios.listarRoles();
        List roles = new ArrayList();
        
        for (int i = 0; i < lista.size(); i++) {
            Object[] r = (Object[])lista.get(i);
            Rol rol = new Rol(r[0].toString(),r[1].toString());
            roles.add(rol);
        }
        return roles;
    }
    
    //ROLES
    public static List<Estado> listarEstadoUsuario() {
        List lista = DaoUtilitarios.listarEstadoUsuario();
        List estados = new ArrayList();
        
        for (int i = 0; i < lista.size(); i++) {
            Object[] s = (Object[])lista.get(i);
            Estado est = new Estado(s[0].toString(), s[1].toString());
            estados.add(est);
        }
        
        return estados;
    }
}
