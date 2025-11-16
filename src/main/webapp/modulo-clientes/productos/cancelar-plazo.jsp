<%-- 
  Document   : cancelar-plazo.jsp
  Ubicación  : /modulo-clientes/productos/cancelar-plazo.jsp
  Descripción: (V-10) Paso 1: Confirmar cancelación de plazo.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Cancelar Cuenta a Plazo - Quantum Bank</title>

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-global.css"/> 
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/productos.css"/> 
    </head>

    <body data-active-page="cuentas" class="client-portal-body">

        <jsp:include page="/util/header-cliente.jsp" />
        <div class="tc-banner">...</div>

        <div class="container-fluid p-4 client-portal-content">
            <div class="row justify-content-center">
                <div class="col-lg-7">

                    <div class="mb-3">
                        <a href="${pageContext.request.contextPath}/modulo-clientes/detalle-cuenta.jsp" class="btn btn-link text-decoration-none p-0 btn-volver">
                            <i class="bi bi-arrow-left me-1"></i>
                            Volver al Detalle de Cuenta
                        </a>
                    </div>

                    <div class="card shadow-sm border-0">
                        <div class="card-body p-4 p-md-5">

                            <div class="text-center">
                                <i class="bi bi-exclamation-triangle-fill text-danger display-3"></i>
                                <h2 class="h4 fw-bold mt-3">Confirmar Cancelación Anticipada</h2>
                                <p class="text-muted">Está solicitando la cancelación de su Cuenta a Plazo Fijo antes de la fecha de vencimiento.</p>
                            </div>

                            <hr class="my-4">

                            <h5 class="step-title mb-3">Liquidación de Intereses</h5>

                            <ul class="list-group list-group-flush calculation-list">
                                <li class="list-group-item d-flex justify-content-between">
                                    <span>Monto Principal:</span>
                                    <strong>S/ 10,000.00</strong>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    <span>Interés Generado a la fecha:</span>
                                    <span class="text-success">+ S/ 15.30</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    <span>Penalidad por Cancelación:</span>
                                    <span class="text-danger">- S/ 5.00</span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between bg-light">
                                    <strong class="h5">Monto Total a Recibir:</strong>
                                    <strong class="h5 text-primary">S/ 10,010.30</strong>
                                </li>
                            </ul>

                            <div class="alert alert-warning mt-4">
                                <strong>Importante:</strong> El monto total será abonado en su <strong>Cuenta de Ahorros Soles (001...001)</strong>.
                            </div>

                            <form action="cancelar-exito.jsp" method="POST" class="mt-5">
                                <div class="row g-2">
                                    <div class="col-6 d-grid">
                                        <a href="${pageContext.request.contextPath}/modulo-clientes/detalle-cuenta.jsp" class="btn btn-outline-secondary btn-lg">No, volver</a>
                                    </div>
                                    <div class="col-6 d-grid">
                                        <button type="submit" class="btn btn-danger btn-lg fw-semibold">Sí, Cancelar Plazo</button>
                                    </div>
                                </div>
                            </form>
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