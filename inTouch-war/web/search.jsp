<%-- 
    Document   : Search
    Created on : Apr 1, 2019, 8:57:01 AM
    Author     : jfaldanam
--%>

<%@page import="java.util.Map"%>
<%@page import="inTouch.entity.Post"%>
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
            .italic {
                font-style: italic;
            }
            
            fieldset {
                border:2px solid purple;
                -moz-border-radius:8px;
                -webkit-border-radius:8px;	
                border-radius:8px;	
            }
        </style>
    </head>
    <body>
        <%
            int loggedUserId = (Integer) session.getAttribute("userId");
            User loggedUser = new User(loggedUserId);
            List<User> userList = (List<User>) request.getAttribute("userList");
            Map<User, Post> postMap = (Map<User, Post>) request.getAttribute("postMap");
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
                        <form action="addFriend" method="get" name="addFriend">
                            <input type="hidden" name="addUserId" value="<%=user.getId()%>">
                            <fieldset>
                                <legend>
                                    <center>
                                        <%=user.getUsername()%>
                                        <%
                                            if (!loggedUser.isFriend(user)) {
                                        %>
                                        <input type="submit" value="A&ntilde;adir amigo">
                                        <%
                                            } else {
                                        %>
                                        <input type="submit" value="Ya sois amigos" disabled>
                                        <%
                                            }
                                        %>
                                    </center><br/>
                                </legend>
                                <%
                                    if (postMap.get(user)!=null) {
                                %>
                                    <%=postMap.get(user).getBody()%>
                                <%
                                    } else {
                                %>
                                    <div class="italic">
                                        <%=user.getUsername()%> aun no ha  hecho ningun post
                                    </div>
                                <%
                                    }
                                %>
                            </fieldset>
                        </form>
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
