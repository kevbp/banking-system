<%-- 
    Document   : consulta-movimientos
    Created on : Oct 12, 2025, 6:51:27 PM
    Author     : kevin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${sessionScope.usuAut == null}">
    <c:redirect url="login.jsp" />
</c:if>

<!DOCTYPE html>
<html>
    <head>
        <script src="${pageContext.request.contextPath}/js/color-modes.js"></script>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/sidebars.css" rel="stylesheet">
        <title>Consulta de movimientos</title>
    </head>
    <body>
        <%@ include file="../util/theme.jsp" %>
        <div class="d-flex">
            <%@ include file="../util/sidebar.jsp" %>
            <div class="container mt-5 mb-4">
                <div class="card shadow-sm">
                    <div class="card-header bg-dark text-light text-center">
                        <h4 class="mb-0">Consulta de Movimientos</h4>
                    </div>

                    <div class="card-body">
                        <p class="text-muted">
                            Consulte los movimientos de una cuenta bancaria. Primero busque al cliente y seleccione la cuenta que desea revisar.
                        </p>
                        <hr>

                        <!-- 🔍 Sección 1: Buscar cliente -->
                        <h5>Buscar Cliente</h5>
                        <form action="/ControlMovimientos" method="get" class="mb-4">
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
                                    <button type="submit" class="btn btn-success">Buscar</button>
                                </div>
                            </div>
                        </form>

                        <hr>

                        <!-- 🧾 Sección 2: Datos del cliente -->
                        <h5>Datos del Cliente</h5>
                        <table class="table table-bordered mb-4">
                            <tr><th>Tipo de Cliente</th><td>Persona Natural</td></tr>
                            <tr><th>Nombre / Razón Social</th><td>Juan Pérez</td></tr>
                            <tr><th>Documento</th><td>DNI 47283910</td></tr>
                            <tr><th>Teléfono</th><td>987 654 321</td></tr>
                            <tr><th>Correo</th><td>juanperez@mail.com</td></tr>
                        </table>

                        <!-- 🏦 Sección 3: Listado de cuentas -->
                        <h5>Cuentas Registradas</h5>
                        <div class="table-responsive mb-4">
                            <table class="table table-bordered table-striped align-middle">
                                <thead class="table-dark text-center">
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
                                    <!-- Ejemplo de cuentas -->
                                    <tr>
                                        <td>001-00012345</td>
                                        <td>Ahorros</td>
                                        <td>Soles</td>
                                        <td>S/ 1,250.50</td>
                                        <td>Activa</td>
                                        <td>No</td>
                                        <td class="text-center">
                                            <button type="button" class="btn btn-info btn-sm" data-bs-toggle="collapse" data-bs-target="#movimientosCuenta1">
                                                Ver Movimientos
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
                                            <button type="button" class="btn btn-info btn-sm" data-bs-toggle="collapse" data-bs-target="#movimientosCuenta2">
                                                Ver Movimientos
                                            </button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <!-- 📋 Sección 4: Movimientos de cuenta 1 -->
                        <div class="collapse" id="movimientosCuenta1">
                            <div class="card mb-4">
                                <div class="card-header bg-secondary text-light">
                                    Movimientos - Cuenta: 001-00012345 (Ahorros - S/)
                                </div>
                                <div class="card-body">
                                    <!-- Filtro -->
                                    <form action="/ControlMovimientos" method="get" class="mb-3">
                                        <input type="hidden" name="numCuenta" value="001-00012345">
                                        <div class="row g-3 align-items-end">
                                            <div class="col-md-4">
                                                <label for="fechaInicio1" class="form-label">Desde</label>
                                                <input type="date" class="form-control" id="fechaInicio1" name="fechaInicio">
                                            </div>

                                            <div class="col-md-4">
                                                <label for="fechaFin1" class="form-label">Hasta</label>
                                                <input type="date" class="form-control" id="fechaFin1" name="fechaFin">
                                            </div>

                                            <div class="col-md-4 d-grid">
                                                <button type="submit" class="btn btn-primary">Filtrar</button>
                                            </div>
                                        </div>
                                    </form>

                                    <!-- Tabla de movimientos -->
                                    <div class="table-responsive">
                                        <table class="table table-bordered table-striped align-middle">
                                            <thead class="table-dark text-center">
                                                <tr>
                                                    <th>Fecha</th>
                                                    <th>Tipo</th>
                                                    <th>Descripción</th>
                                                    <th>Monto</th>
                                                    <th>Saldo Resultante</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>2025-10-10</td>
                                                    <td>Depósito</td>
                                                    <td>Depósito en ventanilla</td>
                                                    <td class="text-success">+ S/ 500.00</td>
                                                    <td>S/ 1,250.50</td>
                                                </tr>
                                                <tr>
                                                    <td>2025-10-07</td>
                                                    <td>Retiro</td>
                                                    <td>Retiro por ventanilla</td>
                                                    <td class="text-danger">- S/ 200.00</td>
                                                    <td>S/ 750.50</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- 📋 Movimientos de cuenta 2 -->
                        <div class="collapse" id="movimientosCuenta2">
                            <div class="card mb-4">
                                <div class="card-header bg-secondary text-light">
                                    Movimientos - Cuenta: 001-00045678 (Corriente - $)
                                </div>
                                <div class="card-body">
                                    <form action="/ControlMovimientos" method="get" class="mb-3">
                                        <input type="hidden" name="numCuenta" value="001-00045678">
                                        <div class="row g-3 align-items-end">
                                            <div class="col-md-4">
                                                <label for="fechaInicio2" class="form-label">Desde</label>
                                                <input type="date" class="form-control" id="fechaInicio2" name="fechaInicio">
                                            </div>

                                            <div class="col-md-4">
                                                <label for="fechaFin2" class="form-label">Hasta</label>
                                                <input type="date" class="form-control" id="fechaFin2" name="fechaFin">
                                            </div>

                                            <div class="col-md-4 d-grid">
                                                <button type="submit" class="btn btn-primary">Filtrar</button>
                                            </div>
                                        </div>
                                    </form>

                                    <div class="table-responsive">
                                        <table class="table table-bordered table-striped align-middle">
                                            <thead class="table-dark text-center">
                                                <tr>
                                                    <th>Fecha</th>
                                                    <th>Tipo</th>
                                                    <th>Descripción</th>
                                                    <th>Monto</th>
                                                    <th>Saldo Resultante</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>2025-09-25</td>
                                                    <td>Transferencia Entrante</td>
                                                    <td>Desde cuenta 001-00012345</td>
                                                    <td class="text-success">+ $ 200.00</td>
                                                    <td>$ 3,400.00</td>
                                                </tr>
                                                <tr>
                                                    <td>2025-09-10</td>
                                                    <td>Retiro</td>
                                                    <td>Retiro en ventanilla</td>
                                                    <td class="text-danger">- $ 50.00</td>
                                                    <td>$ 3,200.00</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="text-center mt-4">
                            <a href="../home.jsp" class="btn btn-secondary px-4">Volver</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sidebars.js"></script>
    </body>
</html>
