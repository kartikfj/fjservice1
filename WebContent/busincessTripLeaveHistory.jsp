<%-- 
    Document   : leaveHistory 
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@include file="mainview.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<c:choose>
    <c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1}">      
        <jsp:useBean id="businessleave" class="beans.BusinessTripLVApplication" scope="request"/>       
         <jsp:setProperty name="leave" property="emp_code" value="${fjtuser.emp_code}"/>        
        <!DOCTYPE html>       
        <sql:query var="rs" dataSource="jdbc/mysqlfjtcolocal">
            SELECT fromdate, todate, country, customer_name,applied_date, purpose,status from  businesstrip_leave_application where canceldate is NULL and uid=? order by applied_date asc
            <sql:param value="${fjtuser.emp_code}"/>
        </sql:query>
       
        <div class="container">
           <%-- <div class="att_searchbox">
                <h1>Leave Requests/ Leave encashment Requests</h1> <!--iframe name="result" style="width:1em; float:right; height:1em;border:0px"></iframe-->
            </div> --%>
             <div class="panel panel-default  small" id="fj-page-head-box">
                <div class="panel-heading" id="fj-page-head">                        
                   <h4 class="text-left">
                    Business Trip Leave Requests
                   <a href="homepage.jsp" > <i class="fa fa-home pull-right"></i></a> 
                   <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a>                      
                  </h4>                      
                </div>
            </div>
            <c:choose>
                <c:when test="${!empty rs.rows}">
                    <div class="table-responsive">  
                    <table class="table" cellpadding="1" cellspacing="1">
                        <thead>
                            <tr bgcolor="#2c2c2c" style="color:#FFFFFF;">                               
                                <th class="tab_h">From Date</th>
                                <th class="tab_h">To Date</th>
                                <th class="tab_h">Country Visited</th>
                                <th class="tab_h">Company Name/Project Details</th>
                                <th class="tab_h">Purpose</th>   
                                <th class="tab_h">Other Details </th>   
                            </tr>                
                        </thead>
                        <tbody>
                        <c:forEach var="current" items="${rs.rows}">
                            <fmt:formatDate pattern="dd-MM-yyyy" var="cfmdt" value="${current.fromdate}" />
                            <fmt:formatDate pattern="dd-MM-yyyy" var="ctodt"  value="${current.todate}" /> 
                                <tr bgcolor="#e1e1e1" style="color:#000000;">  
                                    <td class="tab_h2"><c:out value="${cfmdt}"/></td>
                                    <td class="tab_h2"><c:out value="${ctodt}"/></td>                                  
                                    <td class="tab_h2">${current.country}</td>
                                    <td class="tab_h2">${current.customer_name}</td>
                                    <td class="tab_h2">${current.purpose}</td> 
                                    <td class="tab_h2">
                                        <c:if test="${current.status eq 1  and current.fromdate.time ge cmp_param.currentProcMonthStartDate.time}">
                                            Pending approval from manager
                                        </c:if>
                                        <c:if test="${current.status eq 1 and current.fromdate.time lt cmp_param.currentProcMonthStartDate.time}">
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
                        No leave applications.
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