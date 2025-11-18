document.addEventListener('DOMContentLoaded', () => {

    const modalEl = document.getElementById('modalDetalle');

    // IDs de Campos Visuales
    const lblNum = document.getElementById('lblNumCuenta');
    const badgeEstado = document.getElementById('badgeEstado');
    const valCliente = document.getElementById('valCliente');
    const valTipo = document.getElementById('valTipo');
    const valSaldo = document.getElementById('valSaldo');
    const valMoneda = document.getElementById('valMoneda');
    const valMonedaDesc = document.getElementById('valMonedaDesc');
    const valFecha = document.getElementById('valFecha');

    // Secciones de Embargo
    const alertEmbargo = document.getElementById('alertEmbargoInfo');
    const formEmbargo = document.getElementById('formEmbargoSection');
    const actionsPanel = document.getElementById('actionsPanel');

    // Inputs ocultos para formularios
    const inpCerrar = document.getElementById('inputNumCuentaCerrar');
    const inpInactivar = document.getElementById('inputNumCuentaInactivar');
    const inpEmbargo = document.getElementById('inputNumCuentaEmbargo');

    // Botones
    const btnShowEmbargo = document.getElementById('btnShowEmbargo');
    const btnCancelEmbargo = document.getElementById('btnCancelarEmbargo');

    // AL ABRIR EL MODAL
    modalEl.addEventListener('show.bs.modal', (event) => {
        const button = event.relatedTarget;
        const numCuenta = button.getAttribute('data-num');

        // 1. Asignación inmediata de IDs (Esto hace que los botones funcionen siempre)
        lblNum.textContent = numCuenta;
        inpCerrar.value = numCuenta;
        inpInactivar.value = numCuenta;
        inpEmbargo.value = numCuenta;

        // 2. Resetear UI
        alertEmbargo.classList.add('d-none');
        formEmbargo.classList.add('d-none');
        actionsPanel.classList.remove('d-none');
        badgeEstado.className = 'badge bg-secondary';
        badgeEstado.textContent = 'Cargando...';
        valCliente.textContent = 'Consultando...';
        valSaldo.textContent = '--';

        // 3. Petición AJAX
        fetch(`${contextPath}/ControlCuenta?accion=detalle&num=${numCuenta}`)
                .then(res => {
                    if (!res.ok)
                        throw new Error("Error en el servidor");
                    return res.json();
                })
                .then(data => {
                    if (data && data.exito) {
                        // Llenar datos
                        valCliente.textContent = data.cliente;
                        valTipo.textContent = data.tipo;

                        const simbolo = data.moneda === 'Dólares' ? '$ ' : 'S/ ';
                        valSaldo.textContent = simbolo + parseFloat(data.saldo).toFixed(2);
                        valMoneda.textContent = data.moneda;
                        valMonedaDesc.textContent = data.moneda;
                        valFecha.textContent = data.fecha.substring(0, 10);

                        // Estado (Color dinámico)
                        let colorBadge = 'bg-secondary';
                        if (data.estado === 'Activo' || data.estado === 'Activa')
                            colorBadge = 'bg-success';
                        if (data.estado === 'Embargado')
                            colorBadge = 'bg-danger';
                        if (data.estado === 'Cerrado')
                            colorBadge = 'bg-dark';

                        badgeEstado.className = `badge ${colorBadge}`;
                        badgeEstado.textContent = data.estado;

                        // Embargos
                        if (data.embargo && data.embargo.activo) {
                            alertEmbargo.classList.remove('d-none');
                            document.getElementById('embExp').textContent = data.embargo.expediente;
                            document.getElementById('embMonto').textContent = simbolo + parseFloat(data.embargo.monto).toFixed(2);
                            document.getElementById('embMot').textContent = data.embargo.motivo;
                            btnShowEmbargo.disabled = true; // No permitir doble embargo
                        } else {
                            btnShowEmbargo.disabled = false;
                        }
                    } else {
                        valCliente.textContent = "Error al cargar datos";
                        alert("No se encontraron datos para esta cuenta.");
                    }
                })
                .catch(err => {
                    console.error(err);
                    valCliente.textContent = "Error de conexión";
                });
    });

    // Lógica de visualización de formularios
    if (btnShowEmbargo) {
        btnShowEmbargo.addEventListener('click', () => {
            formEmbargo.classList.remove('d-none');
            actionsPanel.classList.add('d-none');
        });
    }

    if (btnCancelEmbargo) {
        btnCancelEmbargo.addEventListener('click', () => {
            formEmbargo.classList.add('d-none');
            actionsPanel.classList.remove('d-none');
        });
    }
});