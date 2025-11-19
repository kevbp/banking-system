<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Mis Cuentas - Quantum Bank</title>

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/portal-global.css"/> 
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css"/> 

        <style>
            /* Estilos inline para asegurar el diseño amigable sin depender de archivos externos nuevos */
            body {
                background-color: #f8f9fa;
                font-family: 'Poppins', sans-serif;
            }

            .welcome-section {
                background: linear-gradient(135deg, #0d6efd 0%, #0043a8 100%);
                color: white;
                border-radius: 1rem;
                padding: 2rem;
                margin-bottom: 2rem;
                box-shadow: 0 4px 15px rgba(13, 110, 253, 0.2);
            }

            /* Tarjetas de Cuenta */
            .account-card {
                border: none;
                border-radius: 1rem;
                transition: transform 0.2s, box-shadow 0.2s;
                overflow: hidden;
                background: white;
                height: 100%;
                position: relative;
            }

            .account-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.08);
                cursor: pointer;
            }

            /* Decoración lateral de las tarjetas según tipo */
            .card-decoration {
                position: absolute;
                left: 0;
                top: 0;
                bottom: 0;
                width: 6px;
            }
            .type-ahorro {
                background-color: #198754;
            }    /* Verde */
            .type-corriente {
                background-color: #0d6efd;
            } /* Azul */
            .type-plazo {
                background-color: #ffc107;
            }     /* Amarillo */

            .card-icon-bg {
                width: 48px;
                height: 48px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
            }

            /* Panel Lateral de Acciones */
            .quick-actions-card {
                border-radius: 1rem;
                border: none;
                background: white;
            }

            .action-btn {
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                padding: 1rem;
                border-radius: 0.8rem;
                background-color: #f8f9fa;
                color: #495057;
                text-decoration: none;
                transition: all 0.2s;
                border: 1px solid #e9ecef;
                height: 100%;
            }

            .action-btn:hover {
                background-color: #e7f1ff;
                color: #0d6efd;
                border-color: #0d6efd;
            }

            .action-btn i {
                font-size: 1.5rem;
                margin-bottom: 0.5rem;
            }
            .action-btn span {
                font-size: 0.85rem;
                font-weight: 500;
            }

            .section-title {
                font-size: 1.1rem;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 1rem;
                display: flex;
                align-items: center;
            }
        </style>
    </head>

    <body data-active-page="inicio" class="client-portal-body">

        <%@ include file="../util/header-cliente.jsp" %>

        <div class="container py-4">

            <div class="welcome-section d-flex align-items-center justify-content-between">
                <div>
                    <h1 class="h3 fw-bold mb-1">Hola, ${sessionScope.nombreClienteReal} 👋</h1>
                    <p class="mb-0 opacity-75">Bienvenido a tu banca digital. Aquí tienes el resumen de tus productos.</p>
                </div>
                <div class="d-none d-md-block">
                    <i class="bi bi-shield-check display-4 opacity-50"></i>
                </div>
            </div>

            <div class="row g-4">

                <div class="col-lg-8">
                    <div class="section-title">
                        <i class="bi bi-wallet2 me-2 text-primary"></i> Mis Cuentas
                    </div>

                    <div class="row g-3">
                        <c:forEach var="c" items="${misCuentas}">
                            <c:set var="esPlazo" value="${c.desTipoCuenta.toLowerCase().contains('plazo')}" />
                            <c:set var="esCorriente" value="${c.desTipoCuenta.toLowerCase().contains('corriente')}" />
                            <c:set var="bgIconClass" value="${esPlazo ? 'bg-warning-subtle text-warning-emphasis' : (esCorriente ? 'bg-primary-subtle text-primary' : 'bg-success-subtle text-success')}" />
                            <c:set var="borderClass" value="${esPlazo ? 'type-plazo' : (esCorriente ? 'type-corriente' : 'type-ahorro')}" />
                            <c:set var="iconClass" value="${esPlazo ? 'bi-piggy-bank' : (esCorriente ? 'bi-briefcase' : 'bi-wallet-fill')}" />

                            <div class="col-md-6">
                                <a href="${pageContext.request.contextPath}/ControlLoginCliente?accion=detalle&num=${c.numCuenta}" class="text-decoration-none text-dark">
                                    <div class="card account-card shadow-sm h-100">
                                        <div class="card-decoration ${borderClass}"></div>
                                        <div class="card-body p-4">
                                            <div class="d-flex align-items-start justify-content-between mb-3">
                                                <div class="card-icon-bg ${bgIconClass}">
                                                    <i class="bi ${iconClass}"></i>
                                                </div>
                                                <span class="badge bg-light text-dark border">${c.desMoneda}</span>
                                            </div>

                                            <h6 class="card-subtitle text-muted small text-uppercase fw-bold mb-1">${c.desTipoCuenta}</h6>
                                            <div class="h4 fw-bold mb-0 text-truncate">
                                                ${c.codMoneda eq 'USD' ? '$' : 'S/'} 
                                                <fmt:formatNumber value="${c.salAct}" minFractionDigits="2" maxFractionDigits="2"/>
                                            </div>
                                            <small class="text-muted font-monospace">**** ${c.numCuenta.substring(Math.max(0, c.numCuenta.length() - 4))}</small>

                                            <div class="mt-3 pt-3 border-top d-flex align-items-center text-primary small fw-medium">
                                                Ver movimientos <i class="bi bi-arrow-right ms-auto"></i>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>

                        <c:if test="${empty misCuentas}">
                            <div class="col-12">
                                <div class="alert alert-light border text-center py-5 shadow-sm rounded-4">
                                    <div class="mb-3">
                                        <div class="bg-light d-inline-flex p-3 rounded-circle">
                                            <i class="bi bi-layers text-muted h1 mb-0"></i>
                                        </div>
                                    </div>
                                    <h5 class="fw-bold text-muted">Aún no tienes cuentas activas</h5>
                                    <p class="text-muted mb-4">¡Comienza hoy mismo abriendo tu primera cuenta digital!</p>
                                    <a href="${pageContext.request.contextPath}/modulo-clientes/productos/apertura-cuenta.jsp" class="btn btn-primary px-4 py-2 rounded-pill">
                                        <i class="bi bi-plus-lg me-2"></i>Abrir una Cuenta
                                    </a>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div> 

                <div class="col-lg-4">

                    <div class="mb-4">
                        <div class="section-title">
                            <i class="bi bi-lightning-charge me-2 text-warning"></i> ¿Qué quieres hacer?
                        </div>
                        <div class="card quick-actions-card shadow-sm p-3">
                            <div class="row g-2">
                                <div class="col-4">
                                    <a href="${pageContext.request.contextPath}/modulo-clientes/operaciones/transferencia.jsp" class="action-btn">
                                        <i class="bi bi-arrow-left-right"></i>
                                        <span>Transferir</span>
                                    </a>
                                </div>
                                <div class="col-4">
                                    <a href="${pageContext.request.contextPath}/ControlDepositoCliente?accion=vista" class="action-btn">
                                        <i class="bi bi-box-arrow-in-down"></i>
                                        <span>Depositar</span>
                                    </a>
                                </div>
                                <div class="col-4">
                                    <a href="${pageContext.request.contextPath}/modulo-clientes/operaciones/retiro.jsp" class="action-btn">
                                        <i class="bi bi-cash-coin"></i>
                                        <span>Retirar</span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div>
                        <div class="section-title">
                            <i class="bi bi-star me-2 text-danger"></i> Favoritos
                        </div>
                        <div class="card quick-actions-card shadow-sm">
                            <div class="list-group list-group-flush rounded-3">
                                <a href="#" class="list-group-item list-group-item-action d-flex align-items-center p-3 border-0">
                                    <div class="bg-primary-subtle text-primary rounded-circle d-flex align-items-center justify-content-center me-3" style="width: 40px; height: 40px; font-weight: 600;">
                                        M
                                    </div>
                                    <div class="flex-grow-1 line-height-sm">
                                        <div class="fw-medium">Maria Lopez</div>
                                        <small class="text-muted" style="font-size: 0.8rem;">BCP - Ahorros Soles</small>
                                    </div>
                                    <i class="bi bi-chevron-right text-muted small"></i>
                                </a>
                                <a href="#" class="list-group-item list-group-item-action text-center text-muted small py-3 border-top">
                                    Ver todos los favoritos
                                </a>
                            </div>
                        </div>
                    </div>

                </div> 
            </div> 
        </div> 

        <%@ include file="../util/cont-sesion.jsp" %>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/session-timer.js"></script>
        <script src="${pageContext.request.contextPath}/js/portal-cliente.js"></script>
    </body>
</html>