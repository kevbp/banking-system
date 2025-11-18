<%-- 
    Document   : login-cliente
    Created on : Oct 27, 2025
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
        <title>Banca Web - Login Cliente</title>

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css"/>
    </head>
    <body>
        <div class="container-fluid vh-100 g-0">
            <div class="row h-100 g-0">

                <div class="col-md-6 d-none d-md-block">
                    <img src="${pageContext.request.contextPath}/img/portada_cliente.jpg" alt="Quantum Bank Clientes" class="img-fluid h-100 w-100 object-fit-cover">
                </div>

                <div class="col-md-6 d-flex justify-content-center align-items-center bg-gradient">

                    <div class="login-card animate-fade">

                        <div class="d-flex justify-content-center align-items-center mb-3">
                            <img src="${pageContext.request.contextPath}/img/logoQB_colores.png" alt="Quantum Bank Logo" style="width:140px"/>
                        </div>

                        <div class="text-center mb-3">
                            <p class="text-muted">Inicia sesión como Cliente.</p>
                        </div>

                        <form action="${pageContext.request.contextPath}/ControlLoginCliente" method="post">
                            <input type="hidden" name="accion" value="login">
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" name="inpUsu" id="inpUsu" placeholder="Ingresa tu DNI" required>
                                <label for="inpUsu">Usuario</label>
                            </div>

                            <div class="form-floating mb-3">
                                <input type="password" class="form-control" name="inpPwd" id="inpPwd" placeholder="Ingresa tu contraseña" required>
                                <label for="inpPwd">Contraseña</label>
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-login">Iniciar Sesión</button>
                            </div>

                            <c:if test="${not empty mensaje}">
                                <div class="alert alert-warning text-center mt-3">${mensaje}</div>
                            </c:if>

                            <div class="text-center mt-3">
                                <a href="${pageContext.request.contextPath}/modulo-clientes/recuperar-contrasena.jsp" class="text-decoration-none small text-secondary">¿Olvidaste tu contraseña?</a>
                            </div>

                            <hr class="my-4">

                            <div class="text-center">
                                <p class="small text-muted mb-2">¿No tienes cuenta?</p>
                                <a href="${pageContext.request.contextPath}/modulo-clientes/registro-clientes.jsp" class="btn btn-outline-secondary w-100">Registrarse</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    </body>
</html>