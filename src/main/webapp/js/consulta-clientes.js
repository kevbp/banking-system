/*
 * ===================================================
 * consulta-clientes.js
 * Lógica de UI para la página de Consulta de Clientes
 *
 * Funcionalidad:
 * 1. Poblado de Modal de Desactivación de Cliente.
 * ===================================================
 */

document.addEventListener('DOMContentLoaded', () => {

    // 1. Lógica del Modal Desactivar Cliente (convertida de jQuery)
    const modalDesactivar = document.getElementById('modalDesactivarCliente');
    
    if (modalDesactivar) {
        modalDesactivar.addEventListener('show.bs.modal', (event) => {
            // Botón que disparó el modal
            const button = event.relatedTarget; 
            
            // Extraer datos de los atributos data-*
            const id = button.dataset.id;
            const nombre = button.dataset.nombre;

            // Poblar el formulario del modal
            modalDesactivar.querySelector('#idClienteDesactivar').value = id;
            modalDesactivar.querySelector('#nombreClienteDesactivar').textContent = nombre;
        });
    }

    // (La lógica de ubigeo.js se ejecutará por separado)
    // (La lógica de 'abrirModalEditar' se maneja en el JSP con <c:if>)
});