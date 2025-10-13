
package servicio;

import com.fasterxml.jackson.databind.ObjectMapper;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.security.SecureRandom;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;

public class ServicioCliente {
    public static Usuario validacionReniec(String tipo, String documento){
        // La URL del endpoint de la API que quieres consumir
        String API_URL_BASE = "https://dniruc.apisperu.com/api/v1/"+tipo+"/";
        String TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImNhcmxvc2VkdWFyZG8xMjkzQGdtYWlsLmNvbSJ9.9u9vycOXxx0pKH2ONaFg3l_7I7dpEGC8CZg94vBPh0w"; 
        Usuario usuario = null;
        
        // 1. Construir la URL con parámetros de consulta (Query Params)
        String finalUrl = API_URL_BASE + documento + "?token=" + TOKEN;
        
        try {
            SSLContext sslContext = SSLContext.getInstance("TLS");
            sslContext.init(null, new TrustManager[]{new InsecureTrustManager()}, new SecureRandom());

            // 3. Crear el cliente HTTP
            HttpClient client = HttpClient.newBuilder()
                        .sslContext(sslContext) // Omitir la verificación SSL/TLS
                        .followRedirects(HttpClient.Redirect.ALWAYS) // Seguir redirecciones
                        .build();

            // 4. Crear la solicitud (request) con método POST
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(finalUrl))
                    // La cabecera Content-Type ya no es necesaria para un GET simple, pero no daña
                    .GET() 
                    .build();
            
            // 5. Enviar la solicitud y obtener la respuesta
            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            // 6. Procesar la respuesta
            if (response.statusCode() == 200) {
                String jsonResponse = response.body();
                System.out.println("\nRespuesta JSON recibida:\n" + jsonResponse);

                // Deserialización del JSON (Asumiendo que devuelve un Array JSON como antes)
                ObjectMapper objectMapper = new ObjectMapper();  
                
                usuario = objectMapper.readValue(jsonResponse, Usuario.class);  

            } else {
                System.err.println("\nError al consumir la API. Código de estado: " + response.statusCode());
                System.err.println("Cuerpo de error: " + response.body());
            }

        } catch (Exception e) {
            System.err.println("Ocurrió un error al realizar la petición o al procesar el JSON.");
            e.printStackTrace();
        }
        return usuario;
    }
}
