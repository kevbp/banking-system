<%-- 
    Document   : gestion-cuentas
    Created on : Oct 12, 2025, 5:45:49 PM
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
        <title>Gestión de cuentas</title>
    </head>
    <body>
        <%@ include file="../util/theme.jsp" %>
        <div class="d-flex">
            <%@ include file="../util/sidebar.jsp" %>
            <div class="container mt-5 mb-4">
                <div class="card shadow-sm">
                    <div class="card-header bg-dark text-light text-center">
                        <h4 class="mb-0">Gestión de Cuentas</h4>
                    </div>

                    <div class="card-body">
                        <p class="text-muted">Busque y consulte las cuentas bancarias registradas. Puede ver su información y realizar acciones desde el modal.</p>
                        <hr>

                        <!-- Formulario de búsqueda -->
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
                                    <button type="submit" class="btn btn-success">Buscar</button>
                                </div>

                            </div>
                        </form>

                        <hr>

                        <!-- Resultados -->
                        <h5 class="mb-3">Listado de Cuentas</h5>

                        <div class="table-responsive">
                            <table class="table table-bordered table-striped align-middle">
                                <thead class="table-dark text-center">
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
                                    <!-- Ejemplo de filas estáticas -->
                                    <tr>
                                        <td>001-00012345</td>
                                        <td>Juan Pérez</td>
                                        <td>Ahorros</td>
                                        <td>Soles</td>
                                        <td>S/ 1,250.50</td>
                                        <td>Embargada</td>
                                        <td class="text-center">
                                            <button type="button" class="btn btn-sm btn-info" data-bs-toggle="modal" data-bs-target="#modalCuenta1">Ver</button>
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
                                            <button type="button" class="btn btn-sm btn-info" data-bs-toggle="modal" data-bs-target="#modalCuenta2">Ver</button>
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
            </div>

            <!-- MODAL CUENTA 1 -->
            <div class="modal fade" id="modalCuenta1" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-xl modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header bg-dark text-light">
                            <h5 class="modal-title">Detalle de Cuenta - 001-00012345</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">

                            <h6>Información General</h6>
                            <table class="table table-bordered">
                                <tr><th>Cliente</th><td>Juan Pérez</td></tr>
                                <tr><th>Tipo de Cuenta</th><td>Ahorros</td></tr>
                                <tr><th>Moneda</th><td>Soles</td></tr>
                                <tr><th>Saldo Actual</th><td>S/ 1,250.50</td></tr>
                                <tr><th>Estado</th><td>Embargada</td></tr>
                                <tr><th>Fecha de Apertura</th><td>2025-10-01</td></tr>
                            </table>

                            <h6>Situación Judicial</h6>
                            <div class="alert alert-warning" role="alert">
                                <strong>Embargo Parcial Activo</strong><br>
                                <ul class="mb-0">
                                    <li><strong>Monto embargado:</strong> S/ 500.00</li>
                                    <li><strong>N° Expediente Judicial:</strong> EXP-2025-00123</li>
                                    <li><strong>Motivo:</strong> Mandato judicial por deuda civil</li>
                                </ul>
                            </div>

                            <h6>Últimos Movimientos</h6>
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

            <!-- MODAL CUENTA 2 -->
            <div class="modal fade" id="modalCuenta2" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-xl modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header bg-dark text-light">
                            <h5 class="modal-title">Detalle de Cuenta - 002-00055678</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">

                            <h6>Información General</h6>
                            <table class="table table-bordered">
                                <tr><th>Cliente</th><td>Comercial ABC S.A.C.</td></tr>
                                <tr><th>Tipo de Cuenta</th><td>Plazo Fijo</td></tr>
                                <tr><th>Moneda</th><td>Dólares</td></tr>
                                <tr><th>Saldo Actual</th><td>$ 5,000.00</td></tr>
                                <tr><th>Estado</th><td>Activa</td></tr>
                                <tr><th>Fecha de Apertura</th><td>2025-09-20</td></tr>
                                <tr><th>Interés Mensual</th><td>2.5%</td></tr>
                                <tr><th>Plazo</th><td>12 meses</td></tr>
                            </table>

                            <h6>Situación Judicial</h6>
                            <div class="alert alert-success" role="alert">
                                <strong>Sin embargos activos.</strong> Esta cuenta se encuentra libre de medidas judiciales.
                            </div>

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
        </div>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sidebars.js"></script>
    </body>
</html>
