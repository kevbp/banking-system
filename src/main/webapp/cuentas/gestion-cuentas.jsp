<%-- 
    Document   : gestion-cuentas
    Created on : Oct 12, 2025, 5:45:49 PM
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

        <title>Gestión de Cuentas - Quantum Bank</title> </head>

    <body data-active-page="cuentas-gestion">
        <%@ include file="../util/theme.jsp" %>

        <div class="d-flex">
            <%@ include file="../util/sidebar.jsp" %>

            <div class="main-content flex-grow-1">
                <%@ include file="../util/header.jsp" %>

                <div class="content-area p-4">
                    <div class="card shadow-sm border-0">
                        <div class="card-header bg-dark text-light text-center">
                            <h4 class="mb-0">Gestión de Cuentas</h4>
                        </div>

                        <div class="card-body p-4">
                            <p class="text-muted">Busque y consulte las cuentas bancarias registradas. Puede ver su información y realizar acciones desde el modal.</p>
                            <hr>

                            <form action="/ControlCuenta" method="get" class="mb-4">
                                <div class="row g-3 align-items-end">

                                    <div class="col-md-3">
                                        <label for="numCuenta" class="form-label">Número de Cuenta</label>
                                        <input type="text" class="form-control" id="numCuenta" name="numCuenta" placeholder="Ej: 001-123456">
                                    </div>

                                    <div class="col-md-3">
                                        <label for="numDoc" class="form-label">Documento del Cliente</label>
                                        <input type="text" class="form-control" id="numDoc" name="numDoc" placeholder="DNI o RUC">
                                    </div>

                                    <div class="col-md-3">
                                        <label for="tipoCuenta" class="form-label">Tipo de Cuenta</label>
                                        <select class="form-select" id="tipoCuenta" name="tipoCuenta">
                                            <option value="">Todas</option>
                                            <option value="AHORRO">Ahorros</option>
                                            <option value="CORRIENTE">Corriente</option>
                                            <option value="PLAZO">Plazo Fijo</option>
                                        </select>
                                    </div>

                                    <div class="col-md-2">
                                        <label for="estado" class="form-label">Estado</label>
                                        <select class="form-select" id="estado" name="estado">
                                            <option value="">Todos</option>
                                            <option value="ACTIVA">Activa</option>
                                            <option value="INACTIVA">Inactiva</option>
                                            <option value="CERRADA">Cerrada</option>
                                            <option value="EMBARGADA">Embargada</option>
                                        </select>
                                    </div>

                                    <div class="col-md-1 d-grid">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="bi bi-search"></i>
                                        </button>
                                    </div>

                                </div>
                            </form>

                            <hr>

                            <h5 class="mb-3">Listado de Cuentas</h5>

                            <div class="table-responsive">
                                <table class="table table-bordered table-striped align-middle">
                                    <thead class="table-light text-center">
                                        <tr>
                                            <th>N° Cuenta</th>
                                            <th>Cliente</th>
                                            <th>Tipo</th>
                                            <th>Moneda</th>
                                            <th>Saldo</th>
                                            <th>Estado</th>
                                            <th>Acción</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>001-00012345</td>
                                            <td>Juan Pérez</td>
                                            <td>Ahorros</td>
                                            <td>Soles</td>
                                            <td>S/ 1,250.50</td>
                                            <td>Embargada</td>
                                            <td class="text-center">
                                                <button type="button" class="btn btn-sm btn-info" 
                                                        data-bs-toggle="modal" 
                                                        data-bs-target="#modalGestionCuenta"
                                                        data-nro-cuenta="001-00012345"
                                                        data-cliente="Juan Pérez"
                                                        data-tipo="Ahorros"
                                                        data-moneda="Soles"
                                                        data-saldo="S/ 1,250.50"
                                                        data-estado="Embargada"
                                                        data-fecha-apertura="2025-10-01"
                                                        data-embargo-activo="true"
                                                        data-embargo-monto="S/ 500.00"
                                                        data-embargo-exp="EXP-2025-00123"
                                                        data-embargo-motivo="Mandato judicial por deuda civil"
                                                        data-interes=""
                                                        data-plazo="">
                                                    Ver
                                                </button>
                                            </td>
                                        </tr>

                                        <tr>
                                            <td>002-00055678</td>
                                            <td>Comercial ABC S.A.C.</td>
                                            <td>Plazo Fijo</td>
                                            <td>Dólares</td>
                                            <td>$ 5,000.00</td>
                                            <td>Activa</td>
                                            <td class="text-center">
                                                <button type="button" class="btn btn-sm btn-info" 
                                                        data-bs-toggle="modal" 
                                                        data-bs-target="#modalGestionCuenta"
                                                        data-nro-cuenta="002-00055678"
                                                        data-cliente="Comercial ABC S.A.C."
                                                        data-tipo="Plazo Fijo"
                                                        data-moneda="Dólares"
                                                        data-saldo="$ 5,000.00"
                                                        data-estado="Activa"
                                                        data-fecha-apertura="2025-09-20"
                                                        data-embargo-activo="false"
                                                        data-interes="2.5%"
                                                        data-plazo="12 meses">
                                                    Ver
                                                </button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <div class="text-center mt-4">
                                <a href="../home.jsp" class="btn btn-secondary px-4">Cancelar</a>
                            </div>
                        </div>
                    </div>
                </div> </div> <div class="modal fade" id="modalGestionCuenta" tabindex="-1" aria-labelledby="modalGestionCuentaLabel" aria-hidden="true">
                <div class="modal-dialog modal-xl modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header bg-dark text-light">
                            <h5 class="modal-title" id="modalGestionCuentaLabel">Detalle de Cuenta</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">

                            <h6>Información General</h6>
                            <table class="table table-bordered">
                                <tr><th>Cliente</th><td id="modalCuentaCliente"></td></tr>
                                <tr><th>Tipo de Cuenta</th><td id="modalCuentaTipo"></td></tr>
                                <tr><th>Moneda</th><td id="modalCuentaMoneda"></td></tr>
                                <tr><th>Saldo Actual</th><td id="modalCuentaSaldo"></td></tr>
                                <tr><th>Estado</th><td id="modalCuentaEstado"></td></tr>
                                <tr><th>Fecha de Apertura</th><td id="modalCuentaFechaApertura"></td></tr>
                                <tr class="d-none" id="modalPlazoFijoFilaInteres">
                                    <th>Interés Mensual</th><td id="modalCuentaInteres"></td>
                                </tr>
                                <tr class="d-none" id="modalPlazoFijoFilaPlazo">
                                    <th>Plazo</th><td id="modalCuentaPlazo"></td>
                                </tr>
                            </table>

                            <h6>Situación Judicial</h6>
                            <div class="alert alert-warning d-none" role="alert" id="modalEmbargoAlert">
                                <strong>Embargo Activo</strong><br>
                                <ul class="mb-0">
                                    <li><strong>Monto embargado:</strong> <span id="modalEmbargoMonto"></span></li>
                                    <li><strong>N° Expediente Judicial:</strong> <span id="modalEmbargoExp"></span></li>
                                    <li><strong>Motivo:</strong> <span id="modalEmbargoMotivo"></span></li>
                                </ul>
                            </div>
                            <div class="alert alert-success d-none" role="alert" id="modalSinEmbargoAlert">
                                <strong>Sin embargos activos.</strong> Esta cuenta se encuentra libre de medidas judiciales.
                            </div>

                            <h6>Últimos Movimientos (Ejemplo)</h6>
                            <table class="table table-striped">
                                <thead>
                                    <tr><th>Fecha</th><th>Tipo</th><th>Monto</th><th>Descripción</th></tr>
                                </thead>
                                <tbody>
                                    <tr><td>2025-10-10</td><td>Depósito</td><td>S/ 500.00</td><td>Depósito en ventanilla</td></tr>
                                    <tr><td>2025-10-08</td><td>Retiro</td><td>S/ 100.00</td><td>Retiro ATM</td></tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-danger">Cerrar Cuenta</button>
                            <button class="btn btn-warning">Inactivar</button>
                            <button class="btn btn-secondary">Embargar</button>
                            <button class="btn btn-outline-dark" data-bs-dismiss="modal">Salir</button>
                        </div>
                    </div>
                </div>
            </div>

        </div> <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>

        <script src="${pageContext.request.contextPath}/js/sidebar.js"></script>

        <script src="${pageContext.request.contextPath}/js/gestion-cuentas.js"></script>
    </body>
</html>