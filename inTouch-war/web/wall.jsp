<%-- 
    Document   : wall
    Created on : Apr 1, 2019, 9:29:09 AM
    Author     : Nellogy
--%>
<%@page import="inTouch.entity.SocialGroup"%>
<%@page import="componentesHtml.NavMenu"%>
<%@page import="markdownj.Markdown"%>
<%@page import="java.util.List"%>
<%@page import="inTouch.entity.Post"%>
<%@page import="inTouch.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    
    List<Post> globalPostList = (List<Post>)request.getAttribute("globalPostList");
    List<Post> privatePostList = (List<Post>)request.getAttribute("privatePostList");
    List<SocialGroup> groupList = (List<SocialGroup>)request.getAttribute("groupList");
    
%>

<html>
    <head>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
        <link rel="stylesheet" href="resources/css/inTouch.css">
        <link rel="stylesheet" href="resources/css/navmenu.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
          body {
              font-family: "Lato", sans-serif;
              background: #263238;
              color: white;
          }

          td {
              border-top: 1px solid white;
          }
          
          .groupList{
              vertical-align: top;
              border-right: 1px solid white;
          }
          
          .inviteList{
              vertical-align: top;
              border-left: 1px solid white;
              text-align: right;
          }

          .tablink {
              background-color: #555;
              color: white;
              border: none;
              outline: none;
              cursor: pointer;
              padding: 14px 16px;
              font-size: 17px;
              width: 25%;
          }

          .tablink:hover {
              background-color: #777;
          }

          /* Style the tab content */
          .tabcontent {
              color: black;
              display: none;
              padding: 50px;
          }

          .content{
              height:1000px;
          }

          .wallTable {
              border-collapse: separate;
              border-spacing: 5px 5px;
          }

          .tabButtons{
              padding-left: 5px;
              padding-right: 5px;
              width: 470px;
          }

          .groupHeader{
              width: 150px;
          }

          .inviteHeader{
              width: 150px;
          }

          .list{
              left: 50%;
          }

          .fixedButton {
              position: fixed;
              bottom: 75px;
              right: 570px;
          }

          .personalInfo{

          }
          
          .post {
              background: #37474f;
              border-radius: 8px;
              padding-left: 20px;
              padding-right: 20px;
              padding-top: 5px;
              padding-bottom: 10px;
              margin-top: 20px;
          }
          
          /* The Modal (background) */
          .modal {
              display: none; /* Hidden by default */
              position: fixed; /* Stay in place */
              z-index: 1; /* Sit on top */
              padding-top: 100px; /* Location of the box */
              left: 0;
              top: 0;
              width: 100%; /* Full width */
              height: 100%; /* Full height */
              overflow: auto; /* Enable scroll if needed */
              background-color: rgb(0,0,0); /* Fallback color */
              background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
           }
           
           /* Modal Content */
            .modal-content {
              background-color: #fefefe;
              margin: auto;
              padding: 20px;
              border: 1px solid #888;
              width: 80%;
            }

            /* The Close Button */
            .close {
              color: #aaaaaa;
              float: right;
              font-size: 28px;
              font-weight: bold;
            }

            .close:hover,
            .close:focus {
              color: #000;
              text-decoration: none;
              cursor: pointer;
            }
            
            #postModal{
                color: black;
            }
      </style>
</head>


<body>
    <!-- Options header -->
    <%=NavMenu.toHtml("home")%>
    
    <!-- Personal info  -->
    <div class="personalInfo" align="center">
        <h1>INFORMACION DEL USUARIO</h1>
    </div>

    <!-- Div for the wall on the main page (public/private) -->
    <table class="wallTable" align="center">
        <tr id="R1">
            <td class="groupHeader">
                <!-- Groups div -->
                <div>
                    <h1>GROUPS</h1>
                </div>
            </td>

            <td class="tabButtons">
                <div align="center">
                    <button class="tablink" onclick="openChat('Private', this, 'purple')" id="defaultOpen">Private</button>

                    <button class="tablink" onclick="openChat('Public', this, 'blue')">Public</button>
                </div>
            </td>

            <td class="inviteHeader">
                <!-- Invites div -->
                <div>
                    <h1>INVITES</h1>
                </div>
            </td>
        </tr>

        <tr>
            <td class="groupList">
                <% 
                    for(SocialGroup sg : groupList){
                %>
                <a href="#"><%=sg.getName()%></a> <!-- Hace falta saber como enlazarlos -->
                <% 
                    }
                %>
            </td>

            <td class="content">
                <div id="Public" class="tabcontent"><font color="white">
                    <% 
                        for(Post p: globalPostList){
                    %>
                    <div class="post">
                        <h3 align="center">
                            <i class="fa fa-user-circle" aria-hidden="true"></i>
                            <%=p.getAuthor().getUsername()%>
                        </h3>
                        <p><%=Markdown.toHtml(p.getBody())%></p>
                    </div>
                    <%
                        }
                    %>
                </font></div>

                <div id="Private" class="tabcontent"><font color="white">
                    <%
                        for(Post p: privatePostList){
                    %>
                    <div class="post">
                        <h3 align="center">
                            <i class="fa fa-user-circle" aria-hidden="true"></i>
                            <%=p.getAuthor().getUsername()%>
                        </h3>
                        <p><%=Markdown.toHtml(p.getBody())%></p>
                    </div>
                    <%
                        }
                    %>
                </font></div>
            </td>

            <td class="inviteList">
                <p>invite1</p>
                <p>invite2</p>
                <p>invite3</p>
            </td>
        </tr>
    </table>

    <!-- Up button -->
    <button class="fixedButton"><a href="#R1">UP</a></button>
    
    <!-- Post button -->
    <button id="postButton">Post</button>
    
    <!-- Post form -->
    <div id="postModal" class="modal" align="center">
        <div class="modal-content">
            <span class="close">&times;</span>
            <form id="postForm" method="POST" action="createPostServlet">
                <textarea rows="5" cols="50" name="body" form="postForm"></textarea><br/>
                Private <input type="checkbox" name="isPrivate" /><br/>
                <!-- date and author on servlet -->
                <input type="submit"/>
            </form>
        </div>
    </div>

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
