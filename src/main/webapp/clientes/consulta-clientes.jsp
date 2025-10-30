<%-- 
    Document   : consulta-clientes
    Created on : Oct 12, 2025, 5:20:02 PM
    Author     : kevin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <script src="${pageContext.request.contextPath}/js/color-modes.js"></script>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/sidebars.css" rel="stylesheet">
        <title>Consulta de clientes</title>
    </head>
    <body>
        <%@ include file="../util/theme.jsp" %>
        <div class="d-flex">
            <%@ include file="../util/sidebar.jsp" %>
            <div class="container mt-5 mb-4">
                <div class="card shadow-sm">
                    <div class="card-header bg-dark text-light text-center">
                        <h4 class="mb-0">Consulta de Clientes</h4>
                    </div>

                    <div class="card-body">
                        <p class="text-muted">Busque clientes registrados por tipo de documento, número o nombre.</p>
                        <hr>

                        <!-- Formulario de búsqueda -->
                        <form action="${pageContext.request.contextPath}/ControlCliente" method="post" class="mb-4">
                            <input type="hidden" name="accion" value="Consultar">
                            <div class="row g-3 align-items-end">

                                <div class="col-md-3">
                                    <label for="tipoDoc" class="form-label">Tipo de Documento</label>
                                    <select class="form-select" id="tipoDoc" name="tipoDoc">
                                        <option value="">Todos</option>
                                        <option value="DNI">DNI</option>
                                        <option value="RUC">RUC</option>
                                    </select>
                                </div>

                                <div class="col-md-3">
                                    <label for="numDoc" class="form-label">Número de Documento</label>
                                    <input type="text" class="form-control" id="numDoc" name="numDoc" placeholder="Ingrese número">
                                </div>

                                <div class="col-md-4">
                                    <label for="nombre" class="form-label">Nombre / Razón Social</label>
                                    <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Ingrese nombre o razón social">
                                </div>

                                <div class="col-md-2 d-grid">
                                    <button type="submit" class="btn btn-success">Buscar</button>
                                </div>

                            </div>
                        </form>

                        <hr>

                        <!-- Resultados -->
                        <h5 class="mb-3">Resultados de la Búsqueda</h5>

                        <div class="table-responsive">
                            <table class="table table-bordered table-striped align-middle">
                                <thead class="table-primary text-center">
                                    <tr>
                                        <th>Código</th>
                                        <th>Tipo Doc</th>
                                        <th>Número Doc</th>
                                        <th>Nombre / Razón Social</th>
                                        <th>Celular</th>
                                        <th>Correo</th>
                                        <th>Estado</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="item" items="${requestScope.lista}">
                                    <!-- Ejemplo de datos estáticos (se reemplaza por datos del servlet o JSTL) -->
                                    <tr>
                                        <td>${item[0]}</td>
                                        <td>${item[1]}</td>
                                        <td>${item[2]}</td>
                                        <td>${item[3]}</td>
                                        <td>${item[4]}</td>
                                        <td>${item[5]}</td>
                                        <td>${item[7]}</td>
                                        <td class="text-center">
                                            <a href="verCliente.jsp?cod=CLI001" class="btn btn-sm btn-info">Ver</a>
                                            <a href="editarCliente.jsp?cod=CLI001" class="btn btn-sm btn-warning">Editar</a>
                                        </td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>

                        <div class="text-center mt-3">
                            <a href="${pageContext.request.contextPath}/home.jsp" class="btn btn-secondary px-4">Volver al Panel</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sidebars.js"></script>
    </body>
</html>
