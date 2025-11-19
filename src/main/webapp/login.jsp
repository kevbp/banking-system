<%-- 
    Document   : login
    Created on : Oct 6, 2025, 12:32:20 PM
    Author     : broncake
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Quantum Bank - Login Empleado</title>

        <!-- Fuentes y Bootstrap -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/estilos.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    </head>

    <body>
        <div class="container-fluid h-100 g-0">
            <div class="row h-100 g-0">
                <!-- Imagen lateral -->
                <div class="col-md-6 d-none d-md-block img-side">
                    <img src="img/portada.jpg" alt="Quantum Bank" class="img-fluid h-100 w-100 object-fit-cover">
                </div>

                <!-- Formulario -->
                <div class="col-md-6 d-flex justify-content-center align-items-center bg-gradient position-relative">

                    <a href="${pageContext.request.contextPath}/selec-roles.jsp" 
                       class="text-decoration-none text-secondary position-absolute top-0 start-0 m-4 fw-medium"
                       style="font-size: 0.9rem;">
                        <i class="bi bi-chevron-left me-1"></i>Volver a la selección de rol
                    </a>

                    <div class="login-card animate-fade">
                        <div class="text-center mb-4">
                            <img src="img/logoQB_colores.png" alt="Quantum Bank" style="width:140px;">
                            <p class="mt-3 text-muted">Inicie sesión para comenzar.</p>
                        </div>

                        <form action="${pageContext.request.contextPath}/ControlLogin" method="POST">
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" name="inpUsu" id="inpUsu" placeholder="Usuario" required>
                                <label for="inpUsu">Usuario</label>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="password" class="form-control" name="inpPwd" id="inpPwd" placeholder="Contraseña" required>
                                <label for="inpPwd">Contraseña</label>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-login">Iniciar Sesión</button>
                            </div>

                            <c:if test="${not empty mensaje}">
                                <div class="alert alert-warning text-center mt-3 small">${mensaje}</div>
                            </c:if>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="js/bootstrap.bundle.min.js"></script>
    </body>
</html>
