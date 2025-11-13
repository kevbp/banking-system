/*
 * ===================================================
 * gestion-embargos.js
 * Lógica de UI para la página de Gestión de Embargos
 *
 * Funcionalidad:
 * 1. Poblado dinámico del Modal "Editar Embargo".
 * ===================================================
 */

document.addEventListener('DOMContentLoaded', () => {

    // 1. Lógica del Modal Editar Embargo
    const modalEditar = document.getElementById('modalEditarEmbargo');

    if (modalEditar) {
        modalEditar.addEventListener('show.bs.modal', (event) => {
            // Botón que disparó el modal
            const button = event.relatedTarget;

            // Extraer datos de los atributos data-*
            const id = button.dataset.id;
            const monto = button.dataset.monto;
            const estado = button.dataset.estado;
            const descripcion = button.dataset.descripcion;
            const expediente = button.dataset.expediente;

            // Poblar el formulario del modal
            modalEditar.querySelector('#modalEditarEmbargoLabel').textContent = `Editar Embargo - ID ${id}`;
            modalEditar.querySelector('#editEmbargoId').value = id;
            modalEditar.querySelector('#editEmbargoMonto').value = monto;
            modalEditar.querySelector('#editEmbargoEstado').value = estado;
            modalEditar.querySelector('#editEmbargoDescripcion').value = descripcion;
            modalEditar.querySelector('#editEmbargoExpediente').value = expediente;
        });
    }
});