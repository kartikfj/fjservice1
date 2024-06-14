<%-- 
    Document   : expiresession 
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="resources/abc/style.css" rel="stylesheet" type="text/css" />
         <link href="resources/css/stylev2.css" rel="stylesheet" type="text/css" />
        <title>FJTCO</title>
    </head>
    <body>
<c:if test="${empty fjtuser.emp_code}">
             <jsp:forward page="index.jsp"/>
        </c:if>
        <c:if test="${!empty fjtuser}">
<c:if test="${pageContext.request.method eq 'POST' and empty param.choiceact}">
<div class="wrapper" id="choicebox">
<div class="login_box">
<img alt="FJTCO" src="resources/images/logo.jpg" />
                                <h2>FJ PORTAL </h2>
    <form  method="POST" action="expiresession.jsp">
<h2>A user is already logged in.</h2>
<div class="l_one" style="text-align: left !important;">
<input name="choiceact" value="expire" type="radio" style="float: left" checked="checked"/> <label>Log out and continue</label>
</div>
<div class="l_one" style="text-align: left !important;">
<input  name="choiceact" value="stay" type="radio" style="float: left" />
<label>Continue with the current login</label></div>

<div class="l_one">
<div class="bt_box"> <input name="proceed" value="Proceed" class="log_btn" type="submit" /></div>
</div>
<div class="clear"></div>
</form>
 <div class="footer_login">
                        <span class="footer-text">© 1988 - 2019 <a  target="_blank" href="http://www.faisaljassim.ae" rel="noopener noreferrer">FJ-Group</a>. All Rights Reserved.</span>
                        </div>
</div>
</div>
</c:if>  
            <c:if test="${pageContext.request.method eq 'POST' and !empty param.choiceact}">
                <c:choose>
                    <c:when test="${param.choiceact eq 'expire'}">
                        <jsp:forward page="logout.jsp"/>
                    </c:when>
                    <c:otherwise>
                        You can close this tab and go to already opened tab.
                    </c:otherwise>
                </c:choose>
                
           </c:if>
</c:if>
</body>
</html>
