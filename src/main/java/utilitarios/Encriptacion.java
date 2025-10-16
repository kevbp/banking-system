
package utilitarios;

import java.security.MessageDigest;
import java.util.Arrays;
import java.util.Base64;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class Encriptacion {
    private static String  ENCRYPT_KEY = "clave-compartida-no-reveloar-nunca";
    
    public static String encode(String cadena){
        String encriptacion = "";
        try {
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            byte[] llavePassword = md5.digest(ENCRYPT_KEY.getBytes("utf-8"));
            byte[] BytesKey = Arrays.copyOf(llavePassword, 24);
            SecretKey key = new SecretKeySpec(BytesKey, "DESede");
            Cipher cifrado = Cipher.getInstance("DESede");
            cifrado.init(Cipher.ENCRYPT_MODE, key);
            byte[] plainTextBystes = cadena.getBytes("utf-8");
            byte[] buf = cifrado.doFinal(plainTextBystes);
            encriptacion = Base64.getEncoder().encodeToString(buf);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return encriptacion;
    }
    
    public static String decript(String cadenaEncriptada){
        String desencriptacion = "";
        try {
            byte[] message = Base64.getDecoder().decode(cadenaEncriptada.getBytes("utf-8"));            
            MessageDigest md5 = MessageDigest.getInstance("MD5");
            byte[] llavePassword = md5.digest(ENCRYPT_KEY.getBytes("utf-8"));
            byte[] BytesKey = Arrays.copyOf(llavePassword, 24);
            SecretKey key = new SecretKeySpec(BytesKey, "DESede");
            Cipher descifrado = Cipher.getInstance("DESede");
            descifrado.init(Cipher.DECRYPT_MODE, key);
            byte[] plainText = descifrado.doFinal(message);
            desencriptacion = new String(plainText, "utf-8");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return desencriptacion;
    }
    
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
