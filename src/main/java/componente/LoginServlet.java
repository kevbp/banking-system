package componente;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import negocio.ServicioLogin;
import servicio.Usuario;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String boton = request.getParameter("accion");
        String usuario = request.getParameter("usuario");
        //String contraseña = request.getParameter("clave");
        
        if (boton.equalsIgnoreCase("Ingresar")) {
           Usuario usu = ServicioLogin.validacionReniec("",usuario);
            if (usu != null) {
                request.getSession().setAttribute("usuario", usu);
                response.sendRedirect("menu.jsp"); 
            }
        }           
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
