/*
 * ===================================================
 * session-timer.js
 * * Lógica de inactividad con 5s de gracia y contador siempre visible.
 * * El modal es solo una advertencia y se cierra con CUALQUIER actividad.
 *
 * * v2 (CORREGIDO): 'handleUserActivity' ahora SIEMPRE
 * * intenta hacer ping, y 'pingServer' lo filtra (throttle).
 * ===================================================
 */
document.addEventListener('DOMContentLoaded', () => {

    // --- Configuración ---
    const SESSION_DURATION_SECONDS = 60; // 60s (debe coincidir con setMaxInactiveInterval)
    const WARN_BEFORE_SECONDS = 15;      // 15s de aviso
    const GRACE_PERIOD_SECONDS = 5;      // 5s de gracia
    const PING_THROTTLE_SECONDS = 5;     // 1 ping cada 5s de actividad

    // --- Variables de estado ---
    let lastActivityTime = Date.now();
    let mainTickInterval;
    let modalIsVisible = false;
    let canPing = true; // Para throttling del ping

    // --- Elementos del DOM ---
    const modalElement = document.getElementById('sessionWarningModal');
    if (!modalElement) {
        console.warn("Timer de Sesión: No se encontró #sessionWarningModal. Saliendo.");
        return;
    }

    const sessionModal = new bootstrap.Modal(modalElement);
    const modalCountdownDisplay = document.getElementById('sessionCountdown');
    const headerCountdownWrapper = document.getElementById('header-countdown-wrapper');
    const headerCountdownDisplay = document.getElementById('session-header-countdown');

    // Asumir que 'window.APP_CONTEXT_PATH' se define en el JSP (lo pusimos en header.jsp)
    const CONTEXT_PATH = window.APP_CONTEXT_PATH || '';

    /**
     * El corazón del timer. Se ejecuta CADA SEGUNDO.
     */
    function checkSessionState() {
        const now = Date.now();
        const inactiveForSeconds = Math.floor((now - lastActivityTime) / 1000);

        let actualSessionTimeRemaining;

        // 1. Aún en período de gracia (0-4 segundos de inactividad)
        if (inactiveForSeconds < GRACE_PERIOD_SECONDS) {
            actualSessionTimeRemaining = SESSION_DURATION_SECONDS;
            // Ocultar modal si estuviera visible
            if (modalIsVisible) {
                sessionModal.hide();
                modalIsVisible = false;
            }
        } else {
            // 2. Período de gracia terminado. Empezar conteo regresivo.
            actualSessionTimeRemaining = SESSION_DURATION_SECONDS - (inactiveForSeconds - GRACE_PERIOD_SECONDS);
        }

        // 3. Actualizar los contadores visuales
        const displaySeconds = Math.max(0, actualSessionTimeRemaining);
        updateVisuals(displaySeconds, displaySeconds <= WARN_BEFORE_SECONDS);

        // 4. Lógica de Advertencia (Modal)
        if (displaySeconds <= WARN_BEFORE_SECONDS && !modalIsVisible) {
            modalIsVisible = true;
            modalCountdownDisplay.textContent = displaySeconds;
            sessionModal.show();
        }

        // 5. Lógica de Cierre de Sesión
        if (displaySeconds <= 0) {
            logout();
        }
    }

    /**
     * Actualiza el DOM (ambos contadores y el color del header).
     */
    function updateVisuals(seconds, isWarning) {
        const s = seconds < 10 ? `0${seconds}` : seconds;

        if (headerCountdownDisplay) {
            headerCountdownDisplay.textContent = s;
        }

        if (modalIsVisible && modalCountdownDisplay) {
            modalCountdownDisplay.textContent = s;
        }

        if (headerCountdownWrapper) {
            if (isWarning) {
                headerCountdownWrapper.classList.add('text-danger');
                headerCountdownWrapper.classList.remove('text-muted');
            } else {
                headerCountdownWrapper.classList.remove('text-danger');
                headerCountdownWrapper.classList.add('text-muted');
            }
        }
    }

    /**
     * Se llama con CUALQUIER actividad del usuario.
     */
    function handleUserActivity() {
        // CAMBIO: La lógica de 'if (inactiveForSeconds...)' se eliminó.

        // 1. Resetea el timer visual INMEDIATAMENTE.
        lastActivityTime = Date.now();

        // 2. Intenta hacer ping al servidor (la función pingServer lo filtrará).
        pingServer();
    }

    /**
     * Envía un "ping" (keep-alive) al backend (con throttling).
     */
    function pingServer() {
        // 'canPing' es el guardián. Si es 'false', la función no hace nada.
        // Esto asegura que solo se ejecute 1 ping cada 5 segundos.
        if (canPing) {
            canPing = false; // Bloquea pings futuros

            fetch(`${CONTEXT_PATH}/ControlUsuario?op=keepAlive`)
                    .then(response => {
                        if (!response.ok) {
                            logout();
                        }
                        // Si el ping es exitoso, la sesión del servidor se reinició.
                    })
                    .catch(() => {
                        logout();
                    });

            // Re-habilita el ping después de 5 segundos.
            setTimeout(() => {
                canPing = true;
            }, PING_THROTTLE_SECONDS * 1000);
        }
    }

    /**
     * Cierra la sesión forzosamente.
     */
    function logout() {
        clearInterval(mainTickInterval); // Detiene el reloj
        window.location.href = `${CONTEXT_PATH}/ControlUsuario?op=CerrarSesion`;
    }

    // --- Vinculación de Eventos ---
    // (Ya no hay botones de modal)

    // Eventos de actividad
    ['click', 'mousemove', 'keypress', 'scroll', 'touchstart'].forEach(event => {
        document.addEventListener(event, handleUserActivity);
    });

    // Iniciar el reloj
    mainTickInterval = setInterval(checkSessionState, 1000);
});