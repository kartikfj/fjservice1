<%-- 
    Document   : SIP user actvity history  
--%>
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
  String currCalDtTime = dateFormat.format(cal.getTime());
  request.setAttribute("CURR_YR",iYear);
  request.setAttribute("MTH",month);
  request.setAttribute("currCal", currCalDtTime);

  
 %>
<!DOCTYPE html>

<html><head>
<script>
$(document).ready(function() {  $('.select2').select2();
	 $('#laoding').hide(); } ); 
	 </script>
<style>


.loader {position: fixed; z-index: 999; height: 2em;width: 2em;overflow: show; margin: auto; top: 0;left: 0;bottom: 0; right: 0;}
.loader:before { content: '';display: block;position: fixed;top: 0; left: 0;width: 100%; height: 100%; background-color: rgba(0,0,0,0.3);}
.small-box { border-radius: 2px;position: relative; display: block; margin-top: 10px; box-shadow: 0 1px 1px rgba(0,0,0,0.1);}
.bg-activity {background-color: #ffffff !important; color: black;border: 1px solid #607D8B;}
.activity-sapn{font-size: 80%;font-weight: 600;}
#smonth{margin-left: -5px;border-radius: 5px;height: 29px;border: 1px solid #aba8a7;width: 75px;}
.small-box>.small-box-footer { position: relative; text-align: center; padding: 3px 0;  color: #fff;color: rgba(255,255,255,0.8);display: block; z-index: 10; background: rgba(0,0,0,0.1);text-decoration: none;}
.small-box .icon { -webkit-transition: all .3s linear; -o-transition: all .3s linear; transition: all .3s linear; position: absolute; top: 5px; right: 10px; z-index: 0; font-size: 75px; color: rgba(0,0,0,0.15);}
.small-box p { z-index: 5;} .small-box p { font-size: 15px;} .small-box>.inner { padding: 10px;} .small-box h3, .small-box p {z-index: 5;}
.small-box h3 { font-size: 2em; font-weight: bold; margin: 0 0 10px 0; white-space: nowrap; padding: 0;}
#chart_div, #prf_summ_billing_ytd, #prf_summ_booking_ytd, #stages{position: relative;border-radius: 3px; border-top: 3px solid #065685; margin-bottom: 20px; box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12);}
.stage{ background-color: #065685;color: white; border: 1px solid #065685;}
.navbar { margin-bottom: 8px !important;} 
.table{display: block !important; overflow-x:auto !important;}
#db-title-boxx{background: white; height: auto;; margin-top: -9px; margin-left: -10px; margin-right: -10px; box-shadow: 0 0 4px rgba(0,0,0,.14), 0 4px 8px rgba(0,0,0,.28);}


   
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


.box-footer{padding:1px;}

.dataTables_wrapper .dataTables_info{    color: #2196F3 !important;
    font-size: 10px !important;
    font-weight: bold !important;}
	
	.dataTables_wrapper .dataTables_paginate .paginate_button.disabled {color: #fff !important;
   
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


.box-primary ,.box-danger,.box-success { border-top-color: #ffffff !important; }
.box-header.with-border {
   /* border-bottom: 1px solid #f4f4f4;*/
   border-bottom: none !important;
}


</style>

<link rel="stylesheet" href="resources/bower_components/font-awesome/css/font-awesome.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="resources/dist/css/AdminLTE.min.css">
<link rel="stylesheet" href="resources/dist/css/skins/_all-skins.min.css">
<link rel="stylesheet" type="text/css" href="resources/datatables/datatables-fjtco/css/jquery.dataTables.min.css" />
<link rel="stylesheet" type="text/css" href="resources/datatables/buttons-fjtco/css/buttons.dataTables.min.css" />
<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.flash.min.js"></script>
<script type="text/javascript" src="resources/datatables/ajax/excelmake/jszip.min.js"></script>
<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/dataTables.buttons.min.js"></script>	
<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.html5.min.js"></script>
<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.print.min.js"></script>
<link rel="stylesheet" href="resources/bower_components/select2/dist/css/select2.min.css">



 <!--  .graph activities end..  -->
 </head>
 <c:choose>
 <c:when test="${!empty fjtuser.emp_code and (fjtuser.role eq 'mg' or fjtuser.salesDMYn ge 1 ) and fjtuser.sales_code ne null and !empty fjtuser.sales_code  and fjtuser.checkValidSession eq 1}">
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
		              <li><a href="CompanyInfo.jsp"><i class="fa fa-pie-chart"></i><span>Division Performance</span></a></li>
		              <li class="active"><a href="SipUserActivity"><i class="fa fa-table"></i><span>S.Eng. Activity History</span></a></li>
<!-- 					  <li><a href="SipJihDues"><i class="fa fa-table"></i><span>JIH Dues</span></a></li>    -->
					  <li><a href="SipStageFollowUpController"><i class="fa fa-database"></i><span>Stage Follow-Up</span></a></li>
					  <li><a href="sipWeeklyReport"><i class="fa fa-bar-chart"></i><span>Weekly-Sales Report</span></a></li>
					  <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>
               </c:when>
               <c:when test="${fjtuser.salesDMYn ge 1 and fjtuser.sales_code ne null}">
	                  <c:if test="${fjtuser.role eq 'gm'}">
	      		 	  <li><a href="SipBranchPerformance"><i class="fa fa-building-o"></i><span>Branch Performance</span></a></li>
	      			  </c:if>
	                  <li><a href="DmInfo.jsp"><i class="fa fa-dashboard"></i><span>Sales Engineers Performance</span></a></li>
		              <li><a href="DisionInfo.jsp"><i class="fa fa-line-chart"></i><span>Sub Division Performance</span></a></li>
		              <li><a href="CompanyInfo.jsp"><i class="fa fa-pie-chart"></i><span>Division Performance</span></a></li>
		              <li class="active"><a href="SipUserActivity"><i class="fa fa-table"></i><span>S.Eng. Activity History</span></a></li>
<!-- 					  <li><a href="SipJihDues"><i class="fa fa-table"></i><span>JIH Dues</span></a></li>   -->
					  <li><a href="SipStageFollowUpController"><i class="fa fa-database"></i><span>Stage Follow-Up</span></a></li>
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


    <!-- Main content -->  
	   <div class="content-wrapper" style="margin-top: -8px;">
	  
                    <div class="box-body">
                       <div class="row">
       
        <div class="col-lg-12 col-md-12">
          <!-- small box -->
          <div class="small-box bg-activity">
            <div class="inner">
              <h4 class="aIf-aLe" style="padding-bottom: 5px;border-bottom: 3px #795548 solid; color: black;">Sales Engineer's Dashboard Activity History
              <span class="form-group form-inline pull-right activity-sapn" >
                 
                  <select class="form-control select2" style="width: max-content !important;" name="scode" id="scode" onchange="showLCAccptncPndng(); required ">
  <c:if test="${empty fjtuser.subordinatelist}">
  <c:forEach var="s_engList"  items="${SEngLst}" >
					  	<option value="${s_engList.salesman_emp_code}" ${s_engList.salesman_emp_code  == selected_salesman_emp_code ? 'selected':''}>  ${s_engList.salesman_name}</option>
  </c:forEach>
  </c:if>
  						
  						 <c:if test="${!empty fjtuser.subordinatelist}">
  						 <option selected value="${fjtuser.emp_code}"> ${fjtuser.uname}</option>
  						 
   						 <c:choose>
  						 <c:when test="${fjtuser.sales_code eq 'MG001' or fjtuser.sales_code eq 'MG002'}">
   						<c:forEach var="s_engList"  items="${SEngLst}" >
   						<c:set var="sales_egr_code" value="${selected_salesman_code}" scope="page" /> 
					  	<option value="${s_engList.salesman_emp_code}" ${s_engList.salesman_emp_code  == selected_salesman_code ? 'selected':''}>${s_engList.salesman_name} </option>
					  	</c:forEach>
					  	</c:when>
					  	<c:otherwise>
					  	<c:forEach var="s_engList"  items="${SEngLst}" >
					  	<c:set var="sales_egr_code" value="${selected_salesman_code}" scope="page" /> 
					  	<option value="${s_engList.salesman_emp_code}" ${s_engList.salesman_emp_code  == selected_salesman_code ? 'selected':''}> ${s_engList.salesman_name}</option>
					  	</c:forEach>
					  	</c:otherwise>
					  	</c:choose>
					  	</c:if>
						</select>
						  <select class="form-control form-control-sm" name="smonth" id="smonth"  required>
  						<option  value="${SLCTEDMTH}">${SLCTEDMTH}</option>
  						<option  value="Jan">Jan</option>
  						<option  value="Feb">Feb</option>
  						<option  value="Mar">Mar</option>
  						<option  value="Apr">Apr</option>
  						<option  value="May">May</option>
  						<option  value="Jun">Jun</option>
  						<option  value="Jul">Jul</option>
  						<option  value="Aug">Aug</option>
  						<option  value="Sep">Sep</option>
  						<option  value="Oct">Oct</option>
  						<option  value="Nov">Nov</option>
  						<option value="Dec">Dec</option>
						</select>
						<button id="sbmtUsrHstry" name="sbmtUsrHstry"   type="button" class="btn btn-sm btn-primary" onclick="showUserHistory();">Query</button>
                </span>
              </h4>

     
            </div>
          
           
          </div>
        </div>
        <div class="col-md-12">
                <div id="preLoadtablehead" style="width: max-content;border: 1px solid #03A9F4;background: white;">
                <table id="userActivity_table" class="table table-bordered table-striped small">
                  <thead>
                  <tr>
                    <th>S.No.</th> <th> Name </th> <th>Date</th><th>Company</th> <th>Division</th> <th>Logged in Time</th>
                   
                  </tr>
                  </thead>
                  <tbody>
                 <c:set var="actvty_count" value="0" scope="page" />
                 <c:if test="${!empty DBUAH or DBUAH ne null}">
               <c:forEach var="userActivityReport" items="${DBUAH}">
                <c:set var="actvty_count" value="${actvty_count + 1}" scope="page" />               
				<tr>
				<td>${actvty_count}</td>
				<td>${userActivityReport.d3}</td>				
				<fmt:parseDate value="${userActivityReport.d1}" var="workDate"    pattern="yyyy-MM-dd" />
			    <td><fmt:formatDate value="${workDate}" pattern="dd/MM/yyyy"/>  </td>
				<td>${userActivityReport.d5}</td>
				<td >
				${userActivityReport.d6}
				</td>
				<td>
			<c:set var='firstTm' value='${userActivityReport.d4}'/>
							${fn:substring(firstTm, 10, 16)}
				
				 </td>
				
				</tr>
				</c:forEach>
               	</c:if>
               
             
                  </tbody>
                </table>
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
      <b>Version</b> 3.0.0
    </div>
    <strong>Copyright &copy; 1988-${CURR_YR} <a href="http://www.faisaljassim.ae/">Faisal Jassim Group</a>.</strong> All rights
    reserved.
  </footer>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Create the tabs -->
    <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
      <li><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
      <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
    </ul>
    
  </aside>
  <div class="control-sidebar-bg"></div>

</div>
</div>
<script type="text/javascript">



function showUserHistory(){
	
	  var dataPst1=$.trim($("#scode").val());
	  var dataPst2=$.trim($("#smonth").val());
	 // alert(dataPst1+" "+dataPst2);

	 var exclTtl="Dashboard User Activity History";
	
	 $.ajax({ type: 'POST',url: 'SipUserActivity',  data: {octjf: "sltdauwm",edoCpme:dataPst1,htmcust:dataPst2}, dataType: "json",
	 success: function(data) {
		
		
		
		 var output="<table id='custUsrActvty-table' class='table table-bordered table-striped small display' style='width:100%'> "+
		            "<thead><tr><th>S No.</th><th>Name</th><th>Date</th><th>Company</th><th>Division</th>"+
	                "<th>Logged-In Time</th>"+
	                "</tr></thead><tbody>";  
       var j=0;
       var lastUsedTime;
       for (var i in data) { 
    	   if (typeof data[i].d6 !== 'undefined'){
    		   lastUsedTime =data[i].d6.slice(11, 16); 
    	   }else{
    		   lastUsedTime =data[i].d5.slice(11, 16);
    	   }
    	   //alert(data[i].d3);
    	   j=j+1;
	 output+="<tr><td>"+j+"</td><td>" + data[i].d3 + "</td>"+"<td>" + $.trim(data[i].d1.substring(0, 10)).split("-").reverse().join("/")  + "</td><td>" + data[i].d5+ "</td>"+ "<td>" + data[i].d6 + "</td><td>" + data[i].d4.slice(11, 16) + "</td>"+
	 "</tr>"; } ;
	 output+="</tbody></table>";

	 $("#preLoadtablehead").html(output);	
	 $('#custUsrActvty-table').DataTable( {
	    	"paging":   true,
	        "ordering": true,
	        "info":     false,
	        "searching": false,
	         dom: 'Bfrtip',  
	         buttons: [
	            {
	                extend: 'excelHtml5',
	                exportOptions: {
	                	   columns: ':not(.noShow):visible'
	                	},
	                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 1.5em;">Export</i>',
	                filename: exclTtl,
	                title: exclTtl,
	                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	           
	        ]
	    } );
	 $('#laoding').hide(); 
		},error:function(data,status,er) {$('#laoding').hide();  alert("please click again");}});
}

function preLoader(){ $('#laoding').show();}
$(document).ready(function() {
	$('#userActivity_table').DataTable( {
        dom: 'Bfrtip',
        "paging":   true,
        "ordering": false,
        "info":     false,
        "searching": false,
        buttons: [
            {
                extend: 'excelHtml5',
                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
                filename: 'Dashboard User Activity History',
                title: 'Dashboard User Activity History',
                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
                
                
            }
          
           
        ]
    } );
});
</script>
<script src="resources/bower_components/fastclick/lib/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="resources/dist/js/adminlte.min.js"></script>
<script src="resources/bower_components/select2/dist/js/select2.full.min.js"></script>

<!-- page script -->

</body>


</c:when>
<c:otherwise>
        <body onload="window.top.location.href='logout.jsp'">
        </body>
     
    
</c:otherwise>

</c:choose>
</html>