<%-- 
  Document   : dashboard-cliente.jsp
  Ubicación  : /modulo-cliente/dashboard-cliente.jsp
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Mis Cuentas - Quantum Bank</title>

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-global.css"/> 
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css"/> 
    </head>

    <body data-active-page="inicio" class="client-portal-body">

        <%@ include file="../util/header-cliente.jsp" %>

        <div class="tc-banner">
            <div class="container-fluid px-4">
                <i class="bi bi-graph-up me-1"></i>
                <strong>T.C. Referencial:</strong> Compra S/ 3.314 | Venta S/ 3.414
            </div>
        </div>


        <div class="container-fluid p-4 client-portal-content">

            <h2 class="h4 fw-bold mb-4">Bienvenido, Juan Pérez</h2>

            <div class="row h-100 g-4">

                <div class="col-lg-8 h-100 d-flex flex-column dashboard-account-column">

                    <h3 class="h5 fw-semibold mb-3">Mis Cuentas</h3>

                    <div class="account-list-scrollable">
                        <a href="detalle-cuenta.jsp" class="card account-card-horizontal text-decoration-none mb-3">
                            <div class="card-body d-flex align-items-center p-3">
                                <div class="icon-wrapper bg-success-subtle text-success">
                                    <i class="bi bi-currency-dollar"></i>
                                </div>
                                <div class="card-info mx-3">
                                    <span class="account-type">Cuenta de Ahorros</span>
                                    <span class="account-number">N° 001-XXXX-001</span>
                                </div>
                                <div class="card-balance ms-auto text-end">
                                    <span class="balance-label">Soles</span>
                                    <span class="balance-amount">S/ 1,250.50</span>
                                </div>
                            </div>
                        </a>
                        <a href="detalle-cuenta.jsp" class="card account-card-horizontal text-decoration-none mb-3">
                            <div class="card-body d-flex align-items-center p-3">
                                <div class="icon-wrapper bg-primary-subtle text-primary"><i class="bi bi-currency-dollar"></i></div>
                                <div class="card-info mx-3">
                                    <span class="account-type">Cuenta Corriente</span>
                                    <span class="account-number">N° 002-XXXX-002</span>
                                </div>
                                <div class="card-balance ms-auto text-end">
                                    <span class="balance-label">Dólares</span>
                                    <span class="balance-amount">$ 300.00</span>
                                </div>
                            </div>
                        </a>
                        <a href="detalle-cuenta.jsp" class="card account-card-horizontal text-decoration-none mb-3">
                            <div class="card-body d-flex align-items-center p-3">
                                <div class="icon-wrapper bg-warning-subtle text-warning"><i class="bi bi-clock-history"></i></div>
                                <div class="card-info mx-3">
                                    <span class="account-type">Cuenta Plazo Fijo</span>
                                    <span class="account-number">N° 003-XXXX-003</span>
                                </div>
                                <div class="card-balance ms-auto text-end">
                                    <span class="balance-label">Soles</span>
                                    <span class="balance-amount">S/ 10,000.00</span>
                                </div>
                            </div>
                        </a>
                        <a href="detalle-cuenta.jsp" class="card account-card-horizontal text-decoration-none mb-3">
                            <div class="card-body d-flex align-items-center p-3">
                                <div class="icon-wrapper bg-success-subtle text-success"><i class="bi bi-currency-dollar"></i></div>
                                <div class="card-info mx-3">
                                    <span class="account-type">Cuenta de Ahorros 2</span>
                                    <span class="account-number">N° 001-XXXX-004</span>
                                </div>
                                <div class="card-balance ms-auto text-end">
                                    <span class="balance-label">Soles</span>
                                    <span class="balance-amount">S/ 500.00</span>
                                </div>
                            </div>
                        </a>
                    </div> 

                </div> <div class="col-lg-4 d-flex flex-column h-100">
                    <div class="card shadow-sm border-0 quick-actions-card d-flex flex-column h-100">
                        <div class="card-body p-4"> <h5 class="fw-semibold mb-3">Operaciones</h5>

                            <div class="row g-2 mb-4">
                                <div class="col-4"><a href="${pageContext.request.contextPath}/modulo-clientes/operaciones/transferencia.jsp" class="btn action-grid-btn"><i class="bi bi-arrow-left-right"></i><span>Transferir</span></a></div>
                                <div class="col-4"><a href="${pageContext.request.contextPath}/modulo-clientes/operaciones/deposito.jsp" class="btn action-grid-btn"><i class="bi bi-box-arrow-in-down"></i><span>Depositar</span></a></div>
                                <div class="col-4"><a href="${pageContext.request.contextPath}/modulo-clientes/operaciones/retiro.jsp" class="btn action-grid-btn"><i class="bi bi-cash"></i><span>Retirar</span></a></div>
                            </div>

                            <hr>

                            <h5 class="fw-semibold mb-3">Cuentas Favoritas</h5>

                            <div class="favorite-list-scrollable">
                                <div class="list-group list-group-flush favorite-list">
                                    <a href="#" class="list-group-item list-group-item-action favorite-account-item">
                                        <div class="avatar-initial bg-primary text-white">M</div>
                                        <div class="favorite-info">
                                            <span class="fw-medium">Maria Lopez</span>
                                            <small class="text-muted">BCP - Ahorros Soles</small>
                                        </div>
                                    </a>
                                    <a href="#" class="list-group-item list-group-item-action favorite-account-item">
                                        <div class="avatar-initial bg-success text-white">R</div>
                                        <div class="favorite-info">
                                            <span class="fw-medium">Raul Gomez</span>
                                            <small class="text-muted">Interbank - Corriente Dólares</small>
                                        </div>
                                    </a>
                                    <a href="#" class="list-group-item list-group-item-action favorite-account-item">
                                        <div class="avatar-initial bg-warning text-dark">E</div>
                                        <div class="favorite-info">
                                            <span class="fw-medium">Empresa SAC</span>
                                            <small class="text-muted">Quantum Bank - Corriente Soles</small>
                                        </div>
                                    </a>
                                    <a href="#" class="list-group-item list-group-item-action favorite-account-item">
                                        <div class="avatar-initial bg-danger text-white">P</div>
                                        <div class="favorite-info">
                                            <span class="fw-medium">Papá</span>
                                            <small class="text-muted">BBVA - Ahorros Soles</small>
                                        </div>
                                    </a>
                                    <a href="#" class="list-group-item list-group-item-action favorite-account-item">
                                        <div class="avatar-initial bg-info text-white">L</div>
                                        <div class="favorite-info">
                                            <span class="fw-medium">Luis (Alquiler)</span>
                                            <small class="text-muted">Scotiabank - Ahorros Soles</small>
                                        </div>
                                    </a>
                                    <a href="#" class="list-group-item list-group-item-action favorite-account-item">
                                        <div class="avatar-initial bg-dark text-white">J</div>
                                        <div class="favorite-info">
                                            <span class="fw-medium">Javier (Pago)</span>
                                            <small class="text-muted">Yape / PLIN</small>
                                        </div>
                                    </a>
                                    <a href="#" class="list-group-item list-group-item-action favorite-account-item">
                                        <div class="avatar-initial bg-secondary text-white">A</div>
                                        <div class="favorite-info">
                                            <span class="fw-medium">Ana G.</span>
                                            <small class="text-muted">BCP - Ahorros Dólares</V>
                                        </div>
                                    </a>
                                </div>
                            </div>

                        </div>
                    </div>
                </div> </div> </div> <%@ include file="../util/cont-sesion.jsp" %>

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/session-timer.js"></script>
        <script src="${pageContext.request.contextPath}/js/portal-cliente.js"></script>
    </body>
</html>