/*
 * =============================================
 * detalle-cuenta.js
 * Lógica de UI para la página de Detalle de Cuenta.
 * =============================================
 */
document.addEventListener('DOMContentLoaded', () => {

    // 1. Inicializar todos los tooltips de Bootstrap
    const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    const tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {

        const tooltip = new bootstrap.Tooltip(tooltipTriggerEl);

        tooltipTriggerEl.addEventListener('shown.bs.tooltip', () => {
            setTimeout(() => {
                tooltip.hide();
            }, 1500);
        });

        return tooltip;
    });

    // 2. Lógica para Copiar al Portapapeles (Formato Personalizado)
    const btnCopiarCuentas = document.getElementById('btnCopiarCuentas');

    if (btnCopiarCuentas) {
        btnCopiarCuentas.addEventListener('click', () => {

            const nroCuentaEl = document.getElementById('textNroCuenta');
            const cciEl = document.getElementById('textCCI');

            if (nroCuentaEl && cciEl) {

                const nroCuenta = nroCuentaEl.innerText;
                const cciNumber = cciEl.innerText.replace('CCI: ', '');

                const textToCopy = `Mi n° de cuenta Quantum Bank es : ${nroCuenta} y mi numero CCI es: ${cciNumber}`;

                navigator.clipboard.writeText(textToCopy).then(() => {
                    const tooltip = bootstrap.Tooltip.getInstance(btnCopiarCuentas);
                    tooltip.show();
                }).catch(err => {
                    console.error('Error al copiar: ', err);
                });
            }
        });
    }

});