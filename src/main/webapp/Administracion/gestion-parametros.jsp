<%-- 
    Document   : gestion-parametros
    Created on : Oct 12, 2025, 7:31:56 PM
    Author     : kevin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Parámetros del Sistema - Quantum Bank</title>

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/estilos.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/sidebar.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    </head>

    <body data-active-page="admin-parametros">
        <%@ include file="../util/theme.jsp" %>

        <div class="d-flex">
            <%@ include file="../util/sidebar.jsp" %>

            <div class="main-content flex-grow-1">
                <%@ include file="../util/header.jsp" %>

                <div class="content-area p-4">
                    <div class="card shadow-sm border-0">

                        <div class="card-header bg-dark text-light text-center">
                            <h4 class="mb-0">Parámetros del Sistema</h4>
                        </div>

                        <div class="card-body p-4">
                            <p class="text-muted mb-0">
                                Administre las configuraciones maestras del banco: monedas, tipos de cuenta y tipos de movimiento.
                                Solo el personal autorizado debe realizar cambios en esta sección.
                            </p>
                            <hr>

                            <ul class="nav nav-tabs mb-3" id="paramTabs" role="tablist">
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link active" id="tab-monedas" data-bs-toggle="tab" 
                                            data-bs-target="#pane-monedas" type="button" role="tab" 
                                            aria-controls="pane-monedas" aria-selected="true">
                                        <i class="bi bi-currency-exchange me-1"></i> Monedas y tipo de cambio
                                    </button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="tab-cuentas" data-bs-toggle="tab"
                                            data-bs-target="#pane-cuentas" type="button" role="tab"
                                            aria-controls="pane-cuentas" aria-selected="false">
                                        <i class="bi bi-credit-card me-1"></i> Tipos de cuenta
                                    </button>
                                </li>
                                <li class="nav-item" role="presentation">
                                    <button class="nav-link" id="tab-movimientos" data-bs-toggle="tab"
                                            data-bs-target="#pane-movimientos" type="button" role="tab"
                                            aria-controls="pane-movimientos" aria-selected="false">
                                        <i class="bi bi-arrow-left-right me-1"></i> Tipos de movimiento
                                    </button>
                                </li>
                            </ul>

                            <div class="tab-content" id="paramTabsContent">

                                <div class="tab-pane fade show active" id="pane-monedas" role="tabpanel" aria-labelledby="tab-monedas">
                                    <h5 class="mb-3">Monedas y Tipo de Cambio</h5>
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <h6 class="mb-0">Catálogo de Monedas</h6>
                                        <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#modalNuevaMoneda">
                                            <i class="bi bi-plus-circle me-1"></i> Nueva moneda
                                        </button>
                                    </div>

                                    <div class="table-responsive mb-4">
                                        <table class="table table-bordered table-striped align-middle">
                                            <thead class="table-light text-center">
                                                <tr>
                                                    <th scope="col">Código</th>
                                                    <th scope="col">Descripción</th>
                                                    <th scope="col">Símbolo</th>
                                                    <th scope="col">Estado</th>
                                                    <th scope="col">Acciones</th>
                                                </tr>
                                            </thead>
                                            <tbody class="text-center">
                                                <c:forEach var="m" items="${listaMonedas}">
                                                    <tr>
                                                        <td>${m.codMoneda}</td>
                                                        <td>${m.descMoneda}</td>
                                                        <td>${m.simbolo}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${m.codEstado eq 'S0001'}"><span class="badge bg-success">Activa</span></c:when>
                                                                <c:otherwise><span class="badge bg-danger">Inactiva</span></c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <button class="btn btn-sm btn-outline-warning" 
                                                                    data-bs-toggle="modal" data-bs-target="#modalEditarMoneda"
                                                                    data-codigo="${m.codMoneda}"
                                                                    data-descripcion="${m.descMoneda}"
                                                                    data-simbolo="${m.simbolo}">
                                                                Editar
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>

                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <h6 class="mb-0">Tipo de cambio del día</h6>
                                        <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#modalNuevoTipoCambio">
                                            <i class="bi bi-arrow-repeat me-1"></i> Registrar / Actualizar tipo de cambio
                                        </button>
                                    </div>

                                    <div class="table-responsive mb-2">
                                        <table class="table table-bordered table-striped align-middle">
                                            <thead class="table-light text-center">
                                                <tr>
                                                    <th scope="col">Moneda</th>
                                                    <th scope="col">Código</th>
                                                    <th scope="col">Tasa compra</th>
                                                    <th scope="col">Tasa venta</th>
                                                    <th scope="col">Última actualización</th>
                                                    <th scope="col">Acciones</th>
                                                </tr>
                                            </thead>
                                            <tbody class="text-center">
                                                <c:forEach var="tc" items="${listaTiposCambio}">
                                                    <tr>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${tc.monedaOrigen eq 'USD'}">Dólares</c:when>
                                                                <c:when test="${tc.monedaOrigen eq 'EUR'}">Euros</c:when>
                                                                <c:otherwise>${tc.monedaOrigen}</c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>${tc.monedaOrigen}</td>
                                                        <td><fmt:formatNumber value="${tc.tasaCompra}" minFractionDigits="4"/></td>
                                                        <td><fmt:formatNumber value="${tc.tasaVenta}" minFractionDigits="4"/></td>
                                                        <td>${tc.fecha} ${tc.hora}</td>
                                                        <td>
                                                            <button class="btn btn-sm btn-outline-primary" 
                                                                    data-bs-toggle="modal" 
                                                                    data-bs-target="#modalEditarTipoCambio"
                                                                    data-codigo="${tc.monedaOrigen}"
                                                                    data-descripcion="${tc.monedaOrigen eq 'USD' ? 'Dólares' : (tc.monedaOrigen eq 'EUR' ? 'Euros' : tc.monedaOrigen)}"
                                                                    data-compra="${tc.tasaCompra}"
                                                                    data-venta="${tc.tasaVenta}">
                                                                Actualizar
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>

                                                <c:if test="${empty listaTiposCambio}">
                                                    <tr><td colspan="6" class="text-muted">No hay tasas registradas hoy.</td></tr>
                                                </c:if>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                                <div class="tab-pane fade" id="pane-cuentas" role="tabpanel" aria-labelledby="tab-cuentas">
                                    <h5 class="mb-3">Tipos de Cuenta</h5>

                                    <div class="table-responsive mb-3">
                                        <table class="table table-bordered table-striped align-middle">
                                            <thead class="table-light text-center">
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
                                                <c:forEach var="tc" items="${listaTiposCuenta}">
                                                    <tr>
                                                        <td>${tc.codTipCuenta}</td>
                                                        <td>${tc.descTipo}</td>
                                                        <td>${tc.codMoneda}</td>
                                                        <td><fmt:formatNumber value="${tc.tasaInt}" minFractionDigits="2"/>%</td>
                                                        <td>${tc.codEstado eq 'S0001' ? 'Activa' : 'Inactiva'}</td>
                                                        <td class="text-center">
                                                            <button class="btn btn-sm btn-outline-warning" 
                                                                    data-bs-toggle="modal" data-bs-target="#modalEditarTipoCuenta"
                                                                    data-id="${tc.codTipCuenta}"
                                                                    data-descripcion="${tc.descTipo}"
                                                                    data-moneda="${tc.codMoneda}"
                                                                    data-tasa="${tc.tasaInt}">
                                                                Editar
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="text-end mb-4">
                                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalNuevoTipo">
                                            <i class="bi bi-plus-circle me-1"></i> Nuevo Tipo de Cuenta
                                        </button>
                                    </div>

                                </div>

                                <div class="tab-pane fade" id="pane-movimientos" role="tabpanel" aria-labelledby="tab-movimientos">
                                    <h5 class="mb-3">Tipos de Movimiento</h5>

                                    <div class="table-responsive mb-3">
                                        <table class="table table-bordered table-striped align-middle">
                                            <thead class="table-light text-center">
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Descripción</th>
                                                    <th>Signo</th>
                                                    <th>Estado</th>
                                                    <th>Acciones</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="tm" items="${listaMovimientos}">
                                                    <tr>
                                                        <td>${tm.codTipMovimiento}</td>
                                                        <td>${tm.des}</td>
                                                        <td>${tm.signo}</td>
                                                        <td>${tm.codEstado eq 'S0001' ? 'Activo' : 'Inactivo'}</td>
                                                        <td class="text-center">
                                                            <button class="btn btn-sm btn-outline-warning" 
                                                                    data-bs-toggle="modal" data-bs-target="#modalEditarTipoMovimiento"
                                                                    data-id="${tm.codTipMovimiento}"
                                                                    data-descripcion="${tm.des}"
                                                                    data-signo="${tm.signo}"
                                                                    data-estado="${tm.codEstado eq 'S0001' ? 'Activo' : 'Inactivo'}">
                                                                Editar
                                                            </button>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="text-end mb-1">
                                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalNuevoMovimiento">
                                            <i class="bi bi-plus-circle me-1"></i> Nuevo Tipo de Movimiento
                                        </button>
                                    </div>
                                </div>
                            </div>

                            <div class="text-center mt-4">
                                <a href="${pageContext.request.contextPath}/home.jsp" class="btn btn-secondary px-4">
                                    Volver al Panel
                                </a>
                            </div>
                        </div>
                    </div>
                </div> </div> </div> <div class="modal fade" id="modalNuevaMoneda" tabindex="-1" aria-labelledby="modalNuevaMonedaLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title" id="modalNuevaMonedaLabel">Nueva Moneda</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/ControlParametros" method="post">
                        <input type="hidden" name="accion" value="agregarMoneda">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="codMoneda" class="form-label">Código de Moneda</label>
                                <input type="text" class="form-control" id="codMoneda" name="codMoneda" required>
                            </div>
                            <div class="mb-3">
                                <label for="descMoneda" class="form-label">Descripción</label>
                                <input type="text" class="form-control" id="descMoneda" name="descMoneda" required>
                            </div>
                            <div class="mb-3">
                                <label for="simbolo" class="form-label">Símbolo</label>
                                <input type="text" class="form-control" id="simbolo" name="simbolo" required>
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

        <div class="modal fade" id="modalEditarMoneda" tabindex="-1" aria-labelledby="modalEditarMonedaLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title" id="modalEditarMonedaLabel">Editar Moneda</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/ControlParametros" method="post">
                        <input type="hidden" name="accion" value="editarMoneda">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="editMonedaCodigo" class="form-label">Código de Moneda</label>
                                <input type="text" class="form-control" id="editMonedaCodigo" name="codMoneda" readonly>
                            </div>
                            <div class="mb-3">
                                <label for="editMonedaDesc" class="form-label">Descripción</label>
                                <input type="text" class="form-control" id="editMonedaDesc" name="descMoneda" required>
                            </div>
                            <div class="mb-3">
                                <label for="editMonedaSimbolo" class="form-label">Símbolo</label>
                                <input type="text" class="form-control" id="editMonedaSimbolo" name="simbolo" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Actualizar</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalNuevoTipoCambio" tabindex="-1" aria-labelledby="modalNuevoTipoCambioLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title" id="modalNuevoTipoCambioLabel">Registrar Tipo de Cambio</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/ControlParametros" method="post">
                        <input type="hidden" name="accion" value="registrarTipoCambio">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="newTCMoneda" class="form-label">Moneda</label>
                                <select class="form-select" id="newTCMoneda" name="codMoneda" required>
                                    <option value="">Seleccione...</option>
                                    <c:forEach var="m" items="${listaMonedas}">
                                        <c:if test="${m.codEstado eq 'S0001' and m.codMoneda ne 'PEN'}">
                                            <option value="${m.codMoneda}">${m.codMoneda} - ${m.descMoneda}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="newTCCompra" class="form-label">Tasa de Compra (PEN)</label>
                                <input type="number" step="0.0001" class="form-control" id="newTCCompra" name="tasaCompra" required>
                            </div>
                            <div class="mb-3">
                                <label for="newTCVenta" class="form-label">Tasa de Venta (PEN)</label>
                                <input type="number" step="0.0001" class="form-control" id="newTCVenta" name="tasaVenta" required>
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

        <div class="modal fade" id="modalEditarTipoCambio" tabindex="-1" aria-labelledby="modalEditarTipoCambioLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title" id="modalEditarTipoCambioLabel">Actualizar Tipo de Cambio</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/ControlParametros" method="post">
                        <input type="hidden" name="accion" value="actualizarTipoCambio">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="editTCCodigo" class="form-label">Moneda</label>
                                <input type="hidden" id="editTCCodigo" name="codMoneda"> 
                                <input type="text" class="form-control" id="editTCDesc" disabled> </div>
                            <div class="mb-3">
                                <label for="editTCCompra" class="form-label">Tasa de Compra (PEN)</label>
                                <input type="number" step="0.0001" class="form-control" id="editTCCompra" name="tasaCompra" required>
                            </div>
                            <div class="mb-3">
                                <label for="editTCVenta" class="form-label">Tasa de Venta (PEN)</label>
                                <input type="number" step="0.0001" class="form-control" id="editTCVenta" name="tasaVenta" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Actualizar</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalNuevoTipo" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title">Nuevo Tipo de Cuenta</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/ControlParametros" method="post">
                        <input type="hidden" name="accion" value="agregarTipoCuenta">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">Descripción</label>
                                <input type="text" class="form-control" name="descripcion" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Moneda</label>
                                <select class="form-select" name="moneda" id="editTipoCuentaMoneda" required>
                                    <c:forEach var="m" items="${listaMonedas}">
                                        <option value="${m.codMoneda}">${m.descMoneda}</option>
                                    </c:forEach>
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

        <div class="modal fade" id="modalEditarTipoCuenta" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title">Editar Tipo de Cuenta</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/ControlParametros" method="post">
                        <input type="hidden" name="accion" value="editarTipoCuenta">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">ID</label>
                                <input type="text" class="form-control" id="editTipoCuentaID" name="id" readonly>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Descripción</label>
                                <input type="text" class="form-control" id="editTipoCuentaDesc" name="descripcion" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Moneda</label>
                                <select class="form-select" name="moneda" id="editTipoCuentaMoneda" required>
                                    <c:forEach var="m" items="${listaMonedas}">
                                        <option value="${m.codMoneda}">${m.descMoneda}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Tasa de Interés (%)</label>
                                <input type="number" step="0.01" class="form-control" id="editTipoCuentaTasa" name="tasa" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Actualizar</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalNuevaCuenta" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title">Nueva Cuenta del Sistema</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/ControlParametros" method="post">
                        <input type="hidden" name="accion" value="agregarCuentaBase">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">Número de Cuenta</label>
                                <input type="text" class="form-control" name="numCuenta" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Tipo de Cuenta</label>
                                <select class="form-select" name="tipoCuenta" required>
                                    <option value="">Seleccione...</option>
                                    <option>Ahorros</option>
                                    <option>Corriente</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Moneda</label>
                                <select class="form-select" name="moneda" required>
                                    <option value="">Seleccione...</option>
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

        <div class="modal fade" id="modalEditarCuentaSistema" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title">Editar Cuenta del Sistema</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/ControlParametros" method="post">
                        <input type="hidden" name="accion" value="editarCuentaBase">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">Número de Cuenta</label>
                                <input type="text" class="form-control" id="editCuentaNum" name="numCuenta" readonly>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Tipo de Cuenta</label>
                                <select class="form-select" id="editCuentaTipo" name="tipoCuenta" required>
                                    <option>Ahorros</option>
                                    <option>Corriente</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Moneda</label>
                                <select class="form-select" id="editCuentaMoneda" name="moneda" required>
                                    <option>Soles</option>
                                    <option>Dólares</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Tasa de Interés (%)</label>
                                <input type="number" step="0.01" class="form-control" id="editCuentaTasa" name="tasa" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Actualizar</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalNuevoMovimiento" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title">Nuevo Tipo de Movimiento</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/ControlParametros" method="post">
                        <input type="hidden" name="accion" value="agregarTipoMovimiento">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">Descripción</label>
                                <input type="text" class="form-control" name="descripcion" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Signo</label>
                                <select class="form-select" name="signo" required>
                                    <option value="">Seleccione...</option>
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

        <div class="modal fade" id="modalEditarTipoMovimiento" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title">Editar Tipo de Movimiento</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/ControlParametros" method="post">
                        <input type="hidden" name="accion" value="editarTipoMovimiento">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">ID</label>
                                <input type="text" class="form-control" id="editMovID" name="id" readonly>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Descripción</label>
                                <input type="text" class="form-control" id="editMovDesc" name="descripcion" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Signo</label>
                                <select class="form-select" id="editMovSigno" name="signo" required>
                                    <option value="+">+</option>
                                    <option value="-">-</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Estado</label>
                                <select class="form-select" id="editMovEstado" name="estado" required>
                                    <option>Activo</option>
                                    <option>Inactivo</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Actualizar</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <%@ include file="../util/cont-sesion.jsp" %>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sidebar.js"></script>
        <script src="${pageContext.request.contextPath}/js/gestion-parametros.js"></script>
        <script src="${pageContext.request.contextPath}/js/session-timer.js"></script>
        <script>
            // Recuperar pestaña activa desde el parámetro URL enviado por el Servlet
            const urlParams = new URLSearchParams(window.location.search);
            const activeTab = urlParams.get('tab');
            if (activeTab) {
                // Desactivar todos
                document.querySelectorAll('.nav-link').forEach(btn => btn.classList.remove('active'));
                document.querySelectorAll('.tab-pane').forEach(pane => pane.classList.remove('show', 'active'));

                // Activar el correcto
                const tabBtn = document.querySelector(`#tab-${activeTab}`);
                const tabPane = document.querySelector(`#pane-${activeTab}`);
                if (tabBtn && tabPane) {
                    tabBtn.classList.add('active');
                    tabPane.classList.add('show', 'active');
                }
            }
        </script>
    </body>
</html>