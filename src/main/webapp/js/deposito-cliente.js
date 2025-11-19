document.addEventListener('DOMContentLoaded', () => {
    const checkPropia = document.getElementById('checkPropia');
    const divSelect = document.getElementById('divSelectCuenta');
    const divInput = document.getElementById('divInputCuenta');
    const selectCuenta = document.getElementById('selectCuenta');
    const inputCuentaManual = document.getElementById('inputCuentaManual');

    const inputMonto = document.getElementById('monto');
    const spanSimbolo = document.getElementById('monedaSimbolo');
    const divOrigen = document.getElementById('divOrigen');
    const inputOrigen = document.getElementById('origenFondos');

    const tasaCambioInput = document.getElementById('tasaCambioVenta');
    const LIMITE_SOLES = 2000.00;
    const TASA_CAMBIO = parseFloat(tasaCambioInput && tasaCambioInput.value ? tasaCambioInput.value : 3.80);

    function toggleModoCuenta() {
        const esPropia = checkPropia.checked;
        if (esPropia) {
            divSelect.classList.remove('d-none');
            divInput.classList.add('d-none');
            selectCuenta.disabled = false;
            inputCuentaManual.disabled = true;
            actualizarSimbolo();
        } else {
            divSelect.classList.add('d-none');
            divInput.classList.remove('d-none');
            selectCuenta.disabled = true;
            inputCuentaManual.disabled = false;
            spanSimbolo.textContent = "Monto"; // Neutro si es manual
            verificarLimite();
        }
    }

    function actualizarSimbolo() {
        if (!checkPropia.checked)
            return;
        const selectedOption = selectCuenta.options[selectCuenta.selectedIndex];
        if (selectedOption && selectedOption.dataset.simbolo) {
            spanSimbolo.textContent = selectedOption.dataset.simbolo;
        } else {
            spanSimbolo.textContent = "S/";
        }
        verificarLimite();
    }

    function verificarLimite() {
        const monto = parseFloat(inputMonto.value) || 0;
        let superaLimite = false;

        if (monto > 0) {
            if (checkPropia.checked) {
                const selectedOption = selectCuenta.options[selectCuenta.selectedIndex];
                if (selectedOption) {
                    const moneda = selectedOption.dataset.moneda;
                    if (moneda === 'USD') {
                        if ((monto * TASA_CAMBIO) > LIMITE_SOLES)
                            superaLimite = true;
                    } else {
                        if (monto > LIMITE_SOLES)
                            superaLimite = true;
                    }
                }
            } else {
                // Si es manual, asumimos siempre límite 2000 nominal por seguridad
                if (monto > LIMITE_SOLES)
                    superaLimite = true;
            }
        }

        if (superaLimite) {
            divOrigen.classList.remove('d-none');
            divOrigen.classList.add('animate-fade');
            inputOrigen.setAttribute('required', 'true');
        } else {
            divOrigen.classList.add('d-none');
            divOrigen.classList.remove('animate-fade');
            inputOrigen.removeAttribute('required');
        }
    }

    if (checkPropia) {
        checkPropia.addEventListener('change', toggleModoCuenta);
        toggleModoCuenta(); // Estado inicial
    }
    if (selectCuenta)
        selectCuenta.addEventListener('change', actualizarSimbolo);
    if (inputMonto)
        inputMonto.addEventListener('input', verificarLimite);
});