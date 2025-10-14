package control;

import entidad.Cuenta;
import conexion.Acceso;
import conexion.DaoCuenta;
import java.io.IOException;
import java.math.BigDecimal;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import servicio.ServicioOperaciones; 

@WebServlet("/ControlTransferencia")
public class ControlTransferencia extends HttpServlet {

    private final ServicioOperaciones servicio = new ServicioOperaciones();
    private static final String DESTINO_JSP = "/vistas/operaciones/transferencia.jsp";

    /**
     * Maneja la búsqueda de cuentas de origen (Modo GET).
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String numCuenta = request.getParameter("cuentaOrigen");
        
        if (numCuenta != null && !numCuenta.trim().isEmpty()) {
            Cuenta cuentaEncontrada = null;
            
            try (java.sql.Connection cn = Acceso.getConexion()) {
                if (cn != null) {
                    cuentaEncontrada = DaoCuenta.obtenerCuenta(numCuenta, cn); 
                }
            } catch (Exception e) {
                request.setAttribute("mensajeError", "Error interno al consultar la cuenta de origen.");
            }
            
            if (cuentaEncontrada != null) {
                request.setAttribute("cuentaOrigenEncontrada", cuentaEncontrada);
            } else {
                request.setAttribute("mensajeError", "Cuenta de origen " + numCuenta + " no encontrada o inactiva.");
            }
        }
        
        request.getRequestDispatcher(DESTINO_JSP).forward(request, response);
    }

    /**
     * Maneja el registro de la transferencia (Modo POST).
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        
        if ("registrar".equals(accion)) {
            
            String numCuentaOrigen = request.getParameter("cuentaOrigen"); 
            String numCuentaDestino = request.getParameter("cuentaDestino");
            String montoStr = request.getParameter("monto");
            String canal = request.getParameter("medio") == null ? "Web/JSP" : request.getParameter("medio"); 
            
            String codUsuarioOperador = (String) request.getSession().getAttribute("codUsuario");
            if (codUsuarioOperador == null) {
                codUsuarioOperador = "U0001";
            }
            
            BigDecimal monto;
            
            try {
                monto = new BigDecimal(montoStr);
            } catch (Exception e) {
                request.setAttribute("mensajeError", "❌ El monto ingresado no es un número válido.");
                request.getRequestDispatcher(DESTINO_JSP).forward(request, response);
                return;
            }
            
            String resultado = servicio.realizarTransferencia(
                numCuentaOrigen, 
                numCuentaDestino, 
                monto, 
                codUsuarioOperador, 
                canal
            );
            
            if ("OK".equals(resultado)) {
                request.setAttribute("mensajeExito", 
                    "✅ Transferencia de $" + monto.toPlainString() + " realizada exitosamente de " + numCuentaOrigen + " a " + numCuentaDestino + "."
                );
            } else {
                request.setAttribute("mensajeError", "❌ Error al completar la transferencia: " + resultado);
            }
            
            request.getRequestDispatcher(DESTINO_JSP).forward(request, response);
        } else {
             request.setAttribute("mensajeError", "Acción no reconocida.");
             request.getRequestDispatcher(DESTINO_JSP).forward(request, response);
        }
    }
}