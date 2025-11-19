package control;

import entidad.Embargo;
import conexion.DaoCuenta;
import conexion.DaoCliente;
import conexion.DaoParametros;
import servicio.ServicioCuenta;
import entidad.Usuario;
import entidad.CuentasBancarias;
import entidad.TipoCuenta;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.math.BigDecimal;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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
            case "detalle":
                obtenerDetalleCuentaJSON(request, response);
                break;
            case "consultar": // NUEVO CASO
                consultarCuentasCliente(request, response);
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
        } else if ("embargar".equals(accion)) {
            procesarEmbargo(request, response);
        } else if ("cambiarEstado".equals(accion)) {
            procesarCambioEstado(request, response);
        } else {
            doGet(request, response);
        }
    }

    // --- MÉTODOS DE LISTADO Y CARGA ---
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

    private void cargarFormularioApertura(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<TipoCuenta> tipos = DaoParametros.listarTiposCuenta();
        request.setAttribute("listaTipos", tipos);
        request.getRequestDispatcher("cuentas/apertura-cuentas.jsp").forward(request, response);
    }

    // --- MÉTODOS AJAX (JSON) ---
    private void buscarClientePorDoc(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String doc = request.getParameter("doc");
        Object[] datos = DaoCliente.buscarPorDocumento(doc);

        try (PrintWriter out = response.getWriter()) {
            if (datos != null) {
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

        if (numCuenta == null || numCuenta.isEmpty()) {
            response.getWriter().print("{}");
            return;
        }

        CuentasBancarias c = servicio.obtenerDetalle(numCuenta);

        try (PrintWriter out = response.getWriter()) {
            if (c != null) {
                // 1. OBTENER LISTA DE OBJETOS EMBARGO
                List<Embargo> embargos = servicio.listarEmbargos(numCuenta);

                // 2. BUSCAR SI EXISTE ALGUNO ACTIVO (S0001)
                Embargo embargoActivo = null;
                if (embargos != null) {
                    for (Embargo e : embargos) {
                        if ("S0001".equals(e.getCodEstado())) {
                            embargoActivo = e;
                            break; // Tomamos el primero activo que encontremos
                        }
                    }
                }

                boolean tieneEmbargo = (embargoActivo != null);

                StringBuilder json = new StringBuilder();
                json.append("{");
                json.append("\"exito\": true,");
                json.append("\"numCuenta\": \"").append(c.getNumCuenta()).append("\",");
                json.append("\"cliente\": \"").append(limpiarTexto(c.getCliente() != null ? c.getCliente().getNombre() : "Desconocido")).append("\",");
                json.append("\"doc\": \"").append(limpiarTexto(c.getCliente() != null ? c.getCliente().getNumDocumento() : "")).append("\",");
                json.append("\"tipo\": \"").append(limpiarTexto(c.getDesTipoCuenta())).append("\",");
                json.append("\"moneda\": \"").append(limpiarTexto(c.getDesMoneda())).append("\",");

                BigDecimal saldo = c.getSalAct() != null ? c.getSalAct() : BigDecimal.ZERO;
                json.append("\"saldo\": ").append(saldo).append(",");

                json.append("\"codEstado\": \"").append(c.getCodEstado()).append("\",");
                json.append("\"estado\": \"").append(limpiarTexto(c.getDesEstado())).append("\",");
                json.append("\"fecha\": \"").append(c.getFecApe()).append("\"");

                // 3. JSON DEL EMBARGO (USANDO GETTERS)
                if (tieneEmbargo) {
                    json.append(", \"embargo\": {");
                    json.append("\"activo\": true,");
                    json.append("\"monto\": \"").append(embargoActivo.getMonto()).append("\",");
                    json.append("\"expediente\": \"").append(limpiarTexto(embargoActivo.getExpediente())).append("\",");
                    json.append("\"motivo\": \"").append(limpiarTexto(embargoActivo.getDescripcion())).append("\"");
                    json.append("}");
                } else {
                    json.append(", \"embargo\": {\"activo\": false}");
                }
                json.append("}");

                out.print(json.toString());
            } else {
                out.print("{\"exito\": false}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("{\"exito\": false}");
        }
    }

    private String limpiarTexto(Object texto) {
        if (texto == null) {
            return "";
        }
        return texto.toString().replace("\"", "\\\"").replace("\n", " ");
    }

    // --- MÉTODOS TRANSACCIONALES (POST) ---
    private void abrirCuenta(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Usuario usuario = (Usuario) request.getSession().getAttribute("usuAut");
        String codUsuario = (usuario != null) ? usuario.getCodUsuario() : "SYSTEM";

        String codCliente = request.getParameter("codClienteHide");
        String tipo = request.getParameter("tipoCuenta");
        String moneda = request.getParameter("moneda");

        double saldo = 0.0;
        try {
            String saldoStr = request.getParameter("saldoApertura");
            if (saldoStr != null && !saldoStr.isEmpty()) {
                saldo = Double.parseDouble(saldoStr);
            }
        } catch (NumberFormatException e) {
        }

        double sobregiro = 0.0;
        try {
            String s = request.getParameter("sobregiro");
            if (s != null && !s.isEmpty()) {
                sobregiro = Double.parseDouble(s);
            }
        } catch (NumberFormatException e) {
        }

        int plazo = 0;
        double interes = 0.0;
        try {
            String p = request.getParameter("plazo");
            String i = request.getParameter("interes");
            if (p != null && !p.isEmpty()) {
                plazo = Integer.parseInt(p);
            }
            if (i != null && !i.isEmpty()) {
                interes = Double.parseDouble(i);
            }
        } catch (NumberFormatException e) {
        }

        String resultado = servicio.registrarCuenta(codCliente, tipo, moneda, saldo, plazo, interes, codUsuario);
        String tipoMsg = resultado.startsWith("Error") ? "danger" : "success";
        response.sendRedirect("ControlCuenta?accion=listar&msg=" + java.net.URLEncoder.encode(resultado, "UTF-8") + "&tipo=" + tipoMsg);
    }

    private void procesarEmbargo(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Usuario usuario = (Usuario) request.getSession().getAttribute("usuAut");
        String codUser = (usuario != null) ? usuario.getCodUsuario() : "SYSTEM";

        String numCuenta = request.getParameter("numCuentaEmbargo");
        String expediente = request.getParameter("expediente");
        String motivo = request.getParameter("motivo");
        double monto = 0.0;

        try {
            monto = Double.parseDouble(request.getParameter("monto"));
            if (monto <= 0) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("ControlCuenta?accion=listar&msg=" + java.net.URLEncoder.encode("Error: Monto inválido", "UTF-8"));
            return;
        }

        String res = servicio.ejecutarEmbargo(numCuenta, monto, expediente, motivo, codUser);
        response.sendRedirect("ControlCuenta?accion=listar&msg=" + java.net.URLEncoder.encode(res, "UTF-8"));
    }

    private void procesarCambioEstado(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String num = request.getParameter("numCuenta");
        String tipo = request.getParameter("tipo");
        String res = "";

        if ("cerrar".equals(tipo)) {
            res = servicio.cerrarCuenta(num);
        } else if ("inactivar".equals(tipo)) {
            res = servicio.inactivarCuenta(num);
        } else if ("activar".equals(tipo)) {
            res = servicio.activarCuenta(num);
        }

        response.sendRedirect("ControlCuenta?accion=listar&msg=" + java.net.URLEncoder.encode(res, "UTF-8"));
    }

    private void consultarCuentasCliente(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String doc = request.getParameter("numDoc");
        int page = 1;
        int limit = 10; // Registros por página

        try {
            if (request.getParameter("page") != null) {
                page = Integer.parseInt(request.getParameter("page"));
            }
        } catch (NumberFormatException e) {
            page = 1;
        }

        if (doc != null && !doc.isEmpty()) {
            // 1. Buscar datos del Cliente (Cabecera)
            Object[] datosCliente = DaoCliente.buscarPorDocumento(doc);

            if (datosCliente != null) {
                request.setAttribute("clienteNombre", datosCliente[1]); // Nombre
                request.setAttribute("clienteId", datosCliente[0]);     // ID Interno

                // 2. Paginación de Cuentas
                int offset = (page - 1) * limit;
                List<CuentasBancarias> lista = DaoCuenta.listarPorClientePaginado(doc, limit, offset);
                int totalRegistros = DaoCuenta.contarCuentasPorCliente(doc);
                int totalPaginas = (int) Math.ceil((double) totalRegistros / limit);

                request.setAttribute("listaCuentas", lista);
                request.setAttribute("totalRegistros", totalRegistros);
                request.setAttribute("currentPage", page);
                request.setAttribute("totalPages", totalPaginas);
            } else {
                request.setAttribute("msgError", "El cliente con documento " + doc + " no existe.");
            }
            request.setAttribute("numDocBusqueda", doc);
        }

        request.getRequestDispatcher("consultas/consulta-cuentas.jsp").forward(request, response);
    }
}
