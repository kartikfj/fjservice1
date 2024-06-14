<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="mainview.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%
  DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
  Calendar cal = Calendar.getInstance();
  int month = cal.get(Calendar.MONTH)+1;  
  int iYear = cal.get(Calendar.YEAR);  
  int week = cal.get(Calendar.WEEK_OF_YEAR);
  String currCalDtTime = dateFormat.format(cal.getTime());
  request.setAttribute("CURR_YR",iYear);
  request.setAttribute("MTH",month);
  request.setAttribute("currCal", currCalDtTime);
  request.setAttribute("currWeek", week);
  
  
   java.util.Date start_dt = ((beans.CompParam) request.getSession().getAttribute("cmp_param")).getCurrentProcMonthStartDate();
  Calendar cal1 = Calendar.getInstance();
  cal.setTime(start_dt);
  int mon = cal1.get(Calendar.MONTH);
  int day = cal1.get(Calendar.DAY_OF_MONTH);
  int year = cal1.get(Calendar.YEAR);



  
 %>
 <c:set var="syrtemp" value="${selected_Year}" scope="page" />
<!DOCTYPE html>
<html><head>
  <!-- Font Awesome -->
  <link rel="stylesheet" href="resources/bower_components/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="resources/dist/css/AdminLTE.min.css">
<link rel="stylesheet" href="resources/dist/css/skins/_all-skins.min.css">
<link rel="stylesheet" type="text/css" href="resources/datatables/datatables-fjtco/css/jquery.dataTables.min.css" />
<link rel="stylesheet" type="text/css" href="resources/datatables/buttons-fjtco/css/buttons.dataTables.min.css" />
<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/dataTables.buttons.min.js"></script>
<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.flash.min.js"></script>
<script type="text/javascript" src="resources/datatables/ajax/excelmake/jszip.min.js"></script>
<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.html5.min.js"></script>
<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.print.min.js"></script>
          
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<style>
.nav-tabs-custom>.nav-tabs>li.active { border-top: 2px solid #065685 !important;}
 svg:first-child > g > text[text-anchor~=middle]{ font-size: 18px;font-weight: bold; fill: #337ab7;}
.requestWindow{display:none;padding:5px;border-radius:5px;border: rgb(121, 85, 72); 1px solid; border-radius:3px;font-size:0.8em; font-family:Arial, Helvetica, sans-serif; padding: 1em;width:20em;height:auto;background: rgb(121, 85, 72);}
.reasonheading{color:#ffffff;}.reasonbox{display:none; }
.holdrequestWindow{display:none;padding:5px;border-radius:5px;border: rgb(121, 85, 72); 1px solid; border-radius:3px;font-size:0.8em; font-family:Arial, Helvetica, sans-serif; padding: 1em;width:20em;height:auto;background: rgb(121, 85, 72);}
.holdreasonheading{color:#ffffff;}.holdreasonbox{display:none; }
.stg3requestWindow{display:none;padding:5px;border-radius:5px;border: rgb(121, 85, 72); 1px solid; border-radius:3px;font-size:0.8em; font-family:Arial, Helvetica, sans-serif; padding: 1em;width:20em;height:auto;background: rgb(121, 85, 72);}
.stg3reasonheading{color:#ffffff;}.stg3reasonbox{display:none; }
.poUpdaterequestWindow{display:none;padding:5px;border-radius:5px;border: rgb(121, 85, 72); 1px solid; border-radius:3px;font-size:0.8em; font-family:Arial, Helvetica, sans-serif; padding: 1em;width:20em;height:auto;background: rgb(121, 85, 72);}
.poUpdatereasonheading{color:#ffffff;}.poUpdatereasonbox{display:none; }
.invUpdaterequestWindow{display:none;padding:5px;border-radius:5px;border: rgb(121, 85, 72); 1px solid; border-radius:3px;font-size:0.8em; font-family:Arial, Helvetica, sans-serif; padding: 1em;width:20em;height:auto;background: rgb(121, 85, 72);}
.invUpdatereasonheading{color:#ffffff;}.invUpdatereasonbox{display:none; }
.navbar { margin-bottom: 8px !important;} 
.table{display: block !important; overflow-x:auto !important;}
.small-box h3 {font-size: 25px !important;}
.container { padding-right: 0px !important;padding-left: 0px !important;}
.wrapper{margin-top:-8px;}.text-danger {font-weight: bold; }
.main-header {z-index: 851 !important;}td.truncate {max-width:100px; /*white-space: nowrap;*/overflow: hidden;text-overflow: ellipsis;} #qtnLostTbl{color:#000000 !important;}
.label-text{color:#fff !important;}
.remove {display:none;} 
@media ( max-width : 375px) {.modal-title{font-size: 95%;}}
@media ( max-width : 450px) {}
@media ( max-width : 400px) {}
@media ( max-width : 700px) {}
@media (min-width: 1200px){}
@-moz-document url-prefix() {}
</style>
<%@page import="com.google.gson.Gson"%>	 
<c:set var="sales_egr_code" value="0" scope="page" /> 
</head>
<c:choose>
 	<c:when test="${!empty fjtuser.emp_code and !empty fjtuser.sales_code  and fjtuser.checkValidSession eq 1}">
 	<c:set var="sales_egr_code" value="${fjtuser.sales_code}" scope="page" /> 
 	<body class="hold-transition skin-blue sidebar-mini">
 	 	<div class="container">
 	 	<div class="wrapper">
	  	<header class="main-header" style="background-color: #367fa9;">
		    <!-- Logo -->
		    <a href="#" class="logo">
			    <!-- mini logo for sidebar mini 50x50 pixels -->
			    <span class="logo-mini"><b>FJ</b>D</span>
			    <!-- logo for regular state and mobile devices -->
			    <span class="logo-lg"><b>Dashboard</b></span>
		    </a>
		    <!-- Header Navbar: style can be found in header.less -->
		    <nav class="navbar navbar-static-top">
		      <!-- Sidebar toggle button-->
		      <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		      </a>
		    </nav>
	  	</header>
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="main-sidebar">
		<!-- sidebar: style can be found in sidebar.less -->
		<section class="sidebar">
		<!-- sidebar menu: : style can be found in sidebar.less -->
		<ul class="sidebar-menu" data-widget="tree">  
        	 <c:choose>
             <c:when test="${fjtuser.role eq 'mg' and fjtuser.sales_code ne null}"> 
      		 		 <li><a href="SipBranchPerformance"><i class="fa fa-building-o"></i><span>Branch Performance</span></a></li> 
	                 <li><a href="DmInfo.jsp"><i class="fa fa-dashboard"></i><span>Sales Engineers Performance</span></a></li>
					 <li><a href="DisionInfo.jsp"><i class="fa fa-line-chart"></i><span>Sub Division Performance</span></a></li>
					 <li><a href="CompanyInfo.jsp?empcode=${DFLTDMCODE}"><i class="fa fa-pie-chart"></i><span>Division 	Performance</span></a></li>
					 <li><a href="SipUserActivity"><i class="fa fa-table"></i><span>SE Activity History</span></a></li>
<!-- 					 <li class="active"><a href="SipJihDues"><i class="fa fa-table"></i><span>JIH Dues</span></a></li>  -->
<!-- 					 <li><a href="SipLOIDues"><i class="fa fa-table"></i><span>LOI Dues</span></a></li> -->
					 <li><a href="SipStageFollowUpController"><i class="fa fa-database"></i><span>Stage Follow-Up</span></a></li>
					 <li><a href="sipWeeklyReport"><i class="fa fa-bar-chart"></i><span>Weekly-Sales Report</span></a></li>
					 <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>  
               </c:when>
               <c:when test="${!empty fjtuser.subordinatelist and fjtuser.sales_code ne null}">
                      <c:if test="${fjtuser.role eq 'gm'}">
			      		 <li><a href="SipBranchPerformance"><i class="fa fa-building-o"></i><span>Branch Performance</span></a></li>
			      	</c:if>
	                  <li><a href="DmInfo.jsp"><i class="fa fa-dashboard"></i><span>Sales Engineers Performance</span></a></li>
					  <li><a href="DisionInfo.jsp"><i class="fa fa-line-chart"></i><span>Sub Division Performance</span></a></li>
					  <li><a href="CompanyInfo.jsp"><i class="fa fa-pie-chart"></i><span>Division Performance</span></a></li>
					  <li><a href="SipUserActivity"><i class="fa fa-table"></i><span>SE Activity History</span></a></li>
<!-- 					  <li class="active"><a href="SipJihDues"><i class="fa fa-table"></i><span>JIH Dues</span></a></li> -->
<!-- 					  <li><a href="SipLOIDues"><i class="fa fa-table"></i><span>LOI Dues</span></a></li> -->
					  <li><a href="SipStageFollowUpController"><i class="fa fa-database"></i><span>Stage Follow-Up</span></a></li>   
					  <li><a href="sipWeeklyReport"><i class="fa fa-bar-chart"></i><span>Weekly-Sales Report</span></a></li>
					  <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>
               </c:when>
               <c:when test="${fjtuser.sales_code ne null and empty fjtuser.subordinatelist}">
	                <li><a href="DmInfo.jsp"><i class="fa fa-dashboard"></i><span>Sales Engineers Performance</span></a></li>	               
<!-- 	                <li class="active"><a href="SipJihDues"><i class="fa fa-table"></i><span>JIH Dues</span></a></li>  -->
<!-- 	                <li><a href="SipLOIDues"><i class="fa fa-table"></i><span>LOI Dues</span></a></li> -->
	                <li><a href="SipStageFollowUpController"><i class="fa fa-database"></i><span>Stage Follow-Up</span></a></li>  
<!-- 	                <li><a href="SalesManForecast"><i class="fa fa-table"></i><span>Salesman Forecast</span></a></li> -->
	                <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>
	                <%-- <li><a href="sipWeeklyReport"><i class="fa fa-bar-chart"></i><span>Weekly-Sales Report</span></a></li>  --%>
               </c:when>              
               <c:otherwise>				
               </c:otherwise>               
              </c:choose>                            
		</ul>
	    </section>
	    <!-- /.sidebar -->
	  	</aside>
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper" style="margin-top: -8px;">  
		<!-- Main content -->
		<section class="content">
		      <div class="row">
		        <div class="col-xs-12">
		          <div class="box">
		            <div class="box-header">
		              <h2 class="box-title text-danger font-weight-bold">List of JIH Quotations  Not Marked as Lost</h2>
		            </div>
		            <!-- /.box-header -->
		            <button class="btn btn-xs btn-danger" onClick="getExportData()"><i class="fa fa-file-excel-o"></i> Export</button>
		            <div class="box-body small">
		              
		              <table class="table table-bordered table-hover small" id="displayJIHDues">
		                <thead>
		                <tr>
		                  <th>S.Eng.</th>
		                  <th>Qtn. Date</th>
		                  <th>Qtn. Code</th>
		                  <th>Qtn. No.</th>
		                  <th>Exp.PO. Date</th>
		                  <th>Exp.Inv. Date</th>
		                  <th>Customer Code</th>
		                  <th>Customer Name</th>
		                  <th>Project Name</th>
		                  <th>Consultant</th>
		                  <th>Qtn. Amount</th>		                  	                  
		                  <th>Lost/Hold  Status</th>
		                  <th>Qtn.Status</th>	
		                </tr>
		                </thead>
		                <tbody>         
		                <c:forEach  var="dueList" items="${JIHDUES}"  >
		                <tr>                 
		                  <td>${dueList.slesCode}</td>
		                  <td>${dueList.qtnDate}</td>
		                  <td>${dueList.qtnCode}</td>
		                  <td>${dueList.qtnNo}</td>
		                  <td>${dueList.poDate}
		                   <c:if test="${fjtuser.role ne 'mg'}"> 
		                  	 <label style="color:blue;"> 
		                  			<input onClick="openRequestWindow(event, '${dueList.sys_id}','${dueList.qtnCode}','${dueList.qtnNo}', 'PO');" type="radio" name="poupdate"  id="po${dueList.sys_id}" /> &nbsp;Update
		                     </label> 
		                     </c:if>  
		                  </td>
		                  <td>${dueList.invoiceDate}
		                 	 <c:if test="${fjtuser.role ne 'mg'}"> 
			                  	<label style="color:blue;"> 
			                  			<input onClick="openRequestWindow(event, '${dueList.sys_id}','${dueList.qtnCode}','${dueList.qtnNo}', 'INV');" type="radio" name="invupdate"  id="inv${dueList.sys_id}" /> &nbsp;Update
			                     </label>  
		                      </c:if>  
		                  </td>
		                  <td>${dueList.custCode}</td>
		                  <td>${dueList.custName}</td>
		                  <td>${dueList.projectName}</td>
		                  <td id="consltname">${dueList.consultant}</td>
		                  <td align="right"><fmt:formatNumber pattern="#,###.##" value="${dueList.qtnAMount}"/></td>	                  
		                  <td> 
		                  		<label style="color:red;text-transform: uppercase;"> 
		                  			<input onClick="openRequestWindow(event, '${dueList.sys_id}','${dueList.qtnCode}','${dueList.qtnNo}','L');" type="radio" name="lostorhold"  id="${dueList.sys_id}" /> Lost
		                        </label> <br/>
		                        <c:if test="${dueList.qtnStatus ne 'H' }" >
		                        <label style="color:green;text-transform: uppercase;"> 
		                  			<input onClick="openRequestWindow(event, '${dueList.sys_id}','${dueList.qtnCode}','${dueList.qtnNo}', 'NL', '${dueList.qtnDate}');" type="radio" name="lostorhold"  id="nL${dueList.sys_id}" /> Hold<%--Not Lost --%>
		                        </label> 
		                       </c:if>   
		                       <label style="color:blue;text-transform: uppercase;"> 
		                  			<input onClick="openRequestWindow(event, '${dueList.sys_id}','${dueList.qtnCode}','${dueList.qtnNo}', 'stg3','${dueList.qtnDate}');" type="radio" name="lostorhold"  id="stg${dueList.sys_id}" /> Stage 3
		                        </label>         
		                  </td>
						  <td class="jihstatus"><span class="label label-primary"><span id="status${dueList.sys_id}">		                  
		                  <c:choose>
		                  	<c:when test="${dueList.qtnStatus eq 'H'}">Hold By SEg.</c:when>
		                  	<c:otherwise>${dueList.qtnStatus}</c:otherwise>
		                  </c:choose>
		                  </span></span></td>	
		                </tr>
		                </c:forEach>
		                </tbody>		                
		              </table>
		              <div id="exclData" style="display:none;"></div>
		            </div>
		            <!-- /.box-body -->
		          </div>
		          <!-- /.box -->
		          
		         </div>
		       </div>
	 		</section>	   	  	     
	        <%--Reason Div Start --%>
	        <div id="requestWindow" class="requestWindow"  >
	      		<img src="resources/images/Closebutton.png" style="float: right" onclick="closeRequestWindow('requestWindow','reasonbox','L');"/><br/>
	        	<div id="reasonheading" class="reasonheading"></div> 
	        	<div id="reasonbox" class="reasonbox">
	        	    <div class="form-group form-group-sm">
					     <label class="label-text">Reason:*</label>
					      <select class="form-control form-control-sm select2" style="width: 100%;" id="rtyp" name="rtyp" required>
					           <option value="">Select Reason</option>
					           <c:forEach var="typeList"  items="${RTYP}" >
				               <option value="${typeList.remarksType}" >${typeList.remarkTypeDesc}</option>
				               </c:forEach>
					     </select>
					 </div>
	        		<label class="label-text">Remarks:*</label> <textarea name="reason"rows="4" cols="50" id="thereason" maxlength="100" style="width:14em;height: 2em"></textarea>                   
	              	<br/><br/>
	           	  	<input type="button" class="sbt_btn3"  onclick="Apply(this,'thereason','rtyp','L');" name="actn" value="Apply"/>
	        	</div>                     
	       </div>
	       <%-- Reason Div End --%> 
	        <%--Hold Reason Div Start --%>
	        <div id="holdrequestWindow" class="holdrequestWindow"  >
	      		<img src="resources/images/Closebutton.png" style="float: right" onclick="closeRequestWindow('holdrequestWindow','holdreasonbox','NL');"/><br/>
	        	<div id="holdreasonheading" class="holdreasonheading"></div> 
	        	<div id="holdreasonbox" class="holdreasonbox">
	        	    <div class="form-group form-group-sm">
					     <label class="label-text">Reason:*</label>
					      <select class="form-control form-control-sm select2" style="width: 100%;" id="hrtyp" name="hrtyp" required>
					           <option value="">Select Reason</option>
					           <c:forEach var="typeList"  items="${HRTYP}" >
				               <option value="${typeList.remarksType}" >${typeList.remarkTypeDesc}</option>
				               </c:forEach>
					     </select>
					 </div>
	        		<label class="label-text">Remarks:*</label> <textarea name="reason"rows="4" cols="50" id="theholdreason" maxlength="100" style="width:14em;height: 2em"></textarea>                   
	              	<br/><br/>
	           	  	<input type="button" class="sbt_btn3"  onclick="Apply(this,'theholdreason','hrtyp','H');" name="actn" value="Apply"/>
	        	</div>                     
	       </div>
	       <%--Hold Reason Div End --%> 
	       <%-- start of move to Stage 3  --%>
	       <div id="stg3requestWindow" class="stg3requestWindow"  >
	      		<img src="resources/images/Closebutton.png" style="float: right" onclick="closeRequestWindow('stg3requestWindow','stg3reasonbox','STG3');"/><br/>
	        	<div id="stg3reasonheading" class="stg3reasonheading"></div> 
	        	<div id="stg3reasonbox" class="stg3reasonbox">
	        	    <div class="form-group form-group-sm">
					      <label class="label-text">LOI Date<span>*</span></label>
					    	 <input class="select_box2" style= "width:100%" readonly type="text" id="datepicker-13" name="loidate" value="${param.loidate}" autocomplete="off"/>
					 </div>	    
					 <label class="label-text">LOI Amount<span>*</span></label> <textarea name="reason"rows="4" cols="50" id="thestg3amt" maxlength="100" style="width:14em;height: 2em"></textarea>       		                   
	              	<br/><br/>	              
	              	<input type="hidden" name="qtnnDate" value="" id="qtnnDate" /> 
	           	  	<input type="button" class="sbt_btn3"  onclick="Apply(this,'thestg3amt','stg3rtyp','stg3');" name="actn" value="Apply"/>
	        	</div>                     
	       </div>
	       <%-- end of move to stage 3 --%>
	       
	        <%-- start of PO details update  --%>
	       <div id="poUpdaterequestWindow" class="poUpdaterequestWindow"  >
	      		<img src="resources/images/Closebutton.png" style="float: right" onclick="closeRequestWindow('poUpdaterequestWindow','poUpdatereasonbox','PO');"/><br/>
	        	<div id="poUpdatereasonheading" class="poUpdatereasonheading"></div> 
	        	<div id="poUpdatereasonbox" class="poUpdatereasonbox">
	        	    <div class="form-group form-group-sm">
					      <label class="label-text">PO Date<span>*</span></label>
					    	 <input class="select_box2" style= "width:100%" readonly type="text" id="datepicker-14" name="podate" value="${param.poDate}" autocomplete="off"/>
					 </div>                     
	              	<br/><br/>
	           	  	<input type="button" class="sbt_btn3"  onClick="updatePODetails(this,'updatePODate')" name="actn" value="Apply"/>
	        	</div>                     
	       </div>
	       <%-- end of PO details update --%>
	       <%-- start of Invoice details update  --%>
	       <div id="invUpdaterequestWindow" class="invUpdaterequestWindow"  >
	      		<img src="resources/images/Closebutton.png" style="float: right" onclick="closeRequestWindow('invUpdaterequestWindow','invUpdatereasonbox','INV');"/><br/>
	        	<div id="invUpdatereasonheading" class="invUpdatereasonheading"></div> 
	        	<div id="invUpdatereasonbox" class="invUpdatereasonbox">
	        	    <div class="form-group form-group-sm">
					      <label class="label-text">Invoice Date<span>*</span></label>
					    	 <input class="select_box2" style= "width:100%" readonly type="text" id="datepicker-15" name="invdate" value="${param.invoiceDate}" autocomplete="off"/>
					 </div>                     
	              	<br/><br/>
	           	  	<input type="button" class="sbt_btn3"  onClick="updateINVDetails(this,'updateINVDate')" name="actn" value="Apply"/>
	        	</div>                     
	       </div>
	       <%-- end of Invoice details update--%>
		</div>
  		<!-- /.content-wrapper -->
  	<footer class="main-footer">
    	<div class="pull-right hidden-xs">
      		<b>Version</b> 2.0.0
    	</div>
    	<strong>Copyright &copy;  1988 - ${CURR_YR} <a href="http://www.faisaljassim.ae/">Faisal Jassim Group</a>.</strong> All rights reserved.
   </footer>
   <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->
</div>
<!-- jQuery 3 -->
<!-- FastClick -->
<script src="resources/bower_components/fastclick/lib/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="resources/dist/js/adminlte.min.js"></script>
<script src="resources/js/date-eu.js"></script>
<!-- page script START -->
<script>
  var table, qtnId,qtnCode,qtnNo; 
  var exportTable = "<table class='table' id='exclexprtTble'><thead>";  
  $(function(){ 
		 $('.loader').hide();

		 $('#displayJIHDues').DataTable({  
		        'paging'      : true,
		        'lengthChange': false,
		        'searching'   : true,
		        'ordering'    : true,
		        'info'        : false,
		        "pageLength"  : 5,
		        "columnDefs"  :[{"targets": 1, "type":"date-eu"}, {targets:[6],className:"remove"}, {targets:[0,1,2,3,4,5,6,7,8,9,10],className:"truncate"}],
		        "order": [[ 1, "desc" ]],
		          responsive: true,
		    	  orderCellsTop: true,
		          fixedHeader: true, 
			        'autoWidth'   : false,
			        "buttons"     : [{  
	      	  			extend: 'excelHtml5', 
	      	  			text:'<i class="fa fa-file-excel-o" style="color: #1d4e6b; font-size: 1.5em;">Export</i>',
	  		      		filename: 'JIH Qtn - DUES DETAILS',
	  		      		title: 'JIH Qtn - DUES DETAIL', 
	  		      		messageTop: 'The information in this file is copyright to Faisal Jassim Group.', 
	  		     		exportOptions: { 
	  		     		 columns: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11],	  		     			
			  		          format: {
			  		            body: function ( data, row, column, node ) {
			  		            	if( column === 4 || column === 5){
			  		            		return data.substr(0,10);
			  		            	}else{
			  		                  return data;
			  		            	}
			  		            }
			  		          }
	  		     		}
     	  	          }] ,   
    
		 } );  
	});

  function openRequestWindow(event,  id, qtnCde, qtNo, type, qtanDate){
	  qtnId = id;  
	  qtnCode = qtnCde;
	  qtnNo = qtNo;	  
	  if(type === 'L'){    
			    var topDimn = ''+event.clientY-60+'px';
			    var msgbox = document.getElementById("requestWindow");
			    var reasonbox = document.getElementById("reasonbox");
			    if(msgbox ==null) return;
			    document.getElementById("thereason").value="";
			    var heading = document.getElementById("reasonheading");
			    heading.innerHTML="Submit Qtn. Lost Reason - "+qtnCode+"-"+qtnNo;
			    $("#requestWindow").css( {background:'#795548', opacity: 1,  display:'block', position:'absolute', top: topDimn, right:'6%'});	
			    $("#holdrequestWindow").css( {background:'#795548', opacity: 1,  display:'none', position:'absolute', top: topDimn, right:'6%'});	
			    $("#reasonbox").css( {display:'block'});	
			    $("#holdreasonbox").css( {display:'none'});	
			    $("#stg3reasonbox").css( {display:'none'});	
	  }else if(type === 'NL'){
			var qtnDate = qtanDate.split("/").reverse().join("-");
			var todaydate = new Date();
			var qtnDate1  = new Date(qtnDate);
			 qtnDate1.setMonth(qtnDate1.getMonth()+6);			
		    var todaydate2=new Date(todaydate.getFullYear(), todaydate.getMonth(), todaydate.getDate());		   
		    var qtnDate2 = new Date(qtnDate1.getFullYear(), qtnDate1.getMonth(), qtnDate1.getDate());
		    
			if(qtnDate2>todaydate2){
				document.getElementById("nL"+qtnId).checked = false;
				alert("You can't mark this as hold with in 6months from the Quotation Date");				
				return false;
			}			
		    var topDimn = ''+event.clientY-60+'px';
		    var msgbox = document.getElementById("holdrequestWindow");
		    var reasonbox = document.getElementById("holdreasonbox");
		    if(msgbox ==null) return;
		    document.getElementById("theholdreason").value="";
		    var heading = document.getElementById("holdreasonheading");
		    heading.innerHTML="Submit Qtn. Hold Reason - "+qtnCode+"-"+qtnNo;
		    $("#holdrequestWindow").css( {background:'#795548', opacity: 1,  display:'block', position:'absolute', top: topDimn, right:'6%'});	
		    $("#reasonbox").css( {display:'none'});	
		    $("#stg3reasonbox").css( {display:'none'});	
		    $("#holdreasonbox").css( {display:'block'});	
		    
		  //updateNotLostStatus(id, qtnCode, qtnNo, type);  
	  }else if(type === 'stg3'){		  
		    var topDimn = ''+event.clientY-60+'px';
		    var msgbox = document.getElementById("stg3requestWindow");
		    var reasonbox = document.getElementById("stg3reasonbox");
		    if(msgbox ==null) return;
		    document.getElementById("thestg3amt").value="";
		    document.getElementById("datepicker-13").value="";
		    document.getElementById("qtnnDate").value =  qtanDate;			
		    var heading = document.getElementById("stg3reasonheading");
		    heading.innerHTML="Move Qtn. to Stage 3 - "+qtnCode+"-"+qtnNo;
		    $("#stg3requestWindow").css( {background:'#795548', opacity: 1,  display:'block', position:'absolute', top: topDimn, right:'6%'});	
		    $("#reasonbox").css( {display:'none'});	
		    $("#holdreasonbox").css( {display:'none'});	
		    $("#stg3reasonbox").css( {display:'block'});	
		    
		  //updateNotLostStatus(id, qtnCode, qtnNo, type);  
	  }else if(type === 'PO'){			  
		    var topDimn = ''+event.clientY-100+'px';
		    var msgbox = document.getElementById("poUpdaterequestWindow");
		    var reasonbox = document.getElementById("poUpdatereasonbox");
		    if(msgbox ==null) return;		    
		    document.getElementById("datepicker-14").value="";
		    var heading = document.getElementById("poUpdatereasonheading");
		    heading.innerHTML="PO Update - "+qtnCode+"-"+qtnNo;
		    $("#poUpdaterequestWindow").css( {background:'#795548', opacity: 1,  display:'block', position:'absolute', top: topDimn, right:'30%'});
		    $("#poUpdatereasonbox").css( {display:'block'});	
		    
		  //updateNotLostStatus(id, qtnCode, qtnNo, type);  
	  }else if(type === 'INV'){			  
		    var topDimn = ''+event.clientY-100+'px';
		    var msgbox = document.getElementById("invUpdaterequestWindow");
		    var reasonbox = document.getElementById("invUpdatereasonbox");
		    if(msgbox ==null) return;		    
		    document.getElementById("datepicker-15").value="";
		    var heading = document.getElementById("invUpdatereasonheading");
		    heading.innerHTML="Invoice Update - "+qtnCode+"-"+qtnNo;
		    $("#invUpdaterequestWindow").css( {background:'#795548', opacity: 1,  display:'block', position:'absolute', top: topDimn, right:'50%'});
		    $("#invUpdatereasonbox").css( {display:'block'});	
		    
		  //updateNotLostStatus(id, qtnCode, qtnNo, type);  
	  }else{return;}
	}
  
  function checkUserSelectedCheckboxorNot(id){
	  if(id != '' && id != null && id != 'undefined') {
		  return true;
	   }else{
		   return false;
	   }	  
  } 
  
  function closeRequestWindow(requestWindow,reasonbox,type){
		    var msgbox = document.getElementById(requestWindow);
		    var reasonbox = document.getElementById(reasonbox);
		    var chqBox;
		  
		    if(type === 'L'){
		   		 chqBox = document.getElementById(qtnId);
		   		 if(chqBox != null){
				    	document.getElementById(qtnId).checked = false;
				    }	
		    }else if(type === 'NL'){
		    	chqBox = document.getElementById('nL'+qtnId);
		    	 if(chqBox != null && !chqBox.disabled){
				    	document.getElementById('nL'+qtnId).checked = false;
				    }	
		    }else if(type === 'STG3'){
		    	chqBox = document.getElementById('stg'+qtnId);
		    	 if(chqBox != null && !chqBox.disabled){
				    	document.getElementById('stg'+qtnId).checked = false;
				    }	
		    }else if(type === 'PO'){
		    	chqBox = document.getElementById('po'+qtnId);
		    	 if(chqBox != null && !chqBox.disabled){
				    	document.getElementById('po'+qtnId).checked = false;
				    }	
		    }else if(type === 'INV'){
		    	chqBox = document.getElementById('inv'+qtnId);
		    	 if(chqBox != null && !chqBox.disabled){
				    	document.getElementById('inv'+qtnId).checked = false;
				    }	
		    }
		   	    		    
		    reasonbox.style.display="none";
		    msgbox.style.display="none";
		    qtnId='';	      	    	    
	} 
  function updateLostStatus(reason, type,status){
	  // console.log(qtnId);
	  //if(confirm("Are you sure you want to mark this qtn. as Lost?")){	   	
		   	$.ajax({
		   		type: 'POST', 
		   		url: 'SipJihDues',
		   		data: {fjtco: "lost", qtn:qtnId, rsn: reason.trim(), rtyp:type.trim(),tstuas:status},
		   		dataType: "json",
		   		success: function(data) {	
		   		 var title,reasonData,reasonBox;
		   		 if(status === 'L'){
		   			title = document.getElementById("reasonheading");	
		   		 	reasonData = document.getElementById("thereason");
					reasonBox =  document.getElementById("reasonbox");
				 }else{
					 title = document.getElementById("holdreasonheading");
					 reasonData = document.getElementById("theholdreason");
					 reasonBox =  document.getElementById("holdreasonbox");
				 }
				 			
				// title.innerHTML="<strong>Proceesing, Please wait..</strong>";	
					 if(parseInt(data)=== 1){
						 if(status === 'L'){
							 reasonData.value="";
							 reasonBox.style.display ="none";
							 document.getElementById(qtnId).checked = true;
							 document.getElementById(qtnId).disabled = true;
							 document.getElementById("requestWindow").style.display ="none";
							 document.getElementById("status"+qtnId+"").parentElement.parentElement.innerHTML = "<span class='label label-danger bold'><span id='status"+qtnId+"'>Marked as Lost</span>";
							// qtnId='';
							 title.innerHTML="<strong>Completed!</strong>";					  
							 return true;	
						 }else{							 
							 var qtnnId = "nL"+qtnId;							
							 reasonData.value="";
							 reasonBox.style.display ="none";								
							 document.getElementById(qtnnId).checked = true;
							 document.getElementById(qtnnId).disabled = true;
							 document.getElementById("status"+qtnId+"").parentElement.parentElement.innerHTML = "<span class='label label-success bold'><span id='status"+qtnId+"'>Hold By SEG</span>";		
							 title.innerHTML="<strong>Completed!</strong>";		
							 return true;					 
							 }
						 
					 }else{		
						 if(status === 'L'){
							 document.getElementById(qtnId).checked = false;
							 reasonBox.style.display ="none";
							 document.getElementById("requestWindow").style.display ="none";
						 }else{
							 document.getElementById("nL"+qtnId).checked = false;
							 reasonBox.style.display ="none";
							 document.getElementById("holdrequestWindow").style.display ="none";
						 }
						 alert("Something went wrong. Please refresh the page and try again");
					 }
				
					
				},error:function(data,status,er) {
				alert("please click again");
				return false;
				}
			});
  }
  function updateStage3Status(loiDate,loiAmount){
	  // console.log(qtnId);
	//  var qtnId = "nL"+id;
	  var typeTxt = "H";
	  var title = document.getElementById("stg3reasonheading");	
	  var reasonBox = document.getElementById("stg3reasonbox");	  
	//  var chqBox = document.getElementById("nL"+id);
	 // var reasonTxt = "Hold By Sales Engineer to avoid auto lost";
	//  if(confirm("Are you sure you want to Hold this qtn. to avoid auto lost by system..?")){	   	
		   	$.ajax({
		   		type: 'POST', 
		   		url: 'SipJihDues',
		   		data: {fjtco: "updateStg3", qtn:qtnId, loidate: loiDate,loiamt:loiAmount},
		   		dataType: "json",
		   		success: function(data) {	 
								 
				 if(parseInt(data)=== 1){
					 var qtnnId = "stg"+qtnId;							
					// reasonData.value="";
					 reasonBox.style.display ="none";								
					 document.getElementById(qtnnId).checked = true;
					 document.getElementById(qtnnId).disabled = true;
					 document.getElementById("status"+qtnId+"").parentElement.parentElement.innerHTML = "<span class='label label-success bold'><span id='status"+qtnId+"'>Moved to Stage3</span>";		
					 title.innerHTML="<strong>Completed!</strong>";				  
					 return true;					 
				 }else{					
					 document.getElementById(qtnId).checked = false;
					 alert("Something went wrong. Please refresh the page and try again")
				 }
				},error:function(data,status,er) {
				alert("please click again"); 
				    if(chqBox != null && !chqBox.disabled){
				    	document.getElementById(qtnId).checked = false;
				    }	
				return false;
				}
			});
		   		   			   
		/*   return true;
		    }  else { 
				    if(chqBox != null && !chqBox.disabled){
				    	document.getElementById(qtnId).checked = false;
				    }	
		   }*/
	  
  }
  function updatePODetails(obj,loiAmount){alert(qtnCode+" , "+qtnNo);
	  var poDate= document.getElementById('datepicker-14').value;		
	  var title = document.getElementById("expodateheading");	
	  var reasonBox = document.getElementById("poUpdaterequestWindow");	  
	 // var qtnCode = document.getElementById("qtnCode").value;
	  //var qtnNo = document.getElementById("qtnNo").value;

		   	$.ajax({
		   		type: 'POST', 
		   		url: 'SipJihDues',
		   		data: {fjtco: "updatePODate", qtn:qtnId, podate: poDate},
		   		dataType: "json",
		   		success: function(data) {	 
								 
				 if(parseInt(data)=== 1){
					 reasonBox.style.display ="none";
					 document.getElementById("po"+qtnId+"").parentElement.parentElement.innerHTML = poDate+  "<label style='color:blue;'><input type='radio' name='poupdate' id='po"+qtnId+"' onClick='openRequestWindow(\"event\",\""+qtnId+"\", \""+qtnCode+"\",\""+qtnNo+"\",\"PO\")'>&nbsp;Update </label>";
					 return true;					 
				 }else{		
					 alert("Something went wrong. Please refresh the page and try again")
				 }
				},error:function(data,status,er) {
				alert("please click again"); 
				    if(chqBox != null && !chqBox.disabled){
				    	document.getElementById(qtnId).checked = false;
				    }	
				return false;
				}
			});
  
  }
  function updateINVDetails(obj,loiAmount){
	  var invDate= document.getElementById('datepicker-15').value;		
	  var title = document.getElementById("expodateheading");	
	  var reasonBox = document.getElementById("invUpdaterequestWindow");	  
	 // var qtnCode = document.getElementById("qtnCode").value;
	 // var qtnNo = document.getElementById("qtnNo").value;
		   	$.ajax({
		   		type: 'POST', 
		   		url: 'SipJihDues',
		   		data: {fjtco: "updateINVDate", qtn:qtnId, invdate: invDate},
		   		dataType: "json",
		   		success: function(data) {	 
								 
				 if(parseInt(data)=== 1){
					 reasonBox.style.display ="none";					 
					 document.getElementById("inv"+qtnId+"").parentElement.parentElement.innerHTML = invDate+  "<label style='color:blue;'><input type='radio' name='poupdate' id='inv"+qtnId+"' onClick='openRequestWindow(\"event\",\""+qtnId+"\", \""+qtnCode+"\",\""+qtnNo+"\",\"INV\")'>&nbsp;Update </label>";
					 return true;					 
				 }else{	
					 alert("Something went wrong. Please refresh the page and try again")
				 }
				},error:function(data,status,er) {
				alert("please click again"); 
				    if(chqBox != null && !chqBox.disabled){
				    	document.getElementById(qtnId).checked = false;
				    }	
				return false;
				}
			});
  
  }
  function Apply(button,thereason,rtyp,status){
	  
     var qtnDate= document.getElementById("qtnnDate").value;
     
		if(rtyp === 'stg3rtyp'){
			 var LOIdatefiled = document.getElementById('datepicker-13').value;
			 var stg3amt = document.getElementById('thestg3amt').value;
			 if( LOIdatefiled.trim().length < 1){
			    	alert("Please select LOI Date");    	
			        return false;
			    }else if(stg3amt.trim().length < 1){
			    	alert("Please enter LOI amount");
			    	return false;
			    }else if(LOIdatefiled <= qtnDate){
			    	alert("LOI Date should not be less than Quotation Date");
			    	return false;
			    }else{		    	
			    	 if(checkTextValidOrNot(stg3amt))	  
						 updateStage3Status(LOIdatefiled,stg3amt);
			    	}
		}else{
		   var reason = document.getElementById(thereason).value;
		   var type = document.getElementById(rtyp).value;
		    if( type.trim().length < 1){
		    	alert("Please select the reason..");    	
		        return false;
		    }else if(reason.trim().length < 1){
		    	alert("Please enter the remarks..");
		    }else{		    	
		    	updateLostStatus(reason, type,status);
		    	}	
		}
	}
  $(function () {

     	 $("#datepicker-13").datepicker({minDate: new Date(<%=year%>, <%=mon%>, -1, <%=day%>), maxDate: '+1Y', dateFormat: 'dd/mm/yy',  firstDay: 0});
	 	 $("#datepicker-14").datepicker({minDate: new Date(<%=year%>, <%=mon%>, -1, <%=day%>), maxDate: '+1Y', dateFormat: 'dd/mm/yy',  firstDay: 0});
	 	 $("#datepicker-15").datepicker({minDate: new Date(<%=year%>, <%=mon%>, -1, <%=day%>), maxDate: '+1Y', dateFormat: 'dd/mm/yy',  firstDay: 0});
 // $(".exFacDate").datepicker({ "dateFormat" : "dd/mm/yy", yearRange: "2019:2030", minDate : -7});

     });
  function checkTextValidOrNot(stg3aount){
		if(/^[0-9-]*$/.test(stg3aount) == false){
			alert("Please enter only numbers in LOI Amount ");
		    return false
		}else{
			return true;
		}
	}
  function getExportData(){		
			var output ="";
				 $.ajax({
					 type: 'POST', 
				   		url: 'SipJihDues',
				   		data: {fjtco: "export"},
				   		dataType: "json",
		         success: function(data) {
		        	
		        	 var output="<table id='exclexprtTble' class='table'><thead><tr>"+"<th>S.Eng.</th> <th >Qtn. Date</th><th >Qtn. Code</th><th>Qtn. No.</th> <th >Exp.PO. Date</th>"
		        	 		    +"<th >Exp.Inv. Date</th><th>Customer Code</th> <th >Customer Name</th><th >Project Name</th><th >Consultant</th><th>Qtn. Amount</th> <th >Qtn.Status</th>"
		        	 			+"</tr></thead><tbody>";
		        	 var j=0; 
		        	 for (var i in data) {
		        		 j=j+1;
		        	output+="<tr><td>" + $.trim(data[i].slesCode) + "</td>"+ "<td>" + $.trim( data[i].qtnDate ) + "</td>"+ "<td>" + $.trim( data[i].qtnCode) + "</td><td>" + $.trim( data[i].qtnNo) + "</td><td>" + $.trim( data[i].poDate) + "</td>"
		        	        + "<td>" + $.trim( data[i].invoiceDate ) + "</td>"+ "<td>" + $.trim( data[i].custCode) + "</td><td>" + $.trim( data[i].custName) + "</td>" 
		        	        + "<td>" + $.trim( data[i].projectName) + "</td><td>" + $.trim( data[i].consultant) + "</td><td>" + $.trim( data[i].qtnAMount) + "</td><td>" + $.trim( data[i].qtnStatus) + "</td>"
		        			+"</tr>"; 
		        	 }          	
		        	 output+="</tbody></table>";
		        	 $("#exclData").html(output); 
		             table = $('#exclexprtTble').DataTable({   
		               dom: 'Bfrtip',  
		      		   buttons: [{ extend: 'excelHtml5', text:      '<i class="fa fa-file-excel-o" style="color: #fff; font-size: 1.5em;">Download</i>', 
		      		   filename: 'JIH Qtn - DUES DETAILS',		  		      		
		      		   title: 'JIH Qtn - DUES DETAIL',  messageBottom: 'The information in this file is copyright to FJ-Group.'}]
		      		} ); 
		             table.button('.dt-button').trigger();
		         },error:function(data,status,er) { 
		        	 $('#laoding').hide();
		        	 alert("Please refresh the page!."); 
		        	 
		        	 }
		       });
			 	
	}
</script>
<!-- page script END -->
</body>
</c:when>
<c:otherwise>
        <body onload="window.top.location.href='logout.jsp'">                     
        </body>  
</c:otherwise>
</c:choose>
</html>