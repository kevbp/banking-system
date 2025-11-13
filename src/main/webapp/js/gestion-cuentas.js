/*
 * ===================================================
 * gestion-cuentas.js
 * Lógica de UI para la página de Gestión de Cuentas
 *
 * Funcionalidad:
 * 1. Poblado dinámico del Modal "Ver Cuenta".
 * 2. Lógica condicional para mostrar/ocultar secciones
 * (Embargos, Plazo Fijo).
 * ===================================================
 */

document.addEventListener('DOMContentLoaded', () => {

    const modalElement = document.getElementById('modalGestionCuenta');

    if (modalElement) {
        // --- Elementos del Modal ---
        const modalLabel = document.getElementById('modalGestionCuentaLabel');
        // Info General
        const modalCliente = document.getElementById('modalCuentaCliente');
        const modalTipo = document.getElementById('modalCuentaTipo');
        const modalMoneda = document.getElementById('modalCuentaMoneda');
        const modalSaldo = document.getElementById('modalCuentaSaldo');
        const modalEstado = document.getElementById('modalCuentaEstado');
        const modalFechaApertura = document.getElementById('modalCuentaFechaApertura');
        // Plazo Fijo
        const modalFilaInteres = document.getElementById('modalPlazoFijoFilaInteres');
        const modalInteres = document.getElementById('modalCuentaInteres');
        const modalFilaPlazo = document.getElementById('modalPlazoFijoFilaPlazo');
        const modalPlazo = document.getElementById('modalCuentaPlazo');
        // Embargo
        const modalEmbargoAlert = document.getElementById('modalEmbargoAlert');
        const modalSinEmbargoAlert = document.getElementById('modalSinEmbargoAlert');
        const modalEmbargoMonto = document.getElementById('modalEmbargoMonto');
        const modalEmbargoExp = document.getElementById('modalEmbargoExp');
        const modalEmbargoMotivo = document.getElementById('modalEmbargoMotivo');

        // --- Evento ---
        modalElement.addEventListener('show.bs.modal', (event) => {
            const button = event.relatedTarget;

            // 1. Extraer datos del botón
            const nroCuenta = button.dataset.nroCuenta;
            const cliente = button.dataset.cliente;
            const tipo = button.dataset.tipo;
            const moneda = button.dataset.moneda;
            const saldo = button.dataset.saldo;
            const estado = button.dataset.estado;
            const fechaApertura = button.dataset.fechaApertura;
            const embargoActivo = button.dataset.embargoActivo === 'true'; // Convertir a booleano
            const interes = button.dataset.interes;
            const plazo = button.dataset.plazo;

            // 2. Poblar Info General
            modalLabel.textContent = `Detalle de Cuenta - ${nroCuenta}`;
            modalCliente.textContent = cliente;
            modalTipo.textContent = tipo;
            modalMoneda.textContent = moneda;
            modalSaldo.textContent = saldo;
            modalEstado.textContent = estado;
            modalFechaApertura.textContent = fechaApertura;

            // 3. Lógica condicional para Plazo Fijo
            if (tipo === 'Plazo Fijo') {
                modalInteres.textContent = `${interes}%`;
                modalPlazo.textContent = plazo;
                modalFilaInteres.classList.remove('d-none');
                modalFilaPlazo.classList.remove('d-none');
            } else {
                modalFilaInteres.classList.add('d-none');
                modalFilaPlazo.classList.add('d-none');
            }

            // 4. Lógica condicional para Embargo
            if (embargoActivo) {
                modalEmbargoMonto.textContent = button.dataset.embargoMonto;
                modalEmbargoExp.textContent = button.dataset.embargoExp;
                modalEmbargoMotivo.textContent = button.dataset.embargoMotivo;
                modalEmbargoAlert.classList.remove('d-none');
                modalSinEmbargoAlert.classList.add('d-none');
            } else {
                modalEmbargoAlert.classList.add('d-none');
                modalSinEmbargoAlert.classList.remove('d-none');
            }
        });
    }
});