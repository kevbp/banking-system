/*
 * ===================================================
 * gestion-parametros.js
 * Lógica de UI para la página de Gestión de Parámetros
 * ===================================================
 */

document.addEventListener('DOMContentLoaded', () => {

    // =================================================
    // 1. LÓGICA DE PERSISTENCIA DE PESTAÑAS (TABS)
    // =================================================

    const tabs = document.querySelectorAll('#paramTabs button[data-bs-toggle="tab"]');

    tabs.forEach(tab => {
        tab.addEventListener('shown.bs.tab', (event) => {
            localStorage.setItem('lastParamTab', event.target.id);
        });
    });

    const lastTabId = localStorage.getItem('lastParamTab');
    if (lastTabId) {
        const lastTab = document.getElementById(lastTabId);
        if (lastTab) {
            new bootstrap.Tab(lastTab).show();
        }
    }

    // =================================================
    // 2. LÓGICA PARA MODALES
    // =================================================

    // -------------------------------------------------
    // A. Modal "NUEVO Tipo de Cuenta"
    // -------------------------------------------------
    const modalNuevoTipo = document.getElementById('modalNuevoTipo');
    const selCategoria = document.getElementById('newTipoCategoria');
    const inpDesc = document.getElementById('newTipoDesc');
    const divNewSobregiro = document.getElementById('divNewSobregiro');
    const inpNewSobregiro = document.getElementById('inpNewSobregiro');

    if (modalNuevoTipo && selCategoria) {

        // 1. Evento al CAMBIAR la categoría en el select
        selCategoria.addEventListener('change', () => {
            const cat = selCategoria.value;

            // Autocompletar descripción sugerida
            if (inpDesc) {
                if (cat === 'Corriente')
                    inpDesc.value = "Cuenta Corriente";
                else if (cat === 'Ahorros')
                    inpDesc.value = "Cuenta de Ahorros";
                else if (cat === 'Plazo')
                    inpDesc.value = "Cuenta a Plazo Fijo";
            }

            // Mostrar u Ocultar Sobregiro
            if (cat === 'Corriente') {
                if (divNewSobregiro)
                    divNewSobregiro.classList.remove('d-none');
                if (inpNewSobregiro) {
                    inpNewSobregiro.required = true;
                    inpNewSobregiro.value = "0.00";
                }
            } else {
                if (divNewSobregiro)
                    divNewSobregiro.classList.add('d-none');
                if (inpNewSobregiro) {
                    inpNewSobregiro.required = false;
                    inpNewSobregiro.value = "0.00";
                }
            }
        });

        // 2. Evento al ABRIR el modal (Resetear estado)
        modalNuevoTipo.addEventListener('show.bs.modal', () => {
            // Volver al estado inicial (Ahorros)
            selCategoria.value = "Ahorros";
            if (inpDesc)
                inpDesc.value = "";
            // Ocultar sobregiro visualmente
            if (divNewSobregiro)
                divNewSobregiro.classList.add('d-none');
            if (inpNewSobregiro)
                inpNewSobregiro.required = false;
        });
    }

    // -------------------------------------------------
    // B. Modal "EDITAR Tipo de Cuenta"
    // -------------------------------------------------
    const modalEditarTipoCuenta = document.getElementById('modalEditarTipoCuenta');

    if (modalEditarTipoCuenta) {
        modalEditarTipoCuenta.addEventListener('show.bs.modal', (event) => {
            const button = event.relatedTarget;

            // 1. Recuperar datos del botón (data-attributes)
            const id = button.dataset.id;
            const desc = button.dataset.descripcion;
            const moneda = button.dataset.moneda;
            const tasa = button.dataset.tasa;
            // Importante: Si no existe el data-sobregiro, asumimos 0
            const sobregiro = parseFloat(button.dataset.sobregiro || 0);

            // 2. Asignar a los campos básicos
            modalEditarTipoCuenta.querySelector('#editTipoCuentaID').value = id;
            modalEditarTipoCuenta.querySelector('#editTipoCuentaDesc').value = desc;
            modalEditarTipoCuenta.querySelector('#editTipoCuentaMoneda').value = moneda;
            modalEditarTipoCuenta.querySelector('#editTipoCuentaTasa').value = tasa;

            // 3. Lógica del campo Sobregiro
            const divSob = modalEditarTipoCuenta.querySelector('#divEditSobregiro');
            const inpSob = modalEditarTipoCuenta.querySelector('#editTipoCuentaSobregiro');

            // Mostrar SI es "Corriente" O SI ya tiene un sobregiro configurado
            if (desc.toLowerCase().includes('corriente') || sobregiro > 0) {
                if (divSob)
                    divSob.classList.remove('d-none');
                if (inpSob) {
                    inpSob.value = sobregiro.toFixed(2);
                    inpSob.required = true;
                }
            } else {
                if (divSob)
                    divSob.classList.add('d-none');
                if (inpSob) {
                    inpSob.value = "0.00";
                    inpSob.required = false;
                }
            }
        });
    }

    // -------------------------------------------------
    // C. Otros Modales (Monedas, Tipos Cambio, etc.)
    // -------------------------------------------------

    // Editar Moneda
    const modalEditarMoneda = document.getElementById('modalEditarMoneda');
    if (modalEditarMoneda) {
        modalEditarMoneda.addEventListener('show.bs.modal', (evt) => {
            const btn = evt.relatedTarget;
            modalEditarMoneda.querySelector('#editMonedaCodigo').value = btn.dataset.codigo;
            modalEditarMoneda.querySelector('#editMonedaDesc').value = btn.dataset.descripcion;
            modalEditarMoneda.querySelector('#editMonedaSimbolo').value = btn.dataset.simbolo;
        });
    }

    // Editar Tipo Cambio
    const modalEditarTC = document.getElementById('modalEditarTipoCambio');
    if (modalEditarTC) {
        modalEditarTC.addEventListener('show.bs.modal', (evt) => {
            const btn = evt.relatedTarget;
            modalEditarTC.querySelector('#editTCCodigo').value = btn.dataset.codigo;
            modalEditarTC.querySelector('#editTCDesc').value = btn.dataset.descripcion;
            modalEditarTC.querySelector('#editTCCompra').value = btn.dataset.compra;
            modalEditarTC.querySelector('#editTCVenta').value = btn.dataset.venta;
        });
    }

    // Editar Cuenta Sistema
    const modalEditarCuentaSistema = document.getElementById('modalEditarCuentaSistema');
    if (modalEditarCuentaSistema) {
        modalEditarCuentaSistema.addEventListener('show.bs.modal', (evt) => {
            const btn = evt.relatedTarget;
            modalEditarCuentaSistema.querySelector('#editCuentaNum').value = btn.dataset.numero;
            modalEditarCuentaSistema.querySelector('#editCuentaTipo').value = btn.dataset.tipo;
            modalEditarCuentaSistema.querySelector('#editCuentaMoneda').value = btn.dataset.moneda;
            modalEditarCuentaSistema.querySelector('#editCuentaTasa').value = btn.dataset.tasa;
        });
    }

    // Editar Tipo Movimiento
    const modalEditarTipoMovimiento = document.getElementById('modalEditarTipoMovimiento');
    if (modalEditarTipoMovimiento) {
        modalEditarTipoMovimiento.addEventListener('show.bs.modal', (evt) => {
            const btn = evt.relatedTarget;
            modalEditarTipoMovimiento.querySelector('#editMovID').value = btn.dataset.id;
            modalEditarTipoMovimiento.querySelector('#editMovDesc').value = btn.dataset.descripcion;
            modalEditarTipoMovimiento.querySelector('#editMovSigno').value = btn.dataset.signo;
            modalEditarTipoMovimiento.querySelector('#editMovEstado').value = btn.dataset.estado;
        });
    }
});