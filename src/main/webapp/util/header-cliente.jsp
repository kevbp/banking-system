<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<script>
    window.APP_CONTEXT_PATH = "${pageContext.request.contextPath}";
    // Recuperamos el tiempo de sesión del servidor (si no existe, usa 600s por defecto)
    const SESSION_TIMEOUT_SECONDS = ${pageContext.session.maxInactiveInterval > 0 ? pageContext.session.maxInactiveInterval : 600};
</script>

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
    <div class="container-fluid px-4">

        <a class="navbar-brand" href="${pageContext.request.contextPath}/ControlLoginCliente?accion=dashboard">
            <img src="${pageContext.request.contextPath}/img/logoQB_colores.png" alt="Quantum Bank" height="40">
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarClienteContent">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarClienteContent">

            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link fw-medium" href="${pageContext.request.contextPath}/ControlLoginCliente?accion=dashboard">
                        Inicio
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link fw-medium" href="${pageContext.request.contextPath}/modulo-clientes/productos/apertura-cuenta.jsp">
                        Abrir Productos
                    </a>
                </li>
            </ul>

            <ul class="navbar-nav ms-auto align-items-center">

                <li class="nav-item me-3 d-none d-lg-block">
                    <small class="text-muted fw-bold me-1">Sesión:</small>
                    <span id="sessionTimer" class="badge bg-warning text-dark font-monospace">--:--</span>
                </li>

                <li class="nav-item me-2 mb-2 mb-lg-0">
                    <a href="${pageContext.request.contextPath}/modulo-clientes/operaciones/transferencia.jsp" class="btn btn-primary fw-semibold px-3">
                        <i class="bi bi-arrow-left-right me-1"></i> Transferir
                    </a>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="navbarDropdownUser" role="button" data-bs-toggle="dropdown">
                        <i class="bi bi-person-circle fs-4 me-2 text-secondary"></i>
                        <span class="fw-semibold text-dark">${sessionScope.nombreClienteReal}</span> 
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end border-0 shadow" aria-labelledby="navbarDropdownUser">
                        <li><span class="dropdown-header">Opciones</span></li>
                        <li><a class="dropdown-item" href="#">Mi Perfil</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger fw-bold" href="${pageContext.request.contextPath}/ControlLoginCliente?accion=logout">Cerrar Sesión</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="tc-banner">
    <div class="container-fluid px-4">
        <c:choose>
            <c:when test="${not empty tipoCambioDia}">
                <i class="bi bi-graph-up me-1"></i>
                <strong>T.C. Hoy:</strong> 
                Compra S/ <fmt:formatNumber value="${tipoCambioDia.compra}" minFractionDigits="3"/> | 
                Venta S/ <fmt:formatNumber value="${tipoCambioDia.venta}" minFractionDigits="3"/>
            </c:when>
            <c:otherwise>
                <i class="bi bi-exclamation-circle me-1 text-warning"></i>
                <strong class="text-warning">T.C. no configurado hoy (Operaciones limitadas)</strong>
            </c:otherwise>
        </c:choose>
    </div>
</div>