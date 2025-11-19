package utilitarios;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        // 1. Evitar caché para que no puedan volver atrás tras logout
        res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        res.setHeader("Pragma", "no-cache");
        res.setDateHeader("Expires", 0);

        // 2. Definir rutas clave
        String path = req.getRequestURI().substring(req.getContextPath().length());

        // Rutas de Login y Recursos Públicos (CSS, JS, Imágenes)
        boolean isStaticResource = path.startsWith("/css") || path.startsWith("/js") || path.startsWith("/img");
        boolean isLoginEmpleado = path.equals("/login.jsp") || path.equals("/ControlLogin");
        boolean isLoginCliente = path.contains("/modulo-clientes/login-clientes.jsp") || path.contains("/ControlLoginCliente")
                || path.contains("/modulo-clientes/registro-clientes.jsp") || path.contains("/modulo-clientes/recuperar-contrasena.jsp");
        boolean isSeleccionRol = path.equals("/selec-roles.jsp");

        // 3. Obtener sesión (sin crear una nueva si no existe)
        HttpSession session = req.getSession(false);
        boolean isEmpleadoLogueado = (session != null && session.getAttribute("usuAut") != null);
        boolean isClienteLogueado = (session != null && session.getAttribute("clienteAut") != null);

        // 4. LÓGICA DE PROTECCIÓN DIFERENCIADA
        // A. Si pide recursos estáticos o selección de rol -> Dejar pasar
        if (isStaticResource || isSeleccionRol) {
            chain.doFilter(request, response);
            return;
        }

        // B. ¿Está intentando entrar al MÓDULO DE CLIENTES?
        if (path.startsWith("/modulo-clientes")) {
            if (isClienteLogueado || isLoginCliente) {
                // Tiene permiso o está intentando loguearse/registrarse como cliente
                chain.doFilter(request, response);
            } else {
                // No es cliente y quiere entrar -> Al Login de Clientes
                res.sendRedirect(req.getContextPath() + "/modulo-clientes/login-clientes.jsp");
            }
            return;
        }

        // C. Para el resto (MÓDULO EMPLEADOS/ADMIN)
        // Si es empleado logueado o está en el login de empleado -> Dejar pasar
        if (isEmpleadoLogueado || isLoginEmpleado) {
            chain.doFilter(request, response);
        } else {
            // No es empleado -> Al Login de Empleados
            res.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }

    @Override
    public void destroy() {
    }
}
