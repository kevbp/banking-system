package control;

import conexion.DaoParametros;
import entidad.*;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ControlParametros", urlPatterns = {"/ControlParametros"})
public class ControlParametros extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Cargar datos para las tablas
        List<Moneda> monedas = DaoParametros.listarMonedas();
        List<TipoCuenta> cuentas = DaoParametros.listarTiposCuenta();
        List<TipoMovimiento> movimientos = DaoParametros.listarTiposMovimiento();
        List<TipoCambio> tiposCambio = DaoParametros.listarUltimosTiposCambio();

        // Enviarlos a la vista
        request.setAttribute("listaMonedas", monedas);
        request.setAttribute("listaTiposCuenta", cuentas);
        request.setAttribute("listaMovimientos", movimientos);
        request.setAttribute("listaTiposCambio", tiposCambio);

        // Mantener pestaña activa si se recarga
        String activeTab = request.getParameter("tab");
        if (activeTab == null) {
            activeTab = "monedas";
        }
        request.setAttribute("activeTab", activeTab);

        request.getRequestDispatcher("Administracion/gestion-parametros.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        String tab = "monedas"; // Pestaña por defecto a la que volver

        try {
            if ("agregarMoneda".equals(accion)) {
                Moneda m = new Moneda();
                m.setCodMoneda(request.getParameter("codMoneda").toUpperCase());
                m.setDescMoneda(request.getParameter("descMoneda"));
                m.setSimbolo(request.getParameter("simbolo"));
                DaoParametros.gestionarMoneda(m, "agregar");
                tab = "monedas";
            } else if ("editarMoneda".equals(accion)) {
                Moneda m = new Moneda();
                m.setCodMoneda(request.getParameter("codMoneda"));
                m.setDescMoneda(request.getParameter("descMoneda"));
                m.setSimbolo(request.getParameter("simbolo"));
                DaoParametros.gestionarMoneda(m, "editar");
                tab = "monedas";
            } else if ("agregarTipoCuenta".equals(accion)) {
                TipoCuenta tc = new TipoCuenta();
                tc.setDescTipo(request.getParameter("descripcion"));
                tc.setCodMoneda(request.getParameter("moneda"));
                tc.setTasaInt(Double.parseDouble(request.getParameter("tasa")));

                // Capturar sobregiro (si viene vacío es 0)
                String sob = request.getParameter("sobregiro");
                tc.setLimSobregiro((sob != null && !sob.isEmpty()) ? Double.parseDouble(sob) : 0.0);

                DaoParametros.agregarTipoCuenta(tc);
                tab = "cuentas";

            } else if ("editarTipoCuenta".equals(accion)) {
                TipoCuenta tc = new TipoCuenta();
                tc.setCodTipCuenta(request.getParameter("id"));
                tc.setDescTipo(request.getParameter("descripcion"));
                tc.setCodMoneda(request.getParameter("moneda"));
                tc.setTasaInt(Double.parseDouble(request.getParameter("tasa")));
                String sob = request.getParameter("sobregiro");
                tc.setLimSobregiro((sob != null && !sob.isEmpty()) ? Double.parseDouble(sob) : 0.0);
                DaoParametros.editarTipoCuenta(tc);
                tab = "cuentas";
            } else if ("registrarTipoCambio".equals(accion) || "actualizarTipoCambio".equals(accion)) {
                // Nota: "Actualizar" en realidad inserta un nuevo registro histórico
                String mon = request.getParameter("codMoneda");
                double compra = Double.parseDouble(request.getParameter("tasaCompra"));
                double venta = Double.parseDouble(request.getParameter("tasaVenta"));
                DaoParametros.registrarTipoCambio(mon, compra, venta);
                tab = "monedas"; 
            } else if ("agregarTipoMovimiento".equals(accion)) {
                TipoMovimiento tm = new TipoMovimiento();
                tm.setDes(request.getParameter("descripcion"));
                tm.setSigno(request.getParameter("signo"));
                tm.setCodEstado(request.getParameter("estado").equals("Activo") ? "S0001" : "S0002");
                DaoParametros.agregarTipoMovimiento(tm);
                tab = "movimientos";
            } else if ("editarTipoMovimiento".equals(accion)) {
                TipoMovimiento tm = new TipoMovimiento();
                tm.setCodTipMovimiento(request.getParameter("id"));
                tm.setDes(request.getParameter("descripcion"));
                tm.setSigno(request.getParameter("signo"));
                tm.setCodEstado(request.getParameter("estado").equals("Activo") ? "S0001" : "S0002");
                DaoParametros.editarTipoMovimiento(tm);
                tab = "movimientos";
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("ControlParametros?tab=" + tab);
    }
}
