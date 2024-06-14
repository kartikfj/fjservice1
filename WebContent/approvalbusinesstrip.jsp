 
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
        <!DOCTYPE html>
        <script src="resources/js/approvalrequests.js?v=15062022g"></script>
        <sql:query var="rs" dataSource="jdbc/mysqlfjtcolocal">
            SELECT fromdate, todate, applied_date,country,customer_name, purpose,country, uid,otherdetails  from  businesstrip_leave_application where status=1 and canceldate is NULL and authorised_by=? order by applied_date asc
            <sql:param value="${fjtuser.emp_code}"/>
        </sql:query>              
        <div class="container">
          <%--   <div class="att_searchbox">
                <h1>Leave Requests/ Leave encashment Requests</h1>                
                <!--iframe name="result" style="width:1em; float:right; height:1em;border:0px"></iframe-->
            </div>--%>
			<div class="panel panel-default  small" id="fj-page-head-box">
                <div class="panel-heading" id="fj-page-head">                        
                   <h4 class="text-left">
                    Business Trip Leave Requests
		                <a href="homepage.jsp" > <i class="fa fa-home pull-right" title="Home"></i></a>    
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
                                    <th class="tab_h">Employee</td>                                   
                                    <th class="tab_h">From Date</th>
                                    <th class="tab_h">To Date</th>
                                    <th class="tab_h">Country Visited</th>
                                    <th class="tab_h">Project Details</th>
                                    <th class="tab_h">Purpose</th>
                                   <%-- <th class="tab_h">Other Details</th> --%>   
                                    <th class="tab_h"> </th>   
                                </tr>                
                            </thead>
                            <tbody>
                                <c:forEach var="current" items="${rs.rows}"> 
                                    <fmt:formatDate pattern="dd-MM-yyyy" var="cfmdt" value="${current.fromdate}" />
                                    <fmt:formatDate pattern="dd-MM-yyyy" var="ctodt"  value="${current.todate}" />
                                    <c:if test="${fjtuser.subordinatelist[current.uid].uname ne null and  !empty fjtuser.subordinatelist[current.uid].uname}" >
                                    <tr bgcolor="#e1e1e1" style="color:#000000;"> 
                                        <td class="tab_h2">${fjtuser.subordinatelist[current.uid].uname}</td>
                                        <td class="tab_h2"><c:out value="${cfmdt}"/></td>
                                        <td class="tab_h2"><c:out value="${ctodt}"/></td>
                                        <td class="tab_h2">${current.country}</td>
                                        <td class="tab_h2">${current.customer_name}</td>
                                        <td class="tab_h2">${current.purpose}</td>
                                      <%--  <td class="tab_h2">${current.otherdetails}</td>                                       
                                         <td class="tab_h2">${current.reason}</td> --%>
                                        <td class="tab_h2">
	                                        <c:set var="theurlA" value="LeaveProcess?ocjtfdinu=${current.applied_date.time}&edocmpe=${current.uid}&revorppa=${fjtuser.emp_code}&dpsroe=7&ntac=rpiubnst&epyt=2&egats=1"/>
	                                        <c:set var="theurlR" value="LeaveProcess?ocjtfdinu=${current.applied_date.time}&edocmpe=${current.uid}&revorppa=${fjtuser.emp_code}&dpsroe=5&ntac=rpiubnst&epyt=2&egats=1"/>
	                                        <div name="thebox"> <div class="sbt_btn action-btn"><a style='text-decoration: none;color: #ffffff' href="${theurlA}" target="result" onclick="startAjax(event, this);" > Approve</a></div>
                                            <div class="btn_can action-btn"><a style='text-decoration: none;color: #ffffff' href="${theurlR}" target="result" onclick="startAjax(event, this);"   > Reject</a></div></div>
                                        </td>                                       
                                    </tr> 
                                   </c:if>
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