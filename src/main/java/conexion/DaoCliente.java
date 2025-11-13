
package conexion;

import entidad.Cliente;
import java.util.List;

public class DaoCliente {
    
   public static String crear(Cliente cli){
        String sql = "INSERT t_cliente (codCliente, nomCompleto, tipoDoc, numDoc, fecNac, dir, codUbigeo, tel, cel, email, fecReg, codEstado, codUsuCre, fecUsuCre) "+
                        "VALUES('"+cli.getCodigo()+"','"+cli.getNombre()+"','"+cli.getTipoDoc()+"','"+cli.getNumDocumento()+"','"+cli.getFechaNac()+"','"+
                        cli.getDireccion()+"','"+cli.getCodUbigeo()+"','"+cli.getTelefono()+"','"+cli.getCelular()+"','"+cli.getEmail()+"','"+cli.getFechaReg()+"','"+
                        cli.getEstado()+"','"+cli.getCodUsuarioCre()+"','"+cli.getFechaUsuarioCre()+"');";
        return Acceso.ejecutar(sql);
    }

    public static List listar(String condicion) {
        String sql = "SELECT codCliente, tipoDoc, numDoc, nomCompleto, cel, email, c.codEstado, e.des, fecNac, dir, codUbigeo, tel FROM t_cliente as c " +
                    "inner join t_estado as e on c.codEstado = e.codEstado " +condicion+";";
        return Acceso.listar(sql);
    }

    public static Object[] ultCod() {
        String sql = "SELECT MAX(codCliente) FROM t_cliente;";
        return Acceso.buscar(sql);
    }
    
   public static String actualizar(Cliente cli){
        String sql = "UPDATE bancodb.t_cliente SET " +
                    "fecNac = '"+cli.getFechaNac()+"', " +
                    "dir = '"+cli.getDireccion()+"', " +
                    "codUbigeo = '"+cli.getCodUbigeo()+"', " +
                    "tel = '"+cli.getTelefono()+"', " +
                    "cel = '"+cli.getCelular()+"', " +
                    "email = '"+cli.getEmail()+"', " +
                    "codEstado = '"+cli.getEstado()+"', " +
                    "codUsuMod = '"+cli.getCodUsuarioCre()+"', " +
                    "fecUsuMod = '"+cli.getFechaUsuarioCre()+"' " +
                    "WHERE codCliente = '"+cli.getCodigo()+"';";
        System.out.println(sql);
        return Acceso.ejecutar(sql);
    }   

    public static Object[] buscar(String codigo) {
        String sql = "SELECT codCliente, tipoDoc, numDoc, nomCompleto, cel, email, c.codEstado, e.des, fecNac, dir, c.codUbigeo, tel, u.nomDep, u.nomPro, u.nomDis FROM t_cliente AS c " +
                    "INNER JOIN t_estado AS e on c.codEstado = e.codEstado " +
                    "INNER JOIN t_ubigeo AS U on c.codUbigeo = u.codUbigeo where codCliente = '"+codigo+"';";
        return Acceso.buscar(sql);
    }    
    
    public static String inactivar(String codigo){
        String sql = "UPDATE t_cliente SET codEstado = 'S0002' WHERE codCliente = '"+codigo+"';";
        return Acceso.ejecutar(sql);
    }
}
