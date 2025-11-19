<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Confirmar Depósito - Quantum Bank</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/portal-global.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    </head>
    <body class="bg-light">
        <jsp:include page="../../util/header-cliente.jsp" />

        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-5">
                    <div class="card shadow border-0 rounded-4">
                        <div class="card-body p-4 text-center">

                            <div class="mb-4">
                                <div class="bg-primary bg-opacity-10 text-primary rounded-circle d-inline-flex p-3 mb-3">
                                    <i class="bi bi-check-lg display-6"></i>
                                </div>
                                <h4 class="fw-bold">Confirmar Operación</h4>
                                <p class="text-muted small">Revise los datos antes de finalizar.</p>
                            </div>

                            <ul class="list-group list-group-flush text-start mb-4">
                                <li class="list-group-item py-3 d-flex justify-content-between">
                                    <span class="text-muted">Cuenta Destino:</span>
                                    <span class="fw-bold font-monospace">${sessionScope.dep_cuenta.numCuenta}</span>
                                </li>
                                <li class="list-group-item py-3 d-flex justify-content-between">
                                    <span class="text-muted">Moneda:</span>
                                    <span class="fw-bold">${sessionScope.dep_cuenta.desMoneda}</span>
                                </li>
                                <li class="list-group-item py-3 d-flex justify-content-between align-items-center">
                                    <span class="text-muted">Monto a Depositar:</span>
                                    <span class="fw-bold fs-5 text-primary">
                                        ${sessionScope.dep_cuenta.codMoneda eq 'USD' ? '$' : 'S/'} 
                                        <fmt:formatNumber value="${sessionScope.dep_monto}" minFractionDigits="2"/>
                                    </span>
                                </li>
                                <c:if test="${not empty sessionScope.dep_origen}">
                                    <li class="list-group-item py-3 bg-light">
                                        <span class="d-block text-muted small mb-1">Origen de Fondos:</span>
                                        <span class="fw-medium fst-italic">${sessionScope.dep_origen}</span>
                                    </li>
                                </c:if>
                            </ul>

                            <form action="${pageContext.request.contextPath}/ControlDepositoCliente" method="POST">
                                <input type="hidden" name="accion" value="ejecutar">
                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-success btn-lg fw-semibold">
                                        Confirmar Depósito
                                    </button>
                                    <a href="${pageContext.request.contextPath}/ControlDepositoCliente?accion=vista" class="btn btn-outline-secondary">
                                        Corregir Datos
                                    </a>
                                </div>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="../../util/cont-sesion.jsp" />
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/session-timer.js"></script>
    </body>
</html>