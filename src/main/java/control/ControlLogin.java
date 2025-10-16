package control;

import entidad.LoginRespuesta;
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
        LoginRespuesta resultado = ServicioLogin.loginUsuario(usuario, pass);

        if (resultado.getUsuario() != null) {
            HttpSession session = request.getSession();
            session.setMaxInactiveInterval(60);
            session.setAttribute("usuAut", resultado.getUsuario());
            response.sendRedirect("home.jsp");
        } else {
            request.setAttribute("mensaje", resultado.getMensaje());
            request.getRequestDispatcher("login.jsp").forward(request, response);
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
