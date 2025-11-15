/*
 * =============================================
 * portal-cliente.js
 * Lógica de UI para el portal de cliente.
 * =============================================
 */
document.addEventListener('DOMContentLoaded', () => {

    const activePageId = document.body.dataset.activePage;

    if (!activePageId) {
        return;
    }

    // Busca el link en el navbar con el data-page-id
    const activeLink = document.querySelector(
            `.navbar-nav .nav-link[data-page-id="${activePageId}"]`
            );

    // Añade la clase .active
    if (activeLink) {
        activeLink.classList.add('active');
    }
});