<%-- 
    Document   : registroClientes
    Created on : Oct 29, 2025
    Author     : Kevin
    Descripción : Pantalla de Registro de Cliente, rediseñada con el layout de login.jsp.
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

        <title>Banca Web - Registrarme</title>
    </head>

    <body class="d-flex align-items-center justify-content-center vh-100">

        <div class="container-fluid vh-100 g-0">
            <div class="row h-100 g-0">

                <div class="col-md-6 d-none d-md-block">
                    <img src="${pageContext.request.contextPath}/img/portada_cliente.jpg" alt="Quantum Bank Clientes" class="w-100 vh-100 object-fit-cover">
                </div>

                <div class="col-12 col-md-6 d-flex align-items-center justify-content-center bg-gradient">

                    <div class="login-card animate-fade">

                        <div class="text-center mb-4">
                            <img src="${pageContext.request.contextPath}/img/logoQB_colores.png" alt="Quantum Bank Logo" style="width:140px;" class="mb-3"/>
                        </div>

                        <c:if test="${not empty mensajeCuentasInactivas}">

                            <div id="avisoAcudirBanco" class="text-center">
                                <i class="bi bi-bank display-4 text-danger mb-3"></i>
                                <h5 class="mb-2 fw-bold">Activación Requerida</h5>
                                <p class="text-muted small">
                                    ${mensajeCuentasInactivas}
                                </p>

                                <ul class="list-unstyled text-start small mt-4 p-3 bg-light rounded-3">
                                    <li class="mb-1"><i class="bi bi-check-circle-fill text-success me-2"></i>Acuda a la sucursal con su DNI.</li>
                                    <li><i class="bi bi-check-circle-fill text-success me-2"></i>Solicite a un asesor la activación de su banca web.</li>
                                </ul>

                                <div class="d-grid mt-4">
                                    <a href="login-clientes.jsp" class="btn btn-outline-secondary">Volver al Login</a>
                                </div>
                            </div>

                        </c:if>

                        <c:if test="${empty mensajeCuentasInactivas}">

                            <form action="${pageContext.request.contextPath}/ControlLoginCliente" method="post">
                                <input type="hidden" name="accion" value="registrar">
                                <p class="text-center text-muted">Cree su acceso a la Banca por Internet.</p>

                                <div class="row g-2 mb-3">
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="text" class="form-control" name="inpDni" id="inpDni" placeholder="DNI" required>
                                            <label for="inpDNI">DNI</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="text" class="form-control" name="inpUsu" id="inpUsu" placeholder="Usuario" required>
                                            <label for="inpUsuario">Nombre de usuario</label>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" name="inpPalRec" id="inpPalRec" placeholder="Palabra de recuperación" required>
                                    <label for="inpClave">Palabra de recuperación</label>
                                </div>

                                <div class="row g-2 mb-3">
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="password" class="form-control" name="inpPwd" id="inpPwd" placeholder="Contraseña" required>
                                            <label for="inpPwd">Contraseña</label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-floating">
                                            <input type="password" class="form-control" name="inpPwdConf" id="inpPwdConf" placeholder="Confirmar contraseña" required>
                                            <label for="inpPwdConfirm">Confirmar contraseña</label>
                                        </div>
                                    </div>
                                </div>

                                <div class="d-grid mt-4">
                                    <button type="submit" class="btn btn-login">Finalizar registro</button>
                                </div>

                                <c:if test="${not empty mensaje}">
                                    <div class="alert alert-warning text-center mt-3">${mensaje}</div>
                                </c:if>

                                <div class="text-center mt-3">
                                    <a href="${pageContext.request.contextPath}/modulo-clientes/login-clientes.jsp" class="text-decoration-none small text-secondary">Volver al Login</a>
                                </div>
                            </form>
                        </c:if>

                    </div>
                </div> 
            </div> 
        </div>

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    </body>
</html>