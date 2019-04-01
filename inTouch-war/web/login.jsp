<%-- 
    Document   : login
    Created on : 01-abr-2019, 9:13:40
    Author     : Toshiba
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login inTouch</title>
        <meta charset="UTF-8">
    </head>
    <body>
 
        <h1 align="center">¡Bienvenido a inTouch!</h1>
        <br/>
        <h2 align="center">sIntroduzca los datos de usuario:</h2>
       

        <form method="post" action="loginServlet" name="inicio" accept-charset="UTF-8">
            <p align="center">
            Nombre de Usuario:<br/><input size="40" name="usuario"><br/>
            <br/>
            Contraseña:<br/><input type="password" size="40" name="clave"><br/>
            <br/>
            
            <button>Iniciar</button>
            </p>
        </form>
         <h3 align="center"> &oacute; </h3>  
         
        <h2 align="center">Registrate en nuestra aplicación</h2>
            <p align="center">
            <button class="enlace" role="link" onclick="window.location='alta.html'">Registrarse</button>
            </p>
    </body>
</html>
