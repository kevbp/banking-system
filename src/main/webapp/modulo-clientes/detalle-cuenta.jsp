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
            /* Estilos específicos para esta vista */
            .balance-card {
                background: linear-gradient(135deg, #0d6efd 0%, #0a58ca 100%);
                color: white;
            }
            .movement-table th {
                font-size: 0.85rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }
            .movement-table td {
                font-size: 0.95rem;
                vertical-align: middle;
            }
            .amount-pos {
                color: #198754;
                font-weight: 600;
            }
            .amount-neg {
                color: #dc3545;
                font-weight: 600;
            }
        </style>
    </head>
    <body class="bg-light">

        <%@ include file="../util/header-cliente.jsp" %>

        <div class="container py-4">

            <div class="row mb-4">
                <div class="col-md-6 col-lg-4">
                    <label class="form-label fw-bold text-secondary small">SELECCIONAR CUENTA</label>
                    <div class="input-group shadow-sm">
                        <span class="input-group-text bg-white border-end-0"><i class="bi bi-wallet2 text-primary"></i></span>
                        <select class="form-select border-start-0 ps-0 fw-bold text-primary" 
                                onchange="window.location.href = '${pageContext.request.contextPath}/ControlLoginCliente?accion=detalle&num=' + this.value;">
                            <c:forEach var="c" items="${misCuentas}">
                                <option value="${c.numCuenta}" ${c.numCuenta eq cuentaActual.numCuenta ? 'selected' : ''}>
                                    ${c.desTipoCuenta} - ${c.numCuenta} (${c.desMoneda})
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>

            <c:if test="${not empty cuentaActual}">
                <div class="row g-4">

                    <div class="col-lg-4">

                        <div class="card balance-card shadow border-0 mb-4">
                            <div class="card-body p-4 text-center">
                                <h6 class="text-white-50 fw-bold mb-3">SALDO DISPONIBLE</h6>
                                <h2 class="display-5 fw-bold mb-0">
                                    ${cuentaActual.codMoneda eq 'USD' ? '$' : 'S/'} 
                                    <fmt:formatNumber value="${cuentaActual.salAct}" minFractionDigits="2" maxFractionDigits="2"/>
                                </h2>

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

                        <div class="card shadow-sm border-0">
                            <div class="card-header bg-white fw-bold py-3">Detalles del Producto</div>
                            <div class="card-body">
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item d-flex justify-content-between px-0">
                                        <span class="text-muted">Número de Cuenta</span>
                                        <span class="font-monospace fw-bold">${cuentaActual.numCuenta}</span>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between px-0">
                                        <span class="text-muted">CCI</span>
                                        <span class="font-monospace small text-end">${cuentaActual.cci != null ? cuentaActual.cci : '-'}</span>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between px-0">
                                        <span class="text-muted">Tipo</span>
                                        <span>${cuentaActual.desTipoCuenta}</span>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between px-0">
                                        <span class="text-muted">Moneda</span>
                                        <span>${cuentaActual.desMoneda}</span>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between px-0">
                                        <span class="text-muted">Fecha Apertura</span>
                                        <span><fmt:formatDate value="${cuentaActual.fecApe}" pattern="dd/MM/yyyy"/></span>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between px-0">
                                        <span class="text-muted">Estado</span>
                                        <span class="badge bg-success">${cuentaActual.desEstado}</span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-8">
                        <div class="card shadow-sm border-0 h-100">
                            <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
                                <h6 class="mb-0 fw-bold">Últimos Movimientos</h6>
                                <button class="btn btn-sm btn-outline-secondary"><i class="bi bi-download"></i> Exportar</button>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-hover mb-0 movement-table align-middle">
                                    <thead class="table-light">
                                        <tr>
                                            <th class="ps-4">Fecha</th>
                                            <th>Descripción</th>
                                            <th>N° Operación</th>
                                            <th class="text-end pe-4">Monto</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="m" items="${movimientos}">
                                            <tr>
                                                <td class="ps-4 text-nowrap">
                                                    <div class="fw-bold"><fmt:formatDate value="${m.fec}" pattern="dd MMM"/></div>
                                                    <small class="text-muted"><fmt:formatDate value="${m.fec}" pattern="yyyy"/></small>
                                                </td>
                                                <td>
                                                    <div class="text-truncate" style="max-width: 300px;" title="${m.des}">
                                                        ${m.des}
                                                    </div>
                                                </td>
                                                <td class="font-monospace small text-muted">${m.codTransaccion}</td>
                                                <td class="text-end pe-4">
                                                    <span class="${m.signo eq '+' ? 'amount-pos' : 'amount-neg'}">
                                                        ${m.signo} ${cuentaActual.codMoneda eq 'USD' ? '$' : 'S/'} 
                                                        <fmt:formatNumber value="${m.monto}" minFractionDigits="2" maxFractionDigits="2"/>
                                                    </span>
                                                </td>
                                            </tr>
                                        </c:forEach>

                                        <c:if test="${empty movimientos}">
                                            <tr>
                                                <td colspan="4" class="text-center py-5 text-muted">
                                                    <i class="bi bi-receipt display-4 mb-3 d-block"></i>
                                                    No hay movimientos recientes.
                                                </td>
                                            </tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                </div>
            </c:if>

            <c:if test="${empty cuentaActual}">
                <div class="alert alert-warning text-center">
                    No se pudo cargar la información de la cuenta. <a href="ControlLoginCliente?accion=dashboard">Volver al inicio</a>.
                </div>
            </c:if>

        </div>

        <%@ include file="../util/cont-sesion.jsp" %>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/session-timer.js"></script>
    </body>
</html>