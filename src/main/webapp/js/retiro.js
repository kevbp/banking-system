/*
 * retiro.js
 * Lógica de validación para la interfaz de Retiros
 */

document.addEventListener('DOMContentLoaded', () => {
    const inputMonto = document.getElementById('montoRetiro');
    const inputSaldo = document.getElementById('saldoDisponible');
    const feedback = document.getElementById('feedbackSaldo');
    const btnProcesar = document.getElementById('btnProcesar');

    if (inputMonto && inputSaldo) {

        inputMonto.addEventListener('input', () => {
            const monto = parseFloat(inputMonto.value) || 0;
            const saldo = parseFloat(inputSaldo.value) || 0;

            if (monto > saldo) {
                // Excede saldo: Mostrar error y bloquear botón
                inputMonto.classList.add('is-invalid');
                feedback.classList.remove('d-none');
                btnProcesar.disabled = true;
            } else {
                // Saldo correcto
                inputMonto.classList.remove('is-invalid');
                feedback.classList.add('d-none');
                btnProcesar.disabled = false;
            }
        });
    }
});

// Función global para el onsubmit del formulario
function confirmarRetiro() {
    const monto = document.getElementById('montoRetiro').value;
    return confirm(`¿Está seguro de procesar el retiro por ${monto}? \nEsta acción descontará el saldo inmediatamente.`);
}