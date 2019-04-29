<%-- 
    Document   : login
    Created on : 01-abr-2019, 9:13:40
    Author     : Toshiba
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="resources/css/inTouch.css">
        <title>Login inTouch</title>
        <style type="text/css">
            #Error {color: red}
        </style>
        <meta charset="UTF-8">
    </head>
    <body>
 
        <h1 align="center">¡Bienvenido a inTouch!</h1>
        <br/>
        <h2 align="center">Introduzca los datos de usuario:</h2>
       

        <form method="post" action="loginServlet" name="login" accept-charset="UTF-8">
            <p align="center">
            Nombre de Usuario:<br/><input size="40" name="user"><br/>
            <br/>
            Contraseña:<br/><input type="password" size="40" name="password"><br/>
            <br/>
            
            <button>Iniciar</button>
            </p>
        </form>
        <% Boolean login = (Boolean)request.getAttribute("login");
                        if (login != null && !login) {
        %>
        <br/>
        <p id="Error" align="center">
        CONTRASEÑA O USUARIO INCORRECTOS 
        </p>
        <br/>
         <%
                       }
         %> 
         <h3 align="center"> &oacute; </h3>  
         
        <h2 align="center">Registrate en nuestra aplicación</h2>
            <p align="center">
            <button class="enlace" role="link" onclick="window.location='signUp.html'">Registrarse</button>
            </p>
    </body>
</html>
