 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@include file="mainview.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:choose>
    <c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1}">
        <jsp:useBean id="cmp_param" class="beans.CompParam" scope="session"/>
        <jsp:useBean id="usrleave" class="beans.Leave" scope="request"/>
        <jsp:setProperty name="usrleave" property="cur_procm_startdt" value="${cmp_param.currentProcMonthStartDate}"/>
        <jsp:setProperty name="leave" property="emp_code" value="${fjtuser.emp_code}"/>
        <jsp:setProperty name="leave" property="emp_comp_code" value="${fjtuser.emp_com_code}"/>
        <!DOCTYPE html>
        <script src="resources/js/approvalrequests.js?v=15062022g"></script>
              
        <div class="container">
         	<div class="panel panel-default  small" id="fj-page-head-box">
                <div class="panel-heading" id="fj-page-head">                        
                   <h4 class="text-left">
                    	Sick Leave Requests
		                <a href="homepage.jsp" > <i class="fa fa-home pull-right" title="Home"></i></a>    
		                <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a>                   
                  </h4>                      
                </div>
            </div>
            <c:choose>
                <c:when test="${!empty SICKLEAVEREQ}">               
                    <div class="table-responsive">
                        <table class="table" cellpadding="1" cellspacing="1">
                            <thead>
                                <tr bgcolor="#2c2c2c" style="color:#FFFFFF;">
                                 	<th class="tab_h">Employee Name</th>
                                    <th class="tab_h">Employee Id</th>
                                    <th class="tab_h">Division</th>
                                    <th class="tab_h">Leave Type</th>
                                    <th class="tab_h">From Date</th>
                                    <th class="tab_h">To Date</th>
                                    <th class="tab_h">Resume On</th>
                                    <th class="tab_h">Leave Days</th>
                                    <th class="tab_h">Leave Balance</th>
                                    <th class="tab_h">Reason</th>   
                                    <th class="tab_h"> </th>   
                                </tr>                
                            </thead>
                            <tbody>
                                <c:forEach var="current" items="${SICKLEAVEREQ}">                               
                                    <fmt:formatDate pattern="dd-MM-yyyy" var="cfmdt" value="${current.fromdate}" />
                                    <fmt:formatDate pattern="dd-MM-yyyy" var="ctodt"  value="${current.todate}" /> 
                                    <fmt:formatDate pattern="dd-MM-yyyy" var="cresdt" value="${current.resumedate}"/> 
                                  
                                    <tr bgcolor="#e1e1e1" style="color:#000000;"> 
                                    	<td class="tab_h2">${current.emp_name}</td>
                                        <td class="tab_h2">${current.emp_code}</td>
                                        <td class="tab_h2">${current.emp_divn_code}</td>
                                        <td height="20" class="tab_h2">${current.leavetype}</td>
                                        <td class="tab_h2"><c:out value="${cfmdt}"/></td>
                                        <td class="tab_h2"><c:out value="${ctodt}"/></td>
                                        <td class="tab_h2">${cresdt}</td>
                                        <td class="tab_h2">${current.leavedays}</td>
                                        <td class="tab_h2">
                                            <jsp:setProperty name="usrleave" property="emp_code" value="${current.emp_code}"/>
                                            <jsp:setProperty name="usrleave" property="cur_leave_type" value="${current.leavetype}"/>
                                            <jsp:setProperty name="usrleave" property="emp_comp_code" value="${current.comp_code}"/>
                                            ${usrleave.leaveBalanceOf}
                                        </td>
                                        <td class="tab_h2">${current.reason}</td> 
                                        <td class="tab_h2">                                           
                                                
                                                    <c:set var="theurlA" value="LeaveProcess?ocjtfdinu=${current.applied_date.time}&edocmpe=${current.emp_code}&revorppa=${current.approver}&dpsroe=7&ntac=grulae&epyt=1&egats=2&lvbal=${usrleave.leaveBalanceOf}&signedBy=fjtco"/>
                                                    <c:set var="theurlR" value="LeaveProcess?ocjtfdinu=${current.applied_date.time}&edocmpe=${current.emp_code}&revorppa=${current.approver}&dpsroe=5&ntac=grulae&epyt=1&egats=2&lvbal=${usrleave.leaveBalanceOf}&signedBy=fjtco"/>  
                                                                                      

                                            <div name="thebox"> <div class="sbt_btn action-btn"><a style='text-decoration: none;color: #ffffff' href="${theurlA}" target="result" onclick="startAjax(event, this);" > Approve</a></div>
                                                <div class="btn_can action-btn"><a style='text-decoration: none;color: #ffffff' href="${theurlR}" target="result" onclick="startAjax(event, this);"   > Reject</a></div></div>
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
        <body onload="window.top.location.href = 'logout.jsp'"></body>

    </body>
</html>
</c:otherwise>
</c:choose>