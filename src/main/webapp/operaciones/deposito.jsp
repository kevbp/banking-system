<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Nuevo Depósito - Quantum Bank</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/estilos.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/sidebar.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body data-active-page="operaciones-deposito">
        <%@ include file="../util/theme.jsp" %>

        <div class="d-flex">
            <%@ include file="../util/sidebar.jsp" %>

            <div class="main-content flex-grow-1">
                <%@ include file="../util/header.jsp" %>

                <div class="content-area p-4">

                    <c:if test="${not empty msg}">
                        <div class="alert alert-success alert-dismissible fade show shadow-sm border-success">
                            <i class="bi bi-check-circle-fill me-2"></i> ${msg}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    <c:if test="${not empty msgError}">
                        <div class="alert alert-danger alert-dismissible fade show shadow-sm border-danger">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${msgError}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <div class="card shadow-sm border-0">
                        <div class="card-header bg-dark text-light text-center">
                            <h4 class="mb-0">Depósito en Cuenta</h4>
                        </div>

                        <div class="card-body p-4">

                            <h5 class="text-muted mb-3">1. Buscar Cuenta Destino</h5>
                            <form action="${pageContext.request.contextPath}/ControlDeposito" method="get" class="mb-4">
                                <div class="row g-3 align-items-end">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Número de Cuenta</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="bi bi-search"></i></span>
                                            <input type="text" class="form-control" name="numCuenta" value="${numCuentaBusqueda}" placeholder="Ej: 001-..." required>
                                        </div>
                                    </div>
                                    <div class="col-md-2">
                                        <button type="submit" class="btn btn-primary w-100">Buscar</button>
                                    </div>
                                </div>
                            </form>

                            <hr>

                            <c:if test="${not empty cuenta}">

                                <div class="alert alert-light border shadow-sm">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <strong>Cliente:</strong> ${cuenta.cliente.nombre} <br>
                                            <strong>Documento:</strong> ${cuenta.cliente.numDocumento}
                                        </div>
                                        <div class="col-md-6 text-md-end">
                                            <strong>Producto:</strong> ${cuenta.desTipoCuenta} (${cuenta.desMoneda}) <br>
                                            <strong>Saldo Actual:</strong> 
                                            <span class="text-primary fw-bold">
                                                ${cuenta.desMoneda eq 'Dólares' ? '$' : 'S/'} 
                                                <fmt:formatNumber value="${cuenta.salAct}" minFractionDigits="2" maxFractionDigits="2"/>
                                            </span>
                                            <br>
                                            <span class="badge ${cuenta.desEstado eq 'Activo' or cuenta.desEstado eq 'Activa' ? 'bg-success' : 'bg-danger'}">
                                                ${cuenta.desEstado}
                                            </span>
                                        </div>
                                    </div>
                                </div>

                                <h5 class="text-muted mt-4 mb-3">2. Registrar Depósito</h5>
                                <form action="${pageContext.request.contextPath}/ControlDeposito" method="post" onsubmit="return confirm('¿Confirmar Depósito?');">
                                    <input type="hidden" name="accion" value="registrar">
                                    <input type="hidden" name="numCuenta" value="${cuenta.numCuenta}">

                                    <div class="row g-3 mb-3">
                                        <div class="col-md-4">
                                            <label for="monto" class="form-label fw-bold">Monto a Depositar <span class="text-danger">*</span></label>
                                            <div class="input-group">
                                                <span class="input-group-text fw-bold">${cuenta.desMoneda eq 'Dólares' ? '$' : 'S/'}</span>
                                                <input type="number" step="0.01" min="0.10" class="form-control form-control-lg fw-bold text-success" 
                                                       id="monto" name="monto" placeholder="0.00" required
                                                       data-moneda="${cuenta.desMoneda eq 'Dólares' ? 'USD' : 'PEN'}">
                                            </div>
                                        </div>

                                        <div class="col-md-4">
                                            <label for="medioPago" class="form-label">Medio de Pago</label>
                                            <select class="form-select" name="medioPago">
                                                <option value="Efectivo">Efectivo</option>
                                                <option value="Cheque">Cheque</option>
                                                <option value="Transferencia">Transferencia Externa</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div id="origenFondosContainer" class="mb-3 d-none p-3 bg-warning bg-opacity-10 border border-warning rounded">
                                        <label for="origenFondos" class="form-label fw-bold text-warning-emphasis">
                                            <i class="bi bi-exclamation-circle-fill me-1"></i> Origen de Fondos (Monto > 2000)
                                        </label>
                                        <input type="text" class="form-control" id="origenFondos" name="origenFondos" 
                                               placeholder="Especifique la procedencia del dinero (Ej: Venta de inmueble, Ahorros, etc.)">
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Observaciones</label>
                                        <textarea class="form-control" name="descripcion" rows="2"></textarea>
                                    </div>

                                    <div class="text-end mt-4">
                                        <a href="deposito.jsp" class="btn btn-secondary me-2">Limpiar</a>
                                        <button type="submit" class="btn btn-success px-5 fw-bold">
                                            <i class="bi bi-cash-coin me-2"></i> Procesar Depósito
                                        </button>
                                    </div>
                                </form>

                            </c:if>

                            <c:if test="${empty cuenta and empty msgError and not empty param.numCuenta}">
                                <div class="alert alert-warning mt-3">No se encontró información para la cuenta ingresada.</div>
                            </c:if>

                        </div>
                    </div>
                </div> 
            </div> 
        </div> 

        <%@ include file="../util/cont-sesion.jsp" %>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sidebar.js"></script>
        <script src="${pageContext.request.contextPath}/js/deposito.js"></script>
        <script src="${pageContext.request.contextPath}/js/session-timer.js"></script>
    </body>
</html>