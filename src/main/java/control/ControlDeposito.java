package control;

import java.io.IOException;
import java.math.BigDecimal;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import servicio.ServicioOperaciones; 
import entidad.Cuenta;
import conexion.Acceso;
import conexion.DaoCuenta;

@WebServlet("/ControlDeposito")
public class ControlDeposito extends HttpServlet {

    private final ServicioOperaciones servicio = new ServicioOperaciones();
    private static final String DESTINO_JSP = "/vistas/operaciones/depositos.jsp";

    // Maneja la búsqueda de la cuenta (GET)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String numCuenta = request.getParameter("numCuenta"); 
        
        if (numCuenta != null && !numCuenta.trim().isEmpty()) {
            Cuenta cuentaEncontrada = null;
            try (java.sql.Connection cn = Acceso.getConexion()) {
                if (cn != null) {
                    cuentaEncontrada = DaoCuenta.obtenerCuenta(numCuenta, cn); 
                }
            } catch (Exception e) {
                request.setAttribute("mensajeError", "Error al consultar la cuenta.");
            }
            
            if (cuentaEncontrada != null) {
                request.setAttribute("cuentaEncontrada", cuentaEncontrada);
            } else {
                request.setAttribute("mensajeError", "Cuenta " + numCuenta + " no encontrada o inactiva.");
            }
        }
        request.getRequestDispatcher(DESTINO_JSP).forward(request, response);
    }

    // Maneja el registro del depósito (POST)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String numCuenta = request.getParameter("numCuenta"); 
        String montoStr = request.getParameter("monto");
        String canal = request.getParameter("canal") == null ? "Ventanilla" : request.getParameter("canal"); 

        String codUsuarioOperador = (String) request.getSession().getAttribute("codUsuario");
        if (codUsuarioOperador == null) {
            codUsuarioOperador = "U0001"; // Default
        }
        
        BigDecimal monto;
        
        try {
            monto = new BigDecimal(montoStr);
        } catch (Exception e) {
            request.setAttribute("mensajeError", "❌ El monto ingresado no es un número válido.");
            request.getRequestDispatcher(DESTINO_JSP).forward(request, response);
            return;
        }
        
        String resultado = servicio.realizarDeposito(numCuenta, monto, codUsuarioOperador, canal);
        
        if ("OK".equals(resultado)) {
            request.setAttribute("mensajeExito", "✅ Depósito de $" + monto.toPlainString() + " realizado exitosamente a la cuenta " + numCuenta + ".");
        } else {
            request.setAttribute("mensajeError", "❌ Error al completar el depósito: " + resultado);
        }
        
        request.getRequestDispatcher(DESTINO_JSP).forward(request, response);
    }
}