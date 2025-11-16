/*
 * =============================================
 * transferencia.js
 * Lógica de UI para la página de Transferencias (V-09).
 * =============================================
 */

// Variables globales para almacenar el estado
let saldoDisponible = 0.0;
let monedaOrigen = '';
let monedaDestino = ''; // Simulación
let montoEsValido = false;
let destinoEsValido = false;
let origenEsValido = false;

document.addEventListener('DOMContentLoaded', () => {

    // --- Elementos del DOM ---
    const cuentaOrigenSelect = document.getElementById('cuentaOrigen');
    const origenVerificado = document.getElementById('origenVerificado');
    const nombreOrigen = document.getElementById('nombreOrigen');
    const saldoDisplayBox = document.getElementById('saldoDisponible');
    const saldoValor = document.getElementById('saldoValor');

    const montoInput = document.getElementById('monto');
    const saldoError = document.getElementById('saldoError');
    const btnContinuar = document.getElementById('btnContinuar');

    const cuentaDestinoInput = document.getElementById('cuentaDestino');
    const avisoTipoCambio = document.getElementById('avisoTipoCambio');

    // (Simulación de la moneda de la cuenta destino)
    const monedaDestinoSimulada = document.getElementById('monedaDestinoSimulada')?.value || 'USD';


    // --- 1. Lógica de Cuenta de Origen (Mostrar Titular y Saldo) ---
    if (cuentaOrigenSelect) {
        cuentaOrigenSelect.addEventListener('change', () => {
            const selectedOption = cuentaOrigenSelect.options[cuentaOrigenSelect.selectedIndex];

            saldoDisponible = parseFloat(selectedOption.dataset.saldo || 0);
            monedaOrigen = selectedOption.dataset.moneda || '';
            const titularOrigen = selectedOption.dataset.titular || '';

            if (titularOrigen) {
                nombreOrigen.value = titularOrigen;
                origenVerificado.classList.remove('d-none');
                origenEsValido = true;
            } else {
                origenVerificado.classList.add('d-none');
                origenEsValido = false;
            }

            if (saldoDisponible > 0) {
                const formatter = new Intl.NumberFormat('es-PE', {
                    style: 'currency',
                    currency: monedaOrigen
                });
                saldoValor.textContent = formatter.format(saldoDisponible);
                saldoDisplayBox.classList.remove('d-none');
            } else {
                saldoDisplayBox.classList.add('d-none');
            }

            validarFormulario();
        });
    }

    // --- 2. Lógica de Validación de Cuenta Destino (Tiempo Real) ---
    if (cuentaDestinoInput) {
        cuentaDestinoInput.addEventListener('input', () => {
            let cuentaDestino = cuentaDestinoInput.value.trim();
            destinoEsValido = cuentaDestino.length > 5;

            // SIMULACIÓN de T.C.
            // Si la cuenta destino es "002-002" (la de dólares), activa la alerta.
            if (cuentaDestino === "002-002") {
                monedaDestino = "USD";
            } else {
                monedaDestino = "PEN"; // Asumir PEN para cualquier otra
            }

            validarFormulario();
        });
    }

    // --- 3. Lógica de Validación de Monto (Tiempo Real) ---
    if (montoInput) {
        montoInput.addEventListener('input', () => {
            const monto = parseFloat(montoInput.value) || 0;

            // Regla: Monto debe ser <= saldo
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
     * Función central que valida todo el formulario y activa/desactiva el botón.
     */
    function validarFormulario() {
        if (!btnContinuar || !avisoTipoCambio)
            return;

        // Validar Alerta de Tipo de Cambio
        if (monedaOrigen && monedaDestino && monedaOrigen !== monedaDestino) {
            avisoTipoCambio.classList.remove('d-none');
        } else {
            avisoTipoCambio.classList.add('d-none');
        }

        // Validar Botón Principal
        if (origenEsValido && destinoEsValido && montoEsValido) {
            btnContinuar.disabled = false;
        } else {
            btnContinuar.disabled = true;
        }
    }
});