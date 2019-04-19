
<%@page import="componentesHtml.NavMenu"%>
<%@page import="inTouch.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    User user;
    
    //leo el usuario
    try
    {
        user = (User)request.getAttribute("user");
    }
    catch(NullPointerException e)
    {
        user = new User();
    }
    
    String passwordVieja = "";
    String passwordNueva1 = "";
    String passwordNueva2 = "";
    
    //leo el codigo de estado (statusCode)
    Integer statusCode;
    try
    {
        statusCode = (Integer)request.getAttribute("statusCode");
    }
    catch(NullPointerException e)
    {
        statusCode = 0;
    }
    if(statusCode == null)
    {
        statusCode = 0;
    }
    
    //averiguo si se ha pasado la contraseña introducida previamente
    passwordVieja = (String)request.getAttribute("oldPassword");
    if(passwordVieja == null)
    {
        passwordVieja = "";
    }
    //averiguo si se ha pasado la contraseña nueva introducida previamente
    passwordNueva1 = (String)request.getAttribute("newPassword1");
    if(passwordNueva1 == null)
    {
        passwordNueva1 = "";
    }
    //averiguo si se ha pasado repeticion la contraseña nueva introducida previamente
    passwordNueva2 = (String)request.getAttribute("newPassword2");
    if(passwordNueva2 == null)
    {
        passwordNueva2 = "";
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
                                <input type="password" name="oldPassword" size="28" maxsize="28" value="<%= passwordVieja %>"/>
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
                                <input type="password"  name="newPassword" size="28" maxsize="28" value="<%= passwordNueva1 %>"/>
                            </td>
                        </tr>
                        <tr class="filaPerfil">
                            <th class="alineadoDerecha" colspan="15">
                                <label for="newPasswordAgain">Repita la contraseña nueva:</label>
                            </th>
                            <td colspan="3">
                                <input type="password" name="newPasswordAgain" size="28" maxsize="28" value="<%= passwordNueva2 %>"/>
                            </td>
                        </tr>
                        <tr>
                            <td rowspan="2" colspan="15">&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </fieldset>

                <fieldset name="cambioClave3" class="boton">
                    <input type="hidden" name="idUser" value="<%=user.getId()%> "/>
                    <button>Modificar la contraseña</button>
                    <br/><br/>
                    <%  
                        String status = "";
                        switch(statusCode)
                        {
                            case 0: status = ""; break;
                            case 1: status = "No se ha introducido la contraseña actual"; break;
                            case 2: status = "La contraseña introducida no es correcta"; break;
                            case 3: status = "No se ha introducido la contraseña nueva"; break;
                            case 4: status = "No se ha introducido la repetición de la contraseña nueva"; break;
                            case 5: status = "Debe introducir la misma contraseña en ambos campos de la contraseña nueva"; break;
                        }
                        if(statusCode > 0 && statusCode < 9)
                        {
                    %>
                    <div class="estadoError">
                    Error <%= statusCode %>: <%= status %>
                    </div>
                    <%
                        }
                        else if(statusCode == 9)
                        {
                    %>
                    <div class="estadoCorrecto">
                    La contraseña se ha cambiado correctamente
                    </div>
                    <%
                        }
                    %>
                    
                </fieldset>
            </fieldset>
        </form>
    </body>
</html>
