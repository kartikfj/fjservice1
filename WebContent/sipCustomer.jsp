<%-- 
    Document   : SIP CUSTOMER  
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="mainview.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>

<!DOCTYPE html>

<html><head>
<style>

.modal-dialog,.modal-content { /* 80% of window height */ /* height: 80%;*/height: calc(100% - 20%);}
.modal-body {  /* 100% = dialog height, 120px = header + footer */ max-height: calc(100% - 120px); overflow-y: scroll; overflow-x: scroll;}
.modal-body th{ font-weight:bold;}
.modal-footer {padding: 2px 15px 15px 15px !important;}
.loader {position: fixed; z-index: 999; height: 2em;width: 2em;overflow: show; margin: auto; top: 0;left: 0;bottom: 0; right: 0;}
.loader:before { content: '';display: block;position: fixed;top: 0; left: 0;width: 100%; height: 100%; background-color: rgba(0,0,0,0.3);}
.small-box { border-radius: 2px;position: relative; display: block; margin-top: 10px; box-shadow: 0 1px 1px rgba(0,0,0,0.1);}
.bg-red {background-color: #3b80a9 !important; color: #fff !important;}
.small-box>.small-box-footer { position: relative; text-align: center; padding: 3px 0;  color: #fff;color: rgba(255,255,255,0.8);display: block; z-index: 10; background: rgba(0,0,0,0.1);text-decoration: none;}
.small-box .icon { -webkit-transition: all .3s linear; -o-transition: all .3s linear; transition: all .3s linear; position: absolute; top: 5px; right: 10px; z-index: 0; font-size: 75px; color: rgba(0,0,0,0.15);}
.small-box p { z-index: 5;} .small-box p { font-size: 15px;} .small-box>.inner { padding: 10px;} .small-box h3, .small-box p {z-index: 5;}
.small-box h3 { font-size: 2em; font-weight: bold; margin: 0 0 10px 0; white-space: nowrap; padding: 0;}
#chart_div, #prf_summ_billing_ytd, #prf_summ_booking_ytd, #stages{position: relative;border-radius: 3px; border-top: 3px solid #065685; margin-bottom: 20px; box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12);}
.stage{ background-color: #065685;color: white; border: 1px solid #065685;}
.navbar { margin-bottom: 8px !important;} 
.table{display: block !important; overflow-x:auto !important;}
#db-title-boxx{background: white; height: auto;; margin-top: -9px; margin-left: -10px; margin-right: -10px; box-shadow: 0 0 4px rgba(0,0,0,.14), 0 4px 8px rgba(0,0,0,.28);}

.google-visualization-table-table {
    font-family: serif !important;
    font-size: 12pt !important;
    border-spacing: 5px !important;
    }
    .tab-content>.active {
    
    margin-top: 10px !important;}
    #jihv_table-dt{
    height:310px !important;
    }
    .table>caption+thead>tr:first-child>td, .table>caption+thead>tr:first-child>th, .table>colgroup+thead>tr:first-child>td, .table>colgroup+thead>tr:first-child>th, .table>thead:first-child>tr:first-child>td, .table>thead:first-child>tr:first-child>th {
    color: #0000ff !important;
     }
   table.dataTable tfoot td {color: blue !important;font-weight: bold;}
   .pagination>li>a, .pagination>li>span{
  border:1px solid red !important;
}
 .fjtco-table {
    /* background-color: #ffff; */
    background-color: #e5f0f7;
    padding: 0.01em 16px;
    margin: 20px 0;
    box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important;
    }
    
    .main-header {z-index: 851 !important;}
  
 
 #stages-dt .col-lg-6 {
 margin-top: -5px;
}
.container {
    padding-right: 0px !important;
    padding-left: 0px !important;
}

.wrapper{margin-top:-8px;}
.row{margin-left:0px !important;margin-right:0px;}

#customer-visit tbody td, #example tbody td {
        padding: 3px 3px;
    font-size: 65%;
}

#customer-visit  thead th, #example thead th{
    padding: 3px 7px;
    border-bottom: 1px solid #795548;
    font-size:80%;
}
.box-footer{padding:1px;}

.dataTables_wrapper .dataTables_info{    color: #2196F3 !important;
    font-size: 10px !important;
    font-weight: bold !important;}
	
	.dataTables_wrapper .dataTables_paginate .paginate_button.disabled {color: #2196F3 !important;
   
    font-size: 10px !important;
    font-weight: bold !important;}
	
	.dataTables_wrapper .dataTables_paginate .paginate_button{    font-size: 10px !important;
    font-weight: bold !important;padding:0 !important;}
    .dataTables_wrapper .dataTables_length, .dataTables_wrapper .dataTables_filter, .dataTables_wrapper .dataTables_info,  .dataTables_wrapper .dataTables_paginate{
   
    font-weight: bold !important;
    font-size: 11px !important;
}
.description-block>.description-header{
    margin: 0;
    padding: 0;
    font-weight: bold !important;
    color: #F44336;
    font-size: 80% !important;
}
.description-block>description-text {font-weight:bold;}
table.dataTable.no-footer {
    border-bottom: 1px solid #795548 !important;
}
.box-header .box-title{font-size:15px !important;font-weight:bold !important;}
.description-block {    margin: 6px 0 !important;}
.dataTables_wrapper .dataTables_info {padding-top: 0.555em; margin-bottom: -2px;
}

svg > g:last-child > g:last-child { pointer-events: none }
div.google-visualization-tooltip { pointer-events: none }
div.google-visualization-tooltip {

    padding: 0 !important;
    margin: 0 !important;
    border:none !important;

 
    height:auto !important;
    overflow:hidden !important;

}
#qtnlost tbody td {
    padding: 2px 4px !important;
    font-size: 90% !important;}
    
    #customer-visit   tfoot th, #example  tfoot th{text-align:right !important;padding: 2px 2px !important; color:#f44336;border-right: 1px solid #c7c3c3;
    border-bottom: 1px solid #111111;}
    #example_wrapper{overflow-x:auto !important;}
    
    .customer-visit{
    border-top-right-radius: 0;
    border-top-left-radius: 0;
    padding: 1px 0 0 0;
    border-top-width: 0;
    width: 280px;
    box-shadow: none;
    border-color: #eee;
    background-color: #fff;
}
.customer-visit>li.visit-header{ 
       height: 52px;
    padding: 5px;
    text-align: center;
    background-color: #607D8B;
    list-style: none;}
    
  .customer-visit li p{
         z-index: 5;
    color: white;
    font-size: 17px;
    margin-top: 0px
  }  
  
   .customer-visit  li.user-header>p>small{    display: block;
    font-size: 12px;}
    .visit-body{
       padding: 8px;
    border-bottom: 1px solid #607d8b;
    border-top: 1px solid #607d8b;
    list-style: none
    }
    .visit-body a{    color: #444 !important;}
</style>


 


<%
  DateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
  Calendar cal = Calendar.getInstance();
   //Date dNow = new Date( ); 
  int month = cal.get(Calendar.MONTH)+1;  
  int iYear = cal.get(Calendar.YEAR);  
  request.setAttribute("currCal",sdf.format(cal.getTime()));
  request.setAttribute("currYr",iYear);
  %>
  
<link rel="stylesheet"
	href="resources/bower_components/font-awesome/css/font-awesome.min.css">

<!-- Theme style -->
<link rel="stylesheet" href="resources/dist/css/AdminLTE.min.css">
<link rel="stylesheet"
	href="resources/dist/css/skins/_all-skins.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/datatables/datatables-fjtco/css/jquery.dataTables.min.css" />
<link rel="stylesheet" type="text/css"
	href="resources/datatables/buttons-fjtco/css/buttons.dataTables.min.css" />
<script type="text/javascript"
	src="resources/datatables/datatables-fjtco/js/jquery.dataTables.min.js"></script>

<script type="text/javascript"
	src="resources/datatables/buttons-fjtco/js/buttons.flash.min.js"></script>
<script type="text/javascript"
	src="resources/datatables/ajax/excelmake/jszip.min.js"></script>
<script type="text/javascript"
	src="resources/datatables/datatables-fjtco/js/dataTables.buttons.min.js"></script>	
<!--  <script type="text/javascript" src="resources/datatables/ajax/pdfmake/vfs_fonts.js"></script>-->
<script type="text/javascript"
	src="resources/datatables/buttons-fjtco/js/buttons.html5.min.js"></script>
<script type="text/javascript"
	src="resources/datatables/buttons-fjtco/js/buttons.print.min.js"></script>

<link href="resources/css/regularisation_report.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="resources/js/regularisation_report.js"></script>
 <script type="text/javascript">
 google.charts.load('current', {'packages':['line','corechart']});


 function preLoader(){ $('#laoding').show();}

	 function formatNumber(num) {return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");}
	 $(document).ready(function() {
		 $('#laoding').show();
		    $('#example').DataTable( {
		    	"paging":   true,
		        "ordering": true,
		        "info":     false,
		        "lengthMenu": [[2, 5, 10, 15, 25, 100, 250, 500, -1], [2, 5, 10, 15, 25, 100, 250, 500, "All" ]],
		         dom: 'Bfrtip',  
		         buttons: [
		            {
		                extend: 'excelHtml5',
		                exportOptions: {
		                	   columns: ':not(.noShow):visible'
		                	},
		                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
		                filename:'Customer Wise Stage-2 Project List (Across all Divisions) - 2018',
		                title: 'Customer Wise Stage-2 Project List   (Across all Divisions) - 2018',
		                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
		                
		                
		            }
		           
		        ]
		    } );
		    
		    $('#laoding').hide();
		} );
	 
 

   
   
</script>


 <!--  .graph activities end..  -->
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
    
           <li><a href="DmInfo.jsp"><i class="fa fa-dashboard"></i><span>Sales Engineers Performance</span></a></li>
           <c:if test="${!empty fjtuser.subordinatelist}" > <li><a href="DisionInfo.jsp"><i class="fa fa-line-chart"></i><span>Sub Division Performance</span></a></li></c:if>
            <c:if test="${!empty fjtuser.subordinatelist}" > <li ><a href="CompanyInfo.jsp"><i class="fa fa-pie-chart"></i><span>Division Performance</span></a></li></c:if>
               <li   class="active"><a href="#" onclick="preLoader();"><i class="fa fa-table"></i><span>Customer Performance</span></a></li>
           
     
        
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>


    <!-- Main content -->  
	   <div class="content-wrapper" style="margin-top: -8px;">
	   
	   
	   


          <div class="row">
        <div class="col-md-12">
          <div class="box box-danger" style="margin-top:15px;">
            <div class="box-header with-border">
              <h3 class="box-title">Customer Wise Stage-2 Project List (Across all Divisions) -2018 </h3>
 

              <div class="box-tools pull-right">
               <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body" style="padding:5px !important;">
              <div class="row">
                <div class="col-md-12">
                  
                  <div class="chart">
                    <!-- Outstanding recvble report divsn -->
                    		<table id="example" class="display" style="width:100%">
        <thead>
            <tr>
                 <th>Customer Code</th>
                <th>Customer  Name</th>
                <th>Week</th>
                <th>Qtn. Status</th>
                <th>Qtn. Date</th>
                <th>Qtn. Code</th>
                 <th>Qtn. Number</th>
                <th>Company Code</th>
                <th>Division</th>
                <th>Sales Egr: Code </th>
                <th>Sales Egr: Name </th>
                <th>Project Name</th>
                <th>Consultant</th>
                <th>Product Type</th>
                <th>Product Classification</th>
                <th>Zone</th>
             
                
            </tr>
        </thead>
        <tbody>
        <c:forEach var="project_list"  items="${PRJCTLIST}" >
        <tr>
        <td>${project_list.customer_code}</td><td>${project_list.customer_name}</td><td>${project_list.week}</td>
        <td>${project_list.quatation_status}</td>
        
        <td>
        <fmt:parseDate value="${project_list.quatation_date}" var="theProjectQtnDate"  pattern="yyyy-MM-dd HH:mm" />
        <fmt:formatDate value="${theProjectQtnDate}" pattern="dd-MM-yyyy"/> 
        </td>
        <td>${project_list.company_code}</td>
        <td>${project_list.quatation_code}</td><td>${project_list.quatation_no}</td><td>${project_list.division}</td>
        <td>${project_list.sm_code}</td><td>${project_list.sm_name}</td><td>${project_list.project_name}</td>
        <td>${project_list.consultant}</td><td>${project_list.prdct_type}</td><td>${project_list.pproduct_classf}</td>
        <td>${project_list.zone}</td>
        </tr>
        
        </c:forEach>
        </tbody>
        
    </table>
                  </div>
                  <!-- /.chart-responsive -->
                </div>
                <!-- /.col -->
               
                <!-- /.col -->
              </div>
              <!-- /.row -->
            </div>
            <!-- ./box-body -->
         
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->
    

    
    
    
    
    
    
    
    
    
    
    
	<!--  modal end -->
	<div id="laoding" class="loader" ><img src="resources/images/wait.gif"></div>
    
    </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <div class="pull-right hidden-xs">
      <b>Version</b> 2.0.0
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
</div>
<!-- ./wrapper -->

<!-- FastClick -->
<script src="resources/bower_components/fastclick/lib/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="resources/dist/js/adminlte.min.js"></script>

<!-- page script -->

</body>


</c:when>
<c:otherwise>
    <html>
        <body onload="window.top.location.href='logout.jsp'">
        </body>
            
        </body>
    
</c:otherwise>

</c:choose>
</html>