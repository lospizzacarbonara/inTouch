<%-- 
    Document   : groupWall
    Created on : 29-abr-2019, 1:06:19
    Author     : darioarrebola
--%>

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
        List<User> userList = (List<User>)request.getAttribute("userList");
        List<Post> groupPostList = (List<Post>)request.getAttribute("groupPostList");


%>
<html> 
    <head>
        <style>
          body {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
              font-family: "Lato", sans-serif;
              background: #263238;
              color: white;
          }

          td {
              border-top: 1px solid white;
          }
          
          .memberList{
              vertical-align: top;
              border-right: 1px solid white;
          }
          
          .nameTag{
              vertical-align: top;
              border-left: 1px solid white;
              text-align: right;
          }
          .groupDescription{
              vertical-align: top;
              border-right: 10px solid white;
              text-align: left;
              
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

          .groupWallTable {
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
    
    <!-- Group info  -->
    <div class="groupDescription" align="center">
        <h1>INFORMACION DEL GRUPO</h1>
    </div>
        
        <table class="groupWallTable" align="center">
        <tr id="R1">
            <td class="groupHeader">
                <!-- Groups div -->
            </td>


        </tr>

        <tr>
            <td class="memberList">
                <div id="Member" class="tabcontent"><font color ="purple"
                <%
                    for(User u: userList){
                 %>
                   <!-- u.getUsername() -->
                    

                <%
                    }
                 %>
            </td>

            <td class="content">
                <div id="Public" class="tabcontent">
                    <% 
                        for(Post p: groupPostList){
                    %>
                    <div class="box">
                        <h3 align="center">
                            <a href="getProfile?userId=<%=p.getAuthor().getId() %>">
                                <i class="fa fa-user-circle" aria-hidden="true"></i>
                                <%=p.getAuthor().getUsername()%>
                        </h3>
                        <p><%=Markdown.toHtml(p.getBody())%></p>
                    </div>
                    <%
                        }
                    %>
                </div>

               <!-- <div id="Private" class="tabcontent"><font color="white"> -->
                     <!-- Un grupo podria poner post publicos o solo privados? -->

                    <%
                        for(User u: userList){
                    %>
                    <!--esto va al carrer -->
                    <div class="post">
                        <h3 align="center">
                            <i class="fa fa-user-circle" aria-hidden="true"></i>
                        <p><%=Markdown.toHtml(u.getUsername())%></p>
                        </h3>
                    </div>
                    <%
                        }
                    %>
                </font></div>
            </td>
        </tr>
    </table>
                <!-- Up button -->
    <button class="fixedButton"><a href="#R1">UP</a></button>
    
    <!-- Post button -->
    <button id="postButton">Post</button>
    <!-- Post form Este no tengo ni muy claro como va-->
    <div id="postModal" class="modal" align="center">
        <div class="modal-content">
            <span class="close">&times;</span>
            <form id="postForm" method="POST" action="createPostServlet">
                <textarea rows="5" cols="50" name="body" form="postForm"></textarea><br/>
                Make Public <input type="checkbox" name="isPublic" /><br/>
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


