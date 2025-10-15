<section class="d-flex flex-nowrap">
    <div class="flex-shrink-0 p-3">
        <a href="#" class="d-flex align-items-center pb-3 mb-3 link-body-emphasis text-decoration-none border-bottom">
            <img src="${pageContext.request.contextPath}/img/logo_fondo_blanco.png" height="80" alt="Logo Quatum Bank"/>
        </a>
        <ul class="list-unstyled ps-0">
            <li class="mb-1 ms-3">
                <a href="${pageContext.request.contextPath}/home.jsp" class="btn fw-semibold d-inline-flex align-items-center rounded border-0">Inicio</a>
            </li>
            <li class="mb-1">
                <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                        data-bs-toggle="collapse" data-bs-target="#clientes-collapse" aria-expanded="false">
                    Clientes
                </button>
                <div class="collapse" id="clientes-collapse">
                    <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                        <c:url var="urlRegistroCliente" value="/ControlClienteReniec">
                            <c:param name="op" value="RegistrarCliente"/>
                        </c:url>
                        <li>
                            <a href="${urlRegistroCliente}" class="link-body-emphasis d-inline-flex text-decoration-none rounded">
                                Registro de clientes
                            </a>
                        </li>
                        <c:url var="urlListarCliente" value="/ControlClienteReniec">
                            <c:param name="op" value="ListaClientes"/>
                        </c:url>
                        <li>
                            <a href="${urlListarCliente}" class="link-body-emphasis d-inline-flex text-decoration-none rounded">
                                Consulta de clientes
                            </a>
                        </li>
                    </ul>
                </div>
            </li>
            <li class="mb-1">
                <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                        data-bs-toggle="collapse" data-bs-target="#cuentas-collapse" aria-expanded="false">
                    Cuentas
                </button>
                <div class="collapse" id="cuentas-collapse">
                    <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                        <li><a href="${pageContext.request.contextPath}/cuentas/apertura-cuentas.jsp" class="link-body-emphasis d-inline-flex text-decoration-none rounded">Apertura de cuentas</a></li>
                        <li><a href="${pageContext.request.contextPath}/cuentas/gestion-cuentas.jsp" class="link-body-emphasis d-inline-flex text-decoration-none rounded">Gestión de cuentas</a></li>
                        <li><a href="${pageContext.request.contextPath}/cuentas/gestion-embargos.jsp" class="link-body-emphasis d-inline-flex text-decoration-none rounded">Gestión de embargos</a></li>
                    </ul>
                </div>
            </li>
            <li class="mb-1">
                <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                        data-bs-toggle="collapse" data-bs-target="#operaciones-collapse" aria-expanded="false">
                    Operaciones
                </button>
                <div class="collapse" id="operaciones-collapse">
                    <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                        <li><a href="${pageContext.request.contextPath}/operaciones/deposito.jsp" class="link-body-emphasis d-inline-flex text-decoration-none rounded">Depósitos</a></li>
                        <li><a href="${pageContext.request.contextPath}/operaciones/retiro.jsp" class="link-body-emphasis d-inline-flex text-decoration-none rounded">Retiros</a></li>
                        <li><a href="${pageContext.request.contextPath}/operaciones/transferencia.jsp" class="link-body-emphasis d-inline-flex text-decoration-none rounded">Transferencias</a></li>
                    </ul>
                </div>
            </li>
            <li class="mb-1">
                <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                        data-bs-toggle="collapse" data-bs-target="#consultas-collapse" aria-expanded="false">
                    Consultas
                </button>
                <div class="collapse" id="consultas-collapse">
                    <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                        <li><a href="${pageContext.request.contextPath}/consultas/consulta-cuentas.jsp" class="link-body-emphasis d-inline-flex text-decoration-none rounded">Cuentas</a></li>
                        <li><a href="${pageContext.request.contextPath}/consultas/consulta-movimientos.jsp" class="link-body-emphasis d-inline-flex text-decoration-none rounded">Movimientos</a></li>
                        <li><a href="${pageContext.request.contextPath}/consultas/consulta-estado-cuenta.jsp" class="link-body-emphasis d-inline-flex text-decoration-none rounded">Estados de cuenta</a></li>
                    </ul>
                </div>
            </li>
            <c:if test="${sessionScope.usuAut.rol == 'R0001'}">
                <li class="mb-1">
                    <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                            data-bs-toggle="collapse" data-bs-target="#admin-collapse" aria-expanded="false">
                        Administración
                    </button>
                    <div class="collapse" id="admin-collapse">
                        <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                            <c:url var="urlRegistroUsuario" value="/ControlUsuario">
                                <c:param name="op" value="RegistrarUsuario"/>
                            </c:url>
                            <li>
                                <a href="${urlRegistroUsuario}" class="link-body-emphasis d-inline-flex text-decoration-none rounded">
                                    Usuarios
                                </a>
                            </li>
                            <li><a href="${pageContext.request.contextPath}/Administracion/gestion-parametros.jsp" class="link-body-emphasis d-inline-flex text-decoration-none rounded">Parámetros</a></li>
                            <li><a href="${pageContext.request.contextPath}/Administracion/gestion-accesos.jsp" class="link-body-emphasis d-inline-flex text-decoration-none rounded">Control de accesoa</a></li>
                        </ul>
                    </div>
                </li>
            </c:if>
            <li class="border-top my-3"></li>
            <li class="mb-1">
                <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                        data-bs-toggle="collapse" data-bs-target="#cuenta-collapse" aria-expanded="false">
                    Cuenta
                </button>
                <div class="collapse" id="cuenta-collapse">
                    <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                        <li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded">Mi perfil</a></li>
                        <li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded">Ajustes</a></li>
                        <li>
                        <c:url var="urlLogout" value="/ControlUsuario"><c:param name="op" value="CerrarSesion"/></c:url>
                        <a href="${urlLogout}" class="link-body-emphasis d-inline-flex text-decoration-none rounded">
                            Cerrar sesión
                        </a>
                        </li>
                    </ul>
                </div>
            </li>
        </ul>
    </div>
</section> 
<div class="b-example-divider b-example-vr"></div>
