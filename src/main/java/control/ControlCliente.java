package control;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import servicio.ServicioCliente;
import entidad.Usuario;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;
import servicio.ServicioUtilitarios;

@WebServlet(name = "ControlCliente", urlPatterns = {"/ControlCliente"})
public class ControlCliente extends HttpServlet {

    String tipoDocumento = "";
    String nroDocumento = "";
    String codigo = "";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        cargarDatosComunes(request);
        
        String operacion = request.getParameter("op");

        if (operacion == null || operacion.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parámetro 'op' requerido.");
            return;
        }

        switch (operacion) {
            case "ListaClientes":
                listarClientesYForward(request, response, "", "", "");
                break;
                
            case "RegistrarCliente":
                codigo = ServicioCliente.nuevoCodigo();
                request.setAttribute("codigo", codigo);
                request.getRequestDispatcher("clientes/registrar-cliente.jsp").forward(request, response);
                break;
                
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Operación GET no reconocida.");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String accion = request.getParameter("accion");
        Usuario usuAut = obtenerUsuarioAutenticado(request); 

        if (accion == null || accion.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parámetro 'accion' requerido.");
            return;
        }

        switch (accion.toLowerCase()) {
            case "consultar":
                ejecutarConsulta(request, response);
                break;
                
            case "registrar":
                ejecutarRegistro(request, response, usuAut);
                break;
                
            case "reniec":
                ejecutarValidacionReniec(request, response);
                break;
                
            case "actualizar":
                ejecutarActualizacion(request, response, usuAut);
                break;
                
            case "desactivar":
                ejecutarDesactivacion(request, response);
                break;
                
            case "detalle":
                mostrarDetalleCliente(request, response);
                break;
                
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Acción POST no reconocida.");
                break;
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
    
    private void cargarDatosComunes(HttpServletRequest request) {
        List region = ServicioUtilitarios.listarRegion();
        request.getSession().setAttribute("region", region);
    }
    
    private void listarClientesYForward(HttpServletRequest request, HttpServletResponse response, 
                                        String tipoDoc, String nroDoc, String nombre) 
            throws ServletException, IOException {
        
        List lista = ServicioCliente.listarClientes(tipoDoc, nroDoc, nombre);
        if (lista != null) {
            request.setAttribute("lista", lista);
        }        
        request.getRequestDispatcher("clientes/consulta-clientes.jsp").forward(request, response);
    }
    
    private Usuario obtenerUsuarioAutenticado(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return (session != null) ? (Usuario) session.getAttribute("usuAut") : null;
    }
    
    private void ejecutarConsulta(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String tipoDocumento = request.getParameter("tipoDoc");
        String nroDocumento = request.getParameter("numDoc");
        String nombre = request.getParameter("nombre");

        listarClientesYForward(request, response, tipoDocumento, nroDocumento, nombre);
    }
    
    private void ejecutarRegistro(HttpServletRequest request, HttpServletResponse response, Usuario usuAut) 
            throws ServletException, IOException {
        
        String codigo = request.getParameter("codCliente");
        String nombre = request.getParameter("nom");
        String tipoDoc = request.getParameter("tipoDoc");
        String nroDoc = request.getParameter("nroDoc");
        String fecNac = request.getParameter("fecNac");
        String dir = request.getParameter("dir");
        String tel = request.getParameter("tel");
        String cel = request.getParameter("cel");
        String email = request.getParameter("email");
        String region = request.getParameter("region");
        String provincia = request.getParameter("provincia");
        String distrito = request.getParameter("distrito");
        
        String msg = ServicioCliente.crearCliente(codigo, nombre, tipoDoc, nroDoc, fecNac, dir, tel, cel, email, region, provincia, distrito, usuAut.getCodUsuario(), LocalDateTime.now().toString());

        if (!msg.isEmpty()) { 
            listarClientesYForward(request, response, "", "", "");
        } else {
            request.setAttribute("error", "Error al registrar cliente.");
            request.getRequestDispatcher("clientes/registrar-cliente.jsp").forward(request, response);
        }
    }
    
    private void ejecutarValidacionReniec(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String tipoDocumento = request.getParameter("tipoDoc");
        String nroDocumento = request.getParameter("numDoc");
        
        Object[] clienteReniec = ServicioCliente.validacionReniec(tipoDocumento, nroDocumento);
        
        request.setAttribute("cliente", clienteReniec);
        request.setAttribute("tipoDoc", tipoDocumento);
        request.setAttribute("codigo", codigo);
        
        cargarDatosComunes(request);
        
        request.getRequestDispatcher("clientes/registrar-cliente.jsp").forward(request, response);
    }
    
    private void ejecutarActualizacion(HttpServletRequest request, HttpServletResponse response, Usuario usuAut) 
            throws ServletException, IOException {
        
        String idCliente = request.getParameter("idCliente");
        String fechaNacimiento = request.getParameter("fechaNacimiento");
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        String celular = request.getParameter("celular");
        String correo = request.getParameter("correo");
        String estado = request.getParameter("estado");
        String region = request.getParameter("region");
        String provincia = request.getParameter("provincia");
        String distrito = request.getParameter("distrito");
        
        String msg = ServicioCliente.actualizarCliente(idCliente, fechaNacimiento, direccion, telefono, celular, correo, estado, region, provincia, distrito, usuAut.getCodUsuario(), LocalDateTime.now().toString());
        
        request.setAttribute("mensajeResultado", msg);
        
        listarClientesYForward(request, response, "", "", "");
    }
    
    private void ejecutarDesactivacion(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idCliente = request.getParameter("idClienteDesactivar");
        String msg = ServicioCliente.inactivarCliente(idCliente);
                
        listarClientesYForward(request, response, "", "", "");
    }
    
    private void mostrarDetalleCliente(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String id = request.getParameter("id");
        Object[] cliente = ServicioCliente.buscarCliente(id);
        
        if (cliente == null) {
            request.setAttribute("error", "Cliente no encontrado.");
        } else {
            List estadosUsuario = ServicioUtilitarios.listarEstadoUsuario();
            request.setAttribute("estUsu", estadosUsuario);
            request.setAttribute("abrirModalEditar", "1");
            request.setAttribute("cliente", cliente);
        }        
        listarClientesYForward(request, response, "", "", "");
    }
}