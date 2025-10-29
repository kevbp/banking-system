package control;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import servicio.ServicioCliente;
import entidad.Usuario;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;
import servicio.ServicioUtilitarios;

@WebServlet(name = "ControlCliente", urlPatterns = {"/ControlCliente"})
public class ControlCliente extends HttpServlet {

    String tipoDocumento = "";
    String nroDocumento = "";
    String codigo = "";

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
                List lista = ServicioCliente.listarClientes("", "", "");
                if (lista != null) {
                    request.setAttribute("lista", lista);
                }
                request.getRequestDispatcher("clientes/consulta-clientes.jsp").forward(request, response);
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
                
                codigo = ServicioCliente.nuevoCodigo();
                request.setAttribute("codigo", codigo);
                request.getRequestDispatcher("clientes/registrar-cliente.jsp").forward(request, response);
                //response.sendRedirect(request.getContextPath() + "/clientes/registrar-cliente.jsp");
                break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        tipoDocumento = request.getParameter("tipoDoc");
        nroDocumento = request.getParameter("numDoc");
        String accion = request.getParameter("accion");
        
        HttpSession session = request.getSession(false); // false para no crear una nueva sesión si no existe
        Usuario usuAut = (Usuario) session.getAttribute("usuAut");

        if (accion.startsWith("Consultar")) {
            String nombre = request.getParameter("nombre");

            List lista = ServicioCliente.listarClientes(tipoDocumento, nroDocumento, nombre);
            if (lista != null) {
                request.setAttribute("lista", lista);
            }
            request.getRequestDispatcher("clientes/consulta-clientes.jsp").forward(request, response);
        } else if (accion.startsWith("Registrar")) {            
            String codigo = request.getParameter("codCliente");
            String nombre = request.getParameter("nom");
            String tipoDoc = request.getParameter("tipoDoc");
            String nroDoc = request.getParameter("nroDoc");
            String fecNac = request.getParameter("fecNac");
            String dir = request.getParameter("dir");
            String tel = request.getParameter("tel");
            String cel = request.getParameter("cel");
            String email = request.getParameter("email");
            String region = request.getParameter("region");
            String provincia = request.getParameter("provincia");
            String distrito = request.getParameter("distrito");            
            LocalDateTime hoy = LocalDateTime.now();
            
            String msg = ServicioCliente.crearCliente(codigo, nombre, tipoDoc, nroDoc, fecNac, dir, tel, cel, email, region, provincia, distrito, usuAut.getCodUsuario(), hoy.toString());
            if (msg != "") {
                List lista = ServicioCliente.listarClientes(tipoDocumento, nroDocumento, nombre);
                if (lista != null) {
                    request.setAttribute("lista", lista);
                }
                response.sendRedirect("clientes/consulta-clientes.jsp");
            }
        } else if (accion.equalsIgnoreCase("Reniec")){
            Object[] clienteReniec = ServicioCliente.validacionReniec(tipoDocumento, nroDocumento);
            request.setAttribute("cliente", clienteReniec);
            request.setAttribute("tipoDoc", tipoDocumento);
            request.setAttribute("codigo", codigo);
            request.getRequestDispatcher("clientes/registrar-cliente.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
