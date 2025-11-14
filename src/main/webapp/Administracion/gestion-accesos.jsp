<%-- 
    Document   : gestion-accesos
    Created on : Oct 12, 2025, 7:32:10 PM
    Author     : kevin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es-ES"> <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/estilos.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/header.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/sidebar.css" rel="stylesheet"> <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

        <title>Control de Accesos - Quantum Bank</title>
    </head>

    <body data-active-page="admin-accesos">
        <%@ include file="../util/theme.jsp" %>

        <div class="d-flex">
            <%@ include file="../util/sidebar.jsp" %>

            <div class="main-content flex-grow-1">
                <%@ include file="../util/header.jsp" %>

                <div class="content-area p-4">

                    <div class="card shadow-sm border-0">
                        <div class="card-header bg-dark text-light text-center">
                            <h4 class="mb-0">Control de Accesos</h4>
                        </div>

                        <div class="card-body p-4">
                            <p class="text-muted">
                                Administre los roles y permisos de los usuarios del sistema. 
                                Solo el personal autorizado puede modificar estos parámetros.
                            </p>
                            <hr>

                            <h5>Asignación de Roles</h5>
                            <form class="row g-3 mb-4" action="/ControlAccesos" method="post">
                                <input type="hidden" name="accion" value="buscarUsuario">
                                <div class="col-md-6">
                                    <label class="form-label">Buscar Usuario</label>
                                    <input type="text" name="criterio" class="form-control" placeholder="Ingrese nombre o usuario">
                                </div>
                                <div class="col-md-2 d-flex align-items-end">
                                    <button type="submit" class="btn btn-primary w-100">
                                        <i class="bi bi-search me-1"></i> Buscar
                                    </button>
                                </div>
                            </form>

                            <div class="table-responsive mb-4">
                                <table class="table table-bordered align-middle">
                                    <thead class="table-light text-center"> 
                                        <tr>
                                            <th>ID</th>
                                            <th>Usuario</th>
                                            <th>Nombre Completo</th>
                                            <th>Rol Actual</th>
                                            <th>Estado</th>
                                            <th>Acción</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td>admin01</td>
                                            <td>Administrador General</td>
                                            <td>Administrador</td>
                                            <td>Activo</td>
                                            <td class="text-center">
                                                <button class="btn btn-sm btn-outline-warning" 
                                                        data-bs-toggle="modal" 
                                                        data-bs-target="#modalAsignarRol"
                                                        data-id="1"
                                                        data-usuario="admin01"
                                                        data-rol="Administrador"
                                                        data-estado="Activo">
                                                    Cambiar Rol
                                                </button>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>2</td>
                                            <td>user02</td>
                                            <td>Cajero Principal</td>
                                            <td>Cajero</td>
                                            <td>Activo</td>
                                            <td class="text-center">
                                                <button class="btn btn-sm btn-outline-warning" 
                                                        data-bs-toggle="modal" 
                                                        data-bs-target="#modalAsignarRol"
                                                        data-id="2"
                                                        data-usuario="user02"
                                                        data-rol="Cajero"
                                                        data-estado="Activo">
                                                    Cambiar Rol
                                                </button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>

                            <hr>

                            <h5>Permisos por Rol</h5>
                            <form action="/ControlAccesos" method="post">
                                <input type="hidden" name="accion" value="guardarPermisos">
                                <div class="mb-3">
                                    <label class="form-label">Seleccione Rol</label>
                                    <select class="form-select w-auto d-inline-block" name="rol" required>
                                        <option>Administrador</option>
                                        <option>Cajero</option>
                                        <option>Supervisor</option>
                                        <option>Consulta</option>
                                    </select>
                                </div>

                                <div class="table-responsive">
                                    <table class="table table-bordered align-middle">
                                        <thead class="table-light text-center">
                                            <tr>
                                                <th>Módulo</th>
                                                <th>Permiso</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td>Registro de Clientes</td>
                                                <td class="text-center"><input type="checkbox" class="form-check-input" name="mod_cliente" checked></td>
                                            </tr>
                                            <tr>
                                                <td>Apertura de Cuentas</td>
                                                <td class="text-center"><input type="checkbox" class="form-check-input" name="mod_apertura" checked></td>
                                            </tr>
                                            <tr>
                                                <td>Gestión de Embargos</td>
                                                <td class="text-center"><input type="checkbox" class="form-check-input" name="mod_embargo"></td>
                                            </tr>
                                            <tr>
                                                <td>Depósitos</td>
                                                <td class="text-center"><input type="checkbox" class="form-check-input" name="mod_deposito" checked></td>
                                            </tr>
                                            <tr>
                                                <td>Retiros</td>
                                                <td class="text-center"><input type="checkbox" class="form-check-input" name="mod_retiro" checked></td>
                                            </tr>
                                            <tr>
                                                <td>Transferencias</td>
                                                <td class="text-center"><input type="checkbox" class="form-check-input" name="mod_transferencia" checked></td>
                                            </tr>
                                            <tr>
                                                <td>Consultas (Cuentas y Movimientos)</td>
                                                <td class="text-center"><input type="checkbox" class="form-check-input" name="mod_consulta" checked></td>
                                            </tr>
                                            <tr>
                                                <td>Administración de Usuarios</td>
                                                <td class="text-center"><input type="checkbox" class="form-check-input" name="mod_usuarios"></td>
                                            </tr>
                                            <tr>
                                                <td>Parámetros del Sistema</td>
                                                <td class="text-center"><input type="checkbox" class="form-check-input" name="mod_parametros"></td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <div class="text-end mt-3">
                                    <button type="submit" class="btn btn-primary">Guardar Permisos</button>
                                </div>
                            </form>

                            <div class="text-center mt-4">
                                <a href="../home.jsp" class="btn btn-secondary px-4">Volver</a>
                            </div>
                        </div>
                    </div>
                </div> </div> <div class="modal fade" id="modalAsignarRol" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header bg-dark text-light">
                            <h5 class="modal-title">Asignar Rol a Usuario</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>
                        <form action="/ControlAccesos" method="post">
                            <input type="hidden" name="accion" value="asignarRol">
                            <input type="hidden" name="idUsuario" id="rolUsuarioId">

                            <div class="modal-body">
                                <div class="mb-3">
                                    <label class="form-label">Usuario</label>
                                    <input type="text" class="form-control" id="rolUsuarioNombre" name="usuario" readonly>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Rol Actual</label>
                                    <input type="text" class="form-control" id="rolUsuarioActual" readonly>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Nuevo Rol</label>
                                    <select class="form-select" id="rolUsuarioNuevo" name="nuevoRol" required>
                                        <option>Administrador</option>
                                        <option>Cajero</option>
                                        <option>Supervisor</option>
                                        <option>Consulta</option>
                                    </select>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Estado</label>
                                    <select class="form-select" id="rolUsuarioEstado" name="estado" required>
                                        <option>Activo</option>
                                        <option>Inactivo</option>
                                    </select>
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
        <%@ include file="../util/cont-sesion.jsp" %>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sidebar.js"></script>
        <script src="${pageContext.request.contextPath}/js/gestion-accesos.js"></script>
        <script src="${pageContext.request.contextPath}/js/session-timer.js"></script>
    </body>
</html>