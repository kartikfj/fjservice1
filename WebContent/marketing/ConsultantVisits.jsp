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
          <c:if test="${!empty service.rows}">  
         	<li><a href="SupportRequest"><i class="fa fa-table"></i><span> BDM Support Request </span></a></li>
         </c:if>        
         <li><a href="ProjectLeads"  class="active"><i class="fa fa-columns"></i><span>Project Stages 0 & 1</span></a></li>         
         <li><a href="ProjectStatus"><i class="fa fa fa-bars"></i><span>Project Status</span></a></li>
		 <li  class="active"><a href="ConsultantVisits"><i class="fa fa-columns"></i><span>Consultant Visits</span></a></li> 
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
      <h1>
        Consultant Visits
        <small>Marketing Portal</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="homepage.jsp"><i class="fa fa-calendar"></i> Home</a></li>
        <li class="active">Marketing</li>
      </ol>
    </section>
    <!-- Main content -->
    <section class="content">
      <!-- Main row -->
       <div class="box box-success">	
        <div class="box-header">
        	  <div class="pull-left" style="display:inline-flex">
				   <div  class="box-title">Consultant Visits Details</div>
				   <div>
				   <c:if test="${fjtuser.role eq 'mkt'  }">
				    <button type="button" class="btn btn-default add-new" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#newConsltnVisits"><i class="fa fa-plus"></i> Add New</button>
				   </c:if>
				   </div>
               </div>
           </div>
	   <!-- Marketing Main Start -->
		        
			            
			        <!-- /.box-body -->        
		            <div class="box-body chat" >	
		         	  <c:choose>
		     				<c:when test="${!empty  VACLD  and  VACLD ne null}">  
		     				<div  class="row consultant-row">  
		     				 <c:if test="${MSG ne null or !empty MSG}">
		            	<div class="alert alert-warning alert-dismissible">
						  <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
						  <strong>Info!</strong>  ${MSG} 
			            </div>  
			         </c:if>   
			         <div class="table-responsive" id="cnslt-table">            
		              <table class="table table-hover small marketing-dtls-table" id="displayLeads" style="border-top: 1px solid #4a46465e !important;" >		        		 
		        		    <thead>
		        			 <tr>		        			    
		        				<th>Consultant</th><th>Consultant Type</th><th>Visit Date</th>   <th>Visit Reason</th>
		           				<th>No.of Attendees</th><th>Division</th><th>Product</th><th>Meeting Person Details</th><th>Meeting Notes</th>
		                     </tr>
		                     </thead>
		                     <c:set var="mcount" value="0"/>
								<tbody> <c:forEach var="cnsltLst"  items="${VACLD}" > <tr>
					             <td><p class="long-letters">${cnsltLst.conslt_name}</p></td>
					              <td><p class="long-letters">${cnsltLst.consultantType}</p></td>
					             <td><fmt:parseDate value="${cnsltLst.date}" var="theCDate"    pattern="yyyy-MM-dd" />
					             <fmt:formatDate value="${theCDate}" pattern="dd-MM-YYYY"/></td> 
					             <td><p class="long-letters">${cnsltLst.visit_reason}</p></td> 
					             <td><p class="long-letters">${cnsltLst.noofattendees}</p></td>
					             <td>
					             <c:forEach var="dvnLst"  items="${DLFCL}" >		          	             
						              <c:if test="${cnsltLst.division eq dvnLst.divn_code}">
						                   <p class="long-letters">${dvnLst.divn_name}</p>		              
						             </c:if>
						          </c:forEach>
					             </td> 
					             <td><p class="long-letters">${cnsltLst.product}</p></td> 		           
					             <td><p class="long-letters">${cnsltLst.meetingperson_details} </p></td>
								  <td><p class="long-letters">${cnsltLst.meeting_notes}</p></td> 
					               		            
					                     
					              </tr>
			
					              
					              </c:forEach> </tbody> 
		                     <tfoot>
					            <tr>
					              <th id="cnslttntfoot">Consultant</th> <th id="cnslttntTypefoot">Consultant Type</th><th  class="tfoot1"   id="pdctfoot">Visit Date</th>   <th  width="100px"  id="statusfoot">Visit Reason</th>
					             <th  width="100px" id="noofattenfltr">No.of Attendees</th> <th  width="100px" id="dvnfltr">Division</th><th  class="tfoot1" >Meeting Person Details</th><th  width="93px"  class="tfoot1" >Meeting Notes</th>
					          
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
		            <!-- /.box-body -->
<!-- 		          </div> -->
		          
		             
		   <!-- Marketing Leads Details End -->
		    
		 
		 </div>
		<c:if test="${fjtuser.role eq 'mkt'  }">   
		 <div class="row">
				<div class="modal fade" id="newConsltnVisits" role="dialog">
				
			       <div class="modal-dialog">
			    
				      <!-- Modal content-->
				      <div class="modal-content">
				        <div class="modal-header">
				          <button type="button" class="close" data-dismiss="modal">&times;</button>
				          <h4 class="modal-title">Consultant Visit Details</h4>
				        </div>
				        <div class="modal-body">
				          
                        
  					<form role="form" action="ConsultantVisits" id="processOne" method="POST"  >
  					<input type="hidden" value="cnclfpad" name="octjf" />
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
              <div class="box-body">
               <div class="row">  
               <div class="col-md-8">
                <div class="form-group">
                  <label for="newConsltnt">Consultant</label>
				 <select class="form-control" name="newConsltnt" id="newConsltnt" required>
                    <option value="">Select Consultant</option>             
                    <c:forEach var="consultLst"  items="${CLFCL}" >
                    <option value="${consultLst.conslt_name}">${consultLst.conslt_name}</option>
                    </c:forEach>
                    
                  </select>
           <script>
        $(document).ready(function() {
            $('#newConsltnt').select2({
                placeholder: 'Search for a Consultant',
                allowClear: true,
                theme: 'bootstrap' // Use Bootstrap theme for Select2
            });
        });
    </script>
                </div>               
                <div class="form-group">
                  <label>Reason for visit</label>
                  <select class="form-control" name="reasontovisit" id="reasontovisit" required>
                    <option value="">Select Reason</option>
                     <option value="Corporate Presentation ">Corporate Presentation </option> 
                    <option value="Factory Visit">Factory Visit</option>
                    <option value="Technical Seminar">Technical Seminar</option>
                    <option value="Product or Technical Presentation">Product or Technical Presentation</option>
                    <option value="Online Presentation">Online Presentation</option>                                       
                  </select>
                </div>
                <div class="col-md-6" style="padding: 0px;!important">
	                <div class="form-group">
	                  <label>Division</label>
	                  <select class="form-control" name="newDiv" id="newDiv">
	                  <option value="">Select Division</option>
	                    <option value="AD">All Division</option>
	                    <c:forEach var="dvnLst"  items="${DLFCL}" >
	                    <option value="${dvnLst.divn_code}">${dvnLst.divn_name}</option>
	                    </c:forEach>
	                  </select>                 
	                </div>	                
                </div>
                 <div class="col-md-6" style="padding: 0px;!important">
	                <div class="form-group" style="float:right">
		                  <label for="mktRmrk">Date</label>
		                  <input  class="form-control" style="background-color:white"  type="text" id="datepicker-13" name="datepicker-13" autocomplete="off"/>
		             </div>
				</div>
<!--                <div class="form-group"> -->
<!--                   <label for="mktRmrk">Contact Details</label> -->
<!--                   <textarea class="form-control" rows="3" id="newConsDetails" placeholder="Enter Contact Details" name="newConsDetails" required></textarea> -->
<!--                 </div> -->
                </div>
                 
                <div class="col-md-4">
               <div class="form-group">
                  <label for="mktRmrk">Consultant Type</label>
                  <select class="form-control" name="consultantType" id="consultantType" required>
                    <option value="">Select Consultant Type</option>
                     <option value="Primary">Primary</option> 
                    <option value="Secondary">Secondary</option>
                  </select>
                </div>                 
				 <div class="form-group" id="productDiv">
	             	<label>No.of attendees</label>
							<input type="number" class="form-control" id="noofattendees" placeholder="No.of Attendees" min="1" max="50" name="noofattendees" autocomplete="off" required></input>
				 </div>
				  <div class="form-group" id="productDiv">
             	<label>Product</label><br/>
			       <select  class="form-control form-control-sm"  id="productsOpt" multiple="multiple"  name="newProduct">
			        </select>
			     </div>
              	
               
                </div>
                <div class="col-md-12">
		                 <div class="form-group" id="productDiv">
		             		<label>Meeting Person Detail</label>
					       <textarea class="form-control" rows="2" id="personDetails" placeholder="Meeting person details" name="personDetails" required></textarea>
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
                <button type="submit" id="crtNewCnsltLds" class="btn btn-primary"   onclick="getSeletedval();validateMandetoryFields()" >Submit</button>
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
	                filename: "Consultant Visits Details - ${CURR_YR}",
	                title: "Consultant Visits Details -  ${CURR_YR}",
	                messageBottom: 'The information in this file is copyright to Faisal Jassim Group.',
	               
	                
	            }
	          
	           
	        ],
	        
           "createdRow": function ( row, data, index ) {      
           },
           initComplete: function () {
               this.api().columns([0,1,2,3,4,5]).every( function () {
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
	   
	   $('#cnslttntfoot select.filter > option:first-child')
	    .text('Select By Consultant');
	   
	   $('#cnslttntTypefoot select.filter > option:first-child')
	    .text('Select By Consultant Type');
	   
	   $('#statusfoot select.filter > option:first-child')
	    .text('Select By Visit Reason');
	   
	   $('#pdctfoot select.filter > option:first-child')
	    .text('Select By Visit Date');
	   
	   $('#noofattenfltr select.filter > option:first-child')
	    .text('Select By No.of Attendees');
	   
	   $('#dvnfltr select.filter > option:first-child')
	    .text('Select By Division');
	   
	   $('#productsOpt').multiselect({
	    	nonSelectedText: 'Select Products',
	        includeSelectAllOption: true,	       
	    });
	   
	   getProducts();
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

function getSeletedval(){
	
    var selectedValues = [];    
    $("#productsOpt :selected").each(function(){
        selectedValues.push($(this).val()); 
    });
    return true;
    //alert(selectedValues);
   
  
}
document.getElementById('processOne').addEventListener('submit', function(event) {
    var myDivsionInputElement = document.getElementById('newDiv');
    var myproductInupuElement = document.getElementById('productsOpt');
  
    if ((myDivsionInputElement.hasAttribute('required') && !myDivsionInputElement.value.trim()) && (myproductInupuElement.hasAttribute('required') && !myproductInupuElement.value.trim()) ){
      event.preventDefault(); 
      alert('Please fill in the required field.'); 
    }
   
  });
function validateMandetoryFields(){
	var visitReasonSel = document.getElementById("reasontovisit").value;
	
	if(visitReasonSel.trim() == "Corporate Presentation" || visitReasonSel.trim() == "Online Presentation"){		
		$("#newDiv").prop('required', false);
		$("#productsOpt").prop('required', false);
	}else{
		$("#newDiv").prop('required', true);
		$("#productsOpt").prop('required', true);
	}
	
}
function preLoader(){ $('#laoding').show();}	
$(function () {   
    $("#datepicker-13").datepicker({ "dateFormat" : "dd/mm/yy", yearRange: "2020:2030", "minDate" : "-30D","maxDate" : "0"});    
});
$('#newConsltnVisits').on('hidden.bs.modal', function () {
    $(this).find('form').trigger('reset');
})
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