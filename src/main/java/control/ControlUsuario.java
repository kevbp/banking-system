/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package control;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import servicio.ServicioUsuario;

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
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cod = request.getParameter("txtCod");
        String username = request.getParameter("txtUsn");
        String nom = request.getParameter("txtNom");
        String pass = request.getParameter("txtPass");
        String rol = request.getParameter("txtRol");
        String est = request.getParameter("selEst");

        String acc = request.getParameter("acc");
        String msg;
//        List lista;

        switch (acc) {
            case "Crear":
                //msg = ServicioUsuario.crearUsuario(username, nom, pass, rol);
                //response.sendRedirect(request.getContextPath() + "/GestionUsuarios/registrarUsuario.jsp?msg=" + msg + "");
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
