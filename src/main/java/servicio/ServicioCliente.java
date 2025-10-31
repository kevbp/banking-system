package servicio;

import utilitarios.InsecureTrustManager;
import com.fasterxml.jackson.databind.ObjectMapper;
import conexion.DaoCliente;
import entidad.Cliente;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import utilitarios.Utiles;

public class ServicioCliente {
    public static Object[] validacionReniec(String tipo, String documento){
        // La URL del endpoint de la API que quieres consumir
        String API_URL_BASE = "https://dniruc.apisperu.com/api/v1/"+tipo+"/";
        String TOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6ImNhcmxvc2VkdWFyZG8xMjkzQGdtYWlsLmNvbSJ9.9u9vycOXxx0pKH2ONaFg3l_7I7dpEGC8CZg94vBPh0w"; 
        Object[] clie = null;
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
                
                Map<String, Object> resultado = objectMapper.readValue(jsonResponse, Map.class);
                
                List<Object> valoresDeseados = new ArrayList<>();

                if (resultado.containsKey("dni")) {
                    // Es el formato DNI. Queremos devolver DNI, Nombres y Apellidos
                    valoresDeseados.add(resultado.get("dni"));
                    valoresDeseados.add(resultado.get("nombres") + " " + resultado.get("apellidoPaterno") + " " + resultado.get("apellidoMaterno"));

                } else if (resultado.containsKey("ruc")) {
                    // Es el formato RUC. Queremos devolver RUC, Razón Social y Dirección
                    valoresDeseados.add(resultado.get("ruc"));
                    valoresDeseados.add(resultado.get("razonSocial"));
                    valoresDeseados.add(resultado.get("direccion"));
                    valoresDeseados.add(resultado.get("ubigeo"));
                }

                // Convertir la lista al tipo final requerido: Object[]
                clie = valoresDeseados.toArray();

            } else {
                System.err.println("\nError al consumir la API. Código de estado: " + response.statusCode());
                System.err.println("Cuerpo de error: " + response.body());
            }

        } catch (Exception e) {
            System.err.println("Ocurrió un error al realizar la petición o al procesar el JSON.");
            e.printStackTrace();
        }
        return clie;
    }
    
    public static String crearCliente(String codigo, String nombre, 
                                        String tipoDoc, String numDocumento, 
                                        String fechaNac, String direccion, 
                                        String telefono, String celular, 
                                        String email, String region, 
                                        String provincia,String distrito, 
                                        String codUsuCre, String fechaReg){
        
        String codUbigeo = ServicioUtilitarios.obtenerUbigeo(region, provincia, distrito);
        
        Cliente cliente = new Cliente(codigo, nombre, tipoDoc, numDocumento, fechaNac, direccion, codUbigeo, telefono, celular, email, fechaReg, "S0001", codUsuCre, fechaReg);
        String msg = DaoCliente.crear(cliente);
        if(msg == null){
            msg = "Cliente registrado!";
        }
        return msg;
    }
    
    public static List listarClientes(String tipoDoc, String numDoc, String nomb)
    {
        String condicion = "Where ";
        if (!tipoDoc.isEmpty()) {
            condicion = condicion + "tipoDoc = '"+tipoDoc+"' and numDoc = '"+numDoc+"'";
        }
        
        if (!tipoDoc.isEmpty() && !nomb.isEmpty()) {
            condicion = condicion + " and nom like '%"+nomb+"%'";
        }else if(tipoDoc.isEmpty() && !nomb.isEmpty()){
            condicion = condicion + "nomCompleto like '%"+nomb+"%'";
        }
        
        if (tipoDoc.isEmpty() && nomb.isEmpty()){
            condicion = "";
        }
        
        List lista = DaoCliente.listar(condicion);          
        return lista;
    }
    
    public static String nuevoCodigo(){
        Object[] ultCod = DaoCliente.ultCod();
        System.out.println(ultCod[0].toString());
        String codigo = Utiles.newCod(ultCod[0].toString());
        return codigo;
    }
    
    public static String actualizarCliente(String codigo, String fechaNac, 
                                        String direccion, String telefono, 
                                        String celular, String email,
                                        String estado, String region, 
                                        String provincia, String distrito, 
                                        String codUsuCre, String fechaReg){
        
        String codUbigeo = ServicioUtilitarios.obtenerUbigeo(region, provincia, distrito);
        
        Cliente cliente = new Cliente(codigo, fechaNac, direccion, codUbigeo, telefono, celular, email, estado, codUsuCre, fechaReg);
        String msg = DaoCliente.actualizar(cliente);
        if(msg == null){
            msg = "Cliente actualizado!";
        }
        return msg;
    }
    
    public static Object[] buscarCliente(String codigo){
        return DaoCliente.buscar(codigo);
    }    
    
    public static String inactivarCliente(String codigo){
        String msg = DaoCliente.inactivar(codigo);
        if(msg == null){
            msg = "El cliente fue inactivado!";
        }
        return msg;
    }
}
