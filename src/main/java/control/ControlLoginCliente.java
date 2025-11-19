package control;

import entidad.UsuarioCliente;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
                break;
            case "detalle":
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

    // --- MÉTODOS DE LÓGICA ---
    private void procesarLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String nomUsuario = request.getParameter("inpUsu");
        String psw = request.getParameter("inpPwd");

        Object[] datos = ServicioCliente.autenticarClienteWeb(nomUsuario, psw);

        if (datos != null) {
            HttpSession session = request.getSession(true);
            UsuarioCliente usu = new UsuarioCliente();

            // 1. Mapeo inteligente (Soluciona error de número vs string)
            try {
                usu.setCodUsuarioCliente(Integer.parseInt(datos[0].toString()));
                usu.setCodCliente(datos[1].toString());
                usu.setNomUsuario(datos[2].toString());
            } catch (NumberFormatException e) {
                usu.setCodCliente(datos[0].toString());
                usu.setNomUsuario(datos[1].toString());
            }

            // 2. Obtener nombre real
            String sqlNom = "SELECT nomCompleto FROM t_cliente WHERE codCliente = '" + usu.getCodCliente() + "'";
            Object[] datosCli = conexion.Acceso.buscar(sqlNom);
            String nombreReal = (datosCli != null) ? datosCli[0].toString() : usu.getNomUsuario();

            // 3. GUARDAR SESIÓN (CORRECCIÓN DE COMPATIBILIDAD)
            session.setAttribute("clienteAut", usu);   // Para el nuevo código
            session.setAttribute("cliAut", datos);     // Para tu Filtro antiguo (¡ESTO ARREGLA EL ERROR!)
            session.setAttribute("nombreClienteReal", nombreReal);

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

        // Cargar Cuentas
        java.util.List<entidad.CuentasBancarias> misCuentas = conexion.DaoCuenta.listarPorCliente(usu.getCodCliente());
        request.setAttribute("misCuentas", misCuentas);

        request.getRequestDispatcher("modulo-clientes/dashboard-cliente.jsp").forward(request, response);
    }

    private void verDetalleCuenta(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("--- DEBUG: INICIO verDetalleCuenta ---"); // DEBUG

        HttpSession session = request.getSession();
        UsuarioCliente usu = (UsuarioCliente) session.getAttribute("clienteAut");

        if (usu == null) {
            System.out.println("--- DEBUG: Usuario es NULL. Redirigiendo al login ---"); // DEBUG
            response.sendRedirect("modulo-clientes/login-clientes.jsp");
            return;
        }

        System.out.println("--- DEBUG: Usuario: " + usu.getCodCliente() + " ---"); // DEBUG

        // 1. Obtener todas las cuentas
        java.util.List<entidad.CuentasBancarias> misCuentas = conexion.DaoCuenta.listarPorCliente(usu.getCodCliente());
        System.out.println("--- DEBUG: Cuentas encontradas: " + (misCuentas != null ? misCuentas.size() : "NULL") + " ---"); // DEBUG

        request.setAttribute("misCuentas", misCuentas);

        // 2. Determinar qué cuenta mostrar
        String num = request.getParameter("num");
        System.out.println("--- DEBUG: Parametro 'num' recibido: " + num + " ---"); // DEBUG

        entidad.CuentasBancarias cuentaActual = null;

        if (misCuentas != null && !misCuentas.isEmpty()) {
            if (num == null || num.isEmpty()) {
                cuentaActual = misCuentas.get(0);
                System.out.println("--- DEBUG: Usando cuenta por defecto (la primera): " + cuentaActual.getNumCuenta() + " ---"); // DEBUG
            } else {
                for (entidad.CuentasBancarias c : misCuentas) {
                    if (c.getNumCuenta().equals(num)) {
                        cuentaActual = c;
                        break;
                    }
                }
                if (cuentaActual == null) {
                    System.out.println("--- DEBUG: No se encontró la cuenta solicitada en la lista del cliente ---"); // DEBUG
                    cuentaActual = misCuentas.get(0);
                }
            }

            System.out.println("--- DEBUG: Consultando detalle completo para: " + cuentaActual.getNumCuenta() + " ---"); // DEBUG
            cuentaActual = conexion.DaoCuenta.obtenerCuenta(cuentaActual.getNumCuenta(), conexion.Acceso.getConexion());

            if (cuentaActual == null) {
                System.out.println("--- DEBUG: ALERTA - DaoCuenta.obtenerCuenta devolvió NULL ---"); // DEBUG
            }
        } else {
            System.out.println("--- DEBUG: ALERTA - La lista 'misCuentas' está vacía ---"); // DEBUG
        }

        request.setAttribute("cuentaActual", cuentaActual);

        // 3. Cargar Movimientos
        if (cuentaActual != null) {
            System.out.println("--- DEBUG: Buscando movimientos... ---"); // DEBUG
            java.util.List<entidad.Movimiento> movs = conexion.DaoMovimiento.listarUltimosMovimientos(cuentaActual.getNumCuenta());
            System.out.println("--- DEBUG: Movimientos encontrados: " + (movs != null ? movs.size() : "NULL") + " ---"); // DEBUG
            request.setAttribute("movimientos", movs);
        }

        request.getRequestDispatcher("modulo-clientes/detalle-cuenta.jsp").forward(request, response);
        System.out.println("--- DEBUG: FIN verDetalleCuenta (Redirigiendo al JSP) ---"); // DEBUG
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
