<%-- 
    Document   : SIP recievable  
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

#example tbody td {
    padding: 4px 5px;
    font-size: 83%;
}

#example thead th{
    padding: 3px 10px;
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
    
    #example  tfoot th{text-align:right !important;padding: 2px 2px !important; color:#f44336;border-right: 1px solid #c7c3c3;
    border-bottom: 1px solid #111111;}
    #example_wrapper{overflow-x:auto !important;}
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
  <!-- Font Awesome -->
  <link rel="stylesheet" href="resources/bower_components/font-awesome/css/font-awesome.min.css">
 
  <!-- Theme style -->
  <link rel="stylesheet" href="resources/dist/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="resources/dist/css/skins/_all-skins.min.css">
<link rel="stylesheet" type="text/css" href="resources/datatables/datatables-fjtco/css/jquery.dataTables.min.css"/>
<link rel="stylesheet" type="text/css" href="resources/datatables/buttons-fjtco/css/buttons.dataTables.min.css"/>
<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/dataTables.buttons.min.js"></script>
<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.flash.min.js"></script>
<script type="text/javascript" src="resources/datatables/ajax/excelmake/jszip.min.js"></script>
<script type="text/javascript" src="resources/datatables/ajax/pdfmake/vfs_fonts.js"></script>
<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.html5.min.js"></script>
<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.print.min.js"></script>

<link href="resources/css/regularisation_report.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script src="resources/js/regularisation_report.js"></script>
 <script type="text/javascript">
 google.charts.load('current', {'packages':['line','corechart']});
 google.charts.setOnLoadCallback(drawChart);
 

 function drawChart() {
	
   var data = google.visualization.arrayToDataTable([
     ['Division', 'Jan', 'Feb','Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct','Nov', 'Dec'],
     <c:choose>
     <c:when test='${!empty PDCHAND}'>
     <c:forEach var="pdcHandVal" items="${PDCHAND}">
      ['${pdcHandVal.divname}',
    	  <c:choose>
      <c:when test='${!empty pdcHandVal.jan_data}'> ${pdcHandVal.jan_data}, </c:when><c:otherwise>0,</c:otherwise></c:choose>
      <c:choose> 
      <c:when test='${!empty pdcHandVal.feb_data}'>   ${pdcHandVal.feb_data}, </c:when><c:otherwise>0,</c:otherwise></c:choose>
      <c:choose> 
      <c:when test='${!empty pdcHandVal.mar_data}'>   ${pdcHandVal.mar_data}, </c:when><c:otherwise>0,</c:otherwise></c:choose>
      <c:choose> 
      <c:when test='${!empty pdcHandVal.apr_data}'>  ${pdcHandVal.apr_data}, </c:when><c:otherwise>0,</c:otherwise></c:choose>
      <c:choose> 
      <c:when test='${!empty pdcHandVal.may_data}'>  ${pdcHandVal.may_data},  </c:when><c:otherwise>0,</c:otherwise></c:choose>
      <c:choose> 
      <c:when test='${!empty pdcHandVal.jun_data}'>  ${pdcHandVal.jun_data}, </c:when><c:otherwise>0,</c:otherwise></c:choose>
      <c:choose>  
      <c:when test='${!empty pdcHandVal.jul_data}'>   ${pdcHandVal.jul_data},  </c:when><c:otherwise>0,</c:otherwise></c:choose>
      <c:choose>  
      <c:when test='${!empty pdcHandVal.aug_data}'>   ${pdcHandVal.aug_data}, </c:when><c:otherwise>0,</c:otherwise></c:choose>
      <c:choose>  
      <c:when test='${!empty pdcHandVal.sep_data}'>   ${pdcHandVal.sep_data},  </c:when><c:otherwise>0,</c:otherwise></c:choose>
      <c:choose>  
      <c:when test='${!empty pdcHandVal.oct_data}'>   ${pdcHandVal.oct_data}, </c:when><c:otherwise>0,</c:otherwise></c:choose>
      <c:choose>  
      <c:when test='${!empty pdcHandVal.nov_data}'>  ${pdcHandVal.nov_data}, </c:when><c:otherwise>0,</c:otherwise></c:choose>
      <c:choose>  
      <c:when test='${!empty pdcHandVal.dec_data}'>   ${pdcHandVal.dec_data} </c:when><c:otherwise>0</c:otherwise></c:choose>
    	  ],
       
     </c:forEach> 
     </c:when>
     <c:otherwise>
     
     ['',0, 0,0, 0,0, 0,0, 0,0, 0,0, 0],
   
   
    
   
     </c:otherwise>
     </c:choose>
    
     
   ]);
   var view = new google.visualization.DataView(data);
	/* view.setColumns([0, 1,
	                  { calc: "stringify",
	                    sourceColumn: 1,
	                    type: "string",
	                    role: "annotation" },
	                  2,{
	   calc: "stringify",
	   sourceColumn: 2, 
	   type: "string",
	   role: "annotation"
	},3,{ calc: "stringify",
        sourceColumn: 3,
        type: "string",
        role: "annotation" },4,{ calc: "stringify",
            sourceColumn: 4,
            type: "string",
            role: "annotation" },5,{ calc: "stringify",
                sourceColumn: 5,
                type: "string",
                role: "annotation" },6,{ calc: "stringify",
                    sourceColumn: 6,
                    type: "string",
                    role: "annotation" },7,{ calc: "stringify",
	                    sourceColumn: 7,
	                    type: "string",
	                    role: "annotation" },8,{ calc: "stringify",
		                    sourceColumn: 8,
		                    type: "string",
		                    role: "annotation" },9,{ calc: "stringify",
			                    sourceColumn: 9,
			                    type: "string",
			                    role: "annotation" },10,{ calc: "stringify",
				                    sourceColumn: 10,
				                    type: "string",
				                    role: "annotation" },11,{ calc: "stringify",
					                    sourceColumn: 11,
					                    type: "string",
					                    role: "annotation" },12,{ calc: "stringify",
						                    sourceColumn: 12,
						                    type: "string",
						                    role: "annotation" },]);*/
	 
   var options = {
     title: 'PDC ON HAND',
     curveType: 'function',
     legend: { position: 'top', textStyle: { fontSize: 9} },
     pointSize: 3,
     'is3D':true,
    
	      pointSize:10,
	      
	      'height': 300,
	      'vAxis': {title: 'Value->',titleTextStyle: {italic: false},viewWindow:{ min:0},format: 'short'} ,
	      'hAxis': {title: 'Division->',
		        titleTextStyle: {italic: false},
		        //viewWindow:{ min:1},ticks:[{v:1,f:"Jan"},{v:2,f:"Feb"},{v:3,f:"Mar"},{v:4,f:"Apr"},{v:5,f:"May"},{v:6,f:"Jun"},{v:7,f:"Jul"},{v:8,f:"Aug"},{v:9,f:"Sep"},{v:10,f:"Oct"},{v:11,f:"Nov"},{v:12,f:"Dec"}],
				// format: '#'
				 } 
	    , isStacked:true
    
   };

   var chart = new google.visualization.ColumnChart(document.getElementById('curve_chart'));

   chart.draw(view, options);
 }
 
 
 
 
 function formatNumber(num) {return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");}
 $(document).ready(function() {
	    $('#example').DataTable( {
	    	"paging":   true,
	        "ordering": true,
	        "info":     false,
	        "lengthMenu": [[-1, 5, 10, 15, 25], ["All", 5, 10, 15, 25 ]],
	     "footerCallback": function ( row, data, start, end, display ) {
	            var api = this.api(), data;
	 
	            // Remove the formatting to get integer data for summation
	            var intVal = function ( i ) {
	                return typeof i === 'string' ?
	                    i.replace(/[\$,]/g, '')*1 :
	                    typeof i === 'number' ?
	                        i : 0;
	            };
	 
	            // Total over all pages
	            var totalag1 = api
	                .column( 2 )
	                .data()
	                .reduce( function (a, b) {
	                    return intVal(a) + intVal(b);
	                }, 0 );
	            
	            var totalag2 = api
                .column( 3 )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );
	            
	            var totalag3 = api
                .column( 4 )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );
	            
	            var totalag4 = api
                .column( 5 )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );
            
            var totalag5 = api
            .column( 6 )
            .data()
            .reduce( function (a, b) {
                return intVal(a) + intVal(b);
            }, 0 );
            
            var totalag6 = api
            .column( 7 )
            .data()
            .reduce( function (a, b) {
                return intVal(a) + intVal(b);
            }, 0 );
	        
	            // Update footer
	                     $( api.column( 2).footer() ).html(formatNumber(totalag1));
	                     $( api.column(3 ).footer() ).html(formatNumber(totalag2));
	                     $( api.column( 4).footer() ).html(formatNumber(totalag3));
	                     $( api.column( 5 ).footer() ).html(formatNumber(totalag4));
	            		 $( api.column( 6).footer() ).html(formatNumber(totalag5));
	                     $( api.column( 7 ).footer() ).html(formatNumber(totalag6));
	            
	            
	        }
	    } );
	} );
 
 

   
   
</script>


 <!--  .graph activities end..  -->
 </head>
 <c:choose>
 <c:when test="${!empty fjtuser.emp_code and !empty fjtuser.sales_code and !empty fjtuser.subordinatelist  and fjtuser.checkValidSession eq 1}">
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
    
            <li><a href="DisionInfo.jsp"><i class="fa fa-pie-chart"></i><span>Division Sales Stages</span></a></li>
            <li><a href="DmInfo.jsp"><i class="fa fa-dashboard"></i><span>Sales Team Performance</span></a></li>
          
            <li   class="active"><a href="Receivables"><i class="fa fa-th"></i><span>Receivables</span></a></li>
           
           <!--   <li><a href="#"><i class="fa fa-edit"></i><span>Inventory Aging</span></a></li>
            <li><a href="#"><i class="fa fa-book"></i><span>P&L and Operating Expenses</span></a></li>-->
     
        
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>


    <!-- Main content -->  
	   <div class="content-wrapper" style="margin-top: -8px;">
	   
	   
	   
	   


 
    
    
    
          <div class="row">
        <div class="col-md-12">
          <div class="box box-danger" style="margin-top:15px;">
            <div class="box-header with-border"><c:forEach var="rcvbl_list_date"  items="${DORAR}" > <c:set var="rcvble_date" value="${rcvbl_list_date.pr_date}" scope="page" /> </c:forEach>
                <c:set var ="recievable_date" value = "${fn:substring(rcvble_date, 0, 10)}" />
              <h3 class="box-title">Outstanding Receivable Aging (Value in base local currency)</h3><i> As on 
<fmt:parseDate value="${rcvble_date}" var="theDate" 
     pattern="yyyy-MM-dd HH:mm" />
<fmt:formatDate value="${theDate}" pattern="dd-MM-yyyy, HH:mm"/>
   AM</i>
 

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
                <th>S.Egr: Code</th>
                <th>Sales Egr: Name</th>
                <th>>30 Days</th>
                <th>30-60 Days</th>
                <th>60-90 Days</th>
                <th>90-120 Days</th>
                <th>120-180 Days</th>
                <th>>180 Days</th>
             
                
            </tr>
        </thead>
        <tbody>
        
        <c:set var="ag1" value="${0}" scope="page" />
		<c:set var="ag2" value="${0}" scope="page" />
		<c:set var="ag3" value="${0}" scope="page" />
		<c:set var="ag4" value="${0}" scope="page" />
		<c:set var="ag5" value="${0}" scope="page" />
		<c:set var="ag6" value="${0}" scope="page" />
        <c:forEach var="rcvbl_list"  items="${DORAR}" >
 		    <tr>
 		    
 		    
 		    <c:set var="ag1" value="${ag1 + rcvbl_list.aging_1}" scope="page" />
			<c:set var="ag2" value="${ag2 + rcvbl_list.aging_2}" scope="page" />
			<c:set var="ag3" value="${ag3 + rcvbl_list.aging_3}" scope="page" />
			<c:set var="ag4" value="${ag4 + rcvbl_list.aging_4}" scope="page" />
			<c:set var="ag5" value="${ag5 + rcvbl_list.aging_5}" scope="page" />
			<c:set var="ag6" value="${ag6 + rcvbl_list.aging_6}" scope="page" />
                <td>${rcvbl_list.sm_code}</td>
                <td>${rcvbl_list.sm_name}</td>
                <td align="right"><fmt:formatNumber pattern="#,##0" value="${rcvbl_list.aging_1}" /></td>
                <td align="right"><fmt:formatNumber pattern="#,##0" value="${rcvbl_list.aging_2}" /></td>
                <td align="right"><fmt:formatNumber pattern="#,##0" value="${rcvbl_list.aging_3}" /></td>
                <td align="right"><fmt:formatNumber pattern="#,##0" value="${rcvbl_list.aging_4}" /></td>
                <td align="right"><fmt:formatNumber pattern="#,##0" value="${rcvbl_list.aging_5}" /></td>
                <td align="right"><fmt:formatNumber pattern="#,##0" value="${rcvbl_list.aging_6}" /></td>
            </tr>
        </c:forEach>    
        </tbody>
        <tfoot>
            <tr>
                <th colspan="2" style="text-align:right;color:red;">Total:</th>
                <th ></th> <th ></th>
                <th ></th> <th ></th>
                <th ></th> <th ></th>
            </tr>
        </tfoot>
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
    
    	<div class="row">
    	<div class="col-md-12"> <div id="curve_chart" ></div></div>
    	
    	
    	</div>
 		  
     	
	<!--  modal end -->
	<!--  <div id="laoding" class="loader" ><img src="resources/images/wait.gif"></div>-->
    
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