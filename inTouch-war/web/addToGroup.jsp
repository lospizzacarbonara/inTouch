<%@page import="componentesHtml.MultiLanguage"%>
<%-- 
    Document   : addToGroup
    Created on : 10-may-2019, 21:19:22
    Author     : darioarrebola
--%>

<%@page import="inTouch.entity.SocialGroup"%>
<%@page import="inTouch.entity.Post"%>
<%@page import="markdownj.Markdown"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="inTouch.entity.User"%>
<%@page import="componentesHtml.NavMenu"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
            Map<User, Object[]> userData = (Map<User, Object[]>) request.getAttribute("userData");
            int loggedUserId = (Integer)session.getAttribute("userId");
            int currentGroupId = (Integer)request.getAttribute("groupId");

            Set<User> userSet = null;
            if (userData != null){
                userSet = userData.keySet();
            }
               
            String lang = (String) session.getAttribute("lang");
            if (lang == null)
            lang = "english";
            MultiLanguage ml = new MultiLanguage(lang, "addToGroup");
%>
<!DOCTYPE html>
<html>
    <head>
            
        <link rel="stylesheet" href="resources/css/inTouch.css">
        <link rel="stylesheet" href="resources/css/navmenu.css">

            <title><%=ml.get("title_resultList")%></title>
    </head>
    <body>
        <%=NavMenu.toHtml("")%>
        <h1><%=ml.get("resultList")%></h1>
        <!-- Friends -->
            <%
                if (userSet != null) {
            %>
            <fieldset>
                <legend><%=ml.get("friends")%></legend> 
                <table>
                    <%
                        for (User user: userSet) {
                            if (user != null && user.getId() != loggedUserId) {
                    %>
                    <tr>
                        <td>
                            <form action="addToGroupServlet" method="get" name="sendMembershipInvitation">
                                <input type="hidden" name="addUserId" value="<%=user.getId()%>">
                                <input type="hidden" name="groupId" value="<%=currentGroupId%>">
                                <input type="hidden" name="pageURL" value="groupWallServlet">
                                <fieldset>
                                    <legend class="center-legend">
                                            <a href="getProfile?userId=<%=user.getId()%>"><%=user.getUsername()%></a>
                                            <%
                                                SocialGroup.membershipStatus memberStatus = (SocialGroup.membershipStatus)userData.get(user)[1];
                                                if (memberStatus == SocialGroup.membershipStatus.member) { 
                                            %>
                                                <input type="submit" value="<%=ml.get("alreadyMember") %>" disabled>  
                                            <%
                                                } else if (memberStatus == SocialGroup.membershipStatus.pending) {
                                            %>
                                                <input type="submit" value="<%=ml.get("petitionSent") %>" disabled>
                                            <%
                                                } else {
                                            %>
                                                <input type="submit" value="<%=ml.get("addMember") %>">
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
                                            <%=user.getUsername()%> <%ml.get("noPostYet"); %>
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
                }
            %>

    </body>
</html>
