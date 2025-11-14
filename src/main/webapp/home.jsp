<%-- 
    Document   : home
    Created on : Oct 8, 2025, 6:08:47 PM
    Author     : kevin
--%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es-ES">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Panel Principal - Quantum Bank</title>

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css"> </head>

    <body data-active-page="home">
        <%@ include file="util/theme.jsp" %>

        <div class="d-flex">
            <%@ include file="util/sidebar.jsp" %>

            <div class="main-content flex-grow-1">
                <%@ include file="util/header.jsp" %>

                <div class="content-area p-4">
                    <h2 class="fw-semibold mb-2">Bienvenido, ${sessionScope.usuAut.username}</h2>
                    <p class="text-muted mb-4">Seleccione una opción del menú para comenzar.</p>

                    <div class="row">
                        <div class="col-md-4 mb-3">
                            <div class="card-dash">
                                <i class="bi bi-person-check icon" aria-hidden="true"></i>
                                <div>
                                    <h6>Clientes activos</h6>
                                    <p class="value is-loading" id="stat-clientes-activos">${clientesActivos}</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="card-dash">
                                <i class="bi bi-credit-card icon" aria-hidden="true"></i>
                                <div>
                                    <h6>Cuentas abiertas hoy</h6>
                                    <p class="value is-loading" id="stat-cuentas-hoy">...</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <div class="card-dash">
                                <i class="bi bi-cash-stack icon" aria-hidden="true"></i>
                                <div>
                                    <h6>Operaciones del día</h6>
                                    <p class="value is-loading" id="stat-operaciones-dia">...</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            window.APP_CONTEXT_PATH = "${pageContext.request.contextPath}";
        </script>

        <%@ include file="util/cont-sesion.jsp" %>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sidebar.js"></script>
        <script src="${pageContext.request.contextPath}/js/dashboard.js"></script>
        <script src="${pageContext.request.contextPath}/js/session-timer.js"></script>
    </body>
</html>