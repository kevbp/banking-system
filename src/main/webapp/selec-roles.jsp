<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Banca Web - Selección de Rol</title>

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/selec-rol.css"/> 
    </head>

    <body class="d-flex align-items-center justify-content-center vh-100">

        <div class="card shadow-lg border-0 role-card">
            <div class="card-body p-5">

                <div class="text-center mb-4">
                    <img src="${pageContext.request.contextPath}/img/logoQB_colores.png" alt="Quantum Bank Logo" style="width:150px" class="mb-5"/>
                    <h2 class="h5 fw-bold mb-1">Bienvenido</h2>
                    <p class="text-muted">Seleccione su tipo de ingreso</p>
                </div>

                <form id="rolForm" action="${pageContext.request.contextPath}/ControlLogin" method="post">
                    <input type="hidden" id="rolSeleccionado" name="rol" value="">

                    <div class="roles-container">
                        <div class="rol text-center" data-value="empleado">
                            <img src="${pageContext.request.contextPath}/img/admin.png" alt="Empleado"> 
                            <p>Empleado</p>
                        </div>
                        <div class="rol text-center" data-value="cliente">
                            <img src="${pageContext.request.contextPath}/img/cliente.png" alt="Cliente"> 
                            <p>Cliente</p>
                        </div>
                    </div>

                    <div class="d-grid mt-4">
                        <button type="submit" id="btnContinuar" class="btn btn-primary btn-lg fw-semibold" disabled>
                            Continuar
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>

        <script src="${pageContext.request.contextPath}/js/selec-rol.js"></script>
    </body>
</html>