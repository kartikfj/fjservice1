<%-- 
    Document   : PUMP SERVICE PORTAL , FIELD STAFF HOME PAGE 
--%>
<%@include file="/service/header.jsp" %>
<jsp:useBean id="now" class="java.util.Date" scope="request"/>
<fmt:parseNumber value="${now.time / (1000*60*60*24) }"  integerOnly="true" var="toDay" scope="request"/>
<c:set  value="0" var="dateDiff" scope="page" />	 
<style>
@media only screen and (max-width: 800px) {
}
 
@media only screen and (max-width: 640px) {
	  table td:nth-child(1),table th:nth-child(1), table td:nth-child(3),table th:nth-child(3), table td:nth-child(6),table th:nth-child(6){display: none;}
	  .table-responsive>.table>tbody>tr>td{white-space: normal !important;}
	 table tr>th, table tr>td{font-size:10px !important;}
	 #btn-nw-rqst{margin-left: 15px !important;}
	 .entry-btn-div {margin-top: -30px !important;}
	 div.dt-buttons,.dataTables_wrapper .dataTables_info {  float: left !important;}
	 .box-header .box-title, .content-header>h1{font-size: 14px !important;}
}
</style>
<body class="hold-transition skin-blue sidebar-mini sidebar-collapse sidebar-mini">
 <c:if test="${empty fjtuser.emp_code}"> <jsp:forward page="index.jsp"/> </c:if>
 <c:choose>
 <c:when test="${!empty fjtuser.emp_code and   fjtuser.checkValidSession eq 1 }">
 <c:set var="controller" value="ServiceController" scope="page" />
<div class="wrapper">

  <header class="main-header">
    <!-- Logo -->
    <a href="homepage.jsp" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>FJ</b>S</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg">
         <i class="fa fa-edit"></i> <b>FJ-Services</b>
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
    <!-- sidebar-->
    <section class="sidebar">
      <!-- Sidebar user panel --> 
      <!-- sidebar menu -->
      <ul class="sidebar-menu" data-widget="tree">
         <li class="active"><a href="${controller}"><i class="fa fa-dashboard"></i><span>Service Requests</span></a></li>            
         <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>      
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>Service Requests <small>Service Portal</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="homepage.jsp"><i class="fa fa-calendar"></i> Home</a></li>
        <li class="active">Service Portal</li>
      </ol>
    </section>
    
    <!-- Main content -->
	    
	    <%--Field Staff Home Section Start--%>
	    <section class="content">
	    <c:set var="rqstscount" value="0" scope="page" />
	    <c:set var="statusText" value="" scope="page" />  
	    
        <c:choose>
        <c:when test="${filters.status eq 0}"><c:set var="statusText" value="Pending" scope="page" /> </c:when>
        <c:when test="${filters.status eq 1}"><c:set var="statusText" value="Closed" scope="page" /> </c:when>
        <c:when test="${filters.status eq 2}"><c:set var="statusText" value="All" scope="page" /> </c:when>
        <c:otherwise></c:otherwise>
        </c:choose>         
	    
	     <div class="row entry-btn-div">
	       <div class="col-md-10 col-xs-12"> 
           <form method="POST" >       
   		     <div class="form-group form-inline">
   		     <div class="col-md-12 col-xs-12">
   		      <input  class="form-control form-control-sm filetrs"   placeholder="Select Start Date"  type="text" id="fromdate" name="fromdate" value="${filters.startDate}" autocomplete="off"   required/>			
			  <input  class="form-control form-control-sm filetrs"    type="text" id="todate" placeholder="Select To Date"  name="todate"  value="${filters.toDate}"  autocomplete="off" required/>	 
			   <select class="form-control form-control-sm  select2 filetrs"  name="status" required>
  						<option  value="0" ${filters.status eq 0 ? 'selected="selected"' : ''}>Pending</option>
  						<option  value="1" ${filters.status eq 1 ? 'selected="selected"' : ''}>Closed</option>
  						<option  value="2" ${filters.status eq 2 ? 'selected="selected"' : ''}>All</option>
  			   </select>	
            <input type="hidden" value="custVw" name="action" />
            	<input type="hidden" value="${USRTYP}" name="usrTyp" />
            <button type="submit" name="refresh" id="refresh" class="btn btn-primary refresh-btn filetrs" onclick="preLoader();" ><i class="fa fa-refresh"></i> Refresh</button>
            </div>
            </div>
            </form>
          </div> 
	     </div> 
	    
	     
	     
	    <%-- TABLUAR DETAILS START --%>
	   <div class="row small">
        <div class="col-xs-12">
          <div class="box box-primary">
            <div class="box-header">
              <h3 class="box-title"><b>Service Requests</b>-<span>${statusText}</span></h3>
              </div> 
            <!-- /.box-header --> 
            <div class="box-body table-responsive  padding" style="/*display:flex;*/">
              <table class="table table-bordered small bordered"  id="displayRqsts">
                <thead>
                <tr>
                  <th>SL. No.</th> 
                  <th>SO-Code</th>
                  <th>Project Name</th>
                  <th>Service Type</th> 
                  <th>Created On</th> 
                  <th>Location</th>  
                  <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="request" items="${SRVSRQSTS}" >
                <c:set var="rqstscount" value="${rqstscount + 1}" scope="page" />
                <tr>
                  <td>${rqstscount}</td>
                  <td>${request.soCodeNo}</td>
                  <td>${request.projectName}</td>                   
                  <td>${request.visitType}</td>  
                  <td> 
                  <fmt:parseDate value="${request.createdDate}" var="theCrtdDate"  dateStyle="short"   pattern="yyyy-MM-dd HH:mm" />
		           <c:choose>
		           <c:when test="${request.fldStatus eq 0}">
		            
		           	<fmt:parseNumber value="${ theCrtdDate.time / (1000*60*60*24) }" integerOnly="true" var="CreatedDay" scope="page"/>
		           	<c:set  value="${toDay - CreatedDay}" var="dateDiff" scope="page" />			           	
		           	 	<b style="color:red;"> Due by ${dateDiff}  Days.</b>
		           	    <br/> 
		           	    <span class="small">(<fmt:formatDate value="${theCrtdDate}" pattern="dd/MM/yyyy HH:mm"/>)</span>        	 		           	 	           
		           </c:when>
		           <c:otherwise>
		            <b style="color:blue;"><fmt:formatDate value="${theCrtdDate}" pattern="dd/MM/yyyy HH:mm"/></b>
		           </c:otherwise>
		           </c:choose>               
                  </td>
                  <td>${request.location}</td>  
                   <c:if test="${USRTYP eq 'FU'}">
                  <td>
                  <form action="${controller}" method="POST" style="display: inline !important;">
                     <input type="hidden" value="${USRTYP}" name="userType" />
				   	 <input type="hidden" value="${request.id}" name="fldid" />
				     <input type="hidden" name="action" value="fldVw" />
				     <c:choose>
				     <c:when test="${request.fldStatus eq 0}">
					     <button type="submit"   class="btn btn-danger btn-xs"   onClick="preLoader()">
						 <i class="fa fa-arrow-right"></i> 
						 </button>
				     </c:when>
				     <c:otherwise>
					     <button type="submit"   class="btn btn-primary btn-xs"   onClick="preLoader()">
						 <i class="fa fa-eye"></i> 
						 </button>
				     </c:otherwise>
				     </c:choose>
				     
				 </form>              
                  </c:if>
                </tr>
               </c:forEach>      
              </tbody></table>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
      </div>
	  <%-- TABULAR DETAILS END --%> 
	    </section>
	    <%--Field Staff Home Section End --%>	        
    <div id="laoding" class="loader" ><img src="././resources/images/wait.gif"></div> 
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
<script src="././resources/bower_components/jquery-knob/js/jquery.knob.js"></script>
<!-- page script start -->
<script>
var _usrTyp = '${USRTYP}'; 
var title = 'Service Request List From ';
var defStartDate = '${filters.startDate}';
var defEndtDate = '${filters.toDate}';
$(function(){ 
	 $('.loader').hide();	
	 $("#fromdate").datepicker({ "dateFormat" : "dd/mm/yy", yearRange: "2020:2030", maxDate : 0});
	 $("#todate").datepicker({"dateFormat" : "dd/mm/yy",maxDate : 0 });
	 $('#displayRqsts').DataTable({     "paging":   true,  "ordering": false, "info":true, "searching": true,  "pageLength": 10, } );  
});
function preLoader(){ $('#loading').show();}
</script>
<!-- page Script  end -->

</c:when>
<c:otherwise>

        <body onload="window.top.location.href='logout.jsp'">
   
            
        </body>
  
</c:otherwise>
</c:choose>
</html>