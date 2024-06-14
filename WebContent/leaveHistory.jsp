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
        <jsp:useBean id="leave" class="beans.Leave" scope="session"/>
        <jsp:useBean id="cmp_param" class="beans.CompParam" scope="session"/>
        <jsp:setProperty name="leave" property="emp_code" value="${fjtuser.emp_code}"/>
        <jsp:setProperty name="leave" property="emp_comp_code" value="${fjtuser.emp_com_code}"/>
        <jsp:setProperty name="leave" property="cur_procm_startdt" value="${cmp_param.currentProcMonthStartDate}"/>
        <!DOCTYPE html>
        <script src="resources/js/approvalrequests.js"></script>
        <sql:query var="rs" dataSource="jdbc/mysqlfjtcolocal">
            SELECT leavetype, fromdate, todate,resumedate, leavedays,applied_date, reason,status from  leave_application where cancel_date is NULL and uid=? order by applied_date asc
            <sql:param value="${fjtuser.emp_code}"/>
        </sql:query>
        <sql:query var="rs2" dataSource="jdbc/mysqlfjtcolocal">
            SELECT leave_catcode, effective_date, leave_encash_days,applied_date, remarks,status from  leave_encashments where cancel_date is NULL and  emp_code=? order by applied_date asc
            <sql:param value="${fjtuser.emp_code}"/>
        </sql:query>
        <div class="container">
           <%-- <div class="att_searchbox">
                <h1>Leave Requests/ Leave encashment Requests</h1> <!--iframe name="result" style="width:1em; float:right; height:1em;border:0px"></iframe-->
            </div> --%>
             <div class="panel panel-default  small" id="fj-page-head-box">
                <div class="panel-heading" id="fj-page-head">                        
                   <h4 class="text-left">
                    Leave Requests/ Leave encashment Requests
                   <a href="homepage.jsp" > <i class="fa fa-home pull-right"></i></a> 
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
                                <th class="tab_h">Leave Type</th>
                                <th class="tab_h">From Date</th>
                                <th class="tab_h">To Date</th>
                                <th class="tab_h">Resume On</th>
                                <th class="tab_h">Leave Days</th>
                                <th class="tab_h">Reason</th>   
                                <th class="tab_h">Status </th>   
                            </tr>                
                        </thead>
                        <tbody>
                        <c:forEach var="current" items="${rs.rows}">
                            <fmt:formatDate pattern="dd-MM-yyyy" var="cfmdt" value="${current.fromdate}" />
                            <fmt:formatDate pattern="dd-MM-yyyy" var="ctodt"  value="${current.todate}" />
                            <fmt:formatDate pattern="dd-MM-yyyy" var="cresdt" value="${current.resumedate}"/>
                            
                                <tr bgcolor="#e1e1e1" style="color:#000000;"> 
                                    <td class="tab_h2">${current.leavetype}</td>
                                    <td class="tab_h2"><c:out value="${cfmdt}"/></td>
                                    <td class="tab_h2"><c:out value="${ctodt}"/></td>
                                    <td class="tab_h2">${cresdt}</td>
                                    <td class="tab_h2">${current.leavedays}</td>
                                    <td class="tab_h2">${current.reason}</td> 
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
                                        <c:if test="${current.status eq 2  and current.fromdate.time ge cmp_param.currentProcMonthStartDate.time}">
                                            Pending approval from HR
                                        </c:if>
                                    </td>
                                </tr>

                            </c:forEach>
                            <c:forEach var="current2" items="${rs2.rows}">
                                <fmt:formatDate pattern="dd-MM-yyyy" var="cfmdt" value="${current2.effective_date}" />    
                                <tr bgcolor="#e1e1e1" style="color:#000000;">         
                                    <td class="tab_h2">Leave encashment</td>
                                    <td class="tab_h2"><c:out value="${cfmdt}"/></td>
                                    <td class="tab_h2">-</td>
                                    <td class="tab_h2">-</td>
                                    <td class="tab_h2">${current2.leave_encash_days}</td>
                                    <td class="tab_h2">${current2.remarks}</td> 
                                    <td class="tab_h2">                     
                                        <c:if test="${current2.status eq 1}">
                                            Pending approval
                                        </c:if>

                                        <c:if test="${current2.status eq 4}">
                                            Approved
                                        </c:if>
                                        <c:if test="${current2.status eq 3}">
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