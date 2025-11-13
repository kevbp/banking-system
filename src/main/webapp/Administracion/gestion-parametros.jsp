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

        <!-- Fuentes y estilos globales -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/estilos.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/sidebar.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    </head>

    <body class="is-parametros">
        <%@ include file="../util/theme.jsp" %>

        <div class="d-flex">
            <!-- Sidebar general -->
            <%@ include file="../util/sidebar.jsp" %>

            <!-- Panel principal -->
            <div class="main-content flex-grow-1">
                <%@ include file="../util/header.jsp" %>

                <div class="content-area p-4">
                    <div class="card shadow-sm border-0">
                        <div class="card-header bg-white border-0 pb-0">
                            <h4 class="mb-1">Parámetros del Sistema</h4>
                            <p class="text-muted mb-0">
                                Administre las configuraciones maestras del banco: monedas, tipos de cuenta y tipos de movimiento.
                                Solo el personal autorizado debe realizar cambios en esta sección.
                            </p>
                        </div>

                        <div class="card-body">
                            <!-- Tabs de parámetros -->
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
                                <!-- TAB: MONEDAS Y TIPO DE CAMBIO -->
                                <div class="tab-pane fade show active" id="pane-monedas" role="tabpanel" aria-labelledby="tab-monedas">

                                    <h5 class="mb-3">Monedas y Tipo de Cambio</h5>
                                    <p class="text-muted small mb-3">
                                        Defina las monedas con las que opera el banco y consulte/actualice el tipo de cambio vigente para cada una.
                                    </p>

                                    <!-- ⚠️ Alerta informativa (opcional, solo front) -->
                                    <!--
                                    <div class="alert alert-warning d-flex align-items-center mb-4" role="alert">
                                        <i class="bi bi-exclamation-triangle-fill me-2"></i>
                                        <div>
                                            Falta registrar el tipo de cambio de hoy para una o más monedas extranjeras.
                                            Las operaciones con moneda extranjera se encuentran restringidas.
                                        </div>
                                    </div>
                                    -->

                                    <!-- 1) TABLA DE MONEDAS -->
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <h6 class="mb-0">Catálogo de Monedas</h6>
                                        <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#modalNuevaMoneda">
                                            <i class="bi bi-plus-circle me-1"></i> Nueva moneda
                                        </button>
                                    </div>
                                    <p class="text-muted small mb-2">
                                        Este catálogo define las monedas disponibles en el sistema.
                                    </p>

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
                                                <!-- Ejemplos estáticos, luego vendrán desde la BD -->
                                                <tr>
                                                    <td>PEN</td>
                                                    <td>Soles</td>
                                                    <td>S/</td>
                                                    <td><span class="badge bg-success">Activa</span></td>
                                                    <td>
                                                        <button class="btn btn-sm btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalEditarMoneda">
                                                            Editar
                                                        </button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>USD</td>
                                                    <td>Dólares</td>
                                                    <td>$</td>
                                                    <td><span class="badge bg-success">Activa</span></td>
                                                    <td>
                                                        <button class="btn btn-sm btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalEditarMoneda">
                                                            Editar
                                                        </button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>EUR</td>
                                                    <td>Euros</td>
                                                    <td>€</td>
                                                    <td><span class="badge bg-success">Activa</span></td>
                                                    <td>
                                                        <button class="btn btn-sm btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalEditarMonedaEUR">
                                                            Editar
                                                        </button>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>

                                    <!-- 2) TABLA DE TIPO DE CAMBIO DEL DÍA -->
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <h6 class="mb-0">Tipo de cambio del día</h6>
                                        <!-- Puedes usar este botón para un modal que registre/actualice TC -->
                                        <button class="btn btn-sm btn-primary" data-bs-toggle="modal" data-bs-target="#modalNuevoTipoCambio">
                                            <i class="bi bi-arrow-repeat me-1"></i> Registrar / Actualizar tipo de cambio
                                        </button>
                                    </div>
                                    <p class="text-muted small mb-2">
                                        Valores de compra y venta frente a la moneda base (PEN) para la fecha actual.
                                    </p>

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
                                                <!-- Ejemplo para USD -->
                                                <tr>
                                                    <td>Dólares</td>
                                                    <td>USD</td>
                                                    <td>3.7200</td>
                                                    <td>3.7500</td>
                                                    <td>12/11/2025 09:15</td>
                                                    <td>
                                                        <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modalEditarTcUSD">
                                                            Actualizar
                                                        </button>
                                                    </td>
                                                </tr>
                                                <!-- Ejemplo para EUR -->
                                                <tr>
                                                    <td>Euros</td>
                                                    <td>EUR</td>
                                                    <td>4.0000</td>
                                                    <td>4.0500</td>
                                                    <td>12/11/2025 09:20</td>
                                                    <td>
                                                        <button class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#modalEditarTcEUR">
                                                            Actualizar
                                                        </button>
                                                    </td>
                                                </tr>

                                                <!-- Ejemplo de fila sin tipo de cambio cargado aún (solo front) -->
                                                <!--
                                                <tr class="table-warning">
                                                    <td>Euros</td>
                                                    <td>EUR</td>
                                                    <td>—</td>
                                                    <td>—</td>
                                                    <td>Sin registro hoy</td>
                                                    <td>
                                                        <button class="btn btn-sm btn-outline-danger" data-bs-toggle="modal" data-bs-target="#modalRegistrarTcEUR">
                                                            Registrar
                                                        </button>
                                                    </td>
                                                </tr>
                                                -->
                                            </tbody>
                                        </table>
                                    </div>

                                    <!-- Nota informativa -->
                                    <p class="text-muted small">
                                        El sistema permitirá operaciones con moneda extranjera siempre que exista tipo de cambio registrado para USD y EUR en la fecha actual.
                                    </p>
                                </div>


                                <!-- TAB 2: TIPOS DE CUENTA (incluye cuentas del sistema) -->
                                <div class="tab-pane fade" id="pane-cuentas" role="tabpanel" aria-labelledby="tab-cuentas">
                                    <!-- Tipos de cuenta -->
                                    <h5 class="mb-3">Tipos de Cuenta</h5>
                                    <p class="text-muted small">
                                        Configure los productos disponibles: cuentas de ahorro, corrientes y de plazo.
                                        Estos parámetros se utilizan al momento de la apertura de cuentas.
                                    </p>

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
                                                <tr>
                                                    <td>1</td>
                                                    <td>Ahorros</td>
                                                    <td>Soles</td>
                                                    <td>1.50</td>
                                                    <td>Activa</td>
                                                    <td class="text-center">
                                                        <button class="btn btn-sm btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalEditarTipo1">
                                                            Editar
                                                        </button>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="text-end mb-4">
                                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalNuevoTipo">
                                            <i class="bi bi-plus-circle me-1"></i> Nuevo Tipo de Cuenta
                                        </button>
                                    </div>

                                    <hr>

                                    <!-- Cuentas del sistema -->
                                    <h5 class="mb-3">Cuentas del Sistema</h5>
                                    <p class="text-muted small">
                                        Defina las cuentas internas del banco (por ejemplo, cuentas de caja, intereses y comisiones).
                                    </p>

                                    <div class="table-responsive mb-3">
                                        <table class="table table-bordered table-striped align-middle">
                                            <thead class="table-light text-center">
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
                                                        <button class="btn btn-sm btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalEditarCuenta1">
                                                            Editar
                                                        </button>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="text-end mb-1">
                                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalNuevaCuenta">
                                            <i class="bi bi-plus-circle me-1"></i> Nueva Cuenta del Sistema
                                        </button>
                                    </div>
                                </div>

                                <!-- TAB 3: TIPOS DE MOVIMIENTO -->
                                <div class="tab-pane fade" id="pane-movimientos" role="tabpanel" aria-labelledby="tab-movimientos">
                                    <h5 class="mb-3">Tipos de Movimiento</h5>
                                    <p class="text-muted small">
                                        Defina los códigos de movimiento que se utilizan en las operaciones de las cuentas:
                                        depósitos, retiros, comisiones, intereses, etc.
                                    </p>

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
                                                <tr>
                                                    <td>1</td>
                                                    <td>Depósito</td>
                                                    <td>+</td>
                                                    <td>Activo</td>
                                                    <td class="text-center">
                                                        <button class="btn btn-sm btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalEditarMov1">
                                                            Editar
                                                        </button>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>2</td>
                                                    <td>Retiro</td>
                                                    <td>-</td>
                                                    <td>Activo</td>
                                                    <td class="text-center">
                                                        <button class="btn btn-sm btn-outline-warning" data-bs-toggle="modal" data-bs-target="#modalEditarMov2">
                                                            Editar
                                                        </button>
                                                    </td>
                                                </tr>
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
                </div> <!-- ./content-area -->
            </div> <!-- ./main-content -->
        </div> <!-- ./dashboard -->

        <!-- ========== MODALES ========== -->

        <!-- Modal: Nueva Moneda -->
        <div class="modal fade" id="modalNuevaMoneda" tabindex="-1" aria-labelledby="modalNuevaMonedaLabel" aria-hidden="true">
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

        <!-- Modal: Editar Moneda -->
        <div class="modal fade" id="modalEditarMoneda" tabindex="-1" aria-labelledby="modalEditarMonedaLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title" id="modalEditarMonedaLabel">Editar Moneda</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/ControlParametros" method="post">
                        <input type="hidden" name="accion" value="editarMoneda">

                        <!-- Campo de código (solo lectura) -->
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="codMoneda" class="form-label">Código de Moneda</label>
                                <input type="text" class="form-control" id="codMoneda" name="codMoneda" readonly>
                            </div>

                            <!-- Campo de descripción -->
                            <div class="mb-3">
                                <label for="descMoneda" class="form-label">Descripción</label>
                                <input type="text" class="form-control" id="descMoneda" name="descMoneda" required>
                            </div>

                            <!-- Campo de símbolo -->
                            <div class="mb-3">
                                <label for="simbolo" class="form-label">Símbolo</label>
                                <input type="text" class="form-control" id="simbolo" name="simbolo" required>
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



        <!-- Modal: Registrar / Actualizar Tipo de Cambio -->
        <div class="modal fade" id="modalNuevoTipoCambio" tabindex="-1" aria-labelledby="modalNuevoTipoCambioLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title" id="modalNuevoTipoCambioLabel">Registrar / Actualizar Tipo de Cambio</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/ControlParametros" method="post">
                        <input type="hidden" name="accion" value="registrarTipoCambio">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="codMoneda" class="form-label">Moneda</label>
                                <select class="form-select" id="codMoneda" name="codMoneda" required>
                                    <option value="USD">USD - Dólares</option>
                                    <option value="EUR">EUR - Euros</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="tasaCompra" class="form-label">Tasa de Compra (PEN)</label>
                                <input type="number" step="0.0001" class="form-control" id="tasaCompra" name="tasaCompra" required>
                            </div>
                            <div class="mb-3">
                                <label for="tasaVenta" class="form-label">Tasa de Venta (PEN)</label>
                                <input type="number" step="0.0001" class="form-control" id="tasaVenta" name="tasaVenta" required>
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

        <!-- Modal: Editar Tipo de Cambio -->
        <div class="modal fade" id="modalEditarTcUSD" tabindex="-1" aria-labelledby="modalEditarTcUSDLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title" id="modalEditarTcUSDLabel">Actualizar Tipo de Cambio (USD)</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/ControlParametros" method="post">
                        <input type="hidden" name="accion" value="actualizarTipoCambio">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="codMoneda" class="form-label">Moneda</label>
                                <select class="form-select" id="codMoneda" name="codMoneda" readonly>
                                    <option value="USD" selected>USD - Dólares</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="tasaCompra" class="form-label">Tasa de Compra (PEN)</label>
                                <input type="number" step="0.0001" class="form-control" id="tasaCompra" name="tasaCompra" required>
                            </div>
                            <div class="mb-3">
                                <label for="tasaVenta" class="form-label">Tasa de Venta (PEN)</label>
                                <input type="number" step="0.0001" class="form-control" id="tasaVenta" name="tasaVenta" required>
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

        <!-- Modal: Nuevo Tipo de Cuenta -->
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

        <!-- Modal: Nueva Cuenta del Sistema -->
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

        <!-- Scripts -->
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sidebar.js"></script>

    </body>
</html>
