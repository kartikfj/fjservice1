<%-- 
    Document   : IT ADMIN 
--%>


<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="mainview.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.navbar {  margin-bottom: 8px !important; }
</style>
</head>
<c:choose>
<c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1 and fjtuser.emp_code  eq 'E003006'}">
<body>

</body>
</c:when>
<c:otherwise>
        <body onload="window.top.location.href='logout.jsp'">        
        </body>
</c:otherwise>
</c:choose>
</html>