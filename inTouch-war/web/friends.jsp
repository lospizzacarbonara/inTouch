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
        %>
        <fieldset>
            <legend>Pendientes</legend> 
            <%
                for (User user: pendingFriendsSet) {
            %>
                <fieldset class="thirdSize">
                    <legend class="center-legend"><%=user.getUsername()%></legend>
                </fieldset>
            <%
                }
            %>
        </fieldset>
        
        <fieldset>
            <legend>Amigos</legend> 
            <%
                for (User user: friendsSet) {
            %>
                <fieldset class="thirdSize">
                    <legend class="center-legend"><%=user.getUsername()%></legend>
                </fieldset>
            <%
                }
            %>
        </fieldset>

    </body>
</html>
