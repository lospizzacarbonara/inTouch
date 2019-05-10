<%-- 
    Document   : addToGroup
    Created on : 10-may-2019, 21:19:22
    Author     : darioarrebola
--%>

<%@page import="inTouch.entity.Post"%>
<%@page import="markdownj.Markdown"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="inTouch.entity.User"%>
<%@page import="componentesHtml.NavMenu"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
            Map<User, Object[]> userData = (Map<User, Object[]>) request.getAttribute("userData");
            int loggedUserId = (Integer) session.getAttribute("userId");

            Set<User> userSet = null;
            if (userData != null){
                userSet = userData.keySet();
            }
%>
<!DOCTYPE html>
<html>
    <head>
            <%=NavMenu.toHtml("")%>

            <title>Result list</title>
    </head>
    <body>
        <h1>Result list</h1>
        <!-- Friends -->
            <%
                if (userSet != null) {
            %>
            <fieldset>
                <legend>Amigos</legend> 
                <table>
                    <%
                        for (User user: userSet) {
                            if (user != null && user.getId() != loggedUserId) {
                    %>
                    <tr>
                        <td>
                            <form action="addToGroupServlet" method="get" name="sendMembershipInvitation">
                                <input type="hidden" name="addUserId" value="<%=user.getId()%>">
                                <fieldset>
                                    <legend class="center-legend">
                                            <a href="getProfile?userId=<%=user.getId()%>"><%=user.getUsername()%></a>
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
                    %>

                    </tr>
                </table>
            </fieldset>
            <%
                }
            %>

    </body>
</html>
