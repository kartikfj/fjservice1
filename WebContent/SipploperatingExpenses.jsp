<%-- 
    Document   : SIP OPERATING EXPENSE  
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
			curr_month_name = "Sept";
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
		
		<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
        <script type="text/javascript">
        $(document).ready(function() { 
        google.charts.load('current', {'packages':['corechart','gauge','bar','table']});
        
        google.charts.setOnLoadCallback(drawNetProfitVisualization);
        google.charts.setOnLoadCallback(drawGrossProfitVisualization);
        
        function drawNetProfitVisualization() {
     	var data = google.visualization.arrayToDataTable([
     	['Year', 'Actual' ,{type: 'string', role: 'tooltip'}, 'Target' ,{type: 'string', role: 'tooltip'}],    
     	<c:choose>
     	<c:when test='${!empty NPANALS}'>
     	<c:forEach var="netPAnalsys" items="${NPANALS}">    
     	['${netPAnalsys.year}',<fmt:formatNumber type='number'  pattern = '###.##' value='${netPAnalsys.actual/100000}'/>,
     	'LOI- ${netPAnalsys.year} \r\n  Actual Value: <fmt:formatNumber type='number'   pattern = '#,###.#' value='${netPAnalsys.actual}'/>',<fmt:formatNumber type='number'  pattern = '###.##' value='${netPAnalsys.target/100000}'/>,
     	'Year : ${netPAnalsys.year} \r\n  Target Value:<fmt:formatNumber type='number'   pattern = '#,###.#' value='${netPAnalsys.target}'/>'],
     	 </c:forEach>
     	 </c:when>
     	 <c:otherwise>
     	 ['2016', 0, '', 0, ''],['2017', 0, '', 0, ''],['2018', 0, '', 0, ''],
     	 </c:otherwise>
     	 </c:choose>
     	]);
     	 var view = new google.visualization.DataView(data);
     	 view.setColumns([0, 1, { calc: "stringify",  sourceColumn: 1,   type: "string",   role: "annotation" },  2,3,{ calc: "stringify",  sourceColumn: 3,   type: "string",  role: "annotation" },4]);
     	 var options = {// title : ' NET PROFIT',
     	 titleTextStyle: {color: '#000', fontSize: 13,fontName: 'Arial', bold: true },
     	 'chartArea': { top: 30, right: 12,  bottom: 48, left: 50,  height: '100%', width: '100%'  },
     	  vAxis: {title: 'Value in Millions'},  vAxes: {0: {title: 'Value in Millions',viewWindow:{ min:0}, format: 'short'},},colors: ['#216896', '#2fc2d2'],
     	  'is3D':true, 'height': 230,'legend': { position: 'top' }, tooltip: { textStyle: { fontName: 'verdana', fontSize: 12 } }
     	               };
         var chart = new google.visualization.ColumnChart(document.getElementById('net_profit'));
     	 chart.draw(view, options);
     	 //start  script for deselect column - on modal close
     	 chart.setSelection([{'row': null, 'column': null}]); 
     	 //end  script for deselect column - on modal close
  		 }
       
        function drawGrossProfitVisualization() {
			var data = google.visualization.arrayToDataTable([
			['Year', 'Actual' ,{type: 'string', role: 'tooltip'}, 'Target' ,{type: 'string', role: 'tooltip'}],    
			<c:choose>
			<c:when test='${!empty GPANALS}'>
	     	<c:forEach var="getPAnalsys" items="${GPANALS}">    
	     	['${getPAnalsys.year}',<fmt:formatNumber type='number'  pattern = '###.##' value='${getPAnalsys.actual/100000}'/>,
	     	'LOI- ${getPAnalsys.year} \r\n  Actual Value:<fmt:formatNumber type='number'   pattern = '#,###.#' value='${getPAnalsys.actual}'/>',<fmt:formatNumber type='number'  pattern = '###.##' value='${getPAnalsys.target/100000}'/>,
	     	'Year : ${getPAnalsys.year} \r\n  Target Value:<fmt:formatNumber type='number'   pattern = '#,###.#' value='${getPAnalsys.target}'/>'],
	     	 </c:forEach>
	     	 </c:when>
			<c:otherwise>
			['2016', 0, '', 0, ''],  ['2017', 0, '', 0, ''],  ['2018', 0, '', 0, ''],
			</c:otherwise>
			</c:choose>
			 ]);
			 var view = new google.visualization.DataView(data);
		     view.setColumns([0, 1, { calc: "stringify",  sourceColumn: 1,   type: "string",   role: "annotation" },  2,3,{ calc: "stringify",  sourceColumn: 3,   type: "string",  role: "annotation" },4]);
		     var options = {// title : ' NET PROFIT',
		     titleTextStyle: {color: '#000', fontSize: 13,fontName: 'Arial', bold: true },
		     'chartArea': { top: 30, right: 12,  bottom: 48, left: 50,  height: '100%', width: '100%'  },
		     vAxis: {title: 'Value in Millions'},  vAxes: {0: {title: 'Value in Millions',viewWindow:{ min:0}, format: 'short'},},colors: ['#009688', '#607d8b'],
		     'is3D':true, 'height': 230,'legend': { position: 'top' }, tooltip: { textStyle: { fontName: 'verdana', fontSize: 12 } }
							};
			var chart = new google.visualization.ColumnChart(document.getElementById('gross_profit'));
			chart.draw(view, options);
			//start  script for deselect column - on modal close
			chart.setSelection([{'row': null, 'column': null}]); 
			//end  script for deselect column - on modal close
			}
        });  
			</script>
        
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
							<li><a href="InventoryAging"><i class="fa fa-edit"></i><span>Inventory Aging</span></a></li>
							<li class="active"><a href="P&LandOperatingExpenses"><i class="fa fa-book"></i><span>P&L and Operating Expenses</span></a></li>
							
			           </ul>
				   </section>
				   <!-- /.sidebar -->
			   </aside>
			   
		       <!-- Main content -->
			   <div class="content-wrapper" style="margin-top: -20px;">
					
						<div class="row" style="margin-right: 30px;">
							<div class="col-md-12"
								style="background: white; margin-left: 15px; box-shadow: 0 1px 1px rgba(0, 0, 0, 0.1); margin-top: 20px;">
								<div class="row" style="padding-top: 7px;">
									<div class="col-md-5 col-xs-12">
										<h4 class="divheader"
											style="font-family: sans-serif; width: fit-content; font-weight: bold; color: #0065b3;">
											<c:if test="${DEFCOMPANY ne null or !empty DEFCOMPANY}">${DEFCOMPANY}</c:if>
											<c:if test="${DIVDEFTITL ne  null or !empty DIVDEFTITL}">Sub Division : ${DIVDEFTITL}</c:if> 
											</h4>
									</div>
									<div class="col-md-7">
										<form class="form-inline" method="post" action="P&LandOperatingExpenses">

											<input type="hidden" id="octjf" name="octjf" value="rtlfvid" />



											<div class="form-group">

												<select class="form-control form-control-sm"
													id="division_list" name="tslvid" required>
													<option value="${DIVDEFTITL}">Select Sub Division</option>
													<option value="dlla">All</option>
													<c:forEach var="divisions" items="${DIVLST}">
														<option value="${divisions.div_code}"
															${divisions.div_code  == selected_division ? 'selected':''}>${divisions.div_desc}</option>

													</c:forEach>



												</select>

											</div>
											<div class="form-group">
												<button type="submit" class="btn btn-primary"
													onclick="preLoader();">Refresh</button>
											</div>
										</form>
									</div>
								</div>
							</div>

						</div>	<br/>
			  <div class="row">
			
              <div class="col-md-12">
    			<div class="box">
                <div class="box-header">
                                    <h3 class="box-title">Top 10 Highest Profitable Orders of current Month(${MTH}/${CURR_YR})</h3>
                                     <div class="box-tools pull-right">
                                      <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-plus"></i>
                                      </button>
                                      </div>
                                     </div>
                                <!-- /.box-header -->
						            <div class="box-body">
						              <table id="highestOrder_table"  class="table table-bordered table-striped" >
						                <thead>
               							 <tr>
						                  <th width="10%">Invoice No</th>
						                  <th width="56px;">Inv. Date</th>
						                  <th>Division</th>
						                  <th>Currency</th>
						                  <th>Value</th>
						                  <th>Profit</th>
						                  <th>%</th>
						                  <th>Customer</th>
						                  <th>Project</th>
						                </tr>
                						</thead>
               							 <tbody>
               							 <c:if test="${!empty TTHOCMD or TTHOCMD ne null}">
               							 <c:forEach var="topHighestOrders" items="${TTHOCMD}">
               							 	<tr>
												<td>${topHighestOrders.inv_no}</td>
												<td>
													<fmt:parseDate value="${topHighestOrders.inv_dt}" var="thedtvalH"    pattern="yyyy-MM-dd HH:mm" />
													<fmt:formatDate value="${thedtvalH}" pattern="dd-MM-yyyy"/>
												</td>
												<td>${topHighestOrders.division}</td>
												<td>${topHighestOrders.currncy}</td>
												<td align="right"> <fmt:formatNumber type='number'  pattern = '#,###.#' value='${topHighestOrders.inv_value}'/></td>
												<td align="right"> <fmt:formatNumber type='number'  pattern = '#,###.#' value='${topHighestOrders.profit}'/></td><td><strong>${topHighestOrders.prft_perc}</strong></td>
												<td><small>${topHighestOrders.customer}</small></td><td><small>${topHighestOrders.project}</small></td>
												</tr>
												</c:forEach>
               							 </c:if>
               							 <c:if test="${!empty TTHOCMSD or TTHOCMSD ne null }">
               							 <c:forEach var="topHighestOrders" items="${TTHOCMSD}">
               							 	<tr>
												<td>${topHighestOrders.inv_no}</td>
												<td>
													<fmt:parseDate value="${topHighestOrders.inv_dt}" var="thedtvalH"    pattern="yyyy-MM-dd HH:mm" />
													<fmt:formatDate value="${thedtvalH}" pattern="dd-MM-yyyy"/>
												</td>
												<td>${DIVDEFTITL}</td>
												<td>${topHighestOrders.currncy}</td>
												<td align="right"> <fmt:formatNumber type='number'  pattern = '#,###.#' value='${topHighestOrders.inv_value}'/></td>
												<td align="right"> <fmt:formatNumber type='number'  pattern = '#,###.#' value='${topHighestOrders.profit}'/></td><td><strong>${topHighestOrders.prft_perc}</strong></td>
												<td><small>${topHighestOrders.customer}</small></td><td><small>${topHighestOrders.project}</small></td>
												</tr>
												</c:forEach>
               							 </c:if>
												
											
              							 </tbody>
              							</table>
            </div>
           
            </div>
            </div>
             <div class="col-md-12">
    							<div class="box">
	                                 <div class="box-header">
	                                 <h3 class="box-title">Top 10 Lowest Margin Orders of current Month(${MTH}/${CURR_YR}) </h3>
	                                 <div class="box-tools pull-right">
	                                 <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-plus"></i>
	                                 </button>
	                                 </div>
                                 </div>
                                <!-- /.box-header -->
						        <div class="box-body">
						              <table id="lowestOrder_table" class="table table-bordered table-striped">
						                <thead>
               							 <tr>
						                   <th width="10%;">Invoice No</th>
						                  <th width="56px;">Inv. Date</th>
						                  <th>Division</th>
						                  <th>Currency</th>
						                  <th>Value</th>
						                  <th>Profit</th>
						                  <th>%</th>
						                  <th>Customer</th>
						                  <th>Project</th>
						                </tr>
                						</thead>
               							 <tbody>
               							 <c:if test="${!empty TTLMOCMD or TTLMOCMD ne null}">
               							 <c:forEach var="topLowestOrders" items="${TTLMOCMD}">
												<tr>
												<td>${topLowestOrders.inv_no}</td>
												<td>
                                                 <fmt:parseDate value="${topLowestOrders.inv_dt}" var="thedtvalL"    pattern="yyyy-MM-dd HH:mm" />
												 <fmt:formatDate value="${thedtvalL}" pattern="dd-MM-yyyy"/>
												</td>
												<td>${topLowestOrders.division}</td>
												<td>${topLowestOrders.currncy}</td>
												<td align="right"> <fmt:formatNumber type='number'  pattern = '#,###.#' value='${topLowestOrders.inv_value}'/></td>
												<td align="right"> <fmt:formatNumber type='number'  pattern = '#,###.#' value='${topLowestOrders.profit}'/></td><td><strong>${topLowestOrders.prft_perc}</strong></td>
												<td><small>${topLowestOrders.customer}</small></td><td><small>${topLowestOrders.project}</small></td>
												</tr>
												</c:forEach>
               							 </c:if>
               							 <c:if test="${!empty TTLMOCMSD or TTLMOCMSD ne null}">
               							 <c:forEach var="topLowestOrders" items="${TTLMOCMSD}">
												<tr>
												<td>${topLowestOrders.inv_no}</td>
												<td>
                                                 <fmt:parseDate value="${topLowestOrders.inv_dt}" var="thedtvalL"    pattern="yyyy-MM-dd HH:mm" />
												 <fmt:formatDate value="${thedtvalL}" pattern="dd-MM-yyyy"/>
												</td>
												<td>${DIVDEFTITL}</td>
												<td>${topLowestOrders.currncy}</td>
												<td align="right"> <fmt:formatNumber type='number'  pattern = '#,###.#' value='${topLowestOrders.inv_value}'/></td>
												<td align="right"> <fmt:formatNumber type='number'  pattern = '#,###.#' value='${topLowestOrders.profit}'/></td><td><strong>${topLowestOrders.prft_perc}</strong></td>
												<td><small>${topLowestOrders.customer}</small></td><td><small>${topLowestOrders.project}</small></td>
												</tr>
												</c:forEach>
               							 </c:if>
												
              							 </tbody>
              							</table>
                              </div>          
                         </div>
                   </div>
                   <c:if test="${!empty DIVDEFTITL and DIVDEFTITL ne null}">
                         <div class="col-md-12">
    			<div class="box">
                <div class="box-header" >
                              
                                               
												<select class="form-control form-control-sm overlay" id="acnttype_list" name="tslvid"  onchange="showExpnceValues(this.value);">
													<option value="${DIVDEFTITL}" selected="selected">Select Account Type for Budget Vs Expense Analysis</option>
													<c:forEach var="acntLists" items="${ANFCOE}">
														<option value="${acntLists.accountName}"
															${acntLists.accountName  == selected_acntName ? 'selected':''}>${acntLists.accountName}</option>

													</c:forEach>



												</select>
											
										

                                     <div class="box-tools pull-right">
                                      <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-plus"></i>
                                      </button>
                                      </div>
                                     </div>
                                <!-- /.box-header -->
						            <div class="box-body">
						           <div class="col-md-6"> <div id="expnstitle"></div>
						           
						           <div id="expens_graph"></div>
						           </div>
						           <div class="col-md-6"><div id="expense-List"></div>
						            </div>
						           
			   </div></div></div>
			   </c:if>
                    <div class="col-md-6">
                    	<div class="box">
	                                 <div class="box-header">
	                                 <h3 class="box-title">Net Profit Actual Vs Target Analysis</h3>
	                                 <div class="box-tools pull-right">
	                                 <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-plus"></i>
	                                 </button>
	                                 </div>
                                     </div>
                                     <div class="box-body">
                                     <div id="net_profit">1</div>
                                     </div>
                        </div>
                    </div>
                     <div class="col-md-6">
                     <div class="box">
	                                 <div class="box-header">
	                                 <h3 class="box-title">Gross Profit Actual Vs Target Analysis </h3>
	                                 <div class="box-tools pull-right">
	                                 <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-plus"></i>
	                                 </button>
	                                 </div>
                                     </div>
                                     <div class="box-body">
                                     <div id="gross_profit">1</div>
                                     </div>
                       </div>
                     </div>
              </div>
              <!-- /row  End -->
        
					  <!-- Modal -->
			        <div class="modal fade" id="beError" role="dialog" data-backdrop="static" data-keyboard="false">
					      <div class="modal-dialog modal-sm">
					      <div class="modal-content">  <div class="modal-header">  <button type="button" class="close" data-dismiss="modal">&times;</button>
					      <h4 class="modal-title">Please Select Sub-Division</h4> </div>
					      <div class="modal-body">  <p id="beeMessage">Please Select a sub division from top, then select the account type to continue.</p>
					      </div>
					      <div class="modal-footer">   <button type="button" class="btn btn-default" data-dismiss="modal">OK</button>
					      </div></div></div>
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
			<script>
			 $(document).ready(function() {
				 $('#highestOrder_table').DataTable( {
				        dom: 'Bfrtip',  "paging":   false,  "ordering": false,  "info":     false, "searching": false,
				        buttons: [
				            {
				                extend: 'excelHtml5',
				                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
				                filename: 'Top 10 Highest Profitable Orders of current Month(${CURR_MTH}/${CURR_YR}) for Division: ${DIVDEFTITL} ',
				                title: 'Top 10 Highest Profitable Orders of current Month(${CURR_MTH}/${CURR_YR}) for Division: ${DIVDEFTITL} ',
				                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'     
				            }     ]
				     });
					 $('#lowestOrder_table').DataTable( {
				        dom: 'Bfrtip', "paging":   false,  "ordering": false,  "info":     false,  "searching": false,
				        buttons: [
				            {
				                extend: 'excelHtml5',
				                text:      '<i class="fa fa-file-excel-o" style="color: red; font-size: 2em;"></i>',
				                filename: 'Top 10 Lowest Margin Orders of current Month(${CURR_MTH}/${CURR_YR}) for Division: ${DIVDEFTITL} ',
				                title: 'Top 10 Lowest Margin Orders of current Month(${CURR_MTH}/${CURR_YR}) for Division: ${DIVDEFTITL} ',
				                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
				              }]
				      } );  
	               });
		function showExpnceValues(value){
			var divn='${DIVDEFTITL}';
	        if(divn == null || divn == '') {
			$("#beError").modal("show");
			$('#acnttype_list option').prop('selected', function() {  return this.defaultSelected;   });
			}else{ 
			$.ajax({ type: 'POST',url: 'P&LandOperatingExpenses',  data: {octjf: "eulavsnpxe",emaNtncca:value,nsvid:"${DIVDEFTITL}"}, dataType: "json",
			success: function(data) {
			$("#expnstitle").html("<b>"+value+" Budget Vs Expense Details of Division: ${DIVDEFTITL}</b>");
			//Graph
			google.charts.setOnLoadCallback(drawChart(data));
            //Table
			var output="<table id='expense-table' class='display small' style='width:100%'> "+
			   		     "<thead><tr><th>Month</th><th>Budget</th><th>Expense</th><th>Difference</th></tr></thead><tbody>";  
			for (var i in data) {output+="<tr><td>" + data[i].d1 + "</td>"+"<td>" + data[i].d2 + "</td><td>" + data[i].d3+ "</td>"+ "<td>" + data[i].d4 + "</td></tr>";} 
			output+="</tbody></table>";  $("#expense-List").html(output);	
			$('#expense-table').DataTable( {
			    	"paging":   true,  "ordering": false, "info":false, "lengthMenu": [[6, 12, -1], [6, 12, "All" ]], dom: 'Bfrtip',  
			         buttons: [  { extend: 'excelHtml5',   exportOptions: {  columns: ':not(.noShow):visible' },
			                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
			                filename: value+' Budget Vs Expense Details of Division: ${DIVDEFTITL}',
			                title:  value+' Budget Vs Expense Details of Division: ${DIVDEFTITL}',
			                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
                               }  ]
			                          } );
			   		},error:function(data,status,er) {  alert("please click again");}}); }  }
		
			 function drawChart(results){
			      var data = new google.visualization.DataTable();
 					  data.addColumn('string', 'Topping');data.addColumn('number', 'Budget');data.addColumn('number', 'Expense'); 
				  results.forEach(element => {data.addRow([''+element.d1+'', parseInt(element.d2), parseInt(element.d3)]); }); 
				 var options = {
						  //'title':'Budget',
						   'vAxis': {title: 'Value ',titleTextStyle: {italic: false},format: 'short',viewWindow:{min:0}},
						    hAxis: { slantedText:true, slantedTextAngle:90 },
		                    'is3D':true,  titleTextStyle: {  color: '#000', fontSize: 10,  fontName: 'Arial', bold: true  },
		                    'chartArea': { top: 30,  right: 12,  bottom: 48,  left: 50, height: '100%',  width: '100%' },
						    'height': 180,'legend': {position: 'top'}
		                     ,colors: ['#01b8aa', '#EF851C'], pointSize:2,
		                     series: {  0: { pointShape: 'circle' },  1: { pointShape: 'triangle', pointSize:0 }   }
		                      };
				 var chart = new google.visualization.LineChart(document.getElementById('expens_graph'));
	             chart.draw(data, options);  }
			</script>
    </body>
	 <!-- /.container -->
	</c:when>
	<c:otherwise>
		<body onload="window.top.location.href='logout.jsp'">
		</body>
	</c:otherwise>
	</c:choose>
</html>