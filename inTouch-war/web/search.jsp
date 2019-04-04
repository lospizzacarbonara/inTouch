<%-- 
    Document   : Search
    Created on : Apr 1, 2019, 8:57:01 AM
    Author     : jfaldanam
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="inTouch.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <title>Search</title>
        <style type="text/css">
            table {
                border: 0px solid black;
            }
            th, td {
                padding: 10px
            }
        </style>
    </head>
    <body>
        <%
            List<User> userList = (List<User>) request.getAttribute("userList");
        %>
        <div align="center">
            <form action="search" method="post" name="searchField">
                    <fieldset>
                        <legend>Busqueda de usuarios</legend>
                        username: <input type="text" name="searchText" value=""><br>
                        <input type="submit" value="Buscar">
                    </fieldset>
    
            </form>
            <table>
                <%
                   if (userList != null) {
                    for (User user: userList) {
                        if (user != null) {
                %>
                <tr>
                    <td>
                        <center><%=user.getUsername()%> <input type="submit" value="A&ntilde;adir amigo"></center><br/>
                        TODO: Mostrar ultimo post. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
                    </td>
                </tr>
                <%
                            }
                        }
                    }
                %>

                </tr>
            </table>
        </div>
    </body>
</html>
