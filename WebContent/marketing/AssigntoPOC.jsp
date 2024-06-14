<%-- 
    Document   : MARKETING LEAD
    Created on : January 10, 2019, 10:06:00 AM
    Author     : Nufail Achath
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<% 
        response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
        response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
        response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
        response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
%>
<jsp:useBean id="fjtuser" class="beans.fjtcouser" scope="session"/>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%
  DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
  Calendar cal = Calendar.getInstance();
  int week = cal.get(Calendar.WEEK_OF_YEAR);
  int iYear = cal.get(Calendar.YEAR);  
  String currCalDtTime = dateFormat.format(cal.getTime());
  request.setAttribute("CURR_YR",iYear);
  request.setAttribute("currCal", currCalDtTime);
  request.setAttribute("currWeek", week);
  
 %>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title>Faisal Jassim Trading Co L L C</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="././resources/abc/style.css" rel="stylesheet" type="text/css" />
	<link href="././resources/abc/responsive.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="././resources/abc/bootstrap.min.css">
	<script src="././resources/abc/jquery.min.js"></script>
	<script src="././resources/abc/bootstrap.min.js"></script>
	<script src="././resources/js/mainview.js"></script>
	<link href="././resources/css/multiple_product_list.css" rel="stylesheet" type="text/css" />
	<script src="././resources/js/multiple_product_list.js"></script>
<!-- 	<script type="text/javascript" src="././resources/js/mkt-supportrequest.js?v=290620200"></script> -->
    <link rel="stylesheet" href="././resources/bower_components/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="././resources/dist/css/skins/_all-skins.min.css">
	<link rel="stylesheet" type="text/css" href="././resources/datatables/datatables-fjtco/css/jquery.dataTables.min.css" />
	<link rel="stylesheet" type="text/css" href="././resources/datatables/buttons-fjtco/css/buttons.dataTables.min.css" />
	<script type="text/javascript" src="././resources/datatables/datatables-fjtco/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="././resources/datatables/datatables-fjtco/js/dataTables.buttons.min.js"></script>
	<script type="text/javascript" src="././resources/datatables/buttons-fjtco/js/buttons.flash.min.js"></script>
	<script type="text/javascript" src="././resources/datatables/ajax/excelmake/jszip.min.js"></script>
	<script type="text/javascript" src="././resources/datatables/buttons-fjtco/js/buttons.html5.min.js"></script>
	<script type="text/javascript" src="././resources/datatables/buttons-fjtco/js/buttons.print.min.js"></script>
	<link rel="stylesheet" href="././resources/bower_components/datepicker/dist/css/bootstrap-datepicker.min.css">
  <!-- Theme style -->
    <link rel="stylesheet" href="././resources/bower_components/select2/dist/css/select2.min.css">
    <link rel="stylesheet" href="././resources/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="././resources/dist/css/skins/_all-skins.min.css">
    <link rel="stylesheet" href="././resources/css/mkt-layout.css?v=31032020">

</head>
<body class="hold-transition skin-blue sidebar-mini">
 <c:if test="${empty fjtuser.emp_code}"> <jsp:forward page="logout.jsp"/> </c:if>
 <c:choose>
 <c:when test="${!empty fjtuser.emp_code and  ( fjtuser.role eq 'mkt' or fjtuser.role eq 'mg' or fjtuser.sales_code ne null )  and fjtuser.checkValidSession eq 1  }">	 
<div class="wrapper">

  <header class="main-header">
    <!-- Logo -->
    <a href="././homepage.jsp" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>FJ</b>M</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg">
          <img src="././resources/images/logo_t5.jpg" height="49px" class="img-circle pull-left"  alt="Logo"><b>Marketing</b>
      </span>
    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>

      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
    
          <!-- User Account: style can be found in dropdown.less -->
          <li class="dropdown user user-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-user-circle"></i>
              <span class="hidden-xs"><c:out value="${fjtuser.uname}"/></span>
            </a>
          
          </li>
           <%--Settings--%>
          <li class="dropdown notifications-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-gears"></i>
            </a>
            <ul class="dropdown-menu">
              <li class="header"><a  href="logout.jsp"> <i class="fa fa-power-off"></i> Log-Out</a></li>      
            </ul>
          </li>
          
        </ul>
      </div>
    </nav>
  </header>
  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- Sidebar user panel -->
      <!-- search form -->
      <form action="#" method="get" class="sidebar-form">
        <div class="input-group">
          <input type="text" name="q" class="form-control" placeholder="Search...">
          <span class="input-group-btn">
                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                </button>
              </span>
        </div>
      </form>
      <!-- /.search form -->
      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu" data-widget="tree">
         <c:if test="${fjtuser.emp_code eq 'E004272' || fjtuser.emp_code eq 'E003066'}">
	         <li><a href="MktDashboard"><i class="fa fa-dashboard"></i><span>Dashboard - Sales Leads</span></a></li>
	         <li ><a href="SalesLeads"><i class="fa fa-pie-chart"></i><span>Sales Leads Details</span></a></li>
         </c:if>
<%--          <c:if test="${!empty fjtuser.emp_code and  ( fjtuser.role eq 'mkt' )  and fjtuser.checkValidSession eq 1  }"> --%>
         	<li class="active"><a href="AssignToPOC"><i class="fa fa-table"></i><span> Assign task to POC </span></a></li>
<%--          </c:if> --%>
<%--           <c:if test="${!empty service.rows}">   --%>
         	<li><a href="SupportRequest"><i class="fa fa-table"></i><span> BDM Support Request </span></a></li>
<%--          </c:if>          --%>
         <li><a href="ProjectLeads"  class="active"><i class="fa fa-columns"></i><span>Project Stages 0 & 1</span></a></li>
         <li><a href="ProjectStatus"><i class="fa fa fa-bars"></i><span>Project Status</span></a></li>
		 <li><a href="ConsultantVisits"><i class="fa fa-columns"></i><span>Consultant Visits</span></a></li> 
		 <li><a href="ConsultantLeads"><i class="fa fa-line-chart"></i><span>Consultant Approval Status</span></a></li>
         <li><a href="ConsultantProductReport"><i class="fa fa-columns"></i><span>Consultant Product Dashboard</span></a></li>    
         <li><a href="././homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>     
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>Assign the task to POC<small>Marketing Portal</small> </h1>
      <ol class="breadcrumb">
        <li><a href="homepage.jsp"><i class="fa fa-calendar"></i> Home</a></li>
        <li class="active">Marketing</li>
      </ol>
    </section>
    <!-- Main content -->
    <section class="content">	
	<div class="row">
        <div class="col-xs-12">
          <div class="box box-default">
            <div class="box-header with-border">
             Assign task to POC's
              <c:if test="${fjtuser.role eq 'mkt' and fjtuser.sales_code ne null}">
              <button type="button" class="btn btn-sm btn-dark pull-right" data-toggle="modal" data-target="#modal-default">
                <i class="fa fa-plus"> </i> Assign the task to POC's
              </button>
             </c:if>
            </div>
            <div class="box-body">
               <table class="table table-hover small marketing-dtls-table" id="displayLeadss" style="border-top: 1px solid #4a46465e !important;" >		        		 
		       <thead>
		        <tr>	
		         <th width="35px;">Request Code</th><th width="35px;">Task Name</th>	        			    
		        <th width="45px;">Assigned to</th>
		        <th width="35px;">Initial Remarks</th>	        
		        <th  width="45px;">Ack. Status by SE.</th> 
		        <th width="45px;">SE. Follow-Up Status</th><th width="45px;">Mkt. Final Status</th>
		         <th  width="65">Action</th>
		        </tr>
		        </thead>
		        <tbody>
		        <c:forEach var="requestList"  items="${SRLIST}" >
		        <tr>	
		        <td>FJMPOC ${requestList.id}</td> <td>${requestList.bdmTaskName}</td><td>${requestList.seName}</td> 
		        <td>${requestList.initialReamrks}</td>
		        <td>
		        <c:choose>
		        <c:when test="${requestList.p2Status eq 0}">
		        <b style="color:blue;">Pending</b>
		        </c:when>
		        <c:when test="${requestList.p2Status eq 1}">
		           <b style="color:green;">Accepted / Initiated</b>
		         </c:when>
		           <c:when test="${requestList.p2Status eq 3}">
		            <b style="color:red;">Others</b>
		         </c:when>
		        <c:otherwise>
		        <b style="color:red;">Declined</b>
		        </c:otherwise>
		        
		        </c:choose>
		        </td>
		        <td>
		         <c:choose>
		        <c:when test="${requestList.p3Status eq 1}">
		           <b style="color:green;">Completed</b>
		         </c:when>
		          <c:when test="${requestList.p2Status gt  1}">
		           <b>N/A</b>
		         </c:when>
		           <c:when test="${requestList.p2Status eq 1 and requestList.p3Status eq 0}">
		         <b style="color:blue;">Pending</b>
		         </c:when>
		        <c:otherwise>
		        <b>-</b>
		        </c:otherwise>		        
		        </c:choose> 
		        </td>
		        <td>
		         <c:choose>
		        <c:when test="${requestList.p4Status eq 1}">
		           <b style="color:green;">Closed</b>
		         </c:when>
		         <c:when test="${requestList.p2Status eq 1 and requestList.p3Status eq 1 and requestList.p4Status eq 0}">
		           <b style="color:blue;">Pending</b>
		         </c:when>
		         <c:when test="${requestList.p2Status gt 1  and requestList.p4Status eq 0}">
		           <b style="color:blue;">Pending</b>
		         </c:when>		         
		         <c:when test="${requestList.p2Status eq 0  and requestList.p4Status eq 0}">
		           <b>-</b>
		         </c:when>
		        <c:otherwise>
		        <b>-</b>
		        </c:otherwise>
		        
		        </c:choose> 
		        </td> 
		        <td>        
		         <%-- Edit --%> 
		         <form action="AssignToPOC" method="POST" style="display: inline !important;" name="gs_form_delete">
				   	 <input type="hidden" value="${requestList.id}" name="srdi" />
				   	 <input type="hidden" name="p1" value="${requestList.p1Status}" />
				   	 <input type="hidden" name="p2" value="${requestList.p2Status}" />
				   	 <input type="hidden" name="p3" value="${requestList.p3Status}" />
				   	 <input type="hidden" name="p4" value="${requestList.p4Status}" />
				   	 <input type="hidden" name="edocpmees" value="${requestList.bdmEmpCode}" />
					   <c:choose>
					   <c:when test="${fjtuser.role eq 'mkt' and  requestList.p1Status eq 1 and ((requestList.p2Status eq 0 && requestList.p3Status eq 0 ) or (requestList.p2Status eq 1 && requestList.p3Status eq 0 )) and requestList.p4Status eq 0}">
					     <input type="hidden" name="action" value="view" />
					     <button type="submit"  class="btn btn-primary btn-xs" style="margin-bottom:3px;">
					      <i class="fa fa-eye" aria-hidden="true"></i>View</button>	
					   </c:when>
					   <c:when test="${fjtuser.role ne 'mkt' and requestList.p1Status eq 1 and requestList.p2Status eq 0 and  requestList.p3Status eq 0}"> 
					    <input type="hidden" name="action" value="edit" />
					   <button type="submit"  class="btn btn-primary btn-xs" style="margin-bottom:3px;">
					      <i class="fa fa-edit" aria-hidden="true"></i>Acknowledge</button>
					    </c:when>
					     <c:when test="${fjtuser.role ne 'mkt' and requestList.p1Status eq 1 and requestList.p2Status eq 1 and  requestList.p3Status eq 0   }"> 
					    <input type="hidden" name="action" value="edit" />
					   <button type="submit"  class="btn btn-primary btn-xs" style="margin-bottom:3px;">
					      <i class="fa fa-edit" aria-hidden="true"></i>follow-Up</button>
					    </c:when>
					   <c:when test="${fjtuser.role eq 'mkt' and requestList.p1Status eq 1 and requestList.p2Status eq 1 and  requestList.p3Status eq 1 and requestList.p4Status eq 0}">
					    <input type="hidden" name="action" value="edit" />
					   <button type="submit" id="mkld"  class="btn btn-primary btn-xs" style="margin-bottom:3px;">Close Request</button>
					   </c:when>
					   <c:otherwise>
					     <input type="hidden" name="action" value="view" />
					     <button type="submit" class="btn btn-primary btn-xs" style="margin-bottom:3px;">
					      <i class="fa fa-eye" aria-hidden="true"></i>View</button>		   
					    </c:otherwise>
					   </c:choose>		 
				 </form>
				<%-- /Edit --%> 
				<%-- Delete --%> 
				<c:if test="${requestList.p1Status eq 1 and requestList.p2Status eq 0 and requestList.p3Status eq 0 and requestList.p4Status eq 0  and fjtuser.role eq 'mkt' and fjtuser.emp_code eq requestList.seEmpCode}">
		   		 <form action="AssignToPOC" method="POST" style="display: inline !important;" name="support_form_delete">
				   	 <input type="hidden" value="${requestList.id}" name="srdi" />
				   	 <input type="hidden" value="${requestList.seEmpCode}" name="seempcode" />
				     <input type="hidden" name="action" value="delete" />
				     <button type="submit"   class="btn btn-danger btn-xs"  onclick="if (!(confirm('Are You sure You Want to delete this support request!'))) return false" >
					 <i class="fa fa-trash" aria-hidden="true"></i> Delete
					 </button>
				 </form>
				 </c:if>
			   <!-- /Delete -->						        	   
		        </td>
		     
		        </tr>
		        </c:forEach>
		        
		        </tbody>
		     </table>
		     <c:if test="${!empty MSG }">
		     <br/><div class="alert alert-success" role="alert">
				  ${MSG}
				</div>
			</c:if>
            </div>
          </div>
        </div>
      </div>
	
	
		
	
			          
	  <!-- modal -->
      <div class="modal fade" id="modal-default" data-backdrop="static" data-keyboard="false">
          <div class="modal-dialog modal-lg" style="width: 85%;">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Assign to POC Form</h4>
              </div>
              <div class="modal-body">
                <form role="form" action="AssignToPOC" method="post" id="processOne" name="processOne">
		  		 <input type="hidden" name="action" value="new" /> 
		  		 
			        <!--  Process - 1 -->
			        <div class="row mkt-form-row-border">
			          <div class="col-md-3">
			            <div class="form-group">
			              <label>Task Name:</label>
			              <input type="text" class="form-control" name="taskName" >
			            </div>
			           </div>
			          
			          <div class="col-md-3">
			          <div class="form-group">
			              <label>Sales Engineer:</label>
			              <select class="form-control" style="width: 100%;" id="seEmpCode" name="seEmpCode" required>
			                <option value="" >Select Sales Engineer</option>
		                      <c:forEach var="poclist"  items="${POCLIST}" >					
								 <option value="${poclist.salesman_code}" role="${poclist.salesman_name}">${poclist.salesman_name}</option>
							  </c:forEach>
			              </select>
			            </div>          
			          </div>
			           <div class="col-md-3">
			            <div class="form-group">
			                <label>Remarks:</label> 
				           <textarea  class="form-control" name="remarks" required></textarea>
			            </div>
			           </div>
			          <!-- /.col -->
			        </div>
			        <!-- /.row -->
			        <!-- /.Process-1  -->
	                 <div class="box-footer">
	                 <input type="hidden" name="seEmpname" id="salesEngName"/>
	                 <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>    
	                 <button type="submit" class="btn btn-primary pull-right"  onclick="getSeletedval1();" ><i class="fa fa-paper-plus"></i> Assign</button>
	                </div>
           		 </form>
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
          <div id="laoding" class="loader" ><img src="././resources/images/wait.gif"></div>
        </div>
        <!-- /.modal -->
    
      
    </section>
    <!-- /.content -->
   </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <div class="pull-right hidden-xs">
      <b>Version</b> 1.0.0
    </div>
    <strong>Copyright &copy; 1988-${CURR_YR} <a href="http://www.faisaljassim.ae">FJ-Group</a>.</strong> All rights
    reserved.
  </footer>

</div>

<script src="././resources/bower_components/datepicker/dist/js/bootstrap-datepicker.min.js"></script>
<script src="././resources/bower_components/select2/dist/js/select2.full.min.js"></script>
<script src="././resources/bower_components/fastclick/lib/fastclick.js"></script>
<script src="././resources/dist/js/adminlte.min.js"></script>
<!-- page script start -->
<!-- page Script  end -->
<script>
//TO AVOID RE-SUBMISSION END
$(document).ready(function() {
	var newDate = new Date();
	var currentYear = newDate.getFullYear();
	 if ( window.history.replaceState ) {//script to avoid page resubmission of form on reload
	        window.history.replaceState( null, null, window.location.href );
	    }
	 $('#laoding').hide();
	 
	 $('#processOne').submit(function(evnt) {
		 if ((confirm('Are You sure You Want to assign this task to POC?'))) { 
			 preLoader();
			 return true;
			 }
		 else{return false;}
		});
	 $('#processTwo').submit(function(evnt) {
		 if ((confirm('Are You sure, You Want to acknowledge this request!'))) { 
			 preLoader();
			 return true;
			 }
		 else{return false;}
		});
	 $('#processThree').submit(function(evnt) {
		 if ((confirm('Are You sure, You Want to submit follow-up to BDM!'))) { 
			 preLoader();
			 return true;
			 }
		 else{return false;}
		});
	 $('#processFour').submit(function(evnt) {
		 if ((confirm('Are You sure, You Want to close this task!'))) { 
			 preLoader();
			 return true;
			 }
		 else{return false;}
		});
    
    //dynamic select tag division to product mapping
//     $('#productsOpt').multiselect({
//     	nonSelectedText: 'Select Products',
//         includeSelectAllOption: true
//     });
    //getProducts();
    
    $('#displayLeads').DataTable( {
        dom: 'Bfrtip',
        "paging":   true,
        "ordering": false,
        "info":     false,
        "searching": true,
        "lengthMenu": [[ 5, 10, 15, 25, -1], [ 5, 10, 15, 25, "All" ]], 
         columnDefs:[{targets:[4,8,9, 10,12, 14,  15,   17, 18],className:"remove"},
        {targets:[0,1, 2, 3, 5, 6, 7, 11,13 ,16],className:"truncate"}],
        createdRow: function(row){
           var td = $(row).find(".truncate");
           td.attr("title", td.html());
      },
        buttons: [
            {
                extend: 'excelHtml5',
                text:      '<i class="fa fa-cloud-download" style="color: green; font-size: 1.5em;">Export</i>',
                filename: "Support Request Details - "+currentYear,
                title: "Support Request  Details -  "+currentYear,
                messageTop: 'The information in this file is copyright to Faisal Jassim Group.',
                exportOptions: {
                    columns: ':not(:last-child)',
                  }
                
                
            }
          
           
        ]
    } );
   
});
function getSeletedval1(){
	selectElement = document.querySelector('#seEmpCode');
	var salesEngName = selectElement.options[selectElement.selectedIndex].role;	
	 document.getElementById("salesEngName").value =  salesEngName;
    var selectedValues = [];    
   
    return true;
    //alert(selectedValues);
   
  
}

</script>
</c:when>
<c:otherwise>

        <body onload="window.top.location.href='logout.jsp'">
   
            
        </body>
  
</c:otherwise>
</c:choose>
</body>
</html>