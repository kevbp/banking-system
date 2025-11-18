<%-- 
    Document   : recuperarContrasena
    Created on : Oct 27, 2025
    Author     : broncake
    Descripción: Rediseñado con el layout de login-empleado.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/estilos.css"/> 

        <title>Banca Web - Recuperar Contraseña</title>

    </head>

    <body class="d-flex align-items-center justify-content-center vh-100">

        <div class="container-fluid vh-100 g-0">
            <div class="row h-100 g-0">

                <div class="col-md-6 d-none d-md-block">
                    <img src="${pageContext.request.contextPath}/img/portada_cliente.jpg" alt="Quantum Bank" class="w-100 vh-100 object-fit-cover">
                </div>

                <div class="col-12 col-md-6 d-flex align-items-center justify-content-center bg-gradient">

                    <div class="login-card animate-fade">

                        <div class="d-flex justify-content-center align-items-center mb-3">
                            <img src="${pageContext.request.contextPath}/img/logoQB_colores.png" alt="Quantum Bank Logo" style="width:140px"/>
                        </div>
                        <div class="text-center">
                            <p class="h5 fw-light text-muted">Recuperación de Contraseña</p>
                        </div>

                        <form action="${pageContext.request.contextPath}/ControlLoginCliente" method="post">
                            <input type="hidden" name="accion" value="recuperar">
                            <c:if test="${empty requestScope.showNewPasswordForm}">
                                <p class="text-center text-muted small mt-3">Ingrese su DNI y su palabra secreta para verificar su identidad.</p>

                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" name="inpDNI" id="inpDNI" placeholder="DNI" required value="${param.inpDNI}">
                                    <label for="inpDNI">DNI</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <input type="password" class="form-control" name="inpClave" id="inpClave" placeholder="Palabra Clave" required>
                                    <label for="inpClave">Palabra Clave (Secreta)</label>
                                </div>
                                <div class="d-grid mt-4">
                                    <button type="submit" name="actionStep" value="verificar" class="btn btn-login">Verificar</button>
                                </div>
                            </c:if>

                            <c:if test="${not empty requestScope.showNewPasswordForm and requestScope.showNewPasswordForm}">

                                <input type="hidden" name="inpDNI" value="${param.inpDNI}">

                                <div class="alert alert-success text-center small" role="alert">¡Verificación exitosa! Ingrese su nueva contraseña.</div>

                                <div class="form-floating mb-3">
                                    <input type="password" class="form-control" name="inpNuevaPwd" id="inpNuevaPwd" placeholder="Nueva Contraseña" required>
                                    <label for="inpNuevaPwd">Nueva Contraseña</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <input type="password" class="form-control" name="inpConfirmarPwd" id="inpConfirmarPwd" placeholder="Confirmar Contraseña" required>
                                    <label for="inpConfirmarPwd">Confirmar Contraseña</label>
                                </div>
                                <div class="d-grid mt-4">
                                    <button type="submit" name="actionStep" value="recuperar" class="btn btn-login">Recuperar Contraseña</button>
                                </div>
                            </c:if>

                            <c:if test="${not empty mensaje}">
                                <div class="alert alert-warning text-center mt-3">${mensaje}</div>
                            </c:if>

                            <div class="text-center mt-3">
                                <a href="${pageContext.request.contextPath}/modulo-clientes/login-clientes.jsp" class="text-decoration-none small text-secondary">Volver al Login</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    </body>
</html>