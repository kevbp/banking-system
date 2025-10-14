package control;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import servicio.ServicioClienteReniec;
import entidad.ClienteReniec;

@WebServlet(name = "ControlClienteReniec", urlPatterns = {"/ControlClienteReniec"})
public class ControlClienteReniec extends HttpServlet {
    String tipoDocumento = "";
    String nroDocumento = "";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        tipoDocumento = request.getParameter("tipoDoc");
        nroDocumento = request.getParameter("numDoc");
        String accion = request.getParameter("accion");
        
        if (accion.startsWith("Consultar")) {
            
            request.getSession().setAttribute("tipoDocumento", tipoDocumento);
            request.getSession().setAttribute("nroDocumento", nroDocumento);
            
            ClienteReniec cliReniec = ServicioClienteReniec.validacionReniec(tipoDocumento, nroDocumento);
            if (cliReniec != null) {
                request.getSession().setAttribute("cliReniec", cliReniec);
            }
            request.getRequestDispatcher("clientes/registrar-cliente.jsp").forward(request, response);
        }else if(accion.startsWith("Registrar")){
            String codigo = request.getParameter("codCliente");
            String nombre = request.getParameter("nom");
            String apellido = request.getParameter("ape");
            String fecNac = request.getParameter("fecNac");
            String dir = request.getParameter("dir");
            String tel = request.getParameter("tel");
            String cel = request.getParameter("cel");
            String email = request.getParameter("email");
            String fecReg = request.getParameter("fecReg");
            
            tipoDocumento = (String)request.getSession().getAttribute("tipoDocumento");
            nroDocumento = (String)request.getSession().getAttribute("nroDocumento");
            String msg = ServicioClienteReniec.crearCliente(codigo, nombre, apellido, tipoDocumento, nroDocumento, fecNac, dir, tel, cel, email, fecReg);
            if (msg!="") {
                response.sendRedirect("home.jsp");                
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
