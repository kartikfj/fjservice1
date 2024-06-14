<%-- 
    Document   : MARKETING LEAD
    Created on : January 10, 2019, 10:06:00 AM
    Author     : Nufail Achath
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
	<link href="././resources/abc/style.css" rel="stylesheet" type="text/css" />
	<link href="././resources/abc/responsive.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="././resources/abc/bootstrap.min.css">
	<script src="././resources/abc/jquery.min.js"></script>
	<script src="././resources/abc/bootstrap.min.js"></script>
	<script type="text/javascript" src="././resources/js/mkt-dashboard.js?v=08062020"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
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
  <link rel="stylesheet" href="././resources/bower_components/select2/dist/css/select2.min.css">
  <link rel="stylesheet" href="././resources/dist/css/AdminLTE.min.css">
  <link rel="stylesheet" href="././resources/dist/css/skins/_all-skins.min.css">
   <link rel="stylesheet" href="././resources/css/mkt-dashbaord.css?v=080062020">
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
</style>

</head>
<body class="hold-transition skin-blue sidebar-mini">
 <c:if test="${empty fjtuser.emp_code}"> <jsp:forward page="index.jsp"/> </c:if>
 <c:choose>
 <c:when test="${!empty fjtuser.emp_code and ( fjtuser.role eq 'mkt' or fjtuser.role eq 'mg' or fjtuser.sales_code ne null ) and fjtuser.checkValidSession eq 1  and fjtuser.emp_com_code ne 'EME'}">
 
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
         <li class="active"><a href="MktDashboard"><i class="fa fa-dashboard"></i><span>MKT. Dashboard</span></a></li>
         <li ><a href="SalesLeads"><i class="fa fa-pie-chart"></i><span>Sales  Leads</span></a></li>
         <li><a href="SupportRequest"><i class="fa fa-table"></i><span> SE Support Request </span></a></li>
         <li><a href="ConsultantLeads"><i class="fa fa-line-chart"></i><span>Consultant Approval Status</span></a></li>
         <li><a href="ProjectLeads"><i class="fa fa-columns"></i><span>Project Stages 0 & 1</span></a></li>             
         <li><a href="calendar.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>      
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Marketing Dashboard
        <small>Marketing Portal</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="calendar.jsp"><i class="fa fa-calendar"></i> Home</a></li>
        <li class="active">Marketing</li>
      </ol>
    </section>
    <%--  --%>
      <c:set var="SalesCoversionRate" value="0" scope="page"/>
      <c:set var="totalOfferValue" value="0" scope="page"/>
	  <c:set var="totalCount" value="${fn:length(SLDBANLYSIS)}" scope="page" />
	  <c:set var="rowCount" value="0" scope="page" />
	  <c:set var="totCount" value="0" scope="page" />
	  <c:set var="newOppCount" value="0" scope="page" />
	  <c:set var="s2Count" value="0" scope="page" />
	   <c:forEach var="leadCountDetails"  items="${totalUnqLdCount}" >
	   	<c:if test="${leadCountDetails.leadType eq 'SL011'}"><c:set var="newOppCount" value="${newOppCount + leadCountDetails.totalLeads}" scope="page" /></c:if>
	   	<c:if test="${leadCountDetails.leadType eq 'SL013'}"><c:set var="s2Count" value="${s2Count + leadCountDetails.totalLeads}" scope="page" /></c:if>
	   	<c:if test="${leadCountDetails.leadType eq 'Total'}"><c:set var="totCount" value="${totCount + leadCountDetails.totalLeads}" scope="page" /></c:if>
	  </c:forEach>
	  <c:forEach var="genData"  items="${SLDBANLYSIS}" > 	  	  	  
      		  <c:set var="rowCount" value="${rowCount + 1}" scope="page" />      		       		  
      		  <c:if test="${totalCount eq rowCount and genData.qtdLeads > 0}">
      		  <c:set var="SalesCoversionRate" value="${SalesCoversionRate + ((genData.stage4Count / (genData.totalLeads - genData.declinedLeads )) * 100)}" scope="page"/>
      		  <c:set var="totalOfferValue" value="${totalOfferValue + genData.stage3Value + genData.stage4Value}" scope="page"/>
      		  </c:if>
      </c:forEach>
   <%--  --%>
    <!-- Main content -->
    <section class="content">
      <div class="row">
      <c:if test="${totalUnqLdCount ne null or !empty totalUnqLdCount }">
   		    <div class="col-md-3 col-xs-6">		  
   		    <div class="quick-report">	      			
				<h4 class="description-text">Projects Count</h4>
                   
               	 <div class="quick-report-infos quick-right-border">
						<p>New Opp.</p>
						<h3><fmt:formatNumber pattern="#,###.##" value="${newOppCount}" /></h3>
			    </div>
			   
               	<div class="quick-report-infos quick-right-border">
						<p>Stage-2</p>
						<h3><fmt:formatNumber pattern="#,###.##" value="${s2Count}" /></h3>
			   </div>	
			   		  
               	<div class="quick-report-infos quick-right-border-nc">
						<p>Total</p>
						<h3><fmt:formatNumber pattern="#,###.##" value="${totCount}" /></h3>
			   </div>
			   
			</div>
          </div>  
       </c:if>       
            <%--
            <div class="col-md-2 col-xs-6">
   		    <div class="quick-report">
					<div class="quick-report-infos">
						<p>Offer Value</p>
						<h3><fmt:formatNumber pattern="#,###.##" value="${totalOfferValue}" /></h3>
					</div>
				</div>
            </div>
            
            <div class="col-md-3 col-xs-6 text-center scr-box" >
                 <span class="scr-title pull-left">Sales Conversion  Rate</span>
                 <input type="text" class="knob" data-readonly="true" value="<fmt:formatNumber pattern="#,##" value="${SalesCoversionRate}" />" 
                 data-width="50" data-height="50"
                  data-fgColor="#39CCCC" 
                  data-skin="tron"
				  data-thickness=".4" data-bgColor="#fff"
                  >
            </div>
         --%>
           <c:if test="${SFO eq 1}">
          <form method="POST">
          <div class="col-md-2 col-xs-6">
         
   		     <div class="form-group">
			              <select class="form-control select2 mk-db-select" style="width: 100%;" name="divn" required>
			                <option value="" >Select Division</option>
		                    <c:forEach var="dvnLst"  items="${DLFCL}" >
		                    <option value="${dvnLst.divn_code}" ${dvnLst.divn_code  == selectedDiv ? 'selected':''}> ${dvnLst.divn_code}</option>		                    
		                    </c:forEach>
			              </select>
			  </div>
			  <div class="form-group">
			      <select class="form-control select2 mk-db-select" style="width: 100%;" name="year" required>
  						<option  value="">Select Year</option>						
   						 <%
                        // start year and end year in combo box to change year in calendar
                         for(int iy=2020;iy<=iYear;iy++)
                            {                                               	 
                             %>
                             <c:set var="syrtemp" value="<%=iy%>" scope="page" />
                             <option value="<%=iy%>" ${syrtemp == selectedYear ? 'selected':''}><%=iy%></option>
                            <%                            
                        }
                        %>
		       </select>
			  </div>	
            </div>
            <div class="col-md-2 col-xs-6" style="padding-top: 20px;">
            <input type="hidden" value="vSDiv" name="fjtco" />
            <button type="submit" name="refresh" id="refresh" class="btn btn-primary refresh-btn" onclick="preLoader();" ><i class="fa fa-refresh"></i> Refresh</button>
            </div>
             </form>
             </c:if>
	 </div>
		
	 
     <div class="row">
     <div class="col-md-12">
      		<table class="table table-striped table-bordered marketing-dtls-table small responsive" id="mkt-dashboard-table">
      		<thead>
      			<tr>
      			<c:choose>
	      			<c:when test="${DBT eq 1}">    			
	      			<th>Division</th>
	      			</c:when>
	      			<c:when test="${DBT eq 2}">      			
	      			<th>Sales Eng. </th>
	      			</c:when>
	      			<c:when test="${DBT eq 3}">
	      			<th>Sales Eng.</th>
	      			</c:when>
      			</c:choose>
      			<th>Lead Type (New Opp. & Stage2)</th>
      			<th>Total <br/> Leads</th>
      			<th>No: of Leads <br/> Pending for Ack.</th>
      			<th>No: of Leads <br/> Qtd.</th>
      			<th>No: of Leads <br/> Declined</th>
      			<th>No: of Leads Lost <br/> at Offer Value</th>
      			<th>No: of leads  <br/> in Stage-3</th>
      			<th>Total Stage-3 Value  <br/> (AED)</th>
      			<th>No: of Leads Lost  at <br/> stage-3</th>
      			<th>No: of leads  <br/>in Stage-4</th>
      			<th>Total Stage-4 Value  <br/> (AED)</th>
      			<th width="70">Stage4 <br/> Confirmation  <br/> Pending By Mkt. Team</th>
      			<th width="60">Sales Conversion  <br/> Rate (%)</th>
      			</tr>
      		</thead>
      		<tbody>
      		  <c:set var="rowCountNew" value="0" scope="page" />
      		  <c:set var="rowclassname" value="" scope="page" />
      		 <c:forEach var="data"  items="${SLDBANLYSIS}" > 
      		  <c:set var="rowCountNew" value="${rowCountNew + 1}" scope="page" />
      		  <c:choose>
      		  <c:when test="${data.leadType eq null or empty data.leadType and data.leadType ne 'Total' and DBT eq 1}">
      		   <c:if test="${totalCount eq rowCountNew}">
      		   <c:set var="rowclassname" value="mkd-final-row" scope="page" />
      		   </c:if>
      			<tr class="${rowclassname}">
      			<td style="width:max-content !important;">        					
	      				${data.division} 
		      			<c:if test="${totalCount ne rowCountNew}">
		      				<a href="#" class="toggler" data-lead-cat="${data.division}"  ><i class="fa fa-plus" ></i></a>
		      			</c:if>      		 			
      			</td>
      			<td>${data.leadType}Stage2 & New Opp.</td>
      			<td>${data.totalLeads}</td>
      			<td>${data.ackPendingLeads}</td>
      			<td>${data.qtdLeads}</td>
      			<td>${data.declinedLeads}</td>
      			<td>${data.lostLeadsAtOV}</td>
      			<td>${data.stage3Count}</td>
      			<td>${data.stage3Value}</td>
      			<td>${data.lostLeadsAtS3}</td>
      			<td>${data.stage4Count}</td>
      			<td>${data.stage4Value}</td>
      			<td>${data.stage4NotConfrmd}</td>
      			<td>
      			     <c:choose>
      			     <c:when test="${data.totalLeads eq data.declinedLeads}">
      			       0
      			     </c:when>
      			     <c:otherwise>
      			     <fmt:formatNumber pattern="#,###.##" value="${(data.stage4Count /(data.totalLeads - data.declinedLeads )) * 100}" />
      			     </c:otherwise>
      			     </c:choose>
      			      </td>      			
      			</tr>
      		</c:when>
      		 <c:when test="${data.leadType eq 'Total' and ( DBT eq 2 or DBT eq 3)}">
      		 
      		  <c:if test="${totalCount eq rowCountNew and DBT eq 2 }">
      		   <c:set var="rowclassname" value="mkd-final-row" scope="page" />
      		   </c:if>
      			<tr class="${rowclassname}">
      			
      			<td style="width:max-content !important;">     		     			      				
	      				<c:if test="${totalCount eq  rowCountNew}">
		      			${data.seEmpCode} 
		      			</c:if>
		      			<c:if test="${totalCount ne rowCountNew}">
		      			${data.seEmpName} 
		      				<a href="#" class="toggler" data-lead-cat="${data.seEmpCode}"  ><i class="fa fa-plus" ></i></a>
		      			</c:if>	      			  			
      			</td>
      			<td>Stage2 & New Opp.</td>
      			<td>${data.totalLeads}</td>
      			<td>${data.ackPendingLeads}</td>
      			<td>${data.qtdLeads}</td>
      			<td>${data.declinedLeads}</td>
      			<td>${data.lostLeadsAtOV}</td>
      			<td>${data.stage3Count}</td>
      			<td>${data.stage3Value}</td>
      			<td>${data.lostLeadsAtS3}</td>
      			<td>${data.stage4Count}</td>
      			<td>${data.stage4Value}</td>
      			<td>${data.stage4NotConfrmd}</td>
      			<td>
      			     <c:choose>
      			     <c:when test="${data.totalLeads eq data.declinedLeads}">
      			       0
      			     </c:when>
      			     <c:otherwise>
      			     <fmt:formatNumber pattern="#,###.##" value="${(data.stage4Count / (data.totalLeads - data.declinedLeads )) * 100}" />
      			     </c:otherwise>
      			     </c:choose>
      			</td>
      			
      			</tr>
      		</c:when>
      		<c:otherwise>
      		<c:set var="classValue" value="" />
      		<c:set var="defcolValue" value="" />
      		<c:choose>
	      			<c:when test="${DBT eq 1}">    			
	      			   <c:set var="classValue" value="${data.division}" />
      				   <c:set var="defcolValue" value="${data.division}" />
	      			</c:when>
	      			<c:when test="${DBT eq 2}">      			
	      			   <c:set var="classValue" value="${data.seEmpCode}" />
      				   <c:set var="defcolValue" value="${data.seEmpName}" />
	      			</c:when>
	      			<c:when test="${DBT eq 3}">
	      			   <c:set var="classValue" value="${data.seEmpCode}" />
      				   <c:set var="defcolValue" value="${data.seEmpName}" />
	      			</c:when>
      			</c:choose>    
      		<tr class="hide-lead-type lead-data${classValue}">   
                <td>${defcolValue}</td>  			  			
      			<td>${data.leadType}</td>
      			<td>${data.totalLeads}</td>
      			<td>${data.ackPendingLeads}</td>
      			<td>${data.qtdLeads}</td>
      			<td>${data.declinedLeads}</td>
      			<td>${data.lostLeadsAtOV}</td>
      			<td>${data.stage3Count}</td>
      			<td>${data.stage3Value}</td>
      			<td>${data.lostLeadsAtS3}</td>
      			<td>${data.stage4Count}</td>
      			<td>${data.stage4Value}</td>
      			<td>${data.stage4NotConfrmd}</td>
      			<td>
      			 	<c:choose>
      			     <c:when test="${data.qtdLeads eq 0}">
      			       0
      			     </c:when>
      			     <c:otherwise>
      			     <fmt:formatNumber pattern="#,###.##" value="${(data.stage4Count / data.qtdLeads) * 100}" />
      			     </c:otherwise>
      			     </c:choose>
      			</td>     			
      			</tr>
      		</c:otherwise>
      		</c:choose>
      		</c:forEach>
      		</tbody>
      		</table>
     </div>
     </div>
    </section>
    <div id="laoding" class="loader" ><img src="resources/images/wait.gif"></div>
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

<!-- page Script  end -->

</c:when>
<c:otherwise>

        <body onload="window.top.location.href='logout.jsp'">
   
            
        </body>
  
</c:otherwise>
</c:choose>
</html>