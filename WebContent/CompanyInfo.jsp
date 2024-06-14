<%-- 
    Document   : SIP PAGE FOR PRELOADER  
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="mainview.jsp" %>
<%-- <c:set var="empCodee" value='<%= request.getParameter("empcode") %>' scope="page" /> --%>
<c:if test="${empCodee eq null or empty empCodee}"> <c:set var="empCodee" value="${fjtuser.emp_code}" scope="page" /></c:if>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="java.util.Calendar"%>

<!DOCTYPE html>
<html><head>
  
  
  <!-- Font Awesome -->
  <link rel="stylesheet" href="resources/bower_components/font-awesome/css/font-awesome.min.css">
 
  <!-- Theme style -->
  <link rel="stylesheet" href="resources/dist/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="resources/dist/css/skins/_all-skins.min.css">
  <style>

#guage_test_booking,#guage_test_billing { height: 210px; width: 100%;}
.nav-tabs-custom>.nav-tabs>li.active { border-top: 2px solid #065685 !important;}
 svg:first-child > g > text[text-anchor~=middle]{ font-size: 18px;font-weight: bold; fill: #337ab7;}

.modal-dialog,.modal-content { /* 80% of window height */ /* height: 80%;*/height: calc(100% - 20%);}
.modal-body {  /* 100% = dialog height, 120px = header + footer */ max-height: calc(100% - 120px); overflow-y: scroll; overflow-x: scroll;}
.modal-body th{ font-weight:bold;}
.modal-footer {padding: 2px 15px 15px 15px !important;}
.loader {position: fixed; z-index: 999; height: 2em;width: 2em;overflow: show; margin: auto; top: 0;left: 0;bottom: 0; right: 0;}
.loader:before { content: '';display: block;position: fixed;top: 0; left: 0;width: 100%; height: 100%; background-color: rgba(0,0,0,0.3);}


.stage{ background-color: #065685;color: white; border: 1px solid #065685;}
.navbar { margin-bottom: 8px !important;} 
.table{display: block !important; overflow-x:auto !important;}
#db-title-boxx{background: white; height: auto;; margin-top: -9px; margin-left: -10px; margin-right: -10px; box-shadow: 0 0 4px rgba(0,0,0,.14), 0 4px 8px rgba(0,0,0,.28);}


 .fjtco-table {
   background-color: #ffff;
    
    padding: 0.01em 16px;
    margin: 7px 7px 7px 15px;
    box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important;
    border-top: 3px solid #065685;
    }
   .small-box>.inner {
    padding: 5px;height: 80px;
}
</style>
<style>
.container {
    padding-right: 0px !important;
    padding-left: 0px !important;
}

.wrapper{margin-top:-8px;}
  .counter-anim{color:#f6fff6;}
    .collapse.in {
    background: #3b80a9;
    color: white;
    text-align: center;
    font-weight: bold;
    font-size: larger;
    display: block;
}
.weight-500{color:#FFEB3B;    font-weight: normal;}
.padding-0{
    padding-right:0;
    padding-left:0;
    width: 150px;
    margin-bottom: -18px;
}
.paddingr-0{
    padding-right:0;
     padding-left:0;
    width: 150px;
    margin-bottom: -18px;
}
.paddingl-0{ 
    padding-left:0;
    padding-right:0;
    width: 150px;
    margin-bottom: -18px;
}
.fjtco-table .panel-body {
    padding: 3px;
   
}
.box-tools{cursor: pointer;}
 .row{margin-left:0px !important;}
 
 #stages-dt .col-lg-6 {
 margin-top: -5px;
}

 #stages-dt .small-box .icon {
    -webkit-transition: all .3s linear;
    -o-transition: all .3s linear;
    transition: all .3s linear;
    position: absolute;
    top: -5px;
    right: 10px;
    z-index: 0;
    font-size: 70px;
    color: rgba(0,0,0,0.15);
  
}
.main-header {z-index: 851 !important;}

</style>

<script type="text/javascript">
$(document).ready(function($) {
	 var userRole="${fjtuser.role}";
	 google.charts.load('current', {'packages':['corechart', 'gauge','table']});
	 google.charts.setOnLoadCallback(drawJobInHandVolume); 
	 google.charts.setOnLoadCallback(drawPerfomanceSummaryBookingYtd);
	 google.charts.setOnLoadCallback(drawPerfomanceSummaryBillingYtd); 
     
	 if(userRole=="mg"){ document.forms['mgmentForm'].submit();// for managments
	 }else{ window.location.href = "sipMainDivision";}
     
	
});

  </script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>
 <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
 <script type="text/javascript">

 function drawJobInHandVolume() { var data = new google.visualization.DataTable();
 data.addColumn('string', 'Topping'); data.addColumn('number', 'Amount'); data.addColumn({type:'number', role:'annotation'});
 data.addRows([  ['', 0,0] ]);
 var options = {'title':'Job in hand volume for Last 2 Years from  - (AED)','vAxis': {title: 'Amount (Value in Millions)',titleTextStyle: {italic: false},format: 'short'}, 'legend':'none', 'chartArea': { top: 70, right: 12,  bottom: 48, left: 60,  height: '100%', width: '100%'  }, 'height':275 };
 var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
 chart.draw(data, options);}

 function drawPerfomanceSummaryBookingYtd() { var data = google.visualization.arrayToDataTable([ ['Month', 'Actual', 'Target'],  
     ['Month',0,0],  
    ['YTD', 0,0]
	           ]);

 // Set chart options
 var options = {
				  'title':'Booking YTD (AED) - Target Vs Actual - . \r\n Total Yearly Target :  ',
				  'vAxis': {title: 'Amount (Value in Millions)',titleTextStyle: {italic: false},format: 'short'},
                 'is3D':true,
                  'chartArea': {
				        top: 70,
				        right: 12,
				        bottom: 48,
				        left: 60,
				        height: '100%',
				        width: '100%'
				      },
				     
				      'height': 275,
				      'legend': {
				        position: 'top'
				      }
               
                };
 

 // Instantiate and draw our chart, passing in some options.
 var chart = new google.visualization.ColumnChart(document.getElementById('prf_summ_booking_ytd'));
 chart.draw(data, options);
 
 }
 
 
 function drawPerfomanceSummaryBillingYtd() {
 	
     // Create the data table.
   var data = google.visualization.arrayToDataTable([
     ['Month', 'Actual','Target'],
     ['Month', 0, 0],
     ['YTD',0,0], 
      ]);

// Set chart options
var options = {
		  'title':'Billing YTD (AED) - Target Vs Actual - . \r\n Total Yearly Target :  ',
		  'vAxis': {title: 'Amount (Value in Millions)',titleTextStyle: {italic: false},format: 'short'},
        'is3D':true,
         'chartArea': {
		        top: 70,
		        right: 12,
		        bottom: 48,
		        left: 60,
		        height: '100%',
		        width: '100%'
		      },
		     
		      'height': 275,
		      'legend': {
		        position: 'top'
		      }
      
       };


// Instantiate and draw our chart, passing in some options.
var chart = new google.visualization.ColumnChart(document.getElementById('prf_summ_billing_ytd'));
chart.draw(data, options);

}
    </script>


 </head>
 <c:choose>
 <c:when test="${!empty fjtuser.emp_code and !empty fjtuser.sales_code  and fjtuser.checkValidSession eq 1}">
 
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
    
            <li><a href="DmInfo.jsp"  class="active"><i class="fa fa-dashboard"></i><span>Sales Engineers Performance</span></a></li>
             <li><a href="DisionInfo.jsp"><i class="fa fa-line-chart"></i><span>Sub Division Performance</span></a></li>
             <li class="active"><a href="#"><i class="fa fa-pie-chart"></i><span>Division Performance</span></a></li>            
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper" style="margin-top: -8px;">

    <div class="row">
  <form class="form-inline" method="post" action="sip" style="margin-left: 15px;"> 
  <br/>
  <select class="form-control form-control-sm" name="scode" id="scode" required>
  


					  	<option value="">Select Salesman</option>
 

  						
  					

						</select>
						
						  <select class="form-control form-control-sm" name="syear" id="syear">
  						<option selected value="">Select Year</option>
  						
						</select>
						
					 
   					<button type="submit" id="sf" class="btn btn-primary" >View</button>
			
				</form> 

   </div>
   
   <div  class="fjtco-table"  style="padding:7px;">
 
  
   
 <b style="color: #dc3912; font-family: monospace; font-weight: bold;font-size: 18px;"> Outstanding Receivable Aging  </b> (Value in base local currency) 
              <div class="pull-right box-tools">
               
                 <span data-toggle="tooltip"  data-html="true" title="<em>Outstanding receivable aging repoprt as on:</em><em><br>date</em><em><br>12.05 AM<u> 
				 	 </u></em>" style="color: #dc3912;font-weight: bold;" class="fa fa-calendar">&nbsp;</span><i class="fa fa-arrow-left"></i>
                </div>
            
					  
      
        <div class="row">
        
					<div class="col-lg-2 col-md-3 col-sm-3 col-xs-12 paddingr-0">
						<div class="panel panel-default card-view pa-0">
							<div class="panel-wrapper collapse in">
								<div class="panel-body pa-0">
									<div class="sm-data-box">
										<div class="container-fluid">
											<div class="row">
													<span class="weight-500 font-13"><30 Days</span><br/>
													<span class="counter-anim">0</span>		
											</div>	
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
						<div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 padding-0">
						<div class="panel panel-default card-view pa-0">
							<div class="panel-wrapper collapse in">
								<div class="panel-body pa-0">
									<div class="sm-data-box">
										<div class="container-fluid">
											<div class="row">	
													<span class="weight-500">30-60 Days</span><br/>
													<span class="counter-anim">0</span>
												</div>
											</div>	
										</div>
									</div>
								</div>
							</div>
						</div>
					
				
					<div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 padding-0">
						<div class="panel panel-default card-view pa-0">
							<div class="panel-wrapper collapse in">
								<div class="panel-body pa-0">
									<div class="sm-data-box">
										<div class="container-fluid">
											<div class="row">
													<span class="weight-500 font-13">60-90  Days</span>	<br/>
													<span class="counter-anim">0</span>
											</div>	
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 padding-0">
						<div class="panel panel-default card-view pa-0">
							<div class="panel-wrapper collapse in">
								<div class="panel-body pa-0">
									<div class="sm-data-box">
										<div class="container-fluid">
											<div class="row">
													<span class="weight-500">90-120 Days</span><br/>
													<span class="counter-anim">0</span>
											</div>	
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
						<div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 padding-0">
						<div class="panel panel-default card-view pa-0">
							<div class="panel-wrapper collapse in">
								<div class="panel-body pa-0">
									<div class="sm-data-box">
										<div class="container-fluid">
											<div class="row">	
													<span class="weight-500">120-180  Days</span><br/>
														<span class="counter-anim">0</span>
											</div>	
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
			
					<div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 paddingl-0">
						<div class="panel panel-default card-view pa-0">
							<div class="panel-wrapper collapse in">
								<div class="panel-body pa-0">
									<div class="sm-data-box">
										<div class="container-fluid">
											<div class="row">
													<span class="weight-500">>180  Days</span><br/>
													<span class="counter-anim">0</span>
											</div>	
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
		
				</div>

	   
	</div>
   
	   
	   
	   <div class="row">
        <div class="col-md-6">
          <!-- AREA CHART -->
          <div class="box box-primary" style="margin-bottom: 8px;">
            <div class="box-header with-border">
              <h3 class="box-title">Job in Hand Volume</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
               
              </div>
            </div>
            <div class="box-body">
              <div class="chart">
           
                 <div id="chart_div" style="height:250px;margin-top:-37px;"></div> 
              </div>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->

          <!-- Booking CHART -->
          <div class="box box-danger" style="margin-bottom: 8px;">
            <div class="box-header with-border">
              <h3 class="box-title">Booking</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
               
              </div>
            </div>
            <div class="box-body">
              <div id="prf_summ_booking_ytd" style="height:270px;margin-top:-10px;"></div>  
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->

        </div>
        <!-- /.col (LEFT) -->
        <div class="col-md-6">
        
         
        
          <!-- Stage 3 4 CHART -->
         
          <!-- Custom tabs (Charts with tabs)-->
        <section style="margin-bottom: -11px;">
         <div class="nav-tabs-custom" >
         
          <ul class="nav nav-tabs">
         <li  class="pull-right"><a data-toggle="tab" href="#bb1-meter"  style="border-right:transparent;" >Target Achieved  %</a></li>
          <li class="active pull-right"><a data-toggle="tab" href="#stages-dt">Stage Details</a></li>
         
          
          </ul>
         
           <div class="tab-content" style="height: 232px;">
           <div id="stages-dt" class="tab-pane fade  in active">
             <div class="row">

	              <div class="col-lg-6 col-xs-6"><c:set var="jihv_total" value="0" scope="page" /> <c:forEach var="JOBV" items="${JIHV}">
	              <c:set var="jihv_total" value="${jihv_total + JOBV.amount}" scope="page" /> </c:forEach> 
			 	  <div class="small-box bg-red">
	              <div class="inner"> <h3>Stage 1</h3> <p><strong>0</strong></p></div>
	              <div class="icon"><i class="fa fa-pie-chart"></i></div>
	              <a href="#" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a></div>
				  </div>
  
	              <div class="col-lg-6 col-xs-6">
	              <div class="small-box bg-yellow">
	              <div class="inner"><h3>Stage 2</h3><p> <strong>0</strong></p>
	              </div> <div class="icon"><i class="fa fa-pie-chart"></i> </div><a href="#" class="small-box-footer" style="color: #357398;cursor:default;">.</a>
	              </div></div>

             </div>
		
	   		  <div class="row" > 			
	   	
	   			  <div class="col-lg-6 col-xs-6" style="margin-top:-17px;">
				  <div class="small-box bg-blue">
		          <div class="inner">
                  <h3>Stage 3</h3><p id="s3sum">0</p>
                  <input type="hidden" id="s3sum_temp" value="0" />
                  </div> <div class="icon"><i class="fa fa-pie-chart"></i></div>
                  <a href="#"   class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                  </div>
			      </div>
	   		
       	          <div class="col-lg-6 col-xs-6" style="margin-top:-17px;">
				  <div class="small-box bg-green">
	              <div class="inner">
	              <h3>Stage 4</h3> <p id="s4sum">0</p>
	              <input type="hidden" id="s4sum_temp" value="0" />
	              </div>
	              <div class="icon"><i class="fa fa-pie-chart"></i></div>
	              <a href="#"   class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
	              </div>
				  </div>
				    
	   	     </div>
	   	     
         </div>
    
     </div>
     
      </div>
        </section>

        
         <!-- BILLING CHART -->
          <div class="box box-success" style="margin-bottom: 8px;">
            <div class="box-header with-border">
              <h3 class="box-title">Billing</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
           
              </div>
            </div>
            <div class="box-body">
              <div class="chart">
                <div id="prf_summ_billing_ytd" style="height:270px;margin-top:-10px;"></div>  
              </div>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.billing box -->
        

        </div>
        <!-- /.col (RIGHT) -->
      </div>
      <!-- /.row -->
	   
	   
	   
	    
                <form id="mgmentForm" name="mgmentForm" action="sipMainDivision" method="post">
                <input type="hidden" name="fjtco" value="dmfsltdmd" />
                 <input type="hidden" name="dmCodemgmnt" value="${empCodee}" />
                </form>

	
	
	
       
       
        <div class="row">
					<div class="modal fade" id="editSGoal" role="dialog" >
					
					        <div class="modal-dialog" style="width:97%;">
					     		<!-- Modal content-->
							      	<div class="modal-content">
								        	<div class="modal-header">
								         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
								          		<h4 class="modal-title">Job In Hand Volume Details </h4>
								        	</div>
								        	<div class="modal-body small"> <div id="table_div"></div></div>
									        <div class="modal-footer">
									          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									        </div>
								     </div>
								     
								     
						   	 </div>   	 		   	 
		 			</div>
	  
	</div>
	<div id="laoding" class="loader" ><img src="resources/images/wait.gif"></div>
       
       
       
          
     
      <!-- /.row -->

    
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <div class="pull-right hidden-xs">
      <b>Version</b> 1.1.0
    </div>
    <strong>Copyright &copy; 1988-2018 <a href="http://www.faisaljassim.ae/">Faisal Jassim Group</a>.</strong> All rights
    reserved.
  </footer>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Create the tabs -->
    <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
      <li><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
      <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
    </ul>
    <!-- Tab panes -->
    
  </aside>
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
       immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>

</div>
<!-- ./wrapper -->
</div>
<!-- jQuery 3 -->

<!-- Bootstrap 3.3.7 -->

<!-- ChartJS -->

<!-- FastClick -->
<script src="resources/bower_components/fastclick/lib/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="resources/dist/js/adminlte.min.js"></script>

<!-- page script -->

</body>
</c:when>
<c:otherwise>

        <body onload="window.top.location.href='logout.jsp'">
   
            
        </body>
  
</c:otherwise>
</c:choose>
</html>