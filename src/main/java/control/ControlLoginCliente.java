package control;

import conexion.DaoCuenta;
import entidad.CuentasBancarias;
import entidad.UsuarioCliente;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import servicio.ServicioCliente;

@WebServlet(name = "ControlLoginCliente", urlPatterns = {"/ControlLoginCliente"})
public class ControlLoginCliente extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "";
        }

        switch (accion) {
            case "dashboard":
                mostrarDashboard(request, response);
            case "detalle":  // NUEVO CASO
                verDetalleCuenta(request, response);
                break;
            case "logout":
                request.getSession().invalidate();
                response.sendRedirect("modulo-clientes/login-clientes.jsp");
                break;
            default:
                response.sendRedirect("modulo-clientes/login-clientes.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String accion = request.getParameter("accion");

        if (accion == null) {
            response.sendRedirect("modulo-clientes/login-clientes.jsp");
            return;
        }

        switch (accion) {
            case "registrar":
                procesarRegistro(request, response);
                break;
            case "recuperar":
                procesarRecuperacion(request, response);
                break;
            case "login":
                procesarLogin(request, response);
                break;
            default:
                response.sendRedirect("modulo-clientes/login-clientes.jsp");
                break;
        }
    }

    private void verDetalleCuenta(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UsuarioCliente usu = (UsuarioCliente) session.getAttribute("clienteAut");

        if (usu == null) {
            response.sendRedirect("ControlLoginCliente");
            return;
        }

        // 1. Obtener todas las cuentas del cliente (Para el Dropdown)
        List<CuentasBancarias> misCuentas = DaoCuenta.listarPorCliente(usu.getCodCliente());
        request.setAttribute("misCuentas", misCuentas);

        // 2. Determinar qué cuenta mostrar
        String numCuentaSeleccionada = request.getParameter("num");
        CuentasBancarias cuentaActual = null;

        if (misCuentas != null && !misCuentas.isEmpty()) {
            if (numCuentaSeleccionada == null || numCuentaSeleccionada.isEmpty()) {
                // Por defecto la primera
                cuentaActual = misCuentas.get(0);
            } else {
                // Buscar la seleccionada en la lista (Seguridad: evita ver cuentas de otros)
                for (CuentasBancarias c : misCuentas) {
                    if (c.getNumCuenta().equals(numCuentaSeleccionada)) {
                        cuentaActual = c;
                        break;
                    }
                }
                // Si no la encontró (ej: manipuló URL), volvemos a la primera
                if (cuentaActual == null) {
                    cuentaActual = misCuentas.get(0);
                }
            }

            // Si es necesario obtener más detalles que no vienen en la lista (ej: CCI, fecha apertura completa)
            // podemos hacer una consulta extra, o usar lo que ya tenemos en listarPorCliente.
            // Para estar seguros de tener todo (incluyendo sobregiro si es corriente), llamamos a obtenerCuenta:
            cuentaActual = DaoCuenta.obtenerCuenta(cuentaActual.getNumCuenta(), conexion.Acceso.getConexion());
        }

        request.setAttribute("cuentaActual", cuentaActual);

        // 3. Cargar Movimientos de esa cuenta
        if (cuentaActual != null) {
            List<entidad.Movimiento> movimientos = conexion.DaoMovimiento.listarUltimosMovimientos(cuentaActual.getNumCuenta());
            request.setAttribute("movimientos", movimientos);
        }

        request.getRequestDispatcher("modulo-clientes/detalle-cuenta.jsp").forward(request, response);
    }

    // --- MÉTODOS DE PROCESAMIENTO ---
    private void procesarLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nomUsuario = request.getParameter("inpUsu");
        String psw = request.getParameter("inpPwd");

        // 1. Autenticar
        Object[] datos = ServicioCliente.autenticarClienteWeb(nomUsuario, psw);

        if (datos != null) {
            HttpSession session = request.getSession(true);
            UsuarioCliente usu = new UsuarioCliente();

            // --- CORRECCIÓN DE MAPEO: DETECCIÓN DE TIPO DE DATO ---
            // Esto soluciona el error "For input string: C0001"
            try {
                // Intento 1: El orden estándar (ID, Codigo, Nombre...)
                usu.setCodUsuarioCliente(Integer.parseInt(datos[0].toString()));
                usu.setCodCliente(datos[1].toString());
                usu.setNomUsuario(datos[2].toString());
            } catch (NumberFormatException e) {
                // Intento 2: Si falla, es porque datos[0] es el Código de Cliente (String)
                // Esto ocurre si tu consulta SQL devuelve primero el código "C..."
                usu.setCodCliente(datos[0].toString());
                usu.setNomUsuario(datos[1].toString());
                // El ID numérico lo dejamos en 0 o lo buscamos si está en otra posición, 
                // pero para la sesión lo vital es el codCliente.
            }
            // -------------------------------------------------------

            // 2. Obtener Nombre Real del Cliente (Para el saludo)
            String sqlNom = "SELECT nomCompleto FROM t_cliente WHERE codCliente = '" + usu.getCodCliente() + "'";
            Object[] datosCli = conexion.Acceso.buscar(sqlNom);
            String nombreReal = (datosCli != null) ? datosCli[0].toString() : usu.getNomUsuario();

            // 3. Guardar en sesión
            session.setAttribute("clienteAut", usu);
            session.setAttribute("nombreClienteReal", nombreReal);

            // 4. Redirigir al Dashboard
            response.sendRedirect("ControlLoginCliente?accion=dashboard");

        } else {
            request.setAttribute("mensaje", "Credenciales incorrectas o usuario bloqueado.");
            request.getRequestDispatcher("modulo-clientes/login-clientes.jsp").forward(request, response);
        }
    }

    private void mostrarDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UsuarioCliente usu = (UsuarioCliente) session.getAttribute("clienteAut");

        if (usu == null) {
            response.sendRedirect("ControlLoginCliente");
            return;
        }

        // Cargar Cuentas Reales
        java.util.List<entidad.CuentasBancarias> misCuentas = conexion.DaoCuenta.listarPorCliente(usu.getCodCliente());
        request.setAttribute("misCuentas", misCuentas);

        request.getRequestDispatcher("modulo-clientes/dashboard-cliente.jsp").forward(request, response);
    }

    private void procesarRegistro(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String dni = request.getParameter("inpDni");
        String pwdConf = request.getParameter("inpPwdConf");
        String urlDestino = "modulo-clientes/registro-clientes.jsp";

        if (!request.getParameter("inpPwd").equals(pwdConf)) {
            request.setAttribute("mensaje", "Las contraseñas no coinciden.");
            request.getRequestDispatcher(urlDestino).forward(request, response);
            return;
        }

        UsuarioCliente uc = new UsuarioCliente();
        uc.setNomUsuario(request.getParameter("inpUsu"));
        uc.setClaveWeb(request.getParameter("inpPwd"));
        uc.setPalabraRecuperacion(request.getParameter("inpPalRec"));

        String error = ServicioCliente.registrarAccesoWeb(dni, uc);

        if (error == null) {
            response.sendRedirect("modulo-clientes/login-clientes.jsp?registro=exito");
        } else {
            request.setAttribute("mensaje", error);
            request.getRequestDispatcher(urlDestino).forward(request, response);
        }
    }

    private void procesarRecuperacion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String urlDestino = "modulo-clientes/recuperar-contrasena.jsp";
        String dni = request.getParameter("inpDNI");
        String actionStep = request.getParameter("actionStep");
        String palabraClave = request.getParameter("inpClave");
        String nuevaClave = request.getParameter("inpNuevaPwd");
        String confirmarClave = request.getParameter("inpConfirmarPwd");

        UsuarioCliente uc = new UsuarioCliente();
        String mensajeResultado = null;

        if ("verificar".equalsIgnoreCase(actionStep)) {
            uc.setPalabraRecuperacion(palabraClave);
            mensajeResultado = ServicioCliente.recuperarContrasenaWeb("verificar", dni, uc);

            if (mensajeResultado == null) {
                request.setAttribute("showNewPasswordForm", true);
                request.setAttribute("inpDNI", dni);
            } else {
                request.setAttribute("mensaje", mensajeResultado);
            }
            request.getRequestDispatcher(urlDestino).forward(request, response);

        } else if ("recuperar".equalsIgnoreCase(actionStep)) {
            if (nuevaClave == null || !nuevaClave.equals(confirmarClave)) {
                request.setAttribute("mensaje", "La nueva contraseña y su confirmación no coinciden.");
                request.setAttribute("showNewPasswordForm", true);
                request.setAttribute("inpDNI", dni);
                request.getRequestDispatcher(urlDestino).forward(request, response);
                return;
            }

            uc.setClaveWeb(nuevaClave);
            mensajeResultado = ServicioCliente.recuperarContrasenaWeb("recuperar", dni, uc);

            if (mensajeResultado == null) {
                response.sendRedirect("modulo-clientes/login-clientes.jsp?recuperacion=exito");
            } else {
                request.setAttribute("mensaje", mensajeResultado);
                request.setAttribute("showNewPasswordForm", true);
                request.setAttribute("inpDNI", dni);
                request.getRequestDispatcher(urlDestino).forward(request, response);
            }
        }
    }
}
