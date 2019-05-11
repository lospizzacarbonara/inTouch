    <%-- 
    Document   : error
    Created on : Apr 4, 2019, 9:09:22 AM
    Author     : jfaldanam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error</title>
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
        <h1>This is an error</h1>
        
        <p>
            <%
                if (stacktrace == null) {                
            %>
            
            There is no info about this error ¯\_(ツ)_/¯
            
            <%
            } else {
            %>
            <div class="dropdown">
                <input type="button" value="More details"/>
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
