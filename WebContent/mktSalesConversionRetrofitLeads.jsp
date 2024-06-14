<%-- 
    Document   : MARKETING SALES LEAD 
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
	<script src="resources/js/mainview.js"></script>
	<script type="text/javascript" src="resources/js/mkt-salesconvretro.js?v=1"></script>
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
	<link rel="stylesheet" href="resources/bower_components/datepicker/dist/css/bootstrap-datepicker.min.css">
  <!-- Theme style -->
    <link rel="stylesheet" href="resources/bower_components/select2/dist/css/select2.min.css">
    <link rel="stylesheet" href="resources/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="resources/dist/css/skins/_all-skins.min.css">
    <link rel="stylesheet" href="resources/css/mkt-layout.css?v=29">

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
              <span class="hidden-xs"><c:out value="${fjtuser.uname}"/></span>
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
         <li><a href="ProjectLeads"  class="active"><i class="fa fa-dashboard"></i><span>Projects Under Design</span></a></li>
         <li><a href="ConsultantLeads"><i class="fa fa-line-chart"></i><span>Consultant Leads</span></a></li>
         <li class="active"><a href=""><i class="fa fa-pie-chart"></i><span>Sales Leads </span></a></li>
         <li><a href="#"><i class="fa fa-table"></i><span>BDM Support Request </span></a></li>
         <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>     
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1> Sales  Leads  <small>Marketing Portal</small> </h1>
      <ol class="breadcrumb">
        <li><a href="calendar.jsp"><i class="fa fa-calendar"></i> Home</a></li>
        <li class="active">Marketing</li>
      </ol>
    </section>
    <!-- Main content -->
    <section class="content">
    
		   <!-- SELECT2 EXAMPLE -->
      <div class="box box-default">
        <div class="box-header with-border">
          <h3 class="box-title">Sales Leads Form</h3>

          <div class="box-tools pull-right">
            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
          </div>
        </div>
        <!-- /.box-header -->
        <div class="box-body">
        <div class="row">
          <div class="col-md-12">
          <div class="pull-right">
            <button type="button" class="btn btn-sm btn-dark"><i class="fa fa-plus"></i> Create New Lead</button>
          </div>
          </div>
        </div>

        <!--  Process - 1 -->
          <div class="row mkt-form-row-border">
            <div class="col-md-3">
            
             <div class="form-group">
                <label>Division:</label>
                <select class="form-control select2" style="width: 100%;">
                  <option selected="selected">ECS</option>
                  <option>DCS</option>
                  <option>FT</option>
                </select>
              </div> 
            
	            <div class="form-group">
	                <label>Consultant / Client:</label> 
		           <input type="text" class="form-control">
	            </div>
	            
	          <div class="form-group">
                <label>Sales Engineer:</label>
                <select class="form-control select2" style="width: 100%;">
                  <option selected="selected">Rashad</option>
                  <option>DCS</option>
                  <option>FT</option>
                </select>
              </div>
	            
            </div>
    
          
             <div class="col-md-3">
             
              <div class="form-group">
	                <label>Type of initiation:</label>
	                <select class="form-control select2" style="width: 100%;">
	                <option selected="selected">Sales Conversion</option>
	                <option>Retrofit</option>
	                </select>
              </div>
              
               <div class="form-group"> 
		           <label>Contractor:</label>
		           <input type="text" class="form-control">
               </div> 
                
               <div class="form-group">
               <div class="input-group" style="padding-top: 2.5rem;">
               <button type="submit" class="btn btn-primary"><i class="fa fa-paper-plane"></i> Save New Lead & Send Mail to SE</button>
               </div>
              </div>
              
             </div>
                       
             <div class="col-md-3">
             
             <div class="form-group">
                <label>Products:</label>
                <select class="form-control select2" style="width: 100%;">
                  <option selected="selected">Sales Conversion</option>
                  <option>Retrofit</option>
                </select>
              </div>
              <div class="form-group">
		          <label>Offer Value:</label> 
			      <input type="number" class="form-control">
	          </div>
          
             </div>
             
           <div class="col-md-3">
            
              <div class="form-group">
                <label>Date of initiative:</label>

                <div class="input-group date" id="initiaDte">
                  <div class="input-group-addon">
                    <i class="fa fa-calendar"></i>
                  </div>
                  <input type="text" class="form-control pull-right" id="intDate">
                </div>
                <!-- /.input group -->
              </div>
              <div class="form-group">
	                <label>Closed Date:</label>
	                <div class="input-group date" id="initiaDte">
	                <div class="input-group-addon">
	                <i class="fa fa-calendar"></i>
	                </div>
	                <input type="text" class="form-control pull-right" id="closeDate">
	                </div>
                <!-- /.input group -->
              </div>
             
              
            </div>
            
            <!-- /.col -->
          </div>
          <!-- /.row -->
        <!-- /.Process-1  -->    
             
        <!-- Process-2 -->           
          <div class="row mkt-form-row-border">
            <div class="col-md-5">
            
	            <div class="form-group">
	                <label>Remarks By Sales Engineer:</label> 
		           <textarea  class="form-control"></textarea>
	            </div>
	   
            </div>
    
           <div class="col-md-2">
             
              <div class="form-group"> 
		           <label>Orion Sales Order No.:</label>
		           <input type="text" class="form-control" required>
               </div> 
           </div>
                   
             <div class="col-md-2">
             
              <div class="form-group"> 
		           <label>Orion Sales Order No.:</label>
		           <input type="text" class="form-control" required>
               </div> 
              
             </div>
             <div class="col-md-3">
             
               <div class="form-group">
               <div class="input-group" style="padding-top: 2.5rem;">
               <button type="submit" class="btn btn-primary"><i class="fa fa-paper-plane"></i> Update Follow-Up & Send Mail to Marketing Team</button>
               </div>
              </div>
              
             </div>          
            <!-- /.col -->
          </div>
          <!-- /.row -->
        <!-- /.Process-2 -->  
        
        
        
        <!-- Process-3 -->
        <div class="row mkt-form-row-border">
            <div class="col-md-5">
            
	            <div class="form-group">
	                <label>Remarks By Marketing Team:</label> 
		           <textarea  class="form-control"></textarea>
	            </div>
	   
            </div>
    
           <div class="col-md-2">
             
             <div class="form-group">
	                <label>Status :</label>
	                <select class="form-control select2" style="width: 100%;">
	                <option selected="selected">Sucsses</option>
	                <option>Un-Success</option>
	                 <option>Other</option>
	                </select>
              </div>
           </div>
                   
             <div class="col-md-2">
             
              <div class="form-group"> 
		           <label>Comments:</label>
		           <input type="text" class="form-control" required>
               </div> 
              
             </div>
             <div class="col-md-3">
             
               <div class="form-group">
               <div class="input-group" style="padding-top: 2.5rem;">
               <button type="submit" class="btn btn-primary"><i class="fa fa-paper-plane"></i> Close Lead & Send Mail to SE</button>
               </div>
              </div>
              
             </div>          
            <!-- /.col -->
          </div>
          <!-- /.row -->
        <!-- /.Process-3 -->
                
          <!-- row -->
          <div class="row">
          <div class="col-md-3">
          

          
          </div>
          </div>
          <!-- /.row -->
        </div>
        <!-- /.box-body -->
        <div class="box-footer">  </div>
      </div>
      <!-- /.box -->
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
<script src="resources/bower_components/datepicker/dist/js/bootstrap-datepicker.min.js"></script>
<script src="resources/bower_components/select2/dist/js/select2.full.min.js"></script>
<script src="resources/bower_components/fastclick/lib/fastclick.js"></script>
<script src="resources/dist/js/adminlte.min.js"></script>
<!-- page script start -->
<script>


	   


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