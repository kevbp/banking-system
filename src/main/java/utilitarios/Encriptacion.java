
package utilitarios;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class Encriptacion {
    
    public static String encriptar(String cadena){
        String encriptacion = "";
        try {
            //Inicializa el codificador con un factor de trabajo predeterminado
            BCryptPasswordEncoder password = new BCryptPasswordEncoder();
            
            //1. Hashear (Encriptar) la contraseña
            encriptacion = password.encode(cadena);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return encriptacion;
    }
    
    public static boolean validar(String cadena, String encriptado){
        boolean validado = false;
        try {
            //Inicializa el codificador con un factor de trabajo predeterminado
            BCryptPasswordEncoder password = new BCryptPasswordEncoder();
            
            validado = password.matches(cadena, encriptado);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return validado;
    }
}
