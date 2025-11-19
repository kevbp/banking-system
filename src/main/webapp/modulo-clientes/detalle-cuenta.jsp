<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Detalle de Cuenta - Quantum Bank</title>
    <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/portal-global.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <style>
        /* Mantener tu estilo visual exacto */
        .balance-card { background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%); color: white; }
        .amount-pos { color: #198754; font-weight: 600; }
        .amount-neg { color: #dc3545; font-weight: 600; }
    </style>
</head>
<body class="bg-light">

    <%@ include file="../util/header-cliente.jsp" %>

    <div class="container py-4">
        
        <div class="mb-3">
            <a href="${pageContext.request.contextPath}/ControlLoginCliente?accion=dashboard" class="btn btn-link text-decoration-none p-0">
                <i class="bi bi-arrow-left me-1"></i> Volver a Mis Cuentas
            </a>
        </div>

        <div class="card shadow-sm border-0 mb-4">
            <div class="card-body p-3">
                <div class="dropdown w-100">
                    <button class="btn btn-light dropdown-toggle w-100 d-flex justify-content-between align-items-center" type="button" data-bs-toggle="dropdown">
                        <span class="fw-medium">
                            <i class="bi bi-wallet2 me-2 text-primary"></i>
                            <c:if test="${not empty cuentaActual}">
                                ${cuentaActual.desTipoCuenta} - ${cuentaActual.numCuenta} (${cuentaActual.desMoneda})
                            </c:if>
                            <c:if test="${empty cuentaActual}">Seleccione una cuenta</c:if>
                        </span>
                    </button>
                    <ul class="dropdown-menu w-100">
                        <c:forEach var="c" items="${misCuentas}">
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/ControlLoginCliente?accion=detalle&num=${c.numCuenta}">
                                    <span class="d-block fw-medium">${c.desTipoCuenta} - ${c.numCuenta}</span>
                                    <small class="text-muted">${c.desMoneda}</small>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>

        <c:if test="${not empty cuentaActual}">
            <div class="row g-4">
                
                <div class="col-lg-4 d-flex flex-column h-100">
                    
                    <div class="card balance-card shadow border-0 mb-4">
                        <div class="card-body p-4 text-center">
                            <h6 class="text-white-50 fw-bold mb-3">SALDO DISPONIBLE</h6>
                            <h1 class="display-5 fw-bold mb-0">
                                ${cuentaActual.codMoneda eq 'USD' ? '$' : 'S/'} 
                                <fmt:formatNumber value="${cuentaActual.salAct}" minFractionDigits="2" maxFractionDigits="2"/>
                            </h1>
                            
                            <c:if test="${cuentaActual.sobregiro > 0}">
                                <div class="mt-3 pt-3 border-top border-white-50">
                                    <small class="text-white-50">Línea de Sobregiro:</small>
                                    <div class="fw-bold">
                                        ${cuentaActual.codMoneda eq 'USD' ? '$' : 'S/'} <fmt:formatNumber value="${cuentaActual.sobregiro}" minFractionDigits="2"/>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <div class="card shadow-sm border-0 mb-4">
                        <div class="card-body p-4">
                            <ul class="list-unstyled mb-0">
                                <li class="mb-2 d-flex justify-content-between">
                                    <span class="text-muted">Titular:</span>
                                    <strong>${sessionScope.clienteAut.nomUsuario}</strong>
                                </li>
                                <li class="mb-2 d-flex justify-content-between">
                                    <span class="text-muted">Número:</span>
                                    <span class="font-monospace fw-bold">${cuentaActual.numCuenta}</span>
                                </li>
                                <li class="mb-2 d-flex justify-content-between">
                                    <span class="text-muted">CCI:</span>
                                    <span class="font-monospace small text-end text-muted">${cuentaActual.cci != null ? cuentaActual.cci : '-'}</span>
                                </li>
                                <li class="mb-2 d-flex justify-content-between">
                                    <span class="text-muted">Tipo:</span>
                                    <strong>${cuentaActual.desTipoCuenta}</strong>
                                </li>
                                <li class="mb-2 d-flex justify-content-between">
                                    <span class="text-muted">Moneda:</span>
                                    <strong>${cuentaActual.desMoneda}</strong>
                                </li>
                                <li class="mb-2 d-flex justify-content-between">
                                    <span class="text-muted">Fecha Apertura:</span>
                                    <strong><fmt:formatDate value="${cuentaActual.fecApe}" pattern="dd/MM/yyyy"/></strong>
                                </li>
                                <li class="d-flex justify-content-between align-items-center">
                                    <span class="text-muted">Estado:</span>
                                    <span class="badge bg-success">${cuentaActual.desEstado}</span>
                                </li>
                            </ul>
                        </div>
                    </div>

                </div>

                <div class="col-lg-8 d-flex flex-column h-100">
                    <div class="card shadow-sm border-0 h-100">
                        <div class="card-body p-4">
                            <h5 class="card-title fw-semibold mb-3">Últimos Movimientos</h5>
                            <div class="table-responsive">
                                <table class="table table-striped align-middle mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th>Fecha</th>
                                            <th>Descripción</th>
                                            <th class="text-end">Monto</th>
                                            <th class="text-end">Saldo</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="m" items="${movimientos}">
                                            <tr>
                                                <td>
                                                    <div class="fw-bold"><fmt:formatDate value="${m.fec}" pattern="dd/MM"/></div>
                                                    <small class="text-muted"><fmt:formatDate value="${m.fec}" pattern="yyyy HH:mm"/></small>
                                                </td>
                                                <td>
                                                    <div class="text-truncate" style="max-width: 250px;" title="${m.des}">
                                                        ${m.des}
                                                    </div>
                                                    <small class="text-muted font-monospace">${m.codTransaccion}</small>
                                                </td>
                                                <td class="text-end">
                                                    <span class="${m.signo eq '+' ? 'amount-pos' : 'amount-neg'}">
                                                        ${m.signo} 
                                                        ${cuentaActual.codMoneda eq 'USD' ? '$' : 'S/'} 
                                                        <fmt:formatNumber value="${m.monto}" minFractionDigits="2"/>
                                                    </span>
                                                </td>
                                                <td class="text-end text-muted small">
                                                    ${cuentaActual.codMoneda eq 'USD' ? '$' : 'S/'} 
                                                    <fmt:formatNumber value="${m.salFin}" minFractionDigits="2"/>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        
                                        <c:if test="${empty movimientos}">
                                            <tr><td colspan="4" class="text-center py-5 text-muted">No hay movimientos recientes.</td></tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </c:if>

        <c:if test="${empty cuentaActual}">
            <div class="alert alert-warning text-center mt-5">
                <i class="bi bi-exclamation-triangle display-4 d-block mb-3 text-warning"></i>
                <p class="lead">No se pudo cargar la información de la cuenta.</p>
                <a href="${pageContext.request.contextPath}/ControlLoginCliente?accion=dashboard" class="btn btn-outline-primary">Volver al Inicio</a>
            </div>
        </c:if>

    </div>

    <%@ include file="../util/cont-sesion.jsp" %>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/session-timer.js"></script>
</body>
</html>