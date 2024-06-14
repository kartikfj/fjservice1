<%-- 
    Document   : SIP PAGE FOR PRELOADER  
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="mainview.jsp" %>
<c:set var="empCodee" value='<%= request.getParameter("empcode") %>' scope="page" />
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
	 var userId="${fjtuser.emp_code}";
	
	 google.charts.load('current', {'packages':['corechart', 'gauge','table']});
	 google.charts.setOnLoadCallback(workingCapitalSummary);
	 google.charts.setOnLoadCallback(fundsBlockedSummary);
	 google.charts.setOnLoadCallback(financialPositionSummary);

	     
	 if(userRole=="mg" || userId=='E001977'){document.forms['mgmentForm'].submit();// for managments
	 }else{ window.location.href = "sipMainDivision";}
     
	
});

function workingCapitalSummary () { var data = google.visualization.arrayToDataTable([ ['Month', 'Actual', 'Target'],  
    ['Month',0,0],  
   ['YTD', 0,0]
	           ]);

// Set chart options
var options = {
				  'title':'Total Yearly Target :  ',
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
var chart = new google.visualization.ColumnChart(document.getElementById('workingcapitalchart_div'));
chart.draw(data, options);

}

function financialPositionSummary() { var data = google.visualization.arrayToDataTable([ ['Month', 'Actual', 'Target'],  
    ['Month',0,0],  
   ['YTD', 0,0]
	           ]);

// Set chart options
var options = {
				  'title':'Total Yearly Target :  ',
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
var chart = new google.visualization.ColumnChart(document.getElementById('financialpositionchart_div'));
chart.draw(data, options);

}


function fundsBlockedSummary() {
	
    // Create the data table.
  var data = google.visualization.arrayToDataTable([
    ['Month', 'Actual','Target'],
    ['Month', 0, 0],
    ['YTD',0,0], 
     ]);

//Set chart options
var options = {
		  'title':'Total Yearly Target :  ',
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


//Instantiate and draw our chart, passing in some options.
var chart = new google.visualization.ColumnChart(document.getElementById('fundsblockedchart_div'));
chart.draw(data, options);

}

  </script>
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>
 <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
 <script type="text/javascript">

    </script>


 </head>
 <c:choose>
 <c:when test="${!empty fjtuser.emp_code}">
 
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
	    
                <form id="mgmentForm" name="mgmentForm" action="ConsolidatedReport" method="post">
                <input type="hidden" name="fjtco" value="dmfsltdmd" />
                 <input type="hidden" name="dmCodemgmnt" value="${empCodee}" />
                </form>
                       
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