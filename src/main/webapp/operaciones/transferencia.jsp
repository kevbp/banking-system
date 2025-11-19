<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <title>Transferencias - Quantum Bank</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/estilos.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/sidebar.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body data-active-page="operaciones-transferencia">
        <%@ include file="../util/theme.jsp" %>
        <div class="d-flex">
            <%@ include file="../util/sidebar.jsp" %>
            <div class="main-content flex-grow-1">
                <%@ include file="../util/header.jsp" %>

                <div class="content-area p-4">

                    <c:if test="${not empty msg}"><div class="alert alert-success shadow-sm border-success"><i class="bi bi-check-circle-fill"></i> ${msg}</div></c:if>
                    <c:if test="${not empty msgError}"><div class="alert alert-danger shadow-sm border-danger"><i class="bi bi-exclamation-triangle-fill"></i> ${msgError}</div></c:if>

                        <div class="card shadow-sm border-0">
                            <div class="card-header bg-dark text-white text-center py-3">
                                <h4 class="mb-0"><i class="bi bi-arrow-left-right me-2"></i>Transferencia entre Cuentas</h4>
                            </div>
                            <div class="card-body p-4">

                                <div class="text-end mb-3">
                                    <form action="${pageContext.request.contextPath}/ControlTransferencia" method="post" style="display:inline;">
                                    <input type="hidden" name="accion" value="limpiar">
                                    <button class="btn btn-sm btn-outline-secondary">Nueva Operación</button>
                                </form>
                            </div>

                            <div class="row g-4">
                                <div class="col-md-6 border-end">
                                    <h5 class="text-muted mb-3">1. Cuenta de Origen</h5>
                                    <c:if test="${empty sessionScope.ctaOrigen}">
                                        <form action="${pageContext.request.contextPath}/ControlTransferencia" method="post">
                                            <input type="hidden" name="accion" value="buscarOrigen">
                                            <div class="input-group">
                                                <input type="text" class="form-control" name="numCuenta" placeholder="N° Cuenta Origen" required>
                                                <button class="btn btn-primary">Buscar</button>
                                            </div>
                                        </form>
                                    </c:if>
                                    <c:if test="${not empty sessionScope.ctaOrigen}">
                                        <div class="alert alert-primary shadow-sm">
                                            <h5 class="fw-bold">${sessionScope.ctaOrigen.cliente.nombre}</h5>
                                            <div>${sessionScope.ctaOrigen.numCuenta}</div>
                                            <div class="badge bg-primary">${sessionScope.ctaOrigen.desTipoCuenta}</div>
                                            <hr>
                                            <div class="small text-muted">Disponible:</div>
                                            <h3 class="fw-bold text-primary">
                                                ${sessionScope.ctaOrigen.codMoneda eq 'USD' ? '$' : 'S/'} 
                                                <fmt:formatNumber value="${sessionScope.ctaOrigen.salAct + sessionScope.ctaOrigen.sobregiro}" minFractionDigits="2"/>
                                            </h3>
                                        </div>
                                    </c:if>
                                </div>

                                <div class="col-md-6">
                                    <h5 class="text-muted mb-3">2. Cuenta de Destino</h5>
                                    <c:if test="${empty sessionScope.ctaDestino}">
                                        <form action="${pageContext.request.contextPath}/ControlTransferencia" method="post">
                                            <input type="hidden" name="accion" value="buscarDestino">
                                            <div class="input-group">
                                                <input type="text" class="form-control" name="numCuenta" placeholder="N° Cuenta Destino" required>
                                                <button class="btn btn-success">Buscar</button>
                                            </div>
                                        </form>
                                    </c:if>
                                    <c:if test="${not empty sessionScope.ctaDestino}">
                                        <div class="alert alert-success shadow-sm">
                                            <h5 class="fw-bold">${sessionScope.ctaDestino.cliente.nombre}</h5>
                                            <div>${sessionScope.ctaDestino.numCuenta}</div>
                                            <div class="badge bg-success">${sessionScope.ctaDestino.desTipoCuenta}</div>
                                            <div class="mt-2 small">Moneda: <strong>${sessionScope.ctaDestino.desMoneda}</strong></div>
                                        </div>
                                    </c:if>
                                </div>
                            </div>

                            <c:if test="${not empty sessionScope.ctaOrigen and not empty sessionScope.ctaDestino}">
                                <hr class="my-4">
                                <form action="${pageContext.request.contextPath}/ControlTransferencia" method="post" onsubmit="return confirm('¿Confirmar transferencia?');">
                                    <input type="hidden" name="accion" value="procesar">
                                    <input type="hidden" name="numOrigen" value="${sessionScope.ctaOrigen.numCuenta}">
                                    <input type="hidden" name="numDestino" value="${sessionScope.ctaDestino.numCuenta}">

                                    <div class="row justify-content-center">
                                        <div class="col-md-6 text-center">
                                            <label class="form-label fw-bold">Monto a Transferir (${sessionScope.ctaOrigen.codMoneda})</label>
                                            <input type="number" step="0.01" class="form-control form-control-lg text-center fw-bold" name="monto" required>

                                            <c:if test="${sessionScope.ctaOrigen.codMoneda ne sessionScope.ctaDestino.codMoneda}">
                                                <div class="alert alert-warning mt-3 py-2 small">
                                                    <i class="bi bi-exclamation-circle"></i> Se aplicará tipo de cambio vigente al destino.
                                                </div>
                                            </c:if>

                                            <div class="mt-3">
                                                <input type="text" class="form-control" name="descripcion" placeholder="Referencia / Motivo (Opcional)">
                                            </div>

                                            <button class="btn btn-dark btn-lg w-100 mt-4">Confirmar Operación</button>
                                        </div>
                                    </div>
                                </form>
                            </c:if>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@ include file="../util/cont-sesion.jsp" %>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sidebar.js"></script>
        <script src="${pageContext.request.contextPath}/js/session-timer.js"></script>
    </body>
</html>