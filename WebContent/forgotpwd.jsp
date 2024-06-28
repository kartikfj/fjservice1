<%-- 
    Document   : forgotpwd 
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
        response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
        response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
        response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
        response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
%>
<jsp:useBean id="fjtuser" class="beans.fjtcouser" scope="session"/> 
<!DOCTYPE html>

    <head>
       
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title>Faisal Jassim Trading Co L L C</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
         <link href="resources/abc/style.css" rel="stylesheet" type="text/css" />
         <link href="resources/css/stylev2.css" rel="stylesheet" type="text/css" />
       </head>
    <body>
        <c:if test="${empty fjtuser.emp_code}">
             <jsp:forward page="index.jsp"/>
        </c:if>
        <c:if test="${!empty fjtuser}">
            <c:if test="${pageContext.request.method != 'POST'}">
   
<div class="wrapper" id="choicebox">
<div class="login_box">
<img alt="FJTCO" src="resources/images/logo.jpg" />
                                <h2>FJ PORTAL </h2>
<form  method="POST" action="forgotpwd.jsp">
<h2>Forgot password </h2>
<div class="l_one">
<input name="forgotact" value="sendpwd" type="radio" style="float: left" checked="checked"/> <label>Send me new password via email</label>
</div>
<div class="l_one">
<input  name="forgotact" value="backhome" type="radio" style="float: left" />
<label>Take me back to login page</label></div>

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
    <c:if test="${pageContext.request.method eq 'POST'}">
        
        <c:if test="${param.forgotact eq 'sendpwd'}">   
            <c:if test="${!empty fjtuser.emailid}">
            <jsp:useBean id="pwdgen" class="utils.PasswordGenerator" scope="request" /> 
             <c:set var="newpwdmsg" value="Your new password is : " scope="request"/>
            <c:set var="newpwd" value="${requestScope.pwdgen.randomPassword}" scope="request"/>  
            <jsp:setProperty name="fjtuser" property="form_pwd" value="${requestScope.newpwd}"/>
             <c:set var="mailstatus" value="${fjtuser.changeForgottenPwd}"/>                       
                    <div class="wrapper"><div class="login_msgbox">
                    <c:choose>
                     <c:when test="${mailstatus eq 1}">
                         <div class="l_one"> New password sent. Go <a href="index.jsp" style="text-decoration:none; color: white">home</a></div><br/>
                     </c:when>  
                   
                     <c:when test="${mailstatus eq 0}">
                     <div class="l_one">No  mail details available. Failed to send password. Go <a href="index.jsp" style="text-decoration:none; color: white">home</a></div>
                    </c:when>  
                    <c:when test="${mailstatus eq -1}">
                     <div>Failed to send password Go <a href="index.jsp" style="text-decoration:none; color: white">home</a></div>
                  </c:when>
                  <c:when test="${mailstatus eq -2}">
                      <div class="l_one"> DB Error Go <a href="index.jsp" style="text-decoration:none; color: white">home</a></div>   
                  </c:when>
                    </c:choose>                      
                    </div></div>                   
            </c:if>
            <c:if test="${empty fjtuser.emailid}">
                <c:out value="No mail id found" />
            </c:if>
         <%
             session.invalidate();
          %>
       </c:if>
        <c:if test="${param.forgotact eq 'backhome'}"> 
            <%
             session.invalidate();
          %>
            <jsp:forward page="index.jsp"/>
            
            
        </c:if>
    </c:if>

        </c:if>
        
        
    </body>
</html>
    