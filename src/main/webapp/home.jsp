<%-- 
    Document   : home
    Created on : Oct 8, 2025, 6:08:47 PM
    Author     : kevin
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<c:if test="${sessionScope.usuAut == null}">
    <c:redirect url="login.jsp" />
</c:if>
<!doctype html>
<html lang="es-ES" data-bs-theme="auto">

    <head>
        <script src="js/color-modes.js"></script>

        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="${pageContext.request.contextPath}/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/sidebars.css" rel="stylesheet">

        <title>Home - Quantum Bank</title>


    </head>

    <body>
        <%@ include file="util/theme.jsp" %>
        <div class="d-flex">
            <%@ include file="util/sidebar.jsp" %>
        </div>

        <script src="${pageContext.request.contextPath}/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/js/sidebars.js"></script>
    </body>

</html>
