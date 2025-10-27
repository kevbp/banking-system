<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <link rel="stylesheet" href="cs/login-cli.css"/> 
        <title>Banca web - Login Cliente</title>
        <style>
            .right-section {
                min-height: 100vh; 
            }
            .login-card-cliente { 
                 margin: 40px auto; 
            }
        </style>
    </head>
    <body>
        <div class="container-fluid h-100 g-0">
            <div class="row h-100 g-0">
                
                <div class="col-md-6 d-none d-md-block">
                    <img src="img/portada.jpg" alt="Quantum Bank" class="img-fluid h-100 w-100 object-fit-cover">
                </div>

                <div class="col-md-6 right-section d-flex align-items-center justify-content-center">
                    
                    <div class="login-card-cliente" style="max-width: 400px;"> 
                        <div class="text-center">
                            <img src="img/logoQB.png" alt="Quantum Bank Logo" style="width:150px" class="mb-3"/>
                            <p>Inicia sesión como Cliente</p>
                        </div>
                        
                        <form action="${pageContext.request.contextPath}/ControlLoginCliente" method="POST">
                            
                            <div class="form-floating mb-3">
                                <input type="text" class="form-control" name="inpUsu" id="inpUsu" placeholder="Usuario" required>
                                <label for="inpUsu">Usuario</label>
                            </div>
                            
                            <div class="form-floating mb-3">
                                <input type="password" class="form-control" name="inpPwd" id="inpPwd" placeholder="Contraseña" required>
                                <label for="inpPwd">Contraseña</label>
                            </div>
                            
                            <div class="d-grid mt-4">
                                <button type="submit" class="btn btn-custom">Iniciar Sesión</button>
                            </div>

                            <div class="text-center mt-3">
                                <a href="recuperarContrasena.jsp" class="text-decoration-none small text-secondary">¿Olvidaste tu contraseña?</a>
                            </div>
                            
                            <c:if test="${not empty mensaje}">
                                <div class="alert alert-warning text-center mt-3">${mensaje}</div>
                            </c:if>

                            <hr class="my-4">
                            
                            <div class="text-center">
                                <p class="small text-muted mb-2">¿No tienes cuenta?</p>
                                <a href="registroClientes.jsp" class="btn btn-outline-secondary w-100">Registrarse</a>
                            </div>
                            
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="js/bootstrap.bundle.min.js"></script>
    </body>
</html>