<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.time.LocalDate"%>
<%@page import="inTouch.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    User user = (User)request.getAttribute("user");
    String nombre = "";
    String apellido = "";
    String fechaNacimiento = "";
    SimpleDateFormat date_format = new SimpleDateFormat("dd/MM/yyyy");
    
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
    }    
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Perfil de usuario</title>
    </head>
    <body>
        <form name="perfil de usuario" method="get" action="userProfileSaveServlet">
            <fieldset name="titulo">
                <h1  align="center">Perfil de usuario</h1>
            </fieldset>
            <br/>
            <br/>
            <fieldset name="datos_personales">
                <legend>Datos personales</legend>
                <table name="datos">
                    <tr>
                        <th>
                            Nombre:
                        </th>
                        <td>
                            <input name="nombre" size="25" maxsize="25" value="<%= nombre %>"/>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Apellidos:
                        </th>
                        <td>
                            <input name="apellido" size="25" maxsize="25" value="<%= apellido %>"/>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Fecha de nacimiento:
                        </th>
                        <td>
                            <input name="birthday" size="25" maxsize="25" value="<%= fechaNacimiento %>"/>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <br/>
            <br/>
            <fieldset name="seguridad">
                <legend>Seguridad</legend>
                <table name="claves">
                    <tr>
                        <th>
                            Usuario:
                        </th>
                        <td>
                            <input name="user" size="25" maxsize="25" value="<%= user.getUsername() %>"/>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Contraseña:
                        </th>
                        <td>
                            <input type="password" name="password" size="25" maxsize="25" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Repita la contraseña:
                        </th>
                        <td>
                            <input type="password" name="password2" size="25" maxsize="25" value=""/>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <br/>
            <br/>
            <fieldset name="email">
                <legend>Correo Electronico</legend>
                <table name="correo">
                    <tr>
                        <th>
                            Correo Electronico:
                        </th>
                        <td>
                            <input name="email" size="25" maxsize="25" value="<%= user.getEmail() %>"/>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <br/>
            <br/>
            <input type="hidden" name="idUsuario" value=""/>
            <input type="hidden" name="nombreOriginal" value="<%= user.getName() %>"/>
            <input type="hidden" name="apellidoOriginal" value="<%= user.getSurname() %>"/>
            <input type="hidden" name="birthdayOriginal" value="<%= user.getBirthdate() %>"/>
            <input type="hidden" name="userOriginal" value="<%= user.getUsername() %>"/>
            <input type="hidden" name="passwordOriginal" value="<%= user.getPassword() %>"/>
            <input type="hidden" name="emailOriginal" value="<%= user.getEmail() %>"/>
           
            <button>Guardar cambios</button>
        </form>
    </body>
</html>
