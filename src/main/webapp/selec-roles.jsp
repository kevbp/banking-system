<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/selec-rol.css"/> 
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <title>Banca web - Selección de Rol</title>
    </head>
    <body>

        <div class="container">
            <div class="left">
                </div>

            <div class="right">
                <div class="role-card">
                    
                    <div class="text-center mb-4">
                        <img src="img/logoQB.png" alt="Quantum Bank Logo" style="width:120px" class="mb-3"/>
                    </div>
                    
                    <h2>¿Con qué rol deseas ingresar?</h2>
                    
                    <form id="rolForm" action="" method="post"> 
                        <input type="hidden" id="rolSeleccionado" name="rol" value="">

                        <div class="roles-container">
                            
                            <div class="rol" id="empleado" data-url="login.jsp" onclick="seleccionarRol('empleado')">
                                <img src="img/admin.png" alt="Empleado"> 
                                <p>Empleado</p>
                            </div>
                            
                            <div class="rol" id="cliente" data-url="login-cli.jsp" onclick="seleccionarRol('cliente')">
                                <img src="img/cliente.png" alt="Cliente"> 
                                <p>Cliente</p>
                            </div>
                        </div>

                        <div class="d-grid mt-4">
                            <button type="submit" id="btnContinuar" disabled>Continuar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="js/selec-rol.js"></script>
        <script src="js/bootstrap.bundle.min.js"></script>
    </body>
</html>
