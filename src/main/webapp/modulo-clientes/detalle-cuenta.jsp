<%-- 
    Document   : detalle-cuenta.jsp
    Descripción: (V-05) Muestra los movimientos y detalles de una cuenta.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Detalle de Cuenta - Quantum Bank</title>

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link href="../css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <link rel="stylesheet" href="../css/estilos-cliente.css"/> 
    </head>

    <body data-active-page="cuentas">

        <script>
            // Define el context path para los scripts
            window.APP_CONTEXT_PATH = "${pageContext.request.contextPath}";
        </script>

        <nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
            <div class="container-fluid px-4">

                <a class="navbar-brand" href="dashboard-cliente.jsp">
                    <img src="../img/logoQB_colores.png" alt="Quantum Bank" height="40">
                </a>

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarClienteContent" aria-controls="navbarClienteContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarClienteContent">

                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link" href="dashboard-cliente.jsp" data-page-id="cuentas">
                                Mis Cuentas
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="#" data-page-id="productos">
                                Abrir Productos
                            </a>
                        </li>
                    </ul>

                    <ul class="navbar-nav ms-auto align-items-center">
                        <li class="nav-item me-2 mb-2 mb-lg-0">
                            <a href="#" class="btn btn-primary fw-semibold px-3">
                                <i class="bi bi-arrow-left-right me-1"></i> Transferir
                            </a>
                        </li>

                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" id="navbarDropdownUser" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="bi bi-person-circle fs-4 me-2"></i>
                                <span class="fw-semibold">Juan Pérez</span> 
                            </a>
                            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownUser">
                                <li><a class="dropdown-item" href="#">Mi Perfil</a></li>
                                <li><a class="dropdown-item" href="#">Seguridad</a></li>
                                <li><hr class="dropdown-divider"></li>
                                <li><a class="dropdown-item" href="../login-clientes.jsp">Cerrar Sesión</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container-fluid p-4">

            <div class="mb-4">
                <h2 class="h5 text-muted fw-normal">Cuenta de Ahorros - Soles</h2>
                <h1 class="display-5 fw-bold">S/ 1,250.50</h1>
                <span class="text-muted">Saldo Disponible</span>
            </div>

            <div class="row">

                <div class="col-lg-8">
                    <div class="card shadow-sm border-0">
                        <div class="card-body p-4">
                            <h5 class="card-title fw-semibold mb-3">Últimos 20 Movimientos</h5>

                            <div class="table-responsive">
                                <table class="table table-striped align-middle">
                                    <thead class="table-light">
                                        <tr>
                                            <th scope="col">Fecha</th>
                                            <th scope="col">Descripción</th>
                                            <th scope="col" class="text-end">Monto</th>
                                            <th scope="col" class="text-end">Saldo</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>12/11/2025</td>
                                            <td>
                                                <span class="d-block fw-medium">Depósito en Agente</span>
                                                <span class="d-block small text-muted">Agente K-0012</span>
                                            </td>
                                            <td class="text-end text-success fw-medium">
                                                + S/ 50.00
                                            </td>
                                            <td class="text-end">S/ 1,250.50</td>
                                        </tr>
                                        <tr>
                                            <td>11/11/2025</td>
                                            <td>
                                                <span class="d-block fw-medium">Pago de Servicio (Netflix)</span>
                                                <span class="d-block small text-muted">Cod. 12345</span>
                                            </td>
                                            <td class="text-end text-danger fw-medium">
                                                - S/ 44.90
                                            </td>
                                            <td class="text-end">S/ 1,200.50</td>
                                        </tr>
                                        <tr>
                                            <td>10/11/2025</td>
                                            <td>
                                                <span class="d-block fw-medium">Transferencia a Terceros</span>
                                                <span class="d-block small text-muted">Cta. 001-XXXX-002</span>
                                            </td>
                                            <td class="text-end text-danger fw-medium">
                                                - S/ 100.00
                                            </td>
                                            <td class="text-end">S/ 1,245.40</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">

                    <div class="card shadow-sm border-0 mb-3">
                        <div class="card-body p-4">
                            <h5 class="card-title fw-semibold mb-3">Acciones de Cuenta</h5>

                            <div class="d-grid gap-2">
                                <a href="#" class="btn btn-primary">
                                    <i class="bi bi-arrow-left-right me-1"></i> Transferir
                                </a>
                                <a href="#" class="btn btn-outline-secondary">
                                    <i class="bi bi-box-arrow-in-down me-1"></i> Depositar
                                </a>
                                <a href="#" class="btn btn-outline-secondary">
                                    <i class="bi bi-cash me-1"></i> Retirar
                                </a>

                                <button class="btn btn-outline-danger mt-3" disabled>
                                    Cerrar Cuenta
                                </button>
                                <small class="text-muted text-center">La cuenta debe tener saldo S/ 0.00 para cerrarse.</small>
                            </div>
                        </div>
                    </div>

                    <div class="card shadow-sm border-0">
                        <div class="card-body p-4">
                            <h5 class="card-title fw-semibold mb-3">Datos de la Cuenta</h5>
                            <ul class="list-unstyled account-details">
                                <li>
                                    <span>N° de Cuenta:</span>
                                    <strong>001-XXXX-001</strong>
                                </li>
                                <li>
                                    <span>CCI:</span>
                                    <strong>002-001-XXXXXXXXXX-01</strong>
                                </li>
                                <li>
                                    <span>Titular:</span>
                                    <strong>Juan Pérez</strong>
                                </li>
                                <li>
                                    <span>Estado:</span>
                                    <strong class="text-success">Activa</strong>
                                </li>
                            </ul>
                        </div>
                    </div>

                </div> </div> </div> <div class="modal fade" id="sessionWarningModal" 
                                  data-bs-backdrop="static" data-bs-keyboard="false" 
                                  tabindex="-1" aria-labelledby="sessionWarningModalLabel" aria-hidden="true">

            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-warning text-dark text-center">
                        <h5 class="modal-title w-100" id="sessionWarningModalLabel">
                            <i class="bi bi-exclamation-triangle-fill"></i> Su sesión está a punto de expirar
                        </h5>
                    </div>
                    <div class="modal-body">
                        <p class="text-center">Su sesión se cerrará automáticamente en:</p>
                        <h1 class="text-center display-4" id="sessionCountdown">15</h1>
                        <p class="text-center text-muted">Mueva el mouse o presione una tecla para continuar.</p>
                    </div>
                </div>
            </div>
        </div>
        <script src="../js/bootstrap.bundle.min.js"></script>
        <script src="../js/session-timer.js"></script>
        <script src="../js/portal-cliente.js"></script>
    </body>
</html>