<%-- 
    Document   : wall
    Created on : Apr 1, 2019, 9:29:09 AM
    Author     : Nellogy
--%>
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
    
%>

<html>
    <head>
        <link rel="stylesheet" href="resources/css/inTouch.css">
        <link rel="stylesheet" href="resources/css/navmenu.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
          body {
              font-family: "Lato", sans-serif;
          }

          table, td, tr {
              border: 1px solid black;
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
              text-align: center;
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

          #fixedbutton {
              position: fixed;
              bottom: 75px;
              right: 570px;
          }

          .personalInfo{

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
            <td class="list">
                <p>group1</p>
                <p>group2</p>
                <p>group3</p>
            </td>

            <td class="content">
                <div id="Public" class="tabcontent" align="center">
                    <% 
                        for(Post p: globalPostList){
                    %>
                    <h1><%=p.getAuthor().getUsername()%></h1>
                    <%=Markdown.toHtml(p.getBody())%>
                    <%
                        }
                    %>
                </div>

                <div id="Private" class="tabcontent" align="center">
                    <%
                        for(Post p: privatePostList){
                    %>
                    <h1><%=p.getAuthor().getUsername()%></h1>
                    <%=Markdown.toHtml(p.getBody())%>
                    <%
                        }
                    %>
                </div>
            </td>

            <td class="list">
                <p>invite1</p>
                <p>invite2</p>
                <p>invite3</p>
            </td>
        </tr>
    </table>

    <!-- Up button -->
    <button id="fixedbutton"><a href="#R1">UP</a></button>


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
