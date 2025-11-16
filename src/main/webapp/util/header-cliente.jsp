<%-- 
  Document   : header-cliente.jsp
  Ubicación  : /util/header-cliente.jsp
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script>
    window.APP_CONTEXT_PATH = "${pageContext.request.contextPath}";
</script>

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
    <div class="container-fluid px-4">

        <a class="navbar-brand" href="${pageContext.request.contextPath}/modulo-clientes/dashboard-cliente.jsp">
            <img src="${pageContext.request.contextPath}/img/logoQB_colores.png" alt="Quantum Bank" height="40">
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarClienteContent">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarClienteContent">

            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/modulo-clientes/dashboard-cliente.jsp" data-page-id="inicio">
                        Inicio
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/modulo-clientes/productos/apertura-cuenta.jsp" data-page-id="productos">
                        Abrir Productos
                    </a>
                </li>
            </ul>

            <ul class="navbar-nav ms-auto align-items-center">
                <li class="nav-item me-2 mb-2 mb-lg-0">
                    <a href="${pageContext.request.contextPath}/modulo-clientes/operaciones/transferencia.jsp" class="btn btn-primary fw-semibold px-3" data-page-id="transferir">
                        <i class="bi bi-arrow-left-right me-1"></i> Transferir
                    </a>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="navbarDropdownUser" role="button" data-bs-toggle="dropdown">
                        <i class="bi bi-person-circle fs-4 me-2"></i>
                        <span class="fw-semibold">Juan Pérez</span> 
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownUser">
                        <li><a class="dropdown-item" href="#">Mi Perfil</a></li>
                        <li><a class="dropdown-item" href="#">Seguridad</a></li>
                        <li><hr class="dropdown-divider"></li>

                        <c:url var="urlLogout" value="/ControlUsuario">
                            <c:param name="op" value="CerrarSesion"/>
                        </c:url>
                        <li><a class="dropdown-item" href="${urlLogout}">Cerrar Sesión</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>