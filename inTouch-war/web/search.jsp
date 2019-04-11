<%-- 
    Document   : Search
    Created on : Apr 1, 2019, 8:57:01 AM
    Author     : jfaldanam
--%>

<%@page import="componentesHtml.NavMenu"%>
<%@page import="markdownj.Markdown"%>
<%@page import="java.util.Set"%>
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
        <link rel="stylesheet" href="resources/css/inTouch.css">
        <link rel="stylesheet" href="resources/css/navmenu.css">
        <link rel="stylesheet" href="resources/css/search.css">
    </head>
    <body>
        <%=NavMenu.toHtml("search")%>
        
        <%
            int loggedUserId = (Integer) session.getAttribute("userId");
            String searchText = request.getParameter("searchText");
            if (searchText == null) {
                searchText = "";
            }
            
            Map<User, Object[]> userData = (Map<User, Object[]>) request.getAttribute("userData");
            Set<User> userSet = null;
            if (userData != null){
                userSet = userData.keySet();
            }
        %>
        <div align="center">
            <form action="search" method="post" name="searchField">
                    <fieldset>
                        <legend>Busqueda de usuarios</legend> 
                        username: <input type="text" name="searchText" value=<%=searchText%>><br>
                        <input type="submit" value="Buscar">
                    </fieldset>
    
            </form>
            <table>
                <%
                   if (userSet != null) {
                    for (User user: userSet) {
                        if (user != null && user.getId() != loggedUserId) {
                %>
                <tr>
                    <td>
                        <form action="addFriend" method="get" name="addFriend">
                            <input type="hidden" name="addUserId" value="<%=user.getId()%>">
                            <fieldset>
                                <legend class="center-legend">
                                        <%=user.getUsername()%>
                                        <%
                                            User.friendStatus friendStatus = (User.friendStatus)userData.get(user)[1];
                                            if (friendStatus == User.friendStatus.friends) { 
                                        %>
                                            <input type="submit" value="Ya sois amigos" disabled>  
                                        <%
                                            } else if (friendStatus == User.friendStatus.pending) {
                                        %>
                                            <input type="submit" value="Peticion enviada" disabled>
                                        <%
                                            } else {
                                        %>
                                            <input type="submit" value="A&ntilde;adir amigo">
                                        <%
                                            }
                                        %>
                                </legend>
                                <%
                                    Post p = (Post)userData.get(user)[0];
                                    if (p != null) {
                                %>
                                <%=Markdown.toHtml(p.getBody())%>
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
