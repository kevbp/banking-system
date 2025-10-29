
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

public class AuthenticationFilter implements Filter{
    // 1. Método init (opcional, para inicialización)
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        Filter.super.init(filterConfig);
        // Aquí puedes leer parámetros de configuración del web.xml, si los hay.
        System.out.println("Filtro de autenticación inicializado.");
    }
    // 2. Método doFilter (El corazón del filtro)
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain fc) throws IOException, ServletException {
        // Conversión a objetos HTTP para acceder a sesiones y redirecciones
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        
        // 1. **INYECCIÓN DE ENCABEZADOS DE NO-CACHÉ**
        // Esto obliga al navegador a revalidar la página con el servidor.
        res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        res.setHeader("Pragma", "no-cache"); // HTTP 1.0
        res.setDateHeader("Expires", 0); // Proxies

        // Rutas que no requieren login
        String loginURI = req.getContextPath() + "/login.jsp";
        String loginClienteURI = req.getContextPath() + "/clientes/login-clientes.jsp";
        String selectRoleURI = req.getContextPath() + "/selec-rol.jsp";

        // Obtener la sesión existente. 'false' NO crea una sesión si no existe/expiró.
        HttpSession session = req.getSession(false);
        
        // Asume que guardaste el nombre de usuario (o un objeto User) al hacer login
        boolean isLoggedIn = (session != null && session.getAttribute("usuAut") != null);
        System.out.println("ruta:"+req.getRequestURI());
        boolean isLoginRequest = req.getRequestURI().equals(loginURI)||req.getRequestURI().equals(loginClienteURI)||req.getRequestURI().endsWith(selectRoleURI);

        if (isLoggedIn || isLoginRequest) {
            // Si el usuario está logueado O está intentando acceder a la página de login,
            // permite el paso al siguiente recurso (Servlet/JSP).
            fc.doFilter(request, response);
        } else {
            // Si no está logueado, redirige a la página de login.
            String redirectURI = req.getContextPath() + "/selec-rol.jsp";
            res.sendRedirect(loginURI + "?auth=required");
            // Nota: Al no llamar a chain.doFilter(), el recurso original no se ejecuta.
        }
    }
    // 3. Método destroy (opcional, para limpieza)
    @Override
    public void destroy() {
        Filter.super.destroy(); 
        // Aquí se liberan recursos si fueron cargados en init().
        System.out.println("Filtro de autenticación destruido.");
    }
    
}
