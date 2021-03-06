<%-- 
    Document   : wall
    Created on : Apr 1, 2019, 9:29:09 AM
    Author     : Nellogy
--%>
<%@page import="componentesHtml.MultiLanguage"%>
<%@page import="inTouch.entity.SocialGroup"%>
<%@page import="componentesHtml.NavMenu"%>
<%@page import="markdownj.Markdown"%>
<%@page import="java.util.List"%>
<%@page import="inTouch.entity.Post"%>
<%@page import="inTouch.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String lang = (String) session.getAttribute("lang");
    if (lang == null)
        lang = "english";
    MultiLanguage ml = new MultiLanguage(lang, "wall");
%>
<%
    
    List<Post> globalPostList = (List<Post>)request.getAttribute("globalPostList");
    List<Post> privatePostList = (List<Post>)request.getAttribute("privatePostList");
    List<SocialGroup> groupList = (List<SocialGroup>)request.getAttribute("groupList");
    List<User> friendInviteList = (List<User>)request.getAttribute("friendInviteList");
    List<SocialGroup> groupInviteList = (List<SocialGroup>)request.getAttribute("groupInviteList");
    User loggedUser = (User)request.getAttribute("user");
    
%>

<html>
    <head>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
        <link rel="stylesheet" href="resources/css/inTouch.css">
        <link rel="stylesheet" href="resources/css/navmenu.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title><%=ml.get("title")%></title>
    <style>
          td {
              border-top: 1px solid white;
          }
          
          h1{
              text-align: center;
          }
          
          ul{
              margin: 0;
              padding: 14px;
          }
          
          .groupList{
              vertical-align: top;
          }
          
          .inviteList{
              vertical-align: top;
          }

          .tablink {
              background-color: #555;
              color: white;
              border: none;
              border-radius: 8px;
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
              right: 380px;
              padding: 12px 28px;
          }
          
          #postButton {
              position: fixed;
              bottom: 75px;
              right: 280px;
              padding: 12px 28px;
          }

          textArea {
              font-family: Arial, Helvetica, sans-serif;
              color: black;
              background: #b0bec5;
              border: none;
              border-radius: 4px;
                  
          }
          
          .groupName {
              background: #b0bec5;
              border: none;
              border-radius: 4px;
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
              background-color: #37474f;
              margin: auto;
              padding: 20px;
              border: 1px solid #888;
              border-radius: 8px;
              width: 80%;
              color:white;
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
            
            #createGroupModal{
                color: black;
            }
      </style>
</head>


<body>
    <!-- Options header -->
    <%=NavMenu.toHtml("home")%>
    
    <!-- Personal info  -->
    <div class="personalInfo" align="center">
        <h1><%=ml.get("welcome")%>: <%=loggedUser.getName()%> <%=loggedUser.getSurname()%> (<%=loggedUser.getUsername()%>)</h1>
    </div>

    <!-- Div for the wall on the main page (public/private) -->
    <table class="wallTable" align="center">
        <tr id="R1">
            <td class="groupHeader">
                <!-- Groups div -->
                <div>
                    <h1><%=ml.get("groups")%></h1>
                </div>
            </td>

            <td class="tabButtons">
                <div align="center">
                    <button class="tablink" onclick="openChat('Private', this)" id="defaultOpen"><%=ml.get("private")%></button>

                    <button class="tablink" onclick="openChat('Public', this)"><%=ml.get("public")%></button>
                </div>
            </td>

            <td class="inviteHeader">
                <!-- Invites div -->
                <div>
                    <h1><%=ml.get("invites")%></h1>
                </div>
            </td>
        </tr>

        <tr>
            <td class="groupList">
                <br/>
                <ul>
                    <% 
                        for(SocialGroup sg : groupList){
                    %>
                    <li><a href="groupWallServlet?groupId=<%=sg.getId()%>"><%=sg.getName()%></a></li>
                    <br/>
                    <% 
                        }
                    %>
                </ul>
                <!-- createGroup button -->
                <br/>
                <button id="createGroupButton"><%=ml.get("createGroup")%></button>
            </td>

            <td class="content">
                <div id="Public" class="tabcontent">
                    <% 
                        for(Post p: globalPostList){
                    %>
                    <div class="box">
                        <h3 align="center">                
                            <a href="getProfile?userId=<%=p.getAuthor().getId()%>">
                                <i class="fa fa-user-circle" aria-hidden="true"></i>
                                <%=p.getAuthor().getUsername()%></a>
                        </h3>
                        <p><%=Markdown.toHtml(p.getBody())%></p>
                    </div>
                    <%
                        }
                    %>
                </div>

                <div id="Private" class="tabcontent">
                    <%
                        for(Post p: privatePostList){
                    %>
                    <div class="box">
                        <h3 align="center">
                            <a href="getProfile?userId=<%=p.getAuthor().getId()%>">
                                <i class="fa fa-user-circle" aria-hidden="true"></i>
                                <%=p.getAuthor().getUsername()%>
                            </a>
                            <%
                                if(p.getSocialGroup() != null){   
                                    SocialGroup sg = p.getSocialGroup();                     
                            %>
                                &nbsp;-&nbsp;
                                <a href="groupWallServlet?groupId=<%=sg.getId()%>">
                                    <%=sg.getName()%>
                                </a>
                            <%
                                }
                            %>
                        </h3>
                        <p><%=Markdown.toHtml(p.getBody())%></p>
                    </div>
                    <%
                        }
                    %>
                </div>
            </td>

            <td class="inviteList">
                <% if(!friendInviteList.isEmpty()){
                %>
                    <br/>
                    <h3><%=ml.get("friends")%></h3>
                    <hr/>
                    <%
                        for (User user: friendInviteList) {
                    %>
                        <fieldset class="thirdSize">
                            <legend class="center-legend">
                                <a href="getProfile?userId=<%=user.getId()%>"><%=user.getUsername()%></a>
                            </legend>
                            <form action="acceptFriend" method="post" name="acceptFriend">
                                    <input type="hidden" name="acceptUserId" value="<%=user.getId()%>"/>
                                    <input type="hidden" name="pageURL" value="wallServlet"/>
                                    <input type="submit" value="<%=ml.get("accept")%>"/>
                            </form>
                            <form action="cancelPendingFriend" method="post" name="cancelPendingFriend">
                                    <input type="hidden" name="cancelUserId" value="<%=user.getId()%>"/>
                                    <input type="hidden" name="pageURL" value="wallServlet"/>
                                    <input type="submit" value="<%=ml.get("deny")%>"/>
                            </form>
                        </fieldset>
                <%
                        }
                    }

                    if(!groupInviteList.isEmpty()){
                %>        
                    <br/>
                    <h3><%=ml.get("groups")%></h3>
                    <hr/>
                    <%
                        for (SocialGroup sg: groupInviteList) {
                    %>
                        <fieldset class="thirdSize">
                            <legend class="center-legend">
                                <a href="groupWallServlet?groupId=<%=sg.getId()%>"><%=sg.getName()%></a>
                            </legend>
                            <form action="acceptPendingInvitation" method="post" name="acceptGroup">
                                    <input type="hidden" name="acceptGroupId" value="<%=sg.getId()%>">
                                    <input type="hidden" name="pageURL" value="wallServlet"/>
                                    <input type="submit" value="<%=ml.get("accept")%>">
                            </form>
                            <form action="cancelPendingInvitation" method="post" name="rejectGroup">
                                    <input type="hidden" name="cancelGroupId" value="<%=sg.getId()%>">
                                    <input type="hidden" name="pageURL" value="wallServlet"/>
                                    <input type="submit" value="<%=ml.get("deny")%>">
                            </form>
                        </fieldset>
                <%
                        }
                    }
                %>
            </td>
        </tr>
    </table>

    <!-- Up button -->
    <a href="#R1"><button class="fixedButton"><%=ml.get("up")%></button></a>
    
    <!-- Post button -->
    <button id="postButton"><%=ml.get("post")%></button>
    
    <!-- Post form -->
    <div id="postModal" class="modal" align="center">
        <div class="modal-content">
            <span class="close">&times;</span>
            <div align="center"><p><%=ml.get("message")%></p></div>
            <form id="postForm" method="POST" action="createPostServlet">
                <textarea rows="5" cols="50" name="body" form="postForm"></textarea><br/><br/>
                <%=ml.get("public")%> <input type="checkbox" name="isPublic" /><br/>
                <!-- date and author on servlet -->
                <input type="submit" value="<%=ml.get("submit")%>"/>
            </form>
        </div>
    </div>
            
    <!-- Create group form -->
    <div id="createGroupModal" class="modal" align="center">
        <div class="modal-content">
            <span class="close">&times;</span>
            <form id="createGroupForm" method="POST" action="createGroupServlet">
                <div align="center"><p><%=ml.get("groupName")%></p></div>
                <input type="text" class="groupName" name="groupName" />
                <br/><br/><br/>
                <div align="center"><p><%=ml.get("groupDesc")%></p></div>
                <textarea rows="5" cols="50" name="body" form="createGroupForm"></textarea><br/><br/>
                <!-- date and author on servlet -->
                <input type="submit" value="<%=ml.get("submitGroup")%>"/>
            </form>
        </div>
    </div>

    <!-- post modal script -->
    <script>
        // Modal script
        let modal = document.getElementById("postModal");
        let btn = document.getElementById("postButton");
        let span = document.getElementsByClassName("close")[0];
        
        // Modal script
        let cgModal = document.getElementById("createGroupModal");
        let cgBtn = document.getElementById("createGroupButton");
        let cgSpan = document.getElementsByClassName("close")[1];
        
        btn.onclick = function() {
            if(modal.style.display !== "block"){
                modal.style.display = "block";
            } else {
                modal.style.display = "none";
            }
        };
        
        cgBtn.onclick = function() {
            if(cgModal.style.display !== "block"){
                cgModal.style.display = "block";
            } else {
                cgModal.style.display = "none";
            }
        };
        
        span.onclick = function() {
            modal.style.display = "none";
        };
        
        cgSpan.onclick = function() {
            cgModal.style.display = "none";
        };
        
        window.onclick = function(event) {
            if(event.target === modal){
                modal.style.display="none";
            }
            
            if(event.target === cgModal){
                cgModal.style.display="none";
            }
        };
    </script>

    <!-- Script for the tabs -->
    <script>
        function openChat(chatName, place) {
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
            place.style.backgroundColor = '#9b30ff';

        }
        
        // Get the element with id="defaultOpen" and click on it
        document.getElementById("defaultOpen").click();
    </script>

</body>
</html>
