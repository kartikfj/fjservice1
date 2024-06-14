<%-- 
    Document   : PUMP SERVICE PORTAL , OFFICE STAFF HOME APGE 
--%>
<%@include file="/service/header.jsp" %>
<jsp:useBean id="now" class="java.util.Date" scope="request"/>
<fmt:parseNumber value="${now.time / (1000*60*60*24) }"  integerOnly="true" var="toDay" scope="request"/>
<c:set  value="0" var="dateDiff" scope="page" />
<style>
@media only screen and (max-width: 640px) {
table thead th[colspan]:not([colspan="1"]), table thead tr:nth-child(even) th[rowspan]{display: none;}table th:nth-child(5),table th:nth-child(6),table th:nth-child(7),table th:nth-child(8),table th:nth-child(9), table th:nth-child(10),
 table td:nth-child(5),table td:nth-child(6),table td:nth-child(7),table td:nth-child(8), table td:nth-child(9),table td:nth-child(10), table td:nth-child(12),table td:nth-child(13),
table td:nth-child(14),table td:nth-child(15), table td:nth-child(16),table td:nth-child(17),table td:nth-child(18){display: none;}table tr>th, table tr>td{font-size:10px !important;}
#btn-nw-rqst{margin-left: 15px !important;}.entry-btn-div {margin-top: -30px !important;}div.dt-buttons,.dataTables_wrapper .dataTables_info {  float: left !important;}
.box-header .box-title, .content-header>h1{font-size: 14px !important;}
.table-responsive>.table>tbody>tr>td{white-space: normal !important;}
}
}  
.txt-trim + [title]  {border: 5px solid blue;}table.dataTable td { width:max-content !important;}
table.dataTable{border-collapse: collapse !important;}.table>tbody>tr>td{line-height: 1.1 !important;vertical-align: middle !important;}table.dataTable thead th{    padding: 3px 8px !important;}
.rwfrmbx{width:65px !important;    margin-right: 0px !important; margin-left: 0px !important;}
#viewAssitanttable tbody  td, #viewAssitanttable thead th, #viewAssitanttable thead td{border: 1px solid #1979a9 !important; }
.modal-h5{border: 1px solid #1979a9 !important;margin-bottom:5px;margin-top: -20px;}.modal-h5 h5{padding: 0px 5px;   font-weight: 700;   color: #792e13;  font-family: monospace;}
</style>
<body class="hold-transition skin-blue sidebar-mini sidebar-collapse sidebar-mini">
 <c:if test="${empty fjtuser.emp_code}"> <jsp:forward page="index.jsp"/> </c:if>
 <c:choose>
 <c:when test="${!empty fjtuser.emp_code and fjtuser.checkValidSession eq 1}">
 <c:set var="controller" value="ServiceController" scope="page" />
<div class="wrapper">
  <header class="main-header">
    <!-- Logo -->
    <a href="homepage.jsp" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>FJ</b>S</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg">
         <i class="fa fa-edit"></i> <b>FJ-Services</b>
      </span>
    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <!-- User Account: style can be found in dropdown.less -->
          <li class="dropdown user user-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-user-circle"></i>
              <span class="hidden-xs">${fjtuser.uname}</span>
            </a>        
          </li>
           <%--Settings--%>
          <li class="dropdown notifications-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-gears"></i>
            </a>
            <ul class="dropdown-menu">
              <li class="header"><a  href="logout.jsp"> <i class="fa fa-power-off"></i> Log-Out</a></li>      
            </ul>
          </li>
          
        </ul>
      </div>
    </nav>
  </header>
  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- Sidebar user panel -->
      <!-- sidebar menu -->
      <ul class="sidebar-menu" data-widget="tree">
      	 <c:if test="${USRTYP eq 'VU' or USRTYP eq 'MU'  or USRTYP eq 'OU'}">
      	 <li><a href="ServiceReports"><i class="fa fa-bar-chart"></i><span>Reports</span></a></li>
      	 </c:if>
         <li class="active"><a href="${controller}"><i class="fa fa-table"></i><span>Service Requests</span></a></li>            
         <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>      
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1> After Sales Service Requests <small>Service Portal</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="homepage.jsp"><i class="fa fa-calendar"></i> Home</a></li>
        <li class="active">Service Portal</li>
      </ol>
    </section>   
    <!-- Main content -->	    
	    <%--Office Staff Entry Section Start--%>
	    <section class="content">
	    <c:set var="requestCount" value="0" scope="page" />  
	    <c:set var="statusText" value="" scope="page" />   
        <c:choose>
        <c:when test="${filters.status eq 0}"><c:set var="statusText" value="Pending" scope="page" /> </c:when>
        <c:when test="${filters.status eq 1}"><c:set var="statusText" value="Closed" scope="page" /> </c:when>
        <c:when test="${filters.status eq 2}"><c:set var="statusText" value="All" scope="page" /> </c:when>
        <c:otherwise></c:otherwise>
        </c:choose>         	    
	     <div class="row entry-btn-div">
	       <div class="col-md-10 col-xs-12"> 
           <form method="POST" >       
   		     <div class="form-group form-inline"> 
   		      <input  class="form-control form-control-sm filetrs"   placeholder="Select Start Date"  type="text" id="fromdate" name="fromdate" value="${filters.startDate}" autocomplete="off" onChange="setDeafultToDate()" required/>			
			  <input  class="form-control form-control-sm filetrs"    type="text" id="todate" placeholder="Select To Date"  name="todate"  value="${filters.toDate}"  autocomplete="off" required/>	 
			   <select class="form-control form-control-sm"   style="margin-top: -5px;" id="divn"  name="divn" required> 	  					 
				    <c:forEach var="item"  items="${DIVNLST}" >
									    <option value="${item.division}" ${item.division == SDIVN ? 'selected':''} >${item.division}</option>				   
			        </c:forEach>      
			   </select>
			   <select class="form-control form-control-sm  select2 filetrs"  name="status" required>						
  						<option  value="0" ${filters.status eq 0 ? 'selected="selected"' : ''}>Pending</option>
  						<option  value="1" ${filters.status eq 1 ? 'selected="selected"' : ''}>Closed</option>
  						<option  value="2" ${filters.status eq 2 ? 'selected="selected"' : ''}>All</option>
  			   </select>	
            <input type="hidden" value="custVw" name="action" />
            	<input type="hidden" value="${USRTYP}" name="usrTyp" />
            <button type="submit" name="refresh" id="refresh" class="btn btn-primary refresh-btn filetrs" onclick="preLoader();" ><i class="fa fa-refresh"></i> Refresh</button>
            </div> 
            </form>
          </div> 
          <c:if test="${USRTYP eq 'OU'}">
	     <div class="col-md-2 col-xs-12 pull-right">
	     	 <button type="button" class="btn btn-sm btn-primary" id="btn-nw-rqst" data-toggle="modal" data-target="#modal-officestaff" onClick="clearFields();">
                Create New Service Request
              </button>
	     </div>
	     </c:if>
	     </div> 
	    	     
	    <%-- TABLUAR DETAILS START --%>
	   <div class="row">
        <div class="col-xs-12">
          <div class="box box-primary">
            <div class="box-header">
              <h3 class="box-title"><b>Service Requests</b> - <span>${statusText}</span></h3>
              </div> 
            <!-- /.box-header --> 
            <div class="box-body table-responsive small" >
              <table class="table table-bordered small bordered no-padding" id="displayRqsts">
                <thead>
                  <tr>
                  <th rowspan="2" width="35px">SL. No.</th> 
                  <th rowspan="2" width="65px">SO Code-No.</th>
                  <th rowspan="2">Project Name</th>
                  <th rowspan="2">Service Type</th>
                  <th rowspan="2" width="100px">Status</th>
                  <th rowspan="2">Office Staff</th>
                  <th rowspan="2">Field Staff</th>
                  <th rowspan="2">Region</th>
                  <th rowspan="2">Location</th>
                  <th rowspan="2" width="50px">No. of Visits</th>
                   <th rowspan="2" width="50px">Tot. Service Hrs</th> 
                  <th rowspan="2" width="80px">Created On</th> 
                  <th colspan="3" align="center">Estimated</th> 
                  <th rowspan="2"  >Total Estimated Costing</th> 
                  <th colspan="3" align="center">Actual</th>                  
                  <th rowspan="2"  >Total Actual Costing</th> 
                  <th rowspan="2" width="70px">Action</th>
                </tr>
                 <tr>              
                  <th width="45px" >Material</th> 
                  <th width="45px">Labor</th> 
                  <th width="45px">Other</th>
                  <th width="45px">Material</th> 
                  <th width="45px">Labor</th> 
                  <th width="45px">Other</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="request" items="${SRVSRQSTS}" >
                 <c:set var="requestCount" value="${requestCount + 1 }" scope="page" />
                <tr>
                  <td>${requestCount}</td>
                  <td data-toggle="tooltip" data-html="true" class="txt-trim" title="${request.projectName}" >  ${request.soCodeNo}   </td> 
                  <td>  ${request.projectName} </td> 
                  <td>${request.visitType}</td>
                  <td>
                  <c:choose>
	                  <c:when test="${request.fldStatus eq 0  and request.finalStatus eq 0}"><span class="label label-danger">Field Visit - Pending</span></c:when>
	                  <c:when test="${(request.fldStatus eq 1  and request.finalStatus eq 0) or (request.fldStatus eq 1  and request.finalStatus eq 2)}"><span class="label label-info">OS Confirmation - Pending</span></c:when>
	                  <c:when test="${request.fldStatus eq 0  and request.finalStatus eq 2}"><span class="label label-danger">OS Returned to FS</span></c:when>
	                  <c:otherwise><span class="label label-success">Completed</span></c:otherwise>
	                  </c:choose>                  
                  </td>
                  <td>${request.officeUserName}</td>
                  <td>${request.fieldUserName}</td>
                   <td>${request.region}</td>
                  <td>${request.location}</td>
                  <td align="center">${request.noOfVisits}</td>
                  <td align="center">
	                  <fmt:formatNumber var="totalServiceHrs" type="number" minFractionDigits="2" maxFractionDigits="2" value="${request.totalServiceMinutes/60}" /> 
	                
	                  <span style="padding: 2px 5px !important;background-color: #9e9e9e47;border-color: #9e9e9e47;color: #000000;"  class="btn btn-warning bt-xs" 
	                   onclick="viewAssitantVisit('${request.id}', '${request.soCodeNo}','${request.projectName}', '${request.visitType}');">   ${totalServiceHrs}  <i style="color: #795548 !important;" class="fa fa-sm fa-arrow-right"></i></span>
                  </td>
                   <td> 
		                  <fmt:parseDate value="${request.createdDate}" var="theCrtdDate"  dateStyle="short"   pattern="yyyy-MM-dd HH:mm" />
				           <c:choose>
				           <c:when test="${request.fldStatus eq 0}">
				            
				           	<fmt:parseNumber value="${ theCrtdDate.time / (1000*60*60*24) }" integerOnly="true" var="CreatedDay" scope="page"/>
				           	<c:set  value="${toDay - CreatedDay}" var="dateDiff" scope="page" />			           	
				           	 	<b style="color:red;"> Due by ${dateDiff}  Days.</b>
				           	    <br/> 
				           	    <span class="small">(<fmt:formatDate value="${theCrtdDate}" pattern="dd/MM/yyyy HH:mm"/>)</span>        	 		           	 	           
				           </c:when>
				           <c:otherwise>
				            <b style="color:blue;"><fmt:formatDate value="${theCrtdDate}" pattern="dd/MM/yyyy HH:mm"/></b>
				           </c:otherwise>
				           </c:choose>               
                  </td>
                  <td width="45px" align="right"><fmt:formatNumber pattern="#,###.##" value="${request.materialCost}" /></td>
                  <td width="45px" align="right"><fmt:formatNumber pattern="#,###.##" value="${request.laborCost}" /></td>
                  <td width="45px" align="right"><fmt:formatNumber pattern="#,###.##" value="${request.otherCost}" /></td> 
                   <td width="45px" align="right"><fmt:formatNumber pattern="#,###.##" value="${request.totalEstCost}" /></td>
                  <td width="45px" align="right"><fmt:formatNumber pattern="#,###.##" value="${request.actMaterialCost}" /></td> 
                  <td width="45px" align="right"><fmt:formatNumber pattern="#,###.##" value="${request.actLaborCost}" /></td>
                  <td width="45px" align="right"><fmt:formatNumber pattern="#,###.##" value="${request.actOtherCost}" /></td>                 
                  <td width="45px" align="right"><fmt:formatNumber pattern="#,###.##" value="${request.totalActCost}" /></td>   
                  <td width="70px">
                  <div class="row rwfrmbx">
	                   <div class="col-xs-6">
	                   <form class="form-inline" action="${controller}" method="POST" name="vw-visit-details">
	                   		    <input type="hidden" value="${request.id}" name="rqid" />
	                    		<input type="hidden" value="${USRTYP}" name="usrTyp" />
								<input type="hidden" name="action" value="oview" /> 
								<button class="btn btn-xs btn-sm btn-primary"><i class="fa fa-eye"></i></button>
	                    </form>
	                   </div>
                  	   <div class="col-xs-6">    
	                   <form class="form-inline" action="${controller}" method="POST" name="vw-visit-details">               
	                   <c:choose>
	                   	<c:when test="${request.fldStatus eq 0 and request.noOfVisits eq 0 and request.finalStatus eq 0 and request.officeUserId eq fjtuser.emp_code and USRTYP eq 'OU'}">
		                   		<button class="btn  btn-xs btn-danger"  onclick="if (!(confirm('Are You sure You Want to delete this Service Request!'))) return false"><i class="fa fa-remove"></i></button>
		                   		<input type="hidden" value="${request.id}" name="rqid" />
		                   		<input type="hidden" value="${USRTYP}" name="usrTyp" />
								<input type="hidden" name="action" value="rmvSr" /> 
	                   	</c:when>
	                    <c:when test="${request.fldStatus eq 1 and request.noOfVisits ge 1 and request.officeUserId eq fjtuser.emp_code and USRTYP eq 'OU' and request.finalStatus ne 1}">
	                    		<input type="hidden" value="${request.id}" name="rqid" />
	                    		<input type="hidden" value="${USRTYP}" name="usrTyp" />
								<input type="hidden" name="action" value="oupdate" /> 
	                    		<button class="btn btn-xs btn-success"><i class="fa fa-edit"></i></button>
	                    </c:when>
	                   	<c:otherwise>                  	        		  
						</c:otherwise>							 
	                   </c:choose> 
	                   </form>
	                   </div>              
                   </div>
                  </td>      
                </tr>
               </c:forEach>      
              </tbody></table>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div> 
        <div class="col-xs-12">${MSG}</div>
      </div>
	  <%-- TABULAR DETAILS END --%>
	  	  
	     <div class="modal fade" id="modal-officestaff" data-backdrop="static" data-keyboard="false">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  	<span aria-hidden="true">&times;</span></button>
                	<h4 class="modal-title">New Service Request</h4>
              </div>
              <div class="modal-body">
                <form id="newServiceRequest" name="newServiceRequest">
                <div class="box-body"> 
                <div class="row"
>					<div class="form-group col-xs-12 tpm"> 
								<select class="form-control form-control-sm" id="prjctTyp" name="prjctTyp" required>
								  <option value="0">Select Project Type</option> 
								  <option value="1">ORION Project</option> 
								  <option value="2">New Project</option> 
								</select>
					</div>
				</div>
                <div class="" >	               	
	                 <div class="form-group">
	                 <div  id="ornPjctBx">
			            <label>SO Code-Number:</label> 
	                 	<div class="input-group">                
			                  <input type="text" class="form-control" id="prjctCode" data-inputmask="'alias': 'SOCODE-No. Reference'" data-mask autocomplete="off" required>
			                  <div class="input-group-addon" onClick="getProjectReference();">
		                      	<i class="fa fa-search"></i>
		                  	  </div> 
	                   </div> 
	                </div>         
	                </div>
	                <div class="prjctDetails" id="prjctDetails"></div>
	                <div class="row" id="newPrjctDetails">  
						<div class="col-xs-6">     
							<div class="input-group">   
								<label>Enter Project Name:</label>        
			                	<input type="text" class="form-control" id="newPname"   autocomplete="off"  /> 
			           	 	</div>
						</div> 
						<div class="col-xs-6">     
							<div class="input-group"> 
								<label>Enter Customer</label>          
			                	<input type="text" class="form-control" id="newPcustomer"   autocomplete="off"  /> 
			           	 	</div>
						</div> 
						<div class="col-xs-6">     
							<div class="input-group"> 
								<label>Enter Consultant</label>          
			                	<input type="text" class="form-control" id="newPconsult" autocomplete="off"  /> 
			            	</div>
						</div> 
	                </div>	                
		                  <input type="hidden" name="_data_pcode" id="_data_pcode" />   
		                  <input type="hidden" name="_data_pname" id="_data_pname" />  
		                  <input type="hidden" name="_data_pcust" id="_data_pcust" />  
		                  <input type="hidden" name="_data_pconsult" id="_data_pconsult" />  
		                  <input type="hidden" name="action" id="action" />  
		                  <input type="hidden" name="usrTyp" id="usrTyp" />  
		                  <input type="hidden" name="userDiv" id="userDiv" />  
	                <div id="action_alert" title="Action"></div>
              	</div>
              		<div class="row tpm">  
              			<div class="form-group col-xs-6"> 
							<select class="form-control form-control-sm" id="serviceRgion" name="serviceRgion" required>
							  <option value="">Select Region</option>
							    <c:forEach var="rgns"  items="${RGNS}" >
							    	<option value="${rgns.region}">${rgns.region}</option>
							    </c:forEach>
							</select>
					    </div> 
						<div class="col-xs-6">     
							<div class="input-group">          
			                <input type="text" class="form-control" id="location" name="location" autocomplete="off" required />
			                <span class="input-group-addon"><i class="fa fa-map-marker"></i></span>
			            </div>
						</div>  
					</div>
					<div class="row"> 
						<div class="form-group col-sm-6 tpm"> 
							<select class="form-control form-control-sm" id="flduser" name="flduser" required>
							  <option value="">Select Field User</option>
							    <c:forEach var="fieldUsers"  items="${FLDUSRS}" >
							    	<option value="${fieldUsers.employee_id}">${fieldUsers.empName}</option>
							    </c:forEach>
							</select>
					</div> 
					<div class="form-group col-xs-6 tpm"> 
							<select class="form-control form-control-sm" id="serviceTyp" name="serviceTyp" required>
							  <option value="">Select Service Type</option>
							    <c:forEach var="visit"  items="${VTYPES}" >
							    	<option value="${visit.visitType}">${visit.visitType}</option>
							    </c:forEach>
							</select>
					</div> 
					</div>  
					<div class="row"> 
						<div class="form-group col-xs-12 tpm">
				             <label>Remarks</label>
				             <textarea class="form-control" rows="2" placeholder="Enter Remarks..."  name="remarks" id="remarks" style="width:100%" required></textarea>
               			</div>  
					</div> 
					<div class="row"> 
					<h4 class="cost-div">Estimated Cost for Service (AED)</h4> 
				    <div class="form-group col-xs-3 tpm"> 
							<label>Material</label>
			      			<input type="number" class="form-control floatNumberField" id="materialCost" step=".01"  min="0" name="materialCost" value="0" style="width:100px" required>	
					</div> 
					<div class="form-group col-xs-3  tpm"> 
							<label>Labor</label>
			      			<input type="number" class="form-control floatNumberField" id="laborCost" step=".01"  min="0" name="laborCost" value="0"  style="width:100px" required>
					</div>
					<div class="form-group col-xs-3 tpm"> 
							<label>Others</label>
			      			<input type="number" class="form-control floatNumberField" id="otherCost" step=".01"  min="0" name="otherCost" value="0"  style="width:100px" required>
					 </div>
					</div> 
					<div class="row"> 
						<div class="form-group col-sm-12 tpm">
				            <span class="small pull-left" id="err-msg"></span>	
				        </div>
				   </div> 
					</div>  					
					<div class="row srvc-form-footer">
		              	<div class="col-xs-12">
			                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
			                <button type="button" class="btn btn-primary pull-right" id="sbmtRqst" onClick="submitRequest()">Submit Service Request</button>
		                </div>
		                <div id="laoding_prjct" class="loader" ><img src="././resources/images/wait.gif"></div>
		             </div>				
					</form> 				
               <!-- /.modal body -->              
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog --> 
        </div>
        <!-- /.modal -->	            
        	<div class="row">
					<div class="modal fade" id="fldVstAsstntDtls" role="dialog" >
					
					        <div class="modal-dialog" style="width:max-content;">
					     		<!-- Modal content-->
							      	<div class="modal-content">
								        	<div class="modal-header">
								         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
								          		<h4 class="modal-title">Complete Service Visit Details </h4>
								        	</div>
								        	<div class="modal-body"> </div>
									        <div class="modal-footer">
									          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									        </div>
								     </div>
								     
								     
						   	 </div>   	 		   	 
		 			</div>	  
				</div>	     
	    </section>
	     <div class="row">
	     <div class="col-md-12 col-sm-12">
	      <div id="laoding" class="loader" ><img src="././resources/images/wait.gif"></div>
	     </div> 
	     </div>
    	<%--Field Staff Entry Section End--%>   
    <!-- /.content -->
   </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <div class="pull-right hidden-xs">
      <b>Version</b> 1.0.0
    </div>
    <strong>Copyright &copy; 1988-${CURR_YR} <a href="http://www.faisaljassim.ae">FJ-Group</a>.</strong> All rights reserved.
  </footer> 
</div>
<script src="././resources/bower_components/select2/dist/js/select2.full.min.js"></script>
<script src="././resources/bower_components/fastclick/lib/fastclick.js"></script>
<script src="././resources/dist/js/adminlte.min.js"></script>
<script src="././resources/bower_components/jquery-knob/js/jquery.knob.js"></script>
<!-- page script start -->
<script>
var _usrTyp = '${USRTYP}'; 
var _url = 'ServiceController';
var _method = "POST";
var title = 'Service Request List From';
var defStartDate = '${filters.startDate}';
var defEndtDate = '${filters.toDate}';
var p1Typ = 'ORION Project';
var p2Typ = 'New Project';
var pMainTyp = 0 ;
$(function(){  
	 $('.loader, #ornPjctBx, #newPrjctDetails').hide();    	 
	 $("#fromdate").datepicker({ "dateFormat" : "dd/mm/yy", yearRange: "2020:2030", maxDate : 0});
	 $("#todate").datepicker({"dateFormat" : "dd/mm/yy",maxDate : 0 }); 
	 $('#displayRqsts').DataTable({   dom: 'Bfrtip', "paging":   true,
		  //stateSave: true,	  
		   "ordering": false, "info":true, "searching": true,  "pageLength": 10,	    
	   columnDefs:[{targets:[2, 8, 15, 19 ],className:"remove"},
	   {targets:[0, 1, 3, 4, 5, 6, 7, 9, 10, 11, 12, 13, 15, 16, 17],className:"truncate"}], 
	   buttons: [{ extend: 'excelHtml5', text:      '<i class="fa fa-file-excel-o" style="color: #009688; font-size: 1.5em;">Export</i>', filename: title+' '+defStartDate+' to '+defEndtDate+'',
	   title: title+' '+defStartDate+' to '+defEndtDate+'', messageTop: 'The information in this file is copyright to Faisal Jassim Group.', exportOptions: { columns: ':not(:last-child)', }}]
	 } );  
	 $( "#prjctTyp" ).change(function() {
			  showProjectTypeBox();
	 }); 
});
function submitRequest(){
	 $('#err-msg').html('');
	 setNewProjectReferences();
	 	if(pMainTyp == 0){
	 		$('#err-msg').html('Please select correct project type');
	    	document.getElementById("prjctTyp").focus();
	    	return false;
	 	}else if(!validateProjectReferences()){
	    	$('#err-msg').html('Please enter a valid "SOCODE-Number" format & get details from ORION');
	    	document.getElementById("prjctCode").focus();
	    	return false;
	    }else if(!validateServiceRegion()){
	    	$('#err-msg').html('Please select Service Region.');
	    	document.getElementById("serviceRgion").focus();
	    	return false;
	    }else if(!validateLocation()){
	    	$('#err-msg').html('Please enter location details.');
	    	document.getElementById("location").focus();
	    	return false;
	    }else if(!validateFieldUser()){
	    	$('#err-msg').html('Please select Main Field Staff.');
	    	document.getElementById("flduser").focus();
	    	return false;
	    }else if(!validateServiceType()){
	    	$('#err-msg').html('Please select Service Type.');
	    	document.getElementById("serviceTyp").focus();
	    	return false;
	    }else if($('#remarks').val().length < 10){
	    	$('#err-msg').html('Please enter Remarks (Atleast 10 character).');
	    	document.getElementById("remarks").focus();
	    	return false;
	    }else if($('#remarks').val().length > 200){
	    	$('#err-msg').html('Remarks : Maximum 200 Character.');
	    	document.getElementById("remarks").focus();
	    	return false;
	    }else if(!validateCosting()){		    	
	    	$('#err-msg').html('Please enter correct costings.'); 
	    	return false;
	    }else{
	    	$('#err-msg').html(''); 
	    	   document.forms["newServiceRequest"]["usrTyp"].value = _usrTyp; 
			   document.forms["newServiceRequest"]["action"].value = "newSR"; 
			   document.forms["newServiceRequest"].method = _method; 
			 if ((confirm('Are You sure, You Want to submit this service request!'))) { 
				 $('#laoding_prjct').show();
	  			document.getElementById("newServiceRequest").submit(); 
	  			 return true;
	  			 }
	  		 else{return false;} 	    	
	    }
}
function setNewProjectReferences(){
	if(pMainTyp == 2){
		var poCode = "SOPP-GENERAL";    
		var prjctName = $('#newPname').val();
		var customer = $('#newPcustomer').val();
		var consultant = $('#newPconsult').val();
		setProjectFields(poCode,prjctName, customer, consultant);
	}	
}
function showProjectTypeBox(){
	 clearprojectRefDetails();
	 var d1 =  $('#prjctTyp').val();
	 var d2 =  $('#prjctTyp option:selected').text();
	 if(d1  == 1 && d2 == p1Typ){
		 $('#newPrjctDetails').hide();
		 $('#ornPjctBx').show();  
		 pMainTyp = 1;
	 }else if(d1  == 2 && d2 == p2Typ){
		 $('#ornPjctBx, #prjctDetails').hide(); 
		 $('#newPrjctDetails').show();
		 pMainTyp = 2;
	 }else{
		 pMainTyp = 0;
	 }
}

function validateFieldUser(){
	 var d1 =  $('#flduser').val();
	 return validateField(d1);
}
function validateServiceType(){
	 var d1 =  $('#serviceTyp').val();
	 return validateField(d1);
}
function validateProjectType(){
	 var d1 =  $('#prjctTyp').val();
	 return validateField(d1);
}
function validateLocation(){
	 var d1 =  $('#location').val();
	 return validateField(d1);
}
function validateServiceRegion(){
	 var d1 =  $('#serviceRgion').val();
	 return validateField(d1);
}
function validateProjectReferences(){
	if(pMainTyp == 1){
		 var d1 =  checkProjectValues($('#_data_pcode').val());
		 var d2 =  checkProjectValues($('#_data_pname').val());
		 var d3 =  checkProjectValues($('#_data_pcust').val());
		 var d4 =  checkProjectValues($('#_data_pconsult').val());
		 var status = (validateField(d1) && validateField(d2) && validateField(d3) && validateField(d4) )? true : false;
		 return status;
	}else{
		 return true;
	}

}
function validateCosting(){	  
	var materialCost = Number($('#materialCost').val());
	var laborCost = Number($('#laborCost').val());
	var otherCost = Number($('#otherCost').val());
	if(typeof(materialCost) != 'number'  || typeof(laborCost) != 'number' || typeof(otherCost) != 'number' ){
		return false;
	 }else{
		return true;
	 }
}
function validateField(val){
	return ($.trim(val) != null && $.trim(val) != '' && $.trim(val) != 'undefined')? true : false;	
}
function viewAssitantVisit(serviceId, projectCode, projectName, serviceTyp){
	_url ="ServiceReports";
	var output =  "<div  class='modal-h5' ><h5>Project Code: "+projectCode+"</h5>";
		output += "<h5>Project Name: "+projectName+"</h5>";
		output += "<h5>Service Type: "+serviceTyp+"</h5></div>";
		output += "<table class='table small' id='viewAssitanttable' >"+
		 		  "<thead style='backgrond:gray;'>"+
		 		  "<tr><th>Site Visitors</th><th>Visit Date</th><th>Check-In</th><th>Check-Out</th><th>Total Time (Hr)</th><th>Hourly Rate</th></tr>"
		 		  "</thead><tbody>"; 
	 $.ajax({
		 type: _method,
   	 url: _url, 
   	 data: {action: "viewFv",  vd0:serviceId },
    success: function(data) {  
   	 $('#loading').hide(); 
			 var j=0; 
			 for (var i in data) { j=j+1;  
				  var hrMnt = 60;  
					 var ttlHrs =(parseInt($.trim(data[i].ttim))/(hrMnt)).toFixed(2);
       	output+="<tr>"+ 
      			"<td>"+data[i].fldStaffName+"</input></td>"+"<td>"+$.trim(data[i].visitDate.substring(0, 10)).split("-").reverse().join("/")+"</input></td>"+ 
       	    	"<td>"+data[i].chkIn+"</td>"+ "<td>"+data[i].chkOut+"</td>"+ 
               "<td>"+ttlHrs+"</td>"+"<td>"+data[i].hourlyRate+"</td>"+
     			"</tr>"; 
			 } 
			 output+="</tbody></table></div>";
			 $("#fldVstAsstntDtls .modal-body").html(output);$("#fldVstAsstntDtls").modal("show");
    },error:function(data,status,er) {
   	 $('#loading').hide();
   	 alert("No data to display,Please refresh the page!."); }
  });
}
function getProjectReference(){ 
	$("#prjctDetails, #action_alert").css( { display:'none'});
	var soCodeNo = document.getElementById('prjctCode').value;
	if(soCodeNo.trim()  != '' && soCodeNo.trim() != null && soCodeNo.trim() != 'undefined'){	
		 $('#laoding_prjct').show();
		$.ajax({ type: _method, url: _url,
       	 data: {action: "prjctRef", cd1:soCodeNo },  dataType: "json",	 
       		 success: function(data) {      	
       			 var output="<div style='display:flex;'>"+
       			 "<table class='table small' id='pdata_table'>"+
	  			 "<tr><thead style='backgrond:gray;'>"+
		        "</tr></thead><tbody>";	  
	  			 var j=0; 
	  			 for (var i in data) { j=j+1; 	
	  			 if(j=1){
	  				setProjectFields(data[i].soCodeNo, data[i].projectName, data[i].customer, data[i].consultant);
		        	output+="<tr>"+
               			"<th style='width:30%'>Project Code:</th>"+
	           			"<td>"+data[i].soCodeNo+"</input></td>"+
	          			"</tr>"+
	          			"<tr>"+
	            		"<th>Project Name :</th>"+
	            	    "<td>"+checkProjectValues(data[i].projectName)+"</input></td>"+
	          		    "</tr>"+
		                "<tr>"+
		                "<th>Customer:</th>"+
		                "<td>"+checkProjectValues(data[i].customer)+"</input></td>"+
	          			"</tr>"+
	          			"<tr>"+
	            		"<th>Consultant:</th>"+
	            		"<td>"+checkProjectValues(data[i].consultant)+"</input></td>"+
	          			"</tr>";
	  			 }
	  			 } 
	  			 output+="</tbody></table></div>";        				  				  			 
	  			 if(j > 0 ){ 
	  				 $('#action_alert').html("");
	  				 $("#laoding_prjct").hide();
	  				 $('#prjctDetails').css('display','block');
	  				 $('#prjctDetails').fadeTo('slow',1);
	  				 $("#prjctDetails").html(output); 
	  				$('#err-msg').html('');
	       		}else{
	       			$("#laoding_prjct").hide();
	       			$('#action_alert').html("<b style='color:red;'>No result found for SO Code-No.  "+soCodeNo+"</b>");
	       			clearprojectRefDetails();
	       			$("#action_alert").css( { display:'block'}); 
	       			}
	  },
	  error:function(data,status,er) {	        		
	    console.log("NO Details");
	   }
	 });
  } else{
	  $('#action_alert').css('display','block');
	  $("#action_alert").html("<b style='color:red;'>Please enter a project code</b>");
	  }	
}
function checkProjectValues(val){
	return ($.trim(val) === 'undefined' || $.trim(val) == null || $.trim(val) == '') ? '-':$.trim(val);	
}
function setProjectFields(pCode, pName, customer, consultant ){	
	//console.log(pCode +" "+pName+" "+customer+" "+consultant);
	document.forms["newServiceRequest"]["_data_pcode"].value = checkProjectValues(pCode);
	document.forms["newServiceRequest"]["_data_pname"].value = checkProjectValues(pName);
	document.forms["newServiceRequest"]["_data_pcust"].value = checkProjectValues(customer);
	document.forms["newServiceRequest"]["_data_pconsult"].value = checkProjectValues(consultant);
}
function preLoader(){ $('#loading').show();}	
function clearFields(){ 
	document.getElementById("newServiceRequest").reset();
	$('#err-msg').html('');
	$("#prjctDetails, #action_alert, #laoding_prjct").css( { display:'none'});
	clearFormFieldValues();
	clearprojectRefDetails();
	}	
function clearFormFieldValues(){ 
	  document.forms["newServiceRequest"]["prjctCode"].value = "";
      document.forms["newServiceRequest"]["location"].value = "";
      document.forms["newServiceRequest"]["remarks"].value = "";
      document.forms["newServiceRequest"]["serviceRgion"].selectedIndex = 0;
      document.forms["newServiceRequest"]["flduser"].selectedIndex = 0;
      document.forms["newServiceRequest"]["serviceTyp"].selectedIndex = 0;
	  document.forms["newServiceRequest"]["materialCost"].value = 0;
	  document.forms["newServiceRequest"]["laborCost"].value = 0; 
	  document.forms["newServiceRequest"]["otherCost"].value = 0; 	
}
function clearprojectRefDetails(){
	  document.forms["newServiceRequest"]["_data_pcode"].value = "";
	  document.forms["newServiceRequest"]["_data_pname"].value = "";
	  document.forms["newServiceRequest"]["_data_pcust"].value = "";
	  document.forms["newServiceRequest"]["_data_pconsult"].value = "";
}
function validateStatus(){
	 var value = $('#wrkngStatus').val(); 
	 return (value == null || value == '' || value === 'undefined')? true : false;
} 
</script>
<!-- page Script  end -->
</c:when>
<c:otherwise>
        <body onload="window.top.location.href='logout.jsp'"> </body>
</c:otherwise>
</c:choose>
</html>