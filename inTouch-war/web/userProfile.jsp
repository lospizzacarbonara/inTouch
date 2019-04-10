<%@page import="java.util.Scanner"%>
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

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Perfil de usuario</title>
        <link rel="stylesheet" href="perfilcss.css">
        <link rel="stylesheet" href="menucss.css">
    </head>
    
    <body>

        <div id="menu">
            <ul>
                <li><a href="/inTouch-war/chargingWallServlet">Home</a></li>
                <li><a href="#">Options</a></li>
                <li><a href="#">Friends</a></li>
                <li><a href="/inTouch-war/search">Search</a></li>
                <li><a href="#" class="active">My Profile</a></li>
            </ul>
        </div>

        <fieldset name="titulo" class="tituloPerfil">
            <h1  align="center">Perfil de usuario</h1>
        </fieldset>
        <br/>

        <fieldset name="seguridad" class="seguridadPerfil">
            <form name="perfilDeUsuario" method="post" action="changePasswordServlet">
                <input type="hidden" name="idUser" value="<%=user.getId()%> "/>
                <button>Cambiar la contraseña</button>
            </form>
        </fieldset>
        
        <form name="perfilDeUsuario" method="post" action="userProfileSaveServlet">
            <fieldset name="datos_personales" class="centroPerfil">
                <legend>Datos personales</legend>
                    <table name="datos" class="centradoPerfil">
                        <tr class="filaPerfil">
                            <th class="alineadoDerecha">
                                <label for="user">Apodo:</label>
                            </th>
                            <td colspan="3">
                                <!-- el nombre de usuario no se puede modificar -->
                                <input type="text" name="user" size="28" value="<%= user.getUsername() %>" disabled="disabled"/>
                            </td>
                        </tr>
                        <tr class="filaPerfil">
                            <th class="alineadoDerecha">
                                <label for="name">Nombre:</label>
                            </th>
                            <td colspan="3">
                                <input type="text"  name="name" size="28" maxsize="28" value="<%= nombre %>"/>
                            </td>
                        </tr>
                        <tr class="filaPerfil">
                            <th class="alineadoDerecha">
                                <label for="surname">Apellidos:</label>
                            </th>
                            <td colspan="3">
                                <input type="text" name="surname" size="28" maxsize="28" value="<%= apellido %>"/>
                            </td>
                        </tr>
                        <tr>
                            <th class="alineadoDerecha" rowspan="2">
                                Fecha de nacimiento:
                            </th>
                            <th>
                                <label for="dayBirth">Día</label>
                            </th>
                            <th>
                                <label for="monthBirth">Mes</label>
                            </th>
                            <th>
                                <label for="yearBirth">Año</label>
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
                                        <option value="<%= i %>" <%= selected %>> <%= (i>0)?i:"" %> </option>
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
                                        <option value="<%= i %>" <%= selected %>> <%= (i>0)?meses[i-1]:"" %> </option>
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
                                        <option value="<%= i %>" <%= selected %>> <%= i %> </option>
                                    <%
                                        }
                                    %>
                                </select>

                            </td>
                        </tr>
                    </table>
                    <input type="hidden" name="idUser" value="<%=user.getId()%> "/>
                    <input type="hidden" name="user" value="<%=alias%> "/>
                    <input type="hidden" name="nameOriginal" value="<%=nombre%> "/>
                    <input type="hidden" name="surnameOriginal" value="<%=apellido%> "/>
                    <input type="hidden" name="birthdayOriginal" value="<%=fechaNacimiento%> "/>
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
                                <input type="email" name="email" size="50" maxsize="50" value="<%= user.getEmail() %>"/>
                            </td>
                        </tr>
                    </table>
                </fieldset>
                <br/>
                <br/>
                <input type="hidden" name="idUser" value="<%=user.getId()%> "/>
                <input type="hidden" name="emailOriginal" value="<%= user.getEmail() %>"/>
                <div>
                    <button>Guardar cambios email</button>
                </div>
            </form>
    </body>
</html>
