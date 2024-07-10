<%-- 
    Document   : SIP JIH DUES  
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="mainview.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.google.gson.Gson"%>
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
<link rel="stylesheet" href="resources/bower_components/select2/dist/css/select2.min.css">
<link href="resources/css/jquery-ui.css" rel="stylesheet">
<script type="text/javascript" src="resources/js/jquery-ui.js"></script>

<style>
.nav-tabs-custom>.nav-tabs>li.active { border-top: 2px solid #065685 !important;}
 svg:first-child > g > text[text-anchor~=middle]{ font-size: 18px;font-weight: bold; fill: #337ab7;}
.requestWindow{display:none;padding:5px;border-radius:5px;border: rgb(121, 85, 72) 1px solid; border-radius:3px;font-size:0.8em; font-family:Arial, Helvetica, sans-serif; padding: 1em;width:20em;height:auto;background: rgb(121, 85, 72);}
.lostWindow{display:none;padding:5px;border-radius:5px;border: rgb(121, 85, 72) 1px solid; border-radius:3px;font-size:0.8em; font-family:Arial, Helvetica, sans-serif; padding: 1em;width:20em;height:auto;background: rgb(121, 85, 72);}
.reasonheading{color:#ffffff;}.reasonbox{display:none; }
.lostreasonheading{color:#ffffff;}.lostreasonbox{display:none; }
.holdrequestWindow,.stage1requestWindow,.submittalstatusrequestWindow{display:none;padding:5px;border-radius:5px;border: rgb(121, 85, 72); 1px solid; border-radius:3px;font-size:0.8em; font-family:Arial, Helvetica, sans-serif; padding: 1em;width:20em;height:auto;background: rgb(121, 85, 72);}
.holdreasonheading,.stage1reasonheading,.submittalstatusreasonheading{color:#ffffff;}.holdreasonbox,.submittalstatusreasonbox{display:none; }
.poUpdaterequestWindow{display:none;padding:5px;border-radius:5px;border: rgb(121, 85, 72); 1px solid; border-radius:3px;font-size:0.8em; font-family:Arial, Helvetica, sans-serif; padding: 1em;width:20em;height:auto;background: rgb(121, 85, 72);}
.poUpdatereasonheading{color:#ffffff;}.poUpdatereasonbox{display:none; }
.expLOIDateUpdaterequestWindow,.sewinUpdaterequestWindow,.expOrderDateUpdaterequestWindow,.expBillingDateUpdaterequestWindow{display:none;padding:5px;border-radius:5px;border: rgb(121, 85, 72); 1px solid; border-radius:3px;font-size:0.8em; font-family:Arial, Helvetica, sans-serif; padding: 1em;width:20em;height:auto;background: rgb(121, 85, 72);}
.expLOIUpdatereasonheading,.sewinUpdatereasonheading,.expOrderDateUpdatereasonheading,.expBillingDateUpdatereasonheading{color:#ffffff;}.expLOIUpdatereasonbox,.sewinUpdatereasonbox,.expOrderDateUpdatereasonbox,.expBillingDateUpdatereasonbox{display:none; }
.invUpdaterequestWindow{display:none;padding:5px;border-radius:5px;border: rgb(121, 85, 72); 1px solid; border-radius:3px;font-size:0.8em; font-family:Arial, Helvetica, sans-serif; padding: 1em;width:20em;height:auto;background: rgb(121, 85, 72);}
.invUpdatereasonheading{color:#ffffff;}.invUpdatereasonbox{display:none; }
.navbar { margin-bottom: 8px !important;} 
.table{display: block !important; overflow-x: auto;table-layout: auto;}
.table1{overflow-x: auto;table-layout: auto;}
.small-box h3 {font-size: 25px !important;}
.container { padding-right: 0px !important;padding-left: 0px !important; width:100%}
.wrapper{margin-top:-8px;}.text-danger {font-weight: bold; }
.main-header {z-index: 851 !important;}td.truncate {max-width:100px; /*white-space: nowrap;*/overflow: hidden;text-overflow: ellipsis;} #qtnLostTbl{color:#000000 !important;}
.label-text{color:#fff !important;}
.remove {display:none;} 
#priority, #status,.filter{    width: 100px !important; border-radius: 5% !important;   height: 30px !important;  border-color: #aaaaaa;}
#stage{ width: 100% !important; border-radius: 5% !important;   height: 30px !important;  border-color: #aaaaaa;}
.fltr-slct{float:left;margin-right: 5px;margin-left: 10px;}
#stageSubmit{width:60px !important;margin-top: 20px;}
.select2-container--default .select2-selection--multiple .select2-selection__choice { font-size: 11px !important; background-color: #3c8dbc !important;  border-color: #367fa9 !important;   padding: 1px 5px !important;  color: #fff !important;}
.select2-container--default .select2-selection--multiple .select2-selection__choice__remove {  color: #ff5722 !important;}
table.dataTable tbody td {  padding: 4px 6px !important; font-size: 8.5px !important;  color: #040404d9 !important;}
.table-bordered>thead>tr>th, .table-bordered>tbody>tr>th, .table-bordered>tfoot>tr>th, .table-bordered>thead>tr>td, .table-bordered>tbody>tr>td, .table-bordered>tfoot>tr>td {border: 1px solid #0000009e !important;}
.table-bordered {  border: 1px solid #616161;}
table.dataTable thead th, table.dataTable thead td { padding: 6px 10px !important; border-bottom: 1px solid #616161 !important;}
#stage_detail_report_wrapper{float:right !important;}
.select2-container--default .select2-selection--multiple .select2-selection__rendered{max-height: 100px; overflow: scroll;}
.select2-container--default .select2-selection--multiple .select2-selection__rendered::-webkit-scrollbar {  width: 2px; height: 2px}
.select2-container--default .select2-selection--multiple .select2-selection__rendered::-webkit-scrollbar-button { background: #ccc}
.select2-container--default .select2-selection--multiple .select2-selection__rendered::-webkit-scrollbar-track-piece { background: #009688}
.select2-container--default .select2-selection--multiple .select2-selection__rendered::-webkit-scrollbar-thumb {background: #009688} 
@media ( max-width : 375px) {.modal-title{font-size: 95%;}}
@media ( max-width : 450px) {}
@media ( max-width : 400px) {}
@media ( max-width : 700px) {}
@media (min-width: 1200px){}
@-moz-document url-prefix() {}
* Responsive styles */
@media screen and (max-width: 768px) {
    .table th,
    .table td {
        display: block; /* Stack table cells vertically on smaller screens */
        text-align: left; /* Align text to the left */
    }

    .table th {
        text-align: center; /* Center align table headers */
    }
}
div.dt-buttons{
 margin-left: 25px;
}
#cvDetails_tbl thead th, #cvDetails_tbl tbody td{border: 1px solid #03a9f4 !important;padding: 7px; text-align: left;}
.stg3requestWindow{display:none;padding:5px;border-radius:5px;border: rgb(121, 85, 72); 1px solid; border-radius:3px;font-size:0.8em; font-family:Arial, Helvetica, sans-serif; padding: 1em;width:20em;height:auto;background: rgb(121, 85, 72);}
.stg3reasonheading{color:#ffffff;}.stg3reasonbox{display:none; }

</style>
<c:set var="sales_egr_code" value="0" scope="page" /> 
</head>
<c:choose>
 	<c:when test="${!empty fjtuser.emp_code and !empty fjtuser.sales_code  and fjtuser.checkValidSession eq 1}">
 	<c:set var="sales_egr_code" value="${fjtuser.sales_code}" scope="page" />
 	<c:set var="loggedEmp" value="${fjtuser.emp_code}" scope="page" /> 
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
      		 		 <li><a href="SalesManagerInfo.jsp"><i class="fa fa-building-o"></i><span>Sales Manager Performance</span></a></li>
	                 <li><a href="DmInfo.jsp"><i class="fa fa-dashboard"></i><span>Sales Engineers Performance</span></a></li>
					 <li><a href="DisionInfo.jsp"><i class="fa fa-line-chart"></i><span>Sub Division Performance</span></a></li>
					 <li><a href="CompanyInfo.jsp?empcode=${DFLTDMCODE}"><i class="fa fa-pie-chart"></i><span>Division 	Performance</span></a></li>
					 <li><a href="SipUserActivity"><i class="fa fa-table"></i><span>SE Activity History</span></a></li>
<!-- 					 <li><a href="SipJihDues"><i class="fa fa-table"></i><span>JIH Dues</span></a></li> -->
<!-- 					 <li><a href="SipLOIDues"><i class="fa fa-table"></i><span>LOI Dues</span></a></li>  -->
					  <li><a href="ProjectStatus"><i class="fa fa fa-bars"></i><span>Project Status</span></a></li> 
					 <li class="active"><a href="SipStageFollowUpController"><i class="fa fa-database"></i><span>Stage Follow-Up</span></a></li> 
					 <li><a href="sipWeeklyReport"><i class="fa fa-bar-chart"></i><span>Weekly-Sales Report</span></a></li>  
					 <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>
               </c:when>
               <c:when test="${!empty fjtuser.subordinatelist and fjtuser.sales_code ne null}">
                      <c:if test="${fjtuser.role eq 'gm'}">
			      		 <li><a href="SipBranchPerformance"><i class="fa fa-building-o"></i><span>Branch Performance</span></a></li>
			      	</c:if>
	                  <li><a href="DmInfo.jsp"><i class="fa fa-dashboard"></i><span>Sales Engineers Performance</span></a></li>
					  <li><a href="DisionInfo.jsp"><i class="fa fa-line-chart"></i><span>Sub Division Performance</span></a></li>
					  <li><a href="CompanyInfo.jsp"><i class="fa fa-pie-chart"></i><span>Division 	Performance</span></a></li>
					  <li><a href="SipUserActivity"><i class="fa fa-table"></i><span>SE Activity History</span></a></li>
<!-- 					  <li><a href="SipJihDues"><i class="fa fa-table"></i><span>JIH Dues</span></a></li> -->
<!-- 					  <li><a href="SipLOIDues"><i class="fa fa-table"></i><span>LOI Dues</span></a></li> -->
					  <li><a href="ProjectStatus"><i class="fa fa fa-bars"></i><span>Project Status</span></a></li> 
					  <li class="active"><a href="SipStageFollowUpController"><i class="fa fa-database"></i><span>Stage Follow-Up</span></a></li>   
					  <li><a href="sipWeeklyReport"><i class="fa fa-bar-chart"></i><span>Weekly-Sales Report</span></a></li>
					  <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>
               </c:when>
               <c:when test="${fjtuser.sales_code ne null and empty fjtuser.subordinatelist}">
	                <li><a href="sip.jsp"><i class="fa fa-dashboard"></i><span>Sales Engineers Performance</span></a></li>	               
<!-- 	                <li><a href="SipJihDues"><i class="fa fa-table"></i><span>JIH Dues</span></a></li>  -->
<!-- 	                <li><a href="SipLOIDues"><i class="fa fa-table"></i><span>LOI Dues</span></a></li>   -->
					 <li><a href="ProjectStatus"><i class="fa fa fa-bars"></i><span>Project Status</span></a></li> 
	                <li class="active"><a href="SipStageFollowUpController"><i class="fa fa-database"></i><span>Stage Follow-Up</span></a></li>
<!-- 	                <li><a href="SalesManForecast"><i class="fa fa-table"></i><span>Salesman Forecast</span></a></li> -->
						<li><a href="sipWeeklyReport"><i class="fa fa-bar-chart"></i><span>Weekly-Sales Report</span></a></li>
	                <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>
               </c:when>              
               <c:otherwise>				
               </c:otherwise>               
              </c:choose>                            
		</ul>
	    </section>
	    <!-- /.sidebar -->
	  	</aside>
		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper" style="margin-top: -8px;min-height:520px">  
		<!-- Main content -->
		<section class="content">
		      <div class="row" id="stageFilter">
		       <form id="stageFup">
		        <div class="col-md-12 col-xs-12">
		         	
			      <div class="form-group form-inline"> 
							<select class="form-control form-control-sm select2 small"  id="secode" style="width:80% !important;overflow: scroll;height: 80px !important;" multiple="multiple" data-placeholder="Select Sales Engineers By Clicking on this box" required>
							  <c:forEach var="s_engList"  items="${SEngLst}" >			
								 <option value="${s_engList.salesman_code}" ${s_engList.salesman_code  == selected_salesman_code ? 'selected':''}>${s_engList.salesman_name} -(${s_engList.salesman_code})</option>
							  </c:forEach>
							</select>
							<input type="checkbox" id="slctAllseg" >Select All
						</div>
				</div>
				<div class="col-xs-2" style="width:12%">
						<div class="form-group">
							<label style="font-size:80%">Stage</label>
							<select class="form-control form-control-sm" id="stage" style="font-size:11px" required>
							<option value="">Select</option>
							<option value="1">Stage-1</option>
							<option value="2">Stage-2</option>
							<option value="3">Stage-3</option>
							<option value="4">Stage-4</option>  
							</select>
						</div>
				</div>
				<div id="filters"> 
				 </div>
				 <div class="fltr-slct">
				 	<div class="form-group">
						 <button type="submit" id="stageSubmit" class="btn btn-primary form-control form-control-sm"  >Fetch</button>
					</div>
				 </div> 				 
				 </form>  
				 <div class="sb col-xs-4" style="float:none;">      
		             <div class="col-xs-12" id="totalCount" style="margin-left:500px;">		               
		              <p><b>Total Amount: <span id="s2CntDiv"> 0 </span> <br/> </b></p>
		            </div>
		          </div>
		      </div>
		     
		      <div class="row"> 
		         <div class="col-xs-12" id="stage_detail"> 
		         </div>
		       </div>
		         <%--Reason Div Start --%>
			        <div id="requestWindow" class="requestWindow"  >
			      		<img src="resources/images/Closebutton.png" style="float: right" onclick="closeRequestWindow();"/><br/>
			        	<div id="reasonheading" class="reasonheading"></div> 
			        	<div id="reasonbox" class="reasonbox">
			        	    <div class="form-group form-group-sm">
							     <label class="label-text">Status:</label>
							     <select  class="form-control form-control-sm" id="statusUpdt"></select>
							 </div>
							 <div class="form-group form-group-sm">
							     <label class="label-text">Priority:</label>
							     <select  class="form-control form-control-sm" id="priorityUpdt"></select>
							 </div>
			        		<label class="label-text">Remarks:</label> <textarea name="remarks" rows="4" cols="50" id="remarks" maxlength="200" style="width:18em;height: 6em"></textarea>                   
			              	<br/><br/>
			           	  	<input type="button" class="sbt_btn3"  onclick="Apply(event);" name="actn" value="Apply"/>
			        	</div>                     
			       </div>
			       <div id="requestWindowPriority" class="requestWindow">
    <img src="resources/images/Closebutton.png" style="float: right" onclick="closeRequestWindow('requestWindowPriority');" /><br/>
    <div id="reasonheading" class="reasonheading"></div> 
    <div id="reasonbox" class="reasonbox">
        <div class="form-group form-group-sm">
            <label class="label-text">Priority:</label>
            <select class="form-control form-control-sm" id="priorityUpdt"></select>
        </div>
        <br/><br/>
        <input type="button" class="sbt_btn3" onclick="updatePriority(event);" name="actn" value="Update Priority" />
    </div>
</div>
			       <%-- Reason Div End --%> 
			       <%--STAGE 4 Items Start --%>
			       		<div class="modal fade" id="s4_items_modal" role="dialog" >					
					        <div class="modal-dialog" style="width:max-content;max-width:75% !important;">
					     		<!-- Modal content-->
							      	<div class="modal-content">  
								        	<div class="modal-header">
								         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
								          		<h4 class="modal-title"> </h4>
								        	</div>
								        	<div class="modal-body small"></div>
									        <div class="modal-footer">  
									            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									        </div>
								     </div>									     								     
						   	 </div>   	 		   	 
		 			</div>
			       <%--STAGE 4 Items End --%>
			<%--Reason Div Start --%>
	        <div id="lostWindow" class="lostWindow"  >
	      		<img src="resources/images/Closebutton.png" style="float: right" onclick="closeLostHoldStg3RequestWindow('lostWindow','lostreasonbox','L');"/><br/>
	        	<div id="lostreasonheading" class="lostreasonheading"></div> 
	        	<div id="lostreasonbox" class="lostreasonbox">
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
	           	  	<input type="button" class="sbt_btn3"  onclick="Submit(this,'thereason','rtyp','L');" name="actn" value="Apply"/>
	           	  	<input type="hidden" id="segsalescode" value=""/>
	        	</div>                     
	       </div>
	       <%-- Reason Div End --%> 
	        <%-- start of move to Stage 3  --%>
	       <div id="stg3requestWindow" class="stg3requestWindow"  >
	      		<img src="resources/images/Closebutton.png" style="float: right" onclick="closeLostHoldStg3RequestWindow('stg3requestWindow','stg3reasonbox','STG3');"/><br/>
	        	<div id="stg3reasonheading" class="stg3reasonheading"></div> 
	        	<div id="stg3reasonbox" class="stg3reasonbox">
	        	    <div class="form-group form-group-sm">
					      <label class="label-text">LOI Date<span>*</span></label>
					    	 <input class="select_box2" style= "width:100%" readonly type="text" id="datepicker-13" name="loidate" value="${param.loidate}" autocomplete="off"/>
					 </div>	    
					 <label class="label-text">LOI Amount(AED)<span>*</span></label> <textarea name="reason"rows="4" cols="50" id="thestg3amt" maxlength="100" style="width:14em;height: 2em"></textarea>       		                   
	              	<br/><br/>	              
	              	<input type="hidden" name="qtnnDate" value="" id="qtnnDate" /> 
	           	  	<input type="button" class="sbt_btn3"  onclick="Submit(this,'thestg3amt','stg3rtyp','stg3');" name="actn" value="Apply"/>
	        	</div>                     
	       </div>
	       <%-- end of move to stage 3 --%>
	       <%--Hold Reason Div Start --%>
	        <div id="holdrequestWindow" class="holdrequestWindow"  >
	      		<img src="resources/images/Closebutton.png" style="float: right" onclick="closeLostHoldStg3RequestWindow('holdrequestWindow','holdreasonbox','NL');"/><br/>
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
	           	  	<input type="button" class="sbt_btn3"  onclick="Submit(this,'theholdreason','hrtyp','H');" name="actn" value="Apply"/>
	        	</div>                     
	       </div>
	       <%--Reason Div Start --%>
	        <div id="loilostWindow" class="lostWindow"  >
	      		<img src="resources/images/Closebutton.png" style="float: right" onclick="closeLostHoldStg3RequestWindow('loilostWindow','loilostreasonbox','L');"/><br/>
	        	<div id="loilostreasonheading" class="lostreasonheading"></div> 
	        	<div id="loilostreasonbox" class="lostreasonbox">
	        	    <div class="form-group form-group-sm">
					     <label class="label-text">Reason:*</label>
					      <select class="form-control form-control-sm select2" style="width: 100%;" id="loirtyp" name="loirtyp" required>
					           <option value="">Select Reason</option>
					           <c:forEach var="typeList"  items="${RTYP}" >
				               <option value="${typeList.remarksType}" >${typeList.remarkTypeDesc}</option>
				               </c:forEach>
					     </select>
					 </div>
	        		<label class="label-text">Remarks:*</label> <textarea name="reason"rows="4" cols="50" id="loithereason" maxlength="100" style="width:14em;height: 2em"></textarea>                   
	              	<br/><br/>
	           	  	<input type="button" class="sbt_btn3"  onclick="Submit2(this,'loithereason','loirtyp','L');" name="actn" value="Apply"/>
	           	  	<input type="hidden" id="segsalescode" value=""/>
	           	  	<input type="hidden" id="segsalesname" value=""/>
	           	  	<input type="hidden" id="showButton" value=""/>
	        	</div>                     
	       </div>
	       <%-- Reason Div End --%> 
	       <%--Hold Reason Div Start --%>
	        <div id="loiholdrequestWindow" class="holdrequestWindow"  >
	      		<img src="resources/images/Closebutton.png" style="float: right" onclick="closeLostHoldStg3RequestWindow('loiholdrequestWindow','loiholdreasonbox','NL');"/><br/>
	        	<div id="loiholdreasonheading" class="holdreasonheading"></div> 
	        	<div id="loiholdreasonbox" class="holdreasonbox">
	        	    <div class="form-group form-group-sm">
					     <label class="label-text">Reason:*</label>
					      <select class="form-control form-control-sm select2" style="width: 100%;" id="loihrtyp" name="loihrtyp" required>
					           <option value="">Select Reason</option>
					           <c:forEach var="typeList"  items="${HRTYP}" >
				               <option value="${typeList.remarksType}" >${typeList.remarkTypeDesc}</option>
				               </c:forEach>
					     </select>
					 </div>
	        		<label class="label-text">Remarks:*</label> <textarea name="reason"rows="4" cols="50" id="loitheholdreason" maxlength="100" style="width:14em;height: 2em"></textarea>                   
	              	<br/><br/>
	           	  	<input type="button" class="sbt_btn3"  onclick="Submit2(this,'loitheholdreason','loihrtyp','H');" name="actn" value="Apply"/>
	        	</div>                     
	       </div>
	       	        <%-- start of PO details update  --%>
	       <div id="poUpdaterequestWindow" class="poUpdaterequestWindow"  >
	      		<img src="resources/images/Closebutton.png" style="float: right" onclick="closeLostHoldStg3RequestWindow('poUpdaterequestWindow','poUpdatereasonbox','PO');"/><br/>
	        	<div id="poUpdatereasonheading" class="poUpdatereasonheading"></div> 
	        	<div id="poUpdatereasonbox" class="poUpdatereasonbox">
	        	    <div class="form-group form-group-sm">
					      <label class="label-text">PO Date<span>*</span></label>
					    	 <input class="select_box2" style= "width:100%" readonly type="text" id="datepicker-14" name="podate" value="${param.poDate}" autocomplete="off"/>
					 </div>                     
	              	<br/><br/>
	           	  	<input type="button" class="sbt_btn3"  onClick="updatePODetails(this,'updatePODate',)" name="actn" value="Apply"/>
	        	</div>                     
	       </div>
	       <%-- end of PO details update --%>
	       <%-- start of Invoice details update  --%>
	       <div id="invUpdaterequestWindow" class="invUpdaterequestWindow"  >
	      		<img src="resources/images/Closebutton.png" style="float: right" onclick="closeLostHoldStg3RequestWindow('invUpdaterequestWindow','invUpdatereasonbox','INV');"/><br/>
	        	<div id="invUpdatereasonheading" class="invUpdatereasonheading"></div> 
	        	<div id="invUpdatereasonbox" class="invUpdatereasonbox">
	        	    <div class="form-group form-group-sm">
					      <label class="label-text">Invoice Date<span>*</span></label>
					    	 <input class="select_box2" style= "width:100%" readonly type="text" id="datepicker-15" name="invdate" autocomplete="off"/>
					 </div>                     
	              	<br/><br/>
	           	  	<input type="button" class="sbt_btn3"  onClick="updateINVDetails(this,'updateINVDate')" name="actn" value="Apply"/>
	        	</div>                     
	       </div>
	       <%-- end of Invoice details update--%>
	       <%-- start of Reminder details update  --%>
	       <div id="reminderrequestWindow" class="stg3requestWindow">
	      		<img src="resources/images/Closebutton.png" style="float: right" onclick="closeLostHoldStg3RequestWindow('reminderrequestWindow','reminderreasonbox','REM');"/><br/>
	        	<div id="reminderreasonheading" class="stg3reasonheading"></div> 
	        	<div id="reminderreasonbox" class="stg3reasonbox">
	        	    <div class="form-group form-group-sm">
					      <label class="label-text">Reminder Date<span>*</span></label>
					    	 <input class="select_box2" style= "width:100%" readonly type="text" id="datepicker-16" name="reminderdate" value="${param.loidate}" autocomplete="off"/>
					 </div>	    
					 <label class="label-text">Description<span>*</span></label> <textarea name="reason"rows="4" cols="50" id="thereminder" maxlength="200" style="width:18em;height: 6em"></textarea>   
					         		                   
	              	<br/><br/>	              
	              	<input type="hidden" name="qtnnDate" value="" id="qtnnDate" /> 
	              	<input type="hidden" id="projectName" value=""/>
	              	<input type="hidden" id="qtncodeno" value=""/>
	           	  	<input type="button" class="sbt_btn3"  onclick="Submit(this,'thereminder','remrtyp','rem');" name="actn" value="Apply"/>
	        	</div>                     
	       </div>
	        <%-- end of Reminder details update  --%>
	        <%-- start of stage1 details update  --%>
	       <div id="stage1requestWindow" class="stage1requestWindow">
	      		<img src="resources/images/Closebutton.png" style="float: right" onclick="closeWindow('stage1requestWindow');"/><br/>
	        	<div id="stage1reasonheading" class="stage1reasonheading"></div>                     
	       </div>
	       <%-- start of Expected LOI details details update  --%>
	       <div id="expLOIDateUpdaterequestWindow" class="expLOIDateUpdaterequestWindow"  >
	      		<img src="resources/images/Closebutton.png" style="float: right" onclick="closeLostHoldStg3RequestWindow('expLOIDateUpdaterequestWindow','expLOIUpdatereasonbox','ExpLOI');"/><br/>
	        	<div id="expLOIUpdatereasonheading" class="expLOIUpdatereasonheading"></div> 
	        	<div id="expLOIUpdatereasonbox" class="expLOIUpdatereasonbox">
	        	    <div class="form-group form-group-sm">
	        	       <label class="label-text">LOI Date<span>*</span></label>
					    <input class="select_box2" style= "width:100%" readonly type="text" id="datepicker-17" name="exploidate" value="${param.expLOIDate}" autocomplete="off"/>
					 </div>                     
	              	<br/><br/>
	           	  	<input type="button" class="sbt_btn3"  onClick="updateExpLOIDetails(this)" name="actn" value="Apply"/>
	        	</div>                     
	       </div>
	      
	       <%-- start of Expected LOI details details update  --%>
	       <div id="expOrderDateUpdaterequestWindow" class="expOrderDateUpdaterequestWindow"  >
	      		<img src="resources/images/Closebutton.png" style="float: right" onclick="closeLostHoldStg3RequestWindow('expOrderDateUpdaterequestWindow','expOrderDateUpdatereasonbox','ExpOD');"/><br/>
	        	<div id="expOrderDateUpdatereasonheading" class="expOrderDateUpdatereasonheading"></div> 
	        	<div id="expOrderDateUpdatereasonbox" class="expOrderDateUpdatereasonbox">
	        	    <div class="form-group form-group-sm">
	        	       <label class="label-text">Order Date<span>*</span></label>
					    <input class="select_box2" style= "width:100%" readonly type="text" id="datepicker-18" name="exploidate" value="${param.expLOIDate}" autocomplete="off"/>
					 </div>                     
	              	<br/><br/>
	           	  	<input type="button" class="sbt_btn3"  onClick="updateExpOrderDetails(this)" name="actn" value="Apply"/>
	        	</div>                     
	       </div>
	        <%-- end of Expected LOI details update --%>
	        <%-- start of Expected LOI details details update  --%>
	       <div id="expBillingDateUpdaterequestWindow" class="expBillingDateUpdaterequestWindow"  >
	      		<img src="resources/images/Closebutton.png" style="float: right" onclick="closeLostHoldStg3RequestWindow('expBillingDateUpdaterequestWindow','expBillingDateUpdatereasonbox','ExpBD');"/><br/>
	        	<div id="expBillingDateUpdatereasonheading" class="expBillingDateUpdatereasonheading"></div> 
	        	<div id="expBillingDateUpdatereasonbox" class="expBillingDateUpdatereasonbox">
	        	    <div class="form-group form-group-sm">
	        	       <label class="label-text">Billing Date<span>*</span></label>
					    <input class="select_box2" style= "width:100%" readonly type="text" id="datepicker-19" name="expbillingdate" value="${param.expLOIDate}" autocomplete="off"/>
					 </div>                     
	              	<br/><br/>
	           	  	<input type="button" class="sbt_btn3"  onClick="updateExpBillingDetails(this)" name="actn" value="Apply"/>
	        	</div>                     
	       </div>
	        <%-- end of Expected LOI details update --%>
	       <%-- start of SE WIN % details update  --%>
	       <div id="sewinUpdaterequestWindow" class="sewinUpdaterequestWindow"  >
	      		<img src="resources/images/Closebutton.png" style="float: right" onclick="closeLostHoldStg3RequestWindow('sewinUpdaterequestWindow','sewinUpdatereasonbox','SEWIN');"/><br/>
	        	<div id="sewinUpdatereasonheading" class="sewinUpdatereasonheading"></div> 
	        	<div id="sewinUpdatereasonbox" class="sewinUpdatereasonbox">
	        	    <div class="form-group form-group-sm">					    
					    	 <label class="label-text">WIN %<span>*</span></label> <textarea name="sewin" rows="1"  id="sewin" maxlength="100" style="width:14em;height: 2em"></textarea>
					 </div>                     
	              	<br/><br/>
	              	<input type="hidden" id="stageno" value=""/>
	           	  	<input type="button" class="sbt_btn3"  onClick="updateSEWin(this)" name="actn" value="Apply"/>
	        	</div>                     
	       </div>
	       <%-- end of SE WIN % update --%>
	        
			<div class="modal fade" id="cvDetails" role="dialog" >					
				 <div class="modal-dialog" style="width:30%;">
				     <!-- Modal content-->
						<div class="modal-content"> 
							    <div class="modal-body small"> <div id="table_div"></div></div> 
								<div class="modal-footer">
								         <button type="button" class="btn btn-default pull-right" data-dismiss="modal">Close</button>
								 </div>
						</div>								     								     
				   </div>   	 		   	 
			</div>	
		 <%--Submittal status Reason Div Start --%>
	        <div id="submittalstatusrequestWindow" class="holdrequestWindow"  >
	      		<img src="resources/images/Closebutton.png" style="float: right" onclick="closeLostHoldStg3RequestWindow('submittalstatusrequestWindow','submittalstatusreasonbox','SS');"/><br/>
	        	<div id="submittalstatusreasonheading" class="holdreasonheading"></div> 
	        	<div id="submittalstatusreasonbox" class="holdreasonbox">
	        	    <div class="form-group form-group-sm">
					     <label class="label-text">Status:*</label>
					      <select class="form-control form-control-sm select2" style="width: 100%;" id="substatus" name="substatus" required>
					           <option value="">Select</option>
					           <c:forEach var="typeList"  items="${SUBSTS}" >
				               <option value="${typeList.remarksType}" >${typeList.remarkTypeDesc}</option>
				               </c:forEach>
					     </select>
					 </div>
	        		<label class="label-text">Remarks:</label> <textarea name="substatusremarks" rows="4" cols="50" id="substatusremarks" maxlength="200" style="width:18em;height: 6em" required></textarea>               
	              	<br/><br/>
	           	  	<input type="button" class="sbt_btn3"  onclick="Submit(this,'substatusremarks','substatus','SS');" name="actn" value="Apply"/>
	        	</div>                     
	       </div>	
	       <%-- End Submittal status Reason Div Start --%>
		<div class="modal fade" id="help-modaltotalwinning"  role="dialog" >
		 <div class="modal-dialog  modal-sm"  >
			<div class="modal-content" style="height:min-content;width: max-content !important;">
				 <div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					 <h4 class="modal-title">Chances Of Winning</h4>
					 </div>
					<div class="modal-body">
							<font  color="#0c3d6d" style="padding-left:20px"> <b>40% Consultant Winning</b></font><br/>
						 <ol>					    	
							 <li><font color="#0000ff"> </font> Product specified fall - 40%
							</li>
							 <li><font color="#ff9900"></font>  No specified - 10%
							</li>
							 <li><font color="#3b80a9"></font>  Other FJ product specified - 20%
							</li>							 
						 </ol>    
						<font  color="#0c3d6d" style="padding-left:20px"> <b>60% Contractor Winning</b></font><br/>	
						<ol>					    	
							 <li><font color="#0000ff"> </font>We sold same product before - 60%
							</li>
							 <li><font color="#ff9900"></font>We sold other FJ products before - 40%
							</li>
							 <li><font color="#3b80a9"></font>New contractor - 20%
							</li>							 
						 </ol> 
							<br/><br/>
							
					              
					 </div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default pull-left"
											data-dismiss="modal">Close</button>

									</div>
								</div>
								<!-- /.modal-content -->
							</div>
							<!-- /.modal-dialog -->
						</div>	
			        <div id="laoding" class="loader" ><img src="resources/images/wait.gif"></div>	
	 		</section>
	
      
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
<script src="resources/bower_components/select2/dist/js/select2.full.min.js"></script>
<script src="resources/js/date-eu.js"></script>
<!-- page script START -->
<script>
var _url = 'SipStageFollowUpController';
var _empCode = '${fjtuser.emp_code}';
var _method = "POST"; 
const statusList     =  <%=new Gson().toJson(request.getAttribute("STATUSLST"))%>;
const priorityList   =  <%=new Gson().toJson(request.getAttribute("PRIORITYLST"))%>;
const seList   =  <%=new Gson().toJson(request.getAttribute("SEngLst"))%>;
const filterList = <%=new Gson().toJson(request.getAttribute("FILTERLST"))%>;
const filterData = {};
var stage4List = [], stage23List = [];
const months = [{value:'01',month:'Jan'}, {value:'02',month:'Feb'}, {value:'03',month:'Mar'},{value:'04',month:'Apr'},  {value:'05',month:'May'},{value:'06',month:'Jun'},
	{value:'07',month:'Jul'},{value:'08',month:'Aug'},{value:'09',month:'Sep'},{value:'10',month:'Oct'},{value:'11',month:'Nov'},{value:'12',month:'Dec'}];
const years = [ new Date().getFullYear()-1, new Date().getFullYear(), new Date().getFullYear()+1] 
const loggedEmp = '${loggedEmp}';
let selectedStatus = '${selectedStatus}';
let selectedStage  =  '${selectedStage}'; 
let selectedPriority  =  '${selectedPriority}';
let selectedId, selectedSeCode, selectedRow;
let table;
var SUBSTS_JSON =   <%=new Gson().toJson(request.getAttribute("SUBSTS"))%>;
  $(function () {  
	  $('.loader,.sub-laoding, #sub-laoding').hide();
	  $('.select2').select2();    
	  $('[data-toggle="tooltip"]').tooltip();   
	  $(".filterDate").datepicker({ "dateFormat" : "dd/mm/yy"});
	  if(selectedStage){
		  setFilterSelectorsMain(stage);	 
	  }
	  $('#stage').on('change', function() {
		  const stage  =  $.trim($('#stage').val());  
		  Object.getOwnPropertyNames(filterData).forEach(function (prop) {
			  delete filterData[prop];
			});
		  setFilterSelectorsMain(stage); 
		});
	  $("#stageFup").submit(function(e){
		  e.preventDefault();
		  const data = checkDataToSubmit(); 
		  if(data.ready){
			  selectedStage = data.stage; 
			  getData(data);
		  }
		});
	  $("#slctAllseg").click(function(){
		    if($("#slctAllseg").is(':checked') ){
		        $("#secode > option").prop("selected","selected");
		        $("#secode").trigger("change");
		    }else{ 
		    	$("#secode").find('option').prop("selected",false);
		        $("#secode").trigger('change');
		     }
		});
});
function checkDataToSubmit(){
	closeRequestWindow();
	selectedId = "";
	selectedRow = -1;
	let ready = false;
	const seCodes   =  $.trim($('#secode').val());  
	const stage    =  $.trim($('#stage').val());  	
	const remarks    =  $.trim($('#searchremarks').val()); 
	const amountGreaterthan    =  $.trim($('#amountgreaterthan').val());
     if(seCodes === null || typeof seCodes === 'undefined' || seCodes === '' || seCodes.length == 0){
		 $("#secode").focus();
		 alert("Please select atleast one sales engineer");   
		 return {"ready": ready};
	}if(amountGreaterthan != null){
		if(/^[0-9-]*$/.test(amountGreaterthan) == false){
			alert("Please enter only numbers in Amount ");
		    return false;
		}
	} 
    if(seCodes && stage){ ready = true; } 
    //const obj = {"ready":ready,"seCode":seCodes.split(",").map(item=>"'"+item+"'").join(","),"stage": (stage < 2 || stage > 3)? 2: stage,"status":status,"priority": priority};
    const obj = {"ready":ready,"seCode":seCodes.split(",").map(item=>"'"+item+"'").join(","),"remarks":remarks,"amountgreaterthan":amountGreaterthan,"stage": (stage < 1 || stage > 4 )? 2 : stage, ...filterData};
    return obj; 
	 
}
function selectAndSetFilterOptions(event){ filterData[event.target.id] = event.target.value;}
function changeStyle(event){ 
	event.target.style.backgroundColor = event.target.value;
	event.target.style.fontWeight = "bold"; 	
}
function changeChildItemsValues(element,id, event){  
	document.querySelectorAll('.'+id).forEach(function(headerItem) { headerItem.value=event.target.value; });
}
function getSelectElement(type, selectedElmnt,filter,stage, headerId, itemId){
	  let select = "";
	  if( type === 'HEADER'){
		  select += '<select  id=\''+filter+''+headerId+'\' onchange=changeChildItemsValues("select",\''+filter+''+headerId+'\',event)>';
	  }else{
		  select += '<select class=\''+filter+''+headerId+'\'  id=\''+filter+''+itemId+'\' >';
	  } 
	  select += '<option value="">Select</option>';  
	  filterList.filter(s => (s.stage === 4 && s.filter === filter )).map(item =>{  
		  if(item.status === selectedElmnt){
			  select += '<option  style=\'font-weight:bold;background-color:'+item.style+'\' value=\''+item.status+'\' selected>'+item.status+'</option>';
		  }else{
			  select += '<option  style=\'font-weight:bold;background-color:'+item.style+'\' value=\''+item.status+'\' >'+item.status+'</option>';
		  }
		   
	  });
	  select += "</select>"
	  return select;
}
function getDateElement(type, dateValue, filter, headerId, itemId){
	let date = "";
	if( type === 'HEADER'){
		date += '<input class="filterDate"  style="width:70px !important;"  type="text" id=\''+filter+''+headerId+'\'  value=\''+dateValue+'\' autocomplete="off" onchange=changeChildItemsValues("date",\''+filter+''+headerId+'\',event)  /></td>';
	  }else{
		  date += '<input class="filterDate '+filter+''+headerId+'\"  style="width:70px !important;"  type="text" id=\''+filter+''+itemId+'\'  value=\''+dateValue+'\' autocomplete="off"   /></td>';
	  }
	
	return date;
}
function updateStage4SingleItem(details,event){ 
	
    const tempIndexOfItems = [];
    const arrayOfFilters =  [];
    let subItemsListForHeader = [];
    subItemsListForHeader = stage4List.filter(item=> (details.soId=== item.cqhSysId && item.type === 'DETAIL'));
    const timeElapsed = Date.now();
    const today = new Date(timeElapsed);
    details.itemIDs.map(item=>{ 
    	const singleItem = subItemsListForHeader.filter(snglI => item  == snglI.itemId)[0];
    	
    	const mainIndex = stage4List.indexOf(singleItem);
    	const subIndex =  subItemsListForHeader.indexOf(singleItem);
    	tempIndexOfItems.push({main:mainIndex, sub:subIndex});  
     	const deliveryDate = $.trim($('#deliverydate'+item).val());
     	const materialStatus = $.trim($('#Material'+item).val());
     	const paymentStatus = $.trim($('#Payment'+item).val());
     	const readynessStatus = $.trim($('#Readiness'+item).val()); 
     	arrayOfFilters.push({"itemId": ''+item+'' ,"material":materialStatus, "payment":paymentStatus, "readyness":readynessStatus,"deliveryDate": deliveryDate})
     	subItemsListForHeader[subIndex] = {...singleItem, deliveryDate, materialStatus, paymentStatus, readynessStatus,"updatedBy":_empCode,"updatedOn":today.toLocaleDateString() };
    }); 
	const filterData ={data:  arrayOfFilters };  
	if ((confirm('Are You sure, You Want to update this details!'))) { 
		document.querySelector('#responsetxt').innerHTML = "<b style='font-weight: bold;font-size: 14px;' class='text-info'>Dont close this window, Data update prgressing...<i class='fa fa-refresh fa-spin'></i></b>";
		$.ajax({
			 type: _method,
			 url: _url,  
			 data: {action: "updateStage", filterData : JSON.stringify(filterData), seCode: details.seCode, stage: details.stage, soId: details.soId},
			 dataType: "json", 
			 success: function(data) {    
				 if(data === arrayOfFilters.length){
					  event.target.style.display = "none"; 
					  document.querySelector('#responsetxt').innerHTML = "<b style='font-weight: bold;font-size: 14px;' class='text-success'>Details saved successfully..!</b>";
					   tempIndexOfItems.map(index=>{
					 	  stage4List[index.main] = subItemsListForHeader[index.sub];
					  });  
				 }else{
					 document.querySelector('#responsetxt').innerHTML = "<b style='font-weight: bold;font-size: 14px;' class='text-danger'>Details not updated..!, Please try logout and login again</b>";
				 }
				  
			 },
			 error:function(data,status,er) { 
				 	 document.querySelector('#responsetxt').innerHTML = "<b style='font-weight: bold;font-size: 14px;' class='text-danger'>Details not updated..!, Please try logout and login again</b>";
					 //$("#stage_detail").html("Something went wrong..!, Please try logout and login again");  
			}
		}); 
	} else{
		$('#laoding').hide();
		return false;
	}    	
	//console.log({...filterData,deliveryDate,materialStatus,paymentStatus,readynessStatus,billingStatus});
}
function stage4Items(data){ 
	const items = stage4List.filter(item => (item.cqhSysId === data.id )); 
	const itemIDs =   items.filter(item => item.type == 'DETAIL' ).map(i=>i.itemId);  
	 $("#s4_items_modal .modal-title").html("Item Details For "+items[0].qtnCode+"-"+items[0].qtnNo); 
	let output="";
	 output += '<div class="small" style="margin-bottom:10px;">'+
	 			'<b>Customer : </b>'+items[0].custName+'<br/>'+
	 			'<b>Project : </b>'+items[0].projectName+' '+
	 			'<span id="responsetxt" class="pull-right"><span>';
	 if(data.showUpdateBtn){
		 output += '<button class="btn btn-xs btn-danger pull-right"  onclick=updateStage4SingleItem({seCode:\''+$.trim(items[0].seCode)+'\',stage:'+selectedStage+',soId:\''+$.trim(items[0].cqhSysId)+'\',itemIDs:['+itemIDs+']},event)>Save Changes</button>'; 		  
	 }			
	 output += '</div>';
	 output += '<table id="stage4_items_tbl" class="table table-bordered table-hover small">'+
		'<thead>'+       		
		'<tr>	'+	        			 
		'<th>Item Code</th><th>Item Description</th><th>SO EUM</th><th>Balance Qty.</th><th>Balance Value</th>'+	
		'<th>Delivery Date</th><th>Material Status</th><th>Payment Status</th><th>Ready Status</th>'+      
		'</tr></thead><tbody>'; 
		 for(var i in items) {
				//const showUpdateBtn = (getSalesEngineerDetails(data.seCode)[0].salesman_emp_code === loggedEmp) ? true : false;   
				  output += '<tr>';
				  if( $.trim(items[i].type) === 'HEADER'){
					  output += '<td><b class="text-success">All Items</b></td><td>-</td><td></td>';
				  }else{
					  output += '<td>'+$.trim(items[i].itemCode)+'</td><td style="cursor:pointer;" data-toggle="tooltip" title=\''+$.trim(items[i].itemDesc)+'\'  >'+$.trim(items[i].itemDesc).slice(0, 50)+'...</td><td>'+$.trim(items[i].soUom)+'</td>';
				  } 
				  if(data.showUpdateBtn){
					  output +='<td>'+$.trim(items[i].balanceQty)+'</td><td>'+$.trim(items[i].amount)+'</td>'+ 
					  '<td>'+getDateElement($.trim(items[i].type),$.trim(items[i].deliveryDate.substring(0, 10)).split("-").reverse().join("/"),'deliverydate',$.trim(items[i].cqhSysId),$.trim(items[i].itemId))+'</td>'+	
					 '<td>'+ getSelectElement($.trim(items[i].type),$.trim(items[i].materialStatus),'Material',4,$.trim(items[i].cqhSysId),$.trim(items[i].itemId))+'</td>'+ 
					 '<td>'+getSelectElement($.trim(items[i].type),$.trim(items[i].paymentStatus),'Payment',4,$.trim(items[i].cqhSysId),$.trim(items[i].itemId))+'</td><td>'
					   +getSelectElement($.trim(items[i].type),$.trim(items[i].readynessStatus),'Readiness',4,$.trim(items[i].cqhSysId),$.trim(items[i].itemId))+'</td>'; 
				  }else{
					  output +='<td>'+$.trim(items[i].balanceQty)+'</td><td>'+$.trim(items[i].amount)+'</td>'+ 
					  '<td>'+$.trim(items[i].deliveryDate.substring(0, 10)).split("-").reverse().join("/")+'</td>'+	
					 '<td>'+$.trim(items[i].materialStatus)+'</td>'+ 
					 '<td>'+$.trim(items[i].paymentStatus)+'</td><td>'+$.trim(items[i].readynessStatus)+'</td>'; 
				  }
				 
				  output += '</tr>';
			
				}
		output += '</tbody></table></div>';
		 $("#s4_items_modal .modal-body").html(output);
         $("#s4_items_modal").modal("show");
         $(".filterDate").datepicker({ "dateFormat" : "dd/mm/yy"});
}



function getData(details){
	stage4List = [];stage23List=[];
	 $('#laoding').show();  
	$.ajax({
		 type: _method,
		 url: _url,  
		 data: {action: "stageData", seCode:details.seCode, searchremarks:details.remarks, amountgreaterthan:details.amountgreaterthan,stage:details.stage, ...filterData },
		 dataType: "json", 
		 success: function(data) { 
			 $('#laoding').hide(); 
			 let output="<div class='box-body small'>" , outputReport ="";
			
			 if(parseInt(details.stage) === 4){				 			
				if(data && $.trim(data) == ''){
					 output += '<table id="stage_detail_tbl4" class="table1 table-bordered table-hover small">';
				}else{
				 output += '<table id="stage_detail_tbl4" class="table table-bordered table-hover small">';
				}
				 output +='<thead>'+       		
		 			'<tr>	'+	        			 
		 			'<th width="10%">Sales Eng.</th><th width="10%">SO Dt.</th><th width="10%">SO Code-No.</th><th width="10%">Customer</th><th width="10%">Project</th><th width="10%">Balance Value</th><th width="10%">Exp.Billing Date</th><th width="10%">Short Close</th><th width="10%">Reminders</th>'+	
		 			'<th width="10%">Items</th>'+      
		 			'</tr></thead><tbody>'; 
		 		 outputReport += '<table id="stage_detail_report" class="display nowrap" >'+
					'<thead>'+       		
		 			'<tr>	'+	        			 
		 			'<th>Sales Eng.</th><th>SO Dt.</th><th>SO Code-No.</th><th>Customer</th><th>Project</th><th>Consultant</th><th>Balance Value</th>'+	
		 			'<th>Delivery Dt.</th><th>Item Code</th><th>Item Desc</th><th>SO UOM</th><th>Balance Quantity</th>'+   
		 			'<th>Material Status</th><th>Payment Status</th><th>Readyness Staus</th><th>Updated On</th>'+  
		 			'</tr></thead><tbody>'; 
				 if(data){
					 stage4List = data; 
					 var totalAmount = 0;
					 for(var i in data) {					
					const showUpdateBtn = (getSalesEngineerDetails(data[i].seCode)[0].salesman_emp_code === loggedEmp) ? true : false; 
					
					if($.trim(data[i].type) === 'HEADER'){
					  output += '<tr><td width="15%">'+$.trim(data[i].seCode)+'-'+$.trim(data[i].seName)+'</td>'+	 
					 '<td>'+$.trim(data[i].qtnDt.substring(0, 10)).split("-").reverse().join("/")+'</td>'+	
					 '<td>'+$.trim(data[i].qtnCode)+'-'+$.trim(data[i].qtnNo)+'</td>'+ 
					 '<td>'+$.trim(data[i].custName)+'</td>'+ 
					 '<td width="25%">'+$.trim(data[i].projectName)+'</td>'+ 
					 '<td align ="right">'+$.trim(formatNumber(data[i].amount))+'</td>';
					  output +=  '<td>'+$.trim(data[i].expLOIDate)+'<br/>';					 
						 if(showUpdateBtn){   
							 output += '<input type="radio" id="ExpBD'+$.trim(data[i].cqhSysId)+'"onclick=openLostHoldStg3Window(event,\''+$.trim(data[i].cqhSysId)+'\',\''+$.trim(data[i].qtnCode)+'\',\''+$.trim(data[i].qtnNo)+'\',\'ExpBD\',\''+$.trim(data[i].qtnDt.substring(0, 10)).split("-").reverse().join("/")+'\',\''+$.trim(data[i].seCode)+'\')>';
						 }
					  output +=  ' </td>';	
					  output +=  ' <td>';
						 if(showUpdateBtn){   
							 output += ' <button class="btn btn-xs btn-primary"  name="shortclose" id="SC'+$.trim(data[i].cqhSysId)+'" onClick=updateShortClose(\''+$.trim(data[i].cqhSysId)+'\')> Close </button>'
							 output += ' <div id="shortc'+$.trim(data[i].cqhSysId)+'">'
						    }
							 output +=  ' </td>';
					  output +=  ' <td>';
						// if(showUpdateBtn){   
							 output += ' <button class="btn btn-xs btn-success"  name="reminders" id="R'+$.trim(data[i].cqhSysId)+'" onClick=openLostHoldStg3Window(event,\''+$.trim(data[i].cqhSysId)+'\',\''+$.trim(data[i].qtnCode)+'\',\''+$.trim(data[i].qtnNo)+'\',\'R\',\''+$.trim(data[i].qtnDt.substring(0, 10)).split("-").reverse().join("/")+'\',\''+$.trim(data[i].seCode)+'\',\''+encodeURIComponent($.trim(data[i].projectName))+'\',\''+$.trim(data[i].qtnCode)+-+$.trim(data[i].qtnNo)+'\',\''+encodeURIComponent($.trim(data[i].seName))+'\',\''+showUpdateBtn+'\')> Reminders </button>' 
							 output += ' <div id="innerday'+$.trim(data[i].cqhSysId)+'" class="cen_icon" onclick="showRemindersForQtn(event,\''+$.trim(data[i].qtnCode)+-+$.trim(data[i].qtnNo)+'\');"> '     	
							 if($.trim(data[i].reminderCount) > 0){ 
								 output += '  <i class="fa fa-2x fa-clock-o"></i>';
							    }
							 output +=  '</div>';
						 	 // }
							 output +=  ' </td>'+
		
					 '<td><button class="btn btn-xs btn-danger" id="'+$.trim(data[i].cqhSysId)+'" onclick=stage4Items({showUpdateBtn:'+showUpdateBtn+',seCode:\''+$.trim(data[i].seCode)+'\',id:\''+$.trim(data[i].cqhSysId)+'\',event})>Items</button></td>';
					
					 output += '</tr>';
					  totalAmount = totalAmount + +data[i].amount;
					}
					outputReport += '<tr><td>'+$.trim(data[i].seCode)+'-'+$.trim(data[i].seName)+'</td>'+	 
						 '<td>'+$.trim(data[i].qtnDt.substring(0, 10)).split("-").reverse().join("/")+'</td>'+	
						 '<td>'+$.trim(data[i].qtnCode)+'-'+$.trim(data[i].qtnNo)+'</td>'+ 
						 '<td>'+$.trim(data[i].custName)+'</td><td>'+$.trim(data[i].projectName)+'</td><td>'+$.trim(data[i].consultant)+'</td><td>'+$.trim(data[i].amount)+'</td>'+ 
						 '<td>'+$.trim(data[i].deliveryDate.substring(0, 10)).split("-").reverse().join("/")+'</td><td>'+$.trim(data[i].itemCode)+'</td><td>'+$.trim(data[i].itemDesc)+'</td><td>'+$.trim(data[i].soUom)+'</td>'+   
						 '<td>'+$.trim(data[i].balanceQty)+'</td><td>'+$.trim(data[i].materialStatus)+'</td><td>'+$.trim(data[i].paymentStatus)+'</td><td>'+$.trim(data[i].readynessStatus)+'</td><td>'+$.trim(data[i].updatedOn)+'</td>';
					outputReport += '</tr>';
					 //totalAmount = totalAmount + +data[i].amount;
					 } 
					}  
				 document.getElementById("totalCount").style.marginLeft = "265px";			
				 $("#s2CntDiv").html(formatNumber(Math.round(totalAmount))); 
			 }else if(parseInt(details.stage) === 3){
				
				 if(data && $.trim(data) == ''){
					 output += '<table id="stage_detail_tbl3" class="table1 table-bordered table-hover small">';
				}else{
					 output += '<table id="stage_detail_tbl3" class="table table-bordered table-hover small">';
				}
				 output +='<thead>'+       		
		 			'<tr>	'+	        			 
		 			'<th>Sales Eng.</th><th>Qtn Dt.</th><th>Qtn No.-Code</th><th>Consultant Win %</th> <th>Contractor Win %</th><th>Total Win % <a href= "#" data-toggle="modal" data-target="#help-modaltotalwinning"> <i class="fa fa-info-circle pull-right" style="color: #2196f3;font-size: 15px;margin-top: 4px;"></i></a></th><th>SE WIN%</th><th>Customer</th><th>Project</th><th>Consultant</th><th>Amount</th><th>Status</th><th>Focus List</th><th>Remark</th>'+	
		 			'<th>Exp.PODate</th><th>Exp. InvDate</th><th width="100px">Lost/Hold  Status</th> <th>Follow-Up & Remarks</th><th>Reminders</th>'+      
		 			'</tr></thead><tbody>'; 
				 if(data){
					 stage23List = data; 
					 var totalAmount = 0;
					 for(var i in data) {
					const showUpdateBtn = (getSalesEngineerDetails(data[i].seCode)[0].salesman_emp_code === loggedEmp) ? true : false; 
					  output += '<tr><td>'+$.trim(data[i].seCode)+'-'+$.trim(data[i].seName)+'</td>'+	 
					 '<td>'+$.trim(data[i].qtnDt.substring(0, 10)).split("-").reverse().join("/")+'</td>'+	
					 '<td>'+$.trim(data[i].qtnCode)+'-'+$.trim(data[i].qtnNo)+'</td>'+
					 '<td>'+$.trim(data[i].consultWin)+'%</td>'+
					 '<td>'+$.trim(data[i].contractorWin)+'%</td>'+
					 '<td>'+$.trim(data[i].totalWin)+'%</td>';
					  output +=  '<td>'+ $.trim(data[i].sewinper);		
					  if($.trim(data[i].sewinper) !== '')
							 output += '% <br/>';
						 if(showUpdateBtn){   
							 output += '<input type="radio" id="SEWIN'+$.trim(data[i].cqhSysId)+'"onclick=openLostHoldStg3Window(event,\''+$.trim(data[i].cqhSysId)+'\',\''+$.trim(data[i].qtnCode)+'\',\''+$.trim(data[i].qtnNo)+'\',\'SEWIN\',\''+$.trim(data[i].qtnDt.substring(0, 10)).split("-").reverse().join("/")+'\',\''+$.trim(data[i].seCode)+'\',\'3\')>';
						 }
					  output +=  ' </td>'+
					 '<td>'+$.trim(data[i].custName)+'</td>'+
					 '<td>'+$.trim(data[i].projectName)+'</td>'+
					 '<td>'+$.trim(data[i].consultant)+'</td>'+
					 '<td  align ="right">'+$.trim(formatNumber(Math.round(data[i].qtnAmount)))+'</td>'+
					 '<td id="status'+$.trim(data[i].cqhSysId)+'">'+$.trim(data[i].status)+'</td>';
					  output +=  '<td>'+ $.trim(data[i].sewinper);		
					  if($.trim(data[i].sewinper) !== '')
							 output += '% <br/>';
						 if(showUpdateBtn){   
							 output += '<input type="radio" id="SEWIN'+$.trim(data[i].cqhSysId)+'"onclick=openLostHoldStg3Window(event,\''+$.trim(data[i].cqhSysId)+'\',\''+$.trim(data[i].qtnCode)+'\',\''+$.trim(data[i].qtnNo)+'\',\'SEWIN\',\''+$.trim(data[i].qtnDt.substring(0, 10)).split("-").reverse().join("/")+'\',\''+$.trim(data[i].seCode)+'\',\'3\')>';
						 }
					  output +=  ' </td>'+					 
					 '<td id="remarks'+$.trim(data[i].cqhSysId)+'">'+$.trim(data[i].remarks)+'</td>';
					 totalAmount = totalAmount + Math.round(data[i].qtnAmount);
					 
// 					 output +=  '<td>'+$.trim(data[i].expLOIDate)+'<br/>';					 
// 					 if(showUpdateBtn){   
// 						 output += '<input type="radio" id="ExpOD'+$.trim(data[i].cqhSysId)+'"onclick=openLostHoldStg3Window(event,\''+$.trim(data[i].cqhSysId)+'\',\''+$.trim(data[i].qtnCode)+'\',\''+$.trim(data[i].qtnNo)+'\',\'ExpOD\',\''+$.trim(data[i].qtnDt.substring(0, 10)).split("-").reverse().join("/")+'\',\''+$.trim(data[i].seCode)+'\')>';
// 					 }
// 					 output +=  ' </td>';					 
					
			 		 output +=  '<td>'+$.trim(data[i].poDate);
			 		 if(showUpdateBtn){ 
			 		 	output += '<label style="color:blue;text-transform: uppercase;"><input type="radio" name="poupdate" id="po'+$.trim(data[i].cqhSysId)+'" onClick=openLostHoldStg3Window(event,\''+$.trim(data[i].cqhSysId)+'\',\''+$.trim(data[i].qtnCode)+'\',\''+$.trim(data[i].qtnNo)+'\',\'PO\',\''+$.trim(data[i].qtnDt.substring(0, 10)).split("-").reverse().join("/")+'\',\''+$.trim(data[i].seCode)+'\')> Update'	 		 
			 		  			 '</label>';
			 		   }
			 		  output +=  '</td> ';
			 		 output +=  '<td>'+$.trim(data[i].invoiceDate);
			 		 if(showUpdateBtn){ 
			 		 	output += '<label style="color:blue;text-transform: uppercase;"><input type="radio" name="invupdate" id="inv'+$.trim(data[i].cqhSysId)+'" onClick=openLostHoldStg3Window(event,\''+$.trim(data[i].cqhSysId)+'\',\''+$.trim(data[i].qtnCode)+'\',\''+$.trim(data[i].qtnNo)+'\',\'INV\',\''+$.trim(data[i].qtnDt.substring(0, 10)).split("-").reverse().join("/")+'\',\''+$.trim(data[i].seCode)+'\',\''+$.trim(data[i].poDate)+'\')> Update'	 		 
			 		  			 '</label>';
			 		   }
			 		  output +=  '</td> ';
			 		 output += ' <td>';
					 if(showUpdateBtn){ 
					 output += ' <label style="color:red;text-transform: uppercase;"><input type="radio" name="lostorhold" id="L'+$.trim(data[i].cqhSysId)+'" onClick=openLostHoldStg3Window(event,\''+$.trim(data[i].cqhSysId)+'\',\''+$.trim(data[i].qtnCode)+'\',\''+$.trim(data[i].qtnNo)+'\',\'LOIL\',\''+$.trim(data[i].qtnDt.substring(0, 10)).split("-").reverse().join("/")+'\',\''+$.trim(data[i].seCode)+'\')> Lost'	 		 
			 		   '</label> ';
				     output += '<label style="color:green;text-transform: uppercase;"> <input type="radio" name="lostorhold" id="nL'+$.trim(data[i].cqhSysId)+'" onClick=openLostHoldStg3Window(event,\''+$.trim(data[i].cqhSysId)+'\',\''+$.trim(data[i].qtnCode)+'\',\''+$.trim(data[i].qtnNo)+'\',\'LOINL\',\''+$.trim(data[i].qtnDt.substring(0, 10)).split("-").reverse().join("/")+'\',\''+$.trim(data[i].seCode)+'\')> HOLD'	 		 
			 		    '</label>';
						 }
					 output += '</td>';
			 		 if(showUpdateBtn){   
						 output += '<td><button class="btn btn-xs btn-danger" id="'+$.trim(data[i].cqhSysId)+'" onclick=openRequestWindow({seCode:\''+$.trim(data[i].seCode)+'\',row:'+i+',id:'+$.trim(data[i].cqhSysId)+',event})>Update</button></td>';
					 }else{
						 const updatedOn = ($.trim(data[i].updatedOn)) ? $.trim(data[i].updatedOn.substring(0, 10)).split("-").reverse().join("/") : '-';
						 output += '<td>'+updatedOn+'</td>'
						 }
			 		 output +=  ' <td>';
					// if(showUpdateBtn){   
						 output += ' <button class="btn btn-xs btn-success"  name="reminders" id="R'+$.trim(data[i].cqhSysId)+'" onClick=openLostHoldStg3Window(event,\''+$.trim(data[i].cqhSysId)+'\',\''+$.trim(data[i].qtnCode)+'\',\''+$.trim(data[i].qtnNo)+'\',\'R\',\''+$.trim(data[i].qtnDt.substring(0, 10)).split("-").reverse().join("/")+'\',\''+$.trim(data[i].seCode)+'\',\''+encodeURIComponent($.trim(data[i].projectName))+'\',\''+$.trim(data[i].qtnCode)+-+$.trim(data[i].qtnNo)+'\',\''+encodeURIComponent($.trim(data[i].seName))+'\',\''+showUpdateBtn+'\')> Reminders </button>' 
						 output += ' <div id="innerday'+$.trim(data[i].cqhSysId)+'" class="cen_icon" onclick="showRemindersForQtn(event,\''+$.trim(data[i].qtnCode)+-+$.trim(data[i].qtnNo)+'\');"> '     	
						 if($.trim(data[i].reminderCount) > 0){ 
							 output += '  <i class="fa fa-2x fa-clock-o"></i>';
						    }
						 output +=  '</div>';
					 	//  }
						 output +=  ' </td>';
			       	  output += '</tr>';
					 } ; 
					 
				}	
				 document.getElementById("totalCount").style.marginLeft = "480px";			
				 $("#s2CntDiv").html(formatNumber(Math.round(totalAmount))); 
			 } else if(parseInt(details.stage) === 2){
				 if(data && $.trim(data) == ''){
					 output += '<table id="stage_detail_tbl" class="table1 table-bordered table-hover small">';
				}else{
					output += '<table id="stage_detail_tbl" class="table table-bordered table-hover small">';
				}
				 
				 output +='<thead>'+       		
		 			'<tr>	'+	        			 
		 			'<th>Sales Eng.</th><th>Qtn Dt.</th><th>Qtn<br/> Code-No</th><th>Consultant<br/> Win %</th> <th>Contractor<br/> Win %</th><th>Total<br/> Win % <a href= "#" data-toggle="modal" data-target="#help-modaltotalwinning"> <i class="fa fa-info-circle pull-right" style="color: #2196f3;font-size: 15px;margin-top: 4px;"></i></a></th><th>SE WIN%</th><th>Customer</th><th>Project</th><th>Consultant</th><th>Product is Specified</th><th>Amount</th><th>Status</th><th>Focus List</th><th>Remarks</th>'+	
		 			'<th>Exp.LOI Date</th><th>Follow-Up & Remarks</th><th width="200px">Lost <br> Hold <br> Status</th><th>Submittal Status</th><th>Reminder</th>'+      
		 			'</tr></thead><tbody>'; 
				 if(data){
					 stage23List = data; 
					 var totalAmount = 0;remindersCount = 1;
					 for(var i in data) {
					const showUpdateBtn = (getSalesEngineerDetails(data[i].seCode)[0].salesman_emp_code === loggedEmp) ? true : false; 
					  output += '<tr id="'+$.trim(data[i].cqhSysId)+'"><td>'+$.trim(data[i].seCode)+'-'+$.trim(data[i].seName)+'</td>'+	 
					 '<td>'+$.trim(data[i].qtnDt.substring(0, 10)).split("-").reverse().join("/")+'</td>'+	
					 '<td>'+$.trim(data[i].qtnCode)+'-'+$.trim(data[i].qtnNo)+'</td>'+
					 '<td>'+$.trim(data[i].consultWin)+'%</td>'+
					 '<td>'+$.trim(data[i].contractorWin)+'%</td>'+
					 '<td>'+$.trim(data[i].totalWin)+'%</td>';
					 output +=  '<td>'+$.trim(data[i].sewinper);	
					 if($.trim(data[i].sewinper) !== '')
						 output += '% <br/>';
						 if(showUpdateBtn){   
							 output += '<input type="radio" id="SEWIN'+$.trim(data[i].cqhSysId)+'"onclick=openLostHoldStg3Window(event,\''+$.trim(data[i].cqhSysId)+'\',\''+$.trim(data[i].qtnCode)+'\',\''+$.trim(data[i].qtnNo)+'\',\'SEWIN\',\''+$.trim(data[i].qtnDt.substring(0, 10)).split("-").reverse().join("/")+'\',\''+$.trim(data[i].seCode)+'\',\'2\')>';
						 }
					 output +=  ' </td>'+
					 '<td>'+$.trim(data[i].custName)+'</td>'+
					 '<td>'+$.trim(data[i].projectName)+'</td>'+
					 '<td>'+$.trim(data[i].consultant)+'</td>';
					 
					 output +=  '<td>';	
					    var isApprovedYesChecked = $.trim(data[i].isApproved) === 'YES' ? 'checked' : '';
					    var isApprovedNoChecked = $.trim(data[i].isApproved) === 'NO' ? 'checked' : '';
					    var isApprovedNSChecked = $.trim(data[i].isApproved) === 'NS' ? 'checked' : '';
					 if(showUpdateBtn){   
						 output += ' <label style="color:red;text-transform: uppercase;"><input type="radio" name="isapproved'+$.trim(data[i].cqhSysId) + '" value="YES"  id="isapprovedYES'+$.trim(data[i].cqhSysId) + '" ' + isApprovedYesChecked + ' onClick=updateIsApprovedYN(event,\''+$.trim(data[i].cqhSysId)+'\',\''+$.trim(data[i].seCode)+'\')> Yes'	 		 
				 		   '</label>';
				 		 output += '<label style="color:green;text-transform: uppercase;"> <input type="radio" name="isapproved'+$.trim(data[i].cqhSysId) + '" value="NO" id="isapprovedNO'+$.trim(data[i].cqhSysId) + '" ' + isApprovedNoChecked + ' onClick=updateIsApprovedYN(event,\''+$.trim(data[i].cqhSysId)+'\',\''+$.trim(data[i].seCode)+'\')> No'	 		 
				 		   '</label>';
						output += '<label style="color:blue;text-transform: uppercase;"> <input type="radio" name="isapproved'+$.trim(data[i].cqhSysId) + '" value="NS" id="isapprovedNS'+$.trim(data[i].cqhSysId) + '" ' + isApprovedNSChecked + ' onClick=updateIsApprovedYN(event,\''+$.trim(data[i].cqhSysId)+'\',\''+$.trim(data[i].seCode)+'\')> Not Sure'	 		 
				 		   '</label>';
				 		  output += '<input type="hidden" id="isapprovedval'+$.trim(data[i].cqhSysId) + '" value="'+$.trim(data[i].isApproved) + '"/>';
					 }
					 output +=  ' </td>'+
					 '<td  align ="right">'+formatNumber(Math.round(data[i].qtnAmount))+'</td>'+					 
					 '<td id="status'+$.trim(data[i].cqhSysId)+'">'+$.trim(data[i].status)+'</td>'+
					 '<td id="priority'+$.trim(data[i].cqhSysId)+'">'+$.trim(data[i].priority)+'</td>'+
					 '<td id="remarks'+$.trim(data[i].cqhSysId)+'">'+$.trim(data[i].remarks)+'</td>';
					 totalAmount = totalAmount+Math.round(data[i].qtnAmount);
					 
					 output +=  '<td>'+$.trim(data[i].expLOIDate) +'<br/>';					 
					 if(showUpdateBtn){   
						 output += '<input type="radio" id="ExpLOI'+$.trim(data[i].cqhSysId)+'"onclick=openLostHoldStg3Window(event,\''+$.trim(data[i].cqhSysId)+'\',\''+$.trim(data[i].qtnCode)+'\',\''+$.trim(data[i].qtnNo)+'\',\'ExpLOI\',\''+$.trim(data[i].qtnDt.substring(0, 10)).split("-").reverse().join("/")+'\',\''+$.trim(data[i].seCode)+'\')>';
					 }
					 output +=  ' </td>';					 
					 if(showUpdateBtn){   
						 output += '<td><button class="btn btn-xs btn-danger" id="'+$.trim(data[i].cqhSysId)+'" onclick=openRequestWindow({seCode:\''+$.trim(data[i].seCode)+'\',row:'+i+',id:'+$.trim(data[i].cqhSysId)+',event})>Update</button></td>';
					 }else{
						 const updatedOn = ($.trim(data[i].updatedOn)) ? $.trim(data[i].updatedOn.substring(0, 10)).split("-").reverse().join("/") : '-';
						 output += '<td>'+updatedOn+'</td>'
						 } 
					 output +=  ' <td>';
					 if(showUpdateBtn){   
					 output += ' <label style="color:red;text-transform: uppercase;"><input type="radio" name="lostorhold" id="L'+$.trim(data[i].cqhSysId)+'" onClick=openLostHoldStg3Window(event,\''+$.trim(data[i].cqhSysId)+'\',\''+$.trim(data[i].qtnCode)+'\',\''+$.trim(data[i].qtnNo)+'\',\'L\',\''+$.trim(data[i].qtnDt.substring(0, 10)).split("-").reverse().join("/")+'\',\''+$.trim(data[i].seCode)+'\')> Lost'	 		 
					 		   '</label>';
					 output += '<label style="color:green;text-transform: uppercase;"> <input type="radio" name="lostorhold" id="nL'+$.trim(data[i].cqhSysId)+'" onClick=openLostHoldStg3Window(event,\''+$.trim(data[i].cqhSysId)+'\',\''+$.trim(data[i].qtnCode)+'\',\''+$.trim(data[i].qtnNo)+'\',\'NL\',\''+$.trim(data[i].qtnDt.substring(0, 10)).split("-").reverse().join("/")+'\',\''+$.trim(data[i].seCode)+'\')> Hold'	 		 
					 		   '</label>';
					 output += '<label style="color:orange;text-transform: uppercase;"> <input type="radio" name="lostorhold" id="stg1'+$.trim(data[i].cqhSysId)+'" onClick=moveToStage1(event,\''+$.trim(data[i].cqhSysId)+'\')> Stage 1'	 		 
				 		  		'</label>';
					 output += '<label style="color:blue;text-transform: uppercase;"> <input type="radio" name="lostorhold" id="stg'+$.trim(data[i].cqhSysId)+'" onClick=openLostHoldStg3Window(event,\''+$.trim(data[i].cqhSysId)+'\',\''+$.trim(data[i].qtnCode)+'\',\''+$.trim(data[i].qtnNo)+'\',\'stg3\',\''+$.trim(data[i].qtnDt.substring(0, 10)).split("-").reverse().join("/")+'\',\''+$.trim(data[i].seCode)+'\')> Stage 3'	 		 
					 		   '</label>';

					 } 
					 output +=  ' </td>';
					 output +=  ' <td>';
					 if(showUpdateBtn){   
						 output += '<button class="btn btn-xs btn-success" id="SS'+$.trim(data[i].cqhSysId)+'" onclick=openLostHoldStg3Window(event,\''+$.trim(data[i].cqhSysId)+'\',\''+$.trim(data[i].qtnCode)+'\',\''+$.trim(data[i].qtnNo)+'\',\'SS\',\''+$.trim(data[i].qtnDt.substring(0, 10)).split("-").reverse().join("/")+'\',\''+$.trim(data[i].seCode)+'\')>Update</button>';
						 }
						 output += ' <div id="submitalstatus'+$.trim(data[i].cqhSysId)+'" class="cen_icon" onclick="showSubmittalStatusForQtn(event,\''+$.trim(data[i].cqhSysId)+'\');"> '     	
						 if( $.trim(data[i].submittalcode) !== ''){ 
							 output += ' <button class="btn btn-xs">Details</button>';
						    }
						output +=  '</div>';
						// }
						 output +=  ' </td>';
					 
					 output +=  ' <td>';
					// if(showUpdateBtn){   
						 output += ' <button class="btn btn-xs btn-success"  name="reminders" id="R'+$.trim(data[i].cqhSysId)+'" onClick=openLostHoldStg3Window(event,\''+$.trim(data[i].cqhSysId)+'\',\''+$.trim(data[i].qtnCode)+'\',\''+$.trim(data[i].qtnNo)+'\',\'R\',\''+$.trim(data[i].qtnDt.substring(0, 10)).split("-").reverse().join("/")+'\',\''+$.trim(data[i].seCode)+'\',\''+encodeURIComponent($.trim(data[i].projectName))+'\',\''+$.trim(data[i].qtnCode)+-+$.trim(data[i].qtnNo)+'\',\''+encodeURIComponent($.trim(data[i].seName))+'\',\''+showUpdateBtn+'\')> Reminder </button>' 
						 output += ' <div id="innerday'+$.trim(data[i].cqhSysId)+'" class="cen_icon" onclick="showRemindersForQtn(event,\''+$.trim(data[i].qtnCode)+-+$.trim(data[i].qtnNo)+'\');"> '     	
						 if($.trim(data[i].reminderCount) > 0){ 
							 output += '  <i class="fa fa-2x fa-clock-o"></i>';
						    }
						 output +=  '</div>';
					 	  //}
						 output +=  ' </td>';
			       	  output += '</tr>';
					 } ; 
					 
				}	
				 $("#s2CntDiv").html(formatNumber(Math.round(totalAmount))); 
			 } else {
				 if(data && $.trim(data) == ''){
					 output += '<table id="stage1_detail_tbl" class="table1 table-bordered table-hover small">';
				}else{
					output += '<table id="stage1_detail_tbl" class="table table-bordered table-hover small">';
				}
				 
				 output += '<thead>'+       		
		 			'<tr>	'+	        			 
		 			'<th>Sales Eng.</th><th>Qtn Dt.</th><th>Qtn Code-No</th><th>Customer</th><th width="20%">Project</th><th>Consultant</th><th>Amount</th><th>Status</th><th>Focus List</th><th>Remarks</th>'+	
		 			'<th>Follow-Up & Remarks</th><th width="120px">Update Stage</th><th>Reminder</th>'+      
		 			'</tr></thead><tbody>'; 
				 if(data){
					 stage23List = data; 
					 var totalAmount = 0;remindersCount = 1;
					 for(var i in data) {
					const showUpdateBtn = (getSalesEngineerDetails(data[i].seCode)[0].salesman_emp_code === loggedEmp) ? true : false; 
					  output += '<tr  id="'+$.trim(data[i].cqhSysId)+'"><td>'+$.trim(data[i].seCode)+'-'+$.trim(data[i].seName)+'</td>'+	 
					 '<td>'+$.trim(data[i].qtnDt.substring(0, 10)).split("-").reverse().join("/")+'</td>'+	
					 '<td>'+$.trim(data[i].qtnCode)+'-'+$.trim(data[i].qtnNo)+'</td>'+
					// '<td>'+$.trim(data[i].consultWin)+'%</td>'+
					 //'<td>'+$.trim(data[i].contractorWin)+'%</td>'+
					 //'<td>'+$.trim(data[i].totalWin)+'%</td>';
					// output +=  '<td>'+$.trim(data[i].sewinper);	
// 					 if($.trim(data[i].sewinper) !== '')
// 						 output += '% <br/>';
// 						 if(showUpdateBtn){   
// 							 output += '<input type="radio" id="SEWIN'+$.trim(data[i].cqhSysId)+'"onclick=openLostHoldStg3Window(event,\''+$.trim(data[i].cqhSysId)+'\',\''+$.trim(data[i].qtnCode)+'\',\''+$.trim(data[i].qtnNo)+'\',\'SEWIN\',\''+$.trim(data[i].qtnDt.substring(0, 10)).split("-").reverse().join("/")+'\',\''+$.trim(data[i].seCode)+'\',\'2\')>';
// 						 }
// 					 output +=  ' </td>'+
					 '<td>'+$.trim(data[i].custName)+'</td>'+
					 '<td>'+$.trim(data[i].projectName)+'</td>'+
					 '<td>'+$.trim(data[i].consultant)+'</td>'+
					 '<td  align ="right">'+formatNumber(Math.round(data[i].qtnAmount))+'</td>'+					 
					 '<td id="status'+$.trim(data[i].cqhSysId)+'">'+$.trim(data[i].status)+'</td>'+
					 '<td id="priority'+$.trim(data[i].cqhSysId)+'">'+$.trim(data[i].priority)+'</td>'+
					 '<td id="remarks'+$.trim(data[i].cqhSysId)+'">'+$.trim(data[i].remarks)+'</td>';
					 totalAmount = totalAmount+Math.round(data[i].qtnAmount);
					
					 if(showUpdateBtn){   
						 output += '<td><button class="btn btn-xs btn-danger" id="'+$.trim(data[i].cqhSysId)+'" onclick=openRequestWindow({seCode:\''+$.trim(data[i].seCode)+'\',row:'+i+',id:'+$.trim(data[i].cqhSysId)+',event})>Update</button></td>';
					 }else{
						 const updatedOn = ($.trim(data[i].updatedOn)) ? $.trim(data[i].updatedOn.substring(0, 10)).split("-").reverse().join("/") : '-';
						 output += '<td>'+updatedOn+'</td>'
						 } 
					 output +=  ' <td>';
					 if(showUpdateBtn){  
					 output += '<label style="color:orange;text-transform: uppercase;"> <input type="radio" name="lostorhold" id="stg1'+$.trim(data[i].cqhSysId)+'" onClick=moveToStage2(event,\''+$.trim(data[i].cqhSysId)+'\')>Move to Stage-2'	 		 
			 		  			'</label>';
					 } 
					 output +=  ' </td>';
					 output +=  ' <td>';
					// if(showUpdateBtn){   
						 output += ' <button class="btn btn-xs btn-success"  name="reminders" id="R'+$.trim(data[i].cqhSysId)+'" onClick=openLostHoldStg3Window(event,\''+$.trim(data[i].cqhSysId)+'\',\''+$.trim(data[i].qtnCode)+'\',\''+$.trim(data[i].qtnNo)+'\',\'R\',\''+$.trim(data[i].qtnDt.substring(0, 10)).split("-").reverse().join("/")+'\',\''+$.trim(data[i].seCode)+'\',\''+encodeURIComponent($.trim(data[i].projectName))+'\',\''+$.trim(data[i].qtnCode)+-+$.trim(data[i].qtnNo)+'\',\''+encodeURIComponent($.trim(data[i].seName))+'\',\''+showUpdateBtn+'\')> Reminder </button>' 
						 output += ' <div id="innerday'+$.trim(data[i].cqhSysId)+'" class="cen_icon" onclick="showRemindersForQtn(event,\''+$.trim(data[i].qtnCode)+-+$.trim(data[i].qtnNo)+'\');"> '     	
						 if($.trim(data[i].reminderCount) > 0){ 
							 output += '  <i class="fa fa-2x fa-clock-o"></i>';
						    }
						 output +=  '</div>';
					 	  //}
						 output +=  ' </td>';
			       	  output += '</tr>';
					 } ; 
					 
				}	
				 $("#s2CntDiv").html(formatNumber(Math.round(totalAmount))); 
			 }  
			 	output += '</tbody></table></div>'; 
			    outputReport += '</tbody></table></div>'; 
			   //avoiding two exports in the same page
			   // $("#stage_detail").html(outputReport+""+output); 
			    $("#stage_detail").html(output);
			    
			    table =	  $('#stage1_detail_tbl').DataTable({
			         dom: 'Bfrtip',
			        'paging'      : true,
			        //'lengthChange': false,
			        'searching'   : true,
			        'ordering'    : true,
			        'info'        : true,			    
			        //"dom": '<"top"if>rt<"bottom"lp><"clear">',
			        "dom": '<"top"iBf>rt<"bottom"lp><"clear">',
			        'autoWidth'   : false,
			        "pageLength"  : 15, 
			        "order": [[ 1, "desc" ]],
			       
			        "createdRow": function (row, data, dataIndex) {

			        },
			        "buttons": [
			        	 {
			                 extend: 'excelHtml5',
			                 text: '<i class="fa fa-file-excel-o" style="color: #1d4e6b; font-size: 1em;">Export</i>',
			                 filename: 'STAGE-' + details.stage + ' Followup Details  ',
			                 title: 'STAGE-' + details.stage + ' Followup Details   ',
			                 messageTop: 'The information in this file is copyright to FJ Group.',
			                 exportOptions: {
			                     format: {
			                         body: function (data, row, column, node) {
			                             //return $(node).attr('data-export');
			                        	 if (column === 11 || column === 12 || column === 13){
					  		            		if(data.startsWith("<"))
			                        		 		return;
			                        		 	else
					  		            		return data.substr(0,10);
					  		            	}
					  		            	else{
					  		                  return data;
					  		            	}
			                         }
			                     },			                    
			                     columns: ':not(:last-child):not(:nth-last-child(2)):not(:nth-last-child(3))'
			                 }
			             }
			         ]
			     });
			    
			    table =	  $('#stage_detail_tbl').DataTable({
			         dom: 'Bfrtip',
			        'paging'      : true,
			        //'lengthChange': false,
			        'searching'   : true,
			        'ordering'    : true,
			        'info'        : true,			    
			        //"dom": '<"top"if>rt<"bottom"lp><"clear">',
			        "dom": '<"top"iBf>rt<"bottom"lp><"clear">',
			        'autoWidth'   : false,
			        "pageLength"  : 15, 
			        "order": [[ 1, "desc" ]],
			       
			        "createdRow": function (row, data, dataIndex) {
			            // Loop through each column
			           //  var columnsToApplyLogic = [3, 4, 5];
			            for (var i = 0; i < 6; i++) {
			                var cell = $('td', row).eq(i);
			                var fullText = data[i];			               
			                var shortText = fullText != null ? fullText.substring(0, 10) : " ";
							
			                // Set short text for display
			               // cell.text(shortText);
							cell.text(fullText);
			                // Add a data attribute with full text for export
			                cell.attr('data-export', fullText);
			                
			             // Add mouseover event listener to show full text on hover
			               
			                cell.attr('title', fullText);
			            }
			            for (var i = 7; i < 10; i++) {
			                var cell = $('td', row).eq(i);
			                var fullText = data[i];			               
			                var shortText = fullText != null ? fullText.substring(0, 10) : " ";
							
			                // Set short text for display
			                //cell.text(shortText);
							cell.text(fullText);
			                // Add a data attribute with full text for export
			                cell.attr('data-export', fullText);
			                
			             // Add mouseover event listener to show full text on hover
			               
			                cell.attr('title', fullText);
			            }
			            for (var i = 11; i < 13; i++) {
			                var cell = $('td', row).eq(i);
			                var fullText = data[i];			               
			                var shortText = fullText != null ? fullText.substring(0, 10) : " ";
							
			                // Set short text for display
			                //cell.text(shortText);
							cell.text(fullText);
			                // Add a data attribute with full text for export
			                cell.attr('data-export', fullText);
			                
			             // Add mouseover event listener to show full text on hover
			               
			                cell.attr('title', fullText);
			            }
			        },
			        "buttons": [
			        	 {
			                 extend: 'excelHtml5',
			                 text: '<i class="fa fa-file-excel-o" style="color: #1d4e6b; font-size: 1em;">Export</i>',
			                 filename: 'STAGE-' + details.stage + ' Followup Details  ',
			                 title: 'STAGE-' + details.stage + ' Followup Details   ',
			                 messageTop: 'The information in this file is copyright to FJ Group.',
			                 exportOptions: {
			                     format: {
			                         body: function (data, row, column, node) {
			                             //return $(node).attr('data-export');
			                        	 if( column === 6){
			                        		 	if(data.startsWith("<"))
			                        		 		return;
			                        		 	else
					  		            		return data.substr(0,3);
					  		            	}else if (column === 10){
					  		            		var hiddenInputValue = $(node).find('input[type="hidden"]').val();					  		            		
					                             return hiddenInputValue || '';	
					  		            	}else if (column === 14 || column === 15 || column === 16){
					  		            		if(data.startsWith("<"))
			                        		 		return;
			                        		 	else
					  		            		return data.substr(0,10);
					  		            	}
					  		            	else{
					  		                  return data;
					  		            	}
			                         }
			                     },			                    
			                     columns: ':not(:last-child):not(:nth-last-child(2)):not(:nth-last-child(3)):not(:nth-last-child(4))'
			                 }
			             }
			         ]
			     });
			    table =	  $('#stage_detail_tbl3').DataTable({
			         dom: 'Bfrtip',
			        'paging'      : true,
			        //'lengthChange': false,
			        'searching'   : true,
			        'ordering'    : true,
			        'info'        : true,			    
			        //"dom": '<"top"if>rt<"bottom"lp><"clear">',
			        "dom": '<"top"iBf>rt<"bottom"lp><"clear">',
			        'autoWidth'   : false,
			        "pageLength"  : 15, 
			        "order": [[ 1, "desc" ]],
			       
			        "createdRow": function (row, data, dataIndex) {
			            // Loop through each column
			           //  var columnsToApplyLogic = [3, 4, 5];
			            for (var i = 0; i < 6; i++) {
			                var cell = $('td', row).eq(i);
			                var fullText = data[i];			               
			                var shortText = fullText != null ? fullText.substring(0, 10) : " ";
							
			                // Set short text for display
			               // cell.text(shortText);
							cell.text(fullText);
			                // Add a data attribute with full text for export
			                cell.attr('data-export', fullText);
			                
			             // Add mouseover event listener to show full text on hover
			               
			                cell.attr('title', fullText);
			            }
			            for (var i = 7; i < 12; i++) {
			                var cell = $('td', row).eq(i);
			                var fullText = data[i];			               
			                var shortText = fullText != null ? fullText.substring(0, 10) : " ";
							
			                // Set short text for display
			                //cell.text(shortText);
			                cell.text(fullText);
			                // Add a data attribute with full text for export
			                cell.attr('data-export', fullText);
			                
			             // Add mouseover event listener to show full text on hover
			               
			                cell.attr('title', fullText);
			            }
			        },
			        "buttons": [
			        	 {
			                 extend: 'excelHtml5',
			                 text: '<i class="fa fa-file-excel-o" style="color: #1d4e6b; font-size: 1em;">Export</i>',
			                 filename: 'STAGE-' + details.stage + ' Followup Details  ',
			                 title: 'STAGE-' + details.stage + ' Followup Details   ',
			                 messageTop: 'The information in this file is copyright to FJ Group.',
			                 exportOptions: {
			                     format: {
			                         body: function (data, row, column, node) {
			                             //return $(node).attr('data-export');
			                        	 if( column === 6 ){
			                        		 	if(data.startsWith("<"))
			                        		 		return;
			                        		 	else
					  		            		return data.substr(0,3);
					  		            	}else if (column === 14 || column === 15 || column === 16){
					  		            		if(data.startsWith("<"))
			                        		 		return;
			                        		 	else
					  		            		return data.substr(0,10);
					  		            	}
					  		            	else{
					  		                  return data;
					  		            	}
			                         }
			                     },			                    
			                     columns: ':not(:last-child):not(:nth-last-child(2)):not(:nth-last-child(3))'
			                 }
			             }
			         ]
			     });
				  $('#stage_detail_report').DataTable({
			         dom: 'B', 
			         'paging'      : true,
				     //'lengthChange': false,
				     'searching'   : false,
				     'ordering'    : false,
				     'info'        : false,
				     'autoWidth'   : false,
			        "buttons"     : [{  
			      	  			extend: 'excelHtml5', 
			      	  			text:'<i class="fa fa-file-excel-o" style="color: #009688; font-size: 1em;">Export Full Report</i>',
			  		      		filename: 'STAGE-'+details.stage+' Followup Details - Full Report',
			  		      		title: 'STAGE-'+details.stage+' Followup Details - Full Report', 
			  		      		messageTop: 'The information in this file is copyright to FJ Group.', 
			  		     		exportOptions: { columns: ':not(:last-child)', }
			      	  	          }] , 
			      	  	      initComplete: function() {
			      	  	      $('table.dataTable').hide();
			      	  	    }
			      });
			  table =	  $('#stage_detail_tbl4').DataTable({
					  dom: 'Bfrtip',
			        'paging'      : true,
			        'searching'   : true,
			        'ordering'    : true,
			        'info'        : true,
			        "dom": '<"top"iBf>rt<"bottom"lp><"clear">',
			        'autoWidth'   : false,
			        "pageLength"  : 15, 
			        "order": [[ 1, "desc" ]],
				        "buttons"     : [{  
				      	  			extend: 'excelHtml5', 
				      	  			text:'<i class="fa fa-file-excel-o" style="color: #1d4e6b; font-size: 1em;">Export</i>',
				  		      		filename: 'STAGE-'+details.stage+' Followup Details  ',
				  		      		title: 'STAGE-'+details.stage+' Followup Details   ', 
				  		      		messageTop: 'The information in this file is copyright to FJ Group.', 
				  		     		exportOptions: { columns: ':not(:last-child):not(:nth-last-child(2)):not(:nth-last-child(3))', }
				      	  	          }] ,    
				      });
				 
	},error:function(data,status,er) {
		 $('#laoding').hide(); 
		$("#stage_detail").html("Something went wrong..!, Please try logout and login again");  }}); 
	 						
}
 
function closeRequestWindow(){	   
    const msgbox = document.getElementById("requestWindow");
    const reasonbox = document.getElementById("reasonbox");  	    		    
    reasonbox.style.display="none";
    msgbox.style.display="none"; 
    selectedId = "";
    selectedRow = -1;
    selectedSeCode = "";
} 
 
function updateStage(details){  
	if ((confirm('Are You sure, You Want to update this details!'))) {
		$('#laoding').show(); 
		$.ajax({
		   	 	type: _method,
			 	url: _url, 
		   		data: {action: "updateStage", id:details.id, seCode:details.seCode, stage:details.stage, status:details.status, priority:details.priority, remarks:details.remarks  },
		   		dataType: "json",
		   		success: function(data) {	
		   			$('#laoding').hide();
				 const remarks =  document.getElementById("remarks"); 
				 const title = document.getElementById("reasonheading");
				 const reasonBox = document.getElementById("reasonbox");  
				 remarks.value = "";
				 reasonBox.style.display ="none";
				// title.innerHTML="<strong>Proceesing, Please wait..</strong>";				 
				 if(parseInt(data)=== 1){ 
					 document.getElementById(details.id).disabled = true; 
					 //title.innerHTML="<strong>Completed!</strong>";					
					 document.getElementById("status" + details.id).innerHTML = details.status;	
					 if(details.priority)
						 document.getElementById("priority"+details.id).innerHTML = details.priority;
					 if(details.remarks)
						 document.getElementById("remarks"+details.id+"").innerHTML = details.remarks;
					 return true;					 
				 }else{					 
					 title.innerHTML="<strong>Something went wrong, Please try later</strong>";
				 }
				},error:function(data,status,er) {
				$('#laoding').hide();
				alert("please click again");
				return false;
				}
			}); 
	} else{
		$('#laoding').hide();
		return false;}    	
}
function updateShortClose(sysId){
	if ((confirm('Are You sure, You Want to close this Sales Order!'))) {
		$('#laoding').show(); 
		title = document.getElementById("shortc"+sysId);	
		$.ajax({
		   	 	type: _method,
			 	url: _url, 
		   		data: {action: "updateShortClose", id:sysId},
		   		dataType: "json",
		   		success: function(data) {	
		   			$('#laoding').hide();
				 title.innerHTML="<strong>Proceesing, Please wait..</strong>";				 
				 if(parseInt(data)=== 1){ 
					 document.getElementById("SC"+sysId).disabled = true;
					 title.innerHTML="<strong>Completed!Please refresh the page</strong>";					  
					 return true;					 
				 }else{					 
					 title.innerHTML="<strong>Something went wrong, Please try later</strong>";
				 }
				},error:function(data,status,er) {
				$('#laoding').hide();
				alert("please click again");
				return false;
				}
			}); 
	} else{
		$('#laoding').hide();
		return false;}    	
}
function moveToStage1(event,sysId){
	document.getElementById("stg1"+sysId).checked = true;
	if ((confirm('Are You sure, do you Want to move this Quotation to Stage1?'))) {		
		var topDimn = ''+event.clientY-60+'px';
		$.ajax({
		   	 	type: _method,
			 	url: _url, 
		   		data: {action: "movetoStage1", id:sysId},
		   		dataType: "json",
		   		success: function(data) {	
		   			$('#laoding').hide();						 
				 if(parseInt(data)=== 1){
					 document.getElementById("stg1"+sysId).disabled = true;	
					 const title = document.getElementById("stage1reasonheading");
					 $("#stage1requestWindow").css( {background:'#795548', opacity: 1,  display:'block', position:'absolute', top: topDimn, right:'6%'});
					 document.getElementById(sysId).remove();					
									
					 $('#stage_detail_tbl').DataTable().row('#'+sysId).remove().draw(false);
					 title.innerHTML="<strong>Completed!</strong>";		
					 return true;					 
				 }else{					 
					// alert("Something went wrong, Please try later");
				 }
				},error:function(data,status,er) {
				$('#laoding').hide();
				alert("please click again");
				return false;
				}
			}); 
	} else{
		$('#laoding').hide();
		document.getElementById("stg1"+sysId).checked = false;
		return false;}    	
}
function updateIsApprovedYN(event,sysId,segSalesCode){
	var approvalstatus = document.querySelector('input[name="isapproved'+sysId + '"]:checked').value;			
		var topDimn = ''+event.clientY-60+'px';
		$.ajax({
		   	 	type: _method,
			 	url: _url, 
		   		data: {action: "isapprovedyn", id:sysId,sesaledcode:segSalesCode,approvalStatus:approvalstatus},
		   		dataType: "json",
		   		success: function(data) {	
		   			$('#laoding').hide();						 
				 if(parseInt(data)=== 1){
					 var table = $('#stage_detail_tbl').DataTable();
		                var row = table.row('#' + sysId);
		                var cell = row.node().querySelector('td input[type="hidden"]');
		                $(cell).val(approvalstatus);
						alert("Updated!!");
					 return true;					 
				 }else{					 
					// alert("Something went wrong, Please try later");
				 }
				},error:function(data,status,er) {
				$('#laoding').hide();
				alert("please click again");
				return false;
				}
			}); 
	  	
}
function moveToStage2(event,sysId){
	if ((confirm('Are You sure, do you Want to move this Quotation to Stage2?'))) {
		$('#laoding').show(); 
		var topDimn = ''+event.clientY-60+'px';
		$.ajax({
		   	 	type: _method,
			 	url: _url, 
		   		data: {action: "movetoStage2", id:sysId},
		   		dataType: "json",
		   		success: function(data) {	
		   			$('#laoding').hide();						 
				 if(parseInt(data)=== 1){
					 document.getElementById("stg1"+sysId).disabled = true;	
					 const title = document.getElementById("stage1reasonheading");
					 $("#stage1requestWindow").css( {background:'#795548', opacity: 1,  display:'block', position:'absolute', top: topDimn, right:'6%'});
					 document.getElementById(sysId).remove();
					 $('#stage_detail_tbl').DataTable().row('#'+sysId).remove().draw(false);
					 title.innerHTML="<strong>Completed!!</strong>";		
					 return true;					 
				 }else{					 
					// alert("Something went wrong, Please try later");
				 }
				},error:function(data,status,er) {
				$('#laoding').hide();
				alert("please click again");
				return false;
				}
			}); 
	} else{
		$('#laoding').hide();
		return false;}    	
}
function createDiv() {
    // Create a new div element
    const newDiv = document.createElement('div');
    // Set the id and class attributes
    newDiv.id = 'stg1reasonheading';
    newDiv.className = 'stg3reasonheading';
    // Optionally, set the inner content
    newDiv.innerHTML = 'Updated!! Please refresh the page..';
    // Append the new div to the body or any other container
    document.body.appendChild(newDiv);
}
function getSalesEngineerDetails(targetSalesCode){
	return seList.filter(item => item.salesman_code == targetSalesCode);
}
function openRequestWindow(data){	 
	if(data.event.target.id == data.id){ 
		        selectedSeCode = data.seCode;
		        selectedRow = data.row;
				selectedId = data.event.target.id; 
				const singleFilteredRowItem = stage23List.filter(item=> selectedId === item.cqhSysId)[0]
				const status = checkValue(singleFilteredRowItem.status);
				const priority = checkValue(singleFilteredRowItem.priority);
			 	const remarks = checkValue(singleFilteredRowItem.remarks);
				var topDimn = ''+data.event.clientY-60+'px';
				var msgbox = document.getElementById("requestWindow");
				var reasonbox = document.getElementById("reasonbox");
				if(msgbox ==null) return;
				document.getElementById("remarks").value = remarks;
				var heading = document.getElementById("reasonheading");
			    heading.innerHTML="Stage-"+selectedStage+" followup";
				$("#requestWindow").css( {background:'#795548', opacity: 1,  display:'block', position:'absolute', top: topDimn, right:'6%'});	
			    $("#reasonbox").css( {display:'block'});	
			    setFilterSelectorSub(selectedStage, "statusUpdt", status, 'Status');
			    setFilterSelectorSub(selectedStage,"priorityUpdt", priority, 'Priority');
				
			//	document.getElementById("remarks").value =''+table.cell({row:data.row, column:9}).data()+'' ; 
	}   
}
function checkValue(value){
	if(typeof value === 'undefined' || value == 'undefined' || value === null || value === '' || value == ''){
		return "";
	}else{return value;}
}
function Apply(action){
	 action.preventDefault(); 
	 const data = { row:selectedRow, id: selectedId , "stage":$.trim(selectedStage),"status":$.trim($('#statusUpdt').val()), "priority":$.trim($('#priorityUpdt').val()), remarks: $.trim($('#remarks').val()), seCode: selectedSeCode }
	if(data.status){ updateStage(data);} else{
		  alert("Please select a status");
	} 
}
function updatePriority(action) {
    action.preventDefault();
    const data = {
        row: selectedRow,
        id: selectedId,
        priority: $.trim($('#priorityUpdt').val()),
        seCode: selectedSeCode
    };

    updateStage(data);
}
function setAttributes(el, attrs) {
	  for(var key in attrs) {
	    el.setAttribute(key, attrs[key]);
	  }
	} 
function setFilterSelectorsMain(stage){
	 const container = document.getElementById('filters');
	 container.innerHTML = "";  
	const filters = [];
	filterList.filter(s => s.stage == stage).map( item =>{
		if(!filters.includes(item.filter)) filters.push(item.filter);
	});
	if(filters.length > 0){
		filters.map( item =>{
			  const mainDiv = document.createElement('div');  
			  const subDiv = document.createElement('div');  
			  const label = document.createElement('label'); 
			  const select = document.createElement('select');
			  setAttributes(mainDiv, { "class":"fltr-slct"});
			  setAttributes(subDiv, { "class":"form-group"});
			  setAttributes(label, { "style":"font-size:80%"});
			  setAttributes(select, {"id": item, "style":"font-size:10px", "class":"form-control form-control-sm filter fltr-select-data"});
			  setAttributes(select, { "onchange":"selectAndSetFilterOptions(event)"});
			  label.innerText = item;
			  select.options.length = 0;
			  select.options[select.options.length] = new Option('Select', '');  
			  filterList.filter(s => (s.stage == stage && s.filter == item )).map( fltrd => {  
					const selected = (fltrd.status === selectedStatus) ? true : ''; 
					select.options[select.options.length] = new Option(fltrd.status , fltrd.status, false ,selected);
				});   
			  subDiv.appendChild(label);
			  subDiv.appendChild(select);
			  mainDiv.appendChild(subDiv);  
			  container.appendChild(mainDiv); 
		}); 
		 if(stage == 2){
			 setFilterRemarksHTML(container);
		  }
		  if(stage == 4){
			  //setFilterMonthHTML(container);
			  //setFilterYearHTML(container);
			 
		  }
		  setFilterAmountGreaterThanHTML(container);
		  
	}
	if(stage == 4){
		  setFilterAmountGreaterThanHTML(container);
	  }
	
	
}
function setFilterRemarksHTML(container){
	 const mainDiv = document.createElement('div');  
	  const subDiv = document.createElement('div');  
	  const label = document.createElement('label'); 
	  const select = document.createElement('input');
	  setAttributes(label, { "style":"font-size:80%"});
	  setAttributes(mainDiv, { "class":"fltr-slct"});
	  setAttributes(subDiv, { "class":"form-group"});
	  setAttributes(select, {"id": 'searchremarks',"name":"searchremarks","type": "text", "style":"font-size:10px","class":"form-control form-control-sm filter fltr-select-data"});	 
	  label.innerText = "Remarks";	  
	  subDiv.appendChild(label);
	  subDiv.appendChild(select);
	  mainDiv.appendChild(subDiv);  
	  container.appendChild(mainDiv); 
}
function setFilterAmountGreaterThanHTML(container) {
    const mainDiv = document.createElement('div');
    const subDiv = document.createElement('div');
    const label = document.createElement('label');   
    const select = document.createElement('input'); 
    setAttributes(label, { "style":"font-size:80%"});
	setAttributes(mainDiv, { "class":"fltr-slct"});
	setAttributes(subDiv, { "class":"form-group"});
	setAttributes(select, {"id": 'amountgreaterthan',"name":"amountgreaterthan","type": "text", "style":"font-size:10px","class":"form-control form-control-sm filter fltr-select-data"});	 
	//setAttributes(select, { "onkeydown":"checkForNumberValidation(event)"});
	label.innerText = "Amount >= ";	  
    subDiv.appendChild(label);   
    subDiv.appendChild(select);
    mainDiv.appendChild(subDiv);
    container.appendChild(mainDiv);
}
function setFilterMonthHTML(container){
	 const mainDiv = document.createElement('div');  
	  const subDiv = document.createElement('div');  
	  const label = document.createElement('label'); 
	  const select = document.createElement('select');
	  setAttributes(mainDiv, { "class":"fltr-slct"});
	  setAttributes(subDiv, { "class":"form-group"});
	  setAttributes(label, { "style":"font-size:80%"});
	  setAttributes(select, {"id": 'month', "style":"font-size:10px" , "class":"form-control form-control-sm filter fltr-select-data"});
	  setAttributes(select, { "onchange":"selectAndSetFilterOptions(event)"});
	  label.innerText = "ETA Month";
	  select.options.length = 0;
	  select.options[select.options.length] = new Option('Select', '');  
	  months.map( mth => {  
			const selected = (mth.value === selectedStatus) ? true : ''; 
			select.options[select.options.length] = new Option(mth.month , mth.value, false ,selected);
		});   
	  subDiv.appendChild(label);
	  subDiv.appendChild(select);
	  mainDiv.appendChild(subDiv);  
	  container.appendChild(mainDiv); 
}
function setFilterYearHTML(container){
	 const mainDiv = document.createElement('div');  
	  const subDiv = document.createElement('div');  
	  const label = document.createElement('label'); 
	  const select = document.createElement('select');
	  setAttributes(mainDiv, { "class":"fltr-slct"});
	  setAttributes(subDiv, { "class":"form-group"});
	  setAttributes(label, { "style":"font-size:80%"});
	  setAttributes(select, {"id": 'year', "style":"font-size:11px", "class":"form-control form-control-sm filter fltr-select-data"});
	  setAttributes(select, { "onchange":"selectAndSetFilterOptions(event)"});
	  label.innerText = "Year";
	  select.options.length = 0;
	  select.options[select.options.length] = new Option('Select', '');  
	  years.map( yr => {  
			const selected = (yr === selectedStatus) ? true : ''; 
			select.options[select.options.length] = new Option(yr , yr, false ,selected);
		});   
	  subDiv.appendChild(label);
	  subDiv.appendChild(select);
	  mainDiv.appendChild(subDiv);  
	  container.appendChild(mainDiv); 
}

function setFilterSelectorSub(stage, id, selectedFilter, filter){ 
	var select = document.getElementById(id);
	select.options.length = 0;
	select.options[select.options.length] = new Option('Select', ''); 
	filterList.filter(s => s.stage == stage && s.filter === filter).map(item=> {  
		const selected = (item.status === selectedFilter) ? true : ''; 
		select.options[select.options.length] = new Option(item.status , item.status, false ,selected);
	});   
} 

function formatNumber(num) {
	 if(typeof num !== 'undefined' && num !== '' && num != null){
		 return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
	 }else{ return 0;}
	
	 }
function checkForNumberValidation(event){
	var stg3aount = event.target.value;	
	if(/^[0-9-]*$/.test(stg3aount) == false){
		alert("Please enter only numbers in Amount ");
	    return false;
	}else{
		return true;
	}
}
function openLostHoldStg3Window(event,  id, qtnCode, qtnNo, type, qtanDate,segSalesCode,projectname,qtncodeNo,seName,showbutton){
	  qtnId = id,qtCode = qtnCode,qtNo = qtnNo;
	
	  document.getElementById("segsalescode").value = segSalesCode;
	  document.getElementById("segsalesname").value = seName;
	  document.getElementById("showButton").value = showbutton;
	 
	  if(type === 'L'){    
			    var topDimn = ''+event.clientY-60+'px';
			    var msgbox = document.getElementById("lostWindow");
			    var reasonbox = document.getElementById("lostreasonbox");
			    if(msgbox ==null) return;
			    document.getElementById("thereason").value="";
			    var heading = document.getElementById("lostreasonheading");
			    heading.innerHTML="Submit Qtn. Lost Reason - "+qtnCode+"-"+qtnNo;
			    $("#lostWindow").css( {background:'#795548', opacity: 1,  display:'block', position:'absolute', top: topDimn, right:'6%'});	
			    $("#holdrequestWindow").css( {background:'#795548', opacity: 1,  display:'none', position:'absolute', top: topDimn, right:'6%'});	
			    $("#lostreasonbox").css( {display:'block'});	
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
		    $("#lostreasonbox").css( {display:'none'});	
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
		    $("#lostreasonbox").css( {display:'none'});	
		    $("#holdreasonbox").css( {display:'none'});	
		    $("#stg3reasonbox").css( {display:'block'});	
		    
		  //updateNotLostStatus(id, qtnCode, qtnNo, type);  
	  }else if(type === 'LOIL'){    
		    var topDimn = ''+event.clientY-60+'px';
		    var msgbox = document.getElementById("loilostWindow");
		    var reasonbox = document.getElementById("loilostreasonbox");
		    if(msgbox ==null) return;
		    document.getElementById("thereason").value="";
		    var heading = document.getElementById("loilostreasonheading");
		    heading.innerHTML="Submit Qtn. Lost Reason - "+qtnCode+"-"+qtnNo;
		    $("#loilostWindow").css( {background:'#795548', opacity: 1,  display:'block', position:'absolute', top: topDimn, right:'6%'});	
		    $("#loiholdrequestWindow").css( {background:'#795548', opacity: 1,  display:'none', position:'absolute', top: topDimn, right:'6%'});	
		    $("#loilostreasonbox").css( {display:'block'});	
		    $("#loiholdreasonbox").css( {display:'none'});	
		   
     }else if(type === 'LOINL'){
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
		    var msgbox = document.getElementById("loiholdrequestWindow");
		    var reasonbox = document.getElementById("loiholdreasonbox");
		    if(msgbox ==null) return;
		    document.getElementById("loitheholdreason").value="";
		    var heading = document.getElementById("loiholdreasonheading");
		    heading.innerHTML="Submit Qtn. Hold Reason - "+qtnCode+"-"+qtnNo;
		    $("#loiholdrequestWindow").css( {background:'#795548', opacity: 1,  display:'block', position:'absolute', top: topDimn, right:'6%'});	
		    $("#loilostreasonbox").css( {display:'none'});	
		   // $("#stg3reasonbox").css( {display:'none'});	
		    $("#loiholdreasonbox").css( {display:'block'});	
		    
		  //updateNotLostStatus(id, qtnCode, qtnNo, type);  
	  }else if(type === 'PO'){			  
		    var topDimn = ''+event.clientY-100+'px';
		    var msgbox = document.getElementById("poUpdaterequestWindow");
		    var reasonbox = document.getElementById("poUpdatereasonbox");
		    if(msgbox ==null) return;
		    document.getElementById("datepicker-14").value="";
		    var heading = document.getElementById("poUpdatereasonheading");
		    heading.innerHTML="PO Update - "+qtnCode+"-"+qtnNo;
		    $("#poUpdaterequestWindow").css( {background:'#795548', opacity: 1,  display:'block', position:'absolute', top: topDimn, right:'20%'});
		    $("#poUpdatereasonbox").css( {display:'block'});	
		    
		  //updateNotLostStatus(id, qtnCode, qtnNo, type);  
	  }else if(type === 'ExpLOI'){		  
		    var topDimn = ''+event.clientY-100+'px';
		    var msgbox = document.getElementById("expLOIDateUpdaterequestWindow");
		    var reasonbox = document.getElementById("expLOIUpdatereasonbox");
		    if(msgbox ==null) return;		    
		    document.getElementById("datepicker-17").value="";
		    var heading = document.getElementById("expLOIUpdatereasonheading");
		    heading.innerHTML="Exp LOI Update - "+qtnCode+"-"+qtnNo;
		    $("#expLOIDateUpdaterequestWindow").css( {background:'#795548', opacity: 1,  display:'block', position:'absolute', top: topDimn, right:'20%'});
		    $("#expLOIUpdatereasonbox").css( {display:'block'});	
		    
		  //updateNotLostStatus(id, qtnCode, qtnNo, type);  
	  }else if(type === 'ExpOD'){		  
		    var topDimn = ''+event.clientY-100+'px';
		    var msgbox = document.getElementById("expOrderDateUpdaterequestWindow");
		    var reasonbox = document.getElementById("expOrderDateUpdatereasonbox");
		    if(msgbox ==null) return;		    
		    document.getElementById("datepicker-18").value="";
		    var heading = document.getElementById("expOrderDateUpdatereasonheading");
		    heading.innerHTML="Exp Order Date - "+qtnCode+"-"+qtnNo;
		    $("#expOrderDateUpdaterequestWindow").css( {background:'#795548', opacity: 1,  display:'block', position:'absolute', top: topDimn, right:'20%'});
		    $("#expOrderDateUpdatereasonbox").css( {display:'block'});	
		    
		  //updateNotLostStatus(id, qtnCode, qtnNo, type);  
	  }else if(type === 'ExpBD'){		  
		    var topDimn = ''+event.clientY-100+'px';
		    var msgbox = document.getElementById("expBillingDateUpdaterequestWindow");
		    var reasonbox = document.getElementById("expBillingDateUpdatereasonbox");
		    if(msgbox ==null) return;		    
		    document.getElementById("datepicker-19").value="";
		    var heading = document.getElementById("expBillingDateUpdatereasonheading");
		    heading.innerHTML="Exp Billing Date - "+qtnCode+"-"+qtnNo;
		    $("#expBillingDateUpdaterequestWindow").css( {background:'#795548', opacity: 1,  display:'block', position:'absolute', top: topDimn, right:'20%'});
		    $("#expBillingDateUpdatereasonbox").css( {display:'block'});	
		    
		  //updateNotLostStatus(id, qtnCode, qtnNo, type);  
	  }else if(type === 'SEWIN'){	  
		    var topDimn = ''+event.clientY-100+'px';
		    var msgbox = document.getElementById("sewinUpdaterequestWindow");
		    var reasonbox = document.getElementById("sewinUpdatereasonbox");
		    if(msgbox ==null) return;		    
		    document.getElementById("sewin").value="";
		    var heading = document.getElementById("sewinUpdatereasonheading");
		    heading.innerHTML="Chances of Winning - "+qtnCode+"-"+qtnNo;
		    $("#sewinUpdaterequestWindow").css( {background:'#795548', opacity: 1,  display:'block', position:'absolute', top: topDimn, left:'25%'});
		    $("#sewinUpdatereasonbox").css( {display:'block'});	
		    document.getElementById("stageno").value=projectname;
		    
		  //updateNotLostStatus(id, qtnCode, qtnNo, type);  
	  }else if(type === 'INV'){			  
		    var topDimn = ''+event.clientY-100+'px';
		    var msgbox = document.getElementById("invUpdaterequestWindow");
		    var reasonbox = document.getElementById("invUpdatereasonbox");
		    if(msgbox ==null) return;
		    document.getElementById("datepicker-15").value="";
		    var expPOdate = document.getElementById("po"+qtnId+"").parentElement.parentElement.innerHTML.substring(0, 10).split("-").reverse().join("/");			   
		    if(expPOdate.startsWith("<")){
		    	alert("Please enter Expected PO Date first!!");
		    	document.getElementById("inv"+qtnId).checked = false;
		    	return false;
		    }
		    $("#datepicker-15").datepicker("destroy").datepicker({ minDate: expPOdate,maxDate: '+1Y', dateFormat: 'dd/mm/yy' });
		    var heading = document.getElementById("invUpdatereasonheading");
		    heading.innerHTML="Invoice Update - "+qtnCode+"-"+qtnNo;
		    $("#invUpdaterequestWindow").css( {background:'#795548', opacity: 1,  display:'block', position:'absolute', top: topDimn, right:'20%'});
		    $("#invUpdatereasonbox").css( {display:'block'});	
		    
		  //updateNotLostStatus(id, qtnCode, qtnNo, type);  
	  }else if(type === 'R'){			  
		    var topDimn = ''+event.clientY-100+'px';
		    var msgbox = document.getElementById("reminderrequestWindow");
		    var reasonbox = document.getElementById("reminderreasonbox");
		    if(msgbox ==null) return;		    
		    document.getElementById("datepicker-16").value="";
		    document.getElementById("thereminder").value="";
		    var heading = document.getElementById("reminderreasonheading");
		    heading.innerHTML="Reminder - "+qtnCode+"-"+qtnNo;
		    $("#reminderrequestWindow").css( {background:'#795548', opacity: 1,  display:'block', position:'absolute', top: topDimn, right:'10%'});
		    $("#reminderreasonbox").css( {display:'block'});	
		    document.getElementById("projectName").value = projectname;
		    document.getElementById("qtncodeno").value = qtncodeNo;
		  //updateNotLostStatus(id, qtnCode, qtnNo, type);  
	  }else if(type === 'SS'){			  
		    var topDimn = ''+event.clientY-100+'px';		    
		    var msgbox = document.getElementById("submittalstatusrequestWindow");
		    var reasonbox = document.getElementById("submittalstatusreasonbox");
		    if(msgbox ==null) return;		    
		    document.getElementById("datepicker-14").value="";
		    var heading = document.getElementById("submittalstatusreasonheading");
		    heading.innerHTML="Submittal Status - "+qtnCode+"-"+qtnNo;
		    $("#submittalstatusrequestWindow").css( {background:'#795548', opacity: 1,  display:'block', position:'absolute', top: topDimn, right:'10%'});
		    $("#submittalstatusreasonbox").css( {display:'block'});	
		    document.getElementById("projectName").value = projectname;
		    document.getElementById("qtncodeno").value = qtncodeNo;
		  //updateNotLostStatus(id, qtnCode, qtnNo, type);  
	  }else{return;}
	  
	}
function closeLostHoldStg3RequestWindow(requestWindow,reasonbox,type){
    var msgbox = document.getElementById(requestWindow);
    var reasonbox = document.getElementById(reasonbox);
    var chqBox; 
    if(type === 'L'){
   		 chqBox = document.getElementById('L'+qtnId);   		 
   		 if(chqBox != null && !chqBox.disabled){
		    	document.getElementById('L'+qtnId).checked = false;
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
    }else if(type === 'REM'){
    	chqBox = document.getElementById('R'+qtnId);
   	 if(chqBox != null && !chqBox.disabled){
		    	document.getElementById('R'+qtnId).checked = false;
		    }	
   }else if(type === 'ExpLOI'){
   	chqBox = document.getElementById('ExpLOI'+qtnId);
  	 if(chqBox != null && !chqBox.disabled){
		    	document.getElementById('ExpLOI'+qtnId).checked = false;
		    }	
  }else if(type === 'SEWIN'){
	   	chqBox = document.getElementById('SEWIN'+qtnId);
	  	 if(chqBox != null && !chqBox.disabled){
			    	document.getElementById('SEWIN'+qtnId).checked = false;
			    }	
	  }
  else if(type === 'ExpBD'){
	   	chqBox = document.getElementById('ExpBD'+qtnId);
	  	 if(chqBox != null && !chqBox.disabled){
			    	document.getElementById('ExpBD'+qtnId).checked = false;
			    }	
	  } 
    reasonbox.style.display="none";
    msgbox.style.display="none";
    qtnId='';	      	    	    
} 
function Submit(button,thereason,rtyp,status){
	  
    var qtnDate= "";//document.getElementById("qtnnDate").value;
    
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
		}else if(rtyp === 'remrtyp'){
			 var Remdatefiled = document.getElementById('datepicker-16').value;
			 var remdesc = document.getElementById('thereminder').value;
			 var projectName = document.getElementById('projectName').value;
			 var qtncodeno = document.getElementById('qtncodeno').value;
			 if( Remdatefiled.trim().length < 1){
			    	alert("Please select Reminder Date");    	
			        return false;
			    }else if(remdesc.trim().length < 1){
			    	alert("Please enter Reminder Description");
			    	return false;
			    }else{	
			    	updateReminder(Remdatefiled,remdesc,projectName,qtncodeno);
			    	}
		}else if(rtyp === 'substatus'){
			 var reason = document.getElementById(thereason).value;
			 var type = document.getElementById(rtyp).value;			 
			    if( type.trim().length < 1){
			    	alert("Please select the reason..");    	
			        return false;
			    }else if(reason.trim().length < 1){
			    	alert("Please enter the remarks..");
			    }else{		    	
			    	updateSubmittalStatus(reason, type);
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
function Submit2(button,thereason,rtyp,status){
	  
    var qtnDate= "";//document.getElementById("qtnnDate").value;    

		   var reason = document.getElementById(thereason).value;
		   var type = document.getElementById(rtyp).value;
		    if( type.trim().length < 1){
		    	alert("Please select the reason..");    	
		        return false;
		    }else if(reason.trim().length < 1){
		    	alert("Please enter the remarks..");
		    }else{		    	
		    	updateLOILostHostStatus(reason, type,status);
		    	}	
		
	}
function updateLostStatus(reason, type,status){
	  // console.log(qtnId);
	  //if(confirm("Are you sure you want to mark this qtn. as Lost?")){	
		  var segsalescode = document.getElementById("segsalescode").value;
		 
		   	$.ajax({
		   		type: 'POST', 
		   		url: 'SipStageFollowUpController',
		   		data: {action: "lost", qtn:qtnId, rsn: reason.trim(), rtyp:type.trim(),tstuas:status,segsalescode:segsalescode},
		   		dataType: "json",
		   		success: function(data) {	
		   		 var title,reasonData,reasonBox;
		   		 if(status === 'L'){
		   			title = document.getElementById("lostreasonheading");	
		   		 	reasonData = document.getElementById("thereason");
					reasonBox =  document.getElementById("lostreasonbox");
				 }else{
					 title = document.getElementById("holdreasonheading");
					 reasonData = document.getElementById("theholdreason");
					 reasonBox =  document.getElementById("holdreasonbox");
				 }
				 			
				// title.innerHTML="<strong>Proceesing, Please wait..</strong>";	
					 if(parseInt(data)=== 1){
						 if(status === 'L'){
							 var qtnnId = "L"+qtnId;
							 reasonData.value="";
							 reasonBox.style.display ="none";
							 document.getElementById(qtnnId).checked = true;
							 document.getElementById(qtnnId).disabled = true;
							// document.getElementById("lostWindow").style.display ="none";
							// document.getElementById("status"+qtnId+"").parentElement.parentElement.innerHTML = "<span class='label label-danger bold'><span id='status"+qtnId+"'>Marked as Lost</span>";
							// qtnId='';							
							 title.innerHTML="<strong>Updated!</strong>";					  
							 return true;	
						 }else{							 
							 var qtnnId = "nL"+qtnId;							
							 reasonData.value="";
							 reasonBox.style.display ="none";								
							 document.getElementById(qtnnId).checked = true;
							 document.getElementById(qtnnId).disabled = true;
							 //document.getElementById("status"+qtnId+"").parentElement.parentElement.innerHTML = "<span class='label label-success bold'><span id='status"+qtnId+"'>Hold By SEG</span>";		
							 title.innerHTML="<strong>Updated!</strong>";		
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
function updateLOILostHostStatus(reason, type,status){
	 
		  var segsalescode = document.getElementById("segsalescode").value;
		 
		   	$.ajax({
		   		type: 'POST', 
		   		url: 'SipStageFollowUpController',
		   		data: {action: "loilost", qtn:qtnId, rsn: reason.trim(), rtyp:type.trim(),tstuas:status,segsalescode:segsalescode},
		   		dataType: "json",
		   		success: function(data) {	
		   		 var title,reasonData,reasonBox;
		   		 if(status === 'L'){
		   			title = document.getElementById("loilostreasonheading");	
		   		 	reasonData = document.getElementById("loithereason");
					reasonBox =  document.getElementById("loilostreasonbox");
				 }else{
					 title = document.getElementById("loiholdreasonheading");
					 reasonData = document.getElementById("loitheholdreason");
					 reasonBox =  document.getElementById("loiholdreasonbox");
				 }	
				
					 if(parseInt(data)=== 1){
						 if(status === 'L'){
							 var qtnnId = "nL"+qtnId;
							 reasonData.value="";
							 reasonBox.style.display ="none";
							 document.getElementById(qtnnId).checked = true;
							 document.getElementById(qtnnId).disabled = true;
							// document.getElementById("lostWindow").style.display ="none";
							// document.getElementById("status"+qtnId+"").parentElement.parentElement.innerHTML = "<span class='label label-danger bold'><span id='status"+qtnId+"'>Marked as Lost</span>";
							// qtnId='';							
							 title.innerHTML="<strong>Updated!</strong>";					  
							 return true;	
						 }else{							 
							 var qtnnId = "nL"+qtnId;							
							 reasonData.value="";
							 reasonBox.style.display ="none";								
							 document.getElementById(qtnnId).checked = true;
							 document.getElementById(qtnnId).disabled = true;
							 //document.getElementById("status"+qtnId+"").parentElement.parentElement.innerHTML = "<span class='label label-success bold'><span id='status"+qtnId+"'>Hold By SEG</span>";		
							 title.innerHTML="<strong>Updated!</strong>";		
							 return true;					 
							 }
						 
					 }else{		
						 if(status === 'L'){
							 document.getElementById(qtnId).checked = false;
							 reasonBox.style.display ="none";
							 document.getElementById("loilostWindow").style.display ="none";
						 }else{
							 document.getElementById("nL"+qtnId).checked = false;
							 reasonBox.style.display ="none";
							 document.getElementById("loiholdrequestWindow").style.display ="none";
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
	  var segsalescode = document.getElementById("segsalescode").value;
	  var typeTxt = "H";
	  var title = document.getElementById("stg3reasonheading");	
	  var reasonBox = document.getElementById("stg3reasonbox");	 
	 	
		   	$.ajax({
		   		type: 'POST', 
		   		url: 'SipStageFollowUpController',
		   		data: {action: "updateStg3", qtn:qtnId, loidate: loiDate,loiamt:loiAmount,segsalescode:segsalescode},
		   		dataType: "json",
		   		success: function(data) {	 
								 
				 if(parseInt(data)=== 1){
					 var qtnnId = "stg"+qtnId;	
					 reasonBox.style.display ="none";								
					 document.getElementById(qtnnId).checked = true;
					 document.getElementById(qtnnId).disabled = true;
					// document.getElementById("status"+qtnId+"").parentElement.parentElement.innerHTML = "<span class='label label-success bold'><span id='status"+qtnId+"'>Moved to Stage3</span>";
					document.getElementById(qtnId).remove();
					$('#stage_detail_tbl').DataTable().row('#'+qtnId).remove().draw(false);
					 title.innerHTML="<strong>Moved to Stage3!</strong>";				  
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
		  }
function updateReminder(reminderDate,remDesc,projectname,qtncodeno){
	  var segsalescode = document.getElementById("segsalescode").value;
	  var segsalesname = decodeURIComponent(document.getElementById("segsalesname").value);	
	  var title = document.getElementById("reminderreasonheading");	
	  var reasonBox = document.getElementById("reminderreasonbox");	 
	  var pjctname = decodeURIComponent(projectname);
	  var showButton = document.getElementById("showButton").value;
	  if(showButton === "true"){
		   	$.ajax({
		   		type: 'POST', 
		   		url: 'SipStageFollowUpController',
		   		data: {action: "updateReminder", qtn:qtnId, reminderdate: reminderDate,remDesc:remDesc,segsalescode:segsalescode,projectName:pjctname,qtnCodeNo:qtncodeno},
		   		dataType: "json",
		   		success: function(data) {	 
								 
				 if(parseInt(data)=== 1){
					 var qtnnId = "R"+qtnId;	
					 reasonBox.style.display ="none";								
					 document.getElementById(qtnnId).checked = true;
					 document.getElementById("datepicker-16").value="";
					 document.getElementById("thereminder").value="";
					 innerdiv = document.getElementById("innerday"+qtnId);
					 
					 //document.getElementById(qtnnId).disabled = true;
					// document.getElementById("status"+qtnId+"").parentElement.parentElement.innerHTML = "<span class='label label-success bold'><span id='status"+qtnId+"'>Moved to Stage3</span>";	
							
					 title.innerHTML="<strong>Reminder Added!</strong>";
					 $(innerdiv).html('<i class="fa fa-2x fa-clock-o"></i>');
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
	  }else{
		  if (confirm('Are You sure, You Want to send a Reminder to '+segsalesname+" ("+segsalescode+")")) {
			   	$.ajax({
			   		type: 'POST', 
			   		url: 'SipStageFollowUpController',
			   		data: {action: "updateReminder", qtn:qtnId, reminderdate: reminderDate,remDesc:remDesc,segsalescode:segsalescode,projectName:pjctname,qtnCodeNo:qtncodeno},
			   		dataType: "json",
			   		success: function(data) {	 
									 
					 if(parseInt(data)=== 1){
						 var qtnnId = "R"+qtnId;	
						 reasonBox.style.display ="none";								
						 document.getElementById(qtnnId).checked = true;
						 document.getElementById("datepicker-16").value="";
						 document.getElementById("thereminder").value="";
						 innerdiv = document.getElementById("innerday"+qtnId);
						 
						 //document.getElementById(qtnnId).disabled = true;
						// document.getElementById("status"+qtnId+"").parentElement.parentElement.innerHTML = "<span class='label label-success bold'><span id='status"+qtnId+"'>Moved to Stage3</span>";	
								
						 title.innerHTML="<strong>Reminder Added!</strong>";
						 $(innerdiv).html('<i class="fa fa-2x fa-clock-o"></i>');
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
		  }else{
			  $('#laoding').hide();
				return false;
			  }
	  }
		  
	  }
		  
		  function updateSubmittalStatus(reason,type){			
		  
			  var segsalescode = document.getElementById("segsalescode").value;	
			  var title = document.getElementById("submittalstatusreasonheading");	
			  var reasonBox = document.getElementById("submittalstatusreasonbox");
				   	$.ajax({
				   		type: 'POST', 
				   		url: 'SipStageFollowUpController',
				   		data: {action: "updateSubmittalStatus", qtn:qtnId, reasonDesc:reason,substatusType:type,segsalescode:segsalescode},
				   		dataType: "json",
				   		success: function(data) {	 
										 
						 if(parseInt(data)=== 1){
							 var qtnnId = "SS"+qtnId;	
							 reasonBox.style.display ="none";								
							 document.getElementById(qtnnId).checked = true;
							 document.getElementById("substatusremarks").value="";
							 var select = document.getElementById('substatus');
								select.options.length = 0;
								select.options[select.options.length] = new Option('Select', ''); 
								 SUBSTS_JSON.forEach(function(typeList) {
						         select.options[select.options.length] = new Option(typeList.remarkTypeDesc, typeList.remarksType);
								 });
							 innerdiv = document.getElementById("submitalstatus"+qtnId);
							 
							 //document.getElementById(qtnnId).disabled = true;
							// document.getElementById("status"+qtnId+"").parentElement.parentElement.innerHTML = "<span class='label label-success bold'><span id='status"+qtnId+"'>Moved to Stage3</span>";	
									
							 title.innerHTML="<strong>Submittal Status Added!</strong>";
							 $(innerdiv).html('<button class="btn btn-xs">Details</button>');
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
				  }
$(function () {
	 $("#datepicker-13").datepicker({minDate: new Date(<%=year%>, <%=mon%>, -1, <%=day%>), maxDate: '+1Y', dateFormat: 'dd/mm/yy',  firstDay: 0});
	 $("#datepicker-14").datepicker({minDate: 0, maxDate: '+1Y', dateFormat: 'dd/mm/yy',  firstDay: 0});	
	 $("#datepicker-16").datepicker({minDate: 1, maxDate: '+1Y', dateFormat: 'dd/mm/yy',  firstDay: 0});
	 $("#datepicker-17").datepicker({minDate: new Date(<%=year%>, <%=mon%>, -1, <%=day%>), maxDate: '+1Y', dateFormat: 'dd/mm/yy',  firstDay: 0});
	 $("#datepicker-18").datepicker({minDate: new Date(<%=year%>, <%=mon%>, -1, <%=day%>), maxDate: '+1Y', dateFormat: 'dd/mm/yy',  firstDay: 0});
	 $("#datepicker-19").datepicker({minDate: new Date(<%=year%>, <%=mon%>, -1, <%=day%>), maxDate: '+1Y', dateFormat: 'dd/mm/yy',  firstDay: 0});
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
function updatePODetails(obj,loiAmount){
	  var poDate= document.getElementById('datepicker-14').value;		
	  var title = document.getElementById("expodateheading");	
	  var reasonBox = document.getElementById("poUpdaterequestWindow");	  
	  var segsalescode = document.getElementById("segsalescode").value;
	 // var qtnCode = document.getElementById("qtnCode").value;
	 // var qtnNo = document.getElementById("qtnNo").value;
	  if(!poDate){
		  alert("Please select Expected PO date");
		  return false;
	     }
		   	$.ajax({
		   		type: 'POST', 
		   		url: 'SipStageFollowUpController',
		   		data: {action: "updatePODate", qtn:qtnId, podate: poDate,segsalescode:segsalescode},
		   		dataType: "json",
		   		success: function(data) {	 
								 
				 if(parseInt(data)=== 1){
					 reasonBox.style.display ="none";
					 document.getElementById("po"+qtnId+"").parentElement.parentElement.innerHTML = poDate+  "<label style='color:blue;'><input type='radio' name='poupdate' id='po"+qtnId+"' onClick='openLostHoldStg3Window(\"event\",\""+qtnId+"\", \""+qtCode+"\",\""+qtNo+"\",\"PO\",\"\",\""+segsalescode+"\")'>&nbsp;Update </label>";
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
function updateExpLOIDetails(obj,loiAmount){
	  var expLOIDate= document.getElementById('datepicker-17').value;		
	  var title = document.getElementById("expLOIUpdatereasonheading");	
	  var reasonBox = document.getElementById("expLOIUpdatereasonbox");	  
	  var segsalescode = document.getElementById("segsalescode").value;
	 // var qtnCode = document.getElementById("qtnCode").value;
	 // var qtnNo = document.getElementById("qtnNo").value;

		   	$.ajax({
		   		type: 'POST', 
		   		url: 'SipStageFollowUpController',
		   		data: {action: "updateExpLOIDate", qtn:qtnId, exploidate: expLOIDate,segsalescode:segsalescode},
		   		dataType: "json",
		   		success: function(data) {
				 if(parseInt(data)=== 1){
					 reasonBox.style.display ="none";
					 //document.getElementById("ExpLOI"+qtnId+"").parentElement.parentElement.innerHTML = poDate+  "<label style='color:blue;'><input type='radio' name='poupdate' id='ExpLOI"+qtnId+"' onClick='openLostHoldStg3Window(\"event\",\""+qtnId+"\", \""+qtCode+"\",\""+qtNo+"\",\"ExpLOI\",\"\",\""+segsalescode+"\")'>&nbsp;Update </label>";
					  title.innerHTML="<strong>Updated! Please refresh the page</strong>";
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
function updateExpOrderDetails(obj,loiAmount){
	  var expOrderDate= document.getElementById('datepicker-18').value;		
	  var title = document.getElementById("expOrderDateUpdatereasonheading");	
	  var reasonBox = document.getElementById("expOrderDateUpdatereasonbox");	  
	  var segsalescode = document.getElementById("segsalescode").value;
	
		   	$.ajax({
		   		type: 'POST', 
		   		url: 'SipStageFollowUpController',
		   		data: {action: "updateExpOrderDate", qtn:qtnId, exporderdate: expOrderDate,segsalescode:segsalescode},
		   		dataType: "json",
		   		success: function(data) {
				 if(parseInt(data)=== 1){
					 reasonBox.style.display ="none";
					 //document.getElementById("ExpLOI"+qtnId+"").parentElement.parentElement.innerHTML = poDate+  "<label style='color:blue;'><input type='radio' name='poupdate' id='ExpLOI"+qtnId+"' onClick='openLostHoldStg3Window(\"event\",\""+qtnId+"\", \""+qtCode+"\",\""+qtNo+"\",\"ExpLOI\",\"\",\""+segsalescode+"\")'>&nbsp;Update </label>";
					  title.innerHTML="<strong>Updated! Please refresh the page</strong>";
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
function updateExpBillingDetails(obj,loiAmount){
	  var expBillingDate= document.getElementById('datepicker-19').value;		
	  var title = document.getElementById("expBillingDateUpdatereasonheading");	
	  var reasonBox = document.getElementById("expBillingDateUpdatereasonbox");	  
	  var segsalescode = document.getElementById("segsalescode").value;
	
		   	$.ajax({
		   		type: 'POST', 
		   		url: 'SipStageFollowUpController',
		   		data: {action: "updateExpBillingDate", qtn:qtnId, expbillingdate: expBillingDate,segsalescode:segsalescode},
		   		dataType: "json",
		   		success: function(data) {
				 if(parseInt(data)=== 1){
					 reasonBox.style.display ="none";
					 //document.getElementById("ExpLOI"+qtnId+"").parentElement.parentElement.innerHTML = poDate+  "<label style='color:blue;'><input type='radio' name='poupdate' id='ExpLOI"+qtnId+"' onClick='openLostHoldStg3Window(\"event\",\""+qtnId+"\", \""+qtCode+"\",\""+qtNo+"\",\"ExpLOI\",\"\",\""+segsalescode+"\")'>&nbsp;Update </label>";
					  title.innerHTML="<strong>Updated! Please refresh the page</strong>";
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
function updateSEWin(obj,loiAmount){
	  var sewin= document.getElementById('sewin').value;		
	  var title = document.getElementById("sewinUpdatereasonheading");	
	  var reasonBox = document.getElementById("sewinUpdatereasonbox");	  
	  var requestwinddow = document.getElementById("sewinUpdaterequestWindow");
	  var segsalescode = document.getElementById("segsalescode").value;
	  var stageno  = document.getElementById("stageno").value;
	  if(sewin != null){
			if(/^[0-9-]*$/.test(sewin) == false){
				alert("Please enter only numbers in SEWIN ");
			    return false;
			}
		} 
		   	$.ajax({
		   		type: 'POST', 
		   		url: 'SipStageFollowUpController',
		   		data: {action: "updateSEWIN", qtn:qtnId, sewin: sewin,segsalescode:segsalescode,"stage":stageno},
		   		dataType: "json",
		   		success: function(data) {
				 if(parseInt(data)=== 1){
					 //requestwinddow.style.display ="none";					
					 reasonBox.style.display ="none";					 
					// document.getElementById("inv"+qtnId+"").parentElement.parentElement.innerHTML = invDate+  "<label style='color:blue;'><input type='radio' name='poupdate' id='inv"+qtnId+"' onClick='openRequestWindow(\"event\",\""+qtnId+"\", \""+qtnCode+"\",\""+qtnNo+"\",\"INV\")'>&nbsp;Update </label>";
					// return true;					 
					 // document.getElementById("SEWIN"+qtnId+"").parentElement.innerHTML = sewin+  "<input type='radio' id='SEWIN"+qtnId+"' onClick='openLostHoldStg3Window(\"event\",\""+qtnId+"\", \""+qtCode+"\",\""+qtNo+"\",\"SEWIN\",\"\",\""+segsalescode+"\")'>";
					  title.innerHTML="<strong>Updated! Please refresh the page</strong>";
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
	  var segsalescode = document.getElementById("segsalescode").value;
	  if(!invDate){
		  alert("Please select Expected Invoice date");
		  return false;
	     }
		   	$.ajax({
		   		type: 'POST', 
		   		url: 'SipStageFollowUpController',
		   		data: {action: "updateINVDate", qtn:qtnId, invdate: invDate,segsalescode:segsalescode},
		   		dataType: "json",
		   		success: function(data) {	 
								 
				 if(parseInt(data)=== 1){
					 reasonBox.style.display ="none";					 
					 document.getElementById("inv"+qtnId+"").parentElement.parentElement.innerHTML = invDate+  "<label style='color:blue;'><input type='radio' name='poupdate' id='inv"+qtnId+"' onClick='openLostHoldStg3Window(\"event\",\""+qtnId+"\", \""+qtCode+"\",\""+qtNo+"\",\"INV\",\"\",\""+segsalescode+"\")'>&nbsp;Update </label>";
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
function showRemindersForQtn(event,theQtncodeno){

	 var ttl ="Reminder Details for the Quotation "+theQtncodeno;
		var output="<table id='cvDetails_tbl'><thead><tr><th>Reminder Date</th><th>Description</th>"+
					"</tr></thead><tbody>";
	   		$.ajax({ type: 'POST', url: 'SipStageFollowUpController', 
				 data: {action: "remindersfortheqtn",theQtnCodeNo:theQtncodeno}, 
				 dataType: "json", 
			 success: function(data) {
				 for (var i in data) {  
					 output+="<tr><td>" + $.trim(data[i].visitDate.substring(0, 10)).split("-").reverse().join("/") + "</td><td>" + $.trim(data[i].actnDesc)+ "</td></tr>";
					 } 		          	
					 output+="</tbody></table>";
					 $("#cvDetails .modal-title").html(ttl);
					 $("#cvDetails .modal-body").html(output);
					 $("#cvDetails").modal("show");
				},error:function(data,status,er) {
					 e.preventDefault();
					alert("Please Log out and try again.");}
				});	
		 
	}
function showSubmittalStatusForQtn(event,theQtncodeno){

	 var ttl ="Reminder Details for the Quotation "+theQtncodeno;
		var output="<table id='cvDetails_tbl'><thead><tr><th>Reminder Date</th><th>Description</th>"+
					"</tr></thead><tbody>";
	   		$.ajax({ type: 'POST', url: 'SipStageFollowUpController', 
				 data: {action: "submittalstatusfortheqtn",theQtnCodeNo:theQtncodeno}, 
				 dataType: "json", 
			 success: function(data) {
				 for (var i in data) {
					 output+="<tr><td>" + $.trim(data[i].visitDate) + "</td><td>" + $.trim(data[i].actnDesc)+ "</td></tr>";
					 } 		          	
					 output+="</tbody></table>";
					 $("#cvDetails .modal-title").html(ttl);
					 $("#cvDetails .modal-body").html(output);
					 $("#cvDetails").modal("show");
				},error:function(data,status,er) {
					 e.preventDefault();
					alert("Please Log out and try again.");}
				});	
		 
	}
function closeWindow(divId) {
    document.getElementById(divId).style.display = 'none';
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