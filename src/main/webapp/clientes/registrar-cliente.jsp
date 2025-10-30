<%-- 
    Document   : registrar-cliente
    Created on : Oct 12, 2025, 11:34:24 AM
    Author     : kevin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="es-ES">
    <head>
        <script src="${pageContext.request.contextPath}/js/color-modes.js"></script>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/sidebars.css" rel="stylesheet">

        <title>Registrar nuevo cliente</title>
    </head>
    <body>

        <%@ include file="../util/theme.jsp" %>
        <div class="d-flex">
            <%@ include file="../util/sidebar.jsp" %>
            <div class="container mt-5 mb-4">
                <div class="card shadow-sm">
                    <div class="card-header bg-dark text-light text-center">
                        <h4 class="mb-0">Registro de Clientes</h4>
                    </div>
                    <div class="card-body">
                        <p class="text-muted">Complete los datos del cliente. Los campos con <span class="text-danger">*</span> son obligatorios.</p>
                        <hr>


                        <c:set var="c" value="${requestScope.cliente}"/>
                        <form action="${pageContext.request.contextPath}/ControlCliente" method="post">
                            <input type="hidden" name="accion" value="Reniec">
                            <!-- Tipo de documento -->
                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <label for="tipoDoc" class="form-label">Tipo de Documento <span class="text-danger">*</span></label>
                                    <select class="form-select" id="tipoDoc" name="tipoDoc" required>
                                        <option value="">Seleccione...</option>
                                        <option value="dni" <c:if test="${tipoDoc == 'dni'}"> selected </c:if>>DNI - Persona Natural</option>
                                        <option value="ruc" <c:if test="${tipoDoc == 'ruc'}"> selected </c:if>>RUC - Persona Jurídica</option>
                                    </select>
                                </div>

                                <div class="col-md-4">
                                    <label for="numDoc" class="form-label">Número de Documento <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="numDoc" name="numDoc" value="${c[0]}" required>
                                </div>
                                <div class="col-md-4 d-flex align-items-end">                                  
                                    <input type="submit" class="btn btn-secondary w-100" name="accion" value="Consultar RENIEC">
                                </div>
                            </div>
                        </form>
                        <form action="${pageContext.request.contextPath}/ControlCliente" method="post">    
                            <input type="hidden" name="tipoDoc" value="${tipoDoc}">
                            <input type="hidden" name="nroDoc" value="${c[0]}">
                            <!-- Nombres y apellidos / razón social -->
                            <div class="row mb-3">
                                <div class="col-md-12">
                                    <label for="nom" class="form-label">Nombre/Razon Social <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="nom" name="nom" value="${c[1]}" readonly>
                                </div>
                            </div>

                            <!-- Fecha de nacimiento -->
                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <label for="fecNac" class="form-label">Fecha de Nacimiento <span class="text-danger">*</span></label>
                                    <input type="date" class="form-control" id="fecNac" name="fecNac" required>
                                </div>
                            </div>
                            <hr>
                            <!-- Datos de contacto -->
                            <h5 class="mb-3">Datos de Contacto</h5>

                            <div class="row mb-3">
                                <div class="col-md-8">
                                    <label for="dir" class="form-label">Dirección <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="dir" name="dir" value="${c[2]}" required>
                                </div>
                                <div class="col-md-4">
                                    <label for="email" class="form-label">Correo Electrónico</label>
                                    <input type="email" class="form-control" id="email" name="email">
                                </div>
                            </div>

                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <label for="tel" class="form-label">Teléfono</label>
                                    <input type="text" class="form-control" id="tel" name="tel" maxlength="7">
                                </div>
                                <div class="col-md-4">
                                    <label for="cel" class="form-label">Celular <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="cel" name="cel" maxlength="9" required>
                                </div>
                            </div>

                            <hr>

                            <!-- Ubigeo -->
                            <h5 class="mb-3">Ubicación (Ubigeo)</h5>
                            <c:set var="d" value="${sessionScope.region}"/>
                            <div class="row mb-3">
                                <div class="col-md-4">
                                    <label for="region" class="form-label">Región <span class="text-danger">*</span></label>
                                    <select id="region" name="region" class="form-select" required>
                                        <option value="">Seleccione...</option>
                                        <c:forEach var="reg" items="${d}">
                                            <option value="${reg}">${reg}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label for="provincia" class="form-label">Provincia <span class="text-danger">*</span></label>
                                    <select id="provincia" name="provincia" class="form-select" required>
                                        <option value="">Seleccione...</option>
                                    </select>
                                </div>
                                <div class="col-md-4">
                                    <label for="distrito" class="form-label">Distrito <span class="text-danger">*</span></label>
                                    <select id="distrito" name="distrito" class="form-select" required>
                                        <option value="">Seleccione...</option>
                                    </select>
                                </div>
                            </div>

                            <hr>

                            <!-- Datos del sistema -->
                            <h5 class="mb-3">Datos del Sistema</h5>
                            <c:set var="fechaActual" value="<%= new java.util.Date()%>" />
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="codCliente" class="form-label">Código del Cliente</label>
                                    <input type="text" class="form-control" id="codCliente" name="codCliente" value="${codigo}" readonly>
                                </div>
                                <div class="col-md-6">
                                    <label for="fecReg" class="form-label">Fecha de Registro</label>
                                    <input type="date" class="form-control" id="fecReg" name="fecReg" value="<fmt:formatDate value="${fechaActual}" pattern="yyyy-MM-dd" />" readonly>
                                </div>
                            </div>

                            <hr>

                            <!-- Botones -->
                            <div class="text-center mt-4">
                                <input type="hidden" name="accion" value="Registrar">
                                <button type="submit" class="btn btn-success px-4">Registrar Cliente</button>
                                <button type="reset" class="btn btn-warning px-4">Limpiar</button>
                                <a href="../home.jsp" class="btn btn-danger px-4">Cancelar</a>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sidebars.js"></script>
        <script>
            const contextPath = "${pageContext.request.contextPath}";
        </script>
        <script src="${pageContext.request.contextPath}/js/ubigeo.js"></script>
    </body>
</html>
