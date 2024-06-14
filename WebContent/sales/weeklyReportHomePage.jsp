<%-- 
    Document   : SIP JIH DUES  
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="../mainview.jsp" %>
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
.reasonheading{color:#ffffff;}.reasonbox{display:none; }
.navbar { margin-bottom: 8px !important;} 
.table{display: block !important; overflow-x:auto !important;}
.small-box h3 {font-size: 25px !important;}
.container { padding-right: 0px !important;padding-left: 0px !important;}
.wrapper{margin-top:-8px;}.text-danger {font-weight: bold; }
.main-header {z-index: 851 !important;}td.truncate {max-width:100px; /*white-space: nowrap;*/overflow: hidden;text-overflow: ellipsis;} #qtnLostTbl{color:#000000 !important;}
.label-text{color:#fff !important;}
.remove {display:none;} 
#priority, #status, #stage, .filter{    width: 122px !important; border-radius: 5% !important;   height: 30px !important;  border-color: #aaaaaa;}
.fltr-slct{float:left;margin-right: 5px;}
#stageSubmit{width:60px !important;margin-top: 25px;}
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
	                 <li><a href="DmInfo.jsp"><i class="fa fa-dashboard"></i><span>Sales Engineers Performance</span></a></li>
					 <li><a href="DisionInfo.jsp"><i class="fa fa-line-chart"></i><span>Sub Division Performance</span></a></li>
					 <li><a href="CompanyInfo.jsp?empcode=${DFLTDMCODE}"><i class="fa fa-pie-chart"></i><span>Division 	Performance</span></a></li>
					 <li><a href="SipUserActivity"><i class="fa fa-table"></i><span>SE Activity History</span></a></li>
<!-- 					 <li><a href="SipJihDues"><i class="fa fa-table"></i><span>JIH Dues</span></a></li>  -->
<!-- 					 <li><a href="SipLOIDues"><i class="fa fa-table"></i><span>LOI Dues</span></a></li> -->
					 <li><a href="SipStageFollowUpController"><i class="fa fa-database"></i><span>Stage Follow-Up</span></a></li> 
					 <li class="active"><a href="sipWeeklyReport"><i class="fa fa-bar-chart"></i><span>Weekly-Sales Report</span></a></li>  
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
					  <li><a href="SipStageFollowUpController"><i class="fa fa-database"></i><span>Stage Follow-Up</span></a></li>   
					  <li class="active"><a href="sipWeeklyReport"><i class="fa fa-bar-chart"></i><span>Weekly-Sales Report</span></a></li>
					  <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>
               </c:when>
               <c:when test="${fjtuser.sales_code ne null and empty fjtuser.subordinatelist}">
	                <li><a href="DmInfo.jsp"><i class="fa fa-dashboard"></i><span>Sales Engineers Performance</span></a></li>	               
<!-- 	                <li><a href="SipJihDues"><i class="fa fa-table"></i><span>JIH Dues</span></a></li>  -->
<!-- 	                <li><a href="SipLOIDues"><i class="fa fa-table"></i><span>LOI Dues</span></a></li>   -->
						<li><a href="ProjectStatus"><i class="fa fa fa-bars"></i><span>Project Status</span></a></li> 
	                <li><a href="SipStageFollowUpController"><i class="fa fa-database"></i><span>Stage Follow-Up</span></a></li>
	                 <li class="active"><a href="sipWeeklyReport"><i class="fa fa-bar-chart"></i><span>Weekly-Sales Report</span></a></li>
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
		<div class="content-wrapper" style="margin-top: -8px;">  
		<!-- Main content -->
		<section class="content">
		      <div class="row" id="stageFilter">
		       <form id="stageFup" action = "sipWeeklyReport">
		       <div class="col-md-12 col-xs-12">
				</div>
				<div class="col-md-2 col-xs-3">
						<div class="form-group">
							<label>Weekly Report For</label>
							<select class="form-control form-control-sm" id="stage" name="action" required>
							<option value="">Select</option>
							<option value="DV">Division</option>
							<option value="SE">Sales Engineer</option>							 
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
		      </div>
		      <div class="row"> 
		         <div class="col-xs-12" id="stage_detail"> 
		         </div>
		       </div>		       
			       <%--STAGE 4 Items End --%>
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
var _url = 'sipWeeklyReport';
var _empCode = '${fjtuser.emp_code}';
var _method = "POST"; 

  $(function () {  
	  $('.loader,.sub-laoding, #sub-laoding').hide();
	 
});


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