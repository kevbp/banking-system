<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script>
    window.APP_CONTEXT_PATH = "${pageContext.request.contextPath}";
</script>

<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
    <div class="container-fluid px-4">

        <a class="navbar-brand" href="${pageContext.request.contextPath}/cliente/dashboard-cliente.jsp">
            <img src="${pageContext.request.contextPath}/img/logoQB_colores.png" alt="Quantum Bank" height="40">
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarClienteContent" aria-controls="navbarClienteContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarClienteContent">

            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/cliente/dashboard-cliente.jsp" data-page-id="cuentas">
                        Mis Cuentas
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-page-id="productos">
                        Abrir Productos
                    </a>
                </li>
            </ul>

            <ul class="navbar-nav ms-auto align-items-center">

                <li class="nav-item me-2 mb-2 mb-lg-0">
                    <a href="#" class="btn btn-primary fw-semibold px-3">
                        <i class="bi bi-arrow-left-right me-1"></i> Transferir
                    </a>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="navbarDropdownUser" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-person-circle fs-4 me-2"></i>
                        <span class="fw-semibold">${sessionScope.usuAut.username}</span> 
                        <%-- Asumo que el objeto de sesión del cliente también se llama 'usuAut' --%>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownUser">
                        <li><a class="dropdown-item" href="#">Mi Perfil</a></li>
                        <li><a class="dropdown-item" href="#">Seguridad</a></li>
                        <li><hr class="dropdown-divider"></li>

                        <li><a class="dropdown-item" href="#">Cerrar Sesión</a></li>
                    </ul>
                </li>
            </ul>

        </div>
    </div>
</nav>