/*
 * =============================================
 * deposito.js
 * Lógica de UI para la página de Depósitos (V-07).
 * =============================================
 */
document.addEventListener('DOMContentLoaded', () => {

    const montoInput = document.getElementById('monto');
    const origenFondosContainer = document.getElementById('origenFondosContainer');
    const origenFondosInput = document.getElementById('origenFondos');
    const cuentaDestinoSelect = document.getElementById('cuentaDestino');

    // Límite según requerimiento 
    const LIMITE_ORIGEN_FONDOS = 2000;

    if (montoInput) {
        montoInput.addEventListener('input', checkMonto);
    }
    if (cuentaDestinoSelect) {
        cuentaDestinoSelect.addEventListener('change', checkMonto);
    }

    function checkMonto() {
        if (!montoInput || !origenFondosContainer || !origenFondosInput || !cuentaDestinoSelect)
            return;

        const monto = parseFloat(montoInput.value) || 0;
        const selectedOption = cuentaDestinoSelect.options[cuentaDestinoSelect.selectedIndex];
        const moneda = selectedOption.dataset.moneda || 'PEN';

        // Simulación simple del "equivalente en dólares". 
        // En un caso real, necesitaríamos el T.C. del banner.
        // Asumimos T.C. Venta ~3.4
        const limiteEquivalente = (moneda === 'USD') ? (LIMITE_ORIGEN_FONDOS / 3.4) : LIMITE_ORIGEN_FONDOS;

        if (monto > limiteEquivalente) {
            origenFondosContainer.classList.remove('d-none');
            origenFondosInput.required = true;
        } else {
            origenFondosContainer.classList.add('d-none');
            origenFondosInput.required = false;
        }
    }
});