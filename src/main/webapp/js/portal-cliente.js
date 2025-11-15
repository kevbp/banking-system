/*
 * =============================================
 * portal-cliente.js
 * Lógica de UI para el portal de cliente.
 * =============================================
 */
document.addEventListener('DOMContentLoaded', () => {

    // 1. Obtener el ID de la página activa desde el <body>
    //    Ej: <body data-active-page="cuentas">
    const activePageId = document.body.dataset.activePage;

    if (!activePageId) {
        return; // No hay página activa que marcar
    }

    // 2. Encontrar el enlace en el Navbar que coincida
    const activeLink = document.querySelector(
            `.navbar-nav .nav-link[data-page-id="${activePageId}"]`
            );

    // 3. Añadir la clase '.active'
    if (activeLink) {
        activeLink.classList.add('active');
    }
});