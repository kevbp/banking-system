<%-- 
  Document   : transferencia-error.jsp
  Ubicación  : /modulo-clientes/transferencias/transferencia-error.jsp
  Descripción: (V-09) Paso 3: Pantalla de error en la operación.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Error en Transferencia - Quantum Bank</title>

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-global.css"/> 
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/transferencia.css"/> 
    </head>

    <body data-active-page="transferir" class="client-portal-body">

        <jsp:include page="../../util/header-cliente.jsp" />

        <div class="container-fluid p-4 client-portal-content">
            <div class="row justify-content-center">
                <div class="col-lg-7">

                    <div class="card shadow-sm border-0">
                        <div class="card-body p-4 p-md-5">

                            <div class="text-center">
                                <i class="bi bi-x-circle-fill text-danger display-1"></i>

                                <h2 class="h4 fw-bold mt-3">Error en la Transferencia</h2>

                                <p class="text-muted fs-5 mt-3">
                                <c:choose>
                                    <c:when test="${not empty requestScope.error}">
                                        ${requestScope.error}
                                    </c:when>
                                    <c:otherwise>
                                        No pudimos procesar tu solicitud. Por favor, inténtalo de nuevo más tarde.
                                    </c:otherwise>
                                </c:choose>
                                </p>
                            </div>

                            <hr class="my-4">

                            <p class="text-center text-muted">Detalles de la operación (Datos estáticos de ejemplo):</p>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item d-flex justify-content-between">
                                    <span>Desde:</span>
                                    <strong>Ahorros Soles (001...001)</strong>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    <span>Para (Cuenta):</span>
                                    <strong>002-XXXX-002</strong>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    <span>Monto:</span>
                                    <strong class="h5 text-dark">S/ 50.00</strong>
                                </li>
                            </ul>

                            <div class="row g-2 mt-5">
                                <div class="col-6 d-grid">
                                    <a href="${pageContext.request.contextPath}/modulo-clientes/dashboard-cliente.jsp" class="btn btn-outline-secondary btn-lg">Volver al Inicio</a>
                                </div>
                                <div class="col-6 d-grid">
                                    <a href="transferencia.jsp" class="btn btn-primary btn-lg fw-semibold">Volver a Intentar</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div> <jsp:include page="../../util/cont-sesion.jsp" />

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/session-timer.js"></script>
        <script src="${pageContext.request.contextPath}/js/portal-cliente.js"></script>
    </body>
</html>