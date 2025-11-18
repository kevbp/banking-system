<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Gestión de Embargos | Quantum Bank</title>

        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/estilos.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/sidebar.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body data-active-page="cuentas-embargos">

        <%@ include file="../util/theme.jsp" %>

        <div class="d-flex">
            <%@ include file="../util/sidebar.jsp" %>

            <div class="main-content flex-grow-1">
                <%@ include file="../util/header.jsp" %>

                <div class="content-area p-4">
                    <h4 class="mb-3 fw-bold text-dark">Gestión de Embargos Judiciales</h4>

                    <div class="card shadow-sm border-0 mb-4">
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/ControlEmbargo" method="get" class="row g-3 align-items-end">
                                <input type="hidden" name="accion" value="buscar">
                                <div class="col-md-5">
                                    <label class="form-label fw-bold text-muted small">BÚSQUEDA DE CUENTA</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-white"><i class="bi bi-credit-card-2-front"></i></span>
                                        <input type="text" class="form-control" name="numCuenta" 
                                               value="${param.numCuenta}" placeholder="Ej: 001-..." required>
                                    </div>
                                </div>
                                <div class="col-md-2">
                                    <button type="submit" class="btn btn-primary w-100 fw-bold">
                                        <i class="bi bi-search me-1"></i> Buscar
                                    </button>
                                </div>
                            </form>

                            <c:if test="${not empty param.msg}">
                                <div class="alert alert-info mt-3 mb-0 py-2 small">
                                    ${param.msg}
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <c:if test="${not empty cuenta}">

                        <div class="card shadow-sm border-0 mb-4">
                            <div class="card-header bg-white fw-bold border-bottom">Datos de la Cuenta</div>
                            <div class="card-body bg-light">
                                <div class="row g-3">
                                    <div class="col-md-4">
                                        <small class="text-muted fw-bold">CLIENTE</small>
                                        <div class="text-dark">${cuenta.cliente.nombre}</div>
                                        <small class="text-muted">${cuenta.cliente.numDocumento}</small>
                                    </div>
                                    <div class="col-md-4">
                                        <small class="text-muted fw-bold">PRODUCTO</small>
                                        <div>${cuenta.desTipoCuenta} - ${cuenta.desMoneda}</div>
                                        <div class="text-primary fw-bold fs-5">
                                            ${cuenta.desMoneda eq 'Dólares' ? '$' : 'S/'} 
                                            <fmt:formatNumber value="${cuenta.salAct}" minFractionDigits="2" maxFractionDigits="2"/>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <small class="text-muted fw-bold">ESTADO</small>
                                        <div>
                                            <span class="badge ${cuenta.codEstado eq 'S0006' ? 'bg-danger' : 'bg-success'}">
                                                ${cuenta.desEstado}
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="card shadow-sm border-0 mb-4">
                            <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center">
                                <span class="fw-bold"><i class="bi bi-hammer me-2"></i> Historial de Embargos</span>
                                <button class="btn btn-sm btn-danger fw-bold" data-bs-toggle="modal" data-bs-target="#modalRegistrarEmbargo">
                                    <i class="bi bi-plus-circle me-1"></i> Nuevo Embargo
                                </button>
                            </div>
                            <div class="card-body p-0">
                                <c:if test="${empty listaEmbargos}">
                                    <div class="p-5 text-center text-muted">
                                        <i class="bi bi-shield-check fs-1 d-block mb-2 text-success"></i>
                                        <h5 class="fw-light">Sin embargos registrados</h5>
                                    </div>
                                </c:if>

                                <c:if test="${not empty listaEmbargos}">
                                    <div class="table-responsive">
                                        <table class="table table-hover mb-0 align-middle">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>Código</th>
                                                    <th>Monto</th>
                                                    <th>Estado</th>
                                                    <th>Expediente</th>
                                                    <th>Descripción</th>
                                                    <th>Fecha</th>
                                                    <th class="text-end">Acción</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="e" items="${listaEmbargos}">
                                                    <tr>
                                                        <td class="font-monospace small">${e.codEmbargo}</td>
                                                        <td class="fw-bold text-danger">
                                                            ${cuenta.desMoneda eq 'Dólares' ? '$' : 'S/'} 
                                                            <fmt:formatNumber value="${e.monto}" minFractionDigits="2" maxFractionDigits="2"/>
                                                        </td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${e.codEstado eq 'S0001'}">
                                                                    <span class="badge bg-danger">ACTIVO</span>
                                                                </c:when>
                                                                <c:when test="${e.codEstado eq 'S0007'}">
                                                                    <span class="badge bg-success">LIBERADO</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge bg-secondary">${e.codEstado}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td class="small">${e.expediente}</td>
                                                        <td class="small text-muted text-truncate" style="max-width: 150px;">${e.descripcion}</td>
                                                        <td class="small"><fmt:formatDate value="${e.fecUsuCre}" pattern="dd/MM/yyyy"/></td>
                                                        <td class="text-end">
                                                            <button class="btn btn-sm btn-outline-primary" 
                                                                    data-bs-toggle="modal" data-bs-target="#modalEditarEmbargo"
                                                                    data-cod="${e.codEmbargo}" 
                                                                    data-monto="${e.monto}"
                                                                    data-estado="${e.codEstado eq 'S0001' ? 'ACTIVO' : 'LIBERADO'}" 
                                                                    data-exp="${e.expediente}"
                                                                    data-desc="${e.descripcion}" 
                                                                    data-cta="${cuenta.numCuenta}"
                                                                    ${e.codEstado eq 'S0007' ? 'disabled' : ''}>
                                                                <i class="bi bi-pencil-square"></i>
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                    </c:if>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalRegistrarEmbargo" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-danger text-white">
                        <h5 class="modal-title fw-bold"><i class="bi bi-exclamation-triangle-fill me-2"></i>Registrar Embargo</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form action="${pageContext.request.contextPath}/ControlEmbargo" method="post" onsubmit="return confirm('¿Confirmar registro de embargo?');">
                            <input type="hidden" name="accion" value="registrar">
                            <input type="hidden" name="numCuenta" value="${cuenta.numCuenta}">

                            <div class="alert alert-warning small mb-3">
                                <i class="bi bi-info-circle me-1"></i> 
                                Se registrará un bloqueo de fondos sobre la cuenta <strong>${cuenta.numCuenta}</strong>.
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold small">Monto a Retener</label>
                                <div class="input-group">
                                    <span class="input-group-text">${cuenta.desMoneda eq 'Dólares' ? '$' : 'S/'}</span>
                                    <input type="number" step="0.01" min="0.01" class="form-control" name="montoEmbargo" placeholder="0.00" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold small">N° Expediente / Oficio</label>
                                <input type="text" class="form-control" name="expediente" placeholder="Ej: EXP-2025-001" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label fw-bold small">Descripción / Motivo</label>
                                <textarea class="form-control" name="descripcion" rows="3" placeholder="Detalle el motivo..." required></textarea>
                            </div>

                            <div class="text-end">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                <button type="submit" class="btn btn-danger px-4 fw-bold">Registrar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalEditarEmbargo" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-white">
                        <h5 class="modal-title">Gestionar Embargo</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form action="${pageContext.request.contextPath}/ControlEmbargo" method="post">
                            <input type="hidden" name="accion" value="actualizar">
                            <input type="hidden" name="codEmbargo" id="editCod">
                            <input type="hidden" name="numCuentaHidden" id="editCta">

                            <div class="mb-3">
                                <label class="form-label fw-bold text-muted small">ACCIÓN</label>
                                <select class="form-select fw-bold" name="estado" id="editEstado">
                                    <option value="ACTIVO">MANTENER ACTIVO</option>
                                    <option value="LEVANTADO" class="text-success">LEVANTAR (Liberar Fondos)</option>
                                </select>
                            </div>

                            <div class="row g-2 mb-3">
                                <div class="col-6">
                                    <label class="small text-muted">Monto a Liberar</label>
                                    <input type="text" class="form-control" name="monto" id="editMonto" readonly>
                                </div>
                                <div class="col-6">
                                    <label class="small text-muted">Expediente</label>
                                    <input type="text" class="form-control" id="editExp" readonly>
                                </div>
                            </div>

                            <div class="modal-footer border-0 px-0">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                                <button type="submit" class="btn btn-primary">Guardar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <%@ include file="../util/cont-sesion.jsp" %>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sidebar.js"></script>
        <script src="${pageContext.request.contextPath}/js/session-timer.js"></script>
        <script src="${pageContext.request.contextPath}/js/gestion-embargos.js"></script>
    </body>
</html>