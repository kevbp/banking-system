<%-- 
    Document   : gestion-parametros
    Created on : Oct 12, 2025, 7:31:56 PM
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
        <title>JSP Page</title>
    </head>
    <body>
        <%@ include file="../util/theme.jsp" %>
        <div class="d-flex">
            <%@ include file="../util/sidebar.jsp" %>
            <div class="container mt-5 mb-4">
                <div class="card shadow-sm">
                    <div class="card-header bg-dark text-light text-center">
                        <h4 class="mb-0">Parámetros del Sistema</h4>
                    </div>

                    <div class="card-body">
                        <p class="text-muted">
                            Administre las configuraciones maestras del sistema: monedas, tipos de cuenta, cuentas internas y tipos de movimiento.
                            Solo el personal autorizado debe realizar cambios aquí.
                        </p>
                        <hr>

                        <!-- 🌐 Sección 1: Monedas -->
                        <h5>Monedas y Tipo de Cambio</h5>
                        <div class="table-responsive mb-3">
                            <table class="table table-bordered table-striped align-middle">
                                <thead class="table-dark text-center">
                                    <tr>
                                        <th>ID</th>
                                        <th>Moneda</th>
                                        <th>Símbolo</th>
                                        <th>Tipo Cambio Compra</th>
                                        <th>Tipo Cambio Venta</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>Soles</td>
                                        <td>S/</td>
                                        <td>1.00</td>
                                        <td>1.00</td>
                                        <td class="text-center">
                                            <button class="btn btn-sm btn-warning" data-bs-toggle="modal" data-bs-target="#modalEditarMoneda1">Editar</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>Dólares</td>
                                        <td>$</td>
                                        <td>3.72</td>
                                        <td>3.75</td>
                                        <td class="text-center">
                                            <button class="btn btn-sm btn-warning" data-bs-toggle="modal" data-bs-target="#modalEditarMoneda2">Editar</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="text-end mb-4">
                            <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalNuevaMoneda">Nueva Moneda</button>
                        </div>

                        <hr>

                        <!-- 🏦 Sección 2: Tipos de Cuenta -->
                        <h5>Tipos de Cuenta</h5>
                        <div class="table-responsive mb-3">
                            <table class="table table-bordered table-striped align-middle">
                                <thead class="table-dark text-center">
                                    <tr>
                                        <th>ID</th>
                                        <th>Descripción</th>
                                        <th>Moneda</th>
                                        <th>Tasa de Interés (%)</th>
                                        <th>Estado</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>Ahorros</td>
                                        <td>Soles</td>
                                        <td>1.50</td>
                                        <td>Activa</td>
                                        <td class="text-center">
                                            <button class="btn btn-sm btn-warning" data-bs-toggle="modal" data-bs-target="#modalEditarTipo1">Editar</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="text-end mb-4">
                            <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalNuevoTipo">Nuevo Tipo de Cuenta</button>
                        </div>

                        <hr>

                        <!-- 🧾 Sección 3: Cuentas del Sistema -->
                        <h5>Cuentas del Sistema</h5>
                        <div class="table-responsive mb-3">
                            <table class="table table-bordered table-striped align-middle">
                                <thead class="table-dark text-center">
                                    <tr>
                                        <th>N° Cuenta</th>
                                        <th>Tipo de Cuenta</th>
                                        <th>Moneda</th>
                                        <th>Tasa (%)</th>
                                        <th>Estado</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>000-001</td>
                                        <td>Ahorros</td>
                                        <td>Soles</td>
                                        <td>1.50</td>
                                        <td>Activa</td>
                                        <td class="text-center">
                                            <button class="btn btn-sm btn-warning" data-bs-toggle="modal" data-bs-target="#modalEditarCuenta1">Editar</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="text-end mb-4">
                            <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalNuevaCuenta">Nueva Cuenta</button>
                        </div>

                        <hr>

                        <!-- 💳 Sección 4: Tipos de Movimiento -->
                        <h5>Tipos de Movimiento</h5>
                        <div class="table-responsive mb-3">
                            <table class="table table-bordered table-striped align-middle">
                                <thead class="table-dark text-center">
                                    <tr>
                                        <th>ID</th>
                                        <th>Descripción</th>
                                        <th>Signo</th>
                                        <th>Estado</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>Depósito</td>
                                        <td>+</td>
                                        <td>Activo</td>
                                        <td class="text-center">
                                            <button class="btn btn-sm btn-warning" data-bs-toggle="modal" data-bs-target="#modalEditarMov1">Editar</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>Retiro</td>
                                        <td>-</td>
                                        <td>Activo</td>
                                        <td class="text-center">
                                            <button class="btn btn-sm btn-warning" data-bs-toggle="modal" data-bs-target="#modalEditarMov2">Editar</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="text-end">
                            <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalNuevoMovimiento">Nuevo Tipo de Movimiento</button>
                        </div>

                        <div class="text-center mt-4">
                            <a href="../home.jsp" class="btn btn-secondary px-4">Volver</a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 🔸 Modales de Monedas -->
            <div class="modal fade" id="modalNuevaMoneda" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header bg-dark text-light">
                            <h5 class="modal-title">Nueva Moneda</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="/ControlParametros" method="post">
                            <input type="hidden" name="accion" value="agregarMoneda">
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label class="form-label">Descripción</label>
                                    <input type="text" class="form-control" name="descripcion" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Símbolo</label>
                                    <input type="text" class="form-control" name="simbolo" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Tipo Cambio Compra</label>
                                    <input type="number" step="0.0001" class="form-control" name="cambioCompra" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Tipo Cambio Venta</label>
                                    <input type="number" step="0.0001" class="form-control" name="cambioVenta" required>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">Guardar</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Modal: Nuevo Tipo de Cuenta -->
            <div class="modal fade" id="modalNuevoTipo" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header bg-dark text-light">
                            <h5 class="modal-title">Nuevo Tipo de Cuenta</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="/ControlParametros" method="post">
                            <input type="hidden" name="accion" value="agregarTipoCuenta">
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label class="form-label">Descripción</label>
                                    <input type="text" class="form-control" name="descripcion" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Moneda</label>
                                    <select class="form-select" name="moneda" required>
                                        <option>Soles</option>
                                        <option>Dólares</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Tasa de Interés (%)</label>
                                    <input type="number" step="0.01" class="form-control" name="tasa" required>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">Guardar</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- Modal: Nueva Cuenta -->
            <div class="modal fade" id="modalNuevaCuenta" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header bg-dark text-light">
                            <h5 class="modal-title">Nueva Cuenta del Sistema</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="/ControlParametros" method="post">
                            <input type="hidden" name="accion" value="agregarCuentaBase">
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label class="form-label">Número de Cuenta</label>
                                    <input type="text" class="form-control" name="numCuenta" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Tipo de Cuenta</label>
                                    <select class="form-select" name="tipoCuenta" required>
                                        <option>Ahorros</option>
                                        <option>Corriente</option>
                                        <option>Plazo Fijo</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Moneda</label>
                                    <select class="form-select" name="moneda" required>
                                        <option>Soles</option>
                                        <option>Dólares</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Tasa de Interés (%)</label>
                                    <input type="number" step="0.01" class="form-control" name="tasa" required>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">Guardar</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!-- Modal: Nuevo Tipo de Movimiento -->
            <div class="modal fade" id="modalNuevoMovimiento" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header bg-dark text-light">
                            <h5 class="modal-title">Nuevo Tipo de Movimiento</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="/ControlParametros" method="post">
                            <input type="hidden" name="accion" value="agregarTipoMovimiento">
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label class="form-label">Descripción</label>
                                    <input type="text" class="form-control" name="descripcion" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Signo</label>
                                    <select class="form-select" name="signo" required>
                                        <option value="+">+</option>
                                        <option value="-">-</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Estado</label>
                                    <select class="form-select" name="estado" required>
                                        <option>Activo</option>
                                        <option>Inactivo</option>
                                    </select>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">Guardar</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
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