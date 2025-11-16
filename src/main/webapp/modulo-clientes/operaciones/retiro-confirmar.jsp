<%-- 
  Document   : retiro-confirmar.jsp
  Ubicación  : /modulo-clientes/operaciones/retiro-confirmar.jsp
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Confirmar Retiro - Quantum Bank</title>

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-global.css"/> 
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/deposito.css"/> 
    </head>

    <body class="client-portal-body">

        <jsp:include page="/util/header-cliente.jsp" />
        <div class="tc-banner">...</div> <div class="container-fluid p-4 client-portal-content">
            <div class="row justify-content-center">
                <div class="col-lg-7">

                    <h2 class="h4 fw-bold mb-4 text-center">Verificar Retiro</h2>

                    <div class="card shadow-sm border-0">
                        <div class="card-body p-4 p-md-5">

                            <div class="text-center">
                                <i class="bi bi-shield-check text-primary display-3"></i>
                                <h5 class="step-title mt-3">Confirme los Datos</h5>
                            </div>

                            <hr class="my-4">

                            <ul class="list-group list-group-flush">
                                <li class="list-group-item d-flex justify-content-between">
                                    <span>Cuenta de Origen:</span>
                                    <strong>Ahorros Soles (001...001)</strong>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    <span>Monto a Retirar:</span>
                                    <strong class="h5 text-danger">S/ 200.00</strong>
                                </li>
                            </ul>

                            <form action="retiro-exito.jsp" method="POST" class="mt-5">
                                <div class="row g-2">
                                    <div class="col-6 d-grid">
                                        <a href="retiro.jsp" class="btn btn-outline-secondary btn-lg">Cancelar</a>
                                    </div>
                                    <div class="col-6 d-grid">
                                        <button type="submit" class="btn btn-primary btn-lg fw-semibold">Confirmar Retiro</button>
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