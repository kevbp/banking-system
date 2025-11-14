/*
 * dashboard.js
 * Maneja la carga de datos dinámicos para el panel principal.
 */
document.addEventListener("DOMContentLoaded", () => {
    
    const statClientesEl = document.getElementById("stat-clientes-activos");
    const statCuentasEl = document.getElementById("stat-cuentas-hoy");
    const statOperacionesEl = document.getElementById("stat-operaciones-dia");
    const statElements = [statClientesEl, statCuentasEl, statOperacionesEl];

    async function cargarEstadisticas() {
        const API_ENDPOINT = `${window.APP_CONTEXT_PATH}/api/dashboard/summary`;

        try {
            const response = await fetch(API_ENDPOINT);
            
            if (!response.ok) {
                throw new Error(`Error HTTP: ${response.status}`);
            }
            
            const data = await response.json();

            // Éxito: Actualizar el DOM
            //statClientesEl.textContent = data.clientesActivos;
            statCuentasEl.textContent = data.cuentasHoy;
            statOperacionesEl.textContent = data.operacionesDia;

        } catch (error) {
            console.error('Error al cargar estadísticas:', error);
            // Error: Mostrar estado de error
            statElements.forEach(el => {
                if (el) {
                    //el.textContent = "N/A";
                    el.style.color = "#dc3545"; 
                }
            });
        } finally {
            // Siempre se ejecuta: Quitar el estado 'is-loading'
            statElements.forEach(el => {
                if (el) el.classList.remove('is-loading');
            });
        }
    }

    // Iniciar la carga
    cargarEstadisticas();
});