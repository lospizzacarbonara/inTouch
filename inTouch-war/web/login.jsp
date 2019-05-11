<%-- 
    Document   : login
    Created on : 01-abr-2019, 9:13:40
    Author     : Toshiba
--%>

<%@page import="componentesHtml.MultiLanguage"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    <%
        String lang = (String) session.getAttribute("lang");
        if (lang == null)
            lang = "english";
        MultiLanguage ml = new MultiLanguage(lang, "login");
    %>
<html>
    <head>
        <title><%=ml.get("title")%></title>
        <link rel="stylesheet" href="resources/css/inTouch.css">
        <style type="text/css">
            #Error {color: red}
        </style>
        <meta charset="UTF-8">
    </head>
    <body>
 
        <h1 align="center"><%=ml.get("welcome")%></h1>
        <br/>
        <h2 align="center"><%=ml.get("introduceData")%></h2>
       

        <form method="post" action="loginServlet" name="login" accept-charset="UTF-8">
            <p align="center">
            <%=ml.get("username")%>:<br/><input size="40" name="user"><br/>
            <br/>
            <%=ml.get("password")%>:<br/><input type="password" size="40" name="password"><br/>
            <br/>
            
            <button><%=ml.get("logIn")%></button>
            </p>
        </form>
        <% Boolean login = (Boolean)request.getAttribute("login");
                        if (login != null && !login) {
        %>
        <br/>
        <p id="Error" align="center">
        <%=ml.get("errorUsernameOrPassword")%>
        </p>
        <br/>
         <%
                       }
         %> 
         <h3 align="center"> <%=ml.get("or")%> </h3>  
         
        <h2 align="center"><%=ml.get("registerApplication")%></h2>
            <p align="center">
            <button class="enlace" role="link" onclick="window.location='signUp.jsp'"><%=ml.get("register")%></button>
            </p>
    </body>
</html>
