<%-- 
    Document   : LOGISTIC DASHBOAR IMPORT P 
--%>
<%@include file="/logistic/header.jsp" %> 

 <c:choose>
 	<c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1 }">
 	 <style>
     .hidden-content{display:none;} 
     .slid, th.slid>input{max-width:30px !important; width:30px !important; } 
     .fnSts, th.fnSts, td.fnSts,th.fnSts>input {max-width:75px !important; width:75px !important; }    
     .dateFld, th.dateFld>input{max-width:75px !important; width:75px !important; }
     .cmnFld, th.cmnFld>input{max-width:max-content !important; width:80px !important; }  
     .textAreaFld, th.textAreaFld>input{/*max-width:80px !important; width:80px !important; */}   
     .fnRemarks,th.fnRemarks>input{ max-width:80px !important; width:80px !important; }  
  /* table tr:FIRST-CHILD + tr + tr { display:none; } */
   .sm-bx-row{/* display: table;  border: 1px solid #607d8b;margin-top: -10px; table-layout: fixed; margin-bottom: 2px;margin-left:15px; */ margin-top:7px;}
   .sm-bx-col{display: table-cell; padding:3px 10px; color:#000 !important;text-transform:uppercase;font-weight:bold;border: 1px solid #607d8b; }
   .genStyl{background:#dfe3f0;}
    /*tr.filters>th{background: white; color: #000 !important;}*/
    .txtarea-with-btn{display:inline-block;position:relative;}  
    .txtArea-history{display:block;}
    .history-btn{ position:absolute;top:1px;right:1px;} 
    .history-btn-vw{ position:absolute;top:1px;right:1px;margin-bottom:2px;}  
    #export{/* margin-left: 40%;  margin-top: 10px; */ margin-top:7px;}
    #dlvrySlct{height:22px !important;}
    .rqstDiv{    /* float: right; margin-right: 60%; margin-top: -8px; */  margin-top:7px;}
    .dataTables_wrapper{margin-top:-10px !important;}
	 </style>
 		<%@page import="com.google.gson.Gson"%>	 
 		<c:set var="controller" value="LogisticDeliveryController" scope="page" />
 		<c:set var="importController" value="LogisticPOController" scope="page" />
 		<c:set var="reportController" value="LogisticReportController" scope="page" />
 		<jsp:useBean id="now" class="java.util.Date" scope="request"/> 
 		<fmt:formatDate var="currentDate" value="${now}" pattern="dd/mm/yyyy" scope="page" /> 
 		<c:set  value="${fjtuser.uname}" var="empName" scope="page" />	
 		<c:set value="FJ-Logistic" var="topHeaderFullName" scope="page" />
  		<c:set value="L" var="topHeaderShortName" scope="page" />
  		<c:set value="Delivery" var="contentTitle" scope="page" />
  		<c:set value="Logistic Dashboard" var="dashboardFullName" scope="page" /> 
  		<c:set value="Logistic Portal" var="currentPortalName" scope="page" />

 	<body class="hold-transition skin-blue sidebar-mini sidebar-collapse sidebar-mini">
 		<div class="wrapper">
		 <%@include file="/logistic/dashboardHeader.jsp" %> 
		
  	 <!-- Left side column. contains the logo and sidebar -->
  	 <aside class="main-sidebar">
   			 <!-- sidebar-->
    		<section class="sidebar">
		      <!-- Sidebar user panel --> 
		      <!-- sidebar menu -->
		      <ul class="sidebar-menu" data-widget="tree">
		        <c:if test="${fjtuser.emp_divn_code eq 'LG' or  fjtuser.role eq 'mg'  }"> 
		        <li><a href="${reportController}"><i class="fa fa-dashboard"></i><span>Dashboard</span></a></li> 
		      </c:if>  
		         <li><a href="${importController}"><i class="fa fa-tasks"></i><span>Import PO's</span></a></li>  
		         <li class="active"><a href="${controller}"><i class="fa fa-truck"></i><span>Delivery</span></a></li>                  
		         <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>      
		      </ul>
		    </section>
		    <!-- /.sidebar -->
  	 </aside>

	  <!-- Content Wrapper. Contains page content -->
	  <div class="content-wrapper">
	    <%@include file="/logistic/contentHeader.jsp"   %>  
	    <!-- Main content -->	    
		    <%--Field Staff Home Section Start--%>
		    <section class="content" style="margin-top: -8px;"> 	   
		    <c:set var="rqstscount" value="0" scope="page" />    
		    <%-- TABLUAR DETAILS START --%>
		   <div class="row small"> 
	        <div class="col-xs-12">
	          <div class="box box-primary justify-content-center">   
	            <div class="sm-bx-row col-xs-6">
				     <div class="genStyl sm-bx-col">FROM ORION</div>
				    <div class="divnStyl  sm-bx-col">DIVISION TO INTIATE</div>
				    <div class="fnStyl  sm-bx-col">FINANACE  APPROVAL</div>
				    <div class="lgStyl  sm-bx-col">LOGISTICS UPDATE</div>
				</div>				
			     <div class="col-xs-3 rqstDiv"> 
			           <form method="POST" action="${controller}" >       
			   		     <div class="form-group form-inline"> 
			 			  <div class="form-group" id="multiSelectFrm">  
			 			 
						  <select class="form-control form-control-sm"     id="dlvrySlct"  name="dlvryType" required> 	
							 <option value="N" ${'N' == SDLVRYTYP ? 'selected':''} >Not Approved</option>
							 <option value="Y" ${'Y' == SDLVRYTYP ? 'selected':''} >Approved</option>				  
						 </select>
						</div> 
			             <button type="submit" name="refresh" id="refresh" class="btn btn-primary btn-xs refresh-btn filetrs-r" onclick="preLoader();" ><i class="fa fa-refresh"></i> View</button>
			            </div>
			            </form>
          		 </div> 
          		 <div class="col-xs-3"> 
			     	<button class="btn btn-xs btn-danger" id="export"><i class="fa fa-file-excel-o"></i> Export</button>  
			     </div>  
	            <div class="box-body table-responsive  padding" style="/*display:flex;*/">   
				 
	              <table class="table table-bordered small bordered display nowrap"  id="displayDlvry">  
	                <thead> 
	                <tr>
	                  <th class="slid" >SL. No.</th>  
	                  <th class="cmnFld" >INV. NO.</th> 
	                  <th class="cmnFld dateFld">INV. DATE</th>
	                  <th class="cmnFld" >CUSTOMER-CODE</th>
	                  <th class="cmnFld" >CUSTOMER-NAME</th>
	                  <th class="cmnFld">PROJECT</th>
	                  <th class="divnStyl cmnFld">PAYMENT TERMS</th>
	                  <th class="divnStyl cmnFld">PAYMENT<br/>STATUS</th>
	                  <th class="divnStyl cmnFld">CONTACT<br/>NAME</th>
	                  <th class="divnStyl cmnFld">CONTACT<br/>NUMBER</th>
	                  <th class="divnStyl cmnFld">SITE LOCATION</th>
	                  <th class="divnStyl dateFld">EXP. DELIVERY<br/>DATE</th>
	                  <th class="divnStyl cmnFld">No. & TYPE OF<br/>VEHICLE REQUIRED</th> 
	                  <th class="divnStyl cmnFld">DIVISION<br/>REMARKS</th>
	                  <th class="divnStyl cmnFld">DIVISION<br/>UPDATED</th> 
	                  <th class="fnStyl fnSts">Delivery <br/>Approved?</th>
	                  <th class="fnStyl fnRemarks">FINANCE<br/>REMARKS</th>
	                  <th class="fnStyl dateFld">FINANCE<br/>UPDATED</th>   
	                  <th class="lgStyl cmnFld">LOGISTIC<br/>APPROVED</th>
	                  <th class="lgStyl">LOGISTIC<br/>REMARKS</th>
	                  <th class="lgStyl cmnFld">LOGISTIC<br/>UPDATED</th> 
	                </tr>
	                </thead>
	                <tbody>
	                <c:forEach var="request" items="${DVRYLST}" > 
	                <c:set var="rqstscount" value="${rqstscount + 1}" scope="page" />
	                <tr> 
	                  <td class="slid"  id="${request.id}">
	                  ${rqstscount} 
	                  <c:if test="${request.divnUpdatedBy ne null }">
	                  	<button class="btn btn-info btn-xs "  onClick="showRemarks('${request.id}')" ><i class="fa fa-history" aria-hidden="true"></i></button>
	                  </c:if>
	                  </td> 
	                  <td id="invcNo${request.id}"  class='cmnFld'>${request.txnCode}-${request.invcNumber}</td>      
	                  <td id="invcDt${request.id}" class="dateFld"> 
	                  		<fmt:parseDate value="${request.invcDate}" var="theInvcDate"  dateStyle="short"   pattern="yyyy-MM-dd HH:mm" />
	                  		<fmt:formatDate value="${theInvcDate}" pattern="dd/MM/yyyy"/>
	                  </td> 
	                  <td class="dtlsHeader cmnFld"> ${fn:substring(request.customerCode, 0, 10)}<c:if test="${!empty request.customerCode}">..<span class="dtlsContent"  id="custCode${request.id}">${request.customerCode}</span></c:if></td>
	                  <td class="dtlsHeader cmnFld"> ${fn:substring(request.customername, 0, 10)}<c:if test="${!empty request.customername}">..<span class="dtlsContent"  id="custName${request.id}">${request.customername}</span></c:if></td>
	                  <td class="dtlsHeader cmnFld"> ${fn:substring(request.project, 0, 10)}
	                  <c:if test="${!empty request.project}">..<span class="dtlsContent"  id="project${request.id}">${request.project}</span></c:if>
	                    <input type="hidden" id="divUpdByVal${request.id}" value="${request.divnUpdatedBy}"/>
	                    <input type="hidden" id="divUpdByName${request.id}" value="${request.divnEmpName}"/> 
	                  </td>                    
	                 <c:choose>
	                 	<c:when test="${fjtuser.role eq 'mg' or fjtuser.emp_divn_code eq 'FN' or  fjtuser.emp_divn_code eq 'LG' or  request.logisticUpdBy ne null or lgPermission eq 'view' or request.divnUpdatedBy ne null}">
	                 		<td class="divnStyl dtlsHeader cmnFld"> ${fn:substring(request.paymentTerms, 0, 7)}<c:if test="${!empty request.paymentTerms}"><span class="dtlsContent" >${request.paymentTerms}</span></c:if></td>  
	                        <td class="divnStyl dtlsHeader cmnFld"> ${fn:substring(request.paymentStatus, 0, 9)}<c:if test="${!empty request.paymentStatus}"><span class="dtlsContent" >${request.paymentStatus}</span></c:if></td> 
	                        <td class="divnStyl dtlsHeader cmnFld"> ${fn:substring(request.contactName, 0, 9)}<c:if test="${!empty request.contactName}"><span class="dtlsContent" id="contactName${request.id}">${request.contactName}</span></c:if></td>  
	                        <td class="divnStyl dtlsHeader cmnFld"> ${fn:substring(request.contactNumber, 0, 9)}<c:if test="${!empty request.contactNumber}"><span class="dtlsContent" id="contactNumber${request.id}">${request.contactNumber}</span></c:if></td> 
	                        <td class="divnStyl dtlsHeader cmnFld"> ${fn:substring(request.siteLocation, 0, 9)}<c:if test="${!empty request.siteLocation}"><span class="dtlsContent" id="siteLocation${request.id}">${request.siteLocation}</span></c:if></td> 
	                        <td class="divnStyl dateFld">
	                  			<fmt:parseDate value="${request.expectedDeliveryDate}" var="theEDDDate"  dateStyle="short"   pattern="yyyy-MM-dd HH:mm" />
	                  			<fmt:formatDate value="${theEDDDate}" pattern="dd/MM/yyyy"/>
	                  			<span class="hidden-content" id="exDlvryDate${request.id}"><fmt:formatDate value="${theEDDDate}" pattern="dd/MM/yyyy"/></span>
							</td>
							<td class="divnStyl dtlsHeader cmnFld"> ${fn:substring(request.numberOfvehicleRequired, 0, 9)}<span class="dtlsContent" id="numTypVehicles${request.id}">${request.numberOfvehicleRequired}</span></td> 	                 	    	            
	                  		<td class="divnStyl dtlsHeader cmnFld"> ${fn:substring(request.divnRemarks, 0, 7)}
	                  		<c:if test="${!empty request.divnRemarks}">...<span class="dtlsContent">${request.divnRemarks}</span></c:if> 
	                  		</td>   
	                  		<td class="divnStyl dtlsHeader cmnFld">  ${fn:substring(request.divnEmpName, 0, 9)}<c:if test="${!empty request.divnEmpName}">
	                  				<span class="dtlsContent">Last Updated By ${request.divnEmpName} <br/>  
	                   			 	  <fmt:parseDate value="${request.divnUpdatedDate}" var="theDivUpdtDate"  dateStyle="short"   pattern="yyyy-MM-dd HH:mm" /> 
		                    	 	 At <fmt:formatDate value="${theDivUpdtDate}" pattern="dd/MM/yyyy HH:mm"/> 
		                    	   </span>
		                    	   </c:if>
		                    </td> 
	                 	</c:when>  
	                 	<c:otherwise>
	                 	  <td class="divnStyl cmnFld"> 
	                 	  	<input type="text" id="paymentTerms${request.id}"    value="${request.paymentTerms}" autocomplete="off" />
	                 	  </td>  
	                   	  <td class="divnStyl cmnFld">   
	                   	  	 <input type="text" id="paymentStatus${request.id}"    value="${request.paymentStatus}" autocomplete="off" />
	                   	  </td>
	                   	  <td class="divnStyl cmnFld"> 
	                 	  	<input type="text" id="contactName${request.id}"    value="${request.contactName}" autocomplete="off" />
	                 	  </td>  
	                   	  <td class="divnStyl cmnFld">   
	                   	  	 <input type="text" id="contactNumber${request.id}"    value="${request.contactNumber}" autocomplete="off" />
	                   	  </td>
	                   	  <td class="divnStyl cmnFld">   
	                   	  	 <input type="text" id="siteLocation${request.id}"    value="${request.siteLocation}" autocomplete="off" />
	                   	  </td>  
	                   	  <td class="divnStyl dateFld">
		                  	<fmt:parseDate value="${request.expectedDeliveryDate}" var="theEDDDate"  dateStyle="short"   pattern="yyyy-MM-dd HH:mm" />
		                  	<input  class="form-control form-control-xs filetrs theEDDDate"   type="text" id="exDlvryDate${request.id}"  value="<fmt:formatDate value="${theEDDDate}" pattern="dd/MM/yyyy"/>" autocomplete="off"   required/>
		                  </td> 
		                  <td class="divnStyl cmnFld">     
	                   	  	 <textarea rows="1"  class="form-control form-control-xs filetrs-txtArea"  id="numTypVehicles${request.id}" class="divRemarks" >${request.numberOfvehicleRequired}</textarea>
	                   	  </td>
		                  <td class="divnStyl textAreaFld"> 
			                  <div class="txtarea-with-btn">
		                 		 		<textarea  rows="2" cols="20" class="txtArea-history" id="divRemarks${request.id}"  >${request.divnRemarks}</textarea>  
			                  </div>		                  
		                  </td>
		                  
		                  <td class="divnStyl dtlsHeader cmnFld dateFld">
		                  <button class="btn btn-xs btn-primary updateBtn" id="dvUpdtBtn${request.id}" onClick="updateDivnAction('${request.id}');">Update</button> 
		                  <c:choose>
		                  		<c:when test="${!empty request.divnEmpName}">
		                  			<span id="divUpdBy${request.id}" class="dtlsContent"> 
				                   		Last Updated By<br/>	${request.divnEmpName} <br/>  
				                     	<fmt:parseDate value="${request.divnUpdatedDate}" var="theDivUpdtDate"  dateStyle="short"   pattern="yyyy-MM-dd HH:mm" />
				                     	On<fmt:formatDate value="${theDivUpdtDate}" pattern="dd/MM/yyyy HH:mm"/>   
		                    		</span> 
		                  		</c:when>
		                  		<c:otherwise><span id="divUpdBy${request.id}" class=""> </span></c:otherwise>
		                  </c:choose>		                   	                  
		                  </td>
	                 	</c:otherwise>
	                 </c:choose> 
	                  <c:choose> 
	                 	<c:when test="${request.divnUpdatedBy ne null  and request.contactName ne null and request.contactNumber ne null and request.expectedDeliveryDate ne null and request.siteLocation ne null and fjtuser.emp_divn_code eq 'FN' and ( request.finUpdatedBy eq null or request.finStatus eq 'NOT OK')}"> 
	                 		<td class="fnStyl fnSts" > 
		                 		 <select class="pmtStatus" id="finStatus${request.id}" >
		                 		 	<option  value="" ${request.finStatus eq '' ? 'selected="selected"' : ''} >Select</option> 
		  							<option  value="OK" ${request.finStatus eq 'OK' ? 'selected="selected"' : ''}>OK</option> 
		  							<option  value="NOT OK" ${request.finStatus eq 'NOT OK' ? 'selected="selected"' : ''} >NOT OK</option>
		  			      		</select>	
		  			  		</td>
	                 		 <td class="fnStyl textAreaFld">	                 		 
	                 		 	<div class="txtarea-with-btn">
	                 		 		<textarea  rows="2" cols="20" class="txtArea-history" id="finRemarks${request.id}"  >${request.finRemarks}</textarea>  
		                  		</div>
	                 		 </td>
	                  		<td class="fnStyl dtlsHeader dateFld" id="fnUpdtStatus${request.id}" >
	                  		<button class="btn btn-xs btn-primary updateBtn" id="fnUpdtBtn${request.id}" onClick="updateFinAction('${request.id}');">Update</button> 
	                  		 <c:choose>
		                  		<c:when test="${!empty request.finEmpName}">
		                  			 <span id="finUpdBy${request.id}"  class="dtlsContent"> 
				                  		 Last Updated By<br/>	 ${request.finEmpName} <br/> 
				                  		  <fmt:parseDate value="${request.finUpdatedDate}" var="theFinUpdtDate"  dateStyle="short"   pattern="yyyy-MM-dd HH:mm" />
					                     On <fmt:formatDate value="${theFinUpdtDate}" pattern="dd/MM/yyyy HH:mm"/> 			                     	
	                  		  		 </span>
		                  		</c:when>
		                  		<c:otherwise><span id="finUpdBy${request.id}" class=""> </span></c:otherwise>
		                     </c:choose>
	                  		 </td>     
	                 	</c:when>
	                 	<c:otherwise>
	                 		<td class="fnStyl fnSts" >
	                 		<c:choose>  
		                  	 <c:when test="${(request.finUpdatedBy eq null or empty request.finUpdatedBy ) and  (request.logisticApproved eq null and empty request.logisticApproved  and  request.divnUpdatedBy ne null and !empty request.divnUpdatedBy ) }">
		                  	  Pending By Finance
		                  	 </c:when> 
		                  	 <c:otherwise>${request.finStatus}</c:otherwise>
		                  	 </c:choose> 
	                 		  </td>
	                 		 <td class="fnStyl dtlsHeader fnRemarks"> ${fn:substring(request.finRemarks, 0, 9)}
	                 		 <c:if test="${!empty request.finRemarks}">...<span class="dtlsContent">${request.finRemarks}</span></c:if> 
	                 		 </td> 
	                 		 <td class="fnStyl dtlsHeader dateFld"> ${fn:substring(request.finEmpName, 0, 9)}<c:if test="${!empty request.finEmpName}">
	                 		 <span class="dtlsContent">
	                 		  By ${request.finEmpName} <br/>  
	                  		<fmt:parseDate value="${request.finUpdatedDate}" var="theFinUpdtDate"  dateStyle="short"   pattern="yyyy-MM-dd HH:mm" />
		                    On <fmt:formatDate value="${theFinUpdtDate}" pattern="dd/MM/yyyy HH:mm"/> 
	                 		 </span></c:if>                 
	                 		 </td>    
	                 	</c:otherwise>
	                 </c:choose>                                            	                 	
	                  <c:choose>
	                 	<%-- <c:when test="${fjtuser.emp_divn_code eq 'LG'  and  request.divnUpdatedBy ne null  and   request.finUpdatedBy ne null}">	 --%>   
	                 	<c:when test="${fjtuser.emp_divn_code eq 'LG' and request.logisticApproved ne 'Y'  and request.expectedDeliveryDate ne null  and    request.divnUpdatedBy ne null   }">                      
		                
		                  	<td class="lgStyl">
		                  	<c:choose>
		                  	<c:when test="${request.logisticApproved eq 'Y' }"><input  type="checkbox" id="lgStatus${request.id}" checked  /></c:when>
		                  	<c:otherwise><input  type="checkbox" id="lgStatus${request.id}"     /></c:otherwise>
		                  </c:choose>
		                  	</td>
		                  	<td class="lgStyl textAreaFld"> 
		                  	<div class="txtarea-with-btn">
		                  		<textarea  rows="2" cols="20" class="txtArea-history"  id="lgRemarks${request.id}" name="lgRemarks" >${request.logisticRemark}</textarea> 
		                  	</div>
		                  	</td>  
		                  	<td class="lgStyl dtlsHeader cmnFld dateFld" id="lgUpdtStatus${request.id}">
		                  		<button class="btn btn-xs btn-primary updateBtn" id="lgUpdtBtn${request.id}" onClick="updateLogsticAction('${request.id}');">Update</button>
		                  		 <c:choose>
		                  			<c:when test="${!empty request.logEmpName}">
		                  				<span id="logUpdBy${request.id}" class="lg_dtlsContent"> 
				                  			<fmt:parseDate value="${request.logisticUpdDate}" var="theLogUpdtDate"  dateStyle="short"   pattern="yyyy-MM-dd HH:mm" /> 		 
				                  			Last Updated By<br/>	 ${request.logEmpName} <br/> 
				                  			On <fmt:formatDate value="${theLogUpdtDate}" pattern="dd/MM/yyyy HH:mm"/>  
		                  				</span> 
		                  			</c:when>
		                  			<c:otherwise><span id="logUpdBy${request.id}"  class=""></span></c:otherwise>
		                  		</c:choose>		                  					                  					                  		
		                  	</td> 
	                 	</c:when> 
	                 	<c:otherwise> 
		                  	 <td class="lgStyl dtlsHeader cmnFld small" id="finStatusUp${request.id}">
		                  	 <c:choose>
		                  	 <%-- <c:when test="${divnUpdatedBy eq null}">
		                  	  <small>Division <br/>Not Updated</small>
		                  	 </c:when> --%> 
		                  	  <c:when test="${request.logisticApproved eq 'Y'}">
		                  	  Approved
		                  	 </c:when>
		                  	 <c:when test="${request.logisticApproved eq 'N' }">
		                  	  Not Approved
		                  	 </c:when>
		                  	 <c:when test="${(request.logisticApproved eq null or empty request.logisticApproved) and (request.divnUpdatedBy eq null or empty request.divnUpdatedBy)   }">
		                  	  Division 
		                  	  Not Initiated
		                  	 </c:when>
		                  	 <c:when test="${(request.logisticApproved eq null or empty request.logisticApproved) and (request.divnUpdatedBy ne null and !empty request.divnUpdatedBy)  and (request.finUpdatedBy eq null or empty request.finUpdatedBy or request.finStatus eq 'NOT OK')   }">
		                  	  Waiting for <br/> finance approval
		                  	 </c:when>
		                  	 <c:otherwise>Pending By Logistic</c:otherwise>
		                  	 </c:choose>
		                  	 </td>
		                  	 <td class="lgStyl dtlsHeader cmnFld"> ${fn:substring(request.logisticRemark, 0, 7)}
		                  	 <c:if test="${!empty request.logisticRemark}">...<span class="lg_dtlsContent">${request.logisticRemark}</span></c:if> 
		                  	 </td>		                  	                 	
		                  	<td class="lgStyl dtlsHeader cmnFld dateFld"> ${fn:substring(request.logEmpName, 0, 9)} <br/>
		                  	<c:if test="${!empty request.logEmpName}">
		                  	<span class="lg_dtlsContent">By  ${request.logEmpName}<br/>
		                  	<fmt:parseDate value="${request.logisticUpdDate}" var="theLogUpdtDate"  dateStyle="short"   pattern="yyyy-MM-dd HH:mm" />
		                    On <fmt:formatDate value="${theLogUpdtDate}" pattern="dd/MM/yyyy HH:mm"/> 
		                  	</span></c:if>
		                  	
		                  	 </td> 
	                 	</c:otherwise>
	                  </c:choose>	                  	                 
	                </tr> 
	               </c:forEach>      
	              </tbody>
	              </table> 
				</div>
	              <div id="exclData" style="display:none;"></div> 
	            </div>
	            <!-- /.box-body -->
	          </div>
	          <!-- /.box -->
	        </div> 
		  <%-- TABULAR DETAILS END --%> 
		    </section>
		    <%--Modal Start--%>	   
		    <div class="row">
				<div class="modal fade" id="modal-remarks" role="dialog" >
        			<div class="modal-dialog   modal-md"  >
     				<!-- Modal content-->
		      			<div class="modal-content">
				        	<div class="modal-header">
				         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
				          		<h5 class="modal-title">Remarks</h5>
				        	</div>
				        	<div class="modal-body small"> </div>
					        <div class="modal-footer">
					          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					        </div>
			     		</div>			   			     
	   	 			</div>   	 		   	 
				</div>
			</div>   
			<%--Modal End--%>	  
	    <div id="laoding" class="loader" ><img src="././resources/images/wait.gif"></div> 
	    <!-- /.content -->
	   </div>   
  	<!-- /.content-wrapper -->
	<%@include file="/logistic/footer.jsp" %> 
	<!-- page script start -->
	</div>
<script>
var _url = 'LogisticDeliveryController';
var _method = "POST"; 
var dlvryList = <%=new Gson().toJson(request.getAttribute("DVRYLST"))%>;  
var exportTable = "<table class='table' id='exclexprtTble'><thead>"; 
var table;
$(function(){ 
	 $('.loader').hide();	 
	 $(".theEDDDate").datepicker({ "dateFormat" : "dd/mm/yy", yearRange: "2022:2030", minDate : -7});
	 $("#todate").datepicker({"dateFormat" : "dd/mm/yy",maxDate : 0 });
	 
	  $('#displayDlvry thead tr').clone(true).addClass('filters').appendTo('#displayDlvry thead'); 
	  	  
	 $('#displayDlvry').DataTable({  
	        'paging'      : true,
	        'lengthChange': false,
	        'searching'   : true,
	        'ordering'    : true,
	        'info'        : false,
	       // "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
	        "columnDefs" : [{"targets":[2, 11], "type":"date-eu"}], 
	          responsive: true,
	    	  orderCellsTop: true,
	          fixedHeader: true, 

		        'autoWidth'   : false,
	    	 initComplete: function () {
 	            var api = this.api();
 	 
 	            // For each column
 	            api
 	                .columns()
 	                .eq(0)
 	                .each(function (colIdx) {
 	                    // Set the header cell to contain the input element
 	                    var cell = $('.filters th').eq(
 	                        $(api.column(colIdx).header()).index()
 	                    );
 	                    var title = $(cell).text();
 	                    $(cell).html('<input type="text" placeholder="' + title + '" />');
 	 
 	                    // On every keypress in this input
 	                    $(
 	                        'input',
 	                        $('.filters th').eq($(api.column(colIdx).header()).index())
 	                    )
 	                        .off('keyup change')
 	                        .on('keyup change', function (e) {
 	                            e.stopPropagation();
 	 
 	                            // Get the search value
 	                            $(this).attr('title', $(this).val());
 	                            var regexr = '({search})'; //$(this).parents('th').find('select').val();
 	 
 	                            var cursorPosition = this.selectionStart;
 	                            // Search the column for that value
 	                            api
 	                                .column(colIdx)
 	                                .search(
 	                                    this.value != ''
 	                                        ? regexr.replace('{search}', '(((' + this.value + ')))')
 	                                        : '',
 	                                    this.value != '',
 	                                    this.value == ''
 	                                )
 	                                .draw();
 	 
 	                            $(this)
 	                                .focus()[0]
 	                                .setSelectionRange(cursorPosition, cursorPosition);
 	                        });
 	                });
 	        },    
	 } );   
 
	 ////
	 exportTable += "<tr><th>INV. NO.</th> <th >INV. DATE</th><th>CUSTOMER-CODE</th><th>CUSTOMER-NAME</th> <th>PROJECT</th> <th>PAYMENT TERMS</th>  <th>PAYMENT STATUS</th>"+
	 "<th>CONTACT NAME</th> <th>CONTACT NO.</th>  <th>SITE LOCATION</th>  <th>EXPECTED DELIVERY DATE</th><th>NUMBER AND TYPE OF VEHICLE REQUIRED</th>"+
	 "<th>DIVISION REMARKS</th><th>DIVISION UPDATED BY</th> <th>DIVISION UPDATED DATE</th>  <th>Delivery  Approved?</th>   <th>FINANCE REMARKS</th> <th>FINANCE UPDATED BY</th><th>FINANCE UPDATED DATE</th>"+
	 "<th>LOGISTIC APPROVED?</th> <th>LOGISTIC REMARKS</th><th>LOGISTIC UPDATED BY</th><th>LOGISTIC UPDATED DATE</th>"+
	 "</tr></thead><tbody>";	 
	 dlvryList.map(item =>{
		 exportTable +="<tr>";
		 exportTable +="<td>"+checkValidOrNot(item.txnCode)+"-"+checkValidOrNot(item.invcNumber)+"</td><td>"+checkValidOrNotDate(item.invcDate)+"</td><td>"+checkValidOrNot(item.customerCode)+"</td><td>"+checkValidOrNot(item.customername)+"</td><td>"+checkValidOrNot(item.project)+"</td><td>"+checkValidOrNot(item.paymentTerms)+"</td>"; 
		 exportTable +="<td>"+checkValidOrNot(item.paymentStatus)+"</td><td>"+checkValidOrNotDate(item.contactName)+"</td><td>"+checkValidOrNot(item.contactNumber)+"</td><td>"+checkValidOrNot(item.siteLocation)+"</td><td>"+checkValidOrNotDate(item.expectedDeliveryDate)+"</td><td>"+checkValidOrNot(item.numberOfvehicleRequired)+"</td><td>"+checkValidOrNot(item.divnRemarks)+"</td><td>"+checkValidOrNot(item.divnEmpName)+"</td>"; 
		 exportTable +="<td>"+checkValidOrNotDate(item.divnUpdatedDate)+"</td><td>"+checkValidOrNot(item.finStatus)+"</td><td>"+checkValidOrNot(item.finRemarks)+"</td><td>"+checkValidOrNot(item.finEmpName)+"</td><td>"+checkValidOrNotDate(item.finUpdatedDate)+"</td>";
		 exportTable +="<td>"+checkValidOrNotDate(item.logisticApproved)+"</td><td>"+checkValidOrNot(item.logisticRemark)+"</td><td>"+checkValidOrNot(item.logEmpName)+"</td><td>"+checkValidOrNotDate(item.logisticUpdDate)+"</td>"; 
		 exportTable +="</tr>";
	 });
	 exportTable +="</tbody></table>";  
	 $("#exclData").html(exportTable); 	 
	 table1 = $('#exclexprtTble').DataTable({   dom: 'Bfrtip',  
		   buttons: [{ extend: 'excelHtml5', text:      '<i class="fa fa-file-excel-o" style="color: #fff; font-size: 1.5em;">Download</i>', filename: 'LOGISTIC DASHBORD LOCAL DELIVERY REPORT - ${currCal}',
		   title: 'LOGISTIC DASHBORD LOCAL DELIVERY  REPORT - ${currCal}', messageTop: 'The information in this file is copyright to FJ-Group.'}]
	} ); 
	
	 
	 $("#export").on("click", function() {
		    table1.button( '.dt-button' ).trigger();
		});
});
function preLoader(){ $('.loader').show();}
function updateDivnAction(id, type){ 
	      
	var paymentTerm = $.trim($.trim(document.getElementById('paymentTerms'+id+'').value));
	var paymentStatus = $.trim(document.getElementById('paymentStatus'+id+'').value);
	var contactName = $.trim(document.getElementById('contactName'+id+'').value);
 	var contactNumber = $.trim(document.getElementById('contactNumber'+id+'').value); 
	var location = $.trim(document.getElementById('siteLocation'+id+'').value);
	var expDlvryDate = $.trim(document.getElementById('exDlvryDate'+id+'').value);
	var divRemarks = $.trim(document.getElementById('divRemarks'+id+'').value); 
	var numTypVhcles = $.trim(document.getElementById('numTypVehicles'+id+'').value); 	  
	var divAction = $.trim(document.getElementById('divUpdBy'+id+'').innerHTML);   
	
	var invcNo = $.trim(document.getElementById('invcNo'+id+'').innerHTML); 
	
	var type = 0;  
	if(divAction == null || divAction == '' || typeof divAction === 'undefined' || divAction == 'undefined'){
		type = 0;
	}else{ type = 1; }  
	if(paymentTerm && paymentStatus && expDlvryDate &&  contactNumber && contactName && location  && divRemarks){	
		if(checkDateFormat(expDlvryDate, "Expected Delivery Date")){
			if ((confirm('Are You sure, You Want to update this details.!'))) { 
			 		preLoader();		   
					$.ajax({
					 type: _method,
			    	 url: _url, 
			    	 data: {action: "updudea", podd0:id, podd1:paymentTerm, podd2:paymentStatus, podd3:contactName, podd4:contactNumber, podd5:location,   podd6:expDlvryDate, podd7:divRemarks, podd8:numTypVhcles, podd9:type, podd10:invcNo  },
			    	 success: function(data) {  
			    	 $('.loader').hide();
			    	 if (parseInt(data) == 1) {	 
			    		 var updateBox = document.getElementById('divUpdBy'+id+''); 
			    		 if(!updateBox.classList.contains("dtlsContent")){updateBox.classList.add("dtlsContent");}	
			    		 updateBox.innerHTML='<b class="updatedStyl">Updated Successfully!.</b> By<br/> <b class="text-primary">${empName}</b> <br/> On <b class="text-primary">'+moment().format("DD/MM/YYYY, h:mm:ss a")+'</b>';
			    		 document.getElementById('dvUpdtBtn'+id+'').disabled = true;
			    		 document.getElementById('divRemarks'+id+'').disabled = true;
			    		 document.getElementById('contactName'+id+'').disabled = true;
			    		 document.getElementById('contactNumber'+id+'').disabled = true;
			    		 document.getElementById('paymentTerms'+id+'').disabled = true;  
			    		 document.getElementById('paymentStatus'+id+'').disabled = true;  
			    		 document.getElementById('siteLocation'+id+'').disabled = true;  
			    		 document.getElementById('exDlvryDate'+id+'').disabled = true; 
			    		 document.getElementById('numTypVehicles'+id+'').disabled = true; 
			    		 alert("Details updated successfully & Email sent to Finance team!.");
			    		  return true;
			            }else if(parseInt(data) == 0){ 
			            	alert("Details not updated,Please refresh the page!.");
			            	 return false;
			            }else if(parseInt(data) == 40){ 
			            	alert("Please fill Payment Term,Payment Status, Expected Delivery Date, Contact Name, Contact Number, Site location, Vehicle details, and Remarks...");
			            	 return false;
			            }else{
			            	 alert("Details not updated,Please refresh the page!.");
			            	 return false;
			            }
			     		},error:function(data,status,er) {
			    		 $('#loading').hide();
			    		 alert("Details not updated,Please refresh the page!.");
			    		 return false;	 
			     		}
			   			}); 
			 		} else{return false;} 
		 } else{return false;} 
	}else{alert('Please fill Payment Term,Payment Status, Expected Delivery Date, Contact Name, Contact Number, Site location, Vehicle details, and Remarks...');}
	
}

function updateFinAction(id){  
	var status = $.trim(document.getElementById('finStatus'+id+'').value); 
	var finRemarks = $.trim(document.getElementById('finRemarks'+id+'').value); 
	var invcNo = $.trim(document.getElementById('invcNo'+id+'').innerHTML); 
	var contactName = $.trim(document.getElementById('contactName'+id+'').innerHTML);
 	var contactNumber = $.trim(document.getElementById('contactNumber'+id+'').innerHTML); 
	var location = $.trim(document.getElementById('siteLocation'+id+'').innerHTML);
	var expDlvryDate = $.trim(document.getElementById('exDlvryDate'+id+'').innerHTML); 
	var numTypVhcles = $.trim(document.getElementById('numTypVehicles'+id+'').innerHTML); 	
	
	if( (status ||  finRemarks) && (status === 'OK' || status === 'NOT OK' || status === '') &&  finRemarks){	 
			if ((confirm('Are You sure, You Want to update this details!'))) { 
				 preLoader();		   
					$.ajax({
					 type: _method,
			    	 url: _url, 
			    	 data: {action: "upfudea", podf0:id, podf1:status, podf2:finRemarks, podf3: invcNo, podf4:contactName, podf5:contactNumber, podf6:location, podf7:expDlvryDate, podf8:numTypVhcles  },
			    	 success: function(data) {    
			    	 $('.loader').hide();
			    	 if (parseInt(data) == 1) {	 
			    		 var updateBox = document.getElementById('finUpdBy'+id+'');
			    		 if(!updateBox.classList.contains("dtlsContent")){updateBox.classList.add("dtlsContent");}
			    		 updateBox.innerHTML='<b class="updatedStyl">Updated Successfully!.</b> By<br/> <b class="text-primary">${empName}</b> <br/> On <b class="text-primary">'+moment().format("DD/MM/YYYY, h:mm:ss a")+'</b>';			    		 			    					    		 
			    		
			    		 if(status === 'OK'){
			    			 document.getElementById('fnUpdtBtn'+id+'').disabled = true;
				    		 document.getElementById('finRemarks'+id+'').disabled = true;
				    		 document.getElementById('finStatus'+id+'').disabled = true;
				    		 document.getElementById('fnUpdtBtn'+id+'').disabled = true;
				    		 document.getElementById('fnUpdtBtn'+id+'').style.display = "none";
				    		 document.getElementById('fnUpdtStatus'+id+'').innerHTML ="Updated";
				    		 document.getElementById('finStatusUp'+id+'').innerHTML ="Finance Approved";
			    		 alert("Details updated successfully & Email sent to Logistic team!.");
			    		 }else{
			    			 document.getElementById('finStatusUp'+id+'').html ="Finance Approved";
			    			 alert("Details updated successfully.");}
			    		  return true;
			            }else if(parseInt(data) == 0){ 
			            	alert("Something went wrong. Please refresh the page to see updated details");
			            	 return false;
			            }else{
			            	 alert("Details not updated,Please refresh the page!.");
			            	 return false;
			            }
			     		},error:function(data,status,er) {  
			    	 		 $('.loader').hide();
			    			 alert("Details not updated,Please refresh the page!.");
			    	 		 return false;	 
			     		}
			   		}); 
			 }else{return false;}  
	}else{alert('Please fill "OK/NOT OK"  and Remarks...');}
	
}
function updateLogsticAction(id){   
	var status = (document.getElementById('lgStatus'+id+'').checked) ? "Y" : "N";   
	var remarks = $.trim(document.getElementById('lgRemarks'+id+'').value);  
	var invcNo = $.trim(document.getElementById('invcNo'+id+'').innerHTML);
	var divUpdByName = $.trim(document.getElementById('divUpdByName'+id+'').value); 
	var divUpdByCode = $.trim(document.getElementById('divUpdByVal'+id+'').value); 
	var statusMessage = "Not Approved"; 
	if(status == "Y"){  
	statusMessage = "Approved";}  
	if(remarks != null && remarks != 'undefined' && remarks != ''){  
			if(confirm('Delivery '+statusMessage+'. Are You sure?, You Want to update this details!')) { 
			 preLoader();		   
				$.ajax({
					 type: _method,
			    	 url: _url, 
			    	 data: {action: "upludea", podl0:id, podl1:status, podl2:remarks, podl3:invcNo, podl4: divUpdByName, podl5: divUpdByCode  },
			     success: function(data) {  
			    	 $('.loader').hide();
			    	 if (parseInt(data) == 1) {	 
			    		 var updateBox = document.getElementById('logUpdBy'+id+'');
			    		 if(!updateBox.classList.contains("lg_dtlsContent")){updateBox.classList.add("lg_dtlsContent");}		    		 
			    		 updateBox.innerHTML='<b class="updatedStyl">Updated Successfully!.</b> By<br/> <b class="text-primary">${empName}</b> <br/> On <b class="text-primary">'+moment().format("DD/MM/YYYY, h:mm:ss a")+'</b>';
			    		 if(status == "Y"){ 
			    		 	document.getElementById('lgUpdtBtn'+id+'').disabled = true;
			    		 	document.getElementById('lgRemarks'+id+'').disabled = true;
			    		 	document.getElementById('lgStatus'+id+'').disabled = true;
			    		 	document.getElementById('lgUpdtBtn'+id+'').style.display = "none";
				    		document.getElementById('lgUpdtStatus'+id+'').innerHTML ="Updated";
				    		document.getElementById('lgUpdtStatus'+id+'').innerHTML ="Approved";
			    		 }
			    		 alert("Details updated successfully & Email sent to respective division!.");
			    		  return true;
			            }else if(parseInt(data) == 0){
			            	alert("Something went wrong. Please refresh the page to see updated details");
			            	 return false;
			            }else{
			            	 alert("Details not updated,Please refresh the page!.");
			            	 return false;
			            }
			     },error:function(data,status,er) {
			    	 $('.loader').hide();
			    	 alert("Details not updated,Please refresh the page!.");
			    	 return false;	 
			     }
			   }); 
			 }else{return false;}  
	}else{alert('Please enter remarks...');}
	
}

function showRemarks(id){  
	var invcNo = $.trim(document.getElementById('invcNo'+id+'').innerHTML); 
	var invcId =  $.trim(id);   
	if(invcNo !== null &&  invcId !== null && invcNo !== 'undefined' && invcId != 'undefined' && invcNo != '' && invcId != ''  ){	 
			 		preLoader();
			 		
			 		var ttl="<b>Remarks History for Local Delivery Request - <strong style='color:blue;'>"+invcNo+"</strong></b>";
			 	    var excelTtl="Remarks History  for Local Delivery Request  -  "+invcNo+"  ";
			 	    $("#modal-remarks .modal-title").html(ttl);
					$.ajax({
					 type: _method,
			    	 url: _url, 
			    	 data: {action: "rmrkHstry", d0:invcId},
			    	 success: function(data) {  
			    	 $('.loader').hide();
			    	 var output="<table id='tbl-excl' class='table table-bordered small'><thead><tr>"+"<th>#</th><th>Remarks</th><th>Division</th><th>Updated By</th><th>Updated On</th></tr></thead><tbody>";
			    	 var j=0;for (var i in data) {
			    		 j=j+1; 
			    		 output+="<tr><td>"+j+"</td><td>" + $.trim(data[i].remarks)+ "</td><td>" + $.trim(data[i].rem_action_by)+ "</td><td>" + $.trim(data[i].remarks_crtd_by)+ "</td><td>" + $.trim(data[i].remarks_crtd_on.substring(0, 10)).split("-").reverse().join("/")+" "+$.trim(data[i].remarks_crtd_on.substring(11, 19)).split("-")+ "</td></tr>"; 
			    		 } 
			    	 output+="</tbody></table>";  
			    	 $("#modal-remarks .modal-body").html(output);$("#modal-remarks").modal("show");
			    	 $('#tbl-excl').DataTable( {
			    	     dom: 'Bfrtip', 
			    	     "columnDefs" : [{"targets":[3], "type":"date-eu"}],
			    	     buttons: [
			    	         {
			    	             extend: 'excelHtml5',
			    	             text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
			    	             filename: excelTtl,
			    	             title: excelTtl,
			    	             messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to FJ Group.'
			    	             
			    	             
			    	         }
			    	       
			    	        
			    	     ]
			    	 } );
			     		},error:function(data,status,er) {
			    		 $('#loading').hide();
			    		 alert("Details not updated,Please refresh the page!.");
			    		 return false;	 
			     		}
			   			});    
	}else{alert('Please fill Expected Delivery Date, Contact Name, Contact Number and Site location...');}
	
}
function checkDateFormat(dateStr, dateName){  
	if(dateStr){
		if(!(moment(dateStr, "DD/MM/YYYY", true).isValid())){
			 alert("Please Select Correct "+dateName+" Date.");
			return false;
		}else{
			return true;
		} 
	}else{ return true;}
}
 function checkValidOrNot(value){
	 if(typeof value === 'undefined'){
		 return "-";
	 }else{
		 return value;
	 }
 }
 function checkValidOrNotDate(value){
	 if(typeof value === 'undefined'){
		 return "-";
	 }else{
		 return $.trim(value.substring(0, 10)).split("-").reverse().join("/");
	 }
 }
 function setContainerValue(noContainers, id){
	 if(Number.isInteger(noContainers)){ 
		document.getElementById('containers'+id+'').value = noContainers;
		 return noContainers;
	 }else{
		 document.getElementById('containers'+id+'').value = 0;
		 return 0;
	 } 
 }
 
</script>
<!-- page Script  end -->
</c:when>
<c:otherwise>
        <body onload="window.top.location.href='logout.jsp'">              
        </body> 
</c:otherwise>
</c:choose>
</html>