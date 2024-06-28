<%-- 
    Document   : index 
--%>

<%@page import="java.net.InetAddress"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<%@ taglib uri="http://java.sun.com/jstl/sql" prefix="sql" %>
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
        <title>FJ Group</title>
        <link href="resources/abc/style.css?v=27052022-04" rel="stylesheet" type="text/css" />
         <link href="resources/abc/responsive.css" rel="stylesheet" type="text/css" />
        <link href="resources/css/stylev2.css?v=27052022-04" rel="stylesheet" type="text/css" />
        <script src="resources/js/login.js?v=04092019"></script>
        <link rel="stylesheet" href="resources/abc/bootstrap.min.css">
        <script src="resources/abc/jquery.min.js"></script>
        <script src="resources/abc/bootstrap.min.js"></script>  
 <style>  .modal{background: white;} .modal-header {   background: #226a90;  border-bottom: 1px solid #226a90;}.modal-body{ background: #226a90;}</style>
 <script type="text/javascript"> $(document).ready(function(){
	 $("#showEmergencyNo").click(function () { 
		 $("#emergency").modal('show');  
		 }); 
	 }); 
 </script>
        <sql:query var="rs" dataSource="jdbc/mysqlfjtcolocal">
            SELECT * FROM newfjtco.HELPDESKDETAILS
        </sql:query>   

    </head>
    <c:choose>
        <c:when test="${pageContext.request.method != 'POST'}"> 
            <body align="center" onload="return setFields();" class="fjportal">
                <div class="container">
                    <div class="login_box"><img alt="FJTCO" src="resources/images/logo.jpg" />
                        <h2>FJ Portal</h2>
                        <form method="POST" action="index.jsp" onsubmit="return checklogin();">       
                            <div class="l_one" >                          
                                <input class="leave_text" type="text" name="uid" size="20" id="fjuid" placeholder="User id" tabindex="1" onblur="return checkUid(this);" onkeypress="verifyEnter(event);"/> 
                             </div>                          
                            <div class="l_one">                        
                                <input class="leave_text" type="password" name="passwd" size="20" id="fjpwd" placeholder="Password"  tabindex="2" onblur="return setSubType();" onkeypress="verifyEnterInPwd(event);"/> </div>
                            <div class="l_one">
                                <div class="n_text2"></div>
                            </div>
                            <div class="l_one">
                                <input type="hidden" name="ll" id="ll" value="<%=System.currentTimeMillis()%>" /> 
                                <input type="hidden" name="subtype" value="" id="subtype" /> 
                                <div class="bt_box"> <input type="submit" value="Login" name="login" tabindex="3" class="log_btn" id="login_but"/></div>
                            </div>
                            <div class="l_one"><a href="forgotpwd.jsp" style="text-decoration:none;" onclick="return verifyUid();">Forgot your password?</a></div>

                            <div class="clear"></div>
                        </form>
                        <div class="footer_login">
	                        <button class="btn btn-xs btn-danger text-right" id="showEmergencyNo">Emergency Numbers</button><br/>	
	                         <c:forEach var="current" items="${rs.rows}"> 
		                         <span class="footer-text">Help Desk : ${current.ename}</span><br/>
		                         <span class="footer-text">Email : ${current.emailid}</span>  &nbsp;  &nbsp; &nbsp; &nbsp;<span class="footer-text">Extension : ${current.extension}</span> <br/> 
	                         </c:forEach>	                                         
	                        <span class="footer-text">© 1988 - <%=currYear%> <a  target="_blank" href="http://www.faisaljassim.ae" rel="noopener noreferrer">FJ-Group</a>. All Rights Reserved.</span>
                        </div>
                    </div>
                </div> 
            </c:when>
            <c:otherwise>                           
                <%
                    Object referrer = request.getAttribute("javax.servlet.forward.request_uri");
                    if (referrer == null) {
                %>             
                <jsp:useBean id="fjtuser" class="beans.fjtcouser" scope="session"/>   
                <jsp:setProperty name="fjtuser" property="form_uid" param="uid"/>
                <c:choose>
                    <c:when test="${param.subtype eq 'uidchk'}">
                        <c:set var="loginstatus" value="${sessionScope.fjtuser.checkUid}"/> 
                        <c:choose>
                            <c:when test="${loginstatus eq 2}">
                                <div class="l_one"> New user</div>
                                <jsp:forward page="registernewuser.jsp"/>
                            </c:when>
                            <c:when test="${loginstatus eq 1}">
                            <body align="center" onload="return focusPwd();">
                                <div class="container">
                                    <div class="login_box"><img alt="FJTCO" src="resources/images/logo.jpg" />
                                         <h2>FJ Portal</h2>
                                        <form method="POST" action="index.jsp" onsubmit="return checklogin();">       
                                            <div class="l_one">
                                                <input class="leave_text" type="text" name="uid" size="20" id="fjuid"  placeholder="User id" tabindex="1" value="${param.uid}" onkeypress="verifyEnter(event);" onblur="return checkUid(this);" /> </div>
                                            <div class="l_one">
                                                <input class="leave_text" type="password" name="passwd" size="20" id="fjpwd" placeholder="Password" tabindex="2" onblur="return setSubType();" onkeypress="verifyEnterInPwd(event);"/> </div>
                                            <div class="l_one">
                                                <div class="n_text2"></div>
                                            </div>
                                            <div class="l_one">
                                                <input type="hidden" name="ll" id="ll" value="<%=System.currentTimeMillis()%>" /> 
                                                <input type="hidden" name="subtype" value="pwd" id="subtype" /> 
                                                <div class="bt_box"> <input type="submit" value="Login" name="login" tabindex="3" class="log_btn" id="login_but"/></div>
                                            </div>

                                            <div class="l_one"><a href="forgotpwd.jsp" style="text-decoration:none; " onclick="return verifyUid();">Forgot your password?</a></div>
                                            <div class="clear">                                            
                                            <%-- <div class="footer_login">
		                                         <span class="footer-text">© 1988 - <%=currYear%> 
		                                         <a  target="_blank" href="http://www.faisaljassim.ae" rel="noopener noreferrer">FJ-Group</a>. All Rights Reserved.</span>
                                            </div>--%>
                                            </div>
                                        </form>
                                        <div class="footer_login">
					                        <button class="btn btn-xs btn-danger text-right" id="showEmergencyNo">Emergency Numbers</button><br/>
					                        <c:forEach var="current" items="${rs.rows}"> 
						                         <span class="footer-text">Help Desk : ${current.ename}</span><br/>
						                         <span class="footer-text">Email : ${current.emailid}</span>  &nbsp;  &nbsp; &nbsp; &nbsp;<span class="footer-text">Extension : ${current.extension}</span> <br/> 
					                        </c:forEach>					                        
					                        <span class="footer-text">© 1988 - <%=currYear%> <a  target="_blank" href="http://www.faisaljassim.ae" rel="noopener noreferrer">FJ-Group</a>. All Rights Reserved.</span>
				                        </div>
                                    </div>
                                </div>   
                            </c:when>
                            <c:when test="${loginstatus eq -1}">
                                <%
                                    session.removeAttribute("fjtuser");
                                    session.invalidate();
                                %>
                            <body align="center" onload="return setFields();">
                                <div class="container">
                                    <div class="login_box"><img alt="FJTCO" src="resources/images/logo.jpg" />
                                         <h2>FJ Portal</h2>
                                        <form method="POST" action="index.jsp" onsubmit="return checklogin();" >       
                                            <div class="l_one">
                                                <input class="leave_text" type="text" name="uid" size="20" id="fjuid" placeholder="User id" tabindex="1" onblur="return checkUid(this);" onkeypress="verifyEnter(event);"/> </div>
                                            <div class="l_one">
                                                <input class="leave_text" type="password" name="passwd" size="20" id="fjpwd" placeholder="Password" tabindex="2" onblur="return setSubType();" onkeypress="verifyEnterInPwd(event);"/> </div>
                                            <div class="l_one">
                                                <div class="n_text2"></div>
                                            </div>
                                            <div class="l_one">
                                                <input type="hidden" name="ll" id="ll" value="<%=System.currentTimeMillis()%>" /> 
                                                <input type="hidden" name="subtype" value="" id="subtype" /> 
                                                <div class="bt_box"> <input type="submit" value="Login" name="login" tabindex="3" class="log_btn" id="login_but" /></div>
                                            </div>
                                            <div class="l_one"><a href="forgotpwd.jsp" style="text-decoration:none; " onclick="return verifyUid();">Forgot your password?</a></div>

                                        </form>
                                        <div class="l_one" style="text-decoration:none; color: red">Invalid login</div>
                                        <div class="clear"></div>
                                        <div class="footer_login">
					                        <button class="btn btn-xs btn-danger text-right" id="showEmergencyNo">Emergency Numbers</button><br/>
					                        <c:forEach var="current" items="${rs.rows}"> 
						                         <span class="footer-text">Help Desk : ${current.ename}</span><br/>
						                         <span class="footer-text">Email : ${current.emailid}</span>  &nbsp;  &nbsp; &nbsp; &nbsp;<span class="footer-text">Extension : ${current.extension}</span> <br/> 
					                        </c:forEach>
					                        <span class="footer-text">© 1988 - <%=currYear%> <a  target="_blank" href="http://www.faisaljassim.ae" rel="noopener noreferrer">FJ-Group</a>. All Rights Reserved.</span>
					                    </div>
                                         <%-- <div class="footer_login">
                                         <span class="footer-text">© 1988 - <%=currYear%> 
                                         <a  target="_blank" href="http://www.faisaljassim.ae" rel="noopener noreferrer">FJ-Group</a>. All Rights Reserved.</span>
                                         </div> --%>
                                        </div>
                                </div> 

                            </c:when>
                            <c:when test="${loginstatus eq -4}">
                                <jsp:forward page="expiresession.jsp"/>
                            </c:when>                            
                            <c:otherwise>
                            <body align="center" onload="return setFields();">
                                <div class="container">
                                    <div class="login_box"><img alt="FJTCO" src="resources/images/logo.jpg" />
                                         <h2>FJ Portal</h2>
                                        <form method="POST" action="index.jsp" onsubmit="return checklogin();">       
                                            <div class="l_one">
                                                <input class="leave_text" type="text" name="uid" size="20" id="fjuid" placeholder="User id" tabindex="1" onblur="return checkUid(this);" onkeypress="verifyEnter(event);"/> </div>
                                            <div class="l_one">
                                                <input class="leave_text" type="password" name="passwd" size="20" id="fjpwd" placeholder="Password" tabindex="2" onblur="return setSubType();" onkeypress="verifyEnterInPwd(event);"/> </div>
                                            <div class="l_one">
                                                <div class="n_text2"></div>
                                            </div>
                                            <div class="l_one">
                                                <input type="hidden" name="ll" id="ll" value="<%=System.currentTimeMillis()%>" /> 
                                                <input type="hidden" name="subtype" value="" id="subtype" /> 
                                                <div class="bt_box"> <input type="submit" value="Login" name="login" tabindex="3" class="log_btn"  id="login_but"/></div>
                                            </div>
                                            <div class="l_one"><a href="forgotpwd.jsp" style="text-decoration:none; " onclick="return verifyUid();">Forgot your password?</a></div>

                                        </form>
                                        <div class="l_one" style="text-decoration:none; color: red">  <%-- DB Error--%>Something went wrong... <br/> Please contact IT fghhfgh</div>  
                                        <div class="clear"></div>
                                        <div class="footer_login">
					                        <button class="btn btn-xs btn-danger text-right" id="showEmergencyNo">Emergency Numbers</button><br/>
					                        <c:forEach var="current" items="${rs.rows}"> 
						                         <span class="footer-text">Help Desk : ${current.ename}</span><br/>
						                         <span class="footer-text">Email : ${current.emailid}</span>  &nbsp;  &nbsp; &nbsp; &nbsp;<span class="footer-text">Extension : ${current.extension}</span> <br/> 
					                        </c:forEach>
					                        <span class="footer-text">© 1988 - <%=currYear%> <a  target="_blank" href="http://www.faisaljassim.ae" rel="noopener noreferrer">FJ-Group</a>. All Rights Reserved.</span>
					                    </div>
                                        <%-- <div class="footer_login">
                                         <span class="footer-text">© 1988 - <%=currYear%> 
                                         <a  target="_blank" href="http://www.faisaljassim.ae" rel="noopener noreferrer">FJ-Group</a>. All Rights Reserved.</span>
                                         </div>--%>
                                        </div>
                                </div> 

                            </c:otherwise>
                        </c:choose>

                    </c:when>                  
                    <c:when test="${param.subtype eq 'pwd'}">
                        <jsp:setProperty name="fjtuser" property="form_pwd" param="passwd"/>  
                        <c:set var="loginstatus" value="${sessionScope.fjtuser.checkLogin}"/>                              
                        <c:choose>
                            <c:when test="${loginstatus eq 2}">
                                <div class="l_one"> New user</div>
                                <jsp:forward page="registernewuser.jsp"/>
                            </c:when>  
                            <c:when test="${loginstatus eq 1}">
                                <div class="l_one"> Regular user </div>
                                <jsp:useBean id="holiday" class="beans.Holiday" scope="session"/>
                                <jsp:setProperty name="holiday" property="compCode" value="${fjtuser.emp_com_code}"/>
                                <jsp:useBean id="cmp_param" class="beans.CompParam" scope="session"/>   
                                <jsp:setProperty name="cmp_param" property="companyCode" value="${fjtuser.emp_com_code}"/>
                                <jsp:useBean id="leave" class="beans.Leave" scope="session"/>
                                <jsp:setProperty name="leave" property="emp_code" value="${fjtuser.emp_code}"/>
                                <jsp:setProperty name="leave" property="emp_comp_code" value="${fjtuser.emp_com_code}"/>
                                <jsp:setProperty name="leave" property="cur_procm_startdt" value="${cmp_param.currentProcMonthStartDate}"/>                   
                                <jsp:useBean id="attendance" class="beans.Attendance" scope="session"/>
                                
                            
                               <% String site = new String("homepage.jsp");
						         response.setStatus(response.SC_MOVED_TEMPORARILY);
						         response.setHeader("Location", site); %>
                           
        
                            </c:when>  
                            <c:when test="${loginstatus eq 0}">
                                <%
                                    session.removeAttribute("fjtuser");
                                    session.invalidate();
                                %>
                            <body align="center" onload="return setFields();">
                                <div class="container">
                                    <div class="login_box"><img alt="FJTCO" src="resources/images/logo.jpg" />
                                         <h2>FJ Portal</h2>
                                        <form method="POST" action="index.jsp" onsubmit="return checklogin();">       
                                            <div class="l_one">
                                                <input class="leave_text" type="text" name="uid" size="20" id="fjuid" placeholder="User id" tabindex="1" onblur="return checkUid(this);" onkeypress="verifyEnter(event);"/> </div>
                                            <div class="l_one">
                                                <input class="leave_text" type="password" name="passwd" size="20" id="fjpwd" placeholder="Password" tabindex="2" onblur="return setSubType();" onkeypress="verifyEnterInPwd(event);"/> </div>
                                            <div class="l_one">
                                                <div class="n_text2"></div>
                                            </div>
                                            <div class="l_one">
                                                <input type="hidden" name="ll"  id="ll" value="<%=System.currentTimeMillis()%>" /> 
                                                <input type="hidden" name="subtype" value="" id="subtype" /> 
                                                <div class="bt_box"> <input type="submit" value="Login" name="login" tabindex="3" class="log_btn" id="login_but"/></div>
                                            </div>
                                            <div class="l_one"><a href="forgotpwd.jsp" style="text-decoration:none;" onclick="return verifyUid();">Forgot your password?</a></div>

                                        </form>
                                        <div class="l_one" style="text-decoration:none; color: red">Wrong password.</div>
                                        <div class="clear"></div>
                                        <div class="footer_login">
					                        <button class="btn btn-xs btn-danger text-right" id="showEmergencyNo">Emergency Numbers</button><br/>
					                        <c:forEach var="current" items="${rs.rows}"> 
						                         <span class="footer-text">Help Desk : ${current.ename}</span><br/>
						                         <span class="footer-text">Email : ${current.emailid}</span>  &nbsp;  &nbsp; &nbsp; &nbsp;<span class="footer-text">Extension : ${current.extension}</span> <br/> 
					                        </c:forEach>					                       
					                        <span class="footer-text">© 1988 - <%=currYear%> <a  target="_blank" href="http://www.faisaljassim.ae" rel="noopener noreferrer">FJ-Group</a>. All Rights Reserved.</span>
				                        </div>
                                        <%-- <div class="footer_login">
                                         <span class="footer-text">© 1988 - <%=currYear%> 
                                         <a  target="_blank" href="http://www.faisaljassim.ae" rel="noopener noreferrer">FJ-Group</a>. All Rights Reserved.</span>
                                         </div>--%>
                                        </div>
                                </div> 

                            </c:when>  
                            <c:when test="${loginstatus eq -1}">
                                <%
                                    session.removeAttribute("fjtuser");
                                    session.invalidate();
                                %>
                            <body align="center" onload="return setFields();">
                                <div class="container">
                                    <div class="login_box"><img alt="FJTCO" src="resources/images/logo.jpg" />
                                         <h2>FJ Portal</h2>
                                        <form method="POST" action="index.jsp" onsubmit="return checklogin();">       
                                            <div class="l_one">
                                                <input class="leave_text" type="text" name="uid" size="20" id="fjuid" placeholder="User id" tabindex="1" onblur="return checkUid(this);" onkeypress="verifyEnter(event);"/> </div>
                                            <div class="l_one">
                                                <input class="leave_text" type="password" name="passwd" size="20" id="fjpwd" placeholder="Password" tabindex="2" onblur="return setSubType();" onkeypress="verifyEnterInPwd(event);"/> </div>
                                            <div class="l_one">
                                                <div class="n_text2"></div>
                                            </div>
                                            <div class="l_one">
                                                <input type="hidden" name="ll"  id="ll" value="<%=System.currentTimeMillis()%>" /> 
                                                <input type="hidden" name="subtype" value="" id="subtype" /> 
                                                <div class="bt_box"> <input type="submit" value="Login" name="login" tabindex="3" class="log_btn" id="login_but"/></div>
                                            </div>
                                            <div class="l_one"><a href="forgotpwd.jsp" style="text-decoration:none;" onclick="return verifyUid();">Forgot your password?</a></div>

                                        </form>
                                        <div class="l_one" style="text-decoration:none; color: red">Invalid login</div>

                                        <div class="clear"></div>
                                        <div class="footer_login">
					                        <button class="btn btn-xs btn-danger text-right" id="showEmergencyNo">Emergency Numbers</button><br/>
					                        <c:forEach var="current" items="${rs.rows}"> 
						                         <span class="footer-text">Help Desk : ${current.ename}</span><br/>
						                         <span class="footer-text">Email : ${current.emailid}</span>  &nbsp;  &nbsp; &nbsp; &nbsp;<span class="footer-text">Extension : ${current.extension}</span> <br/> 
					                        </c:forEach>
					                        <span class="footer-text">© 1988 - <%=currYear%> <a  target="_blank" href="http://www.faisaljassim.ae" rel="noopener noreferrer">FJ-Group</a>. All Rights Reserved.</span>
				                        </div>
                                        <%--  <div class="footer_login">
                                         <span class="footer-text">© 1988 - <%=currYear%> 
                                         <a  target="_blank" href="http://www.faisaljassim.ae" rel="noopener noreferrer">FJ-Group</a>. All Rights Reserved.</span>
                                         </div>--%>
                                        </div>
                                </div> 

                            </c:when>
                            <c:when test="${loginstatus eq -2}">
                                <%
                                    session.removeAttribute("fjtuser");
                                    session.invalidate();
                                %>
                            <body align="center" onload="return setFields();">
                                <div class="container">
                                    <div class="login_box"><img alt="FJTCO" src="resources/images/logo.jpg" />
                                          <h2>FJ Portal</h2>
                                        <form method="POST" action="index.jsp" onsubmit="return checklogin();" >       
                                            <div class="l_one">
                                                <input class="leave_text" type="text" name="uid" size="20" id="fjuid" placeholder="User id" tabindex="1" onblur="return checkUid(this);" onkeypress="verifyEnter(event);"/> </div>
                                            <div class="l_one">
                                                <input class="leave_text" type="password" name="passwd" size="20" id="fjpwd" placeholder="Password" tabindex="2" onblur="return setSubType();" onkeypress="verifyEnterInPwd(event);"/> </div>
                                            <div class="l_one">
                                                <div class="n_text2"></div>
                                            </div>
                                            <div class="l_one">
                                                <input type="hidden" name="ll" id="ll" value="<%=System.currentTimeMillis()%>" /> 
                                                <input type="hidden" name="subtype" value="" id="subtype" /> 
                                                <div class="bt_box"> <input type="submit" value="Login" name="login" tabindex="3" class="log_btn" id="login_but"/></div>
                                            </div>
                                            <div class="l_one"><a href="forgotpwd.jsp" style="text-decoration:none; " onclick="return verifyUid();">Forgot your password?</a></div>

                                        </form>
                                        <div class="l_one" style="text-decoration:none; color: red">  <%-- DB Error--%>Something went wrong... <br/> Please contact IT</div>   
                                        <div class="clear"></div>
                                        <div class="footer_login">
					                        <button class="btn btn-xs btn-danger text-right" id="showEmergencyNo">Emergency Numbers</button><br/>
					                        <c:forEach var="current" items="${rs.rows}"> 
						                         <span class="footer-text">Help Desk : ${current.ename}</span><br/>
						                         <span class="footer-text">Email : ${current.emailid}</span>  &nbsp;  &nbsp; &nbsp; &nbsp;<span class="footer-text">Extension : ${current.extension}</span> <br/> 
					                        </c:forEach>
					                        <span class="footer-text">© 1988 - <%=currYear%> <a  target="_blank" href="http://www.faisaljassim.ae" rel="noopener noreferrer">FJ-Group</a>. All Rights Reserved.</span>
				                        </div>
                                        <%-- <div class="footer_login">
                                         <span class="footer-text">© 1988 - <%=currYear%> 
                                         <a  target="_blank" href="http://www.faisaljassim.ae" rel="noopener noreferrer">FJ-Group</a>. All Rights Reserved.</span>
                                         </div>--%>
                                        </div>
                                </div> 

                            </c:when>

                        </c:choose>

                    </c:when>
                    <c:otherwise>


                    </c:otherwise>
                </c:choose>

                <%
                } else {
                    System.out.println("forwarded");
                %>
            <body align="center" onload="return setFields();">
                <div class="container">
                    <div class="login_box"><img alt="FJTCO" src="resources/images/logo.jpg" />
                        <h2>FJ Portal</h2>
                        <form method="POST" action="index.jsp" onsubmit="return checklogin();">       
                            <div class="l_one">
                                <input class="leave_text" type="text" name="uid" size="20" id="fjuid" placeholder="User id" tabindex="1" onblur="return checkUid(this);" onkeypress="verifyEnter(event);"/> </div>
                            <div class="l_one">
                                <input class="leave_text" type="password" name="passwd" size="20" id="fjpwd" placeholder="Password" tabindex="2" onblur="return setSubType();" onkeypress="verifyEnterInPwd(event);"/> </div>
                            <div class="l_one">
                                <div class="n_text2"></div>
                            </div>
                            <div class="l_one">
                                <input type="hidden" name="ll" id="ll" value="<%=System.currentTimeMillis()%>" /> 
                                <input type="hidden" name="subtype" value="" id="subtype" /> 
                                <div class="bt_box"> <input type="submit" value="Login" name="login" tabindex="3" class="log_btn" id="login_but"/></div>
                            </div>
                            <div class="l_one"><a href="forgotpwd.jsp" style="text-decoration:none;" onclick="return verifyUid();">Forgot your password?</a></div>
                            <div class="clear"></div>
                        </form>
                        <div class="footer_login">
	                        <button class="btn btn-xs btn-danger text-right" id="showEmergencyNo">Emergency Numbers</button><br/>
	                        <c:forEach var="current" items="${rs.rows}"> 
		                         <span class="footer-text">Help Desk : ${current.ename}</span><br/>
		                         <span class="footer-text">Email : ${current.emailid}</span>  &nbsp;  &nbsp; &nbsp; &nbsp;<span class="footer-text">Extension : ${current.extension}</span> <br/> 
	                        </c:forEach>
	                        <span class="footer-text">© 1988 - <%=currYear%> <a  target="_blank" href="http://www.faisaljassim.ae" rel="noopener noreferrer">FJ-Group</a>. All Rights Reserved.</span>
                        </div>
                        <%-- <div class="footer_login">
                         <span class="footer-text">© 1988 - <%=currYear%> 
                          <a  target="_blank" href="http://www.faisaljassim.ae" rel="noopener noreferrer">FJ-Group</a>. All Rights Reserved.</span>
                        </div>--%>
                    </div>
                </div> 
                <%
                    }
                %>
            </c:otherwise>
        </c:choose> 
        <%-- MODAL START  --%>
   <div id="emergency" class="modal fade"  >
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header"> 
                <button type="button" class="close btn brn-sm btn-danger" data-dismiss="modal" style="color:#ffffff !important;opacity: 1 !important;">X</button>
            </div>
            <div class="modal-body"> <img style="width:100%"  height="550" src="resources/images/covid/fj_covid_emergency.jpg" class="img-fluid" alt="FJ EMERGENCY NUMBERS">    </div>
        </div>
    </div>
    </div>
    <%-- MODAL END  --%>
    </body>
</html>
