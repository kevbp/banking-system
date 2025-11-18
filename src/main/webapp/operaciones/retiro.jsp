<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Retiro de Efectivo - Quantum Bank</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/estilos.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/sidebar.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body data-active-page="operaciones-retiro">
        <%@ include file="../util/theme.jsp" %>

        <div class="d-flex">
            <%@ include file="../util/sidebar.jsp" %>

            <div class="main-content flex-grow-1">
                <%@ include file="../util/header.jsp" %>

                <div class="content-area p-4">

                    <c:if test="${not empty msg}">
                        <div class="alert alert-success shadow-sm border-success mb-4">
                            <i class="bi bi-check-circle-fill me-2"></i> ${msg}
                        </div>
                    </c:if>
                    <c:if test="${not empty msgError}">
                        <div class="alert alert-danger shadow-sm border-danger mb-4">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${msgError}
                        </div>
                    </c:if>

                    <div class="card shadow-sm border-0">
                        <div class="card-header bg-dark text-white text-center py-3">
                            <h4 class="mb-0"><i class="bi bi-wallet2 me-2"></i>Retiro de Efectivo</h4>
                        </div>

                        <div class="card-body p-4">

                            <form action="${pageContext.request.contextPath}/ControlRetiro" method="get" class="mb-4">
                                <div class="row g-2 align-items-end justify-content-center">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold text-muted">BUSCAR CUENTA DE ORIGEN</label>
                                        <div class="input-group input-group-lg">
                                            <span class="input-group-text bg-light"><i class="bi bi-search"></i></span>
                                            <input type="text" class="form-control" name="numCuenta" 
                                                   value="${numCuentaBusqueda}" placeholder="Ingrese N° de Cuenta" required>
                                            <button class="btn btn-primary px-4" type="submit">Buscar</button>
                                        </div>
                                    </div>
                                </div>
                            </form>

                            <c:if test="${not empty cuenta}">
                                <hr class="my-4">

                                <div class="row g-4 mb-4">
                                    <div class="col-md-6">
                                        <div class="card bg-light border-0 h-100">
                                            <div class="card-body">
                                                <h6 class="text-muted fw-bold mb-3">DATOS DEL CLIENTE</h6>
                                                <h4 class="mb-1">${cuenta.cliente.nombre}</h4>
                                                <div class="text-muted">DOC: ${cuenta.cliente.numDocumento}</div>
                                                <div class="mt-2">
                                                    <span class="badge bg-primary">${cuenta.desTipoCuenta}</span>
                                                    <span class="badge ${cuenta.desEstado eq 'Activo' ? 'bg-success' : 'bg-danger'}">
                                                        ${cuenta.desEstado}
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="card border-success h-100">
                                            <div class="card-body text-center d-flex flex-column justify-content-center">
                                                <h6 class="text-success fw-bold">SALDO ACTUAL</h6>
                                                <h2 class="display-5 fw-bold text-dark mb-0">
                                                    ${cuenta.desMoneda eq 'Dólares' ? '$' : 'S/'} 
                                                    <fmt:formatNumber value="${cuenta.salAct}" minFractionDigits="2" maxFractionDigits="2"/>
                                                </h2>

                                                <c:if test="${cuenta.sobregiro > 0}">
                                                    <div class="mt-2 pt-2 border-top text-muted small">
                                                        <i class="bi bi-plus-circle-dotted"></i> Sobregiro: 
                                                        <strong><fmt:formatNumber value="${cuenta.sobregiro}" minFractionDigits="2"/></strong>
                                                    </div>
                                                    <div class="text-primary fw-bold small">
                                                        Disponible Total: 
                                                        <fmt:formatNumber value="${cuenta.salAct + cuenta.sobregiro}" minFractionDigits="2"/>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="card border-0 shadow-sm">
                                    <div class="card-body bg-white">
                                        <h5 class="card-title mb-4 text-danger">
                                            <i class="bi bi-dash-circle me-2"></i>Registrar Salida de Dinero
                                        </h5>

                                        <form action="${pageContext.request.contextPath}/ControlRetiro" method="post" id="formRetiro" onsubmit="return confirmarRetiro();">
                                            <input type="hidden" name="accion" value="procesar">
                                            <input type="hidden" name="numCuenta" value="${cuenta.numCuenta}">

                                            <input type="hidden" id="saldoDisponible" value="${cuenta.salAct}">
                                            <input type="hidden" id="limSobregiro" value="${cuenta.sobregiro}">

                                            <div class="row g-3">
                                                <div class="col-md-5">
                                                    <label class="form-label fw-bold">Monto a Retirar</label>
                                                    <div class="input-group input-group-lg">
                                                        <span class="input-group-text fw-bold text-danger">
                                                            ${cuenta.desMoneda eq 'Dólares' ? '$' : 'S/'}
                                                        </span>
                                                        <input type="number" step="0.01" min="0.10" class="form-control fw-bold text-danger" 
                                                               id="montoRetiro" name="monto" placeholder="0.00" required>
                                                    </div>
                                                    <div id="feedbackSaldo" class="form-text text-danger d-none fw-bold">
                                                        <i class="bi bi-x-circle"></i> El monto excede el saldo disponible.
                                                    </div>
                                                </div>

                                                <div class="col-md-7">
                                                    <label class="form-label">Observaciones / Autorización</label>
                                                    <textarea class="form-control form-control-lg" name="descripcion" rows="1" 
                                                              placeholder="Opcional: DNI de quien retira si es carta poder..."></textarea>
                                                </div>
                                            </div>

                                            <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                                                <a href="retiro.jsp" class="btn btn-secondary px-4">Cancelar</a>
                                                <button type="submit" class="btn btn-danger px-5 fw-bold" id="btnProcesar">
                                                    Procesar Retiro
                                                </button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
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
        <script src="${pageContext.request.contextPath}/js/retiro.js"></script>

    </body>
</html>