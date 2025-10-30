
package servicio;

import conexion.DaoCuenta;
import utilitarios.Utiles;

public class ServicioCuenta {
    
    /**
     * Genera un número de cuenta de 14 dígitos ÚNICO y lo asigna.
     * @return El número de cuenta interno único.
    **/
    public String crearNumeroCuentaUnico() {
        String nuevoNumeroCuenta;
        boolean existe;
        // Bucle para generar, verificar y repetir si ya existe en la DB
        do {
            nuevoNumeroCuenta = Utiles.generarNumeroCuenta();            
            Object[] cuenta = DaoCuenta.verificarExistencia(nuevoNumeroCuenta);            
            // 🚨 Llamada a la DB: Verifica si el número ya existe
            if(cuenta == null) {
                existe = false;
            }else{
                existe = true;
            }
        } while (existe); // Si 'existe' es true, el bucle repite la generación.        
        return nuevoNumeroCuenta;
    }
}
