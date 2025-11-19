<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Mis Cuentas - Quantum Bank</title>

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-global.css"/> 
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css"/> 
    </head>

    <body data-active-page="inicio" class="client-portal-body">

        <%@ include file="../util/header-cliente.jsp" %>

        <div class="container-fluid p-4 client-portal-content">

            <h2 class="h4 fw-bold mb-4">Bienvenido, ${sessionScope.nombreClienteReal}</h2>

            <div class="row h-100 g-4">

                <div class="col-lg-8 h-100 d-flex flex-column dashboard-account-column">

                    <h3 class="h5 fw-semibold mb-3">Mis Cuentas</h3>

                    <div class="account-list-scrollable">

                        <c:forEach var="c" items="${misCuentas}">
                            <a href="${pageContext.request.contextPath}/modulo-clientes/detalle-cuenta.jsp?num=${c.numCuenta}" class="card account-card-horizontal text-decoration-none mb-3">
                                <div class="card-body d-flex align-items-center p-3">

                                    <div class="icon-wrapper ${c.desTipoCuenta.toLowerCase().contains('plazo') ? 'bg-warning-subtle text-warning' : (c.desTipoCuenta.toLowerCase().contains('corriente') ? 'bg-primary-subtle text-primary' : 'bg-success-subtle text-success')}">
                                        <i class="bi ${c.desTipoCuenta.toLowerCase().contains('plazo') ? 'bi-clock-history' : 'bi-currency-dollar'}"></i>
                                    </div>

                                    <div class="card-info mx-3">
                                        <span class="account-type">${c.desTipoCuenta}</span>
                                        <span class="account-number font-monospace">N° ${c.numCuenta}</span>
                                    </div>

                                    <div class="card-balance ms-auto text-end">
                                        <span class="balance-label">${c.desMoneda}</span>
                                        <span class="balance-amount">
                                            ${c.codMoneda eq 'USD' ? '$' : 'S/'} 
                                            <fmt:formatNumber value="${c.salAct}" minFractionDigits="2" maxFractionDigits="2"/>
                                        </span>
                                    </div>
                                </div>
                            </a>
                        </c:forEach>

                        <c:if test="${empty misCuentas}">
                            <div class="alert alert-light border text-center py-4">
                                <i class="bi bi-wallet2 display-4 text-muted mb-3"></i>
                                <p class="text-muted">Aún no tienes cuentas activas.</p>
                                <a href="${pageContext.request.contextPath}/modulo-clientes/productos/apertura-cuenta.jsp" class="btn btn-sm btn-primary">Abrir una Cuenta</a>
                            </div>
                        </c:if>
                    </div> 
                </div> 

                <div class="col-lg-4 d-flex flex-column h-100">
                    <div class="card shadow-sm border-0 quick-actions-card d-flex flex-column h-100">
                        <div class="card-body p-4"> 
                            <h5 class="fw-semibold mb-3">Operaciones</h5>
                            <div class="row g-2 mb-4">
                                <div class="col-4"><a href="${pageContext.request.contextPath}/modulo-clientes/operaciones/transferencia.jsp" class="btn action-grid-btn"><i class="bi bi-arrow-left-right"></i><span>Transferir</span></a></div>
                                <div class="col-4"><a href="${pageContext.request.contextPath}/modulo-clientes/operaciones/deposito.jsp" class="btn action-grid-btn"><i class="bi bi-box-arrow-in-down"></i><span>Depositar</span></a></div>
                                <div class="col-4"><a href="${pageContext.request.contextPath}/modulo-clientes/operaciones/retiro.jsp" class="btn action-grid-btn"><i class="bi bi-cash"></i><span>Retirar</span></a></div>
                            </div>
                            <hr>
                            <h5 class="fw-semibold mb-3">Cuentas Favoritas</h5>
                            <div class="favorite-list-scrollable">
                                <div class="list-group list-group-flush favorite-list">
                                    <a href="#" class="list-group-item list-group-item-action favorite-account-item">
                                        <div class="avatar-initial bg-primary text-white">M</div>
                                        <div class="favorite-info"><span class="fw-medium">Maria Lopez</span><small class="text-muted">BCP - Ahorros Soles</small></div>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> 
            </div> 
        </div> 

        <%@ include file="../util/cont-sesion.jsp" %>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/session-timer.js"></script>
        <script src="${pageContext.request.contextPath}/js/portal-cliente.js"></script>
    </body>
</html>