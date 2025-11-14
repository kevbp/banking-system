
package control;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import servicio.ServicioCliente;

@WebServlet(name = "ControlHome", urlPatterns = {"/ControlHome"})
public class ControlHome extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 1. OBTENER DATOS DINÁMICOS
        // Obtener la cantidad de clientes de hoy
        int clientesHoy = ServicioCliente.contarClientesActivos();
        
        // 2. GUARDAR EN REQUEST SCOPE
        // Los datos se guardan en el Request, no en la Sesión, para que se actualicen siempre.
        request.setAttribute("clientesActivos", clientesHoy);
        
        // 3. HACER FORWARD A LA VISTA
        // Redirige internamente a la página JSP para mostrar los datos
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
