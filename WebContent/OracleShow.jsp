
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<sql:query var="service" dataSource="jdbc/orclfjtcolocal">
				SELECT NAME,DESCRIPTION from OM_CUSTOMER
     
 </sql:query> 
<head>
 <meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
 <c:if test="${!empty service.rows}">  
		 <c:forEach var="subList"  items="${service.rows}" >					   
					  <option value="${subList.name}" >${subList.name} - ${subList.description} </option>					   
		</c:forEach>	
</c:if>
</body>
</html>