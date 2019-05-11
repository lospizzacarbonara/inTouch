    <%@page import="componentesHtml.MultiLanguage"%>
<%-- 
    Document   : error
    Created on : Apr 4, 2019, 9:09:22 AM
    Author     : jfaldanam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    <%
        String lang = (String) session.getAttribute("lang");
        if (lang == null)
            lang = "english";
        MultiLanguage ml = new MultiLanguage(lang, "friends");
    %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=ml.get("title")%></title>
        <style>
            h1 {
                color: red;
            }
            
            .dropdown {
                position: relative;
                display: inline-block;
             }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #f9f9f9;
                min-width: 160px;
                padding: 12px 16px;
                z-index: 1;
            }

            .dropdown:hover .dropdown-content {
                display: block;
            }
        </style>
    </head>
    <%String stacktrace = (String)request.getAttribute("stacktrace");%>
    <body>
        <h1><%=ml.get("thisError")%></h1>
        
        <p>
            <%
                if (stacktrace == null) {                
            %>
            
            <%=ml.get("noInfo")%> ¯\_(ツ)_/¯
            
            <%
            } else {
            %>
            <div class="dropdown">
                <input type="button" value="<%=ml.get("moreDetails")%>"/>
                <div class="dropdown-content">
                    <%=stacktrace%>
                </div>
            </div>
            <%
            }
            %>
        </p>
    </body>
</html>
