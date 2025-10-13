<%-- 
    Document   : gestion-usuarios
    Created on : Oct 12, 2025, 7:31:40 PM
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
        <title>Gestión de usuarios</title>
    </head>
    <body>
        <%@ include file="../util/theme.jsp" %>
        <div class="d-flex">
            <%@ include file="../util/sidebar.jsp" %>
            <div class="container mt-5 mb-4">
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
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label for="nom" class="form-label">Nombres</label>
                                    <input type="text" class="form-control" id="nom" name="nom" required>
                                </div>
                                
                                <div class="col-md-4">
                                    <label for="ape" class="form-label">Apellidos</label>
                                    <input type="text" class="form-control" id="ape" name="ape" required>
                                </div>
                                <div class="col-md-3">
                                    <label for="usn" class="form-label">Nombre de usuario</label>
                                    <input type="text" class="form-control" id="usn" name="usn" required>
                                </div>
                                <div class="col-md-3">
                                    <label for="car" class="form-label">Cargo</label>
                                    <input type="text" class="form-control" id="car" name="car" required>
                                </div>
                                <div class="col-md-3">
                                    <label for="rol" class="form-label">Rol</label>
                                    <select class="form-select" id="rol" name="rol" required>
                                        <option value="">Seleccione...</option>
                                        <option value="Administrador">Administrador</option>
                                        <option value="Cajero">Cajero</option>
                                        <option value="Soporte">Soporte</option>
                                        <option value="Consulta">Consulta</option>
                                    </select>
                                </div>
                                <div class="col-md-2">
                                    <label for="est" class="form-label">Estado</label>
                                    <select class="form-select" id="est" name="est" required>
                                        <option value="Activo">Activo</option>
                                        <option value="Inactivo">Inactivo</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row g-3 mt-1">
                                <div class="col-md-3">
                                    <label for="clave" class="form-label">Contraseña</label>
                                    <input type="password" class="form-control" id="clave" name="clave" required>
                                </div>

                                <div class="col-md-3">
                                    <label for="confirmarClave" class="form-label">Confirmar Contraseña</label>
                                    <input type="password" class="form-control" id="confirmarClave" name="confirmarClave" required>
                                </div>

                                <div class="col-md-6 text-end align-self-end">
                                    <button type="submit" class="btn btn-primary px-4" name="acc" value="crear">Registrar</button>
                                    <a href="../home.jsp" class="btn btn-secondary px-4">Cancelar</a>
                                </div>
                            </div>
                        </form>
                        <hr>
                        <!-- 📋 Listado de usuarios -->
                        <h5>Usuarios Registrados</h5>
                        <div class="table-responsive mb-3">
                            <table class="table table-bordered table-striped align-middle">
                                <thead class="table-dark text-center">
                                    <tr>
                                        <th>ID</th>
                                        <th>Nombre Completo</th>
                                        <th>Usuario</th>
                                        <th>Rol</th>
                                        <th>Estado</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Ejemplo de datos -->
                                    <tr>
                                        <td>1</td>
                                        <td>Juan Pérez</td>
                                        <td>jperez</td>
                                        <td>Administrador</td>
                                        <td>Activo</td>
                                        <td class="text-center">
                                            <button class="btn btn-sm btn-warning" data-bs-toggle="modal" data-bs-target="#modalEditarUsuario1">Editar</button>
                                            <button class="btn btn-sm btn-danger">Eliminar</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>María López</td>
                                        <td>mlopez</td>
                                        <td>Cajero</td>
                                        <td>Inactivo</td>
                                        <td class="text-center">
                                            <button class="btn btn-sm btn-warning" data-bs-toggle="modal" data-bs-target="#modalEditarUsuario2">Editar</button>
                                            <button class="btn btn-sm btn-danger">Eliminar</button>
                                        </td>
                                    </tr>
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
                            <h5 class="modal-title" id="modalEditarUsuario1Label">Editar Usuario: Juan Pérez</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <form action="/ControlUsuarios" method="post">
                            <input type="hidden" name="accion" value="actualizar">
                            <input type="hidden" name="idUsuario" value="1">
                            <div class="modal-body">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label for="nombreEditar1" class="form-label">Nombre Completo</label>
                                        <input type="text" class="form-control" id="nombreEditar1" name="nombreCompleto" value="Juan Pérez">
                                    </div>

                                    <div class="col-md-6">
                                        <label for="usuarioEditar1" class="form-label">Usuario</label>
                                        <input type="text" class="form-control" id="usuarioEditar1" name="usuario" value="jperez">
                                    </div>

                                    <div class="col-md-6">
                                        <label for="rolEditar1" class="form-label">Rol</label>
                                        <select class="form-select" id="rolEditar1" name="rol">
                                            <option>Administrador</option>
                                            <option>Cajero</option>
                                            <option>Soporte</option>
                                            <option>Consulta</option>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="estadoEditar1" class="form-label">Estado</label>
                                        <select class="form-select" id="estadoEditar1" name="estado">
                                            <option>Activo</option>
                                            <option>Inactivo</option>
                                        </select>
                                    </div>

                                    <div class="col-md-6">
                                        <label for="claveNueva1" class="form-label">Nueva Contraseña (opcional)</label>
                                        <input type="password" class="form-control" id="claveNueva1" name="claveNueva" placeholder="Dejar en blanco si no cambia">
                                    </div>

                                    <div class="col-md-6">
                                        <label for="confirmarClaveNueva1" class="form-label">Confirmar Nueva Contraseña</label>
                                        <input type="password" class="form-control" id="confirmarClaveNueva1" name="confirmarClaveNueva">
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
        </div>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sidebars.js"></script>
    </body>
</html>

