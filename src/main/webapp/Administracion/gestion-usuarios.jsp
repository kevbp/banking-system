<%-- 
    Document   : gestion-usuarios
    Created on : Oct 12, 2025, 7:31:40 PM
    Author     : kevin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <script src="${pageContext.request.contextPath}/js/color-modes.js"></script>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/sidebars.css" rel="stylesheet">
        <title>Gestión de usuarios</title>
    </head>
    <body>
        <%@ include file="../util/theme.jsp" %>
        <div class="d-flex">
            <%@ include file="../util/sidebar.jsp" %>
            <div class="container mt-5 mb-4">
                <c:if test="${not empty msg}">
                    <div id="myAlert" class="alert alert-${tipoAlerta} alert-dismissible fade show" role="alert">
                        <strong>${msg}</strong> 
                    </div>
                </c:if>
                <div class="card shadow-sm">
                    <div class="card-header bg-dark text-light text-center">
                        <h4 class="mb-0">Administración de Usuarios</h4>
                    </div>

                    <div class="card-body">
                        <p class="text-muted">
                            Registre, consulte o actualice los usuarios del sistema. Solo el personal autorizado puede realizar cambios en esta sección.
                        </p>
                        <hr>

                        <!-- 🧍 Registro de usuario -->
                        <h5>Registrar Nuevo Usuario</h5>
                        <form action="${pageContext.request.contextPath}/ControlUsuario" method="post" class="mb-4">
                            <input type="hidden" name="accion" value="registrar">
                            <div class="row g-3 mt-2"">
                                <div class="col-md-4">
                                    <label for="nom" class="form-label">Nombres</label>
                                    <input type="text" class="form-control" id="nom" name="nom" required>
                                </div>

                                <div class="col-md-4">
                                    <label for="ape" class="form-label">Apellidos</label>
                                    <input type="text" class="form-control" id="ape" name="ape" required>
                                </div>
                                <div class="col-md-4">
                                    <label for="usn" class="form-label">Nombre de usuario</label>
                                    <input type="text" class="form-control" id="usn" name="usn" required>
                                </div>
                            </div>
                            <div class="row g-3 mt-2">
                                <div class="col-md-4">
                                    <label for="car" class="form-label">Cargo</label>
                                    <input type="text" class="form-control" id="car" name="car" required>
                                </div>
                                <c:set var="roles" value="${sessionScope.roles}"/>
                                <div class="col-md-4">
                                    <label for="rol" class="form-label">Rol</label>
                                    <select id="roles" name="roles" class="form-select" required>
                                        <option value="">Seleccione...</option>
                                        <c:forEach var="rol" items="${roles}">
                                            <option value="${rol.codRol}">${rol.des}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <c:set var="estUsu" value="${sessionScope.estUsu}"/>
                                <div class="col-md-4">
                                    <label for="est" class="form-label">Estado</label>
                                    <select id="est" name="est" class="form-select" required>
                                        <option value="">Seleccione...</option>
                                        <c:forEach var="eu" items="${estUsu}">
                                            <option value="${eu.codEstado}">${eu.des}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="row g-3 mt-1 align-content-around">
                                <div class="col-md-4">
                                    <label for="clave" class="form-label">Contraseña</label>
                                    <input type="password" class="form-control" id="clave" name="clave" required>
                                </div>

                                <div class="col-md-4">
                                    <label for="confirmarClave" class="form-label">Confirmar Contraseña</label>
                                    <input type="password" class="form-control" id="confirmarClave" name="confirmarClave" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12 text-center align-self-center m-2">
                                    <button type="submit" class="btn btn-primary px-4" name="acc" value="CrearUsuario">Registrar</button>
                                    <a href="../home.jsp" class="btn btn-secondary px-4">Cancelar</a>
                                </div>
                            </div>
                        </form>
                    </div>
                    <hr>
                    <!-- 📋 Listado de usuarios -->
                    <h5>Usuarios Registrados</h5>
                    <div class="table-responsive mb-3">
                        <table class="table table-bordered table-striped align-middle">
                            <thead class="table-dark text-center">
                                <tr>
                                    <th>Nombres</th>
                                    <th>Apellidos</th>
                                    <th>Usuario</th>
                                    <th>Cargo</th>
                                    <th>Rol</th>
                                    <th>Estado</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <!-- Ejemplo de datos -->                                
                                <c:forEach var="usu" items="${usuarios}">                                    
                                <tr>
                                    <td>${usu.nom}</td>
                                    <td>${usu.ape}</td>
                                    <td>${usu.username}</td>
                                    <td>${usu.car}</td>
                                    <td>${usu.roll.des}</td>
                                    <td>${usu.estado.des}</td>
                                    <td class="text-center">
                                        <button class="btn btn-sm btn-warning" data-bs-toggle="modal" data-bs-target="#modalEditarUsuario1" 
                                                data-nombre="${usu.nom}" data-rol="${usu.roll.codRol}" data-estado="${usu.estado.codEstado}"
                                                data-id="${usu.codUsuario}" data-apellido="${usu.ape}" data-cargo="${usu.car}">Editar</button>
                                        <form method="post" action="${pageContext.request.contextPath}/ControlUsuario" style="display: inline;">
                                            <input type="hidden" name="id" value="${usu.codUsuario}">
                                            <input type="submit" name="acc" value="Eliminar" class="btn btn-sm btn-danger">
                                        </form>
                                    </td>
                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="text-center mt-4">
                        <a href="../home.jsp" class="btn btn-secondary px-4">Volver</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- 🪟 Modal Editar Usuario 1 -->
        <div class="modal fade" id="modalEditarUsuario1" tabindex="-1" aria-labelledby="modalEditarUsuario1Label" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title" id="modalEditarUsuario1Label"></h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/ControlUsuario" method="post">
                        <input type="hidden" id="idUsuario" name="idUsuario" value="1">
                        <div class="modal-body">
                            <div class="row g-3">
                                <div class="col-md-12">
                                    <label for="nombreEditar" class="form-label">Nombres</label>
                                    <input type="text" class="form-control" id="nombreEditar" name="nombreEditar" value="Juan Pérez">
                                </div>

                                
                                <div class="col-md-5">
                                    <label for="cargoEditar" class="form-label">Cargo</label>
                                    <input type="text" class="form-control" id="cargoEditar" name="cargoEditar">
                                </div>

                                <div class="col-md-4">
                                    <label for="rolEditar" class="form-label">Rol</label>
                                    <select class="form-select" id="rolEditar" name="rolEditar">                                        
                                        <c:forEach var="rol" items="${roles}">
                                            <option value="${rol.codRol}">${rol.des}</option>
                                        </c:forEach>
                                    </select>                                    
                                </div>

                                <div class="col-md-3">
                                    <label for="estadoEditar" class="form-label">Estado</label>
                                    <select class="form-select" id="estadoEditar" name="estadoEditar">
                                        <c:forEach var="eu" items="${estUsu}">
                                            <option value="${eu.codEstado}">${eu.des}</option>
                                        </c:forEach>
                                    </select>
                                </div>                                
                                
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="submit" name="acc" value="Actualizar" class="btn btn-primary">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/sidebars.js"></script>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script>
        $(document).ready(function() {
            // Verifica si el elemento del alert existe en la página
            if ($('#myAlert').length) {
                
                // 1. Establece el tiempo en milisegundos (ej: 5000 ms = 5 segundos)
                var tiempoVisible = 5000; 
                
                // 2. Ocultar el alert después del tiempo especificado
                setTimeout(function() {
                    // Cierra el alert con el método 'alert('close')' de Bootstrap
                    $('#myAlert').alert('close');
                }, tiempoVisible);
            }
            
            $('#modalEditarUsuario1').on('show.bs.modal', function (event) {
                // 2. Elemento Disparador: 'button' que fue clickeado para abrir el modal
                var button = $(event.relatedTarget);

                // 3. Extracción de Datos: Recupera los valores de los atributos data-* del botón
                var codUsuario = button.data('id');
                var nombre = button.data('nombre');
                var apellido = button.data('apellido');
                var rol = button.data('rol');
                var estado = button.data('estado');
                var cargo = button.data('cargo');
                
                // 4. Inyección: Selecciona los campos de entrada del modal por su ID
                // y les asigna los valores extraídos
                var modal = $(this);
                modal.find('#modalEditarUsuario1Label').text('Editar Usuario: ' + nombre);
                modal.find('#idUsuario').val(codUsuario);
                modal.find('#nombreEditar').val(nombre);
                modal.find('#apEditar').val(apellido);
                modal.find('#cargoEditar').val(cargo);                
                modal.find('#rolEditar').val(rol);
                modal.find('#estadoEditar').val(estado);
            });
        });
    </script>
</body>
</html>

