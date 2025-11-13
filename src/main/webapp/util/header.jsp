<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<header class="header d-flex justify-content-end align-items-center px-4">
    <div class="d-flex align-items-center gap-3">
        <span class="fw-medium text-dark">${sessionScope.usuAut.username}</span>
        <c:url var="urlLogout" value="/ControlUsuario">
            <c:param name="op" value="CerrarSesion"/>
        </c:url>
        <a href="${urlLogout}" class="btn btn-sm btn-outline-primary fw-semibold px-3">Cerrar sesión</a>
    </div>
</header>
