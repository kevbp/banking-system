document.addEventListener('DOMContentLoaded', () => {
    const inputMonto = document.getElementById('montoRetiro');
    const inputSaldo = document.getElementById('saldoDisponible');
    const inputSobregiro = document.getElementById('limSobregiro'); // Recuperar sobregiro
    const feedback = document.getElementById('feedbackSaldo');
    const btnProcesar = document.getElementById('btnProcesar');

    if (inputMonto && inputSaldo) {
        inputMonto.addEventListener('input', () => {
            const monto = parseFloat(inputMonto.value) || 0;
            const saldo = parseFloat(inputSaldo.value) || 0;
            const sobregiro = inputSobregiro ? (parseFloat(inputSobregiro.value) || 0) : 0;

            // Capacidad total = Saldo real + Línea de sobregiro
            const capacidadTotal = saldo + sobregiro;

            if (monto > capacidadTotal) {
                inputMonto.classList.add('is-invalid');
                feedback.classList.remove('d-none');
                if (sobregiro > 0) {
                    feedback.innerText = "Excede saldo + sobregiro disponible.";
                } else {
                    feedback.innerText = "Fondos insuficientes.";
                }
                btnProcesar.disabled = true;
            } else {
                inputMonto.classList.remove('is-invalid');
                feedback.classList.add('d-none');
                btnProcesar.disabled = false;
            }
        });
    }
});

// Función global para el onsubmit
function confirmarRetiro() {
    const monto = document.getElementById('montoRetiro').value;
    return confirm(`¿Está seguro de procesar el retiro por ${monto}? \nEsta acción afectará el saldo inmediatamente.`);
}