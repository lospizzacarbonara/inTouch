<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Perfil de usuario</title>
    </head>
    <body>
        <form name="perfil de usuario" method="get" action="perfilUsuarioGuardarServlet">
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
                            <input name="nombre" value="" size="25" maxsize="25"/>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Apellidos:
                        </th>
                        <td>
                            <input name="apellido" value="" size="25" maxsize="25"/>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Fecha de nacimiento:
                        </th>
                        <td>
                            <input name="bithday" value="" size="25" maxsize="25"/>
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
                            <input name="user" value="" size="25" maxsize="25"/>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Contraseña:
                        </th>
                        <td>
                            <input name="password" value="" size="25" maxsize="25"/>
                        </td>
                    </tr>
                    <tr>
                        <th>
                            Repita la contraseña:
                        </th>
                        <td>
                            <input name="password2" value="" size="25" maxsize="25"/>
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
                            <input name="email" value="" size="25" maxsize="25"/>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <br/>
            <br/>
            <input type="hidden" name="id_usuario" value="1"/>
            <button>Guardar cambios</button>
        </form>
    </body>
</html>
