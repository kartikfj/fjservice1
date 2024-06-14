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
	<script type="text/javascript" src="././resources/js/mkt-supportrequest.js?v=290620200"></script>
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
         <li><a href="AssignToPOC"><i class="fa fa-table"></i><span> Assign task to POC </span></a></li>
          <c:if test="${!empty service.rows}">  
         	<li class="active"><a href="SupportRequest"><i class="fa fa-table"></i><span> BDM Support Request </span></a></li>
         </c:if>         
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
      <h1>BDM Support Requests<small>Marketing Portal</small> </h1>
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
            Sales Engineer Support Requests List
              <c:if test="${fjtuser.role ne 'mkt' and fjtuser.sales_code ne null}">
              <button type="button" class="btn btn-sm btn-dark pull-right" data-toggle="modal" data-target="#modal-default">
                <i class="fa fa-plus"> </i> Create New Support Requests
              </button>
             </c:if>
            </div>
            <div class="box-body">
               <table class="table table-hover small marketing-dtls-table" id="displayLeads" style="border-top: 1px solid #4a46465e !important;" >		        		 
		       <thead>
		        <tr>	
		        <th width="35px;">Request Code</th><th  width="30px;">Type</th>	        			    
		        <th width="45px;">Sales Eng.</th><th  width="40px;">Product</th><th>Division</th><th width="35px;">Contractor</th><th width="35px;">Consultant /Client</th>
		        <th width="35px;">Project Details</th>
		        <th width="40px;">Offer Value</th><th width="35px;"> SE Initial Remarks</th><th>SE Requested on </th>		        
		        <th  width="45px;">Ack. Status by Mkt.</th>  
		        <th  width="45px;">Ack. Remarks by Mkt.</th> 	      
		        <th width="45px;">Mkt. Follow-Up Status</th><th width="45px;">Mkt. Follow-Up Remarks</th><th>Mkt. Follow-Up On</th><th width="45px;">SE Final Status</th><th width="45px;">SE Final Remarks</th> <th>SE Closed On</th> 
		         <th  width="65">Action</th>
		        </tr>
		        </thead>
		        <tbody>
		        <c:forEach var="requestList"  items="${SRLIST}" >
		        <tr>	
		        <td>FJMSR${requestList.id}</td><td>${requestList.type}</td> <td>${requestList.seName}</td>        			    
		        <td>${requestList.product}</td><td>${requestList.division}</td>
		        <td>${requestList.contractor}</td><td>${requestList.consultant}</td> 
		          <td>${requestList.projectDetails}</td>	 	
		        <td><fmt:formatNumber pattern="#,###" value="${requestList.offerValue}" /></td> <td>${requestList.initialReamrks}</td>
		        <td  width="90">
		         <fmt:parseDate value="${requestList.requestedOn}" var="theDate1"    pattern="yyyy-MM-dd HH:mm" />
		         <fmt:formatDate value="${theDate1}" />
		        </td>		          		        
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
		         <td>${requestList.support_accept_remarks}</td>		
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
		        <td class="remarks"><span>${requestList.mkt_remarks}</span></td>     
		        <td>
		        <fmt:parseDate value="${requestList.mkt_acted_on}" var="theDate3"    pattern="yyyy-MM-dd HH:mm" />
		         <fmt:formatDate value="${theDate3}" />
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
		        <td>${requestList.se_remarks}</td>
		         <td  width="90">
		        <fmt:parseDate value="${requestList.se_followup_on}" var="theDate2"    pattern="yyyy-MM-dd HH:mm" />
		         <fmt:formatDate value="${theDate2}" />
		        </td>
		        <td>        
		         <%-- Edit --%> 
		         <form action="SupportRequest" method="POST" style="display: inline !important;" name="gs_form_delete">
				   	 <input type="hidden" value="${requestList.id}" name="srdi" />
				   	 <input type="hidden" name="p1" value="${requestList.p1Status}" />
				   	 <input type="hidden" name="p2" value="${requestList.p2Status}" />
				   	 <input type="hidden" name="p3" value="${requestList.p3Status}" />
				   	 <input type="hidden" name="p4" value="${requestList.p4Status}" />
				   	 <input type="hidden" name="edocpmees" value="${requestList.seEmpCode}" />
					   <c:choose>
					   <c:when test="${fjtuser.role ne 'mkt' and  requestList.p1Status eq 1 and ((requestList.p2Status eq 0 && requestList.p3Status eq 0 ) or (requestList.p2Status eq 1 && requestList.p3Status eq 0 )) and requestList.p4Status eq 0}">
					     <input type="hidden" name="action" value="view" />
					     <button type="submit"  class="btn btn-primary btn-xs" style="margin-bottom:3px;">
					      <i class="fa fa-eye" aria-hidden="true"></i>View</button>	
					   </c:when>
					   <c:when test="${fjtuser.role eq 'mkt' and requestList.p1Status eq 1 and requestList.p2Status eq 0 and  requestList.p3Status eq 0}"> 
					    <input type="hidden" name="action" value="edit" />
					   <button type="submit"  class="btn btn-primary btn-xs" style="margin-bottom:3px;">
					      <i class="fa fa-edit" aria-hidden="true"></i>Acknowledge</button>
					    </c:when>
					     <c:when test="${fjtuser.role eq 'mkt' and requestList.p1Status eq 1 and requestList.p2Status eq 1 and  requestList.p3Status eq 0   }"> 
					    <input type="hidden" name="action" value="edit" />
					   <button type="submit"  class="btn btn-primary btn-xs" style="margin-bottom:3px;">
					      <i class="fa fa-edit" aria-hidden="true"></i>follow-Up</button>
					    </c:when>
					   <c:when test="${fjtuser.role ne 'mkt' and requestList.p1Status eq 1 and requestList.p2Status eq 1 and  requestList.p3Status eq 1 and requestList.p4Status eq 0}">
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
				<c:if test="${requestList.p1Status eq 1 and requestList.p2Status eq 0 and requestList.p3Status eq 0 and requestList.p4Status eq 0  and fjtuser.role ne 'mkt' and fjtuser.emp_code eq requestList.seEmpCode}">
		   		 <form action="SupportRequest" method="POST" style="display: inline !important;" name="support_form_delete">
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
                <h4 class="modal-title">Sales Engineer Support Request Form</h4>
              </div>
              <div class="modal-body">
                <form role="form" action="SupportRequest" method="post" id="processOne" name="processOne">
		  		 <input type="hidden" name="action" value="new" /> 
		  		 
			        <!--  Process - 1 -->
			        <div class="row mkt-form-row-border">
			          <div class="col-md-3">
			          <div class="form-group">
			              <label>Type of Support/Service request:</label>
			              <select class="form-control select2" style="width: 100%;" name="typ" required>
			                <option value="">Select Support/Service Type</option>
			                  <c:forEach var="typeList"  items="${CTL}" >
		                    <option value="${typeList.type}">${typeList.type}</option>
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
			            		          
			          </div>
			          <div class="col-md-3"  style="padding-top: 25px;">
			          	    <div class="form-group" id="productDiv">
			              <select  class="form-control form-control-sm"  style="width: 100%;"  id="productsOpt" multiple="multiple"  name="prodct" required>
			              
			              </select>
			            </div>
			          </div>
			          <div class="col-md-3">
			            <div class="form-group">
			              <label>Consultant / Client:</label>
			              <input type="text" class="form-control" name="consultant" >
			            </div>
			          </div>
			          <div class="col-md-3">
			          <div class="form-group">
			              <label>Contractor:</label>
			              <input type="text" class="form-control" name="contractor" >
			            </div>
			           </div>
			           
			           <div class="col-md-3">
			             <div class="form-group">
			              <label>Offer Value:</label>
			              <input type="number" class="form-control" name="offerval" min="0">
			            </div>
			           </div>
			           <div class="col-md-3">
			            <div class="form-group">
			                <label>Project Details:</label> 
				           <textarea  class="form-control" name="prjctDtls" required></textarea>
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
	                 <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>    
	                 <button type="submit" class="btn btn-primary pull-right"  onclick="getSeletedval();" ><i class="fa fa-paper-plus"></i> New Support Request</button>
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

</c:when>
<c:otherwise>

        <body onload="window.top.location.href='logout.jsp'">
   
            
        </body>
  
</c:otherwise>
</c:choose>
</body>
</html>