<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script>
    window.APP_CONTEXT_PATH = "${pageContext.request.contextPath}";
</script>

<header class="header d-flex justify-content-between align-items-center px-4">

    <div id="header-countdown-wrapper" class="d-flex align-items-center gap-2 text-muted fw-semibold">
        <i class="bi bi-clock"></i>
        <span>
            <span id="session-header-countdown">60</span>s
        </span>
    </div>

    <div class="d-flex align-items-center gap-3">
        <span class="fw-medium text-dark">${sessionScope.usuAut.username}</span>
        
        <c:url var="urlLogout" value="/ControlUsuario">
            <c:param name="op" value="CerrarSesion"/>
        </c:url>
        
        <a href="${urlLogout}" class="btn btn-sm btn-outline-primary fw-semibold px-3">Cerrar sesión</a>
    </div>
    
    </header>