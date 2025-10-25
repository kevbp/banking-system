
package conexion;

import entidad.Cliente;
import java.util.List;

public class DaoCliente {
    
   public static String crear(Cliente cli){
        String newline = System.lineSeparator();
        String sql = "INSERT t_cliente (codCliente, nom, ape, tipoDoc, numDoc, fecNac, dir, codUbigeo, tel, cel, email, fecReg, codEstado, codUsuCre, fecUsuCre) VALUES('"+cli.getCodigo()+"','"+cli.getNombre()+"','"+cli.getApellido()+"','"+cli.getTipoDoc()+"','"+cli.getNumDocumento()+"','"+cli.getFechaNac()+"','"+cli.getDireccion()+"','"+cli.getCodUbigeo()+"','"+cli.getTelefono()+"','"+cli.getCelular()+"','"+cli.getEmail()+"','"+cli.getFechaReg()+"','"+cli.getEstado()+"','"+cli.getCodUsuarioCre()+"','"+cli.getFechaUsuarioCre()+"');";
        System.out.println(sql);
        return Acceso.ejecutar(sql);
    }

    public static List listar(String condicion) {
        String sql = "SELECT codCliente, tipoDoc, numDoc, nom, ape, tel, email, c.codEstado, e.des FROM t_cliente as c " +
                    "inner join t_estado as e on c.codEstado = e.codEstado " +condicion+";";
        return Acceso.listar(sql);
    }

    public static Object[] ultCod() {
        String sql = "SELECT MAX(codCliente) FROM t_cliente;";
        return Acceso.buscar(sql);
    }
}
