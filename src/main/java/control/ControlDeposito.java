package control;

import conexion.DaoCuenta;
import entidad.CuentasBancarias;
import entidad.Usuario;
import servicio.ServicioCuenta;
import java.io.IOException;
import java.net.URLEncoder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ControlDeposito", urlPatterns = {"/ControlDeposito"})
public class ControlDeposito extends HttpServlet {

    ServicioCuenta servicio = new ServicioCuenta();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "";
        }

        // Lógica de Búsqueda de Cuenta (Para llenar la tabla del JSP)
        if (request.getParameter("numCuenta") != null) {
            String numCuenta = request.getParameter("numCuenta");
            // Reutilizamos la conexión simple del DAO para lectura
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

        // Recuperar mensajes de redirección
        if (request.getParameter("msg") != null) {
            request.setAttribute("msg", request.getParameter("msg"));
        }
        if (request.getParameter("msgError") != null) {
            request.setAttribute("msgError", request.getParameter("msgError"));
        }

        request.getRequestDispatcher("operaciones/deposito.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        Usuario usu = (Usuario) request.getSession().getAttribute("usuAut");
        String codUsuario = (usu != null) ? usu.getCodUsuario() : "SYSTEM";

        if ("registrar".equals(accion)) {
            try {
                String numCuenta = request.getParameter("numCuenta");
                double monto = Double.parseDouble(request.getParameter("monto"));
                String medioPago = request.getParameter("medioPago");
                String origen = request.getParameter("origenFondos"); // Campo nuevo
                String obs = request.getParameter("descripcion");

                String resultado = servicio.realizarDeposito(numCuenta, monto, medioPago, origen, codUsuario, obs);

                String tipoMsg = resultado.startsWith("Error") ? "msgError" : "msg";
                response.sendRedirect("ControlDeposito?numCuenta=" + numCuenta + "&" + tipoMsg + "=" + URLEncoder.encode(resultado, "UTF-8"));

            } catch (Exception e) {
                response.sendRedirect("ControlDeposito?msgError=" + URLEncoder.encode("Error interno: " + e.getMessage(), "UTF-8"));
            }
        } else {
            doGet(request, response);
        }
    }
}
