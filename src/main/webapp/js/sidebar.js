document.addEventListener('DOMContentLoaded', () => {
  const currentPath = window.location.pathname + window.location.search;

  // 1) Marcar activo el subitem cuyo href coincide con la URL actual
  const subLinks = document.querySelectorAll('.nav-sub-link');
  let activeSub = null;
  subLinks.forEach(a => {
    // Comparación flexible: si el href está contenido en la URL actual
    // o coincide exactamente (útil para /ControlCliente?op=...).
    const href = a.getAttribute('href');
    if (!href) return;

    const samePage = currentPath === href || currentPath.endsWith(href) || currentPath.includes(href);
    if (samePage) {
      a.classList.add('active');
      activeSub = a;
    }
  });

  // 2) Si hay un subitem activo, expandir su sección y marcar la raíz
  if (activeSub) {
    const section = activeSub.closest('.nav-section');
    if (section && !section.classList.contains('show')) {
      section.classList.add('show');
    }
    const collapseId = '#' + section.id;
    const toggleBtn = document.querySelector(`[data-bs-target="${collapseId}"]`);
    if (toggleBtn) {
      toggleBtn.classList.add('active');
      toggleBtn.setAttribute('aria-expanded', 'true');
    }
  }

  // 3) Si estamos exactamente en el home, marcar Inicio como activo
  const isHome = document.body.classList.contains('is-home') ||
                 /\/home\.jsp$/i.test(currentPath);
  if (isHome) {
    const homeLink = document.querySelector('.nav-link.nav-root[href$="home.jsp"]');
    if (homeLink) homeLink.classList.add('active');
  }
});
