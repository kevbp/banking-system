document.addEventListener('DOMContentLoaded', function() {
    // CAMBIO 1: Obtener referencias al formulario y botón
    const rolForm = document.getElementById('rolForm');
    const rolInput = document.getElementById('rolSeleccionado');
    const btnContinuar = document.getElementById('btnContinuar');
    const roles = document.querySelectorAll(".rol");

    // Función modificada para habilitar el botón
    window.seleccionarRol = function(rol) {
        rolInput.value = rol;
        
        roles.forEach(r => r.classList.remove("seleccionado"));
        const rolSeleccionadoDiv = document.getElementById(rol);
        rolSeleccionadoDiv.classList.add("seleccionado");

        // CAMBIO 2: Habilitar el botón Continuar
        btnContinuar.disabled = false;
    };
});