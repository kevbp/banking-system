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
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        String rol = request.getParameter("rol");
        if ("empleado".equals(rol)) {
            response.sendRedirect("login.jsp");
        } else if ("cliente".equals(rol)) {
            response.sendRedirect("modulo-clientes/login-clientes.jsp");
        } else if (rol == null) {
            String usuario = request.getParameter("inpUsu");
            String pass = request.getParameter("inpPwd");
            System.out.println(usuario + " " + pass);
            LoginRespuesta resultado = ServicioLogin.loginUsuario(usuario, pass);

            if (resultado.getUsuario() != null) {                
                HttpSession session = request.getSession();
                session.setMaxInactiveInterval(3600);
                session.setAttribute("usuAut", resultado.getUsuario());
                response.sendRedirect(request.getContextPath() + "/ControlHome");
            } else {
                request.setAttribute("mensaje", resultado.getMensaje());
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
