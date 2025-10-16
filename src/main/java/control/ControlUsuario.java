/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import entidad.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.List;
import servicio.ServicioUsuario;
import servicio.ServicioUtilitarios;

/**
 *
 * @author broncake
 */
@WebServlet(name = "ControlUsuario", urlPatterns = {"/ControlUsuario"})
public class ControlUsuario extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String op = request.getParameter("op");
        System.out.println("Mensaje de get srvlet: " + op);

        switch (op) {
//            case "Listar":
//                List lista = ServicioUsuario.listarUsuario();
//                request.getSession().setAttribute("lista", lista);
//                response.sendRedirect(request.getContextPath() + "/GestionUsuarios/listadoUsuarios.jsp");
//                break;
//            case "Consultar":
//                String cod = request.getParameter("cod");
//                Usuario usu = ServicioUsuario.consultarUsuario(cod);
//                request.getSession().setAttribute("usu", usu);
//                System.out.println(usu.getPerfil());
//                response.sendRedirect(request.getContextPath() + "/GestionUsuarios/actualizarUsuario.jsp");
//                break;
            case "RegistrarUsuario":
                List roles = ServicioUtilitarios.listarRoles();
                request.getSession().setAttribute("roles", roles);
                List estUsu = ServicioUtilitarios.listarEstadoUsuario();
                request.getSession().setAttribute("estUsu", estUsu);
                response.sendRedirect(request.getContextPath() + "/Administracion/gestion-usuarios.jsp");
                break;

            case "CerrarSesion":
                HttpSession session = request.getSession(false);
                if (session != null) {
                    session.invalidate();
                }
                response.sendRedirect("login.jsp");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
//        List lista;

        HttpSession session = request.getSession(false); // false para no crear una nueva sesión si no existe
        Usuario usuAut = (Usuario) session.getAttribute("usuAut");

        switch (acc) {
            case "CrearUsuario":
                System.out.println("Ingresando al case CREAR USUARIO");
                LocalDate hoy = LocalDate.now();
                msg = ServicioUsuario.crearUsuario(usn, clave, confClave, nom, ape, car, roles, est, usuAut.getCodUsuario(), hoy.toString());
                response.sendRedirect(request.getContextPath() + "/Administracion/gestion-usuarios.jsp?msg=" + msg + "");
                break;
//            case "Actualizar":
//                msg = ServicioUsuario.actualizarUsuario(cod, username, nom, pass, rol, est);
//                request.getSession().setAttribute("usu", ServicioUsuario.consultarUsuario(cod));
//                response.sendRedirect(request.getContextPath() + "/GestionUsuarios/actualizarUsuario.jsp?msg=" + msg + "");
//                break;
//            case "Eliminar":
//                msg = ServicioUsuario.eliminarUsuario(cod);
//                lista = ServicioUsuario.listarUsuario();
//                request.getSession().setAttribute("lista", lista);
//                response.sendRedirect(request.getContextPath() + "/GestionUsuarios/listadoUsuarios.jsp?msg=" + msg + "");
//                break;
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
