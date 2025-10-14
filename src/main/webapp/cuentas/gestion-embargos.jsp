<%-- 
    Document   : embargos
    Created on : Oct 12, 2025, 5:54:43 PM
    Author     : kevin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${sessionScope.usuAut == null}">
    <c:redirect url="../login.jsp" />
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
        <title>Embargos</title>
    </head>
    <body>
        <%@ include file="../util/theme.jsp" %>
        <div class="d-flex">
            <%@ include file="../util/sidebar.jsp" %>
            <div class="container mt-5 mb-4">
                <div class="card shadow-sm">
                    <div class="card-header bg-dark text-light text-center">
                        <h4 class="mb-0">Gestión de Embargos</h4>
                    </div>

                    <div class="card-body">
                        <p class="text-muted">
                            Busque una cuenta para consultar los embargos registrados (activos o levantados) 
                            y, si es necesario, registre un nuevo embargo asociado a la cuenta.
                        </p>
                        <hr>

                        <!-- 🔍 Sección 1: Buscar cuenta -->
                        <h5>Buscar Cuenta</h5>
                        <form action="/ControlEmbargo" method="get" class="mb-4">
                            <div class="row g-3 align-items-end">
                                <div class="col-md-4">
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

                                <div class="col-md-2 d-grid">
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
                            <tr><th>Saldo Actual</th><td>S/ 1,250.50</td></tr>
                            <tr><th>Estado</th><td>Activa</td></tr>
                        </table>

                        <!-- ⚖️ Sección 3: Embargos registrados -->
                        <h5>Embargos Registrados</h5>
                        <div class="table-responsive mb-4">
                            <table class="table table-bordered table-striped align-middle">
                                <thead class="table-dark text-center">
                                    <tr>
                                        <th>ID</th>
                                        <th>Monto</th>
                                        <th>Estado</th>
                                        <th>Descripción</th>
                                        <th>Expediente</th>
                                        <th>Fecha Registro</th>
                                        <th>Acción</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>S/ 500.00</td>
                                        <td class="text-warning">Activo</td>
                                        <td>Mandato judicial por deuda civil</td>
                                        <td>EXP-2025-00123</td>
                                        <td>2025-10-05</td>
                                        <td class="text-center">
                                            <button type="button" class="btn btn-sm btn-info" data-bs-toggle="modal" data-bs-target="#modalEditar1">Editar</button>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>2</td>
                                        <td>S/ 1,250.50</td>
                                        <td class="text-success">Levantado</td>
                                        <td>Embargo total por mandato judicial</td>
                                        <td>-</td>
                                        <td>2025-09-12</td>
                                        <td class="text-center">
                                            <button type="button" class="btn btn-sm btn-info" data-bs-toggle="modal" data-bs-target="#modalEditar2">Editar</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <hr>

                        <!-- 🆕 Sección 4: Registrar nuevo embargo -->
                        <h5>Registrar Nuevo Embargo</h5>
                        <form action="/ControlEmbargo" method="post">
                            <input type="hidden" name="accion" value="registrar">
                            <input type="hidden" name="numCuenta" value="001-00012345">

                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <label for="montoEmbargo" class="form-label">Monto Embargado <span class="text-danger">*</span></label>
                                    <input type="number" step="0.01" class="form-control" id="montoEmbargo" name="montoEmbargo" required placeholder="0.00">
                                </div>

                                <div class="col-md-4">
                                    <label for="estadoEmbargo" class="form-label">Estado</label>
                                    <select class="form-select" id="estadoEmbargo" name="estadoEmbargo">
                                        <option value="ACTIVO">Activo</option>
                                        <option value="LEVANTADO">Levantado</option>
                                    </select>
                                </div>

                                <div class="col-md-4">
                                    <label for="expediente" class="form-label">N° Expediente Judicial (opcional)</label>
                                    <input type="text" class="form-control" id="expediente" name="expediente" placeholder="Ej: EXP-2025-00123">
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="descripcion" class="form-label">Descripción / Motivo <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="descripcion" name="descripcion" rows="2" required placeholder="Ej: Mandato judicial, retención administrativa, etc."></textarea>
                            </div>

                            <div class="text-center mt-4">
                                <button type="submit" class="btn btn-danger px-4">Registrar Embargo</button>
                                <a href="../home.jsp" class="btn btn-secondary px-4">Cancelar</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <!-- 🔧 Modal Editar -->
            <div class="modal fade" id="modalEditar1" tabindex="-1" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header bg-dark text-light">
                            <h5 class="modal-title">Editar Embargo - ID 1</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <div class="modal-body">
                            <form action="/ControlEmbargo" method="post">
                                <input type="hidden" name="accion" value="actualizar">
                                <input type="hidden" name="idEmbargo" value="1">

                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="monto" class="form-label">Monto Embargado</label>
                                        <input type="number" step="0.01" class="form-control" name="monto" value="500.00">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="estado" class="form-label">Estado</label>
                                        <select class="form-select" name="estado">
                                            <option value="ACTIVO" selected>Activo</option>
                                            <option value="LEVANTADO">Levantado</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="descripcion" class="form-label">Descripción / Motivo</label>
                                    <textarea class="form-control" name="descripcion" rows="2">Mandato judicial por deuda civil</textarea>
                                </div>

                                <div class="mb-3">
                                    <label for="expediente" class="form-label">N° Expediente Judicial (opcional)</label>
                                    <input type="text" class="form-control" name="expediente" value="EXP-2025-00123">
                                </div>

                                <div class="text-center mt-3">
                                    <button type="submit" class="btn btn-primary px-4">Guardar Cambios</button>
                                    <button type="button" class="btn btn-secondary px-4" data-bs-dismiss="modal">Cerrar</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sidebars.js"></script>
    </body>
</html>


