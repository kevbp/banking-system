<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Gestión de Cuentas</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/estilos.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/sidebar.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body data-active-page="cuentas-gestion">
        <%@ include file="../util/theme.jsp" %>
        <div class="d-flex">
            <%@ include file="../util/sidebar.jsp" %>
            <div class="main-content flex-grow-1">
                <%@ include file="../util/header.jsp" %>

                <div class="content-area p-4">
                    <c:if test="${not empty param.msg}">
                        <div class="alert alert-info alert-dismissible fade show">${param.msg}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>

                    <div class="card mb-4 border-0 shadow-sm">
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/ControlCuenta" method="get">
                                <input type="hidden" name="accion" value="listar">
                                <div class="row g-2">
                                    <div class="col-md-4"><input type="text" class="form-control" name="numCuenta" placeholder="N° Cuenta" value="${param.numCuenta}"></div>
                                    <div class="col-md-4"><input type="text" class="form-control" name="numDoc" placeholder="DNI Cliente" value="${param.numDoc}"></div>
                                    <div class="col-md-4"><button type="submit" class="btn btn-primary w-100"><i class="bi bi-search"></i> Buscar</button></div>
                                </div>
                            </form>
                        </div>
                    </div>

                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-white fw-bold">Resultados</div>
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="table-light">
                                    <tr><th>Cuenta</th><th>Cliente</th><th>Producto</th><th>Moneda</th><th>Estado</th><th>Acción</th></tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="c" items="${listaCuentas}">
                                        <tr>
                                            <td class="font-monospace fw-bold text-primary">${c.numCuenta}</td>
                                            <td>${c.cliente.nombre}</td>
                                            <td><small>${c.desTipoCuenta}</small></td>
                                            <td>${c.desMoneda}</td>
                                            <td><span class="badge bg-secondary">${c.desEstado}</span></td>
                                            <td>
                                                <button type="button" class="btn btn-sm btn-primary w-100 btn-ver" data-id="${c.numCuenta}">
                                                    <i class="bi bi-eye-fill me-1"></i> Ver cuenta
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalGestion" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-white">
                        <h5 class="modal-title">Cuenta: <span id="lblCuenta" class="font-monospace text-warning">...</span></h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body bg-light">

                        <div class="card border-0 shadow-sm mb-3">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-8">
                                        <label class="small text-muted fw-bold">TITULAR</label>
                                        <h5 class="fw-bold text-dark mb-1" id="valCli">...</h5>
                                        <small class="text-muted" id="valDoc">...</small>
                                    </div>
                                    <div class="col-md-4 text-end border-start">
                                        <label class="small text-muted fw-bold">ESTADO ACTUAL</label>
                                        <h5 id="valEstBadged">...</h5>
                                    </div>
                                </div>
                                <hr class="my-2">
                                <div class="row small">
                                    <div class="col-6"><strong>Producto:</strong> <span id="valTip">...</span></div>
                                    <div class="col-6"><strong>Moneda:</strong> <span id="valMon">...</span></div>
                                    <div class="col-6"><strong>Saldo Actual:</strong> <span id="valSaldo" class="fw-bold text-primary">...</span></div>
                                    <div class="col-6"><strong>Fecha Apertura:</strong> <span id="valFec">...</span></div>
                                </div>
                            </div>
                        </div>

                        <div id="alertEmbargo" class="alert alert-danger d-none border-danger">
                            <strong><i class="bi bi-exclamation-triangle-fill"></i> CUENTA EMBARGADA</strong>
                            <ul class="mb-0 small mt-1">
                                <li>Expediente: <span id="embExp"></span></li>
                                <li>Monto Retenido: <span id="embMonto"></span></li>
                                <li>Motivo: <span id="embMot"></span></li>
                            </ul>
                        </div>

                        <div id="formEmbargo" class="card border-danger d-none shadow-sm mb-3">
                            <div class="card-header bg-danger text-white py-1 fw-bold small">Nuevo Embargo</div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/ControlCuenta" method="post">
                                    <input type="hidden" name="accion" value="embargar">
                                    <input type="hidden" name="numCuentaEmbargo" id="inEmbargoNum">
                                    <div class="row g-2">
                                        <div class="col-4"><input type="number" step="0.01" class="form-control form-control-sm" name="monto" placeholder="Monto" required></div>
                                        <div class="col-8"><input type="text" class="form-control form-control-sm" name="expediente" placeholder="N° Expediente" required></div>
                                        <div class="col-12"><input type="text" class="form-control form-control-sm" name="motivo" placeholder="Motivo" required></div>
                                    </div>
                                    <div class="text-end mt-2">
                                        <button type="button" class="btn btn-sm btn-secondary" onclick="$('#formEmbargo').addClass('d-none')">Cancelar</button>
                                        <button class="btn btn-sm btn-danger">Confirmar</button>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-center">

                            <form action="${pageContext.request.contextPath}/ControlCuenta" method="post" id="formEstado">
                                <input type="hidden" name="accion" value="cambiarEstado">
                                <input type="hidden" name="tipo" id="inTipoEstado"> <input type="hidden" name="numCuenta" id="inEstadoNum">
                                <button id="btnToggleEstado" class="btn btn-warning px-4 fw-bold">
                                    <i class="bi bi-power me-1"></i> <span id="lblToggleEstado">Desactivar</span>
                                </button>
                            </form>

                            <button class="btn btn-danger px-4 fw-bold" id="btnShowEmbargo">
                                <i class="bi bi-hammer me-1"></i> Embargar
                            </button>

                            <form action="${pageContext.request.contextPath}/ControlCuenta" method="post" onsubmit="return confirm('¿CERRAR DEFINITIVAMENTE esta cuenta?');">
                                <input type="hidden" name="accion" value="cambiarEstado">
                                <input type="hidden" name="tipo" value="cerrar">
                                <input type="hidden" name="numCuenta" id="inCerrarNum">
                                <button id="btnCerrarCuenta" class="btn btn-dark px-4 fw-bold"> 
                                    <i class="bi bi-archive-fill me-1"></i> 
                                    Cerrar
                                </button>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <%@ include file="../util/cont-sesion.jsp" %>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sidebar.js"></script>

        <script>
                                $(document).ready(function () {
                                    $('.btn-ver').click(function () {
                                        let num = $(this).data('id');

                                        // 1. PRE-ASIGNAR IDs
                                        $('#lblCuenta').text(num);
                                        $('#inEmbargoNum').val(num);
                                        $('#inCerrarNum').val(num);
                                        $('#inEstadoNum').val(num);

                                        // 2. RESETEAR UI (¡Importante!)
                                        // Ocultar alertas y formularios previos
                                        $('#formEmbargo').addClass('d-none');
                                        $('#alertEmbargo').addClass('d-none');

                                        // Poner textos de carga
                                        $('#valCli').text('Cargando...');
                                        $('#valSaldo').text('...');
                                        $('#valEstBadged').html('<span class="badge bg-secondary">Consultando...</span>');

                                        // HABILITAR TODOS LOS BOTONES DEL MODAL AL INICIO
                                        // Esto corrige el problema de que se queden bloqueados si viste una cerrada antes
                                        $('#modalGestion button').prop('disabled', false);

                                        // Resetear texto del botón de estado
                                        $('#lblToggleEstado').text('Cargando...');

                                        // 3. AJAX
                                        $.ajax({
                                            url: '${pageContext.request.contextPath}/ControlCuenta',
                                            data: {accion: 'detalle', num: num},
                                            dataType: 'json',
                                            success: function (data) {
                                                if (data.exito) {
                                                    // Datos básicos
                                                    $('#valCli').text(data.cliente); // Asegúrate que sea data.cliente
                                                    $('#valDoc').text(data.doc);
                                                    $('#valTip').text(data.tipo);
                                                    $('#valMon').text(data.moneda);
                                                    $('#valFec').text(data.fecha.substring(0, 10));

                                                    // Saldo
                                                    let simbolo = (data.moneda === 'Dólares') ? '$ ' : 'S/ ';
                                                    let saldoNum = parseFloat(data.saldo);
                                                    $('#valSaldo').text(simbolo + saldoNum.toFixed(2));

                                                    // --- LÓGICA DE ESTADOS Y BOTONES ---

                                                    let badgeColor = 'bg-secondary';
                                                    let estadoTexto = data.estado; // Texto que viene de la BD (Activo, Cerrado...)

                                                    // Configuración por defecto del botón Toggle
                                                    let btnToggle = $('#btnToggleEstado');
                                                    let lblToggle = $('#lblToggleEstado');
                                                    let inputTipo = $('#inTipoEstado');

                                                    if (data.codEstado === 'S0001') {
                                                        // ACTIVO
                                                        badgeColor = 'bg-success';
                                                        lblToggle.text('Desactivar');
                                                        inputTipo.val('inactivar');
                                                        btnToggle.removeClass('btn-success btn-secondary').addClass('btn-warning');

                                                    } else if (data.codEstado === 'S0002') {
                                                        // INACTIVO
                                                        badgeColor = 'bg-warning text-dark';
                                                        lblToggle.text('Activar');
                                                        inputTipo.val('activar');
                                                        btnToggle.removeClass('btn-warning btn-secondary').addClass('btn-success');

                                                    } else if (data.codEstado === 'S0005') {
                                                        // CERRADO
                                                        badgeColor = 'bg-dark';
                                                        lblToggle.text('Cuenta Cerrada'); // Texto explícito en el botón
                                                        btnToggle.removeClass('btn-success btn-warning').addClass('btn-secondary');
                                                        btnToggle.prop('disabled', true); // Botón desactivado

                                                    } else if (data.codEstado === 'S0006') {
                                                        // EMBARGADO
                                                        badgeColor = 'bg-danger';
                                                        lblToggle.text('Embargada');
                                                        btnToggle.prop('disabled', true);
                                                    }

                                                    // Actualizar el Badge (La casilla de estado)
                                                    $('#valEstBadged').html(`<span class="badge ${badgeColor} fs-6">${estadoTexto}</span>`);

                                                    // Regla de Negocio: No cerrar si hay saldo
                                                    if (saldoNum > 0) {
                                                        $('#btnCerrarCuenta').prop('disabled', true);
                                                        $('#btnCerrarCuenta').attr('title', 'No se puede cerrar cuenta con saldo');
                                                    } else {
                                                        // Solo habilitar si la cuenta NO está cerrada ya
                                                        if (data.codEstado !== 'S0005') {
                                                            $('#btnCerrarCuenta').prop('disabled', false);
                                                        }
                                                    }

                                                    // Mostrar Embargo si existe
                                                    if (data.embargo && data.embargo.activo) {
                                                        $('#alertEmbargo').removeClass('d-none');
                                                        $('#embExp').text(data.embargo.expediente);
                                                        $('#embMonto').text(data.embargo.monto);
                                                        $('#embMot').text(data.embargo.motivo);
                                                        $('#btnShowEmbargo').prop('disabled', true); // Ya está embargada
                                                    }

                                                    // BLOQUEO FINAL: Si está cerrada, bloquear acciones críticas
                                                    if (data.codEstado === 'S0005') {
                                                        // Bloqueamos botones de acción (Embargar, Cerrar, Toggle)
                                                        $('#btnShowEmbargo').prop('disabled', true);
                                                        $('#btnCerrarCuenta').prop('disabled', true);
                                                        // El btnToggle ya se deshabilitó arriba
                                                    }

                                                } else {
                                                    alert('No se pudieron cargar los datos.');
                                                }
                                            },
                                            error: function () {
                                                alert('Error de conexión.');
                                            }
                                        });
                                        new bootstrap.Modal(document.getElementById('modalGestion')).show();
                                    });

                                    $('#btnShowEmbargo').click(function () {
                                        $('#formEmbargo').removeClass('d-none');
                                    });
                                });
        </script>
        <script src="${pageContext.request.contextPath}/js/session-timer.js"></script>
    </body>
</html>