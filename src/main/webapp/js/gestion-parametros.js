/*
 * ===================================================
 * gestion-parametros.js
 * Lógica de UI para la página de Gestión de Parámetros
 *
 * Funcionalidad:
 * 1. Persistencia de Pestañas (Tabs): Recuerda la última pestaña activa
 * después de una recarga de página (ej. al enviar un form).
 * 2. Poblado de Modales: Rellena los modales de "Editar" con
 * la información de la fila seleccionada.
 * ===================================================
 */

document.addEventListener('DOMContentLoaded', () => {

    /*
     * ----------------------------------------
     * 1. LÓGICA DE PERSISTENCIA DE PESTAÑAS (TABS)
     * ----------------------------------------
     */

    const tabs = document.querySelectorAll('#paramTabs button[data-bs-toggle="tab"]');

    // a. Guardar la pestaña activa en localStorage cuando se cambia
    tabs.forEach(tab => {
        tab.addEventListener('shown.bs.tab', (event) => {
            // event.target.id será "tab-monedas", "tab-cuentas", etc.
            localStorage.setItem('lastParamTab', event.target.id);
        });
    });

    // b. Al cargar la página, leer de localStorage
    const lastTabId = localStorage.getItem('lastParamTab');

    if (lastTabId) {
        const lastTab = document.getElementById(lastTabId);
        if (lastTab) {
            // c. Activar la pestaña guardada
            new bootstrap.Tab(lastTab).show();
        }
    }

    /*
     * ----------------------------------------
     * 2. LÓGICA PARA POBLAR MODALES DE EDICIÓN
     * ----------------------------------------
     * Se usa el evento 'show.bs.modal' que se dispara
     * justo ANTES de que el modal sea visible.
     */

    // --- Modal: Editar Moneda ---
    const modalEditarMoneda = document.getElementById('modalEditarMoneda');
    if (modalEditarMoneda) {
        modalEditarMoneda.addEventListener('show.bs.modal', (event) => {
            const button = event.relatedTarget; // El botón que abrió el modal

            // Extraer datos del botón
            const codigo = button.dataset.codigo;
            const descripcion = button.dataset.descripcion;
            const simbolo = button.dataset.simbolo;

            // Poblar el formulario
            modalEditarMoneda.querySelector('#editMonedaCodigo').value = codigo;
            modalEditarMoneda.querySelector('#editMonedaDesc').value = descripcion;
            modalEditarMoneda.querySelector('#editMonedaSimbolo').value = simbolo;
        });
    }

    // --- Modal: Editar Tipo de Cambio ---
    const modalEditarTC = document.getElementById('modalEditarTipoCambio');
    if (modalEditarTC) {
        modalEditarTC.addEventListener('show.bs.modal', (event) => {
            const button = event.relatedTarget;

            const codigo = button.dataset.codigo;
            const descripcion = button.dataset.descripcion;
            const compra = button.dataset.compra;
            const venta = button.dataset.venta;

            modalEditarTC.querySelector('#editTCCodigo').value = codigo;
            modalEditarTC.querySelector('#editTCDesc').value = `${codigo} - ${descripcion}`; // Campo visual
            modalEditarTC.querySelector('#editTCCompra').value = compra;
            modalEditarTC.querySelector('#editTCVenta').value = venta;
        });
    }

    // --- Modal: Editar Tipo de Cuenta ---
    const modalEditarTipoCuenta = document.getElementById('modalEditarTipoCuenta');
    if (modalEditarTipoCuenta) {
        modalEditarTipoCuenta.addEventListener('show.bs.modal', (event) => {
            const button = event.relatedTarget;

            modalEditarTipoCuenta.querySelector('#editTipoCuentaID').value = button.dataset.id;
            modalEditarTipoCuenta.querySelector('#editTipoCuentaDesc').value = button.dataset.descripcion;
            modalEditarTipoCuenta.querySelector('#editTipoCuentaMoneda').value = button.dataset.moneda;
            modalEditarTipoCuenta.querySelector('#editTipoCuentaTasa').value = button.dataset.tasa;
        });
    }

    // --- Modal: Editar Cuenta del Sistema ---
    const modalEditarCuentaSistema = document.getElementById('modalEditarCuentaSistema');
    if (modalEditarCuentaSistema) {
        modalEditarCuentaSistema.addEventListener('show.bs.modal', (event) => {
            const button = event.relatedTarget;

            modalEditarCuentaSistema.querySelector('#editCuentaNum').value = button.dataset.numero;
            modalEditarCuentaSistema.querySelector('#editCuentaTipo').value = button.dataset.tipo;
            modalEditarCuentaSistema.querySelector('#editCuentaMoneda').value = button.dataset.moneda;
            modalEditarCuentaSistema.querySelector('#editCuentaTasa').value = button.dataset.tasa;
        });
    }

    // --- Modal: Editar Tipo de Movimiento ---
    const modalEditarTipoMovimiento = document.getElementById('modalEditarTipoMovimiento');
    if (modalEditarTipoMovimiento) {
        modalEditarTipoMovimiento.addEventListener('show.bs.modal', (event) => {
            const button = event.relatedTarget;

            modalEditarTipoMovimiento.querySelector('#editMovID').value = button.dataset.id;
            modalEditarTipoMovimiento.querySelector('#editMovDesc').value = button.dataset.descripcion;
            modalEditarTipoMovimiento.querySelector('#editMovSigno').value = button.dataset.signo;
            modalEditarTipoMovimiento.querySelector('#editMovEstado').value = button.dataset.estado;
        });
    }
});