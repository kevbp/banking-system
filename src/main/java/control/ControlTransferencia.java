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

@WebServlet(name = "ControlTransferencia", urlPatterns = {"/ControlTransferencia"})
public class ControlTransferencia extends HttpServlet {

    ServicioCuenta servicio = new ServicioCuenta();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Mensajes Flash
        HttpSession session = request.getSession();
        if (session.getAttribute("msg") != null) {
            request.setAttribute("msg", session.getAttribute("msg"));
            session.removeAttribute("msg");
        }
        if (session.getAttribute("msgError") != null) {
            request.setAttribute("msgError", session.getAttribute("msgError"));
            session.removeAttribute("msgError");
        }

        request.getRequestDispatcher("operaciones/transferencia.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        // Búsqueda de Cuentas (Origen o Destino)
        if ("buscarOrigen".equals(accion) || "buscarDestino".equals(accion)) {
            String num = request.getParameter("numCuenta");
            try (java.sql.Connection cn = conexion.Acceso.getConexion()) {
                CuentasBancarias c = DaoCuenta.obtenerCuenta(num, cn);
                if (c != null) {
                    if ("buscarOrigen".equals(accion)) {
                        request.getSession().setAttribute("ctaOrigen", c);
                    } else {
                        request.getSession().setAttribute("ctaDestino", c);
                    }
                } else {
                    request.setAttribute("msgError", "Cuenta no encontrada.");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            request.getRequestDispatcher("operaciones/transferencia.jsp").forward(request, response);
            return;
        }

        // Limpiar selección
        if ("limpiar".equals(accion)) {
            request.getSession().removeAttribute("ctaOrigen");
            request.getSession().removeAttribute("ctaDestino");
            response.sendRedirect("ControlTransferencia");
            return;
        }

        // Procesar Transferencia
        if ("procesar".equals(accion)) {
            Usuario usu = (Usuario) request.getSession().getAttribute("usuAut");
            String codUser = (usu != null) ? usu.getCodUsuario() : "SYSTEM";

            String origen = request.getParameter("numOrigen");
            String destino = request.getParameter("numDestino");
            double monto = Double.parseDouble(request.getParameter("monto"));
            String obs = request.getParameter("descripcion");

            String res = servicio.realizarTransferencia(origen, destino, monto, codUser, obs);

            if (res.startsWith("Error")) {
                request.getSession().setAttribute("msgError", res);
            } else {
                request.getSession().setAttribute("msg", res);
                // Limpiar sesión al finalizar éxito
                request.getSession().removeAttribute("ctaOrigen");
                request.getSession().removeAttribute("ctaDestino");
            }
            response.sendRedirect("ControlTransferencia");
        }
    }
}
