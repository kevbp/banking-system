package control;

import conexion.DaoCuenta;
import entidad.CuentasBancarias;
import entidad.Usuario;
import servicio.ServicioCuenta;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ControlRetiro", urlPatterns = {"/ControlRetiro"})
public class ControlRetiro extends HttpServlet {

    ServicioCuenta servicio = new ServicioCuenta();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lógica de Mensajes Flash (Sesión -> Request)
        HttpSession session = request.getSession();
        if (session.getAttribute("msg") != null) {
            request.setAttribute("msg", session.getAttribute("msg"));
            session.removeAttribute("msg");
        }
        if (session.getAttribute("msgError") != null) {
            request.setAttribute("msgError", session.getAttribute("msgError"));
            session.removeAttribute("msgError");
        }

        // Lógica de Búsqueda
        if (request.getParameter("numCuenta") != null) {
            String numCuenta = request.getParameter("numCuenta");
            java.sql.Connection cn = null;
            try {
                cn = conexion.Acceso.getConexion();
                CuentasBancarias cuenta = DaoCuenta.obtenerCuenta(numCuenta, cn);

                if (cuenta != null) {
                    request.setAttribute("cuenta", cuenta);
                } else {
                    request.setAttribute("msgError", "Cuenta no encontrada.");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (cn != null) {
                        cn.close();
                    }
                } catch (Exception e) {
                }
            }
            request.setAttribute("numCuentaBusqueda", numCuenta);
        }

        request.getRequestDispatcher("operaciones/retiro.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        Usuario usu = (Usuario) request.getSession().getAttribute("usuAut");
        String codUsuario = (usu != null) ? usu.getCodUsuario() : "SYSTEM";

        if ("procesar".equals(accion)) {
            try {
                String numCuenta = request.getParameter("numCuenta");
                double monto = Double.parseDouble(request.getParameter("monto"));
                String obs = request.getParameter("descripcion");

                // Llamada al servicio de RETIRO
                String resultado = servicio.realizarRetiro(numCuenta, monto, codUsuario, obs);

                HttpSession session = request.getSession();
                if (resultado.startsWith("Error")) {
                    session.setAttribute("msgError", resultado);
                } else {
                    session.setAttribute("msg", resultado);
                }

                // Redirigir para refrescar saldo y mostrar mensaje
                response.sendRedirect("ControlRetiro?numCuenta=" + numCuenta);

            } catch (Exception e) {
                request.getSession().setAttribute("msgError", "Error interno: " + e.getMessage());
                response.sendRedirect("ControlRetiro?numCuenta=" + request.getParameter("numCuenta"));
            }
        } else {
            doGet(request, response);
        }
    }
}
