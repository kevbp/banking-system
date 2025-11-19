<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Realizar Depósito - Quantum Bank</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/portal-global.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/deposito.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    </head>

    <body class="client-portal-body">
        <jsp:include page="../../util/header-cliente.jsp" />

        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <div class="text-center mb-4">
                        <h2 class="h4 fw-bold text-dark">Depositar Fondos</h2>
                        <p class="text-muted">Ingreso de efectivo a cuenta propia o terceros</p>
                    </div>

                    <div class="card shadow-sm border-0 rounded-4">
                        <div class="card-body p-4 p-md-5">

                            <c:if test="${not empty msgError}">
                                <div class="alert alert-danger d-flex align-items-center mb-4" role="alert">
                                    <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                                    <div>${msgError}</div>
                                </div>
                            </c:if>

                            <form action="${pageContext.request.contextPath}/ControlDepositoCliente" method="POST" id="formDeposito">
                                <input type="hidden" name="accion" value="validar">
                                <input type="hidden" id="tasaCambioVenta" value="${tipoCambio != null ? tipoCambio.tasaVenta : 3.80}">

                                <div class="mb-4">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <label class="form-label fw-semibold mb-0">Cuenta de Destino</label>
                                        <div class="form-check form-switch">
                                            <input class="form-check-input cursor-pointer" type="checkbox" role="switch" id="checkPropia" checked>
                                            <label class="form-check-label small text-muted" for="checkPropia">A cuenta propia</label>
                                        </div>
                                    </div>

                                    <div id="divSelectCuenta">
                                        <select id="selectCuenta" name="cuentaDestino" class="form-select form-select-lg fs-6" required>
                                            <option value="" selected disabled>Seleccione una cuenta...</option>
                                            <c:forEach var="c" items="${misCuentas}">
                                                <option value="${c.numCuenta}" 
                                                        data-moneda="${c.codMoneda}" 
                                                        data-simbolo="${c.codMoneda eq 'USD' ? '$' : 'S/'}">
                                                    ${c.desTipoCuenta} - ${c.numCuenta} (${c.desMoneda})
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <c:if test="${empty misCuentas}">
                                            <div class="form-text text-danger">No se encontraron cuentas. Intente desmarcar "A cuenta propia".</div>
                                        </c:if>
                                    </div>

                                    <div id="divInputCuenta" class="d-none">
                                        <div class="input-group input-group-lg">
                                            <span class="input-group-text bg-white text-muted"><i class="bi bi-credit-card"></i></span>
                                            <input type="text" id="inputCuentaManual" name="cuentaDestino" class="form-control fs-6" 
                                                   placeholder="Ingrese N° de Cuenta Destino" disabled required>
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-2">
                                    <label for="monto" class="form-label fw-semibold">Monto a Depositar</label>
                                    <div class="input-group input-group-lg">
                                        <span class="input-group-text bg-light fw-bold" id="monedaSimbolo">S/</span>
                                        <input type="number" step="0.01" min="1" class="form-control" id="monto" name="monto" placeholder="0.00" required>
                                    </div>
                                </div>

                                <div id="divOrigen" class="mb-4 p-3 bg-warning-subtle border border-warning rounded-3 d-none animate-fade mt-3">
                                    <div class="d-flex align-items-start mb-2">
                                        <i class="bi bi-shield-exclamation text-warning-emphasis fs-5 me-2"></i>
                                        <div>
                                            <label class="form-label fw-bold text-warning-emphasis mb-0">Declaración de Origen</label>
                                            <div class="small text-muted" style="font-size: 0.85rem;">
                                                Normativa por montos superiores a S/ 2,000 (o eq. USD).
                                            </div>
                                        </div>
                                    </div>
                                    <input type="text" class="form-control mt-2" id="origenFondos" name="origenFondos" 
                                           placeholder="Ej: Ahorros, Venta de Bien..." autocomplete="off">
                                </div>

                                <div class="d-grid gap-2 mt-5">
                                    <button type="submit" class="btn btn-primary btn-lg fw-medium shadow-sm">Continuar</button>
                                    <a href="${pageContext.request.contextPath}/ControlLoginCliente?accion=dashboard" class="btn btn-light btn-lg text-muted">Cancelar</a>
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
        <script src="${pageContext.request.contextPath}/js/deposito-cliente.js"></script>

        <style>.animate-fade {
                animation: fadeIn 0.3s ease-in-out;
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(-10px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }</style>
    </body>
</html>