document.addEventListener('DOMContentLoaded', () => {

    // Referencias del Modal
    const modalEl = document.getElementById('modalDetalle');

    // Campos de valor (Detalles visuales)
    const lblNum = document.getElementById('lblNumCuenta');
    const valCliente = document.getElementById('valCliente');
    const valTipo = document.getElementById('valTipo');
    const valMoneda = document.getElementById('valMoneda');
    const valSaldo = document.getElementById('valSaldo');
    const valEstado = document.getElementById('valEstado');
    const valFecha = document.getElementById('valFecha');

    // Secciones y Alertas
    const alertEmbargo = document.getElementById('alertEmbargoInfo');
    const formEmbargo = document.getElementById('formEmbargoSection');
    const actionsPanel = document.getElementById('actionsPanel');

    // INPUTS OCULTOS (Para que funcionen los botones)
    const inpCerrar = document.getElementById('inputNumCuentaCerrar');
    const inpInactivar = document.getElementById('inputNumCuentaInactivar');
    const inpEmbargo = document.getElementById('inputNumCuentaEmbargo');

    // Botones UI
    const btnShowEmbargo = document.getElementById('btnShowEmbargo');
    const btnCancelEmbargo = document.getElementById('btnCancelarEmbargo');

    // EVENTO 1: Abrir Modal
    modalEl.addEventListener('show.bs.modal', (event) => {
        const button = event.relatedTarget;
        const numCuenta = button.getAttribute('data-num');

        // --- ASIGNACIÓN CRÍTICA: Asegura que los botones funcionen ---
        lblNum.textContent = numCuenta;
        inpCerrar.value = numCuenta;
        inpInactivar.value = numCuenta;
        inpEmbargo.value = numCuenta;

        // Resetear vista
        alertEmbargo.classList.add('d-none');
        formEmbargo.classList.add('d-none');
        actionsPanel.classList.remove('d-none');
        valCliente.textContent = "Cargando...";
        valSaldo.textContent = "";

        // --- Cargar datos vía AJAX ---
        fetch(`${contextPath}/ControlCuenta?accion=detalle&num=${numCuenta}`)
                .then(res => {
                    if (!res.ok) {
                        throw new Error("Error de red o Servidor no accesible.");
                    }
                    return res.json();
                })
                .then(data => {
                    if (data && data.exito) {
                        valCliente.textContent = data.cliente;
                        valTipo.textContent = data.tipo;
                        valMoneda.textContent = data.moneda;

                        // Formateo de Saldo
                        const saldoFormato = (data.moneda === 'Dólares' ? '$ ' : 'S/ ') + parseFloat(data.saldo).toFixed(2);
                        valSaldo.textContent = saldoFormato;

                        // Manejo de Estado
                        valEstado.innerHTML = `<span class="badge bg-${data.estado === 'Activo' ? 'success' : (data.estado === 'Embargado' ? 'danger' : 'secondary')}">${data.estado}</span>`;
                        valFecha.textContent = data.fecha.substring(0, 10); // Cortar el timestamp

                        // Manejo de Embargo Activo
                        if (data.embargo && data.embargo.activo) {
                            alertEmbargo.classList.remove('d-none');
                            document.getElementById('embExp').textContent = data.embargo.expediente;
                            document.getElementById('embMot').textContent = data.embargo.motivo;
                            document.getElementById('embMonto').textContent = (data.moneda === 'Dólares' ? '$ ' : 'S/ ') + parseFloat(data.embargo.monto).toFixed(2);

                            btnShowEmbargo.classList.add('disabled');
                        } else {
                            btnShowEmbargo.classList.remove('disabled');
                        }
                    } else {
                        valCliente.textContent = "Error: No se pudo cargar el detalle.";
                        console.error("El servidor devolvió un error lógico o datos vacíos.");
                    }
                })
                .catch(err => {
                    console.error("Error AJAX:", err);
                    valCliente.textContent = "Error de conexión con el servidor.";
                });
    });

    // EVENTO 2: Mostrar Formulario Embargo
    if (btnShowEmbargo) {
        btnShowEmbargo.addEventListener('click', () => {
            if (!btnShowEmbargo.classList.contains('disabled')) { // Solo si no está embargada
                formEmbargo.classList.remove('d-none');
                actionsPanel.classList.add('d-none');
            }
        });
    }

    // EVENTO 3: Cancelar Embargo
    if (btnCancelEmbargo) {
        btnCancelEmbargo.addEventListener('click', () => {
            formEmbargo.classList.add('d-none');
            actionsPanel.classList.remove('d-none');
        });
    }
});