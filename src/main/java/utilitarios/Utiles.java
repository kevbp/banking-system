package utilitarios;

import java.util.Random;

public class Utiles {
   
    public static String newCod(String pCodigo) {
        System.out.println("Código ingresante: " + pCodigo);
        char letraInicial = pCodigo.charAt(0);
        int numero = Integer.parseInt(pCodigo.substring(1));
        numero = numero + 1;
        String numeroFormateado = String.format("%04d", numero);
        String nuevoCodigo = letraInicial + numeroFormateado;
        System.out.println("Código convertido en Utiles newCod: " + nuevoCodigo);
        return nuevoCodigo;
    }
    
    // ✅ La longitud deseada para el número de cuenta interno (ejemplo: 14 dígitos)
    private static final int LONGITUD_CUENTA = 14; 

    /**
     * Genera una cadena de 14 dígitos aleatorios.
     * @return El número de cuenta aleatorio como String.
     */
    public static String generarNumeroCuenta() {
        Random random = new Random();
        StringBuilder sb = new StringBuilder();

        // Primer dígito: Aseguramos que sea entre 1 y 9 para tener exactamente 14 cifras
        sb.append(random.nextInt(9) + 1); 

        // Generamos los 13 dígitos restantes (14 - 1 = 13)
        for (int i = 0; i < LONGITUD_CUENTA - 1; i++) {
            sb.append(random.nextInt(10)); // Dígito del 0 al 9
        }
        return sb.toString();
    }
}
