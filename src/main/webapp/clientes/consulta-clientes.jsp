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

                        <!-- 🔍 Formulario de búsqueda -->
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

                        <!-- 📋 Resultados -->
                        <h5 class="mb-3">Resultados de la Búsqueda</h5>

                        <div class="table-responsive">
                            <table class="table table-bordered table-striped align-middle">
                                <thead class="table-dark text-center">
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
                                        <tr>
                                            <td>${item[0]}</td>
                                            <td>${item[1]}</td>
                                            <td>${item[2]}</td>
                                            <td>${item[3]}</td>
                                            <td>${item[4]}</td>
                                            <td>${item[5]}</td>
                                            <td>${item[7]}</td>
                                            <td class="text-center">
                                                <!-- Botón Editar -->
                                                <button class="btn btn-sm btn-warning"
                                                        data-bs-toggle="modal"
                                                        data-bs-target="#modalEditarCliente"
                                                        data-id="${item[0]}"
                                                        data-tipo="${item[1]}"
                                                        data-numdoc="${item[2]}"
                                                        data-nombre="${item[3]}"
                                                        data-celular="${item[4]}"
                                                        data-correo="${item[5]}"
                                                        data-estado="${item[7]}">
                                                    Editar
                                                </button>

                                                <!-- Botón Desactivar -->
                                                <button class="btn btn-sm btn-danger"
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
            </div>
        </div>

        <!-- 🪟 Modal Editar Cliente -->
        <div class="modal fade" id="modalEditarCliente" tabindex="-1" aria-labelledby="modalEditarClienteLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title" id="modalEditarClienteLabel">Editar Cliente</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/ControlCliente" method="post">
                        <input type="hidden" name="accion" value="Actualizar">
                        <input type="hidden" id="idCliente" name="idCliente">
                        <div class="modal-body">
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label class="form-label">Tipo Documento</label>
                                    <input type="text" class="form-control" id="tipoDocEditar" name="tipoDocEditar" readonly>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Número Documento</label>
                                    <input type="text" class="form-control" id="numDocEditar" name="numDocEditar" readonly>
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Estado</label>
                                    <select class="form-select" id="estadoEditar" name="estadoEditar">
                                        <option value="Activo">Activo</option>
                                        <option value="Inactivo">Inactivo</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Nombre / Razón Social</label>
                                    <input type="text" class="form-control" id="nombreEditar" name="nombreEditar" readonly>
                                </div>
                                <div class="col-md-2">
                                    <label class="form-label">Celular</label>
                                    <input type="text" class="form-control" id="celularEditar" name="celularEditar">
                                </div>
                                <div class="col-md-4">
                                    <label class="form-label">Correo</label>
                                    <input type="email" class="form-control" id="correoEditar" name="correoEditar">
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

        <!-- 🪟 Modal Desactivar Cliente -->
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

        <!-- Scripts -->
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sidebars.js"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script>
            $(document).ready(function () {
                // Modal Editar Cliente
                $('#modalEditarCliente').on('show.bs.modal', function (event) {
                    var button = $(event.relatedTarget);
                    $('#idCliente').val(button.data('id'));
                    $('#tipoDocEditar').val(button.data('tipo'));
                    $('#numDocEditar').val(button.data('numdoc'));
                    $('#nombreEditar').val(button.data('nombre'));
                    $('#celularEditar').val(button.data('celular'));
                    $('#correoEditar').val(button.data('correo'));
                    $('#estadoEditar').val(button.data('estado'));
                    $('#modalEditarClienteLabel').text('Editar Cliente: ' + button.data('nombre'));
                });

                // Modal Desactivar Cliente
                $('#modalDesactivarCliente').on('show.bs.modal', function (event) {
                    var button = $(event.relatedTarget);
                    $('#idClienteDesactivar').val(button.data('id'));
                    $('#nombreClienteDesactivar').text(button.data('nombre'));
                });
            });
        </script>
    </body>

</html>
