<%-- 
    Document   : retiro
    Created on : Oct 12, 2025, 6:30:40 PM
    Author     : kevin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es-ES"> <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/estilos.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/sidebar.css" rel="stylesheet"> <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

        <title>Registro de Retiro - Quantum Bank</title> </head>

    <body data-active-page="operaciones-retiro">
        <%@ include file="../util/theme.jsp" %>

        <div class="d-flex">
            <%@ include file="../util/sidebar.jsp" %>

            <div class="main-content flex-grow-1">
                <%@ include file="../util/header.jsp" %>

                <div class="content-area p-4">
                    <div class="card shadow-sm border-0">
                        <div class="card-header bg-dark text-light text-center">
                            <h4 class="mb-0">Retiro de Cuenta</h4>
                        </div>

                        <div class="card-body p-4">
                            <p class="text-muted">
                                Registre retiros en cuentas de Ahorros o Corrientes. Verifique que la cuenta tenga saldo disponible y esté activa.
                            </p>
                            <hr>

                            <h5>Buscar Cuenta</h5>
                            <form action="/ControlRetiro" method="get" class="mb-4">
                                <div class="row g-3 align-items-end">
                                    <div class="col-md-5">
                                        <label for="numCuenta" class="form-label">Número de Cuenta</label>
                                        <input type="text" class="form-control" id="numCuenta" name="numCuenta" placeholder="Ej: 001-00012345">
                                    </div>
                                    <div class="col-md-3">
                                        <label for="tipoDoc" class="form-label">Tipo de Documento</label>
                                        <select class="form-select" id="tipoDoc" name="tipoDoc">
                                            <option value="">Seleccione...</option>
                                            <option value="DNI">DNI</option>
                                            <option value="RUC">RUC</option>
                                        </select>
                                    </div>
                                    <div class="col-md-3">
                                        <label for="numDoc" class="form-label">Número de Documento</label>
                                        <input type="text" class="form-control" id="numDoc" name="numDoc" placeholder="DNI o RUC">
                                    </div>
                                    <div class="col-md-1 d-grid">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="bi bi-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </form>

                            <hr>

                            <h5>Datos de la Cuenta</h5>
                            <table class="table table-bordered mb-4">
                                <tr><th>Cliente</th><td>Juan Pérez</td></tr>
                                <tr><th>Número de Cuenta</th><td>001-00012345</td></tr>
                                <tr><th>Tipo de Cuenta</th><td>Ahorros</td></tr>
                                <tr><th>Moneda</th><td>Soles</td></tr>
                                <tr><th>Saldo Actual</th><td>S/ 1,250.50</td></tr>
                                <tr><th>Estado</th><td>Activa</td></tr>
                                <tr><th>Embargo</th><td>No</td></tr>
                            </table>

                            <hr>

                            <h5>Registrar Retiro</h5>
                            <form action="/ControlRetiro" method="post">
                                <input type="hidden" name="accion" value="registrar">
                                <input type="hidden" name="numCuenta" value="001-00012345">

                                <div class="row mb-3">
                                    <div class="col-md-4">
                                        <label for="monto" class="form-label">Monto a Retirar <span class="text-danger">*</span></label>
                                        <input type="number" step="0.01" class="form-control" id="monto" name="monto" placeholder="0.00" required>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="medioPago" class="form-label">Medio de Entrega</label>
                                        <select class="form-select" id="medioPago" name="medioPago">
                                            <option value="Efectivo">Efectivo</option>
                                            <option value="Transferencia">Transferencia</option>
                                            <option value="Cheque">Cheque</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="fechaOperacion" class="form-label">Fecha de Operación</label>
                                        <input type="date" class="form-control" id="fechaOperacion" name="fechaOperacion" value="2025-10-12">
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="descripcion" class="form-label">Observaciones (opcional)</label>
                                    <textarea class="form-control" id="descripcion" name="descripcion" rows="2" placeholder="Ej: Retiro en ventanilla o transferencia saliente"></textarea>
                                </div>

                                <div class="text-center mt-4">
                                    <button type="submit" class="btn btn-danger px-4">Registrar Retiro</button>
                                    <a href="../home.jsp" class="btn btn-secondary px-4">Cancelar</a>
                                </div>
                            </form>
                        </div>
                    </div>
                </div> </div> </div> <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>

        <script src="${pageContext.request.contextPath}/js/sidebar.js"></script>

    </body>
</html>