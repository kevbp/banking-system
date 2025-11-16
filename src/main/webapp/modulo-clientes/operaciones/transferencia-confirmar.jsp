<%-- 
  Document   : transferencia-confirmar.jsp
  Ubicación  : /modulo-clientes/transferencias/transferencia-confirmar.jsp
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Confirmar Transferencia - Quantum Bank</title>

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

                    <h2 class="h4 fw-bold mb-4 text-center">Verificar Datos</h2>

                    <div class="card shadow-sm border-0">
                        <div class="card-body p-4 p-md-5">

                            <div class="text-center">
                                <i class="bi bi-shield-check text-primary display-3"></i>
                                <h5 class="step-title mt-3">Confirme su Transferencia</h5>
                                <p class="text-muted">Revise que los datos sean correctos antes de continuar.</p>
                            </div>

                            <hr class="my-4">

                            <ul class="list-group list-group-flush">
                                <li class="list-group-item d-flex justify-content-between">
                                    <span>Desde (Origen):</span>
                                    <strong>Ahorros Soles (001...001)</strong>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    <span>Titular Origen:</span>
                                    <strong>Juan Pérez (Tú)</strong>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    <span>Para (Destino):</span>
                                    <strong>Maria Lopez (Verificado)</strong>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    <span>N° Cuenta Destino:</span>
                                    <strong>002-XXXX-002</strong>
                                </li>
                                <li class="list-group-item d-flex justify-content-between">
                                    <span>Monto a Enviar:</span>
                                    <strong class="h5 text-danger">S/ 50.00</strong>
                                </li>
                            </ul>

                            <c:set var="monedasDiferentes" value="${true}" /> 
                            <c:if test="${monedasDiferentes}">
                                <div class="alert alert-warning mt-3" id="avisoTipoCambio">
                                    <i class="bi bi-info-circle-fill me-2"></i>
                                    Está transfiriendo entre monedas distintas. Se aplicará el <strong>T.C. Venta: S/ 3.414</strong>.
                                </div>
                            </c:if>

                            <form action="transferencia-exito.jsp" method="POST" class="mt-5">
                                <div class="row g-2">
                                    <div class="col-6 d-grid">
                                        <a href="transferencia.jsp" class="btn btn-outline-secondary btn-lg">Cancelar</a>
                                    </div>
                                    <div class="col-6 d-grid">
                                        <button type="submit" class="btn btn-primary btn-lg fw-semibold">Confirmar</button>
                                    </div>
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
        <script src="${pageContext.request.contextPath}/js/portal-cliente.js"></script>
    </body>
</html>