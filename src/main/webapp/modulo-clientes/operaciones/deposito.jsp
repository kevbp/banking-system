<%-- 
  Document   : deposito.jsp
  Ubicación  : /modulo-clientes/operaciones/deposito.jsp
  Descripción: (V-07) Paso 1: Ingresar datos del depósito.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Depósitos - Quantum Bank</title>

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-global.css"/> 
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/deposito.css"/> 
    </head>

    <body data-active-page="" class="client-portal-body">

        <jsp:include page="../../util/header-cliente.jsp" />
        <div class="tc-banner">...</div> <div class="container-fluid p-4 client-portal-content">
            <div class="row justify-content-center">
                <div class="col-lg-7">

                    <h2 class="h4 fw-bold mb-4 text-center">Realizar un Depósito</h2>

                    <div class="card shadow-sm border-0">
                        <div class="card-body p-4 p-md-5">

                            <form action="deposito-confirmar.jsp" method="POST">

                                <h5 class="step-title mb-3">1. Cuenta a Abonar</h5>
                                <div class="mb-3">
                                    <label for="cuentaDestino" class="form-label">Seleccione su cuenta</label>
                                    <select class="form-select" id="cuentaDestino" name="cuentaDestino" required>
                                        <option value="">Seleccionar cuenta...</option>
                                        <option value="Ahorros Soles (001...001)" data-moneda="PEN">Ahorros Soles (001...001)</option>
                                        <option value="Corriente Dólares (002...002)" data-moneda="USD">Corriente Dólares (002...002)</option>
                                    </select>
                                </div>

                                <hr class="my-4">

                                <h5 class="step-title mb-3">2. Importe</h5>
                                <div class="mb-3">
                                    <label for="monto" class="form-label">Monto a Depositar</label>
                                    <input type="number" step="0.01" class="form-control form-control-lg" id="monto" name="monto" placeholder="0.00" required>
                                </div>

                                <div class="form-floating mb-3 d-none" id="origenFondosContainer">
                                    <input type="text" class="form-control" id="origenFondos" name="origenFondos" placeholder="Ej: Venta de vehículo, ahorros...">
                                    <label for="origenFondos">Origen de los Fondos (Requerido)</label>
                                    <small class="form-text text-muted">
                                        Para depósitos superiores a S/ 2,000.00 (o su equivalente en USD), es requerido declarar el origen.
                                    </small>
                                </div>

                                <div class="d-grid mt-5">
                                    <button type="submit" class="btn btn-primary btn-lg fw-semibold" id="btnContinuar">
                                        Continuar
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div> <jsp:include page="../../util/cont-sesion.jsp" />

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/session-timer.js"></script>
        <script src="${pageContext.request.contextPath}/js/portal-cliente.js"></script>

        <script src="${pageContext.request.contextPath}/js/deposito.js"></script>
    </body>
</html>