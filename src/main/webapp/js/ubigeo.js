document.addEventListener("DOMContentLoaded", () => {
    // 1. Obtener Referencias del DOM
    const reg = document.getElementById("region");
    const prov = document.getElementById("provincia");
    const dist = document.getElementById("distrito");
    const modalEditarCliente = document.getElementById('modalEditarCliente');
    
    // --- Lógica Modularizada para Cargar Distritos ---
    const cargarDistritos = (provinciaValor, distritoValorASeleccionar = null) => {
        // ... (Contenido idéntico a la solución anterior)
        dist.innerHTML = '<option value="">Seleccione...</option>';
        if (provinciaValor === "") { return; }

        fetch(`${contextPath}/ControlUtilitarios?accion=listarDistritos&valor=${provinciaValor}`)
            .then(res => res.json())
            .then(data => {
                let distritoOptions = '';
                data.forEach(d => {
                    const isSelected = d === distritoValorASeleccionar ? 'selected' : '';
                    distritoOptions += `<option value="${d}" ${isSelected}>${d}</option>`;
                });
                dist.innerHTML += distritoOptions;
            })
            .catch(error => console.error('Error al cargar distritos:', error));
    };

    // --- Lógica Modularizada para Cargar Provincias ---
    const cargarProvincias = (regionValor, provinciaValorASeleccionar = null, distritoValorASeleccionar = null) => {
        // ... (Contenido idéntico a la solución anterior)
        prov.innerHTML = '<option value="">Seleccione...</option>';
        dist.innerHTML = '<option value="">Seleccione...</option>';
        if (regionValor === "") { return; }

        fetch(`${contextPath}/ControlUtilitarios?accion=listarProvincias&valor=${regionValor}`)
            .then(res => res.json())
            .then(data => {
                let provinciaOptions = '';
                data.forEach(p => {
                    const isSelected = p === provinciaValorASeleccionar ? 'selected' : '';
                    provinciaOptions += `<option value="${p}" ${isSelected}>${p}</option>`;
                });
                prov.innerHTML += provinciaOptions;
                
                if (provinciaValorASeleccionar) {
                    cargarDistritos(provinciaValorASeleccionar, distritoValorASeleccionar);
                }
            })
            .catch(error => console.error('Error al cargar provincias:', error));
    };

    // --- 3. MANEJO DE EVENTOS DE USUARIO (Común a todas las páginas) ---
    
    // CORREGIDO: Usar 'change' para el selector de Región
    reg.addEventListener("change", () => {
        cargarProvincias(reg.value, null, null);
    });

    // Evento para el selector de Provincia
    prov.addEventListener("change", () => {
        cargarDistritos(prov.value, null);
    });
    
    // --- 4. CARGA INICIAL (Solo se ejecuta en la página de edición) ---
    
    // Verificamos si la variable ES_MODO_EDICION_CLIENTE existe y es true (inyectada por el JSP)
    if (typeof ES_MODO_EDICION_CLIENTE !== 'undefined' && ES_MODO_EDICION_CLIENTE === true) {
        
        // Escucha el evento de Bootstrap cuando el modal se muestra
        modalEditarCliente.addEventListener('shown.bs.modal', () => {
            const regionInicial = reg.value; // Valor seleccionado por JSTL

            // Solo proceder si la región tiene un valor y las variables de cliente existen
            if (regionInicial && typeof PROVINCIA_CLIENTE !== 'undefined' && PROVINCIA_CLIENTE !== "") {
                // Usamos las variables inyectadas
                cargarProvincias(regionInicial, PROVINCIA_CLIENTE, DISTRITO_CLIENTE);
            }
        });
    }
});