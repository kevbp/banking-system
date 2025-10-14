
package conexion;

import entidad.Cliente;

public class DaoCliente {
    
   public static String crear(Cliente cli){
        String newline = System.lineSeparator();
        String sql = "INSERT t_cliente (codCliente, nom, ape, tipoDoc, numDoc, fecNac, dir, codUbigeo, tel, cel, email, fecReg, codEstado, codUsuCre, fecUsuCre) VALUES('"+cli.getCodigo()+"','"+cli.getNombre()+"','"+cli.getApellido()+"','"+cli.getTipoDoc()+"','"+cli.getNumDocumento()+"','"+cli.getFechaNac()+"','"+cli.getDireccion()+"','"+cli.getCodUbigeo()+"','"+cli.getTelefono()+"','"+cli.getCelular()+"','"+cli.getEmail()+"','"+cli.getFechaReg()+"','"+cli.getEstado()+"','"+cli.getCodUsuarioCre()+"','"+cli.getFechaUsuarioCre()+"');";
        System.out.println(sql);
        return Acceso.ejecutar(sql);
        
    }
}
