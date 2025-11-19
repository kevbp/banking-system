<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Detalle de Cuenta - Quantum Bank</title>

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <link href="${pageContext.request.contextPath}/css/portal-global.css" rel="stylesheet">

        <style>
            body {
                background-color: #f8f9fa;
                font-family: 'Poppins', sans-serif;
            }

            /* Tarjeta Principal con Degradado */
            .account-hero-card {
                background: linear-gradient(135deg, #0d6efd 0%, #0043a8 100%);
                color: white;
                border-radius: 1rem;
                box-shadow: 0 10px 25px rgba(13, 110, 253, 0.15);
                position: relative;
                overflow: hidden;
            }

            .account-hero-card::after {
                content: '';
                position: absolute;
                top: 0;
                right: 0;
                bottom: 0;
                width: 40%;
                background: linear-gradient(90deg, rgba(255,255,255,0) 0%, rgba(255,255,255,0.1) 100%);
                clip-path: polygon(20% 0%, 100% 0%, 100% 100%, 0% 100%);
            }

            /* Detalles de la cuenta en la tarjeta */
            .account-detail-label {
                font-size: 0.75rem;
                text-transform: uppercase;
                letter-spacing: 1px;
                opacity: 0.8;
                margin-bottom: 0.25rem;
            }

            .account-detail-value {
                font-family: 'Courier New', monospace;
                font-weight: 600;
                font-size: 1.1rem;
            }

            /* Tabla de Movimientos */
            .movements-card {
                border: none;
                border-radius: 1rem;
                box-shadow: 0 4px 6px rgba(0,0,0,0.02);
            }

            .table-custom th {
                background-color: #f8f9fa;
                border-bottom: 2px solid #e9ecef;
                color: #6c757d;
                font-weight: 600;
                text-transform: uppercase;
                font-size: 0.75rem;
                padding-top: 1rem;
                padding-bottom: 1rem;
            }

            .table-custom td {
                vertical-align: middle;
                padding: 1rem 0.75rem;
                border-bottom: 1px solid #f1f3f5;
            }

            .amount-pos {
                color: #198754;
                font-weight: 600;
            }
            .amount-neg {
                color: #dc3545;
                font-weight: 600;
            }

            .transaction-icon {
                width: 36px;
                height: 36px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 10px;
                font-size: 1rem;
            }

            /* Botón Copiar */
            .btn-copy {
                background: rgba(255,255,255,0.2);
                border: none;
                color: white;
                width: 32px;
                height: 32px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 8px;
                transition: background 0.2s;
            }
            .btn-copy:hover {
                background: rgba(255,255,255,0.3);
                color: white;
            }
        </style>
    </head>
    <body>

        <%@ include file="../util/header-cliente.jsp" %>

        <div class="container py-4">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <a href="${pageContext.request.contextPath}/ControlLoginCliente?accion=dashboard" class="btn btn-outline-secondary border-0 bg-white shadow-sm rounded-pill px-3">
                    <i class="bi bi-arrow-left me-1"></i> Volver a Mis Cuentas
                </a>

                <div class="dropdown">
                    <button class="btn btn-white bg-white shadow-sm border dropdown-toggle rounded-pill px-3" type="button" data-bs-toggle="dropdown">
                        <c:choose>
                            <c:when test="${not empty cuentaActual}">
                                <i class="bi bi-wallet2 text-primary me-2"></i>
                                <span class="fw-medium me-1">${cuentaActual.desTipoCuenta}</span>
                                <small class="text-muted font-monospace">${cuentaActual.numCuenta}</small>
                            </c:when>
                            <c:otherwise>Seleccione Cuenta</c:otherwise>
                        </c:choose>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end shadow border-0 rounded-3 mt-2 p-1">
                        <c:forEach var="c" items="${misCuentas}">
                            <li>
                                <a class="dropdown-item rounded-2 py-2 d-flex align-items-center justify-content-between" 
                                   href="${pageContext.request.contextPath}/ControlLoginCliente?accion=detalle&num=${c.numCuenta}">
                                    <div>
                                        <div class="fw-medium small">${c.desTipoCuenta}</div>
                                        <div class="text-muted x-small font-monospace">${c.numCuenta}</div>
                                    </div>
                                    <span class="badge bg-light text-dark ms-3 border">${c.desMoneda}</span>
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>

            <c:if test="${not empty cuentaActual}">
                <div class="row g-4">

                    <div class="col-lg-5">

                        <div class="card account-hero-card mb-4 border-0">
                            <div class="card-body p-4 position-relative z-1">
                                <div class="d-flex justify-content-between align-items-start mb-4">
                                    <div>
                                        <span class="badge bg-white bg-opacity-25 border border-white border-opacity-25 fw-normal mb-2">
                                            ${cuentaActual.desTipoCuenta}
                                        </span>
                                        <h6 class="text-white-50 mb-0">Saldo Disponible</h6>
                                    </div>
                                    <div class="text-end">
                                        <i class="bi bi-person-circle h4 mb-0 opacity-50"></i>
                                    </div>
                                </div>

                                <h2 class="display-4 fw-bold mb-4">
                                    ${cuentaActual.codMoneda eq 'USD' ? '$' : 'S/'} 
                                    <fmt:formatNumber value="${cuentaActual.salAct}" minFractionDigits="2" maxFractionDigits="2"/>
                                </h2>

                                <div class="row g-3 pt-3 border-top border-white border-opacity-10">
                                    <div class="col-12">
                                        <div class="d-flex align-items-end justify-content-between">
                                            <div>
                                                <div class="account-detail-label">Número de Cuenta</div>
                                                <div class="d-flex align-items-center">
                                                    <span id="textNroCuenta" class="account-detail-value me-2">${cuentaActual.numCuenta}</span>
                                                </div>
                                            </div>
                                            <button id="btnCopiarCuentas" class="btn-copy" data-bs-toggle="tooltip" data-bs-placement="top" title="Copiar datos">
                                                <i class="bi bi-copy"></i>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="account-detail-label">CCI Interbancario</div>
                                        <span id="textCCI" class="account-detail-value small opacity-75">CCI: ${cuentaActual.cci != null ? cuentaActual.cci : 'No asignado'}</span>
                                    </div>
                                </div>

                                <c:if test="${cuentaActual.sobregiro > 0}">
                                    <div class="mt-3 p-2 bg-white bg-opacity-10 rounded text-center small border border-white border-opacity-10">
                                        <i class="bi bi-info-circle me-1"></i> Línea de Sobregiro: 
                                        <strong>${cuentaActual.codMoneda eq 'USD' ? '$' : 'S/'} <fmt:formatNumber value="${cuentaActual.sobregiro}" minFractionDigits="2"/></strong>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <div class="card border-0 shadow-sm rounded-4">
                            <div class="card-body p-4">
                                <h6 class="fw-bold mb-3 text-muted text-uppercase small ls-1">Información General</h6>
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item px-0 d-flex justify-content-between border-bottom-0 py-2">
                                        <span class="text-muted"><i class="bi bi-calendar3 me-2"></i>Fecha Apertura</span>
                                        <span class="fw-medium text-dark"><fmt:formatDate value="${cuentaActual.fecApe}" pattern="dd/MM/yyyy"/></span>
                                    </li>
                                    <li class="list-group-item px-0 d-flex justify-content-between border-bottom-0 py-2">
                                        <span class="text-muted"><i class="bi bi-coin me-2"></i>Moneda</span>
                                        <span class="fw-medium text-dark">${cuentaActual.desMoneda}</span>
                                    </li>
                                    <li class="list-group-item px-0 d-flex justify-content-between border-bottom-0 py-2">
                                        <span class="text-muted"><i class="bi bi-check-circle me-2"></i>Estado</span>
                                        <span class="badge bg-success-subtle text-success border border-success-subtle px-3 rounded-pill">${cuentaActual.desEstado}</span>
                                    </li>
                                    <li class="list-group-item px-0 d-flex justify-content-between border-bottom-0 py-2">
                                        <span class="text-muted"><i class="bi bi-person me-2"></i>Titular</span>
                                        <span class="fw-medium text-dark text-end" style="max-width: 150px;">${sessionScope.clienteAut.nomUsuario}</span>
                                    </li>
                                </ul>
                            </div>
                        </div>

                    </div>

                    <div class="col-lg-7">
                        <div class="card movements-card h-100 bg-white">
                            <div class="card-header bg-transparent border-0 pt-4 pb-2 px-4 d-flex justify-content-between align-items-center">
                                <h5 class="fw-bold mb-0 text-dark">Últimos Movimientos</h5>
                                <button class="btn btn-sm btn-light text-muted"><i class="bi bi-download me-1"></i> Exportar</button>
                            </div>
                            <div class="card-body p-0">
                                <div class="table-responsive px-4 pb-4">
                                    <table class="table table-custom table-hover align-middle mb-0">
                                        <thead>
                                            <tr>
                                                <th scope="col" style="width: 35%">Descripción</th>
                                                <th scope="col">Fecha</th>
                                                <th scope="col" class="text-end">Monto</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="m" items="${movimientos}">
                                                <c:set var="isPos" value="${m.signo eq '+'}"/>
                                                <c:set var="iconClass" value="${isPos ? 'bi-arrow-down-left text-success bg-success-subtle' : 'bi-arrow-up-right text-danger bg-danger-subtle'}"/>
                                                <c:set var="amountClass" value="${isPos ? 'amount-pos' : 'amount-neg'}"/>

                                                <tr>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <div class="transaction-icon ${iconClass}">
                                                                <i class="bi ${isPos ? 'bi-arrow-down-short' : 'bi-arrow-up-short'} display-6" style="font-size: 1.2rem"></i>
                                                            </div>
                                                            <div class="line-height-sm">
                                                                <div class="fw-medium text-dark text-truncate" style="max-width: 200px;" title="${m.des}">
                                                                    ${m.des}
                                                                </div>
                                                                <small class="text-muted font-monospace" style="font-size: 0.75rem">Op: ${m.codTransaccion}</small>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="d-flex flex-column">
                                                            <span class="fw-medium text-dark"><fmt:formatDate value="${m.fec}" pattern="dd MMM"/></span>
                                                            <small class="text-muted"><fmt:formatDate value="${m.fec}" pattern="HH:mm"/></small>
                                                        </div>
                                                    </td>
                                                    <td class="text-end">
                                                        <div class="${amountClass} fs-6">
                                                            ${m.signo} ${cuentaActual.codMoneda eq 'USD' ? '$' : 'S/'} 
                                                            <fmt:formatNumber value="${m.monto}" minFractionDigits="2"/>
                                                        </div>
                                                        <small class="text-muted">Saldo: <fmt:formatNumber value="${m.salFin}" minFractionDigits="2"/></small>
                                                    </td>
                                                </tr>
                                            </c:forEach>

                                            <c:if test="${empty movimientos}">
                                                <tr>
                                                    <td colspan="3" class="text-center py-5">
                                                        <div class="opacity-50">
                                                            <i class="bi bi-receipt display-4 d-block mb-2"></i>
                                                            <p class="mb-0">No hay movimientos recientes en esta cuenta.</p>
                                                        </div>
                                                    </td>
                                                </tr>
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
                <div class="text-center py-5 mt-5">
                    <div class="mb-4">
                        <div class="bg-warning-subtle text-warning rounded-circle d-inline-flex p-4">
                            <i class="bi bi-exclamation-triangle display-4"></i>
                        </div>
                    </div>
                    <h3 class="h4 fw-bold">No se pudo cargar la cuenta</h3>
                    <p class="text-muted mb-4">La cuenta solicitada no existe o no tienes permisos para verla.</p>
                    <a href="${pageContext.request.contextPath}/ControlLoginCliente?accion=dashboard" class="btn btn-primary px-4 py-2 rounded-pill">
                        Volver al Inicio
                    </a>
                </div>
            </c:if>

        </div>

        <%@ include file="../util/cont-sesion.jsp" %>

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/session-timer.js"></script>

        <script src="${pageContext.request.contextPath}/js/detalle-cuenta.js"></script>
    </body>
</html>