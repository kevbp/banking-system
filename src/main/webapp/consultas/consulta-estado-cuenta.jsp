<%-- 
    Document   : consulta-estado-cuenta
    Created on : Oct 12, 2025, 6:51:41 PM
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
        <title>Consulta estado de cuenta</title>
    </head>
    <body>
        <%@ include file="../util/theme.jsp" %>
        <div class="d-flex">
            <%@ include file="../util/sidebar.jsp" %>
            <div class="container mt-5 mb-4">
                <div class="card shadow-sm">
                    <div class="card-header bg-dark text-light text-center">
                        <h4 class="mb-0">Estado de Cuenta</h4>
                    </div>

                    <div class="card-body">
                        <p class="text-muted">
                            Consulte el estado de cuenta de una cuenta de ahorros, corriente o a plazo. 
                            Seleccione la cuenta y el período que desea revisar.
                        </p>
                        <hr>

                        <!-- 🔍 Sección 1: Buscar cuenta -->
                        <h5>Buscar Cuenta</h5>
                        <form action="/ControlEstadoCuenta" method="get" class="mb-4">
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
                                    <input type="text" class="form-control" id="numDoc" name="numDoc" placeholder="Ej: 47283910">
                                </div>

                                <div class="col-md-1 d-grid">
                                    <button type="submit" class="btn btn-success">Buscar</button>
                                </div>
                            </div>
                        </form>

                        <hr>

                        <!-- 🧾 Sección 2: Datos de la cuenta -->
                        <h5>Datos de la Cuenta</h5>
                        <table class="table table-bordered mb-4">
                            <tr><th>Cliente</th><td>Juan Pérez</td></tr>
                            <tr><th>Número de Cuenta</th><td>001-00012345</td></tr>
                            <tr><th>Tipo de Cuenta</th><td>Ahorros</td></tr>
                            <tr><th>Moneda</th><td>Soles</td></tr>
                            <tr><th>Estado</th><td>Activa</td></tr>
                        </table>

                        <!-- 📅 Sección 3: Selección del período -->
                        <h5>Período del Estado de Cuenta</h5>
                        <form action="/ControlEstadoCuenta" method="get" class="mb-4">
                            <input type="hidden" name="numCuenta" value="001-00012345">
                            <div class="row g-3 align-items-end">
                                <div class="col-md-4">
                                    <label for="fechaInicio" class="form-label">Desde</label>
                                    <input type="date" class="form-control" id="fechaInicio" name="fechaInicio">
                                </div>

                                <div class="col-md-4">
                                    <label for="fechaFin" class="form-label">Hasta</label>
                                    <input type="date" class="form-control" id="fechaFin" name="fechaFin">
                                </div>

                                <div class="col-md-4 d-grid">
                                    <button type="submit" class="btn btn-primary">Generar Estado</button>
                                </div>
                            </div>
                        </form>

                        <hr>

                        <!-- 📋 Sección 4: Estado de cuenta -->
                        <h5>Estado de Cuenta: 01/09/2025 - 30/09/2025</h5>
                        <div class="table-responsive mb-3">
                            <table class="table table-bordered table-striped align-middle">
                                <thead class="table-dark text-center">
                                    <tr>
                                        <th>Fecha</th>
                                        <th>Movimiento</th>
                                        <th>Descripción</th>
                                        <th>Débito</th>
                                        <th>Crédito</th>
                                        <th>Saldo</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>2025-09-02</td>
                                        <td>Depósito</td>
                                        <td>Depósito en ventanilla</td>
                                        <td></td>
                                        <td class="text-success">S/ 500.00</td>
                                        <td>S/ 1,200.00</td>
                                    </tr>
                                    <tr>
                                        <td>2025-09-05</td>
                                        <td>Retiro</td>
                                        <td>Retiro en ventanilla</td>
                                        <td class="text-danger">S/ 100.00</td>
                                        <td></td>
                                        <td>S/ 1,100.00</td>
                                    </tr>
                                    <tr>
                                        <td>2025-09-10</td>
                                        <td>Transferencia</td>
                                        <td>Transferencia a cuenta 001-00067890</td>
                                        <td class="text-danger">S/ 150.00</td>
                                        <td></td>
                                        <td>S/ 950.00</td>
                                    </tr>
                                    <tr>
                                        <td>2025-09-20</td>
                                        <td>Depósito</td>
                                        <td>Transferencia recibida</td>
                                        <td></td>
                                        <td class="text-success">S/ 200.00</td>
                                        <td>S/ 1,150.00</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <!-- Totales -->
                        <div class="row text-end mb-4">
                            <div class="col-md-6 offset-md-6">
                                <table class="table table-bordered">
                                    <tr><th>Saldo Inicial</th><td>S/ 700.00</td></tr>
                                    <tr><th>Total Abonos</th><td class="text-success">S/ 700.00</td></tr>
                                    <tr><th>Total Cargos</th><td class="text-danger">S/ 250.00</td></tr>
                                    <tr class="table-secondary"><th>Saldo Final</th><td><strong>S/ 1,150.00</strong></td></tr>
                                </table>
                            </div>
                        </div>

                        <!-- Botones -->
                        <div class="text-center mt-4">
                            <button type="button" class="btn btn-outline-primary px-4">Imprimir</button>
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
