<%-- 
  Document   : apertura-cuenta.jsp
  Ubicación  : /modulo-clientes/productos/apertura-cuenta.jsp
  Descripción: (V-06) Paso 1: Seleccionar producto.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Apertura de Cuenta - Quantum Bank</title>

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

                    <h2 class="h4 fw-bold mb-4 text-center">Apertura de Cuenta</h2>

                    <div class="card shadow-sm border-0">
                        <div class="card-body p-4 p-md-5">

                            <form action="apertura-confirmar.jsp" method="POST">

                                <h5 class="step-title mb-3">1. Seleccione el Producto</h5>
                                <div class="mb-3">
                                    <label for="tipoCuenta" class="form-label">Tipo de Cuenta</label>
                                    <select class="form-select" id="tipoCuenta" name="tipoCuenta" required>
                                        <option value="">Seleccionar producto...</option>
                                        <option value="AHORRO">Cuenta de Ahorros</option>
                                        <option value="CORRIENTE">Cuenta Corriente</option>
                                        <option value="PLAZOS">Cuenta a Plazos</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label for="moneda" class="form-label">Moneda</label>
                                    <select class="form-select" id="moneda" name="moneda" required>
                                        <option value="PEN">Soles (PEN)</option>
                                        <option value="USD">Dólares (USD)</option>
                                    </select>
                                </div>

                                <hr class="my-4">

                                <div class="d-none" id="plazoFijoFields">
                                    <h5 class="step-title mb-3">2. Condiciones del Plazo</h5>
                                    <div class="form-floating mb-3">
                                        <input type="number" step="0.01" class="form-control" id="inpMontoApertura" name="inpMontoApertura" placeholder="0.00">
                                        <label for="inpMontoApertura">Monto de Apertura</label>
                                    </div>
                                    <div class="form-floating mb-3">
                                        <input type="number" class="form-control" id="inpPlazoMeses" name="inpPlazoMeses" placeholder="Ej: 12">
                                        <label for="inpPlazoMeses">Plazo (en meses)</label>
                                    </div>

                                    <div class="form-floating mb-3">
                                        <input type="text" class="form-control" id="inpInteresMensual" name="inpInteresMensual" value="2.5%" readonly>
                                        <label for="inpInteresMensual">Interés Mensual (TEA)</label>
                                    </div>
                                    <hr class="my-4">
                                </div>

                                <div class="d-grid mt-4">
                                    <button type="submit" class="btn btn-primary btn-lg fw-semibold" id="btnContinuar">
                                        Continuar
                                    </button>
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

        <script src="${pageContext.request.contextPath}/js/apertura-cuenta.js"></script>
    </body>
</html>