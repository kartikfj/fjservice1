<%-- 
    Document   : logout 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Calendar"%>
<%
  Calendar cal = Calendar.getInstance(); 
  int currYear = cal.get(Calendar.YEAR);   
 %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="resources/abc/style.css" rel="stylesheet" type="text/css" />
        <link href="resources/css/stylev2.css?v=02" rel="stylesheet" type="text/css" />
        <link href="resources/abc/responsive.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" href="resources/abc/bootstrap.min.css">
        <script src="resources/abc/jquery.min.js"></script>
        <script src="resources/abc/bootstrap.min.js"></script>
        <title>FJ-Group</title>
    
    </head>
    <body align="center">

        <%
            session.removeAttribute("fjtuser");
            session.removeAttribute("cmp_param");//holiday
            session.removeAttribute("holiday");//leave
            session.removeAttribute("leave");
            session.invalidate();
        %>
        <div class="container">
            <div class="login_box">
                <div class="l_msgbox"><label>You have logged out.</label></div>
                <div class="l_one"><label><a href="index.jsp" style="text-decoration:none;"> Go to Login page</a><label></div>
                            <div class="clear"></div>
                              <div class="footer_logout">
                        <span class="footer-text">© 1988 - <%=currYear%> <a target="_blank" href="http://www.faisaljassim.ae" rel="noopener noreferrer">FJ-Group</a>. All Rights Reserved.</span>
                        </div>
                            </div>
                            </div>
                            </body>
                            </html>
