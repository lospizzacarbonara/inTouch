 
<%@page import="componentesHtml.MultiLanguage"%>
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
    String lang = (String) session.getAttribute("lang");
            if (lang == null)
            lang = "english";
            MultiLanguage ml = new MultiLanguage(lang, "addToGroup");

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=ml.get("updatePassword")%></title>
        <link rel="stylesheet" href="resources/css/inTouch.css">
        <link rel="stylesheet" href="resources/css/perfil.css">
        <link rel="stylesheet" href="resources/css/navmenu.css">
        <link rel="stylesheet" href="resources/css/changePassword.css">
    </head>
    
    <body>
        
        <%=NavMenu.toHtml("")%>
        
        <!-- Titulo de la página  -->
        <div name="titulo" class="tituloPerfil">
            <h1  align="center"><%=ml.get("updatePassword")%></h1>
        </div>
        <br/>

        <form name="cambioDeClave" method="post" action="changePasswordSaveServlet">
            <fieldset name="cambioClave1" class="clave">
                <legend><%=ml.get("updatePassword")%></legend>
                <fieldset class="claveVieja">
                    <legend><%=ml.get("OldPassword")%></legend>
                    <table name="clave" class="centradoClave">
                        <tr class="filaPerfil">
                            <th class="alineadoDerecha" colspan="15">
                                <label for="oldPassword"><%=ml.get("currentPassword")%>:</label>
                            </th>
                            <td colspan="3">
                                <input type="password" name="oldPassword" size="28" maxsize="28" value="<%= passwordVieja %>"/>
                            </td>
                        </tr>
                    </table>
                </fieldset>
    
                <fieldset class="claveNueva">
                    <legend><%=ml.get("enterNewPassword")%></legend>
                    <table name="cambioClave2" class="centradoClave">
                        <tr class="filaPerfil">
                            <th class="alineadoDerecha" colspan="15">
                                <label for="newPassword"><%=ml.get("newPassword")%>:</label>
                            </th>
                            <td colspan="3">
                                <input type="password"  name="newPassword" size="28" maxsize="28" value="<%= passwordNueva1 %>"/>
                            </td>
                        </tr>
                        <tr class="filaPerfil">
                            <th class="alineadoDerecha" colspan="15">
                                <label for="newPasswordAgain"><%=ml.get("repeatPassword")%>:</label>
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
                    <button><%=ml.get("submitChanges")%></button>
                    <br/><br/>
                    <%  
                        if((statusCode & 1) == 1)
                        {
                        %>
                            <div class="estadoError">
                                <%=ml.get("errorNoPassword")%>
                            </div>
                        <% 
                            }
                    %>
                    <%  
                        if((statusCode & 2) == 2)
                        {
                        %>
                            <div class="estadoError">
                                <%=ml.get("errorIncorrectPassword")%>
                            </div>
                        <% 
                            }
                    %>
                    <%  
                        if((statusCode & 4) == 4)
                        {
                        %>
                            <div class="estadoError">
                                <%=ml.get("errorNoNewPassword")%>
                            </div>
                        <% 
                            }
                    %>
                    <%  
                        if((statusCode & 8) == 8)
                        {
                        %>
                            <div class="estadoError">
                               <%=ml.get("errorNoRepeatedPassword")%>
                            </div>
                        <% 
                            }
                    %>
                    <%  
                        if((statusCode & 16) == 16)
                        {
                        %>
                            <div class="estadoError">
                                <%=ml.get("errorNoMatchPassword")%>
                            </div>
                        <% 
                            }
                    %>
                    <%  
                        if((statusCode & 32) == 32)
                        {
                        %>
                            <div class="estadoError">
                                <%=ml.get("errorSamePassword")%>
                            </div>
                        <% 
                            }
                    %>
                    <%  
                        if((statusCode & 64) == 64)
                        {
                        %>
                            <div class="estadoCorrecto">
                                <%=ml.get("successPassword")%>
                            </div>
                        <% 
                            }
                    %>
                    
                </fieldset>
            </fieldset>
        </form>
    </body>
</html>
