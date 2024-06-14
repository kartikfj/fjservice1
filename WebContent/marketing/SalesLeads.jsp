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
	<script type="text/javascript" src="././resources/js/mkt-salesleads.js?v=18062020"></script>
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
	<link href="././resources/css/jquery-ui.css" rel="stylesheet">
	<script src="././resources/js/jquery-ui.js"></script>
	<script src="././resources/bower_components/moment/moment.js"></script>	
		
  <!-- Theme style -->
    <link rel="stylesheet" href="././resources/bower_components/select2/dist/css/select2.min.css">
    <link rel="stylesheet" href="././resources/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="././resources/dist/css/skins/_all-skins.min.css">
    <link rel="stylesheet" href="././resources/css/mkt-layout.css?v=18052020">
  <script> 
  var defStartDate = '';var defEndtDate = '';  
  $(function(){ defStartDate = '${defaultStartDate}' ; defEndtDate = '${defaultEndDate}' ; var title ='FJ-Marketing dashboard sales lead  details   from';
  $("#fromdate").datepicker({ "dateFormat" : "dd-mm-yy", yearRange: "2020:2030"}); $("#todate").datepicker({"dateFormat" : "dd-mm-yy",maxDate : 0 }); 
   var table = $('#displayLeads').DataTable({   dom: 'Bfrtip', "paging":   true,
	  stateSave: true,	  
	   "ordering": false, "info":true, "searching": true,  "pageLength": 15,	    
   columnDefs:[{targets:[2,8,9,11,12,14,15,16,17,18,19,20,22,23],className:"remove"},
   {targets:[0,1,3,4,5,6,7,10,13,21],className:"truncate"}], 
   buttons: [{ extend: 'excelHtml5', text:      '<i class="fa fa-file-excel-o" style="color: #009688; font-size: 1.5em;">Export</i>', filename: title+' '+defStartDate+' to '+defEndtDate+'',
   title: title+' '+defStartDate+' to '+defEndtDate+'', messageTop: 'The information in this file is copyright to Faisal Jassim Group.', exportOptions: { columns: ':not(:last-child)', }}]} ); 
  
  table.on('click', 'tbody .quick-view', function(e){
       // Prevent event propagation
       e.stopPropagation();
       
       var $row = $(this).closest('tr');
       var data = table.row($row).data(); 
       var title = "<strong>Sales Lead : "+removeHtml(data[0])+" Deatils</strong>";
       var output="<table class='table table-bordered' style='display:flex;'>";
       output+="<tr><td><strong>Lead Code : </strong>"+removeHtml(data[0])+"</td><td><strong>Lead Type : </strong>"+data[1]+"</td></tr>"; 
       output+="<tr><td><strong>Division : </strong>"+data[2]+"</td><td><strong>Product : </strong>"+data[3]+"</td></tr>"; 
       output+="<tr><td colspan='2'><strong>Sales Eng. : </strong>"+data[4]+"</td></tr>"; 
       output+="<tr><td colspan='2'><strong>Project Details : </strong>"+data[5]+"</td></tr>";
       output+="<tr><td colspan='2'><strong>Contractor : </strong>"+data[6]+"</td></tr>";
       output+="<tr><td colspan='2'><strong>Consultant/Client : </strong>"+data[7]+"</td></tr>";
       output+="<tr><td><strong>Lead Remark : </strong>"+data[8]+"</td><td><strong>Lead Initiated On : </strong>"+data[9]+"</td></tr>";
       output+="<tr><td><strong>S.Eng. Ack. Remarks : </strong>"+data[11]+"</td><td><strong>S.Eng. Ack. Status/On : </strong>"+data[10]+"/"+data[12]+"</td></tr>"; 
       output+="<tr><td><strong>SE Follow-Up Status/On : </strong>"+data[13]+"/"+data[19]+"</td></tr>";
       output+="<tr><td colspan='2'><strong>SE Follow-Up Remarks : </strong>"+data[14]+"</td></tr>";
       output+="<tr><td colspan='2'><strong>Orion Project Code : </strong>"+data[15]+"</td></tr>";
       output+="<tr><td colspan='2'><strong>Offer Value (AED) : </strong>"+data[16]+"</td></tr>";
       output+="<tr><td><strong>LOI Received? : </strong>"+data[17]+"</td><td><strong>LPO Received? : </strong>"+data[18]+"</td></tr>";
       output+="<tr><td colspan='2'><strong>Orion Sales Order No. : </strong>"+data[19]+"</td></tr>";
       output+="<tr><td colspan='2'><strong>MKT. Lead Close Status : </strong>"+data[20]+"</td></tr>";
       output+="<tr><td colspan='2'><strong>MKT. Final Remarks : </strong>"+data[21]+"</td></tr>";
       output+="<tr><td colspan='2'><strong>MKT. Lead Closed on : </strong>"+data[22]+"</td></tr>";
       
       output+="</table>";
       $("#modal-view-lead .modal-body").html(output);
       $("#modal-view-lead .modal-title").html(title);
       $("#modal-view-lead").modal("show");
    });   
     
 });
  
  function removeHtml(html){
	    // Create a new div element
	    var temporalDivElement = document.createElement("div");
	    // Set the HTML content with the providen
	    temporalDivElement.innerHTML = html;
	    // Retrieve the text property of the element (cross-browser support)
	    return temporalDivElement.textContent || temporalDivElement.innerText || "";
	}
  
  
  </script>
<style>
div.dt-buttons{margin-top:-3.3em;} .focus-data{background: #e6cbcb !important;font-weight: bold;}
</style>
</head>
<body class="hold-transition skin-blue sidebar-mini">
 <c:if test="${empty fjtuser.emp_code}"> <jsp:forward page="index.jsp"/> </c:if>
 <c:choose>
 <c:when test="${!empty fjtuser.emp_code and  ( fjtuser.role eq 'mkt' or fjtuser.role eq 'mg' or fjtuser.sales_code ne null )  or fjtuser.sales_code ne null or fjtuser.emp_code eq 'E003066'  and fjtuser.checkValidSession eq 1}">
 <sql:query var="service" dataSource="jdbc/orclfjtcolocal">
		SELECT USER_TYPE, DIVN_CODE FROM FJPORTAL.MARKETING_SALES_USERS WHERE  EMPID = ?  AND ROWNUM = 1
	<sql:param value="${fjtuser.emp_code}"/>
</sql:query>
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
          <c:if test="${!empty service.rows}">  
         	<li><a href="SupportRequest"><i class="fa fa-table"></i><span> BDM Support Request </span></a></li>
         </c:if>
         <li><a href="ConsultantLeads"><i class="fa fa-line-chart"></i><span>Consultant Approval Status</span></a></li>
         <li><a href="ProjectLeads"  class="active"><i class="fa fa-columns"></i><span>Project Stages 0 & 1</span></a></li>       
         <li><a href="././homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>     
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1> Sales Leads  <small>Marketing Portal</small> </h1>
      <ol class="breadcrumb">
        <li><a href="homepage.jsp"><i class="fa fa-calendar"></i> Home</a></li>
        <li class="active">Marketing</li>
      </ol>
    </section>
    <!-- Main content -->
    <section class="content" style="background: #ecf0f5;">
        
              
       
            
	     
    <c:if test="${fjtuser.role eq 'mkt'}">
	<div class="row">
	<div class="col-md-12 col-xs-12">
		<div align="right" style="margin-bottom:5px;">
    		<button type="button" name="add" id="add" class="btn btn-success btn-xs"  data-toggle="modal" data-target="#modal-new-lead">Add New lead</button>
   		</div>
   		<div>
   		    <form method="post" id="processOne">   		    
		  	<input type="hidden" name="action" value="new" /> 
		    <div class="table-responsive">
		     <table class="table table-striped table-bordered small marketing-dtls-table display" style="width:100%" id="user_data">
		     <thead>
		      <tr>
		       <th>Lead Code</th>
		       <th>Type of Lead</th>
		       <th>Division</th>
		       <th>Product</th>
		       <th>Sales Eng.</th>
		       <th>Project Details</th>
		       <th>Contractor</th>
		       <th>Consultant/Client</th>
		       <th>Remarks</th>
		       <th>Qtd. Divisions</th>
		       <th>Actions</th>
		      </tr>
		      </thead>
		      <tbody></tbody>
		     </table>
		     </div>
		    <div align="center">
		     <input type="submit" name="insert" id="insert" class="btn btn-primary" value="Submit" />
		    </div>
		   </form>
   	   </div>
   	   
   
  		    <div id="action_alert" title="Action">

  			</div>
	</div>
	</div>
	</c:if>
	
	<div class="row">
	
	       <form method="POST">
     
           <div class="col-md-12 col-xs-6">        
   		     <div class="form-group form-inline">
   		     <input  class="form-control form-control-sm"   placeholder="Select Start Date"  type="text" id="fromdate" name="fromdate" value="${defaultStartDate}" autocomplete="off" onChange="setDeafultToDate()" required/>			
			  <input  class="form-control form-control-sm"    type="text" id="todate" placeholder="Select To Date"  name="todate"  value="${defaultEndDate}"  autocomplete="off" required/>	
			  <%-- 
			   <select class="form-control form-control-sm  select2  mk-db-select"  name="status" required>
  						<option  value="">Lead Status</option>
  						<option  value="0">Working</option>
  						<option  value="1">Closed</option>
  			   </select>
  			  --%>		
            <input type="hidden" value="vcddtls" name="action" />
            <button type="submit" name="refresh" id="refresh" class="btn btn-primary refresh-btn" onclick="preLoader();" ><i class="fa fa-refresh"></i> Refresh</button>
            </div>
          </div>
             </form>
        <div class="col-xs-12">
          <div class="box box-default">
            <div class="box-header with-border report-title">
             Sales Lead List from  ${defaultStartDate}  to ${defaultEndDate}
            </div> 
            <div class="box-body">
            
              <table class="table table-hover small marketing-dtls-table" id="displayLeads" style="border-top: 1px solid #4a46465e !important;" >		        		 
		       <thead>
		        <tr>	
		        <th  width="30px;">Lead Code</th>	
		        <th   width="25px;">Leads Type</th> 
		        <th   width="25px;">Division</th>        			    
		        <th   width="25px;">Product</th>
		        <th   width="25px;">Sales Eng.</th>
		         <th width="35px;">Project Details</th>
		        <th   width="25px;">Contractor</th>
		        <th   width="25px;">Consultant /Client</th>
		         <th   width="25px;">Lead Remarks</th>
		        <th  width="40">Lead Initiated on </th>
		         <th   width="25px;">SE Ack. Status</th> 
		         <th   width="25px;">SE Ack. Remarks</th>  	  	      
		          <th   width="25px;">SE Ack. On</th> 
		          <th  width="40">SE Follow-Up Status</th>
		            <th   width="25px;">SE Follow-Up Remarks</th>
		          <th   width="25px;">Orion Project Code</th>
		           <th   width="25px;">Offer Value (AED)</th> 
		           <th   width="25px;">LOI Received?</th> 
		         <th   width="25px;">LPO Received?</th> 
		         <th   width="25px;">Orion Sales Order No.</th>
		         <th  width="40">SE Updated On</th>     
		        <th   width="25px;">MKT. Lead Close Status</th>
		        <th   width="25px;">MKT. Final Remarks</th>
		        <th  width="40">MKT. Lead Closed on  </th>  
		        <th   width="60px;">Action</th>
		        </tr>
		        </thead>
		        <tbody>
		        <c:forEach var="leadList"  items="${LEADLIST}" >	   
		        <c:choose>
		         	<c:when test="${leadList.seEmpCode eq fjtuser.emp_code}">
		         	<tr class="focus-data">
		         	</c:when>
		         	<c:otherwise>
		         	<tr>
		         	</c:otherwise>
		         </c:choose>     		        	 		 		      
		         <td>FJMKT${leadList.leadUnfctnCode}</td>	
		         <td>${leadList.type}</td>    
		         <td>${leadList.division}</td> 
		         <td>${leadList.prdct}</td>
		         <td>${leadList.seName}</td>   			    
		         <td class="remarks"><span>${leadList.projectDetails}</span></td>
		        <td class="remarks"><span>${leadList.contractor}</span></td>
		        <td>${leadList.consultant}</td>
		         <td>${leadList.leadRemarks}</td>
		        <td  width="40">
		         <fmt:parseDate value="${leadList.createdOn}" var="theDate1"    pattern="yyyy-MM-dd HH:mm" />
		         <fmt:formatDate value="${theDate1}" />
		        </td>  
		        <td>
		         <c:choose>
		        <c:when test="${leadList.p2Status eq 1}"><b style="color:green;">${leadList.ackDesc}</b></c:when>
		        <c:when test="${leadList.p2Status eq 2}"><b style="color:red;">${leadList.ackDesc}</b></c:when>
		         <c:when test="${leadList.p2Status eq 0}"><b style="color:blue;">${leadList.ackDesc}</b></c:when>
		        <c:otherwise><b style="color:blue;">-</b></c:otherwise>
		        </c:choose>
		        </td>
		        <td>${leadList.ackRemarks}</td>
		        <td  width="40">
		        <fmt:parseDate value="${leadList.acknowledgeOn}" var="theDate2"    pattern="yyyy-MM-dd HH:mm" />
		         <fmt:formatDate value="${theDate2}" />
		        </td>
		        
		        <c:choose>
		        <c:when test="${leadList.processCount eq 3 and  leadList.p2Status ne 2  }">
		           <td>
		         <c:choose>
		        <c:when test="${leadList.p3Status eq 1}"><b style="color:green;">${leadList.followUpAckDesc}</b></c:when>
		        <c:when test="${leadList.p3Status eq 2}"><b style="color:red;">${leadList.followUpAckDesc}</b></c:when>
		         <c:when test="${leadList.p1Status eq 0 and leadList.p2Status eq 1}"><b style="color:blue;">${leadList.followUpAckDesc}</b></c:when>
		         <c:when test="${leadList.p3Status eq 3}"><b style="color:green;">${leadList.followUpAckDesc}</b></c:when>
		        <c:otherwise><b style="color:blue;">-</b></c:otherwise>
		        </c:choose>
		        </td>
		        <td>${leadList.seRemarks}</td> 
		        <td>${leadList.prjctCode}</td>
		        <td><fmt:formatNumber pattern="#,###.##" value="${leadList.offerValue}" /></td>	
		           <td>
		           <c:choose>
                  <c:when test="${leadList.loi eq 1}">YES</c:when>
                  <c:otherwise>NO</c:otherwise>
                  </c:choose> 
		        </td>
		         <td>
		           <c:choose>
                  <c:when test="${leadList.lpo eq 1}">YES</c:when>
                  <c:otherwise>NO</c:otherwise>
                  </c:choose> 
		        </td>
		        <td>${leadList.soNumber}</td>      <td  width="40">
		        <fmt:parseDate value="${leadList.followupOn}" var="theDate3"    pattern="yyyy-MM-dd HH:mm" />
		         <fmt:formatDate value="${theDate2}" />
		        </td>
		        </c:when>
		        <c:when test="${((leadList.processCount eq 2 and  leadList.p2Status eq 2) or (leadList.processCount eq 3 and  leadList.p2Status eq 2))}">
		        <td>N/A</td> <td>N/A</td> <td>N/A</td> <td>N/A</td> <td>N/A</td><td>N/A</td> <td>N/A</td> <td>N/A</td>
		        </c:when>
		        <c:otherwise>
		        <td>-</td> <td>-</td> <td>-</td> <td>-</td> <td>-</td> <td>-</td>  <td>-</td> <td>-</td>
		        </c:otherwise>
		        </c:choose>   	
		        <td>
		         <c:choose>
		        <c:when test="${leadList.mktStatus eq 1}"><b style="color:green;">Success</b></c:when>
		        <c:when test="${leadList.mktStatus eq 2}"><b style="color:red;">Not Success</b></c:when>
		        <c:when test="${leadList.mktStatus eq 3}"><b style="color:blue;">Other</b></c:when>
		        <c:when test="${(leadList.p2Status eq 2) or (leadList.p2Status eq 1 and  leadList.p3Status eq 1 and leadList.mktStatus eq 0) }"><b style="color:blue;">Pending</b></c:when>
		        <c:when test="${leadList.p2Status eq 1 and  leadList.p3Status eq 3 and leadList.mktStatus eq 0}">-</c:when>
		        <c:otherwise>-</c:otherwise>
		        </c:choose>
		        </td>
		        <td>${leadList.mktRemarks}</td>
		        <td  width="40">
		        <fmt:parseDate value="${leadList.mktUpdatedOn}" var="theDate4"    pattern="yyyy-MM-dd HH:mm" />
		         <fmt:formatDate value="${theDate3}" />
		        </td>
		        
		        <td  width="45">
		        
		      <%--  P1= ${leadList.p1Status}-P2=${leadList.p2Status}-p3=${leadList.p3Status}-p4=${leadList.p4Status}-PC=${leadList.processCount} --%>
		         <form action="SalesLeads" method="POST" style="display: inline !important;" name="gs_form_delete" >
				   	 <input type="hidden" value="${leadList.id}" name="lddi" />
				   	 <input type="hidden" name="p1" value="${leadList.p1Status}" />
				   	 <input type="hidden" name="p2" value="${leadList.p2Status}" />
				   	 <input type="hidden" name="p3" value="${leadList.p3Status}" />
				   	 <input type="hidden" name="p4" value="${leadList.p4Status}" />
				   	 <input type="hidden" name="pCount" value="${leadList.processCount}" /> 
				   	  <input type="hidden" name="typeCode" value="${leadList.typeCode}" /> 
				   	 <input type="hidden" name="edocpmees" value="${leadList.seEmpCode}" />
				   	 				    
				  <c:if test="${leadList.processCount eq 3}">
				  
					   <c:choose>
					   <c:when test="${leadList.p1Status eq 1 and leadList.p2Status eq 1  and leadList.p3Status eq 1 and leadList.p4Status eq 0  and fjtuser.role eq 'mkt' and fjtuser.role ne 'mg' }">
					    <input type="hidden" name="action" value="edit" />
					    <button type="submit" class="btn btn-primary btn-xs" style="margin-bottom:3px;">
					      <i class="fa fa-edit" aria-hidden="true"></i> Close Lead</button> 
					   </c:when>
					   <c:when test="${leadList.p1Status eq 1 and leadList.p2Status eq 2  and leadList.p3Status eq 0 and leadList.p4Status eq 0  and fjtuser.role eq 'mkt' and fjtuser.role ne 'mg' }">
					    <input type="hidden" name="action" value="edit" />
					   <button type="submit"   class="btn btn-primary btn-xs" style="margin-bottom:3px;">
					      <i class="fa fa-edit" aria-hidden="true"></i>Close Lead</button>
					    </c:when>
					     <c:when test="${leadList.p1Status eq 1 and leadList.p2Status eq 1  and leadList.p3Status eq 2 and leadList.p4Status eq 0  and fjtuser.role eq 'mkt' and fjtuser.role ne 'mg' }">
					    <input type="hidden" name="action" value="edit" />
					   <button type="submit"   class="btn btn-primary btn-xs" style="margin-bottom:3px;">
					      <i class="fa fa-edit" aria-hidden="true"></i>Close Lead</button>
					    </c:when>
					   <c:when test="${leadList.p1Status eq 1 and leadList.p2Status eq 0  and leadList.p3Status eq 0 and leadList.p4Status eq 0  and fjtuser.role ne 'mkt' and fjtuser.role ne 'mg' and leadList.seEmpCode eq fjtuser.emp_code}">
					    <input type="hidden" name="action" value="edit" />
					   <button type="submit"   class="btn btn-primary btn-xs" style="margin-bottom:3px;"><i class="fa fa-edit" aria-hidden="true"></i>Acknowledge</button>
					   </c:when>
					    <c:when test="${leadList.p1Status eq 1 and leadList.p2Status eq 1 and (leadList.p3Status eq 0 or leadList.p3Status eq 3 ) and leadList.p4Status eq 0  and fjtuser.role ne 'mkt' and fjtuser.role ne 'mg' and leadList.seEmpCode eq fjtuser.emp_code}">
					    <input type="hidden" name="action" value="edit" />
					   <button type="submit"   class="btn btn-primary btn-xs" style="margin-bottom:3px;"><i class="fa fa-edit" aria-hidden="true"></i> Follow-Up</button>
					   </c:when> 
					    <c:when test="${leadList.p1Status eq 1 and leadList.p2Status eq 1  and leadList.p3Status eq 2 and leadList.p4Status eq 0  and fjtuser.role ne 'mkt' and fjtuser.role ne 'mg' and leadList.seEmpCode eq fjtuser.emp_code}">
					   <input type="hidden" name="action" value="view" />
					   <button type="submit"   class="btn btn-primary btn-xs" style="margin-bottom:3px;"><i class="fa fa-edit" aria-hidden="true"></i> View</button>
					   </c:when> 
					   <c:otherwise>
					    <%--
					     <input type="hidden" name="action" value="view" />
					     <button type="submit"   class="btn btn-primary btn-xs view-data" style="margin-bottom:3px;">
					      <i class="fa fa-eye" aria-hidden="true"></i>View</button>	
					     --%>  	   
					    </c:otherwise> 
					   </c:choose>
					   
					   
				</c:if>
			    <c:if test="${leadList.processCount eq 2}">
			    
			     <c:choose>
			     
					   <c:when test="${leadList.p1Status eq 1 and leadList.p2Status eq 1  and leadList.p3Status eq 0 and leadList.p4Status eq 0  and fjtuser.role eq 'mkt' and fjtuser.role ne 'mg' }">
					    <input type="hidden" name="action" value="edit" />
					    <button type="submit" class="btn btn-primary btn-xs" style="margin-bottom:3px;">
					      <i class="fa fa-edit" aria-hidden="true"></i> Close Lead</button> 
					   </c:when>
					   <c:when test="${leadList.p1Status eq 1 and leadList.p2Status eq 2  and leadList.p3Status eq 0 and leadList.p4Status eq 0  and fjtuser.role eq 'mkt' and fjtuser.role ne 'mg' }">
					    <input type="hidden" name="action" value="edit" />
					   <button type="submit"   class="btn btn-primary btn-xs" style="margin-bottom:3px;">
					      <i class="fa fa-edit" aria-hidden="true"></i>Close Lead</button>
					    </c:when>
					    
					   <c:when test="${leadList.p1Status eq 1 and leadList.p2Status eq 0  and leadList.p3Status eq 0 and leadList.p4Status eq 0  and fjtuser.role ne 'mkt' and fjtuser.role ne 'mg' and leadList.seEmpCode eq fjtuser.emp_code}">
					    <input type="hidden" name="action" value="edit" />
					   <button type="submit"   class="btn btn-primary btn-xs" style="margin-bottom:3px;"><i class="fa fa-edit" aria-hidden="true"></i>Acknowledge</button>
					   </c:when>
					   					   
					   <c:otherwise>
					    <%--
					     <input type="hidden" name="action" value="view" />
					     <button type="submit"   class="btn btn-primary btn-xs view-data" style="margin-bottom:3px;">
					      <i class="fa fa-eye" aria-hidden="true"></i>View</button>		
					     --%>   
					    </c:otherwise>
					   
					   </c:choose>
					   
				</c:if>
				 </form>
				<%-- /Edit --%> 
				
				<%-- Delete --%> 
				<c:if test="${leadList.p1Status eq 1 and leadList.p2Status eq 0 and leadList.p3Status eq 0 and leadList.p4Status eq 0  and fjtuser.role eq 'mkt'}">
		   		 <form action="SalesLeads" method="POST" style="display: inline !important;" name="gs_form_delete">
				   	 <input type="hidden" value="${leadList.id}" name="lddi" />
				     <input type="hidden" name="action" value="delete" />
				     <button type="submit"   class="btn btn-danger btn-xs"  onclick="if (!(confirm('Are You sure You Want to delete this lead!'))) return false" >
					 <i class="fa fa-trash" aria-hidden="true"></i> Delete
					 </button>
				 </form>
				 </c:if>
			   <!-- /Delete -->	
			   <button type="button"   class="btn btn-xs btn-info quick-view" > <i class="fa fa-eye" aria-hidden="true"></i>Quick View</button>			        	   
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
      <div class="modal fade" id="modal-new-lead"  data-backdrop="static" data-keyboard="false">
          <div class="modal-dialog modal-lg" style="width: 85%;">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Sales Leads Form</h4>
              </div>
              <div class="modal-body">
                <form role="form"  id="newLeadForm" name="newLeadForm">		  		 
			        <!--  Process - 1 -->
			        <div class="row">
					        <div class="col-md-3">	
					         <div class="form-group">
					              <label>Type of Lead:</label>
					              <select class="form-control select2" style="width: 100%;" id="typ" name="typ" onChange="checkLeadType()" required>
					                <option value="">Select Lead Type</option>
					                  <c:forEach var="typeList"  items="${CTL}" >
				                    <option value="${typeList.typeCode}" class="${typeList.processCount}">${typeList.type}</option>
				                    </c:forEach>
					              </select>
					            </div>
					        </div>		        
					        <div class="col-md-6 form-inline" class="stage2Div1" id="stage2Div1" >	    
					              <label>Enter Orion Project Code:</label><br/>
					               <input type="text" class="form-control"   id="orionPCode"/>
					              <button type="button" id ="getStg2" class="btn btn-primary"  onClick="getStage2ProjectDetails()">Get Project Details</button>			              
					        </div>  
			          
			         </div>
			             <div class="box" id="stage2Div2">
			             
            <div class="box-header with-border">
            <h4 class="box-title">Project Details</h4> 
              <div class="box-tools pull-right">
                <button type="button" style="color:red;"" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
              </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body" id="stage2DivDtls">
             
            
            </div>
            <div class="box-footer clearfix">
             
            </div>
          </div>
			        
			        <div class="row mkt-form-row-border" id="leadMjrDtls">		        
			          <div class="col-md-3">			         			           
			            <div class="form-group">
			              <label>Sales Engineer:</label>
			              <select class="form-control select2" style="width: 100%;" name="seg" id="seg" required onChange="updateSegDetails(this)">
			                <option value="">Select Sales Engineer</option>
		                    <c:forEach var="segList"  items="${SEL}" >
		                    <option value="${segList.se_emp_code}">${segList.se_code} - ${segList.se_name}</option>
		                    </c:forEach>
			              </select>
			              <input type="hidden" value="" id="segDtls" name="segDtls"/>
			               <input type="hidden" value="" id="s2PjctCode" name="s2PjctCode"/>
			            </div>
			            	
			           	<div class="form-group">
			             <label>Lead Code (Lead No. Only):</label>
			              <input type="number" min="0" class="form-control" id="leadCode" name="leadCode" >
			            </div>
			            
			            <div   class="stage2Div3" id="stage2Div3">  
						    
						     <select class="form-control form-control-sm"  multiple="multiple"  style="width: 100%;" id="qtdDivns_list" name="qtdDivns" required>
					         <c:forEach var="dvnLst"  items="${DLFCL}" >
					         <c:if test="${dvnLst.divn_code ne 'AD'}">
					         <option value="${dvnLst.divn_name}">${dvnLst.divn_name}</option>
					         </c:if>
					         </c:forEach>
						     </select>						              
						 </div>	
			          </div>
			          <div class="col-md-3">			          
			          <div class="form-group">
			              <label>Division:</label>
			              <select class="form-control select2" style="width: 100%;" name="divn" required>
			                <option value="" >Select Division</option>
		                    <c:forEach var="dvnLst"  items="${DLFCL}" >
		                    <c:if test="${dvnLst.divn_code ne 'AD'}">
		                    <option value="${dvnLst.divn_code}">${dvnLst.divn_name}</option>
		                    </c:if>
		                    </c:forEach>
			              </select>
			            </div>			            
			            <div class="form-group">
			              <label>Contractor:</label>
			              <input type="text" class="form-control" name="contractor" >
			            </div> 		          
			          </div>
			          <div class="col-md-3" style="padding-top: 25px;">
			          	  <div class="form-group" id="productDiv">
			              <select  class="form-control form-control-sm"  style="width: 100%;"  id="productsOpt" multiple="multiple"  name="prodct" required>
			              
			              </select>
			            </div>  
			             <div class="form-group">
			              <label>Consultant / Client:</label>
			              <input type="text" class="form-control" name="consultant" >
			            </div>
			          </div>
			          <div class="col-md-3">
			
			             <div class="form-group">
			              <label>Project Details:</label>
			              <textarea class="form-control" name="prjctDtls" ></textarea>
			            </div>	
			          </div>
			         <div class="col-md-3">
			
			             <div class="form-group">
			              <label>Remarks:</label>
			              <textarea class="form-control" name="leadRemarks" ></textarea>
			            </div>	
			          </div>
			          <!-- /.col -->			     
			       </div>
			        <!-- /.row -->
			        <!-- /.Process-1  -->
	                 <div class="box-footer">
	                 <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>  
	                 
	                 <button type="button" id ="save" class="btn btn-primary pull-right"  >Save</button>
	                </div>
           		 </form>
              </div>
            </div>
            <!-- /.modal-content -->
          </div> 
                  
          <div id="laoding-stage2" class="loader" ><img src="././resources/images/wait.gif"></div> 
          <!-- /.modal-dialog -->         
        </div>
        <!-- /.modal -->
        
        	  <!-- modal -->
      <div class="modal fade" id="modal-view-lead"  data-backdrop="static" data-keyboard="false">
          <div class="modal-dialog modal-lg"  style="display:flex;">
            <div class="modal-content">
              <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">Sales Leads Form</h4>
              </div>
              <div class="modal-body"> </div>
	        <div class="box-footer">
	        <button type="button" class="btn btn-default pull-right" data-dismiss="modal">Close</button>   
	         </div>
            </div>
         </div>
            <!-- /.modal-content -->
        </div>      
        <!-- /.modal -->
        
    <div id="laoding" class="loader" ><img src="././resources/images/wait.gif"></div> 
      
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
<script src="././resources/bower_components/select2/dist/js/select2.full.min.js"></script>
<script src="././resources/bower_components/fastclick/lib/fastclick.js"></script>
<script src="././resources/dist/js/adminlte.min.js"></script>
<!-- page script start -->

<!-- page Script  end -->

</c:when>
<c:otherwise>

        <body onload="window.top.location.href='logout.jsp'">
   
            
        </body>
  
</c:otherwise>
</c:choose>
</body>
</html>