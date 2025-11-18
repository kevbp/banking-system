<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Apertura de Cuentas - Quantum Bank</title>

        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/estilos.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/sidebar.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>

    <title>Apertura de Cuentas - Quantum Bank</title> </head>

<body data-active-page="cuentas-apertura">
    <%@ include file="../util/theme.jsp" %>
    <div class="d-flex">
        <%@ include file="../util/sidebar.jsp" %>
        <div class="main-content flex-grow-1">
            <%@ include file="../util/header.jsp" %>

            <div class="content-area p-4">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-dark text-light text-center">
                        <h4 class="mb-0">Apertura de Cuenta</h4>
                    </div>
                    <div class="card-body p-4">

                        <div id="alertaForm" class="alert d-none"></div>

                        <form action="${pageContext.request.contextPath}/ControlCuenta" method="post" id="formApertura">
                            <input type="hidden" name="accion" value="abrir">
                            <input type="hidden" id="codClienteHide" name="codClienteHide" required>

                            <h5 class="mb-3 border-bottom pb-2">1. Datos del Cliente</h5>
                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <label for="numDoc" class="form-label">Número de Documento <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <input type="text" class="form-control" id="numDoc" name="numDoc" placeholder="DNI o RUC" maxlength="11" required>
                                        <button class="btn btn-primary" type="button" id="btnBuscarCliente">
                                            <i class="bi bi-search"></i>
                                        </button>
                                    </div>
                                    <small class="text-muted">Presione la lupa para buscar.</small>
                                </div>
                                <div class="col-md-8">
                                    <label for="nomCliente" class="form-label">Cliente (Nombre / Razón Social)</label>
                                    <input type="text" class="form-control bg-light" id="nomCliente" readonly placeholder="Se completará automáticamente...">
                                </div>
                            </div>

                            <h5 class="mb-3 border-bottom pb-2">2. Configuración del Producto</h5>
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="tipoCuenta" class="form-label">Seleccione el Producto <span class="text-danger">*</span></label>
                                    <select class="form-select" id="tipoCuenta" name="tipoCuenta" required>
                                        <option value="">-- Seleccione Producto --</option>
                                        <c:forEach var="tc" items="${listaTipos}">
                                            <c:if test="${tc.codEstado eq 'S0001'}">
                                                <option value="${tc.codTipCuenta}" 
                                                        data-moneda="${tc.codMoneda}" 
                                                        data-tasa="${tc.tasaInt}"
                                                        data-desc="${tc.descTipo}">
                                                    ${tc.descTipo} (${tc.codMoneda})
                                                </option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Moneda</label>
                                    <input type="text" class="form-control bg-light" id="txtMoneda" readonly>
                                    <input type="hidden" name="moneda" id="hiddenMoneda">
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Interés Anual (%)</label>
                                    <input type="text" class="form-control bg-light" id="txtInteres" name="interes" readonly>
                                </div>
                            </div>

                            <div class="row mb-3 d-none" id="rowPlazoFijo">
                                <div class="col-md-6">
                                    <label for="plazo" class="form-label">Plazo de Permanencia <span class="text-danger">*</span></label>
                                    <select class="form-select" id="plazo" name="plazo">
                                        <option value="">Seleccione...</option>
                                        <option value="3">3 Meses</option>
                                        <option value="6">6 Meses</option>
                                        <option value="9">9 Meses</option>
                                        <option value="12">12 Meses</option>
                                        <option value="18">18 Meses</option>
                                        <option value="24">24 Meses</option>
                                    </select>
                                </div>
                                <div class="col-md-6 d-flex align-items-end">
                                    <div class="alert alert-info py-2 w-100 mb-0">
                                        <i class="bi bi-info-circle me-1"></i> 
                                        Monto mínimo: <strong>S/ 500.00</strong> o <strong>$ 200.00</strong>
                                    </div>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="saldoApertura" class="form-label">Monto de Apertura <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text" id="simboloMoneda">S/</span>
                                        <input type="number" step="0.01" class="form-control" id="saldoApertura" name="saldoApertura" required min="0">
                                    </div>
                                    <div class="form-text" id="helpSaldo">Monto mínimo: 0.00</div>
                                </div>
                            </div>

                            <h5 class="mb-3 border-bottom pb-2">3. Datos de Auditoría</h5>
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label class="form-label">Fecha de Operación</label>
                                    <input type="text" class="form-control bg-light" id="fecApertura" readonly>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Número de Cuenta (Preliminar)</label>
                                    <input type="text" class="form-control bg-light" value="Generado automáticamente al guardar" readonly>
                                </div>
                            </div>

                            <div class="text-center mt-4">
                                <button type="submit" class="btn btn-success px-5"><i class="bi bi-check-circle me-1"></i> Abrir Cuenta</button>
                                <a href="${pageContext.request.contextPath}/home.jsp" class="btn btn-secondary px-4">Cancelar</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%@ include file="../util/cont-sesion.jsp" %>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/sidebar.js"></script>
    <script>
        const contextPath = "${pageContext.request.contextPath}";
    </script>
    <script src="${pageContext.request.contextPath}/js/apertura-cuenta.js"></script>
    <script src="${pageContext.request.contextPath}/js/session-timer.js"></script>
</body>
</html>