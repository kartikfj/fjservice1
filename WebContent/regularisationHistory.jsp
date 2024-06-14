<%-- 
    Document   : regularisationHistory 
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@include file="mainview.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:choose>
    <c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1}">
        <jsp:useBean id="regn" class="beans.Regularisation" scope="session"/>
        <jsp:useBean id="cmp_param" class="beans.CompParam" scope="session"/>
        <jsp:setProperty name="regn" property="emp_code" value="${fjtuser.emp_code}"/>
        <jsp:setProperty name="regn" property="comp_code" value="${fjtuser.emp_com_code}"/>
        <!DOCTYPE html>
        <script src="resources/js/approvalrequests.js"></script>
       <sql:query var="rs" dataSource="jdbc/mysqlfjtcolocal">
            select date_to_regularise,reason,applied_date,status from  regularisation_application where uid=?   order by applied_date desc limit 30
            <sql:param value="${fjtuser.emp_code}"/>
        </sql:query>
        <div class="container">
           <%--  <div class="att_searchbox">
                <h1>Reqularisation Request History</h1>
                <!--iframe name="result" style="width:1em; float:right; height:1em;border:0px"></iframe-->
            </div>--%>
            <div class="panel panel-default  small" id="fj-page-head-box">
                <div class="panel-heading" id="fj-page-head">    
	                <div class="col-xs-12 " style="padding-bottom: 10px;">  
				       		 <a href="regularisationHistory.jsp" class="button">Regularisation Request History</a> 
						     <a href="leaveHistory.jsp" class="button">Leave Request History</a>
						     <a href="busincessTripLeaveHistory.jsp" class="button">Business Trip History</a>
						     <c:if test="${fjtuser.role eq 'hr'}">             
			                 	 <a href="AppraisalReport" class="button">Appraisal Report</a>           
			               	 </c:if>
				              <c:if test="${!empty fjtuser.subordinatelist}">
				  				 <a href="Regularisation_Report" class="button">Regularisation Report</a>  
				  				 <a href="Leave_Report" class="button">Leave Report</a> 
				  				  <a href="BusinessTripReport" class="button">Business Trip Report</a>  
				  			  </c:if>  	
				  			 <!--  <a href="Payslip" class="button">Payslip</a>	
				  			  <a href="SalaryCertificate" class="button">Salary Certificate</a>	
				  			  <c:if test="${fjtuser.role ne 'hrmgr'}"> 
				  			 	 <a href="ExperienceCertificate" class="button">Experience Certificate</a>
				  			  </c:if>
				  			  <c:if test="${fjtuser.role eq 'hrmgr'}"> 
				  			  	<a href="ExperienceCertificate" class="button">Self Experience Certificate</a>
				  			  </c:if>
				  			  <c:if test="${fjtuser.role eq 'hrmgr'}"> 
				  			  	<a href="experienceCert.jsp" class="button">Experience Certificate For Employee</a>
				  			  </c:if> -->
				       	</div>                    
                   <h4 class="text-left">
                    Reqularisation Request History
                   <a href="homepage.jsp" > <i class="fa fa-home pull-right" title="Home"></i></a>  
                   <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a>                   
                  </h4>                      
                </div>
            </div>
            <c:choose>
                <c:when test="${!empty rs.rows or !empty rs2.rows}">
                    <div class="table-responsive">  
                        <table class="table" cellpadding="1" cellspacing="1">
                            <thead>
                                <tr bgcolor="#2c2c2c" style="color:#FFFFFF;">
                                    <th class="tab_h">Applied date</th>
                                    <th class="tab_h">Date to regularise</th>
                                    <th class="tab_h">Reason</th>   
                                    <th class="tab_h">Status </th>   
                                </tr>                
                            </thead>
                            <tbody>
                                <c:forEach var="current" items="${rs.rows}">
                                    <fmt:formatDate pattern="dd-MM-yyyy" var="cfmdt" value="${current.date_to_regularise}" />
                                    <fmt:formatDate pattern="dd-MM-yyyy" var="afmdt" value="${current.applied_date}" />
                                    <tr bgcolor="#e1e1e1" style="color:#000000;"> 
                                        <td class="tab_h2">${afmdt}</td>
                                        <td class="tab_h2"><c:out value="${cfmdt}"/></td>
                                        <td class="tab_h2">${current.reason}</td> 
                                        <td class="tab_h2">
                                            <c:if test="${current.status eq 1 and current.date_to_regularise.time ge cmp_param.currentProcMonthStartDate.time}">
                                                Pending approval
                                            </c:if>
                                            <c:if test="${current.status eq 1 and current.date_to_regularise.time lt cmp_param.currentProcMonthStartDate.time}">
                                                Expired
                                            </c:if>
                                            <c:if test="${current.status eq 4}">
                                                Approved
                                            </c:if>
                                            <c:if test="${current.status eq 3}">
                                                Rejected
                                            </c:if>   
                                        </td>
                                    </tr>

                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="n_text_lvdetails">
                        No pending applications.
                    </div>
                </c:otherwise>
            </c:choose>
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