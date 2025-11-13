/*
 * ===================================================
 * consulta-cuentas.js
 * Lógica de UI para la página de Consulta de Cuentas
 *
 * Funcionalidad:
 * 1. Poblado dinámico del Modal "Ver Cuenta".
 * ===================================================
 */

document.addEventListener('DOMContentLoaded', () => {

    // 1. Lógica del Modal Ver Cuenta
    const modalVerCuenta = document.getElementById('modalVerCuenta');

    if (modalVerCuenta) {
        modalVerCuenta.addEventListener('show.bs.modal', (event) => {
            // Botón que disparó el modal
            const button = event.relatedTarget;

            // Extraer datos de los atributos data-*
            const nroCuenta = button.dataset.nroCuenta;
            const tipo = button.dataset.tipo;
            const moneda = button.dataset.moneda;
            const saldo = button.dataset.saldo;
            const fechaApertura = button.dataset.fechaApertura;
            const estado = button.dataset.estado;
            const embargo = button.dataset.embargo;

            // Poblar el título y la tabla del modal
            modalVerCuenta.querySelector('#modalVerCuentaLabel').textContent = `Detalle de Cuenta - ${nroCuenta}`;
            modalVerCuenta.querySelector('#modalCuentaTipo').textContent = tipo;
            modalVerCuenta.querySelector('#modalCuentaMoneda').textContent = moneda;
            modalVerCuenta.querySelector('#modalCuentaSaldo').textContent = saldo;
            modalVerCuenta.querySelector('#modalCuentaFechaApertura').textContent = fechaApertura;
            modalVerCuenta.querySelector('#modalCuentaEstado').textContent = estado;
            modalVerCuenta.querySelector('#modalCuentaEmbargo').textContent = embargo;
        });
    }
});