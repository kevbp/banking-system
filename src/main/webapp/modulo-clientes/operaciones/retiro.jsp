<%-- 
  Document   : retiro.jsp
  Ubicación  : /modulo-clientes/operaciones/retiro.jsp
  Descripción: (V-08) Paso 1: Ingresar datos del retiro.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Retiros - Quantum Bank</title>

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

                    <h2 class="h4 fw-bold mb-4 text-center">Realizar un Retiro</h2>

                    <div class="card shadow-sm border-0">
                        <div class="card-body p-4 p-md-5">

                            <form action="retiro-confirmar.jsp" method="POST">

                                <h5 class="step-title mb-3">1. Cuenta de Origen</h5>
                                <div class="mb-3">
                                    <label for="cuentaOrigen" class="form-label">Seleccione su cuenta de ahorros</label>
                                    <select class="form-select" id="cuentaOrigen" name="cuentaOrigen" required>
                                        <option value="" data-saldo="0" data-moneda="">Seleccionar cuenta...</option>
                                        <option value="Ahorros Soles (001...001)" data-saldo="1250.50" data-moneda="PEN">Ahorros Soles (001...001)</option>
                                    </select>
                                </div>

                                <div id="saldoDisponible" class="saldo-display-box d-none">
                                    <span class="label">Saldo Disponible:</span>
                                    <span class="valor" id="saldoValor">S/ 0.00</span>
                                </div>

                                <hr class="my-4">

                                <h5 class="step-title mb-3">2. Importe</h5>
                                <div class="mb-3">
                                    <label for="monto" class="form-label">Monto a Retirar</label>
                                    <input type="number" step="0.01" class="form-control form-control-lg" id="monto" name="monto" placeholder="0.00" required>
                                </div>

                                <div class="text-danger small d-none mb-3" id="saldoError">
                                    <i class="bi bi-exclamation-circle-fill"></i> El monto es mayor a su saldo disponible.
                                </div>

                                <div class="d-grid mt-5">
                                    <button type="submit" class="btn btn-primary btn-lg fw-semibold" id="btnContinuar" disabled>
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

        <script src="${pageContext.request.contextPath}/js/retiro.js"></script>
    </body>
</html>