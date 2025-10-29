<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="../css/bootstrap.min.css">
        <link rel="stylesheet" href="../css/login-cli.css"/> 
        <title>Banca w  eb - Recuperar Contraseña</title>
        <style>
            
            .right-section { 
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .login-card-cliente { max-width: 400px; }
        </style>
    </head>
    <body>
        <div class="container-fluid h-100 g-0">
            <div class="row h-100 g-0">

                <div class="col-md-6 d-none d-md-block">
                    <img src="../img/portada.jpg" alt="Quantum Bank" class="img-fluid h-100 w-100 object-fit-cover">
                </div>

                <div class="col-md-6 right-section">
                    <div class="login-card-cliente" style="max-width: 400px;"> 
                        <div class="d-flex justify-content-center align-items-center mb-3">
                            <img src="../img/logoQB.png" alt="Quantum Bank Logo" style="width:150px"/>
                        </div>
                        <div class="text-center">
                            <p>Recuperación de Contraseña</p>
                        </div>

                        <form action="${pageContext.request.contextPath}/ControlRecuperarContrasena" method="POST">
                            
                            <c:if test="${empty requestScope.showNewPasswordForm}">
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" name="inpDNI" id="inpDNI" placeholder="DNI" required value="${param.inpDNI}">
                                    <label for="inpDNI">DNI</label>
                                </div>

                                <div class="form-floating mb-3">
                                    <input type="password" class="form-control" name="inpClave" id="inpClave" placeholder="Palabra Clave" required>
                                    <label for="inpClave">Palabra Clave (Secreta)</label>
                                </div>
                                <div class="d-grid mt-4">
                                    <button type="submit" name="action" value="verificar" class="btn btn-custom">Verificar</button>
                                </div>
                            </c:if>

                            <c:if test="${not empty requestScope.showNewPasswordForm and requestScope.showNewPasswordForm}">
                                
                                <input type="hidden" name="inpDNI" value="${param.inpDNI}">
                                
                                <div class="alert alert-success text-center" role="alert">¡Verificación exitosa! Ingrese su nueva contraseña.</div>
                                
                                <div class="form-floating mb-3">
                                    <input type="password" class="form-control" name="inpNuevaPwd" id="inpNuevaPwd" placeholder="Nueva Contraseña" required>
                                    <label for="inpNuevaPwd">Nueva Contraseña</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <input type="password" class="form-control" name="inpConfirmarPwd" id="inpConfirmarPwd" placeholder="Confirmar Contraseña" required>
                                    <label for="inpConfirmarPwd">Confirmar Contraseña</label>
                                </div>
                                <div class="d-grid mt-4">
                                    <button type="submit" name="action" value="recuperar" class="btn btn-custom">Recuperar Contraseña</button>
                                </div>
                            </c:if>
                            
                            <div class="text-center mt-3">
                                <a href="login-clientes.jsp" class="text-decoration-none small text-secondary">Volver al Login</a>
                            </div>

                            <c:if test="${not empty mensaje}">
                                <div class="alert alert-warning text-center mt-3">${mensaje}</div>
                            </c:if>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="../js/bootstrap.bundle.min.js"></script>
    </body>
</html>