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
import entidad.Usuario;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import servicio.ServicioUsuario;
import servicio.ServicioUtilitarios;

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

        String op = request.getParameter("op");
        System.out.println("Mensaje de get srvlet: " + op);

        switch (op) {
            case "ListaClientes":
//                List listaCliente = ServicioClienteReniec.listarCliente();
//                request.getSession().setAttribute("listaCliente", listaCliente);
                response.sendRedirect(request.getContextPath() + "/clientes/consulta-clientes.jsp");
                break;
//            case "Consultar":
//                String cod = request.getParameter("cod");
//                Usuario usu = ServicioUsuario.consultarUsuario(cod);
//                request.getSession().setAttribute("usu", usu);
//                System.out.println(usu.getPerfil());
//                response.sendRedirect(request.getContextPath() + "/GestionUsuarios/actualizarUsuario.jsp");
//                break;
            case "RegistrarCliente":
                //Llamada al dropdown
                List<String> region = ServicioUtilitarios.listarRegion();
                request.getSession().setAttribute("region", region);
//                request.setAttribute("departamentos", departamentos);
//                request.getRequestDispatcher("clientes/registrar-cliente.jsp").forward(request, response);
//                
                response.sendRedirect(request.getContextPath() + "/clientes/registrar-cliente.jsp");
                break;
        }

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
        } else if (accion.startsWith("Registrar")) {
            String codigo = request.getParameter("codCliente");
            String nombre = request.getParameter("nom");
            String apellido = request.getParameter("ape");
            String fecNac = request.getParameter("fecNac");
            String dir = request.getParameter("dir");
            String tel = request.getParameter("tel");
            String cel = request.getParameter("cel");
            String email = request.getParameter("email");
            String region = request.getParameter("region");
            String provincia = request.getParameter("provincia");
            String distrito = request.getParameter("distrito");
            String fecReg = request.getParameter("fecReg");
            
//          Co esto obtendremos el usuario que inició la sesión
            HttpSession session = request.getSession(false); // false para no crear una nueva sesión si no existe
            Usuario usuAut = (Usuario)session.getAttribute("usuAut");
                if (usuAut != null) {
                    // Ya tienes el usuario autenticado
                    System.out.println("Usuario en sesión: " + usuAut.getUsername());
                } else {
                    System.out.println("No hay usuario en sesión.");
                }

            tipoDocumento = (String) request.getSession().getAttribute("tipoDocumento");
            nroDocumento = (String) request.getSession().getAttribute("nroDocumento");
            String msg = ServicioClienteReniec.crearCliente(codigo, nombre, apellido, tipoDocumento, nroDocumento, fecNac, dir, tel, cel, email, region, provincia, distrito, usuAut.getUsername(), fecReg);
            if (msg != "") {
                response.sendRedirect("home.jsp");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
