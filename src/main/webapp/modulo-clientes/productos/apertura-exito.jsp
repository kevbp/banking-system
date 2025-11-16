<%-- 
  Document   : apertura-exito.jsp
  Ubicación  : /modulo-clientes/productos/apertura-exito.jsp
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Apertura Exitosa - Quantum Bank</title>

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-global.css"/> 
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/transferencia.css"/> 
    </head>

    <body data-active-page="productos" class="client-portal-body">

        <jsp:include page="/util/header-cliente.jsp" />
        <div class="tc-banner">...</div> <div class="container-fluid p-4 client-portal-content">
            <div class="row justify-content-center">
                <div class="col-lg-7">

                    <div class="card shadow-sm border-0">
                        <div class="card-body p-4 p-md-5">

                            <div class="text-center">
                                <i class="bi bi-check-circle-fill text-success display-1"></i>
                                <h2 class="h4 fw-bold mt-3">¡Cuenta Creada Exitosamente!</h2>
                                <p class="text-muted">N° de Cuenta Nueva: 001-XXXX-005</p>
                            </div>

                            <hr class="my-4">

                            <ul class="list-group list-group-flush">
                                <li class="list-group-item d-flex justify-content-between">
                                    <span>Titular:</span>
                                    <strong>Juan Pérez (Tú)</strong>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    <span>Producto:</span>
                                    <strong>Cuenta de Ahorros</strong>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    <span>Moneda:</span>
                                    <strong>Soles (PEN)</strong>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    <span>Saldo Inicial:</span>
                                    <strong class="h5 text-dark">S/ 0.00</strong>
                                </li>
                            </ul>

                            <div class="row g-2 mt-5">
                                <div class="col-6 d-grid">
                                    <a href="${pageContext.request.contextPath}/modulo-clientes/dashboard-cliente.jsp" class="btn btn-outline-secondary btn-lg">Volver al Inicio</a>
                                </div>
                                <div class="col-6 d-grid">
                                    <a href="apertura-cuenta.jsp" class="btn btn-primary btn-lg fw-semibold">Abrir otra Cuenta</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div> <jsp:include page="/util/cont-sesion.jsp" />

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/session-timer.js"></script>
        <script src="${pageContext.request.contextPath}/js/portal-cliente.js"></script>
    </body>
</html>