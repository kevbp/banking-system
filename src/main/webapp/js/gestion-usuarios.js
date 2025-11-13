/*
 * ===================================================
 * gestion-usuarios.js
 * Lógica de UI para la página de Gestión de Usuarios
 *
 * Funcionalidad:
 * 1. Auto-cierre de Alertas (si existen).
 * 2. Poblado de Modal de Edición de Usuario.
 * ===================================================
 */

document.addEventListener('DOMContentLoaded', () => {

    // 1. Lógica del Alert (convertida de jQuery)
    // Asume que tu alert tiene id="myAlert"
    const myAlert = document.getElementById('myAlert');
    if (myAlert) {
        const tiempoVisible = 5000; // 5 segundos
        setTimeout(() => {
            // Se necesita el objeto Bootstrap Alert para cerrarlo
            const bsAlert = new bootstrap.Alert(myAlert);
            bsAlert.close();
        }, tiempoVisible);
    }

    // 2. Lógica del Modal Editar Usuario (convertida de jQuery)
    const modalEditar = document.getElementById('modalEditarUsuario1');
    if (modalEditar) {
        
        modalEditar.addEventListener('show.bs.modal', (event) => {
            // Botón que disparó el modal
            const button = event.relatedTarget; 

            // Extraer datos de los atributos data-*
            const id = button.dataset.id;
            const nombre = button.dataset.nombre;
            const apellido = button.dataset.apellido;
            const cargo = button.dataset.cargo;
            const rol = button.dataset.rol;
            const estado = button.dataset.estado;

            // Poblar el formulario del modal
            modalEditar.querySelector('#idUsuario').value = id;
            modalEditar.querySelector('#nombreEditar').value = nombre;
            modalEditar.querySelector('#apellidoEditar').value = apellido; // Campo que faltaba
            modalEditar.querySelector('#cargoEditar').value = cargo;
            modalEditar.querySelector('#rolEditar').value = rol;
        modalEditar.querySelector('#estadoEditar').value = estado;
            
            // Actualizar el título del modal
            modalEditar.querySelector('#modalEditarUsuario1Label').textContent = `Editar Usuario: ${nombre} ${apellido}`;
        });
    }
});