<%-- 
    Document   : groupWall
    Created on : 29-abr-2019, 1:06:19
    Author     : darioarrebola
--%>

<%@page import="componentesHtml.MultiLanguage"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="inTouch.entity.SocialGroup"%>
<%@page import="componentesHtml.NavMenu"%>
<%@page import="markdownj.Markdown"%>
<%@page import="java.util.List"%>
<%@page import="inTouch.entity.Post"%>
<%@page import="inTouch.entity.User"%>


<!DOCTYPE html>
    <%
        String lang = (String) session.getAttribute("lang");
        if (lang == null)
            lang = "english";
        MultiLanguage ml = new MultiLanguage(lang, "groupWall");
    %>
<%
        List<User> userList = (List<User>)request.getAttribute("userList");
        List<Post> groupPostList = (List<Post>)request.getAttribute("groupPostList");
        String groupDescription = (String)request.getAttribute("groupDescription");
        SocialGroup group = (SocialGroup)request.getAttribute("group");
        //int currentGroupId = (Integer) session.getAttribute("groupId");
        int loggedUserId = (Integer) session.getAttribute("userId");
        //User user = new User(loggedUserId);
%>
<html> 
    <head>
        <title><%=ml.get("title")%></title>
        <link rel="stylesheet" href="resources/css/inTouch.css">
        <link rel="stylesheet" href="resources/css/navmenu.css">
        <style>

      </style>
</head>

<body> 
    <!-- Options header -->
    <%=NavMenu.toHtml("")%>
    
    <!-- Group info  -->
    <div class="Descripcion del grupo" align="center">
        <h1><%=group.getName()%></h1><br>
        <%=groupDescription%>
    </div>
    
                    <div class="memberList"align="center">
                    <div class="Members">
                        <h2><%=ml.get("members")%></h2>

                    <%
                        for(User u: userList){
                    %>
                            <a href="getProfile?userId=<%=u.getId() %>">             
                                <%=u.getUsername()%></a>
                       
                    <%
                        }
                    %>
                     </div>
                     
                </div>
        
        <table class="groupWallTable" align="center">
            <tr id="R1">

            <tr>
            <div class="Publicaciones" align="center">
                 <h1><%=ml.get("publications")%></h1>
            </div>
            <td class="content">
                <div id="Public" class="tabcontent">
                    <% 
                        for(Post p: groupPostList){
                    %>
                    <div class="box">
                        <h3 align="center">
                            <a href="getProfile?userId=<%=p.getAuthor().getId() %>">
                                <i class="fa fa-user-circle" aria-hidden="true"></i>
                                <%=p.getAuthor().getUsername()%></a>
                        </h3>
                                <p><%=Markdown.toHtml(p.getBody())%></p>
                    </div>
                    <%
                        }
                    %>
                </div>

               <!-- <div id="Private" class="tabcontent"><font color="white"> -->
             <!-- Un grupo podria poner post publicos o solo privados? -->
             

             </table>    
            
        
    
                <!-- Up button -->
    <a href="#R1"><button class="fixedButton"><%=ml.get("up")%></button></a>
    
    <!-- Post button -->
    <button id="postButton"><%=ml.get("post")%></button>
    <div id="postModal" class="modal" align="center">
        <div class="modal-content">
            <span class="close">&times;</span>
            <form id="postForm" method="POST" action="createGroupPostServlet?groupId=<%=group.getId()%>">
                <textarea rows="5" cols="50" name="body" form="postForm"></textarea><br/>
                <!--Make Public <input type="checkbox" name="isPublic" /><br/>
                <!-- date and author on servlet -->
                <input type="submit"/>
            </form>
        </div>
    </div>
                <h3><%=ml.get("searchUserToAdd")%></h3>    
                <form action="searchFromGroupServlet?groupId=<%=group.getId()%>" method="post" name="busqueda">
                    <fieldset>
                        <legend><%=ml.get("searchUser")%></legend> 
                        <%=ml.get("username")%>: <input type="text" name="searchText" value=""><br>
                        <input type="submit" value="<%=ml.get("search")%>">
                    </fieldset>
    
                </form>
                
                    <h3><%=ml.get("exitGroup")%></h3>
                    <form action="exitGroupServlet" method="post" name="exitGroup">
                        <input type="hidden" name="userId" value="<%=loggedUserId%>">
                        <input type="hidden" name="groupId" value="<%=group.getId()%>">
                        <input type="hidden" name="pageURL" value="wallServlet">
                        <input type="submit" value="<%=ml.get("exit")%>">

                    </form>
                
    <!-- modal script -->
    <script>
        // Modal script
        let modal = document.getElementById("postModal");
        let btn = document.getElementById("postButton");
        let span = document.getElementsByClassName("close")[0];
        
        btn.onclick = function() {
            if(modal.style.display !== "block"){
                modal.style.display = "block";
            } else {
                modal.style.display = "none";
            }
        };
        
        span.onclick = function() {
            modal.style.display = "none";
        };
        
        window.onclick = function(event) {
            if(event.target === modal){
                modal.style.display="none";
            }
        };
    </script>

    <!-- Script for the tabs -->
    <script>
        function openChat(chatName, place, color) {
            let i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablink");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].style.backgroundColor = "";
            }
            document.getElementById(chatName).style.display = "block";
            place.style.backgroundColor = color;

        }
        
        // Get the element with id="defaultOpen" and click on it
        document.getElementById("defaultOpen").click();
        </script>
    </body>
</html>


