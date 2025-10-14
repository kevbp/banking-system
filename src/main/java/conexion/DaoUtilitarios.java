/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package conexion;

import entidad.Ubigeo;
import java.util.ArrayList;
import java.util.List;

public class DaoUtilitarios {

    public static List<String> listarRegion() {
        String sql = "SELECT DISTINCT nomDep FROM bancodb.t_ubigeo ORDER BY nomDep";
        return extraerLista(sql);
    }

    public static List<String> listarProvincias(String nomDep) {
        String sql = "SELECT DISTINCT nomPro FROM bancodb.t_ubigeo WHERE nomDep = '" + nomDep + "' ORDER BY nomPro";
        return extraerLista(sql);
    }

    public static List<String> listarDistritos(String nomPro) {
        String sql = "SELECT DISTINCT nomDis FROM bancodb.t_ubigeo WHERE nomPro = '" + nomPro + "' ORDER BY nomDis";
        return extraerLista(sql);
    }
    
    private static List<String> extraerLista(String sql) {
        List<String> lista = new ArrayList<>();
        for (Object filaObj : Acceso.listar(sql)) {
            Object[] fila = (Object[]) filaObj;
            lista.add(fila[0].toString());
        }
        return lista;
    }
    
    public static Object[] obtenerUbigeo(Ubigeo ubi){
        String sql = "SELECT codUbigeo FROM bancodb.t_ubigeo "
                + "WHERE "
                + "nomDep='"+ ubi.getReg() +"' and "
                + "nomPro='"+ ubi.getPro() +"' and "
                + "nomDis='"+ ubi.getDis() +"'";
        return Acceso.buscar(sql);
    }
}