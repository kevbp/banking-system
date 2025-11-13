/*
 * ===============================================
 * sidebar.js (Versión Robusta con data-attributes)
 * ===============================================
 *
 * Esta lógica activa el enlace del sidebar basándose
 * en un atributo 'data-active-page' en la etiqueta <body>
 * de la página de contenido.
 */
document.addEventListener('DOMContentLoaded', () => {

    // 1. Obtener el ID de la página actual desde la etiqueta <body>
    //    Ej: <body data-active-page="admin-usuarios">
    const activePageId = document.body.dataset.activePage;

    if (!activePageId) {
        // Si la página no especificó un ID (ej. <body data-active-page="...">),
        // no se puede activar ningún enlace.
        console.warn('Sidebar: No se encontró "data-active-page" en el <body>. No se activará ningún enlace.');
        return;
    }

    // 2. Encontrar el enlace en el sidebar que corresponde a ese ID
    //    Busca tanto enlaces raíz (<a class="nav-link">) como sub-enlaces (<a class="nav-sub-link">)
    const activeLink = document.querySelector(
        `.nav-link[data-page-id="${activePageId}"], .nav-sub-link[data-page-id="${activePageId}"]`
    );

    if (!activeLink) {
        // No se encontró un enlace que coincida.
        return;
    }

    // 3. Marcar el enlace como activo
    activeLink.classList.add('active');

    // 4. Lógica para expandir el menú padre (si es un sub-enlace)
    if (activeLink.classList.contains('nav-sub-link')) {
        
        // Encontrar el contenedor colapsable (ej. <div id="admin-collapse" ...>)
        const section = activeLink.closest('.nav-section');
        
        if (section) {
            // 4a. Expandir la sección
            section.classList.add('show');
            
            // 4b. Encontrar el botón que controla esta sección
            const collapseId = '#' + section.id; // ej. "#admin-collapse"
            const toggleBtn = document.querySelector(`[data-bs-target="${collapseId}"]`);
            
            if (toggleBtn) {
                // 4c. Marcar el botón raíz (ej. "Administración") como activo y expandido
                toggleBtn.classList.add('active');
                toggleBtn.setAttribute('aria-expanded', 'true');
            }
        }
    }
});