<%-- 
    Document   : MARKETING LEAD 
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<link href="resources/abc/style.css" rel="stylesheet" type="text/css" />
	<link href="resources/abc/responsive.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="resources/abc/bootstrap.min.css">
	<script src="resources/abc/jquery.min.js"></script>
	<script src="resources/abc/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
	<script src="resources/js/mainview.js"></script>
    <link rel="stylesheet" href="resources/bower_components/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="resources/dist/css/skins/_all-skins.min.css">
	<link rel="stylesheet" type="text/css" href="resources/datatables/datatables-fjtco/css/jquery.dataTables.min.css" />
	<link rel="stylesheet" type="text/css" href="resources/datatables/buttons-fjtco/css/buttons.dataTables.min.css" />
	<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/dataTables.buttons.min.js"></script>
	<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.flash.min.js"></script>
	<script type="text/javascript" src="resources/datatables/ajax/excelmake/jszip.min.js"></script>
	<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.html5.min.js"></script>
	<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.print.min.js"></script>
 
  <!-- Theme style -->
  <link rel="stylesheet" href="resources/dist/css/AdminLTE.min.css">
  <link rel="stylesheet" href="resources/dist/css/skins/_all-skins.min.css">
   <link rel="stylesheet" href="resources/css/mkt-layout.css?v=280120c20">
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
 
</style>

</head>
<body class="hold-transition skin-blue sidebar-mini">
 <c:if test="${empty fjtuser.emp_code}"> <jsp:forward page="index.jsp"/> </c:if>
 <c:choose>
 <c:when test="${!empty fjtuser.emp_code and fjtuser.emp_code eq 'E000020' or fjtuser.emp_code eq 'E000001'  or fjtuser.emp_code eq 'E000063' or fjtuser.sales_code ne null or fjtuser.emp_code eq 'E003066'  and fjtuser.checkValidSession eq 1  and fjtuser.emp_com_code ne 'EME'}">
 
<div class="wrapper">

  <header class="main-header">
    <!-- Logo -->
    <a href="index2.html" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>FJ</b>M</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg">
          <img src="resources/images/logo_t5.jpg" height="49px" class="img-circle pull-left"  alt="Logo"><b>Marketing</b>
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
   
          <!-- Notifications: style can be found in dropdown.less -->
          <li class="dropdown notifications-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-bell-o"></i>
              <span class="label label-warning">10</span>
            </a>
            <ul class="dropdown-menu">
              <li class="header">You have 10 notifications</li>
              <li>
                <!-- inner menu: contains the actual data -->
                <ul class="menu">
                  <li>
                    <a href="#">
                      <i class="fa fa-users text-aqua"></i> 5 new members joined today
                    </a>
                  </li>
                  <li>
                    <a href="#">
                      <i class="fa fa-warning text-yellow"></i> Very long description here that may not fit into the
                      page and may cause design problems
                    </a>
                  </li>
                  <li>
                    <a href="#">
                      <i class="fa fa-users text-red"></i> 5 new members joined
                    </a>
                  </li>
                  <li>
                    <a href="#">
                      <i class="fa fa-shopping-cart text-green"></i> 25 sales made
                    </a>
                  </li>
                  <li>
                    <a href="#">
                      <i class="fa fa-user text-red"></i> You changed your username
                    </a>
                  </li>
                </ul>
              </li>
              <li class="footer"><a href="#">View all</a></li>
            </ul>
          </li>
    
          <!-- User Account: style can be found in dropdown.less -->
          <li class="dropdown user user-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-user-circle"></i>
              <span class="hidden-xs">${fjtuser.uname}</span>
            </a>
          
          </li>
          <!-- Control Sidebar Toggle Button -->
          <li>
            <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
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
       <form method="POST" action="ConsultantLeads" class="sidebar-form">
        <div class="input-group">
          <input type="text" class="form-control" placeholder="Search by consultant..." name="srch-term" id="srch-term" type="text" required>
          <input type="hidden" name="octjf" value="sbcnfpdw"/>
          <span class="input-group-btn">
                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                </button>
              </span>
        </div>
      </form>
      <!-- /.search form -->
      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu" data-widget="tree">
         <li><a href="ProjectLeads"><i class="fa fa-dashboard"></i><span>Projects Under Design</span></a></li>
         <li class="active"><a href="#"><i class="fa fa-line-chart"></i><span>Consultant Leads</span></a></li>
         <li ><a href="#"><i class="fa fa-pie-chart"></i><span>Sales  Leads</span></a></li>
         <li><a href="#"><i class="fa fa-table"></i><span> BDM Support Request </span></a></li>
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
        Consultant Leads
        <small>Marketing Portal</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="calendar.jsp"><i class="fa fa-calendar"></i> Home</a></li>
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
			   <c:if test="${fjtuser.emp_code eq 'E000020' }">
			    <button type="button" class="btn btn-default add-new" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#newConsltnLds"><i class="fa fa-plus"></i> Add New</button>
			   </c:if>
			   </div>
			   <div>  
			   <form method="POST" action=ConsultantLeads>
			   <input type="hidden" value="dlcav" name="octjf" />
			   <button type="submit" class="btn btn-default add-new"  >View All</button>
			   </form>
			   </div>
               </div>
                    <div class="pull-right" id="dwnldexcl">
		             <table id="dwnldLeads" style="display:none;">
		             <thead><tr style="color:#0e64a4;"> <th>Consultant</th><th>Product</th>   <th>Status</th>
		             <th>Division</th>
		             <th>Remarks</th><th>Updated</th> </tr>
		             </thead> <tbody> <c:forEach var="cnsltLst"  items="${VACLD}" > <tr>
		             <td>${cnsltLst.conslt_name}
		               <span class='highlight'>${cnsltLst.updateStatus}</span>
		             </td> <td>${cnsltLst.product}</td> 
		             <td>${cnsltLst.status} </td>
		              <td>
		               <c:forEach var="dvnLst"  items="${DLFCL}" >
		             <c:choose>
		             <c:when test="${cnsltLst.division eq dvnLst.divn_code}">${dvnLst.divn_name} </c:when>             
		             </c:choose>
		            </c:forEach>         
		             </td>
		             <td>${cnsltLst.remarks}</td> 
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
		               </tr>
		              </c:forEach> 
		              </tbody>  
		              </table> 
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
		             <thead><tr> <th>Consultant</th><th>Product</th>   <th  width="100px">Status</th>
		             <th  width="100px">Division</th><th>Remarks</th><th  width="93px">Last Updated</th>
		            <c:if test="${fjtuser.emp_code eq 'E000020' }"> <th  width="65px">Action</th></c:if> </tr>
		             </thead> <tbody> <c:forEach var="cnsltLst"  items="${VACLD}" > <tr>
		             <td><p class="long-letters">${cnsltLst.conslt_name}</p><span class='highlight'>${cnsltLst.updateStatus}</span></td>
		             <td><p class="long-letters">${cnsltLst.product}</p></td> 
		             <td>
		             <c:choose>
		             <c:when test="${cnsltLst.status eq 'Currently Working'}"><span class="label label-info">${cnsltLst.status}</span> </c:when>
		             <c:when test="${cnsltLst.status eq 'Approved'}"><span class="label label-success">${cnsltLst.status}</span> </c:when>
		             <c:when test="${cnsltLst.status eq 'Not Yet Approved'}"><span class="label label-warning">${cnsltLst.status}</span> </c:when>
		             <c:otherwise><span class="label label-danger">${cnsltLst.status}</span> </c:otherwise>
		             </c:choose>  
		             </td>
		             <td>
		               <c:forEach var="dvnLst"  items="${DLFCL}" >
		             <c:choose>
		             <c:when test="${cnsltLst.division eq dvnLst.divn_code}">
		            
		                  <span class="label label-default" style="padding:5px;background-color: #ffffff;">${dvnLst.divn_name}</span>
		              
		             </c:when>             
		             </c:choose>
		            </c:forEach>
		              <c:if test="${cnsltLst.division eq 'AD' and cnsltLst.division ne dvnLst.divn_code}">
		            
		                  <span class="label label-default" style="padding:5px;background-color: #ffffff;">All Division</span>
		              
		             </c:if>
		             
		             </td>
		             <td><p class="long-letters">${cnsltLst.remarks} </p></td> <td>
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
		             
		                     <c:if test="${fjtuser.emp_code eq 'E000020' }">
		                              <td>
		                          <a href="#"   id="eg" class="btn btn-primary btn-xs" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#updateCnslt${cnsltLst.cnslt_id}">
								       		 <i class=" fa fa-pencil" aria-hidden="true"></i>
								       		 </a>
								        	 <!-- delete -->
		   											<form action="ConsultantLeads" method="POST" style="display: inline !important;" >
			   											 <input type="hidden" value="${cnsltLst.cnslt_id}" name="dd1" />
			     										<input type="hidden" name="octjf" value="dsclfpad" />
			     									     <button type="submit" id="mkld"  class="btn btn-danger btn-xs"  onclick="if (!(confirm('Are You sure You Want to Delete this this Consultant Leads!'))) return false" >
										        		 <i class="fa fa-trash" aria-hidden="true"></i></button>
										        	</form>
										        	</td>
										        	</c:if>
		             
		              </tr>
		               <c:if test="${fjtuser.emp_code eq 'E000020' }">
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
		            <Strong >Product : </Strong ><span>${cnsltLst.product}</span><br/>
		             <Strong >Division :  </Strong ><span>${cnsltLst.division}</span><br/>
		             <Strong >Last updated on  :  </Strong ><span>
		             <c:choose> 
		              <c:when test="${cnsltLst.updated_date eq null or cnsltLst.updated_date  eq '' or cnsltLst.updated_date  eq 'undefined'}">
		              ${cnsltLst.created_date}
		              </c:when>
		              <c:otherwise> ${cnsltLst.updated_date}</c:otherwise>
		                         </c:choose>
		             
		             </span>
		             </div>
		             </div>
		             <form  action="MarketingLeads.jsp" method="POST"  >
		             <div class="row">
		             
		            <div class="col-md-4">
		             <div class="form-group">
		                  <label>Status</label>
		                  <select class="form-control" name="ud1" id="updtConsStatus" required>
		                  
		                    <option value="${cnsltLst.status}">${cnsltLst.status}</option>
		                    <option value="Currently Working">Currently Working</option> 
		                    <option value="Approved">Approved</option>
		                    <option value="Not Yet Approved">Not Yet Approved</option>
		                    <option value="Not Initiated">Not Initiated</option>            
		                  </select>
		             
		              </div>
		            </div>
		             <div class="col-md-8">
		                <div class="form-group">
		                  <label for="mktRmrk">Remarks</label>
		                  <textarea class="form-control" rows="3" id="updtConsRmrk" placeholder="Enter Contact Details" name="ud2" required>${cnsltLst.remarks}</textarea>
		                </div>
		             
		             </div>
		             </div>
		            
		                </div>
		              
		                 
		              </div>
		              <!-- /.box-body -->
		              <div class="box-footer">
		              <input type="hidden" value="${cnsltLst.cnslt_id}" name="ud3">
		              <input type="hidden" value="unclfpad" name="octjf"/>
		                <button type="submit" id="updtCnsltLds" class="btn btn-primary">Update</button>
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
		              <th id="cnslttntfoot">Consultant</th><th  class="tfoot1" >Product</th>   <th  width="100px"  id="statusfoot">Status</th>
		             <th  width="100px" id="divnfoot">Division</th><th  class="tfoot1" >Remarks</th><th  width="93px"  class="tfoot1" >Last Updated</th>
		            <c:if test="${fjtuser.emp_code eq 'E000020' }"> <th  width="65px"  class="tfoot1" >Action</th></c:if> 
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
	
                         <c:if test="${fjtuser.emp_code eq 'E000020' }">   
		 <div class="row">
				<div class="modal fade" id="newConsltnLds" role="dialog">
				
			       <div class="modal-dialog">
			    
				      <!-- Modal content-->
				      <div class="modal-content">
				        <div class="modal-header">
				          <button type="button" class="close" data-dismiss="modal">&times;</button>
				          <h4 class="modal-title">Enter New Consultant Leads  Details</h4>
				        </div>
				        <div class="modal-body">
				          
                        
  					<form role="form" id="newConsult_form"  >
              <div class="box-body">
               <div class="row">  
               <div class="col-md-8">
                <div class="form-group">
                  <label for="newConsltnt">Consultant</label>
                  <input type="text" class="form-control" id="newConsltnt" placeholder="Enter Consultant Details" name="newConsltnt" required>
             
                </div>
                <div class="form-group">
                  <label for="mktLocation">Product Name</label>
                  
                  
                  <input type="text" class="form-control" id="newProduct" placeholder="Enter Location Details" name="newProduct" required>
                </div>
            
               <div class="form-group">
                  <label for="mktRmrk">Remarks</label>
                  <textarea class="form-control" rows="3" id="newConsRmrk" placeholder="Enter Contact Details" name="newConsRmrk" required></textarea>
                </div>
                </div>
                <div class="col-md-4">
                  <div class="form-group">
                  <label>Status</label>
                  <select class="form-control" name="newstatus" id="newstatus" required>
                    <option value="">Select Status</option>
                     <option value="Currently Working">Currently Working</option> 
                    <option value="Approved">Approved</option>
                    <option value="Not Yet Approved">Not Yet Approved</option>
                    <option value="Not Initiated">Not Initiated</option>                               
                  </select>
                </div>
                 <div class="form-group" >
                  <label>Division</label>
                  <select class="form-control" name="newDiv" id="newDiv" required>
                  <option>Select Division</option>
                    <option value="AD">All Division</option>
                    <c:forEach var="dvnLst"  items="${DLFCL}" >
                    <option value="${dvnLst.divn_code}">${dvnLst.divn_name}</option>
                    </c:forEach>
                    
                  </select>
                </div>
            
              
                </div>
              </div>
              </div>
              <!-- /.box-body -->
              <div class="box-footer">
                <button type="button" id="crtNewCnsltLds" class="btn btn-primary">Submit</button>
              </div>
            </form>
									        </div>
				        <div class="modal-footer">
				          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				        </div>
				      </div>
			   		 </div>
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

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Create the tabs -->
    <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
      <li><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
      <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
    </ul>
    <!-- Tab panes -->
    <div class="tab-content">
      <!-- Home tab content -->
      <div class="tab-pane" id="control-sidebar-home-tab">
        <h3 class="control-sidebar-heading">Recent Activity</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:void(0)">
              <i class="menu-icon fa fa-birthday-cake bg-red"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

                <p>Will be 23 on April 24th</p>
              </div>
            </a>
          </li>
          <li>
            <a href="javascript:void(0)">
              <i class="menu-icon fa fa-user bg-yellow"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">Frodo Updated His Profile</h4>

                <p>New phone +1(800)555-1234</p>
              </div>
            </a>
          </li>
          <li>
            <a href="javascript:void(0)">
              <i class="menu-icon fa fa-envelope-o bg-light-blue"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">Nora Joined Mailing List</h4>

                <p>nora@example.com</p>
              </div>
            </a>
          </li>
          <li>
            <a href="javascript:void(0)">
              <i class="menu-icon fa fa-file-code-o bg-green"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">Cron Job 254 Executed</h4>

                <p>Execution time 5 seconds</p>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

        <h3 class="control-sidebar-heading">Tasks Progress</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:void(0)">
              <h4 class="control-sidebar-subheading">
                Custom Template Design
                <span class="label label-danger pull-right">70%</span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
              </div>
            </a>
          </li>
          <li>
            <a href="javascript:void(0)">
              <h4 class="control-sidebar-subheading">
                Update Resume
                <span class="label label-success pull-right">95%</span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-success" style="width: 95%"></div>
              </div>
            </a>
          </li>
          <li>
            <a href="javascript:void(0)">
              <h4 class="control-sidebar-subheading">
                Laravel Integration
                <span class="label label-warning pull-right">50%</span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-warning" style="width: 50%"></div>
              </div>
            </a>
          </li>
          <li>
            <a href="javascript:void(0)">
              <h4 class="control-sidebar-subheading">
                Back End Framework
                <span class="label label-primary pull-right">68%</span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-primary" style="width: 68%"></div>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

      </div>
      <!-- /.tab-pane -->
      <!-- Stats tab content -->
      <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
      <!-- /.tab-pane -->
      <!-- Settings tab content -->
      <div class="tab-pane" id="control-sidebar-settings-tab">
        <form method="post">
          <h3 class="control-sidebar-heading">General Settings</h3>

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Report panel usage
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
              Some information about this general settings option
            </p>
          </div>
          <!-- /.form-group -->

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Allow mail redirect
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
              Other sets of options are available
            </p>
          </div>
          <!-- /.form-group -->

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Expose author name in posts
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
              Allow the user to show his name in blog posts
            </p>
          </div>
          <!-- /.form-group -->

          <h3 class="control-sidebar-heading">Chat Settings</h3>

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Show me as online
              <input type="checkbox" class="pull-right" checked>
            </label>
          </div>
          <!-- /.form-group -->

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Turn off notifications
              <input type="checkbox" class="pull-right">
            </label>
          </div>
          <!-- /.form-group -->

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Delete chat history
              <a href="javascript:void(0)" class="text-red pull-right"><i class="fa fa-trash-o"></i></a>
            </label>
          </div>
          <!-- /.form-group -->
        </form>
      </div>
      <!-- /.tab-pane -->
    </div>
  </aside>
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
       immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>
</div>
<script>
  $.widget.bridge('uibutton', $.ui.button);
</script>
<script src="resources/bower_components/fastclick/lib/fastclick.js"></script>
<script src="resources/dist/js/adminlte.min.js"></script>
<!-- page script start -->
<script>
$(document).ready(function() {   
	   $('#dwnldLeads').DataTable( {
		   dom: 'Bfrtipr',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-cloud-download" style="color: green; font-size: 2em;"></i>',
	                filename: "Projects Under Design Details - ${currCal}",
	                title: "Projects Under Design Details -  ${currCal}",
	                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	          
	           
	        ]
	    } );
	   $('#displayCnsltnt').DataTable( {
			  
		   "paging":   true,
	        "ordering": false,    
	        "info":     true,
	        "searching": true,
	        fixedColumns:   true,
	        "lengthMenu": [[ 5, 10, 15, 25, -1], [ 5, 10, 15, 25, "All" ]] 
	       
	    } );
	   
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
	        	        	 url: 'ConsultantLeads',
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
</script>
<!-- page Script  end -->
</body>
</c:when>
<c:otherwise>

        <body onload="window.top.location.href='logout.jsp'">
   
            
        </body>
  
</c:otherwise>
</c:choose>
</html>