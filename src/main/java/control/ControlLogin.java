package control;

import entidad.Usuario;
import servicio.ServicioLogin;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ControlLogin", urlPatterns = {"/ControlLogin"})
public class ControlLogin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String usuario = request.getParameter("inpUsu");
        String pass = request.getParameter("inpPwd");
        System.out.println(usuario + " " + pass);
        Usuario usuAut = ServicioLogin.loginUsuario(usuario, pass);

        if (usuAut != null){
            HttpSession session = request.getSession();
            session.setMaxInactiveInterval(300);
            session.setAttribute("usuAut", usuAut);
            response.sendRedirect("home.jsp");
            System.out.println("Sesión iniciada correctamente");
        } else {
            response.sendRedirect("login.jsp?error=1");
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
    }// </editor-fold>

}
