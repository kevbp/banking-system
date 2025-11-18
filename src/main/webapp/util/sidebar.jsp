<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<nav class="sidebar d-flex flex-column flex-shrink-0">

    <a href="${pageContext.request.contextPath}/home.jsp" 
       class="d-flex align-items-center justify-content-center mb-3 mb-md-0 text-white text-decoration-none">
        <img src="${pageContext.request.contextPath}/img/logoQB.png" alt="Quantum Bank" height="50">
    </a>
    <hr class="text-white opacity-50">

    <ul class="nav nav-pills flex-column">
        <c:url var="urlHome" value="/ControlHome"><c:param name="op" value="home"/></c:url>
            <li class="nav-item mb-1">
                <a href="${urlHome}" class="nav-link nav-root" data-page-id="home">
                <i class="bi bi-house-door me-2"></i> Inicio
            </a>
        </li>

        <li class="mb-1">
            <button class="btn btn-toggle nav-root" data-bs-toggle="collapse" data-bs-target="#clientes-collapse" aria-expanded="false" data-page-id="clientes-root">
                <i class="bi bi-people me-2"></i> Clientes
            </button>
            <div class="collapse nav-section" id="clientes-collapse">
                <ul class="nav-sub list-unstyled">
                    <c:url var="urlListarCliente" value="/ControlCliente"><c:param name="op" value="ListaClientes"/></c:url>
                    <li><a class="nav-sub-link" href="${urlListarCliente}" data-page-id="clientes-consulta">Consulta de clientes</a></li>

                    <c:url var="urlRegistroCliente" value="/ControlCliente"><c:param name="op" value="RegistrarCliente"/></c:url>
                    <li><a class="nav-sub-link" href="${urlRegistroCliente}" data-page-id="clientes-registro">Registro de clientes</a></li>
                </ul>
            </div>
        </li>

        <li class="mb-1">
            <button class="btn btn-toggle nav-root" data-bs-toggle="collapse" data-bs-target="#cuentas-collapse" aria-expanded="false" data-page-id="cuentas-root">
                <i class="bi bi-credit-card me-2"></i> Cuentas
            </button>
            <div class="collapse nav-section" id="cuentas-collapse">
                <ul class="nav-sub list-unstyled">
                    <c:url var="urlAperturaCuenta" value="/ControlCuenta"><c:param name="accion" value="apertura"/></c:url>
                    <li><a class="nav-sub-link" href="${urlAperturaCuenta}" data-page-id="cuentas-apertura">Apertura de cuentas</a></li>
                        <c:url var="urlGestion" value="/ControlCuenta"><c:param name="accion" value="listar"/></c:url>
                    <li><a class="nav-sub-link" href="${urlGestion}" data-page-id="cuentas-gestion">Gestión de cuentas</a></li>
                    <c:url var="urlEmbargos" value="/cuentas/gestion-embargos.jsp"/>
                    <li><a class="nav-sub-link" href="${urlEmbargos}" data-page-id="cuentas-embargos">Gestión de embargos</a></li>
                </ul>
            </div>
        </li>

        <li class="mb-1">
            <button class="btn btn-toggle nav-root" data-bs-toggle="collapse" data-bs-target="#operaciones-collapse" aria-expanded="false" data-page-id="operaciones-root">
                <i class="bi bi-cash-coin me-2"></i> Operaciones
            </button>
            <div class="collapse nav-section" id="operaciones-collapse">
                <ul class="nav-sub list-unstyled">
                    <li><a class="nav-sub-link" href="${pageContext.request.contextPath}/operaciones/deposito.jsp" data-page-id="operaciones-deposito">Depósitos</a></li>
                    <li><a class="nav-sub-link" href="${pageContext.request.contextPath}/operaciones/retiro.jsp" data-page-id="operaciones-retiro">Retiros</a></li>
                    <li><a class="nav-sub-link" href="${pageContext.request.contextPath}/operaciones/transferencia.jsp" data-page-id="operaciones-transferencia">Transferencias</a></li>
                </ul>
            </div>
        </li>

        <li class="mb-1">
            <button class="btn btn-toggle nav-root" data-bs-toggle="collapse" data-bs-target="#consultas-collapse" aria-expanded="false" data-page-id="consultas-root">
                <i class="bi bi-search me-2"></i> Consultas
            </button>
            <div class="collapse nav-section" id="consultas-collapse">
                <ul class="nav-sub list-unstyled">
                    <li><a class="nav-sub-link" href="${pageContext.request.contextPath}/consultas/consulta-cuentas.jsp" data-page-id="consultas-cuentas">Cuentas</a></li>
                    <li><a class="nav-sub-link" href="${pageContext.request.contextPath}/consultas/consulta-movimientos.jsp" data-page-id="consultas-movimientos">Movimientos</a></li>
                    <li><a class="nav-sub-link" href="${pageContext.request.contextPath}/consultas/consulta-estado-cuenta.jsp" data-page-id="consultas-estado">Estados de cuenta</a></li>
                </ul>
            </div>
        </li>

        <c:if test="${sessionScope.usuAut.rol == 'R0001'}">
            <li class="mb-1">
                <button class="btn btn-toggle nav-root" data-bs-toggle="collapse" data-bs-target="#admin-collapse" aria-expanded="false" data-page-id="admin-root">
                    <i class="bi bi-gear me-2"></i> Administración
                </button>
                <div class="collapse nav-section" id="admin-collapse">
                    <ul class="nav-sub list-unstyled">
                        <c:url var="urlRegistroUsuario" value="/ControlUsuario"><c:param name="op" value="RegistrarUsuario"/></c:url>
                        <li><a class="nav-sub-link" href="${urlRegistroUsuario}" data-page-id="admin-usuarios">Usuarios</a></li>
                            <c:url var="urlParametros" value="/ControlParametros"><c:param name="op" value="Parametros"/></c:url>
                        <li><a class="nav-sub-link" href="${urlParametros}" data-page-id="admin-parametros">Parámetros</a></li>
                        <li><a class="nav-sub-link" href="${pageContext.request.contextPath}/Administracion/gestion-accesos.jsp" data-page-id="admin-accesos">Control de accesos</a></li>
                    </ul>
                </div>
            </li>
        </c:if>

    </ul>
</nav>