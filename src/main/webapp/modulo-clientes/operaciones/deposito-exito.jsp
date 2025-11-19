<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Depósito Exitoso - Quantum Bank</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/portal-global.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    </head>
    <body class="bg-light">
        <jsp:include page="../../util/header-cliente.jsp" />

        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-5">
                    <div class="card shadow-lg border-0 rounded-4">
                        <div class="card-body p-5 text-center">

                            <div class="mb-4 text-success">
                                <i class="bi bi-check-circle-fill display-1"></i>
                                <h3 class="fw-bold mt-3">¡Operación Exitosa!</h3>
                            </div>

                            <div class="p-4 bg-light rounded-3 mb-4 border">
                                <div class="text-muted small text-uppercase ls-1 mb-1">Monto Depositado</div>
                                <h2 class="display-6 fw-bold text-dark mb-0">
                                    ${v_cuenta.codMoneda eq 'USD' ? '$' : 'S/'} 
                                    <fmt:formatNumber value="${v_monto}" minFractionDigits="2"/>
                                </h2>
                            </div>

                            <div class="text-start px-2 mb-4">
                                <div class="row mb-2">
                                    <div class="col-5 text-muted">Cuenta Destino:</div>
                                    <div class="col-7 fw-bold font-monospace text-end">${v_cuenta.numCuenta}</div>
                                </div>
                                <div class="row mb-2">
                                    <div class="col-5 text-muted">Fecha y Hora:</div>
                                    <div class="col-7 fw-medium text-end">
                                        <jsp:useBean id="now" class="java.util.Date" />
                                        <fmt:formatDate value="${now}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-5 text-muted">N° Operación:</div>
                                    <div class="col-7 fw-bold text-end">TR-${now.time}</div>
                                </div>
                            </div>

                            <div class="d-grid gap-2">
                                <a href="${pageContext.request.contextPath}/ControlLoginCliente?accion=dashboard" class="btn btn-primary btn-lg">
                                    Volver al Inicio
                                </a>
                                <a href="${pageContext.request.contextPath}/ControlDepositoCliente?accion=vista" class="btn btn-link text-decoration-none">
                                    Realizar otro depósito
                                </a>
                            </div>

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