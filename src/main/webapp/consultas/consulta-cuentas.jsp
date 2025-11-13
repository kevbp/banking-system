<%-- 
    Document   : consulta-cuentas
    Created on : Oct 12, 2025, 6:50:23 PM
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

        <title>Consulta de Cuentas - Quantum Bank</title> </head>

    <body data-active-page="consultas-cuentas">
        <%@ include file="../util/theme.jsp" %>

        <div class="d-flex">
            <%@ include file="../util/sidebar.jsp" %>

            <div class="main-content flex-grow-1">
                <%@ include file="../util/header.jsp" %>

                <div class="content-area p-4">
                    <div class="card shadow-sm border-0">
                        <div class="card-header bg-dark text-light text-center">
                            <h4 class="mb-0">Consulta de Cuentas</h4>
                        </div>

                        <div class="card-body p-4">
                            <p class="text-muted">
                                Consulte las cuentas registradas de un cliente, visualice su información y acceda al detalle de cada cuenta.
                            </p>
                            <hr>

                            <h5>Buscar Cliente</h5>
                            <form action="/ControlConsultaCuenta" method="get" class="mb-4">
                                <div class="row g-3 align-items-end">
                                    <div class="col-md-3">
                                        <label for="tipoDoc" class="form-label">Tipo de Documento</label>
                                        <select class="form-select" id="tipoDoc" name="tipoDoc">
                                            <option value="">Seleccione...</option>
                                            <option value="DNI">DNI</option>
                                            <option value="RUC">RUC</option>
                                        </select>
                                    </div>
                                    <div class="col-md-4">
                                        <label for="numDoc" class="form-label">Número de Documento</label>
                                        <input type="text" class="form-control" id="numDoc" name="numDoc" placeholder="Ej: 47283910 o 20134567890">
                                    </div>
                                    <div class="col-md-4">
                                        <label for="nombreCliente" class="form-label">Nombre / Razón Social</label>
                                        <input type="text" class="form-control" id="nombreCliente" name="nombreCliente" placeholder="Juan Pérez o ABC S.A.C.">
                                    </div>
                                    <div class="col-md-1 d-grid">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="bi bi-search"></i>
                                        </button>
                                    </div>
                                </div>
                            </form>

                            <hr>

                            <h5>Datos del Cliente</h5>
                            <table class="table table-bordered mb-4">
                                <tr><th>Tipo de Cliente</th><td>Persona Natural</td></tr>
                                <tr><th>Nombre / Razón Social</th><td>Juan Pérez</td></tr>
                                <tr><th>Documento</th><td>DNI 47283910</td></tr>
                                <tr><th>Teléfono</th><td>987 654 321</td></tr>
                                <tr><th>Correo</th><td>juanperez@mail.com</td></tr>
                                <tr><th>Dirección</th><td>Av. Los Olivos 123 - Lima</td></tr>
                            </table>

                            <h5>Cuentas Registradas</h5>
                            <div class="table-responsive">
                                <table class="table table-bordered table-striped align-middle">
                                    <thead class="table-light text-center">
                                        <tr>
                                            <th>N° Cuenta</th>
                                            <th>Tipo</th>
                                            <th>Moneda</th>
                                            <th>Saldo</th>
                                            <th>Estado</th>
                                            <th>Embargo</th>
                                            <th>Acción</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>001-00012345</td>
                                            <td>Ahorros</td>
                                            <td>Soles</td>
                                            <td>S/ 1,250.50</td>
                                            <td>Activa</td>
                                            <td>No</td>
                                            <td class="text-center">
                                                <button type="button" class="btn btn-info btn-sm" 
                                                        data-bs-toggle="modal" 
                                                        data-bs-target="#modalVerCuenta"
                                                        data-nro-cuenta="001-00012345"
                                                        data-tipo="Ahorros"
                                                        data-moneda="Soles"
                                                        data-saldo="S/ 1,250.50"
                                                        data-fecha-apertura="2024-05-10"
                                                        data-estado="Activa"
                                                        data-embargo="No">
                                                    Ver
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>001-00045678</td>
                                            <td>Corriente</td>
                                            <td>Dólares</td>
                                            <td>$ 3,400.00</td>
                                            <td>Activa</td>
                                            <td>Parcial</td>
                                            <td class="text-center">
                                                <button type="button" class="btn btn-info btn-sm" 
                                                        data-bs-toggle="modal" 
                                                        data-bs-target="#modalVerCuenta"
                                                        data-nro-cuenta="001-00045678"
                                                        data-tipo="Corriente"
                                                        data-moneda="Dólares"
                                                        data-saldo="$ 3,400.00"
                                                        data-fecha-apertura="2023-11-22"
                                                        data-estado="Activa"
                                                        data-embargo="Parcial">
                                                    Ver
                                                </button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <div class="text-center mt-4">
                                <a href="../home.jsp" class="btn btn-secondary px-4">Volver</a>
                            </div>
                        </div>
                    </div>
                </div> </div> </div> <div class="modal fade" id="modalVerCuenta" tabindex="-1" aria-labelledby="modalVerCuentaLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title" id="modalVerCuentaLabel">Detalle de Cuenta</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <table class="table table-bordered">
                            <tr><th>Tipo de Cuenta</th><td id="modalCuentaTipo"></td></tr>
                            <tr><th>Moneda</th><td id="modalCuentaMoneda"></td></tr>
                            <tr><th>Saldo Actual</th><td id="modalCuentaSaldo"></td></tr>
                            <tr><th>Fecha de Apertura</th><td id="modalCuentaFechaApertura"></td></tr>
                            <tr><th>Estado</th><td id="modalCuentaEstado"></td></tr>
                            <tr><th>Embargo</th><td id="modalCuentaEmbargo"></td></tr>
                        </table>
                        <div class="text-center mt-3">
                            <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">Cerrar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>

        <script src="${pageContext.request.contextPath}/js/sidebar.js"></script>

        <script src="${pageContext.request.contextPath}/js/consulta-cuentas.js"></script>
    </body>
</html>