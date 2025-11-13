<%-- 
    Document   : consulta-clientes
    Created on : Oct 12, 2025, 5:20:02 PM
    Author     : kevin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Consulta de Clientes - Quantum Bank</title>

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/estilos.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/sidebar.css" rel="stylesheet"> <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    </head>

    <body data-active-page="clientes-consulta">

        <%@ include file="../util/theme.jsp" %>

        <div class="d-flex">
            <%@ include file="../util/sidebar.jsp" %>

            <div class="main-content flex-grow-1">
                <%@ include file="../util/header.jsp" %>

                <div class="content-area p-4">

                    <div class="card shadow-sm border-0">
                        <div class="card-header bg-dark text-light text-center">
                            <h4 class="mb-0">Consulta de Clientes</h4>
                        </div>

                        <div class="card-body p-4">
                            <p class="text-muted">Busque clientes registrados por tipo de documento, número o nombre.</p>
                            <hr>

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
                                        <button type="submit" class="btn btn-primary">
                                            <i class="bi bi-search me-1"></i> Buscar
                                        </button>
                                    </div>
                                </div>
                            </form>

                            <hr>

                            <h5 class="mb-3">Resultados de la Búsqueda</h5>

                            <div class="table-responsive">
                                <table class="table table-bordered table-striped align-middle">
                                    <thead class="table-light text-center"> <tr>
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
                                            <tr>
                                                <td>${item[0]}</td>
                                                <td>${item[1]}</td>
                                                <td>${item[2]}</td>
                                                <td>${item[3]}</td>
                                                <td>${item[4]}</td>
                                                <td>${item[5]}</td>
                                                <td>${item[7]}</td>
                                                <td class="text-center">
                                                    <form action="${pageContext.request.contextPath}/ControlCliente" method="post" class="d-inline">
                                                        <input type="hidden" name="accion" value="Detalle">
                                                        <input type="hidden" name="id" value="${item[0]}"/>
                                                        <button type="submit" class="btn btn-sm btn-outline-warning">Editar</button>
                                                    </form>

                                                    <button class="btn btn-sm btn-outline-danger"
                                                            data-bs-toggle="modal"
                                                            data-bs-target="#modalDesactivarCliente"
                                                            data-id="${item[0]}"
                                                            data-nombre="${item[3]}">
                                                        Desactivar
                                                    </button>
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
                </div> </div> </div>

        <div class="modal fade" id="modalEditarCliente" tabindex="-1" aria-labelledby="modalEditarClienteLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title" id="modalEditarClienteLabel">Editar Cliente</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <c:set var="cli" value="${requestScope.cliente}"/>
                    <form action="${pageContext.request.contextPath}/ControlCliente" method="post">
                        <input type="hidden" name="accion" value="Actualizar">
                        <input type="hidden" id="idCliente" name="idCliente" value="${cli[0]}">
                        <div class="modal-body">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label class="form-label">Tipo Documento</label>
                                    <input type="text" class="form-control" id="tipoDocEditar" name="tipoDocEditar" value="${cli[1]}" readonly>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Número Documento</label>
                                    <input type="text" class="form-control" id="numDocEditar" name="numDocEditar" value="${cli[2]}" readonly>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Estado</label>
                                    <select class="form-select" id="estado" name="estado">
                                        <c:forEach var="eu" items="${estUsu}">
                                            <option value="${eu.codEstado}" <c:if test="${eu.codEstado == cli[6]}"> selected </c:if>>${eu.des}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Nombre / Razón Social</label>
                                    <input type="text" class="form-control" id="nombreEditar" name="nombreEditar" value="${cli[3]}" readonly>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Fecha de Nacimiento</label>
                                    <input type="date" class="form-control" id="fechaNacimiento" name="fechaNacimiento" value="${cli[8]}">
                                </div>
                                <div class="col-md-12">
                                    <label class="form-label">Dirección</label>
                                    <input type="text" class="form-control" id="direccion" name="direccion" value="${cli[9]}" placeholder="Ingrese dirección completa">
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Teléfono</label>
                                    <input type="text" class="form-control" id="telefono" name="telefono" value="${cli[11]}" placeholder="Ej. 012345678">
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Celular</label>
                                    <input type="text" class="form-control" id="celular" name="celular" value="${cli[4]}">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Correo</label>
                                    <input type="email" class="form-control" id="correo" name="correo" value="${cli[5]}">
                                </div>
                                <c:set var="d" value="${sessionScope.region}"/>
                                <div class="col-md-4">
                                    <label class="form-label">Departamento</label>
                                    <select class="form-select" id="region" name="region">
                                        <option value="">Seleccione...</option>
                                        <c:forEach var="reg" items="${d}">
                                            <option value="${reg}" <c:if test="${reg == cli[12]}"> selected </c:if>>${reg}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Provincia</label>
                                    <select class="form-select" id="provincia" name="provincia">
                                        <option value="">Seleccione</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Distrito</label>
                                    <select class="form-select" id="distrito" name="distrito">
                                        <option value="">Seleccione</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="modal fade" id="modalDesactivarCliente" tabindex="-1" aria-labelledby="modalDesactivarClienteLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header bg-danger text-light">
                        <h5 class="modal-title" id="modalDesactivarClienteLabel">Confirmar Desactivación</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/ControlCliente" method="post">
                        <input type="hidden" name="accion" value="Desactivar">
                        <input type="hidden" id="idClienteDesactivar" name="idClienteDesactivar">
                        <div class="modal-body">
                            <p>¿Está seguro de que desea desactivar al cliente <strong id="nombreClienteDesactivar"></strong>?</p>
                        </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-danger">Sí, desactivar</button>
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <c:set var="provinciaGuardada" value="${cli[13]}"/>
        <c:set var="distritoGuardado" value="${cli[14]}"/>

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>

        <script src="${pageContext.request.contextPath}/js/sidebar.js"></script>

        <script>
        const contextPath = "${pageContext.request.contextPath}";

        // CAMBIO: Movido de los scripts de abajo para unificar
        const PROVINCIA_CLIENTE = '${provinciaGuardada}';
        const DISTRITO_CLIENTE = '${distritoGuardado}';
        const ES_MODO_EDICION_CLIENTE = true;
        </script>

        <script src="${pageContext.request.contextPath}/js/ubigeo.js"></script>

        <script src="${pageContext.request.contextPath}/js/consulta-clientes.js"></script>

        <c:if test="${requestScope.abrirModalEditar == '1'}">
            <script>
            document.addEventListener('DOMContentLoaded', function () {
                new bootstrap.Modal(document.getElementById('modalEditarCliente')).show();
            });
            </script>
        </c:if>
    </body>
</html>