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
 
  <!-- Theme style -->
  <link rel="stylesheet" href="././resources/dist/css/AdminLTE.min.css">
  <link rel="stylesheet" href="././resources/dist/css/skins/_all-skins.min.css">
   <link rel="stylesheet" href="././resources/css/mkt-layout.css?v=14032020">
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
#fj-page-head-box{border: none;}
.btn-group.open .dropdown-toggle {max-width: 180px !important;overflow: hidden  !important;}
</style>

</head>
<body class="hold-transition skin-blue sidebar-mini">
 <c:if test="${empty fjtuser.emp_code}"> <jsp:forward page="index.jsp"/> </c:if>
 <c:choose>
 <c:when test="${!empty fjtuser.emp_code and  ( fjtuser.role eq 'mkt' or fjtuser.role eq 'mg' or fjtuser.sales_code ne null )  and fjtuser.checkValidSession eq 1 }">
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
         <c:if test="${!empty fjtuser.emp_code and  ( fjtuser.role eq 'mkt' || !empty service.rows)  and fjtuser.checkValidSession eq 1  }">
         	<li><a href="AssignToPOC"><i class="fa fa-table"></i><span> Assign task to POC </span></a></li>
         </c:if>
          <c:if test="${!empty service.rows}">  
         	<li><a href="SupportRequest"><i class="fa fa-table"></i><span> BDM Support Request </span></a></li>
         </c:if>         
         <li class="active "><a href="ProjectLeads"  class="active"><i class="fa fa-columns"></i><span>Project Stages 0 & 1</span></a></li>         
         <li><a href="ProjectStatus"><i class="fa fa fa-bars"></i><span>Project Status</span></a></li>
		 <li><a href="ConsultantVisits"><i class="fa fa-columns"></i><span>Consultant Visits</span></a></li> 
		 <li><a href="ConsultantLeads"><i class="fa fa-line-chart"></i><span>Consultant Approval Status</span></a></li>
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
      <h1> Projects Stages 0 & 1 <small>Marketing Portal</small> </h1>
      <ol class="breadcrumb">
        <li><a href="homepage.jsp"><i class="fa fa-calendar"></i> Home</a></li>
        <li class="active">Marketing</li>
      </ol>
    </section>
    <!-- Main content -->
    <section class="content">
      <!-- Main row -->
       <div class="box box-success">	
       <div class="box-body chat">	   
	   <!-- Marketing Main Start -->
		        <div class="box-body chat">	   
				   <!-- Project Under Design Details Start -->
					 <div class="box-header">
		               <div class="pull-left"  style="display:inline-flex">
		               <div  class="box-title">Under Design Details</div>
		               <c:if test="${fjtuser.role eq 'mkt'}">
		               <button type="button" class="btn btn-default add-new" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#newUnderDsgn"><i class="fa fa-plus"></i> Add New</button>
		               </c:if>
		               <form method="POST" action="ProjectLeads">
		               <input type="hidden" value="dlmav" name="octjf" />
		               <button type="submit" class="btn btn-default add-new" >View All (Including Last Year)</button>
		               </form>  
		               </div>
			            </div>
			            <!-- /.box-header -->
			            
			        <!-- /.box-body -->        
		            <div class="box-body chat" >		            
		              <table class="table table-hover small marketing-dtls-table" id="displayLeads" style="border-top: 1px solid #4a46465e !important;" >		        		 
		        		    <thead>
		        			 <tr>		        			    
		        				<th>Opportunities</th>
		                        <th>Status</th>
		                        <th>Location</th>
		                         <th>Leads</th>
		                         <th>Division</th>
		                         <th>Product</th>
		                         <th>Main Contractor</th>
		                         <th>MEP Contractor</th>
		                         <th  width="67">Updated on </th>
		                      <c:if test="${fjtuser.role eq 'mkt'}">   <th  width="66">Action</th></c:if>
		                     </tr>
		                     </thead>
		                     <c:set var="mcount" value="0"/>
		                    <tbody>
		                      <c:forEach var="mktLst"  items="${MLWD}" >
		                     <c:set var="mcount" value="${mcount + 1 }"/>
		                      <tr>      				 
		                      <td>
		                      <p class="long-letters">${mktLst.opt}</p>
		                     
		                      
		                      <span class='highlight'>${mktLst.updateStatus}</span>
		                      </td>
		                         <td>${mktLst.status}</td>
		                        <td>${mktLst.location}</td>
		                        <!-- <td>${mktLst.leads}</td>-->
		                         <td><p class="long-letters">${mktLst.contactDtls} </p></td>                 
		                         <td>                 
		                         
		                           <c:forEach var="dvnLst"  items="${DLFCL}" >
		             <c:choose>
		             <c:when test="${mktLst.products eq dvnLst.divn_code}">
		               <b> ${dvnLst.divn_name}</b>		              
		             </c:when>		           
		             </c:choose>
		            </c:forEach>         
		                         </td>		                       		                         
		                         <td><p class="long-letters">${mktLst.remarks}</p></td>
		                         <td><p class="long-letters">${mktLst.mainContractor}</p></td>
		                         <td><p class="long-letters">${mktLst.mepContractor}</p></td>
		                         <td>		                         
		                         <fmt:parseDate value=" ${mktLst.updatedDate}" var="theDate"    pattern="yyyy-MM-dd HH:mm" />
		                           <fmt:formatDate value="${theDate}" pattern="MMM-YYYY"/>		                       
		                         </td>
		                         <c:if test="${fjtuser.role eq 'mkt'}">
		                              <td>
		                          <a href="#"   id="eg" class="btn btn-primary btn-xs" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#editMktleads${mcount}">
								       		 <i class=" fa fa-pencil" aria-hidden="true"></i>
								       		 </a>
								        	 <!-- delete -->
		   											<form action="ProjectLeads" method="POST" style="display: inline !important;" name="gs_form_delete">
			   											 <input type="hidden" value="${mktLst.id}" name="mktli" />
			     										<input type="hidden" name="octjf" value="delete" />
			     									     <button type="submit"   class="btn btn-danger btn-xs"  onclick="if (!(confirm('Are You sure You Want to delete this Marketing Opportunitty!'))) return false" >
										        		 <i class="fa fa-trash" aria-hidden="true"></i></button>
										        	</form>
										        	</td>
										        	</c:if>
		                     </tr>		                     		                     
		                         <c:if test="${fjtuser.role eq 'mkt'}">    <div class="row">
						<div class="modal fade" id="editMktleads${mcount}" role="dialog">
						
					       <div class="modal-dialog">
					    
						      <!-- Modal content-->
						      <div class="modal-content">
						        <div class="modal-header">
						          <button type="button" class="close" data-dismiss="modal">&times;</button>
						          <h4 class="modal-title">Edit Project Under Design Details</h4>
						        </div>
						        <div class="modal-body">						         		                        
		  							<form action="ProjectLeads" method="POST" class="form-vertical" name="gi_form_edit">		  						 			                    
								<input type="hidden" name="octjf" value="UPDATE" />
			                    <input type="hidden" name="mktli" value="${mktLst.id}" />
			                  <div class="row">  
		               <div class="col-md-8">
		                <div class="form-group">
		                  <label for="mktOpportunity">Opportunity</label>
		                  <textarea class="form-control" rows="3" id="mktOpportunity" placeholder="Enter Opportunity " name="mktOpportunity" required>${mktLst.opt}</textarea>		             
		                </div>           
		                <div class="form-group">
		                  <label for="mktContact">Leads</label>
		                  <input type="text" class="form-control" id="mktContact" placeholder="Enter Contact Details" name="mktContact" value="${mktLst.contactDtls}">
		                </div>
		               <div class="form-group">
		                  <label for="mktRmrk">Product</label>
		                  <input type="text" class="form-control"    name="prodct" readonly value="${mktLst.remarks}" />
		                </div>
		                 <div class="form-group">
		                  <label for="mktLocation">Main Contractor</label>  
		                  <input type="text" class="form-control" id="mktMainCont" placeholder="Enter Main Contractor Details" name="mktMainCont" value="${mktLst.mainContractor}">
		                </div>
		                 <div class="form-group">
		                  <label for="mktLocation">MEP Contractor</label>  
		                  <input type="text" class="form-control" id="mktMepCont" placeholder="Enter  MEP Contractor Details" name="mktMepCont" value="${mktLst.mepContractor}">
		                </div>
		                </div>
		                <div class="col-md-4">
		                  <div class="form-group">
		                  <label>Status</label>
		                  <select class="form-control" name="mkstatus">
		                    <option value="${mktLst.status}">${mktLst.status}</option>
		                    <option value="Concept">Concept</option>
		                    <option value="Design">Design</option>
		                    <option value="Tender">Tender</option>
<!-- 		                    <option value="JIH">JIH</option> -->
		                  </select>
		                </div>
		                 <div class="form-group">
		                  <label for="mktLocation">Location</label>
		                  
		                  
		                  <input type="text" class="form-control" id="mktLocation" placeholder="Enter Location Details" name="mktLocation" value="${mktLst.location}">
		                </div>     
		                 <input type="hidden" value="Consultant" name="mkLeads"/>
		                
		           
		                
		                     <div class="form-group" >
		                  <label>Division</label>
		                  <input type="text" class="form-control"  readonly name="mkDivn" value="${mktLst.products}">
		                </div>
		               <input type="hidden" value="${currWeek}" name="mktWeek" />
		                
		                </div>
		              
		              </div>    <div class="box-footer">
		                <button type="submit" class="btn btn-primary">Submit</button>
		              </div>
								</form>
											        </div>
						        <div class="modal-footer">
						          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						        </div>
						      </div>
					   		 </div>
		 					</div>
		  
				</div></c:if>
		                     </c:forEach>
		                    </tbody>
		                    <tfoot>
		                    <tr>
		                   
		        				 <th   class="tfoot1" >Opportunities</th>
		                         <th width="90" id="statusfoot">Status</th>
		                        <th width="90"  class="tfoot1" >Location</th>
		                         <th width="90" id="ldsfoot" >Leads</th>
		                        <!--   <th   class="tfoot1" >Contact Details </th>-->
		                         <th id="dvnfltr">Division</th>
		                         <th  class="tfoot1" >Remarks</th>
		                         <th   class="tfoot1" width="30">Week</th>
		                         <th   class="tfoot1"  width="67">Updated on </th>
		                      <c:if test="${fjtuser.role eq 'mkt'}">   <th   class="tfoot1"   width="35">Action</th></c:if>
		                    </tr>
		                    </tfoot>
		                    </table>
		            </div>
		            <!-- /.box-body -->
		          </div>
		             
		   <!-- Marketing Leads Details End -->
		    
		  </div>
		 </div>
		
		   <c:if test="${fjtuser.role eq 'mkt'}">    <div class="row">
				<div class="modal fade" id="newUnderDsgn" role="dialog">
				
			       <div class="modal-dialog">
			    
				      <!-- Modal content-->
				      <div class="modal-content">
				        <div class="modal-header">
				          <button type="button" class="close" data-dismiss="modal">&times;</button>
				          <h4 class="modal-title">Enter Under Design Details</h4>
				        </div>
				        <div class="modal-body">
				          
                        
  					<form role="form" action="ProjectLeads" method="post" id="processOne">
              <div class="box-body">
               <div class="row">  
               <div class="col-md-8">
                <div class="form-group">
                  <label for="mktOpportunity">Opportunity</label>
                  <textarea class="form-control" rows="3" id="mktOpportunity" placeholder="Enter Opportunity " name="mktOpportunity" required></textarea>
             
                </div>          
                <div class="form-group">
                  <label for="mktContact">Leads</label>
                  <input type="text" class="form-control" id="mktContact" placeholder="Enter Contact Details" name="mktContact" >
                </div>
                   <div class="form-group" >
                  <label>Division</label>
                   <select class="form-control" name="mkDivn" required>
                  <option value="" >Select Division</option>
                    <c:forEach var="dvnLst"  items="${DLFCL}" >
                    <option value="${dvnLst.divn_code}">${dvnLst.divn_name}</option>
                    </c:forEach>
                    
                  </select>
                </div>  
                 <div class="form-group">
                  <label for="mktLocation">Main Contractor</label>  
                  <input type="text" class="form-control" id="mktMainCont" placeholder="Enter Main Contractor Details" name="mktMainCont" value="${mktLst.mainContractor}">
                </div>
                 <div class="form-group">
                  <label for="mktLocation">MEP Contractor</label>  
                  <input type="text" class="form-control" id="mktMepCont" placeholder="Enter  MEP Contractor Details" name="mktMepCont" value="${mktLst.mepContractor}">
                </div>
                </div>
                <div class="col-md-4">
                  <div class="form-group">
                  <label>Status</label>
                  <select class="form-control" name="mkstatus" >
                    <option value="">Select Status</option>
                    <option value="Concept">Concept</option>
                    <option value="Design">Design</option>
                    <option value="Tender">Tender</option>
<!--                     <option value="JIH">JIH</option> -->
                  </select>
                </div>
                <input type="hidden" value="Consultant" name="mkLeads"/>
               
			     <div class="form-group" id="productDiv">
			       <select  class="form-control form-control-sm"  style="width: 100%;"   id="productsOpt" multiple="multiple"  name="prodct" required>
			        </select>
			     </div>
               
               
                 <div class="form-group">
                  <label for="mktLocation">Location</label>         
                  <input type="text" class="form-control" id="mktLocation" placeholder="Enter Location Details" name="mktLocation" >
                </div>
                 <input type="hidden" value="${currWeek}" name="mktWeek" />
                </div>
              </div>
              </div>
              <!-- /.box-body -->
              <input type="hidden" name="octjf" value="etadputkm">
              <div class="box-footer">
                <button type="submit" class="btn btn-primary"  onclick="getSeletedval();" >Submit</button>
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
      <!-- /.row (main row) -->

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
	
	 $('#productsOpt').multiselect({
	    	nonSelectedText: 'Select Products',
	        includeSelectAllOption: true
	    });
	    getProducts();
	   
	   /*----------------*/
	   $('#processOne').submit(function(evnt) {
		 if ((confirm('Are You sure, You Want to add new under design details!'))) { 
			 preLoader();
			 return true;
			 }
		 else{return false;}
		});
	   
	   	   $('#displayLeads tfoot th').each( function (i) {
	        var title = $('#displayLeads thead th').eq( $(this).index() ).text();
	        $(this).html( '<input type="text" placeholder="Search '+title+'" data-index="'+i+'" />' );
	    } );
	   var table =  $('#displayLeads').DataTable( {
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
	                filename: "Project Under Design Details - ${CURR_YR}",
	                title: "Project Under Design Details -  ${CURR_YR}",
	                messageTop: 'The information in this file is copyright to Faisal Jassim Group.',
	                exportOptions: {
	                    columns: ':not(:last-child)',
	                  }	                	                
	            }	          	           
	        ],
	        
           "createdRow": function ( row, data, index ) {      
           },
           initComplete: function () {
               this.api().columns([1,3,4]).every( function () {
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
	   
	   /*----------------*/
	   
	   $('#allConsltnLds').on('click', function(e){ 
		
		   $.ajax({	        	    
	    		 'async': false,
	     		 type: 'POST',
	        	 url: 'ProjectLeads',
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
		       		"<form action='ProjectLeads' method='POST' style='display: inline !important;' name='cnslt_form_delete'>"+
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
	   
	   $('#crtNewCnsltLds').on('click', function(e){        
			  var consltant_name = $('#newConsltnt').val();
			  var product=$('#newProduct').val();
			  var status=$('#newstatus').val();
			  var divsn=$('#newDiv').val();
			  var remark=$('#newConsRmrk').val();
			  if(consltant_name  != '' && product  != ''  && status != '' &&  divsn != '' &&  remark != ''){
	        	       
	        	    	 $.ajax({	        	    
	        	    		 'async': false,
	        	     		 type: 'POST',
	        	        	 url: 'MarketingLeads.jsp',
	        	        	 data: {octjf: "cnclfpad", cd1:$('#newConsltnt').val(), cd2:$('#newProduct').val(),cd3:$('#newstatus').val(),
	        	       		   cd4:$('#newDiv').val(),cd5:$('#newConsRmrk').val()},
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
	   
	   
	   
	   $('#statusfoot select.filter > option:first-child')
	    .text('Select By Status');
	   
	   $('#ldsfoot select.filter > option:first-child')
	    .text('Select By Leads');
	   
	   $('#dvnfltr select.filter > option:first-child')
	    .text('Select By Division');
});

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
	 $('select[name=mkDivn]').change(function(){ 
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
function getSeletedval(){
	
    var selectedValues = [];    
    $("#productsOpt :selected").each(function(){
        selectedValues.push($(this).val()); 
    });
    return true;
    //alert(selectedValues);
   
  
}
function preLoader(){ $('#laoding').show();}	
</script>
<!-- page Script  end -->

</c:when>
<c:otherwise>

        <body onload="window.top.location.href='logout.jsp'">
   
            
        </body>
  
</c:otherwise>
</c:choose>
</body>
</html>