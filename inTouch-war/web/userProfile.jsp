<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.time.LocalDate"%>
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
    
    
    String nombre = "";
    String apellido = "";
    String fechaNacimiento = "";
    String correo = "";
    String alias = "";
    
    SimpleDateFormat date_format = new SimpleDateFormat("dd/MM/yyyy");
    
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
        }
    }


%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Perfil de usuario</title>
        <link rel="stylesheet" href="perfilcss.css">
    </head>
    
    <body>
        <fieldset name="titulo" class="tituloPerfil">
            <h1  align="center">Perfil de usuario</h1>
        </fieldset>
        <br/>
        <br/>

        <form name="seguridad" method="post" action="userProfileChangePasswordServlet">               
            <fieldset name="seguridad" class="izquierdaPerfil">
                <legend>Seguridad</legend>
                <table name="claves">
                    <tr>
                        <th class="alineadoDerecha">
                            Usuario:
                        </th>
                        <td>
                            <input name="user" size="25" maxsize="25" value="<%= user.getUsername() %>"/>
                        </td>
                    </tr>
                    <tr>
                        <th class="alineadoDerecha">
                            Contraseña:
                        </th>
                        <td>
                            <input type="password" name="password" size="25" maxsize="25" value=""/>
                        </td>
                    </tr>
                    <tr>
                        <th class="alineadoDerecha">
                            Repita la contraseña:
                        </th>
                        <td>
                            <input type="password" name="confirm_password" size="25" maxsize="25" value=""/>                         
                        </td>
                    </tr>
                </table>
                        <form class="pure-form">
                <fieldset>
                    <script>
                            var password = document.getElementById("password"), confirm_password = document.getElementById("confirm_password");

                            function validatePassword()
                            {
                                    if(password.value != confirm_password.value) 
                                    {
                                            confirm_password.setCustomValidity("Passwords Don't Match");
                                    } 
                                    else 
                                    {
                                            confirm_password.setCustomValidity('');
                                    }
                            }

                            password.onchange = validatePassword;
                            confirm_password.onkeyup = validatePassword;
                    </script>
                    <legend>Confirm password with HTML5</legend>

                    <input type="password" placeholder="Password" id="password" required>
                    <input type="password" placeholder="Confirm Password" id="confirm_password" required>

                    <button type="submit" class="pure-button pure-button-primary">Confirm</button>
                </fieldset>
            </form>
            </fieldset>
            <br/>
            <br/>           
        </form>
        
        
        <form name="perfilDeUsuario" method="post" action="userProfileSaveServlet">
            <fieldset name="datos_personales" class="centroPerfil">
                <legend>Datos personales</legend>
                <table name="datos" class="centradoPerfil">
                    <tr class="filaPerfil">
                        <th class="alineadoDerecha">
                            Apodo:
                        </th>
                        <td>
                            <!-- el nombre de usuario no se puede modificar -->
                            <input name="user" size="25" maxsize="25" value="<%= user.getUsername() %>" disabled="disabled"/>
                        </td>
                    </tr>
                    <tr class="filaPerfil">
                        <th class="alineadoDerecha">
                            Nombre:
                        </th>
                        <td>
                            <input name="name" size="25" maxsize="25" value="<%= nombre %>"/>
                        </td>
                    </tr>
                    <tr class="filaPerfil">
                        <th class="alineadoDerecha">
                            Apellidos:
                        </th>
                        <td>
                            <input name="surname" size="25" maxsize="25" value="<%= apellido %>"/>
                        </td>
                    </tr>
                    <tr class="filaPerfil">
                        <th class="alineadoDerecha">
                            Fecha de nacimiento:
                        </th>
                        <td>
                            <input type="date" name="birthday" value="<%= fechaNacimiento %>"/>
                        </td>
                    </tr>
                </table>
                <input type="hidden" name="idUser" value="<%= alias %> "/>
                <input type="hidden" name="nameOriginal" value="<%= nombre %> "/>
                <input type="hidden" name="surnameOriginal" value="<%= apellido %> "/>
                <input type="hidden" name="birthdayOriginal" value="<%= fechaNacimiento %> "/>
                <br/>
                <div class="derechaPerfil">
                    <button>Guardar cambios</button>
                </div>
            </fieldset>
        </form>
                
                
        
                        
        <form name="correoElectronico" method="post" action="userProfileSaveEmailServlet">
            <fieldset name="email"  class="derechaPerfil">
                <legend>Correo Electronico</legend>
                <table name="correo">
                    <tr>
                        <th class="alineadoDerecha">
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
            
            
            <input type="hidden" name="passwordOriginal" value="<%= user.getPassword() %>"/>
            <input type="hidden" name="emailOriginal" value="<%= user.getEmail() %>"/>
        </form>
        
    </body>
</html>
