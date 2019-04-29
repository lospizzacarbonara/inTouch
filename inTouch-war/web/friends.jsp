<%-- 
    Document   : friends
    Created on : Apr 15, 2019, 10:09:06 AM
    Author     : jfaldanam
--%>

<%@page import="markdownj.Markdown"%>
<%@page import="inTouch.entity.Post"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="inTouch.entity.User"%>
<%@page import="componentesHtml.NavMenu"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Friends</title>
        <link rel="stylesheet" href="resources/css/inTouch.css">
        <link rel="stylesheet" href="resources/css/navmenu.css">
        <link rel="stylesheet" href="resources/css/friends.css">
    </head>
    <body>
        <%=NavMenu.toHtml("friends")%>
        
        <%
            Map<User, Object[]> friendsData = (Map<User, Object[]>) request.getAttribute("friendsData");
            Set<User> friendsSet = null;
            if (friendsData != null){
                friendsSet = friendsData.keySet();
            }
            
            Map<User, Object[]> pendingFriendsData = (Map<User, Object[]>) request.getAttribute("pendingFriendsData");
            Set<User> pendingFriendsSet = null;
            if (pendingFriendsData != null){
                pendingFriendsSet = pendingFriendsData.keySet();
            }
            
            Map<User, Object[]> pendingToAcceptFriendsData = (Map<User, Object[]>) request.getAttribute("pendingToAcceptFriendsData");
            Set<User> pendingToAcceptFriendsSet = null;
            if (pendingToAcceptFriendsData != null){
                pendingToAcceptFriendsSet = pendingToAcceptFriendsData.keySet();
            }
        %>
        <%
            if (pendingToAcceptFriendsSet.size() != 0) {
        %>
            <fieldset>
                <legend>Pendientes de aceptar</legend> 
                <%
                    for (User user: pendingToAcceptFriendsSet) {
                %>
                    <fieldset class="thirdSize">
                        <legend class="center-legend">
                            <a href="getProfile?userId=<%=user.getId()%>"><%=user.getUsername()%></a>
                        </legend>
                        <form action="acceptFriend" method="get" name="acceptFriend">
                                <input type="hidden" name="acceptUserId" value="<%=user.getId()%>">
                                <input type="submit" value="Aceptar petici&oacute;n amigo">
                        </form>
                        <form action="cancelPendingFriend" method="get" name="cancelPendingFriend">
                                <input type="hidden" name="cancelUserId" value="<%=user.getId()%>">
                                <input type="submit" value="Eliminar petici&oacute;n amigo">
                        </form>
                    </fieldset>
                <%
                    }
                %>
            </fieldset>
        <%
            }
        %>
        <%
            if (pendingFriendsSet.size() != 0) {
        %>
            <fieldset>
                <legend>Pendientes de ser aceptadas</legend> 
                <%
                    for (User user: pendingFriendsSet) {
                %>
                    <fieldset class="thirdSize">
                        <legend class="center-legend">
                            <a href="getProfile?userId=<%=user.getId()%>"><%=user.getUsername()%></a>
                        </legend>
                        <form action="cancelPendingFriend" method="get" name="cancelPendingFriend">
                                <input type="hidden" name="cancelUserId" value="<%=user.getId()%>">
                                <input type="submit" value="Cancelar petici&oacute;n amigo">
                        </form>
                    </fieldset>
                <%
                    }
                %>
            </fieldset>
        <%
            }
        %>
        <%
            if (friendsSet.size() != 0) {
        %>
            <fieldset>
                <legend>Amigos</legend> 
                <%
                    for (User user: friendsSet) {
                %>
                    <fieldset class="thirdSize">
                        <legend class="center-legend">
                            <a href="getProfile?userId=<%=user.getId()%>"><%=user.getUsername()%></a>
                        </legend>
                        <form action="removeFriend" method="get" name="removeFriend">
                                <input type="hidden" name="removeUserId" value="<%=user.getId()%>">
                                <input type="submit" value="Eliminar amigo">
                        </form>
                    </fieldset>
                <%
                    }
                %>
            </fieldset>
        <%
            } else {
        %>
            <fieldset>
                <legend>Amigos</legend> 
                No tienes aun ningun amigo. <a href="search">Buscalos</a>
            </fieldset>
        <%
            }
        %>
    </body>
</html>
