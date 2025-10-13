<%-- 
    Document   : login
    Created on : 2 oct. 2025, 09:56:27
    Author     : crios
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Login</h1>
        <form action="LoginServlet" method="post" >            
        <table border="0">
            <tbody>
                <tr>
                    <td>Usuario</td>
                    <td><input type="text" name="usuario"></td>
                </tr>
                <tr>
                    <td>Contraseña</td>
                    <td><input type="password" name="clave" minlength="8"></td>
                </tr>
                <tr>
                    <td colspan="2" style="text-align: center;"><input type="submit" value="Ingresar" name="accion" style="width: 120px"></td>
                </tr>
            </tbody>
        </table>
        </form>
    </body>
</html>
