<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="sidebar d-flex flex-column flex-shrink-0">
    
    <a href="${pageContext.request.contextPath}/home.jsp" 
       class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
        <img src="${pageContext.request.contextPath}/img/logoQB.png" alt="Quantum Bank" height="70" class="me-2">
    </a>
    <hr class="text-white opacity-50">
    
    <!-- Menú principal -->
    <ul class="nav nav-pills flex-column mb-auto">

        <!-- INICIO -->
        <li class="nav-item mb-1">
            <a href="${pageContext.request.contextPath}/home.jsp" class="nav-link nav-root">
                <i class="bi bi-house-door me-2"></i> Inicio
            </a>
        </li>

        <!-- CLIENTES -->
        <li class="mb-1">
            <button class="btn btn-toggle nav-root" data-bs-toggle="collapse" data-bs-target="#clientes-collapse" aria-expanded="false">
                <i class="bi bi-people me-2"></i> Clientes
            </button>
            <div class="collapse nav-section" id="clientes-collapse">
                <ul class="nav-sub list-unstyled">
                    <c:url var="urlListarCliente" value="/ControlCliente"><c:param name="op" value="ListaClientes"/></c:url>
                    <li><a class="nav-sub-link" href="${urlListarCliente}">Consulta de clientes</a></li>

                    <c:url var="urlRegistroCliente" value="/ControlCliente"><c:param name="op" value="RegistrarCliente"/></c:url>
                    <li><a class="nav-sub-link" href="${urlRegistroCliente}">Registro de clientes</a></li>
                </ul>
            </div>
        </li>

        <!-- CUENTAS -->
        <li class="mb-1">
            <button class="btn btn-toggle nav-root" data-bs-toggle="collapse" data-bs-target="#cuentas-collapse" aria-expanded="false">
                <i class="bi bi-credit-card me-2"></i> Cuentas
            </button>
            <div class="collapse nav-section" id="cuentas-collapse">
                <ul class="nav-sub list-unstyled">
                    <li><a class="nav-sub-link" href="${pageContext.request.contextPath}/cuentas/apertura-cuentas.jsp">Apertura de cuentas</a></li>
                    <li><a class="nav-sub-link" href="${pageContext.request.contextPath}/cuentas/gestion-cuentas.jsp">Gestión de cuentas</a></li>
                    <li><a class="nav-sub-link" href="${pageContext.request.contextPath}/cuentas/gestion-embargos.jsp">Gestión de embargos</a></li>
                </ul>
            </div>
        </li>

        <!-- OPERACIONES -->
        <li class="mb-1">
            <button class="btn btn-toggle nav-root" data-bs-toggle="collapse" data-bs-target="#operaciones-collapse" aria-expanded="false">
                <i class="bi bi-cash-coin me-2"></i> Operaciones
            </button>
            <div class="collapse nav-section" id="operaciones-collapse">
                <ul class="nav-sub list-unstyled">
                    <li><a class="nav-sub-link" href="${pageContext.request.contextPath}/operaciones/deposito.jsp">Depósitos</a></li>
                    <li><a class="nav-sub-link" href="${pageContext.request.contextPath}/operaciones/retiro.jsp">Retiros</a></li>
                    <li><a class="nav-sub-link" href="${pageContext.request.contextPath}/operaciones/transferencia.jsp">Transferencias</a></li>
                </ul>
            </div>
        </li>

        <!-- CONSULTAS -->
        <li class="mb-1">
            <button class="btn btn-toggle nav-root" data-bs-toggle="collapse" data-bs-target="#consultas-collapse" aria-expanded="false">
                <i class="bi bi-search me-2"></i> Consultas
            </button>
            <div class="collapse nav-section" id="consultas-collapse">
                <ul class="nav-sub list-unstyled">
                    <li><a class="nav-sub-link" href="${pageContext.request.contextPath}/consultas/consulta-cuentas.jsp">Cuentas</a></li>
                    <li><a class="nav-sub-link" href="${pageContext.request.contextPath}/consultas/consulta-movimientos.jsp">Movimientos</a></li>
                    <li><a class="nav-sub-link" href="${pageContext.request.contextPath}/consultas/consulta-estado-cuenta.jsp">Estados de cuenta</a></li>
                </ul>
            </div>
        </li>

        <!-- ADMINISTRACIÓN (solo admin) -->
        <c:if test="${sessionScope.usuAut.rol == 'R0001'}">
            <li class="mb-1">
                <button class="btn btn-toggle nav-root" data-bs-toggle="collapse" data-bs-target="#admin-collapse" aria-expanded="false">
                    <i class="bi bi-gear me-2"></i> Administración
                </button>
                <div class="collapse nav-section" id="admin-collapse">
                    <ul class="nav-sub list-unstyled">
                        <c:url var="urlRegistroUsuario" value="/ControlUsuario"><c:param name="op" value="RegistrarUsuario"/></c:url>
                        <li><a class="nav-sub-link" href="${urlRegistroUsuario}">Usuarios</a></li>
                        <li><a class="nav-sub-link" href="${pageContext.request.contextPath}/Administracion/gestion-parametros.jsp">Parámetros</a></li>
                        <li><a class="nav-sub-link" href="${pageContext.request.contextPath}/Administracion/gestion-accesos.jsp">Control de accesos</a></li>
                    </ul>
                </div>
            </li>
        </c:if>

    </ul>
</nav>
