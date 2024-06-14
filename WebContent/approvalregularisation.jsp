 

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@include file="mainview.jsp" %>
<head><style>#cvDetails_tbl thead th, #cvDetails_tbl tbody td{border: 1px solid #03a9f4 !important;padding: 7px; text-align: left;}</style></head>
<c:choose>
    <c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1}">
        <jsp:useBean id="regn" class="beans.Regularisation" scope="session"/>
        <jsp:useBean id="cmp_param" class="beans.CompParam" scope="session"/>
        <jsp:setProperty name="regn" property="emp_code" value="${fjtuser.emp_code}"/>
        <jsp:setProperty name="regn" property="comp_code" value="${fjtuser.emp_com_code}"/>
        <jsp:setProperty name="regn" property="cur_procm_startdt" value="${cmp_param.currentProcMonthStartDate}"/>
        <!DOCTYPE html>
        <script src="resources/js/approvalrequests.js?v=3.0001"></script>
        <sql:query var="rs" dataSource="jdbc/mysqlfjtcolocal">
            select uid,date_to_regularise,reason,project_code,applied_date from  regularisation_application where status=1 and authorised_by = ?   and  date_to_regularise > (SELECT  STR_TO_DATE(param_value, '%d/%m/%Y') from  system_params where param_name='CUR_PROCM_START' and status=1 and valid_from = (select max(valid_from) from  system_params where param_name='CUR_PROCM_START' and status=1)) order by applied_date asc
            <sql:param value="${fjtuser.emp_code}"/>
        </sql:query>
         <sql:query var="rs2" dataSource="jdbc/mysqlfjtcolocal">
            SELECT req_id,fromdate, todate, applied_date,country,customer_name, purpose,country, uid, otherdetails  from  businesstrip_leave_application where status=1 and canceldate is NULL and authorised_by=? order by applied_date asc
            <sql:param value="${fjtuser.emp_code}"/>
        </sql:query>    
    
        <div class="container">
           <%--  <div class="att_searchbox">
                <h1>Reqularisation Approval</h1>
                <!--iframe name="result" style="width:1em; float:right; height:1em;border:0px"></iframe-->
            </div>--%>
           <div class="panel panel-default  small" id="fj-page-head-box">
                <div class="panel-heading" id="fj-page-head">                        
                   <h4 class="text-left">
                    Reqularisation Approval
                   <a href="homepage.jsp" > <i class="fa fa-home pull-right" title="Home"></i></a>
                   <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a>                       
                  </h4>                      
                </div>
            </div>
            <c:choose>
                <c:when test="${!empty rs.rows || !empty rs2.rows}">                
                    <div class="table table-responsive">
                        <table class="table" cellpadding="1" cellspacing="1">
                            <thead>
                                <tr bgcolor="#2c2c2c" style="color:#FFFFFF;">
                                    <th class="tab_h">Employee</th>
                                    <th class="tab_h">Code</th>
                                    <th class="tab_h">Date to Regularise</th>
                                    <th class="tab_h">Reason</th> 
                                    <th class="tab_h">Project Code</th>   
                                    <th class="tab_h"> </th>   
									<th class="tab_h"> </th>   
                                </tr>                
                            </thead>
                            <tbody>
                                <c:forEach var="current" items="${rs.rows}">
                                  <c:if test="${fjtuser.subordinatelist[current.uid].uname ne null and !empty fjtuser.subordinatelist[current.uid].uname}">
                                    <fmt:formatDate pattern="dd-MM-yyyy" var="cfmdt" value="${current.date_to_regularise}" />
                                    <tr bgcolor="#e1e1e1" style="color:#000000;"> 
                                        <td class="tab_h2">${fjtuser.subordinatelist[current.uid].uname}</td>
                                        <td class="tab_h2">${current.uid}</td>
                                        <td class="tab_h2"><c:out value="${cfmdt}"/></td>
                                        <td class="tab_h2">${current.reason}</td> 

                                        <td class="tab_h2">                                       
                                          <c:choose>
                                            <c:when test="${current.project_code eq 'CUSTVISIT'}">
                                            <button class="btn btn-xs btn-info" onclick="getCustVisitDetails('${fjtuser.subordinatelist[current.uid].uname}','${current.uid}', '${current.date_to_regularise}', this);"><i class="fa fa-eye"></i> Visit Details</button>
                                            </c:when>
                                            <c:otherwise>
                                            	${current.project_code}
                                            </c:otherwise>
                                            </c:choose>
                                        </td> 
                                        <td class="tab_h2">
                                            <c:set var="theurlA" value="LeaveProcess?ocjtfdinu=${current.applied_date.time}&edocmpe=${current.uid}&revorppa=${fjtuser.emp_code}&dpsroe=7&ntac=raluger"/>                                        
                                            <div name="thebox"> <div class="sbt_btn"><a style='text-decoration: none;color: #ffffff' href="${theurlA}" target="result" onclick="startAjax(event, this);"> Approve</a></div></div>
                                        </td>
										
										<td class="tab_h2">
                                            <c:set var="theurlR" value="LeaveProcess?ocjtfdinu=${current.applied_date.time}&edocmpe=${current.uid}&revorppa=${fjtuser.emp_code}&dpsroe=5&ntac=raluger"/>
                                            <div name="thebox">
                                                <div class="btn_can"><a style='text-decoration: none;color: #ffffff' href="${theurlR}" target="result" onclick="startAjax(event, this);"> Reject</a></div></div>
                                        </td>
										
                                    </tr>
									</c:if>
                                </c:forEach>
                                 <c:forEach var="current" items="${rs2.rows}">
		                                  <c:if test="${fjtuser.subordinatelist[current.uid].uname ne null and !empty fjtuser.subordinatelist[current.uid].uname}">
		                                    <fmt:formatDate pattern="dd-MM-yyyy" var="frmdate" value="${current.fromdate}" />
		                                    <fmt:formatDate pattern="dd-MM-yyyy" var="todate" value="${current.todate}" />
		                                    <tr bgcolor="#e1e1e1" style="color:#000000;"> 
		                                        <td class="tab_h2">${fjtuser.subordinatelist[current.uid].uname}</td>
		                                        <td class="tab_h2">${current.uid}</td>
		                                        <td class="tab_h2">-- </td>
		                                        <td class="tab_h2">Business Trip (${frmdate}   to   ${todate}) </td> 
		
		                                        <td class="tab_h2">                                             
		                                            <button class="btn btn-xs btn-info" onclick="getBusinessTripDetails('${fjtuser.subordinatelist[current.uid].uname}','${current.fromdate}','${current.todate}','${current.uid}','${fjtuser.emp_code}', this);"><i class="fa fa-eye"></i> Visit Details</button>                                          
		                                        </td> 
		                                        <td class="tab_h2">
		                                            <c:set var="theurlA" value="LeaveProcess?ocjtfdinu=${current.applied_date.time}&edocmpe=${current.uid}&revorppa=${fjtuser.emp_code}&reqid=${current.req_id}&dpsroe=7&ntac=rpiubnst&epyt=2&egats=1"/>                                        
		                                            <div name="thebox"> <div class="sbt_btn"><a style='text-decoration: none;color: #ffffff' href="${theurlA}" target="result" onclick="startAjax(event, this);"> Approve</a></div></div>		                                            
		                                        </td>
												
												<td class="tab_h2">
		                                            <c:set var="theurlR" value="LeaveProcess?ocjtfdinu=${current.applied_date.time}&edocmpe=${current.uid}&revorppa=${fjtuser.emp_code}&reqid=${current.req_id}&dpsroe=5&ntac=rpiubnst&epyt=2&egats=1"/>
		                                            <div name="thebox"><div class="btn_can"><a style='text-decoration: none;color: #ffffff' href="${theurlR}" target="result" onclick="startAjax(event, this);"> Reject</a></div></div>
		                                        </td>
												
		                                    </tr>
										</c:if>
		                           </c:forEach>
                            </tbody>
		             <%-- <c:if test ="${!empty rs2.rows}">
		         	   	 <div class="table table-responsive">
		                        <table class="table" cellpadding="1" cellspacing="1">
		                           
		                            <tbody>
		                                <c:forEach var="current" items="${rs2.rows}">
		                                  <c:if test="${fjtuser.subordinatelist[current.uid].uname ne null and !empty fjtuser.subordinatelist[current.uid].uname}">
		                                   
		                                    <tr bgcolor="#e1e1e1" style="color:#000000;"> 
		                                        <td class="tab_h2">${fjtuser.subordinatelist[current.uid].uname}</td>
		                                        <td class="tab_h2">${current.uid}</td>
		                                        <td class="tab_h2">${current.fromdate} - ${current.todate}</td>
		                                        <td class="tab_h2">Business Trip</td> 
		
		                                        <td class="tab_h2">                                             
		                                            <button class="btn btn-xs btn-info" onclick="getBusinessTripDetails('${fjtuser.subordinatelist[current.uid].uname}','${current.fromdate}','${current.todate}','${current.uid}','${fjtuser.emp_code}', this);"><i class="fa fa-eye"></i> Visit Details</button>                                          
		                                        </td> 
		                                        <td class="tab_h2">
		                                            <c:set var="theurlA" value="LeaveProcess?ocjtfdinu=${current.applied_date.time}&edocmpe=${current.uid}&revorppa=${fjtuser.emp_code}&dpsroe=7&ntac=raluger"/>                                        
		                                            <div name="thebox"> <div class="sbt_btn"><a style='text-decoration: none;color: #ffffff' href="${theurlA}" target="result" onclick="startAjax(event, this);"> Approve</a></div></div>
		                                        </td>
												
												<td class="tab_h2">
		                                            <c:set var="theurlR" value="LeaveProcess?ocjtfdinu=${current.applied_date.time}&edocmpe=${current.uid}&revorppa=${fjtuser.emp_code}&dpsroe=5&ntac=raluger"/>
		                                            <div name="thebox">
		                                                <div class="btn_can"><a style='text-decoration: none;color: #ffffff' href="${theurlR}" target="result" onclick="startAjax(event, this);"> Reject</a></div></div>
		                                        </td>
												
		                                    </tr>
										</c:if>
		                                </c:forEach>
		                            </tbody>
		                        </table>
		                    </div>             
		         	   </c:if> --%>
               </table>
              </div>
              <div class="row">           
      			<div class="modal fade" id="cvDetails" role="dialog" >					
					 <div class="modal-dialog" style="width:60%;">
					     <!-- Modal content-->
							<div class="modal-content"> 
								    <div class="modal-body small"> <div id="table_div"></div></div> 
									<div class="modal-footer">
									         <button type="button" class="btn btn-default pull-right" data-dismiss="modal">Close</button>
									 </div>
							</div>								     								     
					   </div>   	 		   	 
		 			</div>
         	   </div>
         	    <div class="row">           
      			<div class="modal fade" id="businesstrpDetails" role="dialog" >					
					 <div class="modal-dialog" style="width:60%;">
					     <!-- Modal content-->
							<div class="modal-content"> 
								    <div class="modal-body small"> <div id="table_div"></div></div> 
									<div class="modal-footer">
									         <button type="button" class="btn btn-default pull-right" data-dismiss="modal">Close</button>
									 </div>
							</div>								     								     
					   </div>   	 		   	 
		 			</div>
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