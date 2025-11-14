<%-- 
 	Document 	: registroClientes
 	Created on : Oct 29, 2025
 	Author 	 	: Kevin
 	Descripción : Pantalla de Registro de Cliente, integra el mensaje de 'Acudir al banco' si es necesario.
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es-ES">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link rel="stylesheet" href="../css/bootstrap.min.css">
		<link rel="stylesheet" href="../css/login-cli.css"/>	
		<!-- Usando Bootstrap Icons para los iconos -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
		<title>Banca web - Registrarme</title>
		<style>
                    
			:root {
				--color-primary: #007bff;
				--color-danger: #dc3545;
			}
			.right-section {	
				min-height: 100vh;
				display: flex;
				align-items: center;
				justify-content: center;
				background-color: #f4f6f9; /* Fondo claro para la sección derecha */
			}
			.login-card-cliente { 
				max-width: 400px;
				padding: 2rem;
				background: #ffffff;
				border-radius: 1rem;
				box-shadow: 0 5px 25px rgba(0, 0, 0, 0.05);
			}

			/* Estilos para el Bloque de Aviso Integrado (NUEVOS ESTILOS) */
			.aviso-content {
				text-align: center;
				padding: 1.5rem 0;
			}
			.icon-bank {
				font-size: 3rem;
				color: var(--color-danger);
				margin-bottom: 0.5rem;
				background: #fdf2f2;
				padding: 0.75rem;
				border-radius: 50%;
				display: inline-block;
			}
			.alert-title {
				font-size: 1.1rem;
				font-weight: bold;
				color: #004C99; /* Azul más oscuro para el título */
			}
			/* Fin de estilos de aviso */

			.btn-custom {
				background-color: #004C99; /* Quantum Blue para el botón de registro */
				border-color: #004C99;
				color: white;
			}
			.btn-custom:hover {
				background-color: #003a7a;
				border-color: #003a7a;
			}
		</style>
	</head>
	<body>
		<div class="container-fluid h-100 g-0">
			<div class="row h-100 g-0">

				<!-- Columna de Imagen (Izquierda) -->
				<div class="col-md-6 d-none d-md-block">
					<!-- Usando el mismo estilo de la versión V2 -->
					<div style="background-image: url('../img/portada.jpg'); background-size: cover; background-position: center; height: 100vh; display: flex; align-items: flex-end; justify-content: center; padding: 2rem;">
						<h2 class="text-center mb-4 fw-bold p-2 text-white" style="background: rgba(0, 0, 0, 0.4); border-radius: 0.5rem;">QUANTUM BANK</h2>
					</div>
				</div>

				<!-- Columna de Formulario/Aviso (Derecha) -->
				<div class="col-md-6 right-section">
					<div class="login-card-cliente">	
						<div class="d-flex justify-content-center align-items-center mb-3">
							<img src="../img/logoQB.png" alt="Quantum Bank Logo" style="width:150px"/>
						</div>
						<div class="text-center">
							<p class="h5 fw-light text-secondary">Registro de Usuario Web</p>
						</div>
						
						<!-- Lógica para mostrar el Aviso o el Formulario -->
						<c:if test="${not empty mensajeCuentasInactivas}">
							
							<!-- Bloque del CUADRO CREMA (Aviso: Acudir al banco) - DISEÑO MEJORADO -->
							<div id="avisoAcudirBanco" class="aviso-content mt-4">
								<i class="bi bi-bank icon-bank"></i>
								
								<h5 class="mb-2 text-danger fw-bold">Activación Requerida</h5>
								
								<p class="small text-dark mb-3">
									<!-- Aquí se inserta el mensaje dinámico del controlador -->
									${mensajeCuentasInactivas}
								</p>
								
								<!-- Contenedor de pasos para mejor visualización -->
								<div class="alert alert-info border-0 rounded-3 p-3 mt-3">
									<p class="mb-0 alert-title">Pasos Siguientes:</p>
									<ul class="list-unstyled text-start small mb-0 p-2">
										<li class="mb-1"><i class="bi bi-chevron-right small me-1"></i> **Acuda a la sucursal** con su <span class="fw-bold text-danger">DNI</span>.</li>
										<li class="mb-1"><i class="bi bi-chevron-right small me-1"></i> **Abra su primera cuenta** con un asesor.</li>
										<li><i class="bi bi-chevron-right small me-1"></i> El asesor completará su activación para la banca web.</li>
									</ul>
								</div>
								
								<div class="mt-4">
									<a href="login-clientes.jsp" class="btn btn-primary w-100">Volver al Login</a>
								</div>
							</div>
							
						</c:if>

						<c:if test="${empty mensajeCuentasInactivas}">
							<!-- Bloque del Formulario de Registro Normal -->
							<form action="${pageContext.request.contextPath}/ControlRegistrarme" method="POST">
								<div class="form-floating mb-3">
									<input type="text" class="form-control" name="inpDNI" id="inpDNI" placeholder="DNI" required>
									<label for="inpDNI">DNI</label>
								</div>
								<div class="form-floating mb-3">
									<input type="password" class="form-control" name="inpClave" id="inpClave" placeholder="Palabra Clave" required>
									<label for="inpClave">Palabra Clave (Secreta)</label>
								</div>
								<div class="form-floating mb-3">
									<input type="password" class="form-control" name="inpPwd" id="inpPwd" placeholder="Contraseña de acceso web" required>
									<label for="inpPwd">Contraseña Web</label>
								</div>
								<div class="d-grid mt-4">
									<button type="submit" class="btn btn-custom">Finalizar Registro</button>
								</div>
								
								<c:if test="${not empty mensaje}">
									<div class="alert alert-warning text-center mt-3">${mensaje}</div>
								</c:if>
							</form>
							<div class="text-center mt-3">
								<a href="login-clientes.jsp" class="text-decoration-none small text-secondary">Volver al Login</a>
							</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>
		<script src="../js/bootstrap.bundle.min.js"></script>
	</body>
</html>
