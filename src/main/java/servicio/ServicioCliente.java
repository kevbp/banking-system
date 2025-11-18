package servicio;

import utilitarios.InsecureTrustManager;
import com.fasterxml.jackson.databind.ObjectMapper;
import conexion.DaoCliente;
import entidad.Cliente;
import entidad.UsuarioCliente;
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
import utilitarios.Encriptacion;
import utilitarios.Utiles;    

public class ServicioCliente {
    private static final int REGISTROS_POR_PAGINA = 15;
    private static final String PASSWORD_PATTERN = "^(?=.*[A-Z])(?=.*[0-9])(?=.*[^a-zA-Z0-9\\s]).{9,}$";
    
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
    
    public static int contarClientes(String tipoDoc, String numDoc, String nomb) {
        String condicion = construirCondicionBusqueda(tipoDoc, numDoc, nomb);
        return DaoCliente.contar(condicion);
    }
    
    private static String construirCondicionBusqueda(String tipoDoc, String numDoc, String nomb) {
        StringBuilder condicion = new StringBuilder(" WHERE 1 = 1 "); // Asumimos un filtro de estado ACTIVO por defecto
        
        // 1. Aplicar filtro por tipo y número de documento (usualmente van juntos)
        if (tipoDoc != null && !tipoDoc.isEmpty() && numDoc != null && !numDoc.isEmpty()) {
            // Se usa el AND porque ya tenemos 'c.codEstado = 'S0001''
            condicion.append(" AND tipoDoc = '").append(tipoDoc).append("' ");
            condicion.append(" AND numDoc = '").append(numDoc).append("' ");
        } 
        
        // 2. Aplicar filtro por nombre (LIKE)
        // Se aplica si no se usó el filtro completo de tipo/número, o se complementa.
        if (nomb != null && !nomb.isEmpty()) {
            condicion.append(" AND nomCompleto LIKE '%").append(nomb).append("%' ");
        } 
        
        // Si no hay ningún filtro más allá del estado activo, la condición sigue siendo " WHERE c.codEstado = 'S0001' "
        return condicion.toString();
    }
    
    public static List listarClientesPaginado(String tipoDoc, String numDoc, String nomb, int pagina) {
        
        // 1. Construir la condición de búsqueda
        String condicion = construirCondicionBusqueda(tipoDoc, numDoc, nomb);
        
        // 2. Calcular el OFFSET para la paginación
        // Fórmula: (Página - 1) * Registros_por_página
        int offset = (pagina - 1) * REGISTROS_POR_PAGINA;
        
        // 3. Llamar al DAO con la condición, el límite (15) y el offset
        // Asumiendo que DaoCliente.listarPaginado(condicion, limit, offset) fue añadido en el DAO
        return DaoCliente.listar(condicion, REGISTROS_POR_PAGINA, offset);
    }
                
    public static int contarClientesActivos() {
        String condicion = "WHERE codEstado = 'S0001'";
        return DaoCliente.contar(condicion);
    }
    // --- MÉTODO NUEVO PARA REGISTRO WEB ---
    public static String registrarAccesoWeb(String dni, UsuarioCliente uc) {
        
        String pwd = uc.getClaveWeb();
        
        // 0. VALIDACIÓN DE POLÍTICA DE CONTRASEÑA (NUEVO)
        if (!pwd.matches(PASSWORD_PATTERN)) {
            return "La contraseña es débil. Debe tener más de 8 caracteres, incluir al menos una mayúscula, un número y un símbolo.";
        }
        
        // 1. Validar que el DNI corresponda a un Cliente existente
        List<Object[]> clientes = DaoCliente.listar(" WHERE numDoc = '" + dni + "'", 1, 0);
        
        if (clientes == null || clientes.isEmpty()) {
            return "El DNI ingresado no pertenece a un cliente registrado en el banco.";
        }

        // Obtener el codCliente
        String codCliente = clientes.get(0)[0].toString();
        uc.setCodCliente(codCliente); // Asignamos la FK a la entidad

        // 2. Validar duplicados
        if (DaoCliente.clienteTieneUsuarioWeb(codCliente)) {
            return "Usted ya tiene una cuenta web activa. Use la opción de recuperar contraseña.";
        }
        if (DaoCliente.existeUsuarioWeb(uc.getNomUsuario())) {
            return "El nombre de usuario ya está en uso. Por favor elija otro.";
        }

        // 3. Encriptar y actualizar la entidad antes de guardar
        uc.setClaveWeb(Encriptacion.encriptar(uc.getClaveWeb()));
        uc.setPalabraRecuperacion(Encriptacion.encriptar(uc.getPalabraRecuperacion()));

        // 4. Registrar en BD
        String errorBD = DaoCliente.registrarUsuarioWeb(uc);
        
        return errorBD; 
    }
    
    public static String recuperarContrasenaWeb(String accion, String dni, UsuarioCliente uc) {
        
        // 1. Obtener codCliente por DNI
        List<Object[]> clientes = DaoCliente.listar(" WHERE numDoc = '" + dni + "'", 1, 0);
        
        if (clientes == null || clientes.isEmpty()) {
            return "El DNI ingresado no está registrado como cliente.";
        }
        String codCliente = clientes.get(0)[0].toString();
        
        // 2. Buscar credenciales web asociadas
        Object[] credencialesWeb = DaoCliente.buscarCredencialesWeb(codCliente); 
        
        if (credencialesWeb == null) {
            return "No tiene una cuenta web asociada. Por favor, regístrese.";
        }
        
        // Elemento [2] contiene la palabra de recuperación encriptada
        String palabraHashAlmacenada = credencialesWeb[2].toString();
        
        // --- LÓGICA DE VERIFICACIÓN (PASO 1) ---
        if ("verificar".equalsIgnoreCase(accion)) {
            // uc.getPalabraRecuperacion() trae el valor sin encriptar del formulario
            if (Encriptacion.validar(uc.getPalabraRecuperacion(), palabraHashAlmacenada)) {
                return null; // Éxito
            } else {
                return "Palabra clave secreta incorrecta.";
            }
        } 
        
        // --- LÓGICA DE RECUPERACIÓN (PASO 2) ---
        else if ("recuperar".equalsIgnoreCase(accion)) {
            // uc.getClaveWeb() trae la nueva clave sin encriptar del formulario
            String nuevaClaveHash = Encriptacion.encriptar(uc.getClaveWeb());
            String errorBD = DaoCliente.actualizarClaveWeb(codCliente, nuevaClaveHash);
            
            return errorBD; // null si éxito, mensaje si error
        }
        
        return "Acción de servicio no reconocida.";
    }
    
    public static Object[] autenticarClienteWeb(String nomUsuario, String psw) {
        
        Object[] datosUsuarioWeb = DaoCliente.buscarUsuarioWeb(nomUsuario);

        if (datosUsuarioWeb == null) {
            return null; // Usuario no encontrado
        }

        // Elementos del array: [0] codCliente, [1] nomUsuario, [2] claveWeb (Hash), [3] codEstado
        String claveHashAlmacenada = datosUsuarioWeb[2].toString();
        String estado = datosUsuarioWeb[3].toString();

        // 1. Verificar estado
        if ("S0003".equalsIgnoreCase(estado)) { // Asumiendo S0003 = BLOQUEADO
            return null; 
        }

        // 2. Validar contraseña usando BCrypt
        if (Encriptacion.validar(psw, claveHashAlmacenada)) {
            // Éxito. Buscamos los datos completos del cliente (t_cliente) para la sesión
            String codCliente = datosUsuarioWeb[0].toString();
            return DaoCliente.buscar(codCliente); // Reutiliza el método buscar de DaoCliente
        } else {
            // Contraseña inválida
            return null;
        }
    }
}