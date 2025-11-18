package control;

import control.*;
import entidad.LoginRespuesta;
import servicio.ServicioLogin;
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
        
        // Verificar qué acción se está solicitando
        String accion = request.getParameter("accion");
        
        // Si no hay acción, asumimos login (o lo que tenías antes)
        if (accion == null) {
            response.sendRedirect("modulo-clientes/dashboard-cliente.jsp");
            return;
        }

        switch (accion) {
            case "registrar":
                procesarRegistro(request, response);
                break;
            case "login":
                // Aquí implementarías la lógica de login luego...
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
        
        String dni = request.getParameter("inpDni");
        String usuario = request.getParameter("inpUsu");
        String palabraRec = request.getParameter("inpPalRec");
        String pwd = request.getParameter("inpPwd");
        String pwdConf = request.getParameter("inpPwdConf");
        
        String urlDestino = "modulo-clientes/registro-clientes.jsp";

        // 1. Validar contraseñas en el controlador (validación básica)
        if (pwd == null || !pwd.equals(pwdConf)) {
            request.setAttribute("mensaje", "Las contraseñas no coinciden.");
            request.getRequestDispatcher(urlDestino).forward(request, response);
            return;
        }

        // 2. Llamar al ServicioCliente para la lógica de negocio
        String error = ServicioCliente.registrarAccesoWeb(dni, usuario, pwd, palabraRec);

        if (error == null) {
            // Éxito: Redirigir al login con parámetro de éxito
            response.sendRedirect("modulo-clientes/login-clientes.jsp?registro=exito");
        } else {
            // Error: Volver al formulario y mostrar mensaje
            request.setAttribute("mensaje", error);
            request.getRequestDispatcher(urlDestino).forward(request, response);
        }
    }
}
