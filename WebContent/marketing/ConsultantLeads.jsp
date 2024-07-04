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
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
	<script src="././resources/js/mainview.js"></script>
	<link href="././resources/css/multiple_product_list.css" rel="stylesheet" type="text/css" />
	<script src="././resources/js/multiple_product_list.js"></script>
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
    <link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
  <!--   <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script> -->
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
  
  <!-- Theme style -->
  <link rel="stylesheet" href="././resources/dist/css/AdminLTE.min.css">
  <link rel="stylesheet" href="././resources/dist/css/skins/_all-skins.min.css">
   <link rel="stylesheet" href="././resources/css/mkt-layout.css?v=13032020">
   
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
 <style>
        /* Custom CSS to match Bootstrap styling */
        .select2-container--bootstrap .select2-selection--single {
            height: calc(1.5em + .75rem + 2px);
            padding: .375rem .75rem;
            border-radius: .25rem;
            border: 1px solid #ced4da;
        }
        
        .select2-container--bootstrap .select2-selection--single .select2-selection__rendered {
            line-height: normal;
        }
        
        /* Ensure the select2 container has full width */
        .select2-container {
            width: 100% !important;
        }
    </style>
 <style>
.navbar-brand {
  padding: 0px;
}
/* new style by nufail */
.navbar-brand>img {
  height: 101%;
  width: auto;
  margin-left: 5px;
  margin-right: 6px;
}
.navbar {
    border-radius: 0px; 
}
.navbar ul li{
	
	
	font-style: normal;
    font-variant-ligatures: normal;
    font-variant-caps: normal;
    font-variant-numeric: normal;
    font-variant-east-asian: normal;
    font-stretch: normal;
    line-height: normal;
    font-size: 14px;
    font-weight: 700;
}

.navbar-default .navbar-nav>li>a:hover, .navbar-default .navbar-nav>.open>li>a, .navbar-default .navbar-nav>.open>li>a:focus, .navbar-default .navbar-nav>.open>li>a:hover{
background:#fff;
color:#008ac1;


}
#fj-page-head{padding:4px 8px !important;color:#065685;margin-top:-20px;}
#fj-page-head-box{border: none;};
 .btn-group.open .dropdown-toggle {max-width: 180px !important;overflow: hidden  !important;}
input.right {
        float: right;
      }
</style>

</head>
<body class="hold-transition skin-blue sidebar-mini">
 <c:if test="${empty fjtuser.emp_code}"> <jsp:forward page="index.jsp"/> </c:if>
 <c:choose>
 <c:when test="${!empty fjtuser.emp_code and ( fjtuser.role eq 'mkt' or fjtuser.role eq 'mg' or fjtuser.sales_code ne null ) and fjtuser.checkValidSession eq 1  }">
 	<sql:query var="service" dataSource="jdbc/orclfjtcolocal">
				SELECT USER_TYPE, DIVN_CODE FROM FJPORTAL.MARKETING_SALES_USERS WHERE  EMPID = ?  AND ROWNUM = 1
			<sql:param value="${fjtuser.emp_code}"/>
 	</sql:query>
<div class="wrapper">

  <header class="main-header">
    <!-- Logo -->
    <a href="index2.html" class="logo">
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
              <span class="hidden-xs">${fjtuser.uname}</span>
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
      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu" data-widget="tree">
      	 <c:if test="${fjtuser.emp_code eq 'E004272' || fjtuser.emp_code eq 'E003066'}">
	         <li><a href="MktDashboard"><i class="fa fa-dashboard"></i><span>Dashboard - Sales Leads</span></a></li>
	         <li ><a href="SalesLeads"><i class="fa fa-pie-chart"></i><span>Sales Leads Details</span></a></li>
         </c:if>
         <c:if test="${!empty service.rows}">  
         	<li><a href="SupportRequest"><i class="fa fa-table"></i><span> BDM Support Request </span></a></li>
         </c:if>        
         <li><a href="ProjectLeads"><i class="fa fa-columns"></i><span>Project Stages 0 & 1</span></a></li>
         <li><a href="ProjectStatus"><i class="fa fa fa-bars"></i><span>Project Status</span></a></li>
         <li><a href="ConsultantVisits"><i class="fa fa-columns"></i><span>Consultant Visit</span></a></li> 
         <li class="active"><a href="ConsultantLeads"><i class="fa fa-line-chart"></i><span>Consultant Approval Status</span></a></li>              
         <li><a href="ConsultantProductReport"><i class="fa fa-columns"></i><span>Consultant Product Dashboard</span></a></li>		       
         <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>      
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Consultant Approval Status
        <small>Marketing Portal</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="homepage.jsp"><i class="fa fa-calendar"></i> Home</a></li>
        <li class="active">Marketing</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
    
       <!--Box Start -->
       <div class="box box-success">
       
       	<!--box Header Start -->
        <div class="box-header">
        	  <div class="pull-left" style="display:inline-flex">
			   <div  class="box-title">Consultants Brand Approval Status Details</div>
			   <div>
			   <c:if test="${fjtuser.role eq 'mkt'  }">
			    <button type="button" class="btn btn-default add-new" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#newConsltnLds"><i class="fa fa-plus"></i> Add New</button>
			   </c:if>
			   </div>
			   <div>  
			   <form method="POST" action=ConsultantLeads>
			   <input type="hidden" value="dlcav" name="octjf" />
			   <button type="submit" class="btn btn-default add-new"  >View All  (Including Last Year)</button>
			   </form>
			   </div>
               </div>
              </div>
       <!--box Header End -->
  	   
	   <!--box Body Start -->
       <div class="box-body chat">
		  <c:choose>
		     <c:when test="${!empty  VACLD  and  VACLD ne null}">
		            <div  class="row consultant-row">             
		             <div class="table-responsive" id="cnslt-table">
		             <table id="displayCnsltnt" class="table table-hover small marketing-dtls-table"   style="border-top: 1px solid #4a46465e !important;border-right: 1px solid #4a46465e !important;">
		             <thead><tr> <th>Consultant</th><th>Consultant Type</th><th>Product</th>   <th  width="100px">Status</th>
		             <th  width="100px">Division</th><th>By BDM</th><th>EOA</th><th>Created By</th><th>Remarks</th><th  width="93px">Last Updated</th>
		            <c:if test="${fjtuser.role eq 'mkt'  }"> <th  width="65px">Action</th></c:if> </tr>
		             </thead> <tbody> <c:forEach var="cnsltLst"  items="${VACLD}" > <tr>
		             <td><p class="long-letters">${cnsltLst.conslt_name}</p><span class='highlight'>${cnsltLst.updateStatus}</span></td>
		             <td><p class="long-letters">${cnsltLst.consultantType}</p></td> <td><p class="long-letters">${cnsltLst.product}</p></td> 
		             <td>
		             <c:choose>
		             <c:when test="${cnsltLst.status eq 'Currently Working'}"><b style="color: #00c0ef;">${cnsltLst.status}</b> </c:when>
		             <c:when test="${cnsltLst.status eq 'Approved'}"><b style="color: #00a65a;">${cnsltLst.status}</b> </c:when>
		             <c:when test="${cnsltLst.status eq 'Not Yet Approved'}"><b style="color: #f39c12;">${cnsltLst.status}</b> </c:when>
		             <c:otherwise><b style="color: #dd4b39;">${cnsltLst.status}</b> </c:otherwise>
		             </c:choose>  
		             </td>
		             <td>
		               <c:forEach var="dvnLst"  items="${DLFCL}" >		          	             
		              <c:if test="${cnsltLst.division eq dvnLst.divn_code}">
		                  <b>${dvnLst.divn_name}</b>		              
		             </c:if>
		            </c:forEach>		             		             
		             </td>
		             <td><p class="long-letters">${cnsltLst.isUpdateByBDM} </p></td>
		              <td><p class="long-letters">${cnsltLst.isUpdateByEVM}</p></td>
		             <td><p class="long-letters">${cnsltLst.createdBy} </p></td>
		             <td><p class="long-letters">${cnsltLst.remarks} </p></td>
					<td>
		              <c:choose> 
		              <c:when test="${cnsltLst.updated_date eq null or cnsltLst.updated_date  eq '' or cnsltLst.updated_date  eq 'undefined'}">
		             <fmt:parseDate value="${cnsltLst.created_date}" var="theCDate"    pattern="yyyy-MM-dd HH:mm" />
		             <fmt:formatDate value="${theCDate}" pattern="MMM-YYYY"/> 
		              </c:when>
		              <c:otherwise> 
		             <fmt:parseDate value="${cnsltLst.updated_date}" var="theUDate"    pattern="yyyy-MM-dd HH:mm" />
		             <fmt:formatDate value="${theUDate}" pattern="MMM-YYYY"/>		              
		             </c:otherwise>
		                         </c:choose>
		             </td>   		             
		                     <c:if test="${fjtuser.role eq 'mkt'  }">
		                              <td>
		                          <a href="#"   onclick="loadMultiSelect('${cnsltLst.cnslt_id}');" id="eg" class="btn btn-primary btn-xs" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#updateCnslt${cnsltLst.cnslt_id}">
								       		 <i class=" fa fa-pencil" aria-hidden="true"></i>
								       		 </a>
								        	 <!-- delete -->
		   											<form action="ConsultantLeads" method="POST" style="display: inline !important;" >
			   											 <input type="hidden" value="${cnsltLst.cnslt_id}" name="dd1" />
			     										<input type="hidden" name="octjf" value="dsclfpad" />
			     									     <button type="submit"  class="btn btn-danger btn-xs"  onclick="if (!(confirm('Are You sure You Want to Delete this this Consultant Leads!'))) return false" >
										        		 <i class="fa fa-trash" aria-hidden="true"></i></button>
										        	</form>
										        	</td>
										        	</c:if>
		             
		              </tr>
		               <c:if test="${fjtuser.role eq 'mkt'  }">
		              		<div class="modal fade" id="updateCnslt${cnsltLst.cnslt_id}" role="dialog">
						
					       <div class="modal-dialog">
					    
						      <!-- Modal content-->
						      <div class="modal-content">
						        <div class="modal-header">
						          <button type="button" class="close" data-dismiss="modal">&times;</button>
						          <h4 class="modal-title">Update Consultant Leads  Details</h4>
						        </div>
						        <div class="modal-body">
						          
		                        
		  					
		              <div class="box-body">
		               <div class="row">  
		               <div class="col-md-12">
		             
		               <Strong>Consultant : </Strong > <span>${cnsltLst.conslt_name}</span><br/>
<%-- 		            <Strong >Product : </Strong ><span>${cnsltLst.product}</span><br/> --%> 						
		             <Strong >Division :  </Strong ><span>${cnsltLst.division}</span><br/>
		             <Strong >Last updated on  :  </Strong ><span>
		             <c:choose> 
		              <c:when test="${cnsltLst.updated_date eq null or cnsltLst.updated_date  eq '' or cnsltLst.updated_date  eq 'undefined'}">		             	
		             	 <fmt:parseDate value="${cnsltLst.created_date}" var="theCDate"    pattern="yyyy-MM-dd HH:mm:ss" />
		             	 <fmt:formatDate value="${theCDate}" pattern="dd-MM-YYYY HH:mm:ss"/> 
		              </c:when>
		              <c:otherwise><fmt:parseDate value="${cnsltLst.updated_date}" var="theCDate"    pattern="yyyy-MM-dd HH:mm:ss" />
		             	 <fmt:formatDate value="${theCDate}" pattern="dd-MM-YYYY HH:mm:ss"/> </c:otherwise>
		                         </c:choose>
		             
		             </span>
		             </div>
		             </div>
		             <form  action="ConsultantLeads" method="POST"  id="updateDetails">
		             <div class="row">
		             
		            <div class="col-md-6">
		             <div class="form-group">
		                  <label>Status</label>
		                  <select class="form-control" name="ud1"  required>
		                  
		                    <option value="${cnsltLst.status}">${cnsltLst.status}</option>
		                    <option value="Currently Working">Currently Working</option> 
		                    <option value="Approved">Approved</option>
		                    <option value="Not Yet Approved">Not Yet Approved</option>
		                    <option value="Not Initiated">Not Initiated</option>            
		                  </select>
		             
		              </div>
		            </div>
		             <div class="col-md-4">
    <div class="form-group">
        <label for="ud7">Evidence of Approval</label>
        <select class="form-control" name="ud7" id="ud7" required>
            <option value="">Select</option>
            <option value="Yes">Yes</option>
            <option value="No">No</option>
        </select>
    </div>
</div>
		             
		             <div class="col-md-4">
		 				<div class="form-group" id="productDiv">
		             		 <label>Product</label><br/>
					        <select  class="form-control form-control-sm dropdown-toggle"  id="editproductsOpt${cnsltLst.cnslt_id}"  multiple="multiple" required>
								 <c:forEach items="${cnsltLst.divnProductList}" var="list">
								  <c:forEach items="${list.value}" var="listItem">
								  		<c:choose>
										 		<c:when test="${fn:contains(cnsltLst.product,listItem)}">
										 			 <option value="${listItem}" selected>${listItem}</option>
										 		</c:when>
										 		<c:otherwise>
										 			<option value="${listItem}" >${listItem}</option>
										 		</c:otherwise>
										 </c:choose>
								 		</c:forEach>
								 </c:forEach>
							</select>
					     </div>
					     </div>
					     </div>
					      <div class="row">
					     <div class="col-md-6">
						<div class="form-group">
		                  <label for="mktRmrkg">Contact Details</label>
		                  <textarea class="form-control" rows="3" id="editConsDetails${cnsltLst.cnslt_id}" placeholder="Enter Contact Details" name="ud4" required>${cnsltLst.contactDetails}</textarea>
		                </div>
		                </div>
		             <div class="col-md-6">
		                <div class="form-group">
		                  <label for="mktRmrk">Remarks</label>
		                  <textarea class="form-control" rows="3"   placeholder="Enter Contact Details" name="ud2" required>${cnsltLst.remarks}</textarea>
		                </div>
		             
		             </div>
		             
		             </div>
		            
		                </div>
		              
		                 
		              </div>
		              <!-- /.box-body -->
		              <div class="box-footer">
		              <input type="hidden" value="${cnsltLst.cnslt_id}" name="ud3" id="ud3">
		              <input type="hidden" value="unclfpad" name="octjf"/>
		              <input type="hidden" name="ud5" id="product" value=""/>
		                <button type="button"  onclick="editSeletedval(${cnsltLst.cnslt_id});" class="btn btn-primary">Update</button>
		              </div>
		            </form>
											       
						        <div class="modal-footer">
						          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						        </div>
						      </div>
					   		 </div>
		 			
		              </div>
		              </c:if>
		              
		              
		              </c:forEach> </tbody>  
		              
		              <tfoot>
		            <tr>
		              <th id="cnslttntfoot" >Consultant</th> <th id="cnslttntTypefoot" >Consultant Type</th><th  class="tfoot1"   id="pdctfoot">Product</th>   <th id="statusfoot">Status</th>
		             <th id="dvnfltr">Division</th><th id="bdmfltr">By BDM</th><th id="eoafltr">EOA</th><th id="cbdmfltr">By BDM</th><th  class="tfoot1" >Remarks</th><th  width="93px"  class="tfoot1" >Last Updated</th>
		            <c:if test="${fjtuser.role eq 'mkt'  }"> <th  width="65px"  class="tfoot1" >Action</th></c:if> 
		            </tr>
		        </tfoot>
		              
		              </table> 
		              </div>
		              
		              </div>
		         </c:when>
		          <c:when test="${SWORD ne null or empty SWORD and TABACTIVE ne 'YES'}">
		          <br/>
		          <div class="alert alert-warning alert-dismissible">
					  <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
					  <strong>Info!</strong>  ${SWORD} 
		            </div>
		            </c:when>
		            <c:otherwise>
		
		            </c:otherwise>
		            </c:choose>  
		   </div>
		 <!--Box Body End -->
         
         </div>
         <!--Box End -->
	
                         <c:if test="${fjtuser.role eq 'mkt'  }">   
		 <div class="row">
				<div class="modal fade" id="newConsltnLds" role="dialog">
				
			       <div class="modal-dialog">
			    
				      <!-- Modal content-->
				      <div class="modal-content">
				        <div class="modal-header">
				          <button type="button" class="close" data-dismiss="modal">&times;</button>
				          <h4 class="modal-title">Enter New Consultant Status Details</h4>
				        </div>
				        <div class="modal-body">
				          
                        
  					<form role="form" action="ConsultantLeads" id="processOne" method="POST"  >
  					<input type="hidden" value="cnclfpad" name="octjf" />
              <div class="box-body">
               <div class="row">  
               <div class="col-md-8">
                <div class="form-group">
              
                 <label for="newConsltnt">Consultant</label>
    <select class="form-control" name="newConsltnt" id="newConsltnt" required>
        <option value="">Select Consultant</option>
        <c:forEach var="consultLst" items="${CLFCL}">
            <option value="${consultLst.conslt_name}">${consultLst.conslt_name}</option>
        </c:forEach>
    </select>

    <!-- Initialize Select2 on the dropdown -->
    <script>
        $(document).ready(function() {
            $('#newConsltnt').select2({
                placeholder: 'Search for a Consultant',
                allowClear: true
            });
        });
    </script>
             
                </div>
<!--                  <div class="col-xs-12"  style="margin-bottom:15px;"> -->
<!-- 					 <div class="col-md-6" style="padding: 0px;!important"> -->
						 <div class="form-group" >
		                  <label>Division</label>
		                  <select class="form-control" name="newDiv" id="newDiv" required>
		                  <option>Select Division</option>	
		                    <c:forEach var="dvnLst"  items="${DLFCL}" >
		                    <option value="${dvnLst.divn_code}">${dvnLst.divn_name}</option>
		                    </c:forEach>
		                  </select>
		                </div> 
		                <div class="container">
                           <div class="row" style="margin-right:45px;">
        <!-- Column for Status Dropdown -->
                                 <div class="col-md-2" style="margin-bottom:15px;" style="margin-right:2px;">
		                  <div class="form-group">
                                        <label for="newstatus">Status</label>
                                        <select class="form-control" name="newstatus" id="newstatus" required>
                                            <option value="">Select Status</option>
                                            <option value="Currently Working">Currently Working</option>
                                            <option value="Approved">Approved</option>
                                            <option value="Not Yet Approved">Not Yet Approved</option>
                                            <option value="Not Initiated">Not Initiated</option>
                                        </select>
                                    </div>
                                    </div>
                                    <div class="col-md-2">
                                    <div class="form-group">
                                        <label for="bybdmyorno1">Evidence of Approval</label>
                                        <select class="form-control" name="bybdmyorno1" id="bybdmyorno1" required disabled>
                                            <option value="">Select</option>
                                            <option value="Yes">Yes</option>
                                            <option value="No">No</option>
                                        </select>
                                    </div>
                                    </div>
                                    </div>
                                     </div>
                                    
                                 
<!-- 	                </div>   -->
<!-- 	                 <div class="col-md-5" style="padding: 0px;!important;float:right;">     -->
		                     
<!-- 				     </div>        	 -->
<!--                 </div> -->
		<!-- 			 <div class="btn-group" style="margin-bottom:15px;">
	                  <label>Status</label>
	                  <select class="form-control" name="newstatus" id="newstatus" required>
	                    <option value="">Select Status</option>
	                     <option value="Currently Working">Currently Working</option> 
	                    <option value="Approved">Approved</option>
	                    <option value="Not Yet Approved">Not Yet Approved</option>
	                    <option value="Not Initiated">Not Initiated</option>                               
	                  </select>
	                </div>  
	                <style>
  .input-group-text {
    min-width: 120px; /* Adjust the width of the label if needed */
  }
  .form-control {
    flex: 1; /* Makes the select elements take up available space */
  }
</style>
   <div class="container">
  <div class="row">
    Column for Status Dropdown
    <div class="col-md-2" style="margin-bottom:15px;">
      <div class="form-group">
        <label for="newstatus">Status</label>
        <select class="form-control" name="newstatus" id="newstatus" required>
          <option value="">Select Status</option>
          <option value="Currently Working">Currently Working</option>
          <option value="Approved">Approved</option>
          <option value="Not Yet Approved">Not Yet Approved</option>
          <option value="Not Initiated">Not Initiated</option>
        </select>
      </div>
    </div>
    Column for Evidence of Approval Dropdown
    <div class="col-md-2">
      <div class="form-group">
        <label for="bybdmyorno">Evidence of Approval</label>
        <select class="form-control" name="bybdmyorno" id="bybdmyorno" required>
          <option value="">Select</option>
          <option value="Yes">Yes</option>
          <option value="No">No</option>
        </select>
      </div>
    </div>
  </div>
</div>
	      -->           
	      
	<!--       <div class="btn-group" style="margin-bottom:15px;">
    <label>Status</label>
    <select class="form-control" name="newstatusss" id="newstatusss" required>
        <option value="">Select Status</option>
        <option value="Currently Working">Currently Working</option>
        <option value="Approved">Approved</option>
        <option value="Not Yet Approved">Not Yet Approved</option>
        <option value="Not Initiated">Not Initiated</option>
    </select>
</div>
 -->
<!-- <div class="container">
    <div class="row">
        Column for Status Dropdown
        <div class="col-md-2" style="margin-bottom:15px;">
            <div class="form-group">
                <label for="newstatus">Status</label>
                <select class="form-control" name="newstatus" id="newstatus" required>
                    <option value="">Select Status</option>
                    <option value="Currently Working">Currently Working</option>
                    <option value="Approved">Approved</option>
                    <option value="Not Yet Approved">Not Yet Approved</option>
                    <option value="Not Initiated">Not Initiated</option>
                </select>
            </div>
        </div>
        Column for Evidence of Approval Dropdown
        <div class="col-md-2">
            <div class="form-group">
                <label for="bybdmyorno">Evidence of Approval</label>
                <select class="form-control" name="bybdmyorno1" id="bybdmyorno1" required disabled>
                    <option value="">Select</option>
                    <option value="Yes">Yes</option>
                    <option value="No">No</option>
                </select>
            </div>
        </div>
    </div>
</div> -->
 <script>
      $(document).ready(function() {
        $('#newstatus').change(function() {
          if ($(this).val() === 'Approved') {
            $('#bybdmyorno1').prop('disabled', false);
          } else {
            $('#bybdmyorno1').prop('disabled', true);
          }
        });
      });
    </script>

	                 
	            <!--       <div class="form-group">
                  <label>Evidence of Approval</label>
                  <select class="form-control" name="bybdmyorno" id="bybdmyorno" required>
                    <option value="">Select</option>
                    <option value="Yes">Yes</option> 
                    <option value="No">No</option>
                  </select>
                </div>      -->  
                    
                         
                </div>
                <div class="col-md-4">                  
				 <div class="form-group" >
                 <label for="mktRmrk">Consultant Type</label>
                  <select class="form-control" name="consultantType" id="consultantType" required>
                    <option value="">Select Consultant Type</option>
                     <option value="Primary">Primary</option> 
                    <option value="Secondary">Secondary</option>
                  </select>
                </div> 
                <div class="btn-group" id="productDiv">
             	  <label>Product</label><br/>
			       <select  class="form-control form-control-sm"  id="productsOpt" multiple="multiple"  name="newProduct" required>
			        </select>
			     </div>	 
                      <br>
			     <div class="form-group" style="margin-top:15px;">
                  <label>By BDM</label>
                  <select class="form-control" name="bybdmyorno" id="bybdmyorno" required>
                    <option value="">Select</option>
                    <option value="Yes">Yes</option> 
                    <option value="No">No</option>
                  </select>
                </div>              	
                </div>
                <div class="col-md-12">	
                	 <div class="form-group">
	                  <label for="mktRmrk">Contact Details</label>
	                  <textarea class="form-control" id="newConsDetails" placeholder="Enter Contact Details" name="newConsDetails" required></textarea>
	                </div> 	                 
				     <div class="form-group">
	                  <label for="mktRmrk">Meeting Notes</label>
	                  <textarea class="form-control" rows="2" id="meetingNotes" placeholder="Enter Meeting Notes" name="meetingNotes" required></textarea>
	                </div>
                 </div>
              </div>
              </div>
              <!-- /.box-body -->
              <div class="box-footer">
                <button type="submit" id="crtNewCnsltLds" class="btn btn-primary"   onclick="getSeletedval();" >Submit</button>
                <button type="submit" class="btn" style="border-color:red;margin-left:40%"><a href="https://dms.fjtco.com:7333/fjtcdms/SearchUI/LDBrowse.aspx?FID=64424621931" TARGET = "_blank" sytle="margin-right: 15px;color: cornsilk;">DMS-BD FOLDER LINK</a></button>
<!-- 					 <div class="btn btn-primary"><a href="https://dms.fjtco.com:7333/fjtcdms/Main/Dashboard.aspx">DMS-BD FOLDER LINK</a></div> -->
              </div>
              
            </form>
            
									        </div>
				        <div class="modal-footer">
				          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				        </div>
				      </div>
			   		 </div>
			   		  <div id="laoding" class="loader" ><img src="././resources/images/wait.gif"></div>
 					</div>
  
		</div>
		
		
		</c:if>
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
<script src="././resources/bower_components/fastclick/lib/fastclick.js"></script>
<script src="././resources/dist/js/adminlte.min.js"></script>
<!-- page script start -->
<script>
$(document).ready(function() {   
	 $('#laoding').hide();
	if ( window.history.replaceState ) {//script to avoid page resubmission of form on reload
        window.history.replaceState( null, null, window.location.href );
    }
	
	   $('#processOne').submit(function(evnt) {
			 if ((confirm('Are You sure, You Want to add new consultant lead details!'))) { 
				 preLoader();
				 return true;
				 }
			 else{return false;}
			});
	   
	   $('#displayCnsltnt tfoot th').each( function (i) {
	        var title = $('#displayCnsltnt thead th').eq( $(this).index() ).text();
	        $(this).html( '<input type="text" placeholder="Search '+title+'" data-index="'+i+'" />' );
	    } );
	   
	   var table =  $('#displayCnsltnt').DataTable( {
		   dom: 'Bfrtip',  
		   "paging":   true,
	        "ordering": false,    
	        "info":     true,
	        "searching": true,
	        fixedColumns:   true,
	        "lengthMenu": [[ 5, 10, 15, 25, -1], [ 5, 10, 15, 25, "All" ]], 
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-cloud-download" style="color: green; font-size: 1.5em;">Export</i>',
	                filename: "Consultant Leads Details - ${CURR_YR}",
	                title: "Consultant Leads Details -  ${CURR_YR}",
	                messageTop: 'The information in this file is copyright to Faisal Jassim Group.',
	                exportOptions: {
	                    columns: ':not(:last-child)',
	                  }
	                
	                
	            }
	          
	           
	        ],
           "createdRow": function ( row, data, index ) {      
           },
           initComplete: function () {
               this.api().columns([0,1,2,3,4,5,6]).every( function () {
                   var column = this;
                   var selectVal;
                   var selectDefault="Select";
                   var select = $('<select class="filter"><option value="">'+selectDefault+'</option></select>')
                       .appendTo( $(column.footer()).empty() )
                       .on( 'change', function () {
                           var val = $.fn.dataTable.util.escapeRegex(
                               $(this).val()
                           );
    
                           column
                               .search( val ? '^'+val+'$' : '', true, false )
                               .draw();
                       } );
                  
                   column.data().unique().sort().each( function ( d, j ) {
                	   selectVal=$(d).text();
                	   select.append( '<option value="'+selectVal+'">'+d+'</option>' )
                   } );
               } );
           }
	    } );
	   
	   $( table.table().container() ).on( 'keyup', 'tfoot input', function () {
		   table
	        .column( $(this).parent().index()+':visible' )
	        .search( "^" + this.value, true, false, true )
	        .draw();
	    } );
	   
	   $('#cnslttntfoot select.filter > option:first-child')
	    .text('Select By Consultant');
	   
	   $('#cnslttntTypefoot select.filter > option:first-child')
	    .text('Select By Consultant Type');
	   
	   $('#statusfoot select.filter > option:first-child')
	    .text('Select By Status');
	   
	   $('#pdctfoot select.filter > option:first-child')
	    .text('Select By Product');
	   
	   $('#dvnfltr select.filter > option:first-child')
	    .text('Select By Division');
	   
	   $('#bdmfltr select.filter > option:first-child')
	    .text('Select By BDM');
	   
	   $('#eoafltr select.filter > option:first-child')
	    .text('Select By EVE');
	   
	   $('#cbdmfltr select.filter > option:first-child')
	    .text('Created By');
	   
	   $('#allConsltnLds').on('click', function(e){ 
		
		   $.ajax({	        	    
	    		 'async': false,
	     		 type: 'POST',
	        	 url: 'ConsultantLeads',
	        	 data: {octjf: "dlcav"},
		  		 success: function(data) {
			     var op="";
			     var outdate="";
		  			var output="<table id='all-table' class='table table-bordered small'><thead><tr>"+"<th>#</th><th>Consultant</th><th>Product</th><th>Status</th>"+
		  			 "<th>Division</th><th>Remarks</th><th>Last Updated</th><th>Action</th></tr></thead><tbody>";
		  			 var j=0;for (var i in data) { 
		  				if(data[i].updated_date == '' || data[i].updated_date == undefined){
		  					outdate=$.trim(data[i].created_date.substring(0, 10)).split("-").reverse().join("/");
		  					}else{
		  						outdate=$.trim(data[i].updated_date);
		  						}
		  				 j=j+1; output+="<tr><td>"+j+"</td><td><span>" + $.trim(data[i].conslt_name)+ "</span></td>"+
		  			 "<td>" + $.trim(data[i].product)+ "</td><td>" + $.trim(data[i].status) + "</td>"+ "<td>" +$.trim(data[i].division)+ "</td><td>" + $.trim(data[i].remarks )+ "</td>"+		  
					 "<td>" +outdate+ "</td>"+
		  			 "<td>"+
		  			"<a href='#'  id='cedt' class='btn btn-primary btn-xs' data-backdrop='static' data-keyboard='false' data-toggle='modal' data-target='#editCDtls"+$.trim(data[i].cnslt_id)+"' >"+
		       		 "<i class=' fa fa-pencil' aria-hidden='true'></i>"+
		       		 "</a>"+
		       		"<form action='ConsultantLeads' method='POST' style='display: inline !important;' name='cnslt_form_delete'>"+
					 "<input type='hidden' value="+$.trim(data[i].cnslt_id)+" name='dic' />"+
					"<input type='hidden' name='octjf' value='etldpc' />"+
				     "<button type='submit' id='mkld'  class='btn btn-danger btn-xs'  onclick='if (!(confirm('Are You sure You Want to delete this Marketing Opportunitty!'))) return false' >"+
        		 "<i class='fa fa-trash' aria-hidden='true'></i></button>"+
        	"</form>"+
			 "</td>"+ "</tr>"; 
		  				 output+=""+$.trim(data[i].cnslt_id);
		  			 
		  			 } 
		  			
		  			 
		  			 output+="</tbody></table>";  $("#cnslt-content").html(output);
			    
			    
		  },
		  error:function(data,status,er) {	        		
		    alert(data);
		   }
		 });
		   
		   
	   }); 
	 
	   $('#productsOpt').multiselect({
	    	nonSelectedText: 'Select Products',
	        includeSelectAllOption: true
	       // buttonWidth: '354px'
	    });
	   
	   getProducts();
	   getConsultantType();
});

function loadMultiSelect(id){
	 $('#editproductsOpt'+id).multiselect({
	    	nonSelectedText: 'Select Products',
	        includeSelectAllOption: true
	    });
}
function createNewLead(){
	   $('#crtNewCnsltLds').on('click', function(e){        
			  var consltant_name = $('#newConsltnt').val();
			  alert(consltant_name);
			  var product=$('#newProduct').val();
			  var status=$('#newstatus').val();
			  var divsn=$('#newDiv').val();
			  var remark=$('#newConsRmrk').val();
			  var contactDetls=$('#newConsDetails').val();
			  if(consltant_name  != '' && product  != ''  && status != '' &&  divsn != '' &&  remark != '' &&  contactDetls != ''){
	        	       
	        	    	 $.ajax({	        	    
	        	    		 'async': false,
	        	     		 type: 'POST',
	        	        	 url: 'ConsultantLeads',
	        	        	 data: {octjf: "cnclfpad", cd1:$('#newConsltnt').val(), cd2:$('#newProduct').val(),cd3:$('#newstatus').val(),
	        	       		   cd4:$('#newDiv').val(),cd5:$('#newConsRmrk').val(),cd6:$('#newConsDetails').val()},
	        		  		 success: function(data) {
	        			   
	        			    $("#newConsltnLds").modal('hide');
	        			    
	        			    alert(data);
	        			    
	        			    
	        		  },
	        		  error:function(data,status,er) {	        		
	        		    alert(data);
	        		   }
	        		 });
			  }else{alert("Please fill all data's");}
       });
}
function validate(evt) {
	  var theEvent = evt || window.event;

	  // Handle paste
	  if (theEvent.type === 'paste') {
	      key = event.clipboardData.getData('text/plain');
	     
	  } else {
	  // Handle key press
	      var key = theEvent.keyCode || theEvent.which;
	      key = String.fromCharCode(key);
	  }
	  var regex = /[0-9]/;
	
	  if( !regex.test(key) ) {
		  if (key.length > 2) {
		        limitField.value = limitField.value.substring(0, limitNum);
		    }
		  document.getElementById('mktWeek').value="";
	    theEvent.returnValue = false;
	    if(theEvent.preventDefault) theEvent.preventDefault();
	  }
	  else{
		  if (key.length > 2) {
			  document.getElementById('mktWeek').value="";
			  theEvent.returnValue = false;
		    }
		 
	  }
	}
function getProducts(){
	 $('select[name=newDiv]').change(function(){ 
	      var division = $(this).val();
	  	  if(division  != ''){	
		    	 $.ajax({	        	    
		    		 'async': false,
		     		 type: 'POST',
		        	 url: 'SupportRequest',
		        	 data: {action: "prdctlist", cd1:division},
		        	 beforeSend: function() {
		        		 $('#productsOpt').empty(); 
		        	    },
			  		 success: function(data) {
			  			 var toAppend = ""; 
				  		  $.each(data,function(i,o){
				  	         toAppend += '<option value="'+data[i].product+'">'+data[i].product+'</option>';
				  			$('#productsOpt').html(data[i].product);
				  	      });
				  	      $('#productsOpt').append(toAppend);	
				  	      
				  	    
				        $('#productsOpt').multiselect('rebuild');	  	    			    
			  },
			  error:function(data,status,er) {	        		
			    console.log("NO Products");
			   }
			 });
	       }
	  	  else{$('#productsOpt').empty();}
	    });
}
function editSeletedval(id){	
    var selectedValues = [];  
    var editConsDetails =  $('#editConsDetails'+id).val();    
    $("#editproductsOpt"+id+" :selected").each(function(){
        selectedValues.push($(this).val());               
    });
     $('#product').val(selectedValues);
     $('#ud3').val(id);
     
	 if(editConsDetails == null || editConsDetails == ''){
		 alert("Enter contact details");
		 return false;
	 }
	 var eoaValue = $('#ud7').val();

	    // Set EOA value to hidden input 'ud7'
	    $('#ud7').val(eoaValue);
	$('#updateDetails').submit();
    return true;
   
   
  
}
function getSeletedval(){
	
    var selectedValues = [];    
   $("#productsOpt :selected").each(function(){
        selectedValues.push($(this).val()); 
    }); 
    return true;
    //alert(selectedValues);
   
  
}
function preLoader(){ $('#laoding').show();}	
function getConsultantType(){

    $('select[name=newConsltnt]').change(function(){
          var consultant = $(this).val();
             if(consultant  != ''){  
                   $.ajax({                      

                          'async': false,
                          type: 'POST',
                          url: 'ConsultantVisits',
                          data: {octjf: "consultantType", cd1:consultant},
                          beforeSend: function() {
                                 $('#consultantType').empty();
                             },
                                 success: function(data) {
                                        console.log("propf "+data.product);
                                       var product = data.product || "Not Assigned";  
                                       var  toAppend = '<option value="'+product+'">'+product+'</option>';
                                             //$('#consultantType').html(data.product);

                                     $('#consultantType').append(toAppend);
                               // $('#consultantType').multiselect('rebuild');   
                                       },
                                 error:function(data,status,er) { 
                                   console.log("NO Products");
                                  }
                        });
           }

             else{$('#consultantType').empty();}
        });

}
</script>
<!-- page Script  end -->

</c:when>
<c:otherwise>

        <body onload="window.top.location.href='logout.jsp'">
   
            
        </body>
  
</c:otherwise>
</c:choose>
</html>