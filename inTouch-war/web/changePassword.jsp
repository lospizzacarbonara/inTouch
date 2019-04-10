
<%@page import="inTouch.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    User user;
    try
    {
        user = (User)request.getAttribute("user");
    }
    catch(NullPointerException e)
    {
        user = new User();
    }
    String password = "";
    
    if(user != null)
    {
        if(user.getPassword()!=null)
        {
           password = user.getPassword();
        }
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cambio de contraseña</title>
        <link rel="stylesheet" href="perfilcss.css">
    </head>
    
    <body>
        <fieldset name="titulo" class="tituloPerfil">
            <h1  align="center">Cambio de contraseña</h1>
        </fieldset>
        <br/>
    </body>
</html>
