<%-- 
  Document   : transferencia.jsp
  Ubicación  : /modulo-clientes/transferencias/transferencia.jsp
  Descripción: (V-09) Paso 1: Ingresar datos.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Transferencias - Quantum Bank</title>

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-global.css"/> 
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/transferencia.css"/> 
    </head>

    <body data-active-page="transferir" class="client-portal-body">

        <jsp:include page="/util/header-cliente.jsp" />

        <div class="container-fluid p-4 client-portal-content">

            <h2 class="h4 fw-bold mb-4 text-center">Realizar Transferencia</h2>

            <form action="transferencia-confirmar.jsp" method="POST">
                <div class="row g-4 d-flex justify-content-center">

                    <div class="col-lg-3 d-flex">
                        <div class="card shadow-sm border-0 h-100 w-100">
                            <div class="card-body p-4">
                                <div class="step-container">
                                    <span class="step-number">1</span>
                                    <h5 class="step-title">Cuenta de Origen</h5>
                                </div>

                                <div class="mb-3">
                                    <label for="cuentaOrigen" class="form-label">Seleccione su cuenta</label>
                                    <select class="form-select" id="cuentaOrigen" name="cuentaOrigen" required>
                                        <option value="" data-saldo="0" data-moneda="" data-titular="">Seleccionar cuenta...</option>
                                        <option value="001-001" data-saldo="1250.50" data-moneda="PEN" data-titular="Juan Pérez (Tú)">Ahorros Soles (001...001)</option>
                                        <option value="002-002" data-saldo="300.00" data-moneda="USD" data-titular="Juan Pérez (Tú)">Corriente Dólares (002...002)</option>
                                    </select>
                                </div>

                                <div class="form-floating mb-3 d-none" id="origenVerificado">
                                    <input type="text" class="form-control" id="nombreOrigen" value="" readonly>
                                    <label for="nombreOrigen">Titular</label>
                                </div>

                                <div id="saldoDisponible" class="saldo-display-box d-none">
                                    <span class="label">Saldo Disponible:</span>
                                    <span class="valor" id="saldoValor">S/ 0.00</span>
                                </div>
                            </div>
                        </div>
                    </div> <div class="col-lg-3 d-flex">
                        <div class="card shadow-sm border-0 h-100 w-100">
                            <div class="card-body p-4">
                                <div class="step-container">
                                    <span class="step-number">2</span>
                                    <h5 class="step-title">Cuenta Destino</h5>
                                </div>

                                <div class="mb-3">
                                    <label for="cuentaDestino" class="form-label">Número de Cuenta o CCI</label>
                                    <input type="text" class="form-control" id="cuentaDestino" name="cuentaDestino" placeholder="Ingrese N° de cuenta" required>
                                </div>

                                <input type="hidden" id="monedaDestinoSimulada" value="USD">

                            </div>
                        </div>
                    </div> <div class="col-lg-3 d-flex">
                        <div class="card shadow-sm border-0 h-100 w-100">
                            <div class="card-body p-4 d-flex flex-column"> 
                                <div class="step-container">
                                    <span class="step-number">3</span>
                                    <h5 class="step-title">Importe a Transferir</h5>
                                </div>

                                <div class="mb-3">
                                    <label for="monto" class="form-label">Monto</label>
                                    <input type="number" step="0.01" class="form-control form-control-lg" id="monto" name="monto" placeholder="0.00" required>
                                </div>

                                <div class="text-danger small d-none mb-3" id="saldoError">
                                    <i class="bi bi-exclamation-circle-fill"></i> El monto es mayor a su saldo disponible.
                                </div>

                                <div class="alert alert-warning mt-3 d-none" id="avisoTipoCambio">
                                    <i class="bi bi-info-circle-fill me-2"></i>
                                    Está transfiriendo entre monedas distintas. Se aplicará el <strong>T.C. Venta: S/ 3.414</strong>.
                                </div>

                                <div class="d-grid mt-auto"> 
                                    <button type="submit" class="btn btn-primary btn-lg fw-semibold" id="btnContinuar" disabled>
                                        Continuar
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div> </div> </form>

        </div> <jsp:include page="/util/cont-sesion.jsp" />
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/session-timer.js"></script>
        <script src="${pageContext.request.contextPath}/js/portal-cliente.js"></script>
        <script src="${pageContext.request.contextPath}/js/transferencia.js"></script>
    </body>
</html>