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

        <link rel="stylesheet" href="../css/portal-global.css"/> 
        <link rel="stylesheet" href="../css/detalle-cuenta.css"/> 
    </head>

    <body data-active-page="cuentas" class="client-portal-body">

        <%@ include file="../util/header-cliente.jsp" %>

        <div class="tc-banner">
            <div class="container-fluid px-4">
                <i class="bi bi-graph-up me-1"></i>
                <strong>T.C. Referencial:</strong> Compra S/ 3.314 | Venta S/ 3.414
            </div>
        </div>

        <div class="container-fluid p-4 client-portal-content">

            <div class="row h-100 g-4">

                <div class="col-lg-4 d-flex flex-column h-100 details-column">

                    <div class="mb-3">
                        <a href="dashboard-cliente.jsp" class="btn btn-link text-decoration-none p-0 btn-volver">
                            <i class="bi bi-arrow-left me-1"></i>
                            Volver a Mis Cuentas
                        </a>
                    </div>

                    <div class="card shadow-sm border-0 mb-4">
                        <div class="card-body p-3">
                            <div class="dropdown w-100 account-selector-dropdown">
                                <button class="btn btn-light dropdown-toggle w-100 d-flex justify-content-between align-items-center" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                    <span class="fw-medium">Cta. Ahorros Soles (001...2345)</span>
                                </button>
                                <ul class="dropdown-menu w-100" aria-labelledby="dropdownMenuButton1">
                                    <li>
                                        <a class="dropdown-item" href="#">
                                            <span class="d-block">Cta. Corriente Dólares (002...5678)</span>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="card shadow-sm border-0 mb-4">
                        <div class="card-body p-4 d-flex flex-wrap justify-content-between align-items-center">
                            <div class_ ="me-3">
                                <h2 class="h6 text-muted fw-normal mb-1">Saldo Disponible</h2>
                                <h1 class="h1 fw-bold text-success mb-0">S/ 1,250.50</h1>
                            </div>
                            <div class="movements-actions-group">
                                <a href="transferencia.jsp" class="btn btn-sm btn-outline-primary" data-bs-toggle="tooltip" title="Transferir">
                                    <i class="bi bi-arrow-left-right"></i>
                                </a>
                                <a href="retiro.jsp" class="btn btn-sm btn-outline-secondary" data-bs-toggle="tooltip" title="Retirar">
                                    <i class="bi bi-cash"></i>
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="card shadow-sm border-0">
                        <div class="card-body p-4">
                            <ul class="list-unstyled account-details">
                                <li class="account-copy-item">
                                    <div class="account-copy-text">
                                        <span>Número de cuenta</span>
                                        <strong id="textNroCuenta">001-00012345</strong>
                                        <strong id="textCCI" class="text-muted">CCI: 0020010001234501</strong>
                                    </div>
                                    <div class="account-copy-button">
                                        <button class="btn btn-copy" 
                                                id="btnCopiarCuentas"
                                                data-bs-toggle="tooltip" 
                                                data-bs-placement="top" 
                                                data-bs-title="¡Copiado!" 
                                                data-bs-trigger="click">
                                            <i class="bi bi-clipboard"></i> Copiar
                                        </button>
                                    </div>
                                </li>
                                <li>
                                    <span>Titular:</span>
                                    <strong>Juan Pérez</strong>
                                </li>
                                <li>
                                    <span>Tasa (TEA):</span>
                                    <strong>1.50%</strong>
                                </li>
                                <li>
                                    <span>Estado:</span>
                                    <strong class="text-success">Activa</strong>
                                </li>
                                <li>
                                    <span>Embargo:</span>
                                    <strong class="text-muted">No</strong>
                                </li>
                                <li>
                                    <span>Fecha Apertura:</span>
                                    <strong>10/05/2024</strong>
                                </li>
                            </ul>
                        </div>
                    </div>

                </div> 
                <div class="col-lg-8 d-flex flex-column h-100">
                    <div class="card shadow-sm border-0 h-100 d-flex flex-column">
                        <div class="card-body p-4 d-flex flex-column flex-grow-1">
                            <h5 class="card-title fw-semibold mb-3">Últimos Movimientos</h5>
                            <div class="table-responsive movements-scrollable">
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
                                        <tr><td>12/11/25</td><td><span class="d-block fw-medium">Depósito en Agente</span><span class="d-block small text-muted">Agente K-0012</span></td><td class="text-end text-success fw-medium">+ S/ 50.00</td><td class="text-end">S/ 1,250.50</td></tr>
                                        <tr><td>11/11/25</td><td><span class="d-block fw-medium">Pago de Servicio (Netflix)</span><span class="d-block small text-muted">Cod. 12345</span></td><td class="text-end text-danger fw-medium">- S/ 44.90</td><td class="text-end">S/ 1,200.50</td></tr>
                                        <tr><td>10/11/25</td><td><span class="d-block fw-medium">Transferencia a Terceros</span><span class="d-block small text-muted">Cta. 001-XXXX-002</span></td><td class="text-end text-danger fw-medium">- S/ 100.00</td><td class="text-end">S/ 1,245.40</td></tr>
                                        <tr><td>09/11/25</td><td><span class="d-block fw-medium">Depósito (Sueldo)</span><span class="d-block small text-muted">Empresa SAC</span></td><td class="text-end text-success fw-medium">+ S/ 800.00</td><td class="text-end">S/ 1,345.40</td></tr>
                                        <tr><td>08/11/25</td><td><span class="d-block fw-medium">Retiro en ATM</span><span class="d-block small text-muted">Cajero AT-034</span></td><td class="text-end text-danger fw-medium">- S/ 200.00</td><td class="text-end">S/ 545.40</td></tr>
                                        <tr><td>05/11/25</td><td><span class="d-block fw-medium">Compra en POS</span><span class="d-block small text-muted">WONG</span></td><td class="text-end text-danger fw-medium">- S/ 150.20</td><td class="text-end">S/ 745.40</td></tr>
                                        <tr><td>02/11/25</td><td><span class="d-block fw-medium">Depósito en Agente</span><span class="d-block small text-muted">Agente K-0012</span></td><td class="text-end text-success fw-medium">+ S/ 50.00</td><td class="text-end">S/ 895.60</td></tr>
                                        <tr><td>01/11/25</td><td><span class="d-block fw-medium">Retiro en ATM</span><span class="d-block small text-muted">Cajero AT-011</span></td><td class="text-end text-danger fw-medium">- S/ 100.00</td><td class="text-end">S/ 845.60</td></tr>
                                        <tr><td>30/10/25</td><td><span class="d-block fw-medium">Pago de Servicio (Luz)</span><span class="d-block small text-muted">Cod. 67890</span></td><td class="text-end text-danger fw-medium">- S/ 80.00</td><td class="text-end">S/ 945.60</td></tr>
                                        <tr><td>28/10/25</td><td><span class="d-block fw-medium">Depósito en Ventanilla</span><span class="d-block small text-muted">Agencia Central</span></td><td class="text-end text-success fw-medium">+ S/ 200.00</td><td class="text-end">S/ 1,025.60</td></tr>
                                        <tr><td>25/10/25</td><td><span class="d-block fw-medium">Transferencia Recibida</span><span class="d-block small text-muted">Cta. 003-XXXX-009</span></td><td class="text-end text-success fw-medium">+ S/ 300.00</td><td class="text-end">S/ 825.60</td></tr>
                                        <tr><td>22/10/25</td><td><span class="d-block fw-medium">Retiro en ATM</span><span class="d-block small text-muted">Cajero AT-034</span></td><td class="text-end text-danger fw-medium">- S/ 100.00</td><td class="text-end">S/ 525.60</td></tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                </div> </div> </div> <%@ include file="../util/cont-sesion.jsp" %>

        <script src="../js/bootstrap.bundle.min.js"></script>
        <script src="../js/session-timer.js"></script>
        <script src="../js/portal-cliente.js"></script>
        <script src="../js/detalle-cuenta.js"></script>
    </body>
</html>