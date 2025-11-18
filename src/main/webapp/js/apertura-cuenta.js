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

            // CORRECCIÓN AQUÍ: Usamos contextPath para armar la ruta correcta
            // Asegúrate de que la variable contextPath esté definida en el JSP
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
                        // Restaurar botón
                        btnBuscar.innerHTML = textoOriginal;
                        btnBuscar.disabled = false;
                    });
        });
    }

    // 3. LÓGICA DE PRODUCTO Y VALIDACIONES
    const selTipo = document.getElementById('tipoCuenta');
    const rowPlazo = document.getElementById('rowPlazoFijo');
    const selPlazo = document.getElementById('plazo');
    const inpSaldo = document.getElementById('saldoApertura');
    const txtMsgMinimo = document.getElementById('msgMinimoPlazo');

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

            // Llenar campos readonly
            txtMoneda.value = moneda === 'PEN' ? 'Soles (PEN)' : (moneda === 'USD' ? 'Dólares (USD)' : '');
            hiddenMoneda.value = moneda;
            txtInteres.value = tasa;
            simbolo.textContent = moneda === 'USD' ? '$' : 'S/';

            // REGLA: ¿Es Plazo Fijo?
            const esPlazo = desc.toLowerCase().includes('plazo');

            if (esPlazo) {
                rowPlazo.classList.remove('d-none');
                selPlazo.setAttribute('required', 'true');

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
            } else {
                rowPlazo.classList.add('d-none');
                selPlazo.removeAttribute('required');
                selPlazo.value = "";

                inpSaldo.min = 0;
                inpSaldo.value = 0.00;
                if (txtMsgMinimo)
                    txtMsgMinimo.innerHTML = "Monto mínimo: 0.00";
            }
        });
    }
});