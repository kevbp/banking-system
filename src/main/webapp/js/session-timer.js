/*
 * ===================================================
 * session-timer.js
 * * Lógica de inactividad HÍBRIDA (Cliente y Admin).
 * * V3: Detección mejorada de entorno y path.
 * ===================================================
 */
document.addEventListener('DOMContentLoaded', () => {

    // --- 1. Detección Robusta del Entorno ---
    const currentUrl = window.location.href;
    // Es cliente si la URL tiene la carpeta 'modulo-clientes' O si está usando el servlet 'ControlLoginCliente'
    const isClientPortal = currentUrl.includes('/modulo-clientes/') || currentUrl.includes('ControlLoginCliente');

    // --- 2. Obtener Context Path de forma segura ---
    // Si window.APP_CONTEXT_PATH no está definido, intentamos adivinarlo o usar cadena vacía
    let contextPath = '';
    if (typeof window.APP_CONTEXT_PATH !== 'undefined') {
        contextPath = window.APP_CONTEXT_PATH;
    } else {
        // Fallback: Intentar obtener el primer segmento de la URL (ej: /banking-system)
        const pathName = window.location.pathname;
        if (pathName.length > 1) {
            const firstSlash = pathName.indexOf('/', 1);
            if (firstSlash > 0) {
                contextPath = pathName.substring(0, firstSlash);
            }
        }
    }

    // --- Configuración ---
    const SESSION_DURATION_SECONDS = (typeof SESSION_TIMEOUT_SECONDS !== 'undefined') ? SESSION_TIMEOUT_SECONDS : 60;
    const WARN_BEFORE_SECONDS = 15;
    const GRACE_PERIOD_SECONDS = 5;
    const PING_THROTTLE_SECONDS = 5;

    const CONFIG = {
        controller: isClientPortal ? 'ControlLoginCliente' : 'ControlUsuario',
        actionParam: isClientPortal ? 'accion' : 'op',
        logoutValue: isClientPortal ? 'logout' : 'CerrarSesion',
        pingValue: 'keepAlive',
        timerDisplayId: isClientPortal ? 'sessionTimer' : 'session-header-countdown'
    };

    // --- Variables ---
    let lastActivityTime = Date.now();
    let mainTickInterval;
    let modalIsVisible = false;
    let canPing = true;

    // --- Elementos DOM ---
    // Buscamos el contador del Cliente o el del Admin
    const headerCountdownDisplay = document.getElementById(CONFIG.timerDisplayId) || document.getElementById('session-header-countdown');
    const headerCountdownWrapper = document.getElementById('header-countdown-wrapper') || headerCountdownDisplay?.parentElement;

    // Modal (si existe)
    const modalElement = document.getElementById('sessionWarningModal');
    let sessionModal = null;
    let modalCountdownDisplay = null;
    if (modalElement) {
        sessionModal = new bootstrap.Modal(modalElement);
        modalCountdownDisplay = document.getElementById('sessionCountdown');
    }

    // Si no hay display visible, salimos para no gastar recursos (opcional)
    if (!headerCountdownDisplay && !modalElement) {
        console.log("Timer: No se encontraron elementos visuales.");
        // return; // Comentado: A veces queremos que el logout forzoso ocurra aunque no haya timer visual
    }

    function checkSessionState() {
        const now = Date.now();
        const inactiveForSeconds = Math.floor((now - lastActivityTime) / 1000);
        let actualSessionTimeRemaining;

        if (inactiveForSeconds < GRACE_PERIOD_SECONDS) {
            actualSessionTimeRemaining = SESSION_DURATION_SECONDS;
            if (modalIsVisible && sessionModal) {
                sessionModal.hide();
                modalIsVisible = false;
            }
        } else {
            actualSessionTimeRemaining = SESSION_DURATION_SECONDS - (inactiveForSeconds - GRACE_PERIOD_SECONDS);
        }

        const displaySeconds = Math.max(0, actualSessionTimeRemaining);
        updateVisuals(displaySeconds, displaySeconds <= WARN_BEFORE_SECONDS);

        if (sessionModal && displaySeconds <= WARN_BEFORE_SECONDS && !modalIsVisible) {
            modalIsVisible = true;
            if (modalCountdownDisplay)
                modalCountdownDisplay.textContent = displaySeconds;
            sessionModal.show();
        }

        if (displaySeconds <= 0) {
            logout();
        }
    }

    function updateVisuals(seconds, isWarning) {
        const s = seconds < 10 ? `0${seconds}` : seconds;

        if (headerCountdownDisplay)
            headerCountdownDisplay.textContent = s;
        if (modalIsVisible && modalCountdownDisplay)
            modalCountdownDisplay.textContent = s;

        if (headerCountdownDisplay) {
            const target = headerCountdownWrapper || headerCountdownDisplay;
            if (isWarning) {
                target.classList.add('text-danger');
                target.classList.remove('text-muted', 'text-warning');
            } else {
                target.classList.remove('text-danger');
                if (!isClientPortal)
                    target.classList.add('text-muted');
                else
                    target.classList.add('text-warning');
            }
        }
    }

    function handleUserActivity() {
        lastActivityTime = Date.now();
        pingServer();
    }

    function pingServer() {
        if (canPing) {
            canPing = false;
            // Construimos URL correctamente con el Context Path
            const url = `${contextPath}/${CONFIG.controller}?${CONFIG.actionParam}=${CONFIG.pingValue}`;

            fetch(url).then(r => {
                if (!r.ok)
                    logout();
            }).catch(() => {
            });

            setTimeout(() => {
                canPing = true;
            }, PING_THROTTLE_SECONDS * 1000);
        }
    }

    function logout() {
        clearInterval(mainTickInterval);
        const url = `${contextPath}/${CONFIG.controller}?${CONFIG.actionParam}=${CONFIG.logoutValue}`;
        console.log("Cerrando sesión, redirigiendo a:", url); // Para depuración
        window.location.href = url;
    }

    ['click', 'mousemove', 'keypress', 'scroll', 'touchstart'].forEach(evt => {
        document.addEventListener(evt, handleUserActivity);
    });

    mainTickInterval = setInterval(checkSessionState, 1000);
});