<%-- 
    Document   : signUp
    Created on : May 11, 2019, 8:13:21 PM
    Author     : jfaldanam
--%>

<%@page import="componentesHtml.MultiLanguage"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    <%
        String lang = (String) session.getAttribute("lang");
        if (lang == null)
            lang = "english";
        MultiLanguage ml = new MultiLanguage(lang, "signUp");
    %>
<html>
    <head>
        <title><%=ml.get("title")%></title>
        <link rel="stylesheet" href="resources/css/inTouch.css">
        <link rel="stylesheet" href="resources/css/perfil.css">
        <link rel="stylesheet" href="resources/css/navmenu.css">
        <meta charset="UTF-8">
        <style type="text/css">
            div.littleText {
                font-size: 12px;
            }
        </style>
    </head>
    <body>
 
        <h1 align="center"><%=ml.get("registerHere")%></h1>
        <br/>
        <h2 align="center"><%=ml.get("introduceData")%>:</h2>
       

        <form method="get" action="signUpServlet" name="signUp" accept-charset="UTF-8">
            <div align="center">
            
            <%=ml.get("name")%>:<br/><input size="60" name="name"><br/>
            <br/>
            <%=ml.get("surname")%>:<br/><input size="60" name="surname"><br/>
            <br/>
            <%=ml.get("email")%>:<br/><input size="60" name="email"><br/>
            <br/>
            <%=ml.get("birthDate")%>: <br/><input type="date" name="date"><br/>
            <br/>
            <br/>
            <%=ml.get("username")%>:<br/><input size="40" name="username"><br/>
            <div class="littleText">
                <%=ml.get("warningNoChange")%>
            </div>
            <br/>
            <br/>
            <%=ml.get("password")%>:<br/><input type="password" size="40" name="password"><br/>
            <br/>
            
            <button><%=ml.get("send")%></button>
            </div>
        </form>
        
    </body>
</h