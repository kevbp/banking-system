<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Gestión de Cuentas - Quantum Bank</title>

        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/estilos.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/sidebar.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>

    <body data-active-page="cuentas-gestion">
        <%@ include file="../util/theme.jsp" %>
        <div class="d-flex">
            <%@ include file="../util/sidebar.jsp" %>
            <div class="main-content flex-grow-1">
                <%@ include file="../util/header.jsp" %>

                <div class="content-area p-4">
                    <div class="card shadow-sm border-0">
                        <div class="card-header bg-dark text-light text-center">
                            <h4 class="mb-0">Cartera de Cuentas</h4>
                        </div>
                        <div class="card-body p-4">

                            <c:if test="${not empty param.msg}">
                                <div class="alert alert-info alert-dismissible fade show">
                                    ${param.msg}
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                                </div>
                            </c:if>

                            <form action="${pageContext.request.contextPath}/ControlCuenta" method="get" class="mb-4">
                                <input type="hidden" name="accion" value="listar">
                                <div class="row g-3 align-items-end">
                                    <div class="col-md-3">
                                        <label class="form-label">N° Cuenta</label>
                                        <input type="text" class="form-control" name="numCuenta" value="${param.numCuenta}">
                                    </div>
                                    <div class="col-md-3">
                                        <label class="form-label">DNI Cliente</label>
                                        <input type="text" class="form-control" name="numDoc" value="${param.numDoc}">
                                    </div>
                                    <div class="col-md-2">
                                        <button type="submit" class="btn btn-primary w-100"><i class="bi bi-search"></i> Filtrar</button>
                                    </div>
                                </div>
                            </form>

                            <hr>

                            <div class="table-responsive">
                                <table class="table table-hover table-bordered align-middle">
                                    <thead class="table-light text-center">
                                        <tr>
                                            <th>N° Cuenta</th>
                                            <th>Cliente</th>
                                            <th>Producto</th>
                                            <th>Moneda</th>
                                            <th>Saldo</th>
                                            <th>Estado</th>
                                            <th>Acción</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="c" items="${listaCuentas}">
                                            <tr>
                                                <td class="fw-bold">${c.numCuenta}</td>
                                                <td>${c.cliente.nombre}</td>
                                                <td>${c.desTipoCuenta}</td>
                                                <td>${c.desMoneda}</td>
                                                <td class="text-end">
                                                    ${c.desMoneda eq 'Dólares' ? '$' : 'S/'} 
                                                    <fmt:formatNumber value="${c.salAct}" minFractionDigits="2"/>
                                                </td>
                                                <td class="text-center">
                                                    <span class="badge ${c.desEstado eq 'Activo' ? 'bg-success' : (c.desEstado eq 'Embargado' ? 'bg-danger' : 'bg-secondary')}">
                                                        ${c.desEstado}
                                                    </span>
                                                </td>
                                                <td class="text-center">
                                                    <button class="btn btn-sm btn-info text-white btn-detalle" 
                                                            data-num="${c.numCuenta}" 
                                                            data-bs-toggle="modal" 
                                                            data-bs-target="#modalDetalle">
                                                        <i class="bi bi-eye"></i> Ver
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty listaCuentas}">
                                            <tr><td colspan="7" class="text-center text-muted">No se encontraron cuentas.</td></tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalDetalle" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title">Gestión de Cuenta: <span id="lblNumCuenta" class="fw-bold"></span></h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">

                        <div class="row">
                            <%-- COLUMNA 1: DATOS DE LA CUENTA --%>
                            <div class="col-md-6 border-end">
                                <h6 class="text-primary mb-3"><i class="bi bi-info-circle me-1"></i> Información General</h6>
                                <table class="table table-sm table-borderless small">
                                    <tr><th>Cliente</th><td id="valCliente" class="fw-medium"></td></tr>
                                    <tr><th>Tipo de Producto</th><td id="valTipo"></td></tr>
                                    <tr><th>Moneda</th><td id="valMoneda"></td></tr>
                                    <tr><th>Fecha Apertura</th><td id="valFecha"></td></tr>
                                </table>
                            </div>

                            <%-- COLUMNA 2: ESTATUS FINANCIERO Y ESTADO --%>
                            <div class="col-md-6">
                                <h6 class="text-primary mb-3"><i class="bi bi-bar-chart-line me-1"></i> Estatus Actual</h6>
                                <div class="p-3 bg-light rounded mb-3">
                                    <strong>SALDO DISPONIBLE:</strong>
                                    <p class="fs-4 fw-bolder mb-0 text-success" id="valSaldo"></p>
                                </div>
                                <table class="table table-sm table-borderless small">
                                    <tr><th>Estado General</th><td id="valEstado"></td></tr>
                                    <tr><th>N° Documento</th><td id="valDoc"></td></tr>
                                </table>
                            </div>
                        </div>

                        <hr>

                        <%-- SECCIÓN DE EMBARGOS (CONDICIONAL) --%>
                        <div id="alertEmbargoInfo" class="alert alert-danger d-none small">
                            <strong><i class="bi bi-lock-fill me-1"></i> ALERTA: CUENTA EMBARGADA</strong>
                            <ul class="mb-0 mt-1">
                                <li><strong>Monto Retenido:</strong> <span id="embMonto"></span></li>
                                <li><strong>N° Expediente:</strong> <span id="embExp"></span></li>
                                <li><strong>Motivo Judicial:</strong> <span id="embMot"></span></li>
                            </ul>
                        </div>

                        <%-- FORMULARIO DE EMBARGO (SE MUESTRA AL HACER CLIC EN BOTÓN) --%>
                        <div id="formEmbargoSection" class="card d-none mt-3 border-danger">
                            <div class="card-body bg-light">
                                <h6 class="text-danger fw-bold mb-3">Registrar Nuevo Embargo Judicial</h6>
                                <form action="${pageContext.request.contextPath}/ControlCuenta" method="post">
                                    <input type="hidden" name="accion" value="embargar">
                                    <input type="hidden" name="numCuentaEmbargo" id="inputNumCuentaEmbargo">

                                    <div class="row g-2">
                                        <div class="col-md-4">
                                            <label class="small">Monto a Retener</label>
                                            <input type="number" step="0.01" class="form-control form-control-sm" name="monto" required>
                                        </div>
                                        <div class="col-md-4">
                                            <label class="small">N° Expediente</label>
                                            <input type="text" class="form-control form-control-sm" name="expediente" required>
                                        </div>
                                        <div class="col-md-12">
                                            <label class="small">Motivo / Descripción</label>
                                            <input type="text" class="form-control form-control-sm" name="motivo" required>
                                        </div>
                                    </div>
                                    <div class="text-end mt-3">
                                        <button type="button" class="btn btn-sm btn-secondary" id="btnCancelarEmbargo">Cancelar</button>
                                        <button type="submit" class="btn btn-sm btn-danger">Ejecutar Retención</button>
                                    </div>
                                </form>
                            </div>
                        </div>

                    </div>

                    <div class="modal-footer d-flex justify-content-between" id="actionsPanel">

                        <%-- FORMULARIOS DE ACCIÓN --%>
                        <form action="${pageContext.request.contextPath}/ControlCuenta" method="post" onsubmit="return confirm('ATENCIÓN: Esto cerrará la cuenta definitivamente. ¿Desea continuar?');">
                            <input type="hidden" name="accion" value="cambiarEstado">
                            <input type="hidden" name="tipo" value="cerrar">
                            <input type="hidden" name="numCuenta" id="inputNumCuentaCerrar">
                            <button class="btn btn-danger action-btn" id="btnCerrarCuenta" title="Cerrar Cuenta"><i class="bi bi-x-circle me-1"></i> Cerrar Cuenta</button>
                        </form>

                        <form action="${pageContext.request.contextPath}/ControlCuenta" method="post" onsubmit="return confirm('¿Seguro que desea Inactivar la cuenta? No se podrán hacer operaciones.');">
                            <input type="hidden" name="accion" value="cambiarEstado">
                            <input type="hidden" name="tipo" value="inactivar">
                            <input type="hidden" name="numCuenta" id="inputNumCuentaInactivar">
                            <button class="btn btn-warning action-btn" id="btnInactivarCuenta" title="Inactivar"><i class="bi bi-pause-circle me-1"></i> Inactivar</button>
                        </form>

                        <button class="btn btn-outline-danger action-btn" id="btnShowEmbargo" title="Embargar"><i class="bi bi-hammer me-1"></i> Embargar</button>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="../util/cont-sesion.jsp" %>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sidebar.js"></script>

        <script>const contextPath = "${pageContext.request.contextPath}";</script>
        <script src="${pageContext.request.contextPath}/js/gestion-cuentas.js"></script>
        <script src="${pageContext.request.contextPath}/js/session-timer.js"></script>
    </body>
</html>