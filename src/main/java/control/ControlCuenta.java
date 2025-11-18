package control;

import conexion.DaoCuenta;
import conexion.DaoCliente;
import conexion.DaoParametros;
import servicio.ServicioCuenta;
import entidad.Usuario;
import entidad.Cuenta; // O CuentasBancarias si ya hiciste el cambio
import entidad.TipoCuenta;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson; // Recomendado, si no tienes GSON usaremos construcción manual de JSON
import entidad.CuentasBancarias;
import java.util.HashMap;
import java.util.Map;
import java.util.List; // Asegúrate de importar List
import java.math.BigDecimal; // Importar BigDecimal

@WebServlet(name = "ControlCuenta", urlPatterns = {"/ControlCuenta"})
public class ControlCuenta extends HttpServlet {

    ServicioCuenta servicio = new ServicioCuenta();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }

        switch (accion) {
            case "listar":
                listarCuentas(request, response);
                break;
            case "apertura":
                cargarFormularioApertura(request, response);
                break;
            case "buscarCliente":
                buscarClientePorDoc(request, response);
                break;
            // --- NUEVA ACCIÓN AJAX PARA EL MODAL ---
            case "detalle":
                obtenerDetalleCuentaJSON(request, response);
                break;
            default:
                response.sendRedirect("cuentas/gestion-cuentas.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        if ("abrir".equals(accion)) {
            abrirCuenta(request, response);
        } // --- NUEVAS ACCIONES ---
        else if ("embargar".equals(accion)) {
            procesarEmbargo(request, response);
        } else if ("cambiarEstado".equals(accion)) {
            procesarCambioEstado(request, response);
        } else {
            doGet(request, response);
        }
    }

    private void listarCuentas(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String numCuenta = request.getParameter("numCuenta");
        String docCliente = request.getParameter("numDoc");
        String tipo = request.getParameter("tipoCuenta");
        String estado = request.getParameter("estado");

        List<CuentasBancarias> lista = DaoCuenta.listarCuentas(numCuenta, docCliente, tipo, estado);
        request.setAttribute("listaCuentas", lista);
        request.getRequestDispatcher("cuentas/gestion-cuentas.jsp").forward(request, response);
    }

    private void abrirCuenta(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Usuario usuario = (Usuario) request.getSession().getAttribute("usuAut");
        String codUsuario = (usuario != null) ? usuario.getCodUsuario() : "SYSTEM";

        String codCliente = request.getParameter("codClienteHide");
        String tipo = request.getParameter("tipoCuenta");
        String moneda = request.getParameter("moneda");

        double saldo = 0.0;
        try {
            saldo = Double.parseDouble(request.getParameter("saldoApertura"));
        } catch (Exception e) {
        }

        int plazo = 0;
        double interes = 0.0;
        try {
            if (request.getParameter("plazo") != null && !request.getParameter("plazo").isEmpty()) {
                plazo = Integer.parseInt(request.getParameter("plazo"));
            }
            if (request.getParameter("interes") != null && !request.getParameter("interes").isEmpty()) {
                interes = Double.parseDouble(request.getParameter("interes"));
            }
        } catch (NumberFormatException e) {
        }

        String resultado = servicio.registrarCuenta(codCliente, tipo, moneda, saldo, plazo, interes, codUsuario);

        String tipoMsg = resultado.startsWith("Error") ? "danger" : "success";
        response.sendRedirect("cuentas/gestion-cuentas.jsp?msg=" + java.net.URLEncoder.encode(resultado, "UTF-8") + "&tipo=" + tipoMsg);
    }

    private void cargarFormularioApertura(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Cargar los productos disponibles para el <select>
        List<TipoCuenta> tipos = DaoParametros.listarTiposCuenta();
        request.setAttribute("listaTipos", tipos);
        request.getRequestDispatcher("cuentas/apertura-cuentas.jsp").forward(request, response);
    }

    private void buscarClientePorDoc(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String doc = request.getParameter("doc");
        Object[] datos = DaoCliente.buscarPorDocumento(doc);

        try (PrintWriter out = response.getWriter()) {
            if (datos != null) {
                // Construimos JSON manual simple: {"encontrado": true, "id": "...", "nombre": "..."}
                out.print("{\"encontrado\": true, \"id\": \"" + datos[0] + "\", \"nombre\": \"" + datos[1] + "\"}");
            } else {
                out.print("{\"encontrado\": false}");
            }
        }
    }

    private void obtenerDetalleCuentaJSON(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String numCuenta = request.getParameter("num");
        System.out.println("🔍 Solicitando detalle para cuenta: " + numCuenta); // Log de depuración

        if (numCuenta == null || numCuenta.isEmpty()) {
            response.getWriter().print("{}");
            return;
        }

        // Llamada al servicio
        CuentasBancarias c = servicio.obtenerDetalle(numCuenta);

        try (PrintWriter out = response.getWriter()) {
            if (c != null) {
                // Obtener embargos
                List<Object[]> embargos = servicio.listarEmbargos(numCuenta);
                boolean tieneEmbargo = (embargos != null && !embargos.isEmpty());

                // Construcción manual de JSON (Más robusta)
                StringBuilder json = new StringBuilder();
                json.append("{");
                json.append("\"exito\": true,");
                json.append("\"numCuenta\": \"").append(c.getNumCuenta()).append("\",");
                json.append("\"cliente\": \"").append(c.getCliente() != null ? c.getCliente().getNombre() : "Desconocido").append("\",");
                json.append("\"tipo\": \"").append(c.getDesTipoCuenta()).append("\",");
                json.append("\"moneda\": \"").append(c.getDesMoneda()).append("\",");
                json.append("\"saldo\": \"").append(c.getSalAct()).append("\",");
                json.append("\"estado\": \"").append(c.getDesEstado()).append("\",");
                json.append("\"fecha\": \"").append(c.getFecApe()).append("\"");

                // Agregar info de embargo si existe
                if (tieneEmbargo) {
                    Object[] ult = embargos.get(embargos.size() - 1);
                    json.append(", \"embargo\": {");
                    json.append("\"activo\": true,");
                    json.append("\"monto\": \"").append(ult[1]).append("\",");
                    json.append("\"expediente\": \"").append(ult[2]).append("\",");
                    json.append("\"motivo\": \"").append(ult[3]).append("\"");
                    json.append("}");
                } else {
                    json.append(", \"embargo\": {\"activo\": false}");
                }
                json.append("}");

                System.out.println("✅ JSON enviado correctamente.");
                out.print(json.toString());
            } else {
                System.err.println("❌ Error: La cuenta " + numCuenta + " devolvió NULL desde el Servicio/DAO.");
                out.print("{\"exito\": false, \"error\": \"Cuenta no encontrada\"}");
            }
        } catch (Exception e) {
            System.err.println("❌ Error generando JSON: " + e.getMessage());
            e.printStackTrace();
            response.getWriter().print("{\"exito\": false}");
        }
    }

    // Helper para evitar romper el JSON con comillas o saltos de línea
    private String limpiarTexto(Object texto) {
        if (texto == null) {
            return "";
        }
        return texto.toString().replace("\"", "\\\"").replace("\n", " ");
    }

    private void procesarEmbargo(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Usuario usuario = (Usuario) request.getSession().getAttribute("usuAut");
        String codUser = (usuario != null) ? usuario.getCodUsuario() : "SYSTEM";

        String numCuenta = request.getParameter("numCuentaEmbargo");
        String expediente = request.getParameter("expediente");
        String motivo = request.getParameter("motivo");
        double monto = Double.parseDouble(request.getParameter("monto"));

        String res = servicio.ejecutarEmbargo(numCuenta, monto, expediente, motivo, codUser);

        response.sendRedirect("ControlCuenta?accion=listar&msg=" + java.net.URLEncoder.encode(res, "UTF-8"));
    }

    private void procesarCambioEstado(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String numCuenta = request.getParameter("numCuenta");
        String tipo = request.getParameter("tipo"); // "cerrar" o "inactivar"

        String res = "";
        if ("cerrar".equals(tipo)) {
            res = servicio.cerrarCuenta(numCuenta);
        } else if ("inactivar".equals(tipo)) {
            res = servicio.inactivarCuenta(numCuenta);
        }

        response.sendRedirect("ControlCuenta?accion=listar&msg=" + java.net.URLEncoder.encode(res, "UTF-8"));
    }
}
