<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Gestión de Usuarios - Quantum Bank</title>

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/estilos.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/sidebar.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
    </head>

    <body data-active-page="admin-usuarios">
        <%@ include file="../util/theme.jsp" %>

        <div class="d-flex">
            <%@ include file="../util/sidebar.jsp" %>

            <div class="main-content flex-grow-1">
                <%@ include file="../util/header.jsp" %>

                <div class="content-area p-4">
                    <div class="card shadow-sm border-0">

                        <div class="card-header bg-dark text-light text-center">
                            <h4 class="mb-0">Administración de Usuarios</h4>
                        </div>

                        <div class="card-body p-4">
                            <p class="text-muted">
                                Registre, consulte o actualice los usuarios del sistema. Solo el personal autorizado puede realizar cambios en esta sección.
                            </p>
                            <hr>

                            <div class="row">
                                <div class="col-md-4">
                                    <h5>Registrar Nuevo Usuario</h5>
                                    <form action="${pageContext.request.contextPath}/ControlUsuario" method="post" class="mb-4">
                                        <input type="hidden" name="accion" value="registrar">
                                        <div class="row g-3 mt-2">
                                            <div class="col-md-12">
                                                <label for="nom" class="form-label">Nombres</label>
                                                <input type="text" class="form-control" id="nom" name="nom" required>
                                            </div>

                                            <div class="col-md-12">
                                                <label for="ape" class="form-label">Apellidos</label>
                                                <input type="text" class="form-control" id="ape" name="ape" required>
                                            </div>

                                            <div class="col-md-12">
                                                <label for="usn" class="form-label">Nombre de usuario</label>
                                                <input type="text" class="form-control" id="usn" name="usn" required>
                                            </div>

                                            <div class="col-md-12">
                                                <label for="car" class="form-label">Cargo</label>
                                                <input type="text" class="form-control" id="car" name="car" required>
                                            </div>

                                            <c:set var="roles" value="${sessionScope.roles}"/>
                                            <div class="col-md-12">
                                                <label for="rol" class="form-label">Rol</label>
                                                <select id="roles" name="roles" class="form-select" required>
                                                    <option value="">Seleccione...</option>
                                                    <c:forEach var="rol" items="${roles}">
                                                        <option value="${rol.codRol}">${rol.des}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>

                                            <c:set var="estUsu" value="${sessionScope.estUsu}"/>
                                            <div class="col-md-12">
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
                                            <div class="col-md-12">
                                                <label for="clave" class="form-label">Contraseña</label>
                                                <input type="password" class="form-control" id="clave" name="clave" required>
                                            </div>

                                            <div class="col-md-12">
                                                <label for="confirmarClave" class="form-label">Confirmar Contraseña</label>
                                                <input type="password" class="form-control" id="confirmarClave" name="confirmarClave" required>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-12 text-center m-2">
                                                <button type="submit" class="btn btn-primary px-4" name="acc" value="CrearUsuario">Registrar</button>
                                                <a href="../home.jsp" class="btn btn-secondary px-4">Cancelar</a>
                                            </div>
                                        </div>
                                    </form>
                                </div>

                                <div class="col-md-8">
                                    <h5>Usuarios Registrados</h5>
                                    <div class="table-responsive mb-3">
                                        <table class="table table-bordered table-striped align-middle">
                                            <thead class="table-light text-center">
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
                                                <c:forEach var="usu" items="${usuarios}">
                                                    <tr>
                                                        <td>${usu.nom}</td>
                                                        <td>${usu.ape}</td>
                                                        <td>${usu.username}</td>
                                                        <td>${usu.car}</td>
                                                        <td>${usu.roll.des}</td>
                                                        <td>${usu.estado.des}</td>
                                                        <td class="text-center">
                                                            <button class="btn btn-sm btn-outline-warning"
                                                                    data-bs-toggle="modal"
                                                                    data-bs-target="#modalEditarUsuario1" 
                                                                    data-nombre="${usu.nom}"
                                                                    data-rol="${usu.roll.codRol}"
                                                                    data-estado="${usu.estado.codEstado}"
                                                                    data-id="${usu.codUsuario}"
                                                                    data-apellido="${usu.ape}"
                                                                    data-cargo="${usu.car}">
                                                                Editar
                                                            </button>
                                                            <form method="post" action="${pageContext.request.contextPath}/ControlUsuario" style="display: inline;">
                                                                <input type="hidden" name="id" value="${usu.codUsuario}">
                                                                <input type="submit" name="acc" value="Eliminar" class="btn btn-sm btn-outline-danger">
                                                            </form>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <div class="text-center mt-4">
                                <a href="../home.jsp" class="btn btn-secondary px-4">Volver</a>
                            </div>
                        </div>
                    </div>
                </div> </div> </div> <div class="modal fade" id="modalEditarUsuario1" tabindex="-1" aria-labelledby="modalEditarUsuario1Label" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-light">
                        <h5 class="modal-title" id="modalEditarUsuario1Label">Editar Usuario</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/ControlUsuario" method="post">
                        <input type="hidden" id="idUsuario" name="idUsuario">
                        <div class="modal-body">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="nombreEditar" class="form-label">Nombres</label>
                                    <input type="text" class="form-control" id="nombreEditar" name="nombreEditar">
                                </div>

                                <div class="col-md-6">
                                    <label for="apellidoEditar" class="form-label">Apellidos</label>
                                    <input type="text" class="form-control" id="apellidoEditar" name="apellidoEditar">
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

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sidebar.js"></script>
        <script src="${pageContext.request.contextPath}/js/gestion-usuarios.js"></script>
    </body>
</html>