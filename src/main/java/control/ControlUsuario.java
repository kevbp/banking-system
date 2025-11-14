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

        String op = request.getParameter("op");
        System.out.println("Mensaje de get srvlet: " + op);

        if (op == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        switch (op) {
            // -----------------------------------------------------------------
            // ----- INICIO: CÓDIGO AÑADIDO PARA EL TIMER DE SESIÓN -----
            // -----------------------------------------------------------------
            case "keepAlive":
                // 1. Acción Keep-Alive (Ping)
                // Reinicia el timer de 60s en el servidor.
                // Responde con JSON para que fetch sepa que todo está OK.
                response.setContentType("application/json");
                response.getWriter().write("{\"status\": \"session_extended\"}");
                break;
            // -----------------------------------------------------------------
            // ----- FIN: CÓDIGO AÑADIDO PARA EL TIMER DE SESIÓN -----
            // -----------------------------------------------------------------

            case "RegistrarUsuario":
                List roles = ServicioUtilitarios.listarRoles();
                request.getSession().setAttribute("roles", roles);
                List estUsu = ServicioUtilitarios.listarEstadoUsuario();
                request.getSession().setAttribute("estUsu", estUsu);
                List usuarios = ServicioUsuario.listarUsuarios();
                request.getSession().setAttribute("usuarios", usuarios);
                response.sendRedirect(request.getContextPath() + "/Administracion/gestion-usuarios.jsp");
                break;

            case "CerrarSesion":
                // 2. Acción de Cerrar Sesión (llamada por JS o el botón del header)
                HttpSession session = request.getSession(false);
                if (session != null) {
                    session.invalidate();
                }
                response.sendRedirect("login.jsp");
                break;

            default:
                // Manejo de otros 'op' si los hubiera
                response.sendRedirect("login.jsp");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String nom = request.getParameter("nom");
        String ape = request.getParameter("ape");
        String usn = request.getParameter("usn");
        String car = request.getParameter("car");
        String roles = request.getParameter("roles");
        String est = request.getParameter("est");
        String clave = request.getParameter("clave");
        String confClave = request.getParameter("confirmarClave");

        String acc = request.getParameter("acc");
        String msg;
        LocalDateTime hoy = LocalDateTime.now();

        HttpSession session = request.getSession(false); // false para no crear una nueva sesión si no existe
        Usuario usuAut = (Usuario) session.getAttribute("usuAut");

        switch (acc) {
            case "CrearUsuario":
                System.out.println("Ingresando al case CREAR USUARIO");
                msg = ServicioUsuario.crearUsuario(usn, clave, confClave, nom, ape, car, roles, est, usuAut.getCodUsuario(), hoy.toString());

                request.getSession().setAttribute("msg", msg);
                request.getSession().setAttribute("tipoAlerta", "success");
                break;
            case "Actualizar":
                String id = request.getParameter("idUsuario");
                String nombre = request.getParameter("nombreEditar");
                String apellido = request.getParameter("apEditar");
                String cargo = request.getParameter("cargoEditar");
                String rol = request.getParameter("rolEditar");
                String estado = request.getParameter("estadoEditar");
                String pass = request.getParameter("claveNueva");
                String confPass = request.getParameter("confirmarClaveNueva");
                msg = ServicioUsuario.actualizarUsuario(id, nombre, apellido, cargo, rol, estado, usuAut.getCodUsuario(), hoy.toString());

                request.getSession().setAttribute("msg", msg);
                request.getSession().setAttribute("tipoAlerta", "success");
                break;
            case "Eliminar":
                String codigo = request.getParameter("id");
                msg = ServicioUsuario.eliminarUsuario(codigo);

                request.getSession().setAttribute("msg", msg);
                request.getSession().setAttribute("tipoAlerta", "success");
                break;
        }
        List usuarios = ServicioUsuario.listarUsuarios();
        request.getSession().setAttribute("usuarios", usuarios);
        response.sendRedirect(request.getContextPath() + "/Administracion/gestion-usuarios.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
