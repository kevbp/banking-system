document.addEventListener('DOMContentLoaded', () => {

    // 1. ASIGNAR FECHA DE HOY
    const hoy = new Date();
    const fechaStr = hoy.toLocaleDateString('es-PE', {day: '2-digit', month: '2-digit', year: 'numeric'});
    const campoFecha = document.getElementById('fecApertura');
    if (campoFecha)
        campoFecha.value = fechaStr;

    // 2. BÚSQUEDA DE CLIENTE
    const btnBuscar = document.getElementById('btnBuscarCliente');
    const inpDoc = document.getElementById('numDoc');
    const inpNombre = document.getElementById('nomCliente');
    const inpCodOculto = document.getElementById('codClienteHide');

    if (btnBuscar) {
        btnBuscar.addEventListener('click', () => {
            const doc = inpDoc.value.trim();
            if (!doc) {
                alert('Por favor, ingrese un número de documento.');
                inpDoc.focus();
                return;
            }

            // Efecto de "Cargando..."
            const textoOriginal = btnBuscar.innerHTML;
            btnBuscar.innerHTML = '<span class="spinner-border spinner-border-sm"></span>';
            btnBuscar.disabled = true;

            // Usamos contextPath definido en el JSP
            const ruta = `${contextPath}/ControlCuenta?accion=buscarCliente&doc=${doc}`;

            fetch(ruta)
                    .then(res => {
                        if (!res.ok)
                            throw new Error("Error en la red");
                        return res.json();
                    })
                    .then(data => {
                        if (data.encontrado) {
                            inpNombre.value = data.nombre;
                            inpCodOculto.value = data.id;

                            // Feedback visual
                            inpDoc.classList.remove('is-invalid');
                            inpDoc.classList.add('is-valid');
                            inpNombre.classList.add('is-valid');
                        } else {
                            inpNombre.value = '';
                            inpCodOculto.value = '';

                            alert('Cliente no encontrado. Por favor regístrelo primero en el módulo de Clientes.');
                            inpDoc.classList.remove('is-valid');
                            inpDoc.classList.add('is-invalid');
                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        alert('Ocurrió un error al buscar el cliente.');
                    })
                    .finally(() => {
                        btnBuscar.innerHTML = textoOriginal;
                        btnBuscar.disabled = false;
                    });
        });
    }

    // 3. LÓGICA DE PRODUCTO Y VALIDACIONES
    const selTipo = document.getElementById('tipoCuenta');

    // Referencias para Plazo Fijo
    const rowPlazo = document.getElementById('rowPlazoFijo');
    const selPlazo = document.getElementById('plazo');

    // Referencias para Cuenta Corriente
    const rowCorriente = document.getElementById('rowCtaCorriente');
    const inpSobregiro = document.getElementById('txtSobregiro');
    const simboloSobregiro = document.getElementById('simboloSobregiro');

    // Referencias Generales
    const inpSaldo = document.getElementById('saldoApertura');
    const txtMsgMinimo = document.getElementById('helpSaldo'); // Corregido para coincidir con el JSP

    // Campos Readonly
    const txtMoneda = document.getElementById('txtMoneda');
    const hiddenMoneda = document.getElementById('hiddenMoneda');
    const txtInteres = document.getElementById('txtInteres');
    const simbolo = document.getElementById('simboloMoneda');

    if (selTipo) {
        selTipo.addEventListener('change', function () {
            const opt = this.options[this.selectedIndex];

            // Obtener datos del data-attribute
            const moneda = opt.dataset.moneda || '';
            const tasa = opt.dataset.tasa || '';
            const desc = opt.dataset.desc || '';
            const sobregiroBD = opt.dataset.sobregiro || '0.00'; // Dato nuevo desde la BD

            // Llenar campos readonly
            txtMoneda.value = moneda === 'PEN' ? 'Soles (PEN)' : (moneda === 'USD' ? 'Dólares (USD)' : '');
            hiddenMoneda.value = moneda;
            txtInteres.value = tasa;

            // Actualizar símbolos de moneda
            const sign = moneda === 'USD' ? '$' : 'S/';
            simbolo.textContent = sign;
            if (simboloSobregiro)
                simboloSobregiro.textContent = sign;

            // Determinar tipo de cuenta
            const esPlazo = desc.toLowerCase().includes('plazo');
            const esCorriente = desc.toLowerCase().includes('corriente');

            // --- CASO 1: CUENTA CORRIENTE ---
            if (esCorriente) {
                // Mostrar sección Corriente
                if (rowCorriente)
                    rowCorriente.classList.remove('d-none');
                // Ocultar sección Plazo
                if (rowPlazo)
                    rowPlazo.classList.add('d-none');

                // Asignar valor de sobregiro traído de la BD
                if (inpSobregiro)
                    inpSobregiro.value = parseFloat(sobregiroBD).toFixed(2);

                // Limpiar campos de Plazo
                if (selPlazo) {
                    selPlazo.removeAttribute('required');
                    selPlazo.value = "";
                }

                // Resetear validación de saldo (puede ser 0)
                inpSaldo.min = 0;
                inpSaldo.value = 0.00;
                if (txtMsgMinimo)
                    txtMsgMinimo.innerHTML = "Monto mínimo: 0.00";

                // --- CASO 2: PLAZO FIJO ---
            } else if (esPlazo) {
                // Mostrar sección Plazo
                if (rowPlazo)
                    rowPlazo.classList.remove('d-none');
                // Ocultar sección Corriente
                if (rowCorriente)
                    rowCorriente.classList.add('d-none');

                // Hacer requerido el plazo
                if (selPlazo)
                    selPlazo.setAttribute('required', 'true');

                // Validaciones de Monto Mínimo
                if (moneda === 'PEN') {
                    inpSaldo.min = 500;
                    inpSaldo.value = 500.00;
                    if (txtMsgMinimo)
                        txtMsgMinimo.innerHTML = "Monto mínimo requerido: <strong>S/ 500.00</strong>";
                } else {
                    inpSaldo.min = 200;
                    inpSaldo.value = 200.00;
                    if (txtMsgMinimo)
                        txtMsgMinimo.innerHTML = "Monto mínimo requerido: <strong>$ 200.00</strong>";
                }

                // --- CASO 3: AHORROS (ESTÁNDAR) ---
            } else {
                // Ocultar ambas secciones específicas
                if (rowPlazo)
                    rowPlazo.classList.add('d-none');
                if (rowCorriente)
                    rowCorriente.classList.add('d-none');

                // Limpiar validaciones extra
                if (selPlazo) {
                    selPlazo.removeAttribute('required');
                    selPlazo.value = "";
                }

                // Resetear validación de saldo
                inpSaldo.min = 0;
                inpSaldo.value = 0.00;
                if (txtMsgMinimo)
                    txtMsgMinimo.innerHTML = "Monto mínimo: 0.00";
            }
        });
    }
});