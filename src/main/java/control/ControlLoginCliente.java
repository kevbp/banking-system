package control;

import entidad.UsuarioCliente;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import servicio.ServicioCliente;

@WebServlet(name = "ControlLoginCliente", urlPatterns = {"/ControlLoginCliente"})
public class ControlLoginCliente extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String accion = request.getParameter("accion");
        
        if (accion == null) {
            response.sendRedirect("modulo-clientes/login-clientes.jsp"); 
            return;
        }

        switch (accion) {
            case "registrar":
                procesarRegistro(request, response);
                break;
            case "recuperar":
                procesarRecuperacion(request, response);
                break;
            case "login":
                // Aquí iría la lógica de login
                response.sendRedirect("modulo-clientes/dashboard-cliente.jsp");
                break;
            default:
                response.sendRedirect("modulo-clientes/login-clientes.jsp");
                break;
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
    private void procesarRegistro(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // DNI necesario para la búsqueda en t_cliente
        String dni = request.getParameter("inpDni"); 
        String pwdConf = request.getParameter("inpPwdConf");
        String urlDestino = "modulo-clientes/registro-clientes.jsp";

        // 1. Validación de contraseñas
        if (!request.getParameter("inpPwd").equals(pwdConf)) {
            request.setAttribute("mensaje", "Las contraseñas no coinciden.");
            request.getRequestDispatcher(urlDestino).forward(request, response);
            return;
        }
        
        // 2. Llenar la entidad UsuarioCliente
        UsuarioCliente uc = new UsuarioCliente();
        uc.setNomUsuario(request.getParameter("inpUsu"));
        uc.setClaveWeb(request.getParameter("inpPwd"));
        uc.setPalabraRecuperacion(request.getParameter("inpPalRec"));

        // 3. Llamar al ServicioCliente
        String error = ServicioCliente.registrarAccesoWeb(dni, uc);

        if (error == null) {
            response.sendRedirect("modulo-clientes/login-clientes.jsp?registro=exito");
        } else {
            request.setAttribute("mensaje", error);
            request.getRequestDispatcher(urlDestino).forward(request, response);
        }
    }
    
    private void procesarRecuperacion(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String urlDestino = "modulo-clientes/recuperar-contrasena.jsp";
        
        String dni = request.getParameter("inpDNI");
        String actionStep = request.getParameter("actionStep"); 
        
        String palabraClave = request.getParameter("inpClave");
        String nuevaClave = request.getParameter("inpNuevaPwd");
        String confirmarClave = request.getParameter("inpConfirmarPwd");
        
        UsuarioCliente uc = new UsuarioCliente();
        String mensajeResultado = null;

        if ("verificar".equalsIgnoreCase(actionStep)) {
            // PASO 1: Llenar entidad con la palabra clave
            uc.setPalabraRecuperacion(palabraClave);
            mensajeResultado = ServicioCliente.recuperarContrasenaWeb("verificar", dni, uc);
            
            if (mensajeResultado == null) {
                // Éxito
                request.setAttribute("showNewPasswordForm", true);
                request.setAttribute("inpDNI", dni); // Mantenemos DNI para el siguiente POST
            } else {
                request.setAttribute("mensaje", mensajeResultado);
            }
            
            request.getRequestDispatcher(urlDestino).forward(request, response);
            
        } else if ("recuperar".equalsIgnoreCase(actionStep)) {
            // PASO 2: Actualizar Contraseña
            
            // 1. Validación de confirmación
            if (nuevaClave == null || !nuevaClave.equals(confirmarClave)) {
                request.setAttribute("mensaje", "La nueva contraseña y su confirmación no coinciden.");
                // Volvemos a mostrar el Paso 2
                request.setAttribute("showNewPasswordForm", true); 
                request.setAttribute("inpDNI", dni);
                request.getRequestDispatcher(urlDestino).forward(request, response);
                return;
            }
            
            // 2. Llenar entidad con la nueva clave
            uc.setClaveWeb(nuevaClave); 
            mensajeResultado = ServicioCliente.recuperarContrasenaWeb("recuperar", dni, uc);

            if (mensajeResultado == null) {
                response.sendRedirect("modulo-clientes/login-clientes.jsp?recuperacion=exito");
            } else {
                request.setAttribute("mensaje", mensajeResultado);
                // Si falla, volvemos a mostrar el Paso 2
                request.setAttribute("showNewPasswordForm", true); 
                request.setAttribute("inpDNI", dni);
                request.getRequestDispatcher(urlDestino).forward(request, response);
            }
        }
    }
}
