/*
 * =============================================
 * retiro.js
 * Lógica de UI para la página de Retiros (V-08).
 * =============================================
 */

// Variables globales para almacenar el estado
let saldoDisponible = 0.0;
let monedaOrigen = '';
let montoEsValido = false;
let origenEsValido = false;

document.addEventListener('DOMContentLoaded', () => {

    // --- Elementos del DOM ---
    const cuentaOrigenSelect = document.getElementById('cuentaOrigen');
    const saldoDisplayBox = document.getElementById('saldoDisponible');
    const saldoValor = document.getElementById('saldoValor');

    const montoInput = document.getElementById('monto');
    const saldoError = document.getElementById('saldoError');
    const btnContinuar = document.getElementById('btnContinuar');

    // --- 1. Lógica de Cuenta de Origen (Mostrar Saldo) ---
    if (cuentaOrigenSelect) {
        cuentaOrigenSelect.addEventListener('change', () => {
            const selectedOption = cuentaOrigenSelect.options[cuentaOrigenSelect.selectedIndex];

            saldoDisponible = parseFloat(selectedOption.dataset.saldo || 0);
            monedaOrigen = selectedOption.dataset.moneda || '';

            if (saldoDisponible > 0) {
                const formatter = new Intl.NumberFormat('es-PE', {
                    style: 'currency',
                    currency: monedaOrigen
                });
                saldoValor.textContent = formatter.format(saldoDisponible);
                saldoDisplayBox.classList.remove('d-none');
                origenEsValido = true;
            } else {
                saldoDisplayBox.classList.add('d-none');
                origenEsValido = false;
            }

            validarFormulario();
        });
    }

    // --- 2. Lógica de Validación de Monto (Tiempo Real) ---
    if (montoInput) {
        montoInput.addEventListener('input', () => {
            const monto = parseFloat(montoInput.value) || 0;

            // Requerimiento: Monto no puede ser mayor al saldo 
            if (monto > 0 && monto > saldoDisponible && saldoDisponible > 0) {
                saldoError.classList.remove('d-none');
                const formatter = new Intl.NumberFormat('es-PE', {style: 'currency', currency: monedaOrigen});
                saldoError.innerHTML = `<i class="bi bi-exclamation-circle-fill"></i> El monto es mayor a su saldo disponible (${formatter.format(saldoDisponible)}).`;
                montoEsValido = false;
            } else {
                saldoError.classList.add('d-none');
                montoEsValido = monto > 0;
            }

            validarFormulario();
        });
    }

    /**
     * Función central que valida el formulario.
     */
    function validarFormulario() {
        if (!btnContinuar)
            return;

        if (origenEsValido && montoEsValido) {
            btnContinuar.disabled = false;
        } else {
            btnContinuar.disabled = true;
        }
    }
});