/*
 * deposito.js
 * Lógica de UI para la página de Depósitos
 */
document.addEventListener('DOMContentLoaded', () => {

    const montoInput = document.getElementById('monto');
    const origenContainer = document.getElementById('origenFondosContainer');
    const origenInput = document.getElementById('origenFondos');

    // Límite según requerimiento (S/ 2000)
    const LIMITE_SOL = 2000;
    // Tipo de cambio referencial para el cálculo (puedes ajustarlo)
    const TIPO_CAMBIO = 3.75;

    if (montoInput) {
        montoInput.addEventListener('input', checkMonto);
    }

    function checkMonto() {
        if (!montoInput || !origenContainer || !origenInput)
            return;

        const monto = parseFloat(montoInput.value) || 0;

        // Obtenemos la moneda desde el atributo data-moneda del input (puesto por JSP)
        const moneda = montoInput.dataset.moneda || 'PEN';

        // Calculamos el límite equivalente
        let limite = LIMITE_SOL;

        if (moneda === 'USD') {
            // Si es dólares, el límite es 2000 / TC (Ej: 2000 / 3.75 = ~533 USD)
            // O si la regla es "$2000", cambia esta lógica. 
            // Asumiré que la regla dice "S/ 2000 o su equivalente".
            limite = LIMITE_SOL / TIPO_CAMBIO;
        }

        if (monto > limite) {
            origenContainer.classList.remove('d-none');
            origenInput.required = true;
        } else {
            origenContainer.classList.add('d-none');
            origenInput.required = false;
            origenInput.value = ''; // Limpiar si baja el monto
        }
    }
});