<%-- 
    Document   : menu
    Created on : 2 oct. 2025, 10:26:22
    Author     : crios
--%>

<%@page import="servicio.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Menu</h1>
        <% 
            Usuario user = (Usuario)session.getAttribute("usuario"); 
        %>
        <table border="1" cellspacing ="5">
            <thead>
                <tr>
                    <th>DNI</th>
                    <th>NOMBRES</th>
                    <th>AP.PATERNO</th>
                    <th>AP.MATERNO</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><%= user.getDni() %></td>
                    <td><%= user.getNombres() %></td>
                    <td><%= user.getApellidoPaterno() %></td>
                    <td><%= user.getApellidoMaterno() %></td>
                </tr>
            </tbody>
        </table>
    </body>
</html>
