<%-- 
    Document   : forgotpwd 
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    response.setHeader("Cache-Control", "no-cache"); //Forces caches to obtain a new copy of the page from the origin server
    response.setHeader("Cache-Control", "no-store"); //Directs caches not to store the page under any circumstance
    response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0 backward compatibility
%>
<jsp:useBean id="fjtuser" class="beans.fjtcouser" scope="session"/> 
<!DOCTYPE html>

<head>

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title>Faisal Jassim Trading Co L L C</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="resources/abc/style.css" rel="stylesheet" type="text/css" />
    <link href="resources/css/stylev2.css" rel="stylesheet" type="text/css" />
    <link href="resources/abc/responsive.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <c:if test="${empty fjtuser.emp_code}">
        <jsp:forward page="index.jsp"/>
    </c:if>
    <c:if test="${!empty fjtuser}">


        <c:if test="${pageContext.request.method eq 'POST'}">
            <c:choose>
                <c:when test="${param.forgotact eq 'sendpwd'}">                 
                    <c:if test="${!empty fjtuser.emailid}"> ${fjtuser.emailid}                
                        <jsp:useBean id="pwdgen" class="utils.PasswordGenerator" scope="request" /> 
                        <c:set var="newpwdmsg" value="Your new password is : " scope="request"/>
                        <c:set var="newpwd" value="${requestScope.pwdgen.randomPassword}" scope="request"/>  
                        <jsp:setProperty name="fjtuser" property="form_pwd" value="${requestScope.newpwd}"/>
                        <c:set var="mailstatus" value="${fjtuser.registeruser}"/>                                               
                        <div class="wrapper"><div class="login_msgbox">
                                <c:choose>
                                    <c:when test="${mailstatus eq 1}">
                                        <div class="l_one" > <div style="font-family:Arial, Helvetica, sans-serif; font-size:0.9em;color: #333;">Your password is sent to your email. Go <a href="index.jsp" style="text-decoration:none; color: white">home</a></div></div><br/>
                                    </c:when>  

                                    <c:when test="${mailstatus eq 0}">
                                        <div class="l_one"> <div style="font-family:Arial, Helvetica, sans-serif; font-size:0.9em;color: #333;">No  mail details available. Failed to send password. Please contact IT Department. <div> </div>
                                            </c:when>  
                                            <c:when test="${mailstatus eq -1}">
                                                <div><div style="font-family:Arial, Helvetica, sans-serif; font-size:0.9em;color: #333;">Failed to send password. Please try again later . </div></div>
                                            </c:when>
                                            <c:when test="${mailstatus eq -2}">
                                                <div class="l_one"><div style="font-family:Arial, Helvetica, sans-serif; font-size:0.9em;color: #333;"> DB Error . Please try again later .</div></div>   
                                            </c:when>
                                        </c:choose>                      
                                    </div></div>                   
                                </c:if>

                            <c:if test="${empty fjtuser.emailid}">
                                <c:out value="No mail id found" />
                                <%
                                    System.out.println("no user email");
                                %>
                            </c:if>
                            <%
                                session.invalidate();
                            %>
                        </c:when>
                        <c:when test="${param.forgotact eq 'backhome'}"> 

                            <%
                                session.invalidate();
                            %>
                            <jsp:forward page="index.jsp"/>


                        </c:when>
                        <c:otherwise>
                         
                            <div class="wrapper" id="choicebox">
                                <div class="login_box" >
                                <img alt="FJTCO" src="resources/images/logo.jpg" />
                                <h2>FJ PORTAL </h2>
                                    <form  method="POST" action="registernewuser.jsp">
                                        
                                        <h2>New user registration </h2>
                                        <div class="l_one"  style="text-align: left !important;">
                                            <input name="forgotact" value="sendpwd" type="radio" style="float: left" checked="checked"/> <label style="font-family:Arial, Helvetica, sans-serif; font-size:0.9em;color: #333">Welcome new user! Your password will be sent to your emailid.  </label>
                                        </div>
                                        <div class="l_one" style="text-align: left !important;">
                                            <input  name="forgotact" value="backhome" type="radio" style="float: left" />
                                            <label style="font-family:Arial, Helvetica, sans-serif; font-size:0.9em;color: #333;">Take me back to login page</label></div>

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
                        </c:otherwise>
                    </c:choose>
                </c:if>

            </c:if>


            </body>
            </html>
