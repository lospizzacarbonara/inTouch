<%@page import="componentesHtml.MultiLanguage"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="inTouch.entity.SocialGroup"%>
<%@page import="java.util.List"%>
<%@page import="componentesHtml.NavMenu"%>
<%@page import="java.util.Scanner"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.time.LocalDate"%>
<%@page import="inTouch.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String lang = (String) session.getAttribute("lang");
    if (lang == null)
        lang = "english";
    MultiLanguage ml = new MultiLanguage(lang, "userProfile");
%>
<%
    User user;
    Boolean miPerfil = false;
    Boolean myFriend = false;
    List<SocialGroup> myGroup = Collections.emptyList();
    
    try
    {
        user = (User)request.getAttribute("user");
    }
    catch(NullPointerException e)
    {
        user = new User();
    }
    
    try
    {
        miPerfil = (Boolean)request.getAttribute("myProfile");
    }
    catch(NullPointerException e)
    {
        miPerfil = false;
    }
    
    try
    {
        myFriend = (Boolean)request.getAttribute("myFriend");
    }
    catch(NullPointerException e)
    {
        myFriend = false;
    }
    
    try
    {
        myGroup = (List)request.getAttribute("myGroup");
    }
    catch(NullPointerException e)
    {
        myGroup = Collections.emptyList();
    }
    
    
    String nombre = "";
    String apellido = "";
    String fechaNacimiento = "";
    String correo = "";
    String alias = "";
    int year, month = 0, day = 0;
    
    LocalDate today = LocalDate.now();
    year = today.getYear();
    
    String[] meses = {"Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Setiembre","Octubre","Noviembre","Diciembre"};
    
    SimpleDateFormat date_format = new SimpleDateFormat("yyyy-MM-dd");
    
    if(user != null)
    {
        if(user.getName()!=null)
        {
           nombre = user.getName();
        }
        if(user.getSurname()!=null)
        {
            apellido = user.getSurname();
        }
        if(user.getBirthdate()!=null)
        {
            fechaNacimiento = date_format.format(user.getBirthdate());
            Scanner scanner = new Scanner(fechaNacimiento);
            scanner.useDelimiter("-");
            year = Integer.parseInt(scanner.next());
            month = Integer.parseInt(scanner.next());
            day = Integer.parseInt(scanner.next());
            fechaNacimiento = day + "/" + month + "/" + year;
        }
    }
    
    String inputDisabled = "";
    if(!miPerfil)
    {
        inputDisabled = "disabled=\"disabled\"";
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=ml.get("title")%></title>
        <link rel="stylesheet" href="resources/css/inTouch.css">
        <link rel="stylesheet" href="resources/css/perfil.css">
        <link rel="stylesheet" href="resources/css/navmenu.css">
    </head>
    
    <body>

       
        <%=NavMenu.toHtml("myProfile")%>

        <!-- Titulo de la página  -->
        <div name="titulo" class="tituloPerfil">
            <h1  align="center"><%=ml.get("userProfile")%></h1>
        </div>
        <br/>
        
        <!-- Opciones para el cambio de los datos personales: nombre, apellido y fecha de nacimiento -->
        <!-- El nombre de usuario una vez creado no se puede modificar por eso el input correspondiente
        al nombre de usuario está deshabilitado -->
        <form name="perfilDeUsuario" method="post" action="userProfileSaveServlet">
            <fieldset name="datosPersonales" class="datos">
                <legend><%=ml.get("personalData")%></legend>
                    <table name="datos" class="centradoPerfil">
                        <tr class="filaPerfil">
                            <th class="alineadoDerecha" colspan="15">
                                <label for="user"><%=ml.get("username")%>:</label>
                            </th>
                            <td colspan="3">
                                <!-- el nombre de usuario no se puede modificar -->
                                <input type="text" name="user" size="28" value="<%= user.getUsername() %>" disabled="disabled"/>
                            </td>
                        </tr>
                        <tr class="filaPerfil">
                            <th class="alineadoDerecha" colspan="15">
                                <label for="name"><%=ml.get("name")%>:</label>
                            </th>
                            <td colspan="3">
                                <input type="text"  name="name" size="28" maxsize="28" value="<%= nombre %>" <%= inputDisabled %>/>
                            </td>
                        </tr>
                        <tr class="filaPerfil">
                            <th class="alineadoDerecha" colspan="15">
                                <label for="surname"><%=ml.get("surname")%>:</label>
                            </th>
                            <td colspan="3">
                                <input type="text" name="surname" size="28" maxsize="28" value="<%= apellido %>" <%= inputDisabled %>/>
                            </td>
                        </tr>
                        <%
                            if(miPerfil || myFriend || !myGroup.isEmpty())
                            {
                        %>
                        <tr>
                            <th class="alineadoDerecha" rowspan="2" colspan="15">
                                <%=ml.get("birthDate")%>:
                            </th>
                            <th>
                                <label for="dayBirth"><%=ml.get("day")%></label>
                            </th>
                            <th>
                                <label for="monthBirth"><%=ml.get("month")%></label>
                            </th>
                            <th>
                                <label for="yearBirth"><%=ml.get("year")%></label>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <select name="dayBirth">
                                    <%
                                        for(int i = 0; i <= 31; i++)
                                        {
                                            String selected = (i==day)?"selected":" ";
                                    %>
                                        <option value="<%= i %>" <%= selected %> <%= inputDisabled %> > <%= (i>0)?i:""   %> </option>
                                    <%
                                        }
                                    %>
                                </select>
                            </td>
                            <td>
                                <select name="monthBirth">
                                    <%
                                        for(int i = 0; i <= 12; i++)
                                        {
                                            String selected = (i==month)?"selected":" ";
                                    %>
                                        <option value="<%= i %>" <%= selected %> <%= inputDisabled %>> <%= (i>0)?meses[i-1]:""  %> </option>
                                    <%
                                        }
                                    %>
                                </select>
                            </td>
                            <td>
                                <select name="yearBirth">
                                    <%
                                        for(int i = 1800; i <= 2101; i++)
                                        {
                                            String selected = (i==year)?"selected":" ";
                                    %>
                                        <option value="<%= i %>" <%= selected %> <%= inputDisabled %>> <%= i  %> </option>
                                    <%
                                        }
                                    %>
                                </select>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        <tr>
                            <td rowspan="2" colspan="15">&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                        <% 
                            if(miPerfil)
                            {
                        %>
                        <tr class="rowButton">
                            <td colspan="15" >
                                <button><%=ml.get("modifyData")%></button>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        <%
                            if(myFriend)
                            {
                        %>
                        <tr class="rowButton">
                            <td colspan="30" >
                                <%= user.getUsername() %><%=ml.get("isMyFriend")%>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        <%
                            if(!myGroup.isEmpty())
                            {
                        %>
                        <tr class="rowButton">
                            <td colspan="15" >
                            <%=ml.get("groupInCommon")%>
                            </td>
                            <td colspan="15">
                        <%
                                for(SocialGroup grupo: myGroup)
                                {
                        %>
                                    <%= grupo.getName() %> ... 
                        <%
                                }
                        %>
                             </td>
                        </tr>
                        <%
                            }
                        %>
                    </table>
                    <input type="hidden" name="idUser" value="<%=user.getId()%> "/>
                    <input type="hidden" name="user" value="<%=alias%> "/>
                    <input type="hidden" name="nameOriginal" value="<%=nombre%> "/>
                    <input type="hidden" name="surnameOriginal" value="<%=apellido%> "/>
                    <input type="hidden" name="birthdayOriginal" value="<%=fechaNacimiento%> "/>
                    <br/>
                </fieldset>
            </form>

            <!-- Opción para realizar el cambio del correo electronico asociado a la cuenta del
            usario -->
            
            <%
                if(miPerfil || myFriend)
                {
            %>
            <form name="correoElectronico" method="post" action="userProfileSaveEmailServlet">
                <fieldset name="email" class="email">
                    <legend><%=ml.get("email")%></legend>
                    <table name="correo" class="centradoPerfil">
                        <tr>
                            <th class="alineadoDerecha" colspan="15">
                                <%=ml.get("email")%>:
                            </th>
                            <td>
                                <input name="email" class="correoElectronico" size="40" maxsize="40" value="<%= user.getEmail() %>" <%= inputDisabled %>/>
                            </td>
                        </tr>
                        <tr>
                            <td rowspan="2" colspan="15">&nbsp;</td>
                            <td>&nbsp;</td>
                        </tr>
                         <% 
                            if(miPerfil)
                            {
                        %>
                        <tr class="rowButton">
                            <td>
                                <input type="hidden" name="idUser" value="<%=user.getId()%> "/>
                                <input type="hidden" name="emailOriginal" value="<%= user.getEmail() %>"/>
                                <!-- <input type="submit" id="modificarEmail" disabled value="Modificar el Correo Electronico"/> -->
                                <button name="modificarEmail"><%=ml.get("modifyEmail")%></button> 
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </table>
                    <br/>
                    <br/>
                </fieldset>
            </form>
            <%
                }
            %>
            
        <% 
            if(miPerfil)
            {
        %>        
        <!-- Botón para ir a la opción de cambio de contraseña -->
        <fieldset name="seguridad" class="seguridad">
            <legend><%=ml.get("password")%></legend>
            <form name="claveDeUsuario" method="post" action="changePasswordServlet">
                                <input type="hidden" name="idUser" value="<%=user.getId()%> "/>
                                <button><%=ml.get("changePassword")%></button>
            </form>
        </fieldset>
        <% 
            }
        %>

    </body>
</html>
