<%-- 
    Document   : personalsettings 
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="mainview.jsp" %>
<c:choose>
    <c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1}">
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <c:if test="${pageContext.request.method eq 'POST'}">
            <jsp:setProperty name="fjtuser" property="form_pwd" param="newpwd"/>
            <c:choose>
                <c:when test="${fjtuser.resetPassword eq 1}">
                    <c:set var="message" value="Successfully changed password"/>
                </c:when>   
                <c:otherwise>
                    <c:set var="message" value="Error in password reset process."/>  
                </c:otherwise>
            </c:choose>

        </c:if>
        <!DOCTYPE html>
        <script>
            function verify() {
                var oldpwd = document.getElementById("oldpwd").value;
                var newpwd = document.getElementById("newpwd").value;
                var cfmpwd = document.getElementById("cfmpwd").value;
                if (oldpwd.length == 0 || newpwd.length == 0 || cfmpwd.length == 0) {
                    alert("Please fill the details");
                    return false;
                } else if (newpwd != cfmpwd) {
                    alert("New password entered does not match with confirmed password. Please try again.");
                    return false;
                } else {
                    return true;
                }
            }
        </script>    
        <div class="container">
            <div class="att_searchbox">
                <h1>Reset password
                	<a href="homepage.jsp" > <i class="fa fa-home pull-right" title="Home"></i></a>  
                    <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a> 
                </h1> 
            </div>
            <div class="att_searchbox">
                <c:out value="${message}"/>
            </div>
            <div class="n_text_msg">
                <form method="post" onsubmit="return verify();">
                    <div class="table-responsive">  
                        <table class="table">
                            <tbody>
                                <tr>
                                    <td>Old password</td><td><input type="password" id="oldpwd" name="oldpwd"/></td>
                                </tr>
                                <tr>
                                    <td>New password</td><td><input type="password" id="newpwd" name="newpwd"/></td>
                                </tr>
                                <tr>
                                    <td>Confirm password</td><td><input type="password" id="cfmpwd" name="cfmpwd"/></td>
                                </tr>
                                <tr><td><input type="submit" name="ok" value="Update" class="sbt_btn"/></td>
                                    <td><input type="reset" name="reset" value="Reset" class="btn_can" /></td></tr>
                            </tbody>
                        </table>
                    </div>
                </form> 
            </div>
        </div>
    </body>
</html>
</c:when>
<c:otherwise>
    <html>
        <body onload="window.top.location.href = 'logout.jsp'">
        </body>

    </body>
</html>
</c:otherwise>
</c:choose>