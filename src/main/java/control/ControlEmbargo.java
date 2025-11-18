package control;

import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import conexion.DaoCuenta;
import conexion.DaoEmbargo;
import entidad.CuentasBancarias;
import entidad.Embargo;
import entidad.Usuario;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ControlEmbargo", urlPatterns = {"/ControlEmbargo"})
public class ControlEmbargo extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "vista";
        }

        if ("buscar".equals(accion)) {
            String numCuenta = request.getParameter("numCuenta");

            // 1. Buscar Cuenta
            CuentasBancarias cuenta = DaoCuenta.obtenerCuenta(numCuenta, conexion.Acceso.getConexion());
            // Nota: Asegúrate de que DaoCuenta tenga un método estático o instanciado que maneje la conexión correctamente.
            // Si DaoCuenta.obtenerCuenta requiere conexión externa, úsalo así. Si abre su propia conexión, retira el parámetro.

            if (cuenta != null) {
                // 2. Listar Embargos
                List<Embargo> lista = DaoEmbargo.listarEmbargos(numCuenta);
                request.setAttribute("cuenta", cuenta);
                request.setAttribute("listaEmbargos", lista);
            } else {
                request.setAttribute("msg", "Cuenta no encontrada.");
            }
            request.setAttribute("numCuentaBusqueda", numCuenta);
        }

        request.getRequestDispatcher("cuentas/gestion-embargos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        Usuario usu = (Usuario) request.getSession().getAttribute("usuAut");
        String codUsuario = (usu != null) ? usu.getCodUsuario() : "SYSTEM";

        if ("registrar".equals(accion)) {
            try {
                Embargo e = new Embargo();
                e.setNumCuenta(request.getParameter("numCuenta"));
                // Conversión segura a BigDecimal
                e.setMonto(new BigDecimal(request.getParameter("montoEmbargo")));
                e.setDescripcion(request.getParameter("descripcion"));
                e.setExpediente(request.getParameter("expediente"));
                e.setCodUsuCre(codUsuario);

                String res = DaoEmbargo.registrarEmbargo(e);
                String mensajeCodificado = URLEncoder.encode(res, StandardCharsets.UTF_8);
                response.sendRedirect("ControlEmbargo?accion=buscar&numCuenta=" + e.getNumCuenta() + "&msg=" + res);
            } catch (Exception ex) {
                response.sendRedirect("ControlEmbargo?msg=Error en datos numéricos");
            }

        } else if ("actualizar".equals(accion)) { // Acción para Levantar Embargo
            String codEmbargo = request.getParameter("codEmbargo");
            String numCuenta = request.getParameter("numCuentaHidden");
            String estado = request.getParameter("estado"); // Esperamos 'LEVANTADO'

            if ("LEVANTADO".equals(estado)) {
                BigDecimal montLib = new BigDecimal(request.getParameter("monto")); // El monto original se libera
                DaoEmbargo.levantarEmbargo(codEmbargo, montLib, numCuenta);
            }

            response.sendRedirect("ControlEmbargo?accion=buscar&numCuenta=" + numCuenta);
        }
    }
}
