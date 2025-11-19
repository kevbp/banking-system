<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <title>Consulta de Cuentas - Quantum Bank</title>
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/estilos.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/sidebar.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    </head>
    <body data-active-page="consultas-cuentas">
        <%@ include file="../util/theme.jsp" %>

        <div class="d-flex">
            <%@ include file="../util/sidebar.jsp" %>
            <div class="main-content flex-grow-1">
                <%@ include file="../util/header.jsp" %>

                <div class="content-area p-4">
                    <h4 class="mb-3 fw-bold text-dark">Consulta de Cuentas por Cliente</h4>

                    <div class="card shadow-sm border-0 mb-4">
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/ControlCuenta" method="get" class="row g-3 align-items-end">
                                <input type="hidden" name="accion" value="consultar">
                                <div class="col-md-5">
                                    <label class="form-label fw-bold text-muted small">DOCUMENTO DE IDENTIDAD</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-white"><i class="bi bi-person-vcard"></i></span>
                                        <input type="text" class="form-control" name="numDoc" 
                                               value="${numDocBusqueda}" placeholder="Ingrese DNI o RUC" required>
                                        <button class="btn btn-primary px-4 fw-bold" type="submit">Buscar</button>
                                    </div>
                                </div>
                            </form>
                            <c:if test="${not empty msgError}">
                                <div class="alert alert-warning mt-3 mb-0"><i class="bi bi-exclamation-triangle"></i> ${msgError}</div>
                            </c:if>
                        </div>
                    </div>

                    <c:if test="${not empty clienteNombre}">

                        <div class="card shadow-sm border-primary mb-4">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <small class="text-muted fw-bold">CLIENTE</small>
                                    <h4 class="text-primary mb-0">${clienteNombre}</h4>
                                </div>
                                <div class="text-end">
                                    <small class="text-muted fw-bold">DOCUMENTO</small>
                                    <div class="fs-5 font-monospace">${numDocBusqueda}</div>
                                </div>
                                <div class="text-end border-start ps-4">
                                    <small class="text-muted fw-bold">TOTAL CUENTAS</small>
                                    <div class="fs-4 fw-bold">${totalRegistros}</div>
                                </div>
                            </div>
                        </div>

                        <div class="card shadow-sm border-0">
                            <div class="card-header bg-white py-3">
                                <h6 class="mb-0 fw-bold">Listado de Productos</h6>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-hover align-middle mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th>N° Cuenta</th>
                                            <th>Producto</th>
                                            <th>Moneda</th>
                                            <th>Saldo Actual</th>
                                            <th>Fecha Apertura</th>
                                            <th>Estado</th>
                                            <th>Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty listaCuentas}">
                                            <tr><td colspan="7" class="text-center py-4 text-muted">Este cliente no tiene cuentas registradas.</td></tr>
                                        </c:if>

                                        <c:forEach var="c" items="${listaCuentas}">
                                            <tr>
                                                <td class="font-monospace fw-bold text-primary">${c.numCuenta}</td>
                                                <td>${c.desTipoCuenta}</td>
                                                <td>${c.desMoneda}</td>
                                                <td class="fw-bold">
                                                    ${c.codMoneda eq 'USD' ? '$' : 'S/'} 
                                        <fmt:formatNumber value="${c.salAct}" minFractionDigits="2" maxFractionDigits="2"/>
                                        </td>
                                        <td><fmt:formatDate value="${c.fecApe}" pattern="dd/MM/yyyy"/></td>
                                        <td>
                                            <span class="badge ${c.codEstado eq 'S0001' ? 'bg-success' : 'bg-secondary'}">
                                                ${c.desEstado}
                                            </span>
                                        </td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/ControlCuenta?accion=detalle&num=${c.numCuenta}" 
                                               class="btn btn-sm btn-outline-secondary" title="Ver Detalle">
                                                <i class="bi bi-eye"></i>
                                            </a>
                                        </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>

                            <c:if test="${totalPages > 1}">
                                <div class="card-footer bg-white py-3">
                                    <nav aria-label="Paginación de cuentas">
                                        <ul class="pagination justify-content-center mb-0">
                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link" href="ControlCuenta?accion=consultar&numDoc=${numDocBusqueda}&page=${currentPage - 1}">Anterior</a>
                                            </li>

                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                    <a class="page-link" href="ControlCuenta?accion=consultar&numDoc=${numDocBusqueda}&page=${i}">${i}</a>
                                                </li>
                                            </c:forEach>

                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link" href="ControlCuenta?accion=consultar&numDoc=${numDocBusqueda}&page=${currentPage + 1}">Siguiente</a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </c:if>
                        </div>
                    </c:if>

                </div>
            </div>
        </div>

        <%@ include file="../util/cont-sesion.jsp" %>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sidebar.js"></script>
        <script src="${pageContext.request.contextPath}/js/session-timer.js"></script>
    </body>
</html>