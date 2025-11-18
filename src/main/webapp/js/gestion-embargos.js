/**
 * gestion-embargos.js
 * Lógica para la vista de Gestión de Embargos
 */

document.addEventListener('DOMContentLoaded', () => {

    // --- LÓGICA PARA EL MODAL DE EDITAR / LEVANTAR ---
    const modalEditar = document.getElementById('modalEditarEmbargo');

    if (modalEditar) {
        modalEditar.addEventListener('show.bs.modal', (evt) => {
            // Botón que disparó el evento
            const btn = evt.relatedTarget;

            // Extraer datos de los atributos data-*
            const cod = btn.getAttribute('data-cod');
            const monto = btn.getAttribute('data-monto');
            const exp = btn.getAttribute('data-exp');
            const cta = btn.getAttribute('data-cta');

            // Referencias a los campos del formulario
            const inputCod = document.getElementById('editCod');
            const inputMonto = document.getElementById('editMonto');
            const inputExp = document.getElementById('editExp');
            const inputCta = document.getElementById('editCta');
            const selectEstado = document.getElementById('editEstado');

            // Asignar valores (validando que el campo exista)
            if (inputCod)
                inputCod.value = cod || '';
            if (inputMonto)
                inputMonto.value = monto || '';
            if (inputExp)
                inputExp.value = exp || '';
            if (inputCta)
                inputCta.value = cta || '';

            // Resetear el select siempre a 'ACTIVO' (opción por defecto) al abrir el modal
            if (selectEstado)
                selectEstado.value = 'ACTIVO';
        });
    }
});