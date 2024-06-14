<%-- 
    Document   : SIP INVENTORY MANAGMENT  
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="mainview.jsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%
	DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	Calendar cal = Calendar.getInstance();
	int month = cal.get(Calendar.MONTH) + 1;
	int iYear = cal.get(Calendar.YEAR);
	String curr_month_name = "JANUARY";
	String currCalDtTime = dateFormat.format(cal.getTime());
	switch (month) {
		case 1 :
			curr_month_name = "Jan";
			break;
		case 2 :
			curr_month_name = "Feb";
			break;
		case 3 :
			curr_month_name = "Mar";
			break;
		case 4 :
			curr_month_name = "Apr";
			break;
		case 5 :
			curr_month_name = "May";
			break;
		case 6 :
			curr_month_name = "Jun";
			break;
		case 7 :
			curr_month_name = "Jul";
			break;
		case 8 :
			curr_month_name = "Aug";
			break;
		case 9 :
			curr_month_name = "Sep";
			break;
		case 10 :
			curr_month_name = "Oct";
			break;
		case 11 :
			curr_month_name = "Nov";
			break;
		case 12 :
			curr_month_name = "Dec";
			break;

	}
	request.setAttribute("currCal", currCalDtTime);
	request.setAttribute("MTH", month);
	request.setAttribute("CURR_YR", iYear);
	request.setAttribute("CURR_MTH", curr_month_name);
%>
<!DOCTYPE html>
<html>
<head>
<style>
  
		
</style>
        <link rel="stylesheet" href="resources/css/fjdashboard.css">
		<link rel="stylesheet" href="resources/bower_components/font-awesome/css/font-awesome.min.css">
		<!-- Theme style -->
		<link rel="stylesheet" href="resources/dist/css/AdminLTE.min.css">
		<link rel="stylesheet" href="resources/dist/css/skins/_all-skins.min.css">
		<link rel="stylesheet" type="text/css" href="resources/datatables/datatables-fjtco/css/jquery.dataTables.min.css" />
		<link rel="stylesheet" type="text/css" href="resources/datatables/buttons-fjtco/css/buttons.dataTables.min.css" />
		<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/jquery.dataTables.min.js"></script>
		<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/dataTables.buttons.min.js"></script>
		<script type="text/javascript" 	src="resources/datatables/buttons-fjtco/js/buttons.flash.min.js"></script>
		<script type="text/javascript" src="resources/datatables/ajax/excelmake/jszip.min.js"></script>
		<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.html5.min.js"></script>
		<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.print.min.js"></script>
		<link rel="stylesheet" href="resources/css/fjtimeline.css">


</head>
	<c:choose>
	<c:when test="${!empty fjtuser.emp_code and !empty fjtuser.sales_code and !empty fjtuser.subordinatelist  and fjtuser.checkValidSession eq 1}">
	<body class="hold-transition skin-blue sidebar-mini">
	<div class="container">
			<div class="wrapper">
			    <header class="main-header" style="background-color: #367fa9;">
					<!-- Logo -->
					<a href="#" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels -->
					<span class="logo-mini"><b>FJ</b>D</span> <!-- logo for regular state and mobile devices -->
					<span class="logo-lg"><b>Dashboard</b></span> </a>
					<!-- Header Navbar: style can be found in header.less -->
					<nav class="navbar navbar-static-top">
					<!-- Sidebar toggle button-->
					<a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button"> <span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span>
					<span class="icon-bar"></span> <span class="icon-bar"></span> </a>
				    </nav>
				</header>
				<!-- Left side column. contains the logo and sidebar -->
				<aside class="main-sidebar">
					<!-- sidebar: style can be found in sidebar.less -->
					<section class="sidebar">
			        <!-- sidebar menu: : style can be found in sidebar.less -->
						<ul class="sidebar-menu" data-widget="tree">
						
			 				<li><a href="DmInfo.jsp"><i class="fa fa-dashboard"></i><span>Sales Engineers Performance</span></a></li>
							<li><a href="DisionInfo.jsp"><i class="fa fa-line-chart"></i><span>Sub Division Performance</span></a></li>
							<li><a href="CompanyInfo.jsp"><i class="fa fa-pie-chart"></i><span>Division 	Performance</span></a></li>
							<li><a href="sipCustomer"><i class="fa fa-table"></i><span>Customer Performance</span></a></li>
							<!--	<li><a href="Receivables"><i class="fa fa-th"></i><span>Receivables</span></a></li>  -->
							<li class="active"><a href="InventoryAging"><i class="fa fa-edit"></i><span>Inventory Aging</span></a></li>
							<li><a href="P&LandOperatingExpenses"><i class="fa fa-book"></i><span>P&L and Operating Expenses</span></a></li>
							
			           </ul>
				   </section>
				   <!-- /.sidebar -->
			   </aside>
			   
		       <!-- Main content -->
			   <div class="content-wrapper" style="margin-top: -20px;">
						
			  <div class="row">
			  <br/>
			  <div class="col-md-12" id="div_filter">
			   <form class="form-inline" method="post" action="InventoryAging">
			   <input type="hidden" id="octjf" name="octjf" value="rtlfvid" />
			  	<div class="form-group">
				<select class="form-control form-control-sm" id="division_list" name="tslvid" required>
				<option value="${DIVDEFTITL}">Select Sub Division</option>
				<option value="dlla">All</option>
				<c:forEach var="divisions" items="${DIVLST}">
				<option value="${divisions.div_code}" ${divisions.div_code  == selected_division ? 'selected':''}>${divisions.div_desc}</option>
				</c:forEach>
				</select>
				</div>
				<div class="form-group"> <button type="submit" class="btn btn-primary" onclick="preLoader();">Refresh</button>
				</div>
				</form>
				</div>
				<!--  *******        -->
              <div class="col-md-12">
    		  <div class="box">
              <div class="box-header">
	              <h3 class="box-title">Monthly Stock values of Slow Moving only (Values)</h3>
	              <div class="box-tools pull-right">   
	              		<button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-plus"></i>  </button>
	              </div>
               </div>
               <!-- /.box-header -->
			   <div class="box-body">
			   <div style="display:inline-block;width:100%;overflow-y:auto;height: 95px;margin-top:-20px;">
					<ul class="timeline timeline-horizontal">
					<c:forEach var="slowStock" items="${MSMSL}">
						<li class="timeline-item">
							<div class="timeline-badge primary">${slowStock.month}</div>
							<div class="timeline-panel">
								<div class="timeline-heading">
									<h4 class="timeline-title"><fmt:formatNumber type="number"   pattern = "#,###.#" value="${slowStock.stock_value}" /></h4>
									
								</div>
								
							</div>
						</li>
					</c:forEach>
						<!--  <li class="timeline-item">
							<div class="timeline-badge success">FEB</div>
							<div class="timeline-panel">
								<div class="timeline-heading">
									<h4 class="timeline-title">1234567891</h4>
									
								</div>
								
							</div>
						</li>
						<li class="timeline-item">
							<div class="timeline-badge info">MAR</div>
							<div class="timeline-panel">
								<div class="timeline-heading">
									<h4 class="timeline-title">1234567891</h4>
									
								</div>
								
							</div>
						</li>
						<li class="timeline-item">
							<div class="timeline-badge danger">APR</div>
							<div class="timeline-panel">
								<div class="timeline-heading">
									<h4 class="timeline-title">1234567891</h4>
									<p></p>
								</div>
								
							</div>
						</li>
						<li class="timeline-item">
							<div class="timeline-badge warning">MAY</div>
							<div class="timeline-panel">
								<div class="timeline-heading">
									<h4 class="timeline-title">1234567891</h4>
									<p></p>
								</div>
								
							</div>
						</li>
						<li class="timeline-item">
							<div class="timeline-badge success">MAY</div>
							<div class="timeline-panel">
								<div class="timeline-heading">
									<h4 class="timeline-title">1234567891</h4>
									<p></p>
								</div>
								
							</div>
						</li>
						<li class="timeline-item">
							<div class="timeline-badge primary">JUL</div>
							<div class="timeline-panel">
								<div class="timeline-heading">
									<h4 class="timeline-title">1234567891</h4>
									
								</div>
								
							</div>
						</li>
						<li class="timeline-item">
							<div class="timeline-badge success">AUG</div>
							<div class="timeline-panel">
								<div class="timeline-heading">
									<h4 class="timeline-title">1234567891</h4>
									
								</div>
								
							</div>
						</li>
						<li class="timeline-item">
							<div class="timeline-badge info">SEP</div>
							<div class="timeline-panel">
								<div class="timeline-heading">
									<h4 class="timeline-title">1234567891</h4>
									
								</div>
								
							</div>
						</li>
						<li class="timeline-item">
							<div class="timeline-badge primary">NOV</div>
							<div class="timeline-panel">
								<div class="timeline-heading">
									<h4 class="timeline-title">1234567891</h4>
									<p></p>
								</div>
								
							</div>
						</li>
						<li class="timeline-item">
							<div class="timeline-badge danger">OCT</div>
							<div class="timeline-panel">
								<div class="timeline-heading">
									<h4 class="timeline-title">1234567891</h4>
									<p></p>
								</div>
								
							</div>
						</li>-->
						
					</ul>
				</div>
			   </div>
			   <!-- /.box-body -->
               </div>
               <!-- /.box-->
              </div>
              </div>
					
											
		
			   </div>
			   <!-- /.content-wrapper -->		
				
			   <footer class="main-footer">
			           <div class="pull-right hidden-xs"> <b>Version</b> 2.0.0 </div>
					   <strong>Copyright &copy; 1988-2018 <a href="http://www.faisaljassim.ae/">Faisal Jassim Group</a>. </strong> All rights reserved.
			   </footer>
			    <!-- /.footer -->
			   <div class="control-sidebar-bg"></div>
			</div> <!-- /.wrapper -->
			
			
			<!-- FastClick -->
			<script src="resources/bower_components/fastclick/lib/fastclick.js"></script>
			<!-- AdminLTE App -->
			<script src="resources/dist/js/adminlte.min.js"></script>
			<script src="resources/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
			<script src="resources/bower_components/jquery-knob/js/jquery.knob.js"></script>
			<!-- page script -->
			
	</div>
	 <!-- /.container -->
	</c:when>
	<c:otherwise>
		<body onload="window.top.location.href='logout.jsp'">
		</body>
	</c:otherwise>
	</c:choose>
</html>