<%-- 
    Document   : login
    Created on : Oct 6, 2025, 12:32:20 PM
    Author     : broncake
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="css/styles.css"/>
        <title>Banca web - Login</title>
    </head>
    <body>
        <div class="container-fluid h-100 g-0">
            <div class="row h-100 g-0">
                <!-- Zona Izquierda (Imagen) -->
                <div class="col-md-6">
                    <img src="img/portada.jpg" alt="Quantum Bank" class="img-fluid h-100 w-100 object-fit-cover">
                </div>

                <!-- Zona Derecha (Formulario) -->
                <div class="col-md-6 right-section">
                    <div class="login-card">
                        <div class="d-flex justify-content-center align-items-center mb-3">
                            <img src="img/logoQB.png" alt="alt" style="width:150px"/>
                        </div>
                        <div class="text-center">
                            <p>Inicie sesión para comenzar.</p>
                        </div>
                        <form action="${pageContext.request.contextPath}/ControlLogin" method="POST">
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" name="inpUsu" id="inpUsu" placeholder="Ingresa tu usuario">
                                <label for="inpUsu" class="form-label">Usuario</label>
                            </div>
                            <div class="form-floating mb-3">
                                <input type="password" class="form-control" name="inpPwd" id="inpPwd" placeholder="Ingresa tu contraseña">
                                <label for="inpPwd" class="form-label">Contraseña</label>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-custom">Iniciar Sesión</button>
                            </div>
                            <c:if test="${param.error == 1}">
                                <div class="text-center mt-3 text-danger">Usuario o clave incorrecta</div>
                            </c:if>

                            <!-- <div class="text-center mt-3">
                                <a href="#" class="text-decoration-none small text-secondary">¿Olvidaste tu contraseña?</a>
                            </div> -->
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="js/bootstrap.bundle.min.js"></script>
    </body>
</html>
