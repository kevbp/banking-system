/*
 * =============================================
 * apertura-cuenta.js
 * Lógica de UI para la página de Apertura de Cuentas (V-06).
 * =============================================
 */
document.addEventListener('DOMContentLoaded', () => {

    const tipoCuentaSelect = document.getElementById('tipoCuenta');
    const plazoFijoFields = document.getElementById('plazoFijoFields');

    // Inputs que deben ser obligatorios solo para Plazo Fijo
    const inpMontoApertura = document.getElementById('inpMontoApertura');
    const inpPlazoMeses = document.getElementById('inpPlazoMeses');

    // CAMBIO: Se eliminó 'inpInteresMensual' de las validaciones

    if (!tipoCuentaSelect || !plazoFijoFields || !inpMontoApertura || !inpPlazoMeses) {
        console.error('Error: No se encontraron todos los elementos necesarios para la apertura de cuenta.');
        return;
    }

    tipoCuentaSelect.addEventListener('change', () => {

        if (tipoCuentaSelect.value === 'PLAZOS') {
            // Mostrar campos
            plazoFijoFields.classList.remove('d-none');
            // Hacerlos obligatorios
            inpMontoApertura.required = true;
            inpPlazoMeses.required = true;
            // CAMBIO: Se eliminó la validación 'required' para el interés
        } else {
            // Ocultar campos
            plazoFijoFields.classList.add('d-none');
            // Quitar 'required'
            inpMontoApertura.required = false;
            inpPlazoMeses.required = false;
        }
    });
});