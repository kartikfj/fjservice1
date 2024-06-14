<%-- 
    Document   : regularisationRequest   
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:useBean id="fjtuser" class="beans.fjtcouser" scope="session"/> 
<%@page import="beans.CustomerVisit"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.lang.reflect.Type"%>
<%@page import="com.google.gson.reflect.TypeToken"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:choose>
<c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1}"> 
  <%      	  System.out.println("WELCOME== "+request.getParameter("hsysId"));   %> 
    <jsp:useBean id="regn" class="beans.Regularisation" scope="request"/> 
    <jsp:setProperty name="regn" property="emp_code" value="${fjtuser.emp_code}"/>
    <jsp:setProperty name="regn" property="emp_name" value="${fjtuser.uname}"/>
    <jsp:setProperty name="regn" property="approver_id" value="${fjtuser.approver}"/>
    <jsp:setProperty name="regn" property="approver_eid" value="${fjtuser.approverId}"/>
    <jsp:setProperty name="regn" property="comp_code" value="${fjtuser.emp_com_code}"/>
    <jsp:setProperty name="regn" property="regularise_dateStr" param="regularise_date"/>
    <jsp:setProperty name="regn" property="reason" param="reason" />
    <jsp:setProperty name="regn" property="chkinTime" param="chkin" />       
    <jsp:setProperty name="regn" property="regOptnStatus" param="regOptnSts" />
    <jsp:setProperty name="regn" property="alrdyUpdtdVstCount" param="alrdyUpdtdVsts" />
    <jsp:setProperty name="regn" property="projectName" param="projectName" />  
    <jsp:setProperty name="regn" property="customerName" param="customerName" />
    <jsp:setProperty name="regn" property="reminderDesc" param="reminderDesc" /> 
    <jsp:setProperty name="regn" property="reminderType" param="reminderType" /> 
    <jsp:setProperty name="regn" property="partyName" param="partyName" />
    <jsp:setProperty name="regn" property="userType" param="userType" />  
    <jsp:setProperty name="regn" property="hsysId" param="hsysId" />  
<!DOCTYPE html>
<html>
    <body>
 
  
    <c:choose>
    	<c:when test="${!empty param.regOptnSts && param.regOptnSts eq 0 }">
    		<c:set var="applystatus" value="${regn.sendRegularisationRequest}" scope="request"/>
	        <c:if test="${applystatus eq 1}">
	            Regularisation application sent.
	        </c:if>
	        <c:if test="${applystatus ne 1}">
	            Error in processing.
	        </c:if>
    	</c:when>
    	<c:when test="${!empty param.regOptnSts && param.regOptnSts eq 1 }">
	    	  <jsp:setProperty name="regn" property="sales_code" value="${fjtuser.sales_code}"/>	    	
		    		  <%       
						    int alrdyUpdtdVisitCount = Integer.parseInt(request.getParameter("alrdyUpdtdVsts")); 
		    		  		String custVstDetails = request.getParameter("details"); 
						    Gson gson = new Gson();
						    Type type = new TypeToken<List<CustomerVisit>>(){}.getType();
						    List<CustomerVisit> visitList = gson.fromJson(custVstDetails, type);
						    int visitCount = visitList.size(); 
					   %> 
					<c:set var="currntUpdtdVstCount" value="<%=visitCount%>" scope="request"/>
					<c:set var="oldVstCount" value="<%=alrdyUpdtdVisitCount%>" scope="request"/>
					<jsp:setProperty name="regn" property="visitData" value="<%=visitList%>" /> 
					<c:choose>
						<c:when test="${currntUpdtdVstCount ge 1}">
							<c:set var="visitIstatus" value="${regn.customerVisitDetailsInsertStatus}" scope="request"/>
						</c:when>
						<c:when test="${currntUpdtdVstCount eq 0 and oldVstCount ge 1}">
							<c:set var="visitIstatus" value="1" scope="request"/>
						</c:when>
						<c:otherwise>
							<c:set var="visitIstatus" value="0" scope="request"/>
						</c:otherwise>
					</c:choose>  
					   
					<c:choose>
						<c:when test="${visitIstatus ge 1}">
							<c:set var="applystatus" value="${regn.sendRegularisationRequest}" scope="request"/>
							 <c:if test="${applystatus eq 1}">
					            Regularzn & Cust-Vst application sent.
					        </c:if>
					        <c:if test="${applystatus ne 1}">
					            Error in processing.
					        </c:if>
						</c:when>
						<c:otherwise>
							 Error in processing.
						</c:otherwise>
					</c:choose>
    	</c:when>
    	<c:when test="${!empty param.regOptnSts && param.regOptnSts eq 2 }">
	    	<jsp:setProperty name="regn" property="sales_code" value="${fjtuser.sales_code}"/>	    	
	    		  <%      	  		        
					    String custVstDetails = request.getParameter("details"); 
					    Gson gson = new Gson();
					    Type type = new TypeToken<List<CustomerVisit>>(){}.getType();
					    List<CustomerVisit> visitList = gson.fromJson(custVstDetails, type);
					    int visitCount = visitList.size(); 
				   %> 
				<jsp:setProperty name="regn" property="visitData" value="<%=visitList%>" /> 
				<c:set var="intlVstCount" value="<%=visitCount%>" scope="request"/>
				<c:set var="visitIstatus" value="${regn.customerVisitDetailsInsertStatus}" scope="request"/>
				<c:choose>
					<c:when test="${visitIstatus eq intlVstCount}"> 
				            Cust-Visit Details Updated. 
					</c:when>
					<c:otherwise>
						 Error in processing.
					</c:otherwise>
				</c:choose>			    						       
    	</c:when>
    	<c:when test="${!empty param.regOptnSts && param.regOptnSts eq 3 }">
	    	<jsp:setProperty name="regn" property="sales_code" value="${fjtuser.sales_code}"/>	    	
	    		  <%      	  		        
					    String custVstDetails = request.getParameter("details"); 
					    Gson gson = new Gson();
					    Type type = new TypeToken<List<CustomerVisit>>(){}.getType();
					    List<CustomerVisit> visitList = gson.fromJson(custVstDetails, type);
					    int visitCount = visitList.size(); 
				   %> 
				<jsp:setProperty name="regn" property="visitData" value="<%=visitList%>" /> 
				<c:set var="intlVstCount" value="<%=visitCount%>" scope="request"/>
				<c:set var="visitIstatus" value="${regn.customerVisitPlannerDetailsInsertStatus}" scope="request"/>
				<c:choose>
					<c:when test="${visitIstatus eq intlVstCount}"> 
				            Cust-Visit Planner Details Updated. 
					</c:when>
					<c:otherwise>
						 Error in processing.
					</c:otherwise>
				</c:choose>			    						       
    	</c:when>
    	<c:when test="${!empty param.regOptnSts && param.regOptnSts eq 4 }">
	    	<c:set var="applystatus" value="${regn.reminderDetailsInsertStatus}" scope="request"/>
	        <c:if test="${applystatus eq 1}">
	           Reminder added successfully.
	        </c:if>
	        <c:if test="${applystatus ne 1}">
	            Error in processing.
	        </c:if>   						       
    	</c:when>    	    
    </c:choose>
    </body>
</html>
</c:when>
<c:otherwise> 
    <html> 
    <head> 
        <body  onload="window.top.location.href='logout.jsp'">      
         <p onmouseover="reloadPage()"><b style="color:red">Error in processing. <br/> Please re-login and try again.</b> <button onclick="reloadPage();">Re-Login</button></p>
        </body> 
    </html>
</c:otherwise>
</c:choose>