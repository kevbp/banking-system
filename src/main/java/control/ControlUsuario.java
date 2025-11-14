package control;

import entidad.Usuario;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;
import servicio.ServicioUsuario;
import servicio.ServicioUtilitarios;

@WebServlet(name = "ControlUsuario", urlPatterns = {"/ControlUsuario"})
public class ControlUsuario extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // (Puedes dejar esto vacío si no lo usas)
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String op = request.getParameter("op");
        
        if (op == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        switch (op) {
            case "keepAlive":
                // 1. Acción Keep-Alive (Ping)
                mantenerSesionActiva(response);
                break;
                
            case "RegistrarUsuario":
                // 2. Carga de datos necesarios para la vista de gestión
                cargarDatosGestionUsuarios(request);
                response.sendRedirect(request.getContextPath() + "/Administracion/gestion-usuarios.jsp");
                break;

            case "CerrarSesion":
                // 3. Acción de Cerrar Sesión
                cerrarSesion(request, response);
                break;

            default:
                // Manejo de 'op' no reconocido
                response.sendRedirect("login.jsp");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String acc = request.getParameter("acc");
        
        // Obtener usuario autenticado y hora actual (necesario en varios casos)
        HttpSession session = request.getSession(false);
        Usuario usuAut = (Usuario) session.getAttribute("usuAut");
        LocalDateTime hoy = LocalDateTime.now();

        if (acc == null || usuAut == null) {
            // Manejo de sesión no válida o acción faltante
            response.sendRedirect("selec-roles.jsp");
            return;
        }

        String msg = "";
        
        switch (acc) {
            case "CrearUsuario":
                msg = ejecutarCrearUsuario(request, usuAut, hoy);
                break;
                
            case "Actualizar":
                msg = ejecutarActualizarUsuario(request, usuAut, hoy);
                break;
                
            case "Eliminar":
                msg = ejecutarEliminarUsuario(request);
                break;
                
            default:
                // Si la acción POST no es reconocida, se puede redirigir o mostrar error.
                msg = "Acción no reconocida.";
                break;
        }
        
        finalizarPost(request, response, msg, "success");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }   
    
    private void mantenerSesionActiva(HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.getWriter().write("{\"status\": \"session_extended\"}");
    }
    
    private void cargarDatosGestionUsuarios(HttpServletRequest request) {        
        List roles = ServicioUtilitarios.listarRoles();
        request.getSession().setAttribute("roles", roles);
        
        List estUsu = ServicioUtilitarios.listarEstadoUsuario();
        request.getSession().setAttribute("estUsu", estUsu);
        
        List usuarios = ServicioUsuario.listarUsuarios();
        request.getSession().setAttribute("usuarios", usuarios);
    }
    
    private void cerrarSesion(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("login.jsp");
    }
    
    private String ejecutarCrearUsuario(HttpServletRequest request, Usuario usuAut, LocalDateTime hoy) {
        String nom = request.getParameter("nom");
        String ape = request.getParameter("ape");
        String usn = request.getParameter("usn");
        String car = request.getParameter("car");
        String roles = request.getParameter("roles");
        String est = request.getParameter("est");
        String clave = request.getParameter("clave");
        String confClave = request.getParameter("confirmarClave");
        
        System.out.println("Ingresando al case CREAR USUARIO");
        
        return ServicioUsuario.crearUsuario(usn, clave, confClave, nom, ape, car, roles, est, usuAut.getCodUsuario(), hoy.toString());
    }
    
    private String ejecutarActualizarUsuario(HttpServletRequest request, Usuario usuAut, LocalDateTime hoy) {
        String id = request.getParameter("idUsuario");
        String nombre = request.getParameter("nombreEditar");
        String apellido = request.getParameter("apellidoEditar");
        String cargo = request.getParameter("cargoEditar");
        String rol = request.getParameter("rolEditar");
        String estado = request.getParameter("estadoEditar");
        
        return ServicioUsuario.actualizarUsuario(id, nombre, apellido, cargo, rol, estado, usuAut.getCodUsuario(), hoy.toString());
    }

    private String ejecutarEliminarUsuario(HttpServletRequest request) {
        String codigo = request.getParameter("id");
        return ServicioUsuario.eliminarUsuario(codigo);
    }
    
    private void finalizarPost(HttpServletRequest request, HttpServletResponse response, String msg, String tipoAlerta) throws IOException {
        
        // Setear mensaje en la sesión (tal como estaba el original)
        request.getSession().setAttribute("msg", msg);
        request.getSession().setAttribute("tipoAlerta", tipoAlerta);
        
        // Actualizar lista de usuarios y guardarla en la sesión (tal como estaba el original)
        List usuarios = ServicioUsuario.listarUsuarios();
        request.getSession().setAttribute("usuarios", usuarios);
        
        // Redirigir al JSP de gestión
        response.sendRedirect(request.getContextPath() + "/Administracion/gestion-usuarios.jsp");
    }
}
