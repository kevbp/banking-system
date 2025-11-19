package control;

import conexion.DaoCuenta;
import conexion.DaoParametros;
import conexion.DaoTransaccion;
import entidad.CuentasBancarias;
import entidad.TipoCambio;
import entidad.UsuarioCliente;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ControlDepositoCliente", urlPatterns = {"/ControlDepositoCliente"})
public class ControlDepositoCliente extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "vista";
        }

        switch (accion) {
            case "vista":
                cargarVista(request, response);
                break;
            case "validar":
                validarDeposito(request, response);
                break;
            case "ejecutar":
                ejecutarDeposito(request, response);
                break;
            default:
                cargarVista(request, response);
        }
    }

    // --- PASO 1: CARGAR DATOS INICIALES (Soluciona el Dropdown vacío) ---
    private void cargarVista(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UsuarioCliente usu = (UsuarioCliente) request.getSession().getAttribute("clienteAut");
        if (usu == null) {
            response.sendRedirect("ControlLoginCliente");
            return;
        }

        // 1. Obtener Cuentas del Cliente para el Dropdown
        List<CuentasBancarias> cuentas = DaoCuenta.listarPorCliente(usu.getCodCliente());
        request.setAttribute("misCuentas", cuentas);

        // 2. Obtener Tipo de Cambio (Para validación JS)
        TipoCambio tc = DaoParametros.obtenerTipoCambioDia();
        if (tc == null) {
            tc = new TipoCambio();
            tc.setTasaVenta(3.80);
        } // Fallback
        request.setAttribute("tipoCambio", tc);

        request.getRequestDispatcher("modulo-clientes/operaciones/deposito.jsp").forward(request, response);
    }

    // --- PASO 2: VALIDAR DATOS Y REGLAS DE NEGOCIO ---
    private void validarDeposito(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String numCuenta = request.getParameter("cuentaDestino"); // Viene del Select o del Input Manual
            double monto = Double.parseDouble(request.getParameter("monto"));
            String origen = request.getParameter("origenFondos");

            if (monto <= 0) {
                throw new Exception("El monto debe ser mayor a 0.");
            }

            // Buscar la cuenta en BD (Sea propia o escrita a mano)
            // Si es deposito a terceros, validamos que la cuenta destino exista en el banco.
            java.sql.Connection cn = conexion.Acceso.getConexion();
            CuentasBancarias cuentaDestino = DaoCuenta.obtenerCuenta(numCuenta, cn);
            try {
                cn.close();
            } catch (Exception e) {
            }

            if (cuentaDestino == null) {
                throw new Exception("La cuenta de destino no existe en nuestros registros.");
            }

            // Regla de Negocio: Origen de Fondos (> S/ 2000 o eq. USD)
            TipoCambio tc = DaoParametros.obtenerTipoCambioDia();
            double tasaVenta = (tc != null) ? tc.getTasaVenta() : 3.80;
            boolean exigeOrigen = false;

            if ("USD".equals(cuentaDestino.getCodMoneda())) {
                if ((monto * tasaVenta) > 2000) {
                    exigeOrigen = true;
                }
            } else {
                if (monto > 2000) {
                    exigeOrigen = true;
                }
            }

            if (exigeOrigen && (origen == null || origen.trim().isEmpty())) {
                throw new Exception("Por normativa, debe declarar el origen de fondos.");
            }

            // Guardar en SESIÓN para el paso de Confirmación
            HttpSession session = request.getSession();
            session.setAttribute("dep_cuenta", cuentaDestino); // Guardamos objeto completo
            session.setAttribute("dep_monto", BigDecimal.valueOf(monto));
            session.setAttribute("dep_origen", origen);

            response.sendRedirect("modulo-clientes/operaciones/deposito-confirmar.jsp");

        } catch (Exception e) {
            request.setAttribute("msgError", e.getMessage());
            cargarVista(request, response); // Recargamos la vista con el error
        }
    }

    // --- PASO 3: EJECUTAR LA TRANSACCIÓN ---
    private void ejecutarDeposito(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        HttpSession session = request.getSession();
        CuentasBancarias c = (CuentasBancarias) session.getAttribute("dep_cuenta");
        BigDecimal monto = (BigDecimal) session.getAttribute("dep_monto");
        String origen = (String) session.getAttribute("dep_origen");

        // (El usuario 'u' ya no es necesario enviarlo al DAO en esta versión simplificada,
        //  porque el DAO usa 'CLIENTE' o el ID de sesión interno si lo prefieres, 
        //  pero para evitar errores de parámetros, lo quitamos de la llamada).
        if (c == null || monto == null) {
            response.sendRedirect("ControlDepositoCliente?accion=vista");
            return;
        }

        // --- CAMBIO AQUÍ ---
        // Usamos la nueva firma del método (solo 3 argumentos)
        String res = DaoTransaccion.realizarDeposito(c.getNumCuenta(), monto, origen);
        // -------------------

        if ("OK".equals(res)) {
            request.setAttribute("v_cuenta", c);
            request.setAttribute("v_monto", monto);
            request.setAttribute("v_origen", origen);

            session.removeAttribute("dep_cuenta");
            session.removeAttribute("dep_monto");
            session.removeAttribute("dep_origen");

            request.getRequestDispatcher("modulo-clientes/operaciones/deposito-exito.jsp").forward(request, response);
        } else {
            request.setAttribute("msgError", res);
            cargarVista(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        processRequest(req, resp);
    }
}
