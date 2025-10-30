<%-- 
    Document   : apertura-cuentas
    Created on : Oct 12, 2025, 5:29:49 PM
    Author     : kevin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <script src="${pageContext.request.contextPath}/js/color-modes.js"></script>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/sidebars.css" rel="stylesheet">
        <title>Apertura de cuentas</title>
    </head>
    <body>
        <%@ include file="../util/theme.jsp" %>
        <div class="d-flex">
            <%@ include file="../util/sidebar.jsp" %>
            <div class="container mt-5 mb-4">
                <div class="card shadow-sm">
                    <div class="card-header bg-dark text-light text-center">
                        <h4 class="mb-0">Apertura de Cuenta</h4>
                    </div>

                    <div class="card-body">
                        <p class="text-muted">Complete los datos para crear una nueva cuenta bancaria. Los campos con <span class="text-danger">*</span> son obligatorios.</p>
                        <hr>

                        <form action="/ControlCuenta" method="post">

                            <!-- Datos del Cliente -->
                            <h5 class="mb-3">Datos del Cliente</h5>

                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <label for="numDoc" class="form-label">Número de Documento <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="numDoc" name="numDoc" placeholder="Ingrese DNI o RUC" required>
                                </div>

                                <div class="col-md-3 d-flex align-items-end">
                                    <button type="button" class="btn btn-secondary w-100" id="btnBuscarCliente">Buscar Cliente</button>
                                </div>

                                <div class="col-md-5">
                                    <label for="nomCliente" class="form-label">Nombre / Razón Social</label>
                                    <input type="text" class="form-control" id="nomCliente" name="nomCliente" placeholder="(Autocompletado al buscar)" readonly>
                                </div>
                            </div>

                            <hr>

                            <!-- Datos de la Cuenta -->
                            <h5 class="mb-3">Datos de la Cuenta</h5>

                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <label for="tipoCuenta" class="form-label">Tipo de Cuenta <span class="text-danger">*</span></label>
                                    <select class="form-select" id="tipoCuenta" name="tipoCuenta" required>
                                        <option value="">Seleccione...</option>
                                        <option value="AHORRO">Cuenta de Ahorros</option>
                                        <option value="CORRIENTE">Cuenta Corriente</option>
                                        <option value="PLAZO">Cuenta a Plazo</option>
                                    </select>
                                </div>

                                <div class="col-md-4">
                                    <label for="moneda" class="form-label">Moneda <span class="text-danger">*</span></label>
                                    <select class="form-select" id="moneda" name="moneda" required>
                                        <option value="">Seleccione...</option>
                                        <option value="PEN">Soles (PEN)</option>
                                        <option value="USD">Dólares (USD)</option>
                                    </select>
                                </div>

                                <div class="col-md-4">
                                    <label for="saldoApertura" class="form-label">Saldo de Apertura</label>
                                    <input type="number" step="0.01" class="form-control" id="saldoApertura" name="saldoApertura" placeholder="0.00" min="500">
                                </div>
                            </div>

                            <!-- Campos adicionales para Cuenta a Plazo -->
                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <label for="plazo" class="form-label">Plazo (meses)</label>
                                    <input type="number" class="form-control" id="plazo" name="plazo" placeholder="Ej: 12">
                                </div>

                                <div class="col-md-4">
                                    <label for="interes" class="form-label">Interés Mensual (%)</label>
                                    <input type="number" step="0.01" class="form-control" id="interes" name="interes" placeholder="Ej: 2.5">
                                </div>
                            </div>

                            <hr>

                            <!-- Datos del Sistema -->
                            <h5 class="mb-3">Datos del Sistema</h5>

                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="numCuenta" class="form-label">Número de Cuenta</label>
                                    <input type="text" class="form-control" id="numCuenta" name="numCuenta" placeholder="Se generará automáticamente" readonly>
                                </div>
                                <div class="col-md-6">
                                    <label for="fecApertura" class="form-label">Fecha de Apertura</label>
                                    <input type="date" class="form-control" id="fecApertura" name="fecApertura" readonly>
                                </div>
                            </div>

                            <hr>

                            <!-- Botones -->
                            <div class="text-center mt-4">
                                <button type="submit" class="btn btn-success px-4">Abrir Cuenta</button>
                                <button type="reset" class="btn btn-warning px-4">Limpiar</button>
                                <a href="../home.jsp" class="btn btn-danger px-4">Cancelar</a>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sidebars.js"></script>
    </body>
</html>
