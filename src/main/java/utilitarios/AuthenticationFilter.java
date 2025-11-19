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

        res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        res.setHeader("Pragma", "no-cache");
        res.setDateHeader("Expires", 0);

        String path = req.getRequestURI().substring(req.getContextPath().length());

        boolean isStaticResource = path.startsWith("/css") || path.startsWith("/js") || path.startsWith("/img");
        boolean isLoginEmpleado = path.equals("/login.jsp") || path.equals("/ControlLogin");

        // Agregamos ControlLoginCliente a la lista de "cosas de clientes"
        boolean isLoginCliente = path.contains("/modulo-clientes/") || path.contains("/ControlLoginCliente");

        boolean isSeleccionRol = path.equals("/selec-roles.jsp");

        HttpSession session = req.getSession(false);
        boolean isEmpleadoLogueado = (session != null && session.getAttribute("usuAut") != null);
        boolean isClienteLogueado = (session != null && session.getAttribute("clienteAut") != null);

        // A. Recursos públicos
        if (isStaticResource || isSeleccionRol) {
            chain.doFilter(request, response);
            return;
        }

        // B. PROTECCIÓN MÓDULO CLIENTES (Corregido)
        // Si la ruta empieza con /modulo-clientes O es el Controlador de Clientes
        if (path.startsWith("/modulo-clientes") || path.startsWith("/ControlLoginCliente")) {

            if (isClienteLogueado || isLoginCliente) {
                // Si ya entró o está intentando loguearse/registrarse -> Pase
                chain.doFilter(request, response);
            } else {
                // Si no tiene sesión y quiere entrar a algo privado -> Login Clientes
                res.sendRedirect(req.getContextPath() + "/modulo-clientes/login-clientes.jsp");
            }
            return;
        }

        // C. PROTECCIÓN MÓDULO EMPLEADOS (El resto)
        if (isEmpleadoLogueado || isLoginEmpleado) {
            chain.doFilter(request, response);
        } else {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
        }
    }

    @Override
    public void destroy() {
    }
}
