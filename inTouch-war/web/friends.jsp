<%-- 
    Document   : friends
    Created on : Apr 15, 2019, 10:09:06 AM
    Author     : jfaldanam
--%>

<%@page import="componentesHtml.MultiLanguage"%>
<%@page import="markdownj.Markdown"%>
<%@page import="inTouch.entity.Post"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="inTouch.entity.User"%>
<%@page import="componentesHtml.NavMenu"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    <%
        String lang = (String) session.getAttribute("lang");
        if (lang == null)
            lang = "english";
        MultiLanguage ml = new MultiLanguage(lang, "friends");
    %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=ml.get("title")%></title>
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
                <legend><%=ml.get("pendingFriends")%></legend> 
                <%
                    for (User user: pendingToAcceptFriendsSet) {
                %>
                    <fieldset class="thirdSize">
                        <legend class="center-legend">
                            <a href="getProfile?userId=<%=user.getId()%>"><%=user.getUsername()%></a>
                        </legend>
                        <form action="acceptFriend" method="get" name="acceptFriend">
                                <input type="hidden" name="acceptUserId" value="<%=user.getId()%>">
                                <input type="submit" value="<%=ml.get("acceptFriend")%>">
                        </form>
                        <form action="cancelPendingFriend" method="get" name="cancelPendingFriend">
                                <input type="hidden" name="cancelUserId" value="<%=user.getId()%>">
                                <input type="submit" value="<%=ml.get("removeFriendship")%>">
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
                <legend><%=ml.get("pendingAccepted")%></legend> 
                <%
                    for (User user: pendingFriendsSet) {
                %>
                    <fieldset class="thirdSize">
                        <legend class="center-legend">
                            <a href="getProfile?userId=<%=user.getId()%>"><%=user.getUsername()%></a>
                        </legend>
                        <form action="cancelPendingFriend" method="get" name="cancelPendingFriend">
                                <input type="hidden" name="cancelUserId" value="<%=user.getId()%>">
                                <input type="submit" value="<%=ml.get("cancelRequest")%>">
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
                <legend><%=ml.get("friends")%></legend> 
                <%
                    for (User user: friendsSet) {
                %>
                    <fieldset class="thirdSize">
                        <legend class="center-legend">
                            <a href="getProfile?userId=<%=user.getId()%>"><%=user.getUsername()%></a>
                        </legend>
                        <form action="removeFriend" method="get" name="removeFriend">
                                <input type="hidden" name="removeUserId" value="<%=user.getId()%>">
                                <input type="submit" value="<%=ml.get("removeFriend")%>">
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
                <legend><%=ml.get("friends")%></legend> 
                <%=ml.get("noFriendsYet")%> <a href="search"><%=ml.get("searchThem")%></a>
            </fieldset>
        <%
            }
        %>
    </body>
</html>
