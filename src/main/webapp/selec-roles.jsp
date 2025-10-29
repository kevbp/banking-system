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
            <div class="right">
                <div class="role-card">                    
                    <div class="text-center mb-4">
                        <img src="img/logoQB.png" alt="Quantum Bank Logo" style="width:120px" class="mb-3"/>
                    </div>                    
                    <h2>Seleccione su tipo de Ingreso</h2>   
                    <form id="rolForm" action="${pageContext.request.contextPath}/ControlLogin" method="post">  
                        <input type="hidden" id="rolSeleccionado" name="rol" value="">
                        <div class="roles-container">
                                <div class="rol" id="empleado" data-url="login.jsp" onclick="seleccionarRol('empleado')">
                                    <img src="img/admin.png" alt="Empleado"> 
                                    <p>Empleado</p>
                                </div>
                            <div class="rol" id="cliente" data-url="clientes/login-clientes.jsp" onclick="seleccionarRol('cliente')">
                                <img src="img/cliente.png" alt="Cliente"> 
                                <p>Cliente</p>
                            </div>
                        </div>
                        <div class="d-grid mt-4">
                            <button type="submit" id="btnContinuar" >Continuar</button>
                        </div>  
                    </form>                  
                </div>
            </div>
        </div>
        <script src="js/selec-rol.js"></script>
        <script src="js/bootstrap.bundle.min.js"></script>
    </body>
</html>
