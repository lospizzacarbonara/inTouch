
<%@page import="componentesHtml.NavMenu"%>
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
        <link rel="stylesheet" href="resources/css/inTouch.css">
        <link rel="stylesheet" href="resources/css/perfil.css">
        <link rel="stylesheet" href="resources/css/navmenu.css">
        <link rel="stylesheet" href="resources/css/changePassword.css">
    </head>
    
    <body>
        
        <%=NavMenu.toHtml("")%>
        
        <!-- Titulo de la página  -->
        <div name="titulo" class="tituloPerfil">
            <h1  align="center">Cambio de contraseña</h1>
        </div>
        <br/>

        <form name="cambioDeClave" method="post" action="changePasswordSaveServlet">
            <fieldset name="cambioClave1" class="clave">
                <legend>Cambio de contraseña</legend>
                <fieldset class="claveVieja">
                    <legend>Contraseña vieja</legend>
                    <table name="clave" class="centradoClave">
                        <tr class="filaPerfil">
                            <th class="alineadoDerecha" colspan="15">
                                <label for="oldPassword">Contraseña actual:</label>
                            </th>
                            <td colspan="3">
                                <input type="password" name="oldPassword" size="28" maxsize="28"/>
                            </td>
                        </tr>
                    </table>
                </fieldset>
    
                <fieldset class="claveNueva">
                    <legend>Introduzca la contraseña nueva</legend>
                    <table name="cambioClave2" class="centradoClave">
                        <tr class="filaPerfil">
                            <th class="alineadoDerecha" colspan="15">
                                <label for="newPassword">Contraseña nueva:</label>
                            </th>
                            <td colspan="3">
                                <input type="password"  name="newPassword" size="28" maxsize="28"/>
                            </td>
                        </tr>
                        <tr class="filaPerfil">
                            <th class="alineadoDerecha" colspan="15">
                                <label for="newPasswordAgain">Repita la contraseña nueva:</label>
                            </th>
                            <td colspan="3">
                                <input type="password" name="newPasswordAgain" size="28" maxsize="28"/>
                            </td>
                        </tr>
                        <tr>
                            <td rowspan="2" colspan="15">&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                </fieldset>
<!--
                <table name="cambioClave3">
                        <tr>
                            <td colspan="15">
                                <input type="hidden" name="idUser" value="<%=user.getId()%> "/>
                                <button>Modificar la contraseña</button>
                            </td>
                        </tr>
                </table>
-->
            </form>
    </body>
</html>
