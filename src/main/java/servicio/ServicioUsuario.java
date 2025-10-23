
package servicio;

import conexion.DaoUsuario;
import entidad.Estado;
import entidad.Rol;
import entidad.Usuario;
import java.util.ArrayList;
import java.util.List;
import utilitarios.Encriptacion;
import utilitarios.Utiles;

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
            
            Usuario usu = new Usuario(codUsuario, username, Encriptacion.encriptar(pass), nom, ape, car, rol, est, 0, codUsuCre, fecUsuCre);
            msg = DaoUsuario.crear(usu);
            if (msg == null) {
                msg = "Usuario creado con éxito.";
            }
        } else {
            msg = "Las contraseñas no coinciden.";
        }

        return msg;
    }

    public static List listarUsuarios() {
        List<Usuario> lista = new ArrayList<>();
        List list = DaoUsuario.listar();
        
        for (int i = 0; i < list.size(); i++) {
            Object[] s = (Object[])list.get(i);
            Usuario usuario = new Usuario();
            usuario.setCodUsuario(s[0].toString());
            usuario.setNom(s[1].toString());
            usuario.setApe(s[2].toString());
            usuario.setUsername(s[3].toString());
                        
            Estado estado = new Estado(s[4].toString(), s[5].toString());
            usuario.setEstado(estado);
            
            Rol rol = new Rol(s[6].toString(), s[7].toString());
            usuario.setRoll(rol);
            
            usuario.setCar(s[8].toString());
            
            lista.add(usuario);
        }
        return lista;
    }
    
    public static String eliminarUsuario(String codigo) 
    {                         
        Usuario usu = new Usuario(codigo);
        String msg = DaoUsuario.eliminar(usu);
        if (msg == null) {
            msg = "El usuario fue eliminado!";
        }
        return msg;
    }

    public static String actualizarUsuario(String codUsuario,
                                            String pass,
                                            String confPass,
                                            String nom,
                                            String ape,
                                            String car,
                                            String rol,
                                            String est,
                                            String codUsuCre,
                                            String fecUsuCre) 
    {        
        String msg = null;
        if (pass.equals(confPass)) {         
            Rol r = new Rol(rol);
            Estado e = new Estado(est);
            Usuario usu = new Usuario(codUsuario, Encriptacion.encriptar(pass), nom, ape, car, r, e, 0, codUsuCre, fecUsuCre);
            msg = DaoUsuario.actualizar(usu);
            if (msg == null) {
                msg = "Usuario actualizado.";
            }
        } else {
            msg = "Las contraseñas no coinciden.";
        }

        return msg;
    }
}
