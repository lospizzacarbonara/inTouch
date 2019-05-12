<%-- 
    Document   : Search
    Created on : Apr 1, 2019, 8:57:01 AM
    Author     : jfaldanam
--%>

<%@page import="componentesHtml.MultiLanguage"%>
<%@page import="inTouch.entity.SocialGroup"%>
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
    <%
        String lang = (String) session.getAttribute("lang");
        if (lang == null)
            lang = "english";
        MultiLanguage ml = new MultiLanguage(lang, "search");
    %>
<html>
    <head>
        <title><%=ml.get("title")%></title>
        <link rel="stylesheet" href="resources/css/inTouch.css">
        <link rel="stylesheet" href="resources/css/navmenu.css">
        <link rel="stylesheet" href="resources/css/friends.css">
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
            
            Map<SocialGroup, Object[]> groupData = (Map<SocialGroup, Object[]>) request.getAttribute("groupData");
            Set<SocialGroup> groupSet = null;
            if (groupData != null){
                groupSet = groupData.keySet();
            }
        %>
        <div align="center">
            <form action="search" method="post" name="searchField">
                    <fieldset>
                        <legend><%=ml.get("userSearch")%></legend> 
                        <%=ml.get("search")%>: <input type="text" name="searchText" value=<%=searchText%>><br>
                        <input type="submit" value="<%=ml.get("search")%>">
                    </fieldset>
    
            </form>
            <!-- Friends -->
            <%
                if (userSet != null && !userSet.isEmpty()) {
            %>
            <fieldset>
                <legend><%=ml.get("users")%></legend> 
                <table>
                    <%
                        for (User user: userSet) {
                            if (user != null && user.getId() != loggedUserId) {
                    %>
                    <tr>
                        <td>
                            <form action="addFriend" method="get" name="addFriend">
                                <input type="hidden" name="addUserId" value="<%=user.getId()%>">
                                <fieldset>
                                    <legend class="center-legend">
                                            <a href="getProfile?userId=<%=user.getId()%>"><%=user.getUsername()%></a>
                                            <%
                                                User.friendStatus friendStatus = (User.friendStatus)userData.get(user)[1];
                                                if (friendStatus == User.friendStatus.friends) { 
                                            %>
                                                <input type="submit" value="<%=ml.get("alreadyFriend")%>" disabled>  
                                            <%
                                                } else if (friendStatus == User.friendStatus.pending) {
                                            %>
                                                <input type="submit" value="<%=ml.get("petitionSent")%>" disabled>
                                            <%
                                                } else {
                                            %>
                                                <input type="submit" value="<%=ml.get("addFriend")%>">
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
                                            <%=user.getUsername()%><%=ml.get("noPostYet")%>
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
                    %>

                    </tr>
                </table>
            </fieldset>
            <%
                } else if(userSet != null) {
            %>
                <fieldset>
                    <legend><%=ml.get("users")%></legend>
                    <p><%=ml.get("noResultFound")%></p>
                </fieldset>
            <%
                }
            %>
            <!-- Groups -->
            <%
                if (groupSet != null && !groupSet.isEmpty()) {
            %>
            <fieldset>
                <legend><%=ml.get("groups")%></legend> 
                <table>
                    <%
                        for (SocialGroup group: groupSet) {
                            if (group != null) {
                    %>
                    <tr>
                        <td>
                            <form action="joinGroup" method="get" name="joinGroup">
                                <input type="hidden" name="groupId" value="<%=group.getId()%>">
                                <fieldset>
                                    <legend class="center-legend">
                                            <a href="groupWallServlet?groupId=<%=group.getId()%>"><%=group.getName()%></a>
                                            <%
                                                SocialGroup.membershipStatus memberStatus = (SocialGroup.membershipStatus)groupData.get(group)[1];
                                                if (memberStatus == SocialGroup.membershipStatus.member) { 
                                            %>
                                                <input type="submit" value="<%=ml.get("alreadyMember")%>" disabled>  
                                            <%
                                                } else if (memberStatus == SocialGroup.membershipStatus.pending) {
                                            %>
                                                <input type="submit" value="<%=ml.get("petitionSent")%>" disabled>
                                            <%
                                                } else {
                                            %>
                                                <input type="submit" value="<%=ml.get("joinGroup")%>">
                                            <%
                                                }
                                            %>
                                    </legend>
                                    <%
                                        Post p = (Post)groupData.get(group)[0];
                                        if (p != null) {
                                    %>
                                    <%=Markdown.toHtml(p.getBody())%>
                                    <%
                                        } else {
                                    %>
                                        <div class="italic">
                                            <%=group.getName()%><%=ml.get("noPostYet")%>
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
                    %>

                    </tr>
                </table>
            </fieldset>
            <%
                } else if(groupSet != null) {
            %>
                <fieldset>
                    <legend><%=ml.get("groups")%></legend>
                    <p><%=ml.get("noResultFound")%></p>
                </fieldset>
            <%
                }
            %>
        </div>
    </body>
</html>
