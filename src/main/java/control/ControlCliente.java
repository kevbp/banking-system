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
        request.setCharacterEncoding("UTF-8");
        
        String op = request.getParameter("op");
        System.out.println("Mensaje de get srvlet: " + op);
        
        //Llamada al dropdown
        List<String> region = ServicioUtilitarios.listarRegion();
        request.getSession().setAttribute("region", region);

        switch (op) {
            case "ListaClientes":
                List lista = ServicioCliente.listarClientes("", "", "");
                if (lista != null) {
                    request.setAttribute("lista", lista);
                }
                request.getRequestDispatcher("clientes/consulta-clientes.jsp").forward(request, response);
                break;
            case "Editar":
                String id = request.getParameter("id");
                Object[] r = ServicioCliente.buscarCliente(id);
                break;
            case "RegistrarCliente":                
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
        } else if(accion.equalsIgnoreCase("Actualizar")){
            String idCliente = request.getParameter("idCliente");
            String fechaNacimiento = request.getParameter("fechaNacimiento");
            String direccion = request.getParameter("direccion");
            String telefono = request.getParameter("telefono");
            String celular = request.getParameter("celular");
            String correo = request.getParameter("correo");
            String estado = request.getParameter("estado");
            String region = request.getParameter("region");
            String provincia = request.getParameter("provincia");
            String distrito = request.getParameter("distrito");            
            LocalDateTime hoy = LocalDateTime.now();   
            String msg = ServicioCliente.actualizarCliente(idCliente, fechaNacimiento, direccion, telefono, celular, correo, estado, region, provincia, distrito, usuAut.getCodUsuario(), hoy.toString());
            request.getRequestDispatcher("clientes/consulta-clientes.jsp").forward(request, response);
        } else if(accion.equalsIgnoreCase("Desactivar")){
            String c = request.getParameter("idClienteDesactivar");
            String msg = ServicioCliente.inactivarCliente(c);
            request.getRequestDispatcher("clientes/consulta-clientes.jsp").forward(request, response);
        } else if(accion.equalsIgnoreCase("Detalle")){
            String id = request.getParameter("id"); 
            // Usa tu servicio existente que retorna Object[]
            Object[] r = ServicioCliente.buscarCliente(id);
            if (r == null) {
                request.setAttribute("error", "Cliente no encontrado");
                request.getRequestDispatcher("clientes/consulta-clientes.jsp").forward(request, response);
                return;
            }
            List estUsu = ServicioUtilitarios.listarEstadoUsuario();
            request.setAttribute("estUsu", estUsu);
            request.setAttribute("abrirModalEditar", "1");
            request.setAttribute("cliente", r);
            request.getRequestDispatcher("clientes/consulta-clientes.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
