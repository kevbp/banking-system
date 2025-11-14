/*
 * =============================================
 * selec-rol.js
 * Lógica para manejar la selección de roles en
 * la pantalla 'selec-roles.jsp'.
 * =============================================
 */

document.addEventListener('DOMContentLoaded', () => {

    // 1. Obtener los elementos del DOM
    const rolForm = document.getElementById('rolForm');
    const rolSeleccionado = document.getElementById('rolSeleccionado'); // El input hidden
    const btnContinuar = document.getElementById('btnContinuar');
    const todosLosRoles = document.querySelectorAll('.rol'); // Los dos divs clickeables

    // 2. Agregar un listener a cada div de rol
    todosLosRoles.forEach(rolDiv => {

        rolDiv.addEventListener('click', () => {

            // a. Quitar la clase 'selected' de todos
            todosLosRoles.forEach(div => {
                div.classList.remove('selected');
            });

            // b. Añadir 'selected' solo al que se hizo clic
            rolDiv.classList.add('selected');

            // c. Obtener el valor (ej: "empleado" o "cliente") del atributo 'data-value'
            const valorRol = rolDiv.dataset.value;

            // d. Actualizar el valor del input hidden que se enviará
            rolSeleccionado.value = valorRol;

            // e. Habilitar el botón de continuar
            btnContinuar.disabled = false;
        });
    });

    // Opcional: Prevenir que el formulario se envíe si no se ha seleccionado nada
    rolForm.addEventListener('submit', (e) => {
        if (rolSeleccionado.value === "") {
            e.preventDefault(); // Detiene el envío
            alert('Por favor, seleccione un rol para continuar.');
        }
    });

});