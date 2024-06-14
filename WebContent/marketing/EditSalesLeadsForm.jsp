<%-- 
    Document   : EDIT LEAD(Form1) and Sales Engineer Support Request (Form2)
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
	<script type="text/javascript" src="././resources/js/mkt-salesleads.js?v=17052020"></script>
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
   <%--Theme style  --%>
    <link rel="stylesheet" href="././resources/bower_components/select2/dist/css/select2.min.css">
    <link rel="stylesheet" href="././resources/dist/css/AdminLTE.min.css">
    <link rel="stylesheet" href="././resources/dist/css/skins/_all-skins.min.css">
    <link rel="stylesheet" href="././resources/css/mkt-layout.css?v=17052020">
<script type="text/javascript">
    $(document).ready(function () {
    	$("#offerParseVal").val(parseFloat($(".floatNumberField").val()).toFixed(2));
        $(".floatNumberField").change(function() {
            $(this).val(parseFloat($(this).val()).toFixed(2));
        });
    });
</script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
 <c:if test="${empty fjtuser.emp_code}"> <jsp:forward page="index.jsp"/> </c:if>
 <c:choose>
 <c:when test="${!empty fjtuser.emp_code and  ( fjtuser.role eq 'mkt' or fjtuser.role eq 'mg' or fjtuser.sales_code ne null )  and fjtuser.checkValidSession eq 1}">
 <sql:query var="service" dataSource="jdbc/orclfjtcolocal">
		SELECT USER_TYPE, DIVN_CODE FROM FJPORTAL.MARKETING_SALES_USERS WHERE  EMPID = ?  AND ROWNUM = 1
	<sql:param value="${fjtuser.emp_code}"/>
</sql:query>
   <c:set var="leadCode" value="0" scope="page" />
    <c:set var="seempCode" value="" scope="page" />
    <c:set var="leadTyp" value="0" scope="page" />
    <c:set var="leadUnifCode" value="0" scope="page" />
    <c:set var="sono" value="" scope="page" />
    <c:set var="pcode" value="" scope="page" />
    <c:set var="offerValue" value="0" scope="page" />
    <c:set var="seRemarks" value="" scope="page" />
    <c:set var="loi" value="" scope="page" />
     <c:set var="lpo" value="" scope="page" />
<div class="wrapper">

  <header class="main-header">
     <%--Logo  --%>
    <a href="././calendar.jsp" class="logo">
       <%--mini logo for sidebar mini 50x50 pixels  --%>
      <span class="logo-mini"><b>FJ</b>M</span>
       <%--logo for regular state and mobile devices  --%>
      <span class="logo-lg">
          <img src="././resources/images/logo_t5.jpg" height="49px" class="img-circle pull-left"  alt="Logo"><b>Marketing</b>
      </span>
    </a>
     <%--Header Navbar: style can be found in header.less  --%>
    <nav class="navbar navbar-static-top">
       <%--Sidebar toggle button --%>
      <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>

      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
  
           <%--User Account: style can be found in dropdown.less  --%>
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
   <%--Left side column. contains the logo and sidebar  --%>
  <aside class="main-sidebar">
     <%--sidebar: style can be found in sidebar.less  --%>
    <section class="sidebar">
       <%--Sidebar user panel  --%>
       <%--search form  --%>
      <form action="#" method="get" id="processOne" class="sidebar-form">
        <div class="input-group">
          <input type="text" name="q" class="form-control" placeholder="Search...">
          <span class="input-group-btn">
                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                </button>
              </span>
        </div>
      </form>
       <%--/.search form  --%>
       <%--sidebar menu: : style can be found in sidebar.less  --%>
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
     <%--/.sidebar  --%>
  </aside>

   <%--Content Wrapper. Contains page content  --%>
  <div class="content-wrapper">
     <%--Content Header (Page header)  --%>
    <section class="content-header">
      <h1> Sales  Leads  Form <small>Marketing Portal</small> </h1>
      <ol class="breadcrumb">
        <li><a href="homepage.jsp"><i class="fa fa-calendar"></i> Home</a></li>
        <li class="active">Marketing</li>
      </ol>
    </section>
     <%--Main content  --%>
    <section class="content">

    <div class="row">
    <div class="col-md-12">
	   <%--SELECT2 EXAMPLE  --%>
      <div class="box box-default">
        <div class="box-header with-border">
          <h3 class="box-title"> </h3>

          <div class="box-tools pull-right">
            <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i></button>
          </div>
        </div>
         <%--/.box-header  --%>
        <div class="box-body">
         <%-- Process - 1 
         <span>${P1}-${P2}-${P3}-${P4}-${fjtuser.role}</span> --%>
         
         
        <c:choose>
      
             
         <%--Process-2  --%>   
       <c:when test="${P1 eq 1 and P2 eq 0 and P3 eq 0 and P4 eq 0 and fjtuser.role ne 'mkt'}">     
          <div class="row mkt-form-row-border">
                <div class="col-xs-12  table-responsive no-padding"">
				  <table class="table table-hover" id="sep2viewtable">
				    <tbody>
				    <c:forEach var="leadList"  items="${LEADLIST}" >
				        <c:set var="leadCode" value="${leadList.id}" scope="page" />
				        <c:set var="seempCode" value="${leadList.seEmpCode}" scope="page" />
				        <c:set var="leadTyp" value="${leadList.type}" scope="page" />
				        <c:set var="leadUnifCode" value="${leadList.leadUnfctnCode}" scope="page" />
				        <c:set var="sEGDetails" value="${leadList.seName}" scope="page" />
				    <tr>
				        <td>
				        <dl class="dl-horizontal">
				       <dt>Lead Code : </dt>
		                <dd>FJMKT-${leadList.leadUnfctnCode}</dd>
		                <dt>Lead Type : </dt>
		                <dd>${leadList.type}</dd>
		                <dt>Division : </dt>
		                 <dd>${leadList.division}</dd>
		                 <dt>Product : </dt>
		                 <dd>${leadList.prdct}</dd>	
		                 <dt>SE Name : </dt>
		                 <dd>${leadList.seName}</dd> 
		                  <dt>Project Details : </dt>
		                  <c:if test="${leadList.typeCode eq 'SL013'}">               
                  		<dt>Already Qtd. Divisions</dt>
                  		<dd>${leadList.stage2QtdDivisions}</dd>
              			</c:if>
		                <dd>${leadList.projectDetails}</dd>	                             
		                 <dt>Contractor : </dt>
		                 <dd>${leadList.contractor}</dd>
		                 <dt>Consultant : </dt>
		                <dd>${leadList.consultant}</dd>
		                 <dt>Lead Remark : </dt>
		                <dd>${leadList.leadRemarks}</dd>  	                
		                <dt>Lead Initiated On : </dt>
		                 <dd><fmt:parseDate value="${leadList.createdOn}" var="theDate1"    pattern="yyyy-MM-dd HH:mm" />
		                  <fmt:formatDate value="${theDate1}" />
		                  </dd>
				       </dl>
				       </td>
				        
				    </tr>
				     
				    </c:forEach>
				    </tbody>
				  </table>
				</div>
		
             <%-- Sales engineer follow up  --%>
		     <form action="SalesLeads" method="POST"  id="processTwo" name="se_followup_form">
		     <input type="hidden" value="" name="p2ackDesc" id="p2ackDesc" required/>
		     <h4>Sales Engineer Acknowledgment Form</h4>
   
                   
		
            <div class="col-md-3">
              <div class="form-group">
	                <label>Remarks : For Sales Engineer Acknowledgment</label> 
		           <textarea  class="form-control" name="ackRemarks" required></textarea>
	            </div>
            </div>
           
            <div class="col-md-3">
            <div class="form-group">
			        <label>Acknowledgment:</label>
			         <!--
			        <select class="form-control select2" style="width: 100%;" name="p2Update" required>
			        <option value="" >Select</option>
			       <option value="1" >Received & will quote</option>
			       <option value="2" >Received but declined</option>
			       
		           </select>
		           -->
		             <select class="form-control select2" style="width: 100%;" name="p2Update" id="p2Update" required onChange="getAckText()">
			              <option value="">Select Acknowledgment Type</option>
			              <c:forEach var="ackList"  items="${ACKLIST}" >
		                  <option value="${ackList.ackStatus}" >${ackList.ackDesc}</option>
		                   </c:forEach>
			         </select>
			 </div>	
            </div>
             <div class="col-md-2">
             
               <div class="form-group">
               <div class="input-group" style="padding-top: 2.5rem;" >
                     <input type="hidden" value="${leadCode}" name="lddi" />
				   	 <input type="hidden" name="p1" value="${P1}" />
				   	 <input type="hidden" name="p2" value="${P2}" />
				   	 <input type="hidden" name="p3" value="${P3}" />
				   	 <input type="hidden" name="p4" value="${P4}" />
				   	 <input type="hidden" name="edocpmees" value="${seempCode}" />
				   	 <input type="hidden" name="ldTyp" value="${leadTyp}" />
				   	 <input type="hidden" name="ldCode" value="${leadUnifCode}" />
				   	 <input type="hidden" name="seg" value="${sEGDetails}" />
				     <input type="hidden" name="action" value="update" />
                     <button type="submit" class="btn btn-primary" >Submit</button>
               </div>
              </div>
              
             </div>  
          </form>           
         <%--/.Sales engineer follow up  --%>
          </div>
        </c:when> 
           <%--/.row  --%>
         <%--/.Process-2  --%>  
        
        <%--Process-3  --%>   
       <c:when test="${P1 eq 1 and P2 eq 1 and (P3 eq 0 or P3 eq 3)  and P4 eq 0 and fjtuser.role ne 'mkt'  }">     
      
          <div class="row mkt-form-row-border">
                <div class="col-xs-12  table-responsive no-padding">
				  <table class="table table-hover" id="sep2viewtable">
				    <tbody>
				     
				      <c:set var="loiChedStatus" value="" scope="page" />
				      <c:set var="loiDisabldStatus" value="" scope="page" />
				      <c:set var="lpoDisabldStatus" value="" scope="page" />
				       <c:set var="soNoDisabldStatus" value="" scope="page" />
				      <c:set var="prjctCodeDisabldStatus" value="" scope="page" />
				     <c:forEach var="seFPDetails"  items="${SEFPDTLS}" >
				      <c:set var="lastProccesdStage" value="${seFPDetails.lastPrccsdStage}" scope="page" /> 
				      <c:set var="processId" value="${seFPDetails.process_id}" scope="page" /> 
				     </c:forEach>
				    <c:forEach var="leadList"  items="${LEADLIST}" >
				        <c:set var="leadCode" value="${leadList.id}" scope="page" />
				        <c:set var="seempCode" value="${leadList.seEmpCode}" scope="page" />
				        <c:set var="leadTyp" value="${leadList.type}" scope="page" />
				        <c:set var="leadUnifCode" value="${leadList.leadUnfctnCode}" scope="page" />
				        <c:set var="sono" value="${leadList.soNumber}" scope="page" />
				        <c:set var="pcode" value="${leadList.prjctCode}" scope="page" />
				        <c:set var="offerValue" value="${leadList.offerValue}" scope="page" />
    				    <c:set var="seRemarks" value="${leadList.seRemarks}" scope="page" />
    					<c:set var="loi" value="${leadList.loi}" scope="page" />
    					<c:set var="lpo" value="${leadList.lpo}" scope="page" />
    					<c:set var="sEGDetails" value="${leadList.seName}" scope="page" /> 
    					<c:set var="leadTypeCode" value="${leadList.typeCode}" scope="page" /> 
				    <tr>
				        <td>
				        <dl class="dl-horizontal">
				       <dt>Lead Code : </dt>
		                <dd>FJMKT${leadList.leadUnfctnCode}</dd>
		                <dt>Lead Type : </dt>
		                <dd>${leadList.type}</dd>
		                <dt>Division : </dt>
		                 <dd>${leadList.division}</dd>
		                 <dt>Product : </dt>
		                 <dd>${leadList.prdct}</dd>	
		                 <dt>SE Name : </dt>
		                 <dd>${leadList.seName}</dd> 
		                  <dt>Project Details : </dt>
		                <dd>${leadList.projectDetails}</dd>  
		                <c:if test="${leadList.typeCode eq 'SL013'}">               
                  		<dt>Already Qtd. Divisions</dt>
                  		<dd>${leadList.stage2QtdDivisions}</dd>
              			</c:if>              
		                 <dt>Contractor : </dt>
		                 <dd>${leadList.contractor}</dd>
		                 <dt>Consultant : </dt>
		                <dd>${leadList.consultant}</dd>		
		                 <dt>Lead Remark : </dt>
		                <dd>${leadList.leadRemarks}</dd>                        
		                <dt>Initiated On : </dt>
		                 <dd><fmt:parseDate value="${leadList.createdOn}" var="theDate1"    pattern="yyyy-MM-dd HH:mm" />
		                  <fmt:formatDate value="${theDate1}" />
		                 </dd>
				       </dl>
				       </td>
				        <td>
				        <dl class="dl-horizontal">
				          <dt>SE Ack. Status : </dt>
		                <dd>
		               <c:choose>
					        <c:when test="${leadList.p2Status eq 1}"><b style="color:green;">${leadList.ackDesc}</b></c:when>
					        <c:when test="${leadList.p2Status eq 2}"><b style="color:red;">${leadList.ackDesc}</b></c:when>
					         <c:when test="${leadList.p2Status eq 0}"><b style="color:blue;">Pending</b></c:when>
					        <c:otherwise><b style="color:blue;">-</b></c:otherwise>
					    </c:choose>
		                </dd>
				         <dt>SE Ack. Remarks : </dt>
		                <dd>${leadList.ackRemarks}</dd>
		                <dt>SE Ack. On : </dt>
		                 <dd><fmt:parseDate value="${leadList.acknowledgeOn}" var="theDate2"    pattern="yyyy-MM-dd HH:mm" />
		                  <fmt:formatDate value="${theDate2}" />
		                  </dd>
		                  <dt>SE Follow-Up Status: </dt>
		                <dd> <c:choose>
		        <c:when test="${leadList.p3Status eq 1}"><b style="color:green;">${leadList.followUpAckDesc}</b></c:when>
		        <c:when test="${leadList.p3Status eq 2}"><b style="color:red;">${leadList.followUpAckDesc}</b></c:when>
		         <c:when test="${leadList.p3Status eq 0 and leadList.p2Status eq 1}"><b style="color:blue;">Pending</b></c:when>
		         <c:when test="${leadList.p3Status eq 3}"><b style="color:green;">${leadList.followUpAckDesc}</b></c:when>
		        <c:otherwise><b style="color:blue;">-</b></c:otherwise>
		        </c:choose>
		        </dd>
		         <dt>SE Follow-Up Remarks : </dt>
		         <dd>${leadList.seRemarks}</dd>
		          <dt>Project Code : </dt>
		          <dd>${leadList.prjctCode}</dd>
		          <dt>Offer Value : </dt>
		          <dd><fmt:formatNumber pattern="#,###.##" value="${leadList.offerValue}" /></dd>
		           <dt>LOI Received?  : </dt>
		           <dd>
		           <c:choose>
                   <c:when test="${leadList.loi eq 1}">YES</c:when>
                   <c:otherwise>NO</c:otherwise>
                   </c:choose> 
                   </dd>
		           <dt>LPO Received?  : </dt>
		           <dd> 
		           <c:choose>
                   <c:when test="${leadList.lpo eq 1}">YES</c:when>
                   <c:otherwise>NO</c:otherwise>
                   </c:choose> 
                   </dd>
		           <dt>Sales Order No. : </dt>
		           <dd>${leadList.soNumber}</dd>      
		           <dt>SE Updated On : </dt>
		           <dd><fmt:parseDate value="${leadList.followupOn}" var="theDate3"    pattern="yyyy-MM-dd HH:mm" />
		           <fmt:formatDate value="${theDate3}" /></dd>
				   </dl>
				   </td>
				    </tr>
				     
				    </c:forEach>
				    </tbody>
				  </table>
				</div>
		     <c:choose>
		      <c:when test="${lastProccesdStage eq 0 }">	
				      <c:if test="${leadTypeCode eq 'SL013' }">
				      <c:set var="prjctCodeDisabldStatus" value="readonly" scope="page" />
				      </c:if>        
				    <c:set var="soNoDisabldStatus" value="readonly" scope="page" />
				    <c:set var="loiDisabldStatus" value="pointer-events: none;" scope="page" />
				    <c:set var="lpoDisabldStatus" value="pointer-events: none;" scope="page" />
		       </c:when>
		        <c:when test="${lastProccesdStage eq 1 }">	        
				    <c:set var="prjctCodeDisabldStatus" value="readonly" scope="page" />
				    <c:set var="soNoDisabldStatus" value="readonly" scope="page" />
				    <c:set var="lpoDisabldStatus" value="pointer-events: none;" scope="page" />
		       </c:when>  
		       <c:when test="${lastProccesdStage eq 2 }">
		       		<c:set var="loiChedStatus" value="checked" scope="page" />
				    <c:set var="loiDisabldStatus" value="pointer-events: none;" scope="page" />
				    <c:set var="prjctCodeDisabldStatus" value="readonly" scope="page" />
		       </c:when>   
		     </c:choose>
		     
             <%-- Sales engineer follow up  --%>
		     <form action="SalesLeads" method="POST"  id="processThree" name="processThree">
		     <input type="hidden" value="" name="p3FupAckDesc" id="p3FupAckDesc" required/>
		     <input type="hidden" value="0" name="p3FupMailYn" id="p3FupMailYn" required/>
		     <input type="hidden" value="${lastProccesdStage}" name="lastProccssedFp" id="lastProccssedFp" required/>
		     <input type="hidden" value="${processId}" name="processId" id="processId" required/>
		     
		     <h4>Sales Engineer Follow-Up Form</h4>
           
            <div class="col-md-3">
            <div class="form-group">
			        <label>Lead Working Status:</label>
			        <!--  
			        <select class="form-control select2" style="width: 100%;" name="p3Update" required>
			       <option value="" >Select Status </option>
			       <option value="1" >Completed</option>
			       <option value="2" >Still Working</option>			       
		           </select>
		           -->
		          
		           <select class="form-control select2" style="width: 100%;" name="p3Update" id="p3Update" required onChange="getFollowUpAckText()">
			              <option value="">Select Lead Working Status</option>
			              <c:forEach var="ackList"  items="${ACKLIST}" >
			              <c:choose>
			              <c:when test="${lastProccesdStage eq 0 }">
			              <c:if test="${ackList.seFpStage eq 1 }">			             
			              <option value="${ackList.ackStatus}" class="${ackList.sendMailYN}" >${ackList.ackDesc}</option>
			              </c:if>
			              </c:when>
			              <c:when test="${lastProccesdStage eq 1 }">
			               <c:if test="${ackList.seFpStage eq 2 }">			             
			              <option value="${ackList.ackStatus}" class="${ackList.sendMailYN}" >${ackList.ackDesc}</option>
			              </c:if>
			              </c:when>
			              <c:when test="${lastProccesdStage eq 2 }">
			               <c:if test="${ackList.seFpStage eq 3 }">			             
			              <option value="${ackList.ackStatus}" class="${ackList.sendMailYN}" >${ackList.ackDesc}</option>
			              </c:if>
			              </c:when>
			              </c:choose>
		                  
		                   </c:forEach>
			         </select>
			 </div>	
			 <div class="form-group"> 
		           <label>Orion Sales Order No. </label>
		           <input type="text" class="form-control" name="soNum" value="${sono}" ${soNoDisabldStatus} />
               </div>
            </div>
            
            <div class="col-md-2">
               <div class="form-group"> 
		           <label>Orion Project Code</label>
		           <input type="text" class="form-control" name="prjctCode" value="${pcode}"  ${prjctCodeDisabldStatus} />
               </div> 
             
              
           </div>
                   
             <div class="col-md-2">
             
            <div class="form-group">
			      <label>Offer Value (AED) :</label>
			      <input type="number" class="form-control floatNumberField" id="offerParseVal" step=".01"  min="0" name="offerval" value="${offerValue}">
			  </div>
              
             </div>
             
             <div class="col-md-2">
			  <div class="form-group"> 
			        <label>LOI Received? </label>
		            <label class="switch" style="${loiDisabldStatus}"><input type="checkbox" id="loiChck" name="loi" value="${loi}" onClick="loiCkChange(this)" ${loiChedStatus} ><div class="slider round"></div></label>
               </div> 	          	   
            </div>
            
            <div class="col-md-2">
           
			  <div class="form-group"> 
		           <label>LPO Received? </label>
		          <label class="switch" style="${lpoDisabldStatus}"><input type="checkbox" id="" name="lpo" value="${lpo}" onClick="lpoCkChange(this)" ><div class="slider round"></div></label>
               </div> 	          	   
            </div>           
		
            <div class="col-md-5">
              <div class="form-group">
	                <label>Comment/Remarks</label> 
		           <textarea  class="form-control" name="seremarks"  required>${seRemarks}</textarea>
	            </div>
            </div>
           
         
             <div class="col-md-2">
             
               <div class="form-group">
               <div class="input-group" style="padding-top: 2.5rem;" >
                     <input type="hidden" value="${leadCode}" name="lddi" />
				   	 <input type="hidden" name="p1" value="${P1}" />
				   	 <input type="hidden" name="p2" value="${P2}" />
				   	 <input type="hidden" name="p3" value="${P3}" />
				   	 <input type="hidden" name="p4" value="${P4}" />
				   	 <input type="hidden" name="edocpmees" value="${seempCode}" />
				   	 <input type="hidden" name="ldTyp" value="${leadTyp}" />
				   	 <input type="hidden" name="ldCode" value="${leadUnifCode}" />
				   	  <input type="hidden" name="seg" value="${sEGDetails}" />
				     <input type="hidden" name="action" value="update" />
                     <button type="submit" class="btn btn-primary" >Update</button>
               </div>
              </div>
              
             </div>  
          </form>           
         <%--/.Sales engineer follow up  --%>
          </div>
        </c:when> 
           <%--/.row  --%>
         <%--/.Process-3  --%>  
        
         <%--Process-4  --%>
        <c:when test="${(P1 eq 1 and P2 eq 1 and P3 eq 1  and P4 eq 0 ) or (P1 eq 1 and P2 eq 1 and P3 eq 2  and P4 eq 0 ) or (P1 eq 1 and P2 eq 2 and P3 eq 0  and P4 eq 0 ) and fjtuser.role eq 'mkt'}"> 
        <div class="row mkt-form-row-border">
            <div class="col-xs-12  table-responsive no-padding">
				  <table class="table table-hover" id="sep2viewtable">
				    <tbody>
				    <c:forEach var="leadList"  items="${LEADLIST}" >
				     <c:set var="leadCode" value="${leadList.id}" scope="page" />
				     <c:set var="seempCode" value="${leadList.seEmpCode}" scope="page" />
				     <c:set var="leadTyp" value="${leadList.type}" scope="page" />
				     <c:set var="leadUnifCode" value="${leadList.leadUnfctnCode}" scope="page" />
				     <c:set var="sEGDetails" value="${leadList.seName}" scope="page" />
				    <c:set var="finalRemarks" value="${leadList.mktRemarks}" scope="page" />
				    <tr>
				        <td>
				        <dl class="dl-horizontal">
				        <dt>Lead Code : </dt>
		                <dd>FJMKT${leadList.leadUnfctnCode}</dd>  
		                  <dt>Type</dt>
		                  <dd>${leadList.type}</dd>
		                  <dt>Division : </dt>
		                 <dd>${leadList.division}</dd>
		                 <dt>Product : </dt>
		                 <dd>${leadList.prdct}</dd>
		                  <dt>SE Name : </dt>
		                 <dd>${leadList.seName}</dd>
		                 <dt>Project Details : </dt>
		                 <dd>${leadList.projectDetails}</dd>	
		                 <c:if test="${leadList.typeCode eq 'SL013'}">               
                  		<dt>Already Qtd. Divisions</dt>
                  		<dd>${leadList.stage2QtdDivisions}</dd>
              			</c:if> 		                
		                 <dt>Contractor : </dt>
		                <dd>${leadList.contractor}</dd>
		                 <dt>Consultant : </dt>
		                <dd>${leadList.consultant}</dd>    	               		                 
		                <dt>Lead Initiated On : </dt>
		                 <dd><fmt:parseDate value="${leadList.createdOn}" var="theDate1"    pattern="yyyy-MM-dd HH:mm" />
		                  <fmt:formatDate value="${theDate1}" />
		                  </dd>
				       </dl>
				       </td>
				        <td>
				        <dl class="dl-horizontal">
				         <dt>SE Ack. Status : </dt>
		                <dd>
		                <c:choose>
				        <c:when test="${leadList.p2Status eq 1}"><b style="color:green;">${leadList.ackDesc}</b></c:when>
				        <c:when test="${leadList.p2Status eq 2}"><b style="color:red;">${leadList.ackDesc}</b></c:when>
				         <c:when test="${leadList.p2Status eq 0}"><b style="color:blue;">${leadList.ackDesc}</b></c:when>
				        <c:otherwise><b style="color:blue;">-</b></c:otherwise>
				        </c:choose>
		                </dd>
				         <dt>SE Ack. Remarks : </dt>
		                <dd>${leadList.ackRemarks}</dd> 
		                <dt>SE Ack. On : </dt>
		                 <dd><fmt:parseDate value="${leadList.acknowledgeOn}" var="theDate2"    pattern="yyyy-MM-dd HH:mm" />
		                  <fmt:formatDate value="${theDate2}" />
		                  </dd>
		                  
		        <c:choose>
		        <c:when test="${leadList.processCount eq 3 and  leadList.p2Status ne 2  }">
		           <dt>SE Follow-Up Status: </dt>
		                <dd> <c:choose>
		        <c:when test="${leadList.p3Status eq 1}"><b style="color:green;">${leadList.followUpAckDesc}</b></c:when>
		        <c:when test="${leadList.p3Status eq 2}"><b style="color:red;">${leadList.followUpAckDesc}</b></c:when>
		         <c:when test="${leadList.p3Status eq 0 and leadList.p2Status eq 1}"><b style="color:blue;">Pending</b></c:when>
		         <c:when test="${leadList.p3Status eq 3}"><b style="color:green;">${leadList.followUpAckDesc}</b></c:when>
		        <c:otherwise><b style="color:blue;">-</b></c:otherwise>
		        </c:choose>
		        </dd>
		        <dt>SE Follow-Up Remarks : </dt>
		        <dd>${leadList.seRemarks}</dd>
		        <dt>Project Code : </dt>
		        <dd>${leadList.prjctCode}</dd>
		         <dt>Offer Value (AED) : </dt>
		         <dd><fmt:formatNumber pattern="#,###" value="${leadList.offerValue}" /></dd>
		          <dt>LOI Received?  : </dt>
		          <dd>
		          <c:choose>
		          <c:when test="${leadList.loi eq 1}">YES</c:when>
		           <c:otherwise>NO</c:otherwise>
		           </c:choose> 
		            </dd>
		           <dt>LPO Received?  : </dt>
		           <dd><c:choose>
                   <c:when test="${leadList.lpo eq 1}">YES</c:when>
		           <c:otherwise>NO</c:otherwise>
		           </c:choose> 
		            </dd>
		             <dt>Sales Order No. : </dt>
		             <dd>${leadList.soNumber}</dd>
		                 <dt>SE Updated On : </dt>
		                <dd><fmt:parseDate value="${leadList.followupOn}" var="theDate3"    pattern="yyyy-MM-dd HH:mm" />
		                  <fmt:formatDate value="${theDate3}" /></dd>
		        </c:when>
		        <c:when test="${((leadList.processCount eq 2 and  leadList.p2Status eq 2) or (leadList.processCount eq 3 and  leadList.p2Status eq 2))}">
		                 <dt>Project Code : </dt>
		                 <dd>N/A</dd>
		                 <dt>Offer Value (AED) : </dt>
		                 <dd>N/A</dd>
		                  <dt>LOI Received? : </dt>
		                  <dd>N/A</dd>
		                  <dt>LPO Received? : </dt>
		                  <dd>N/A</dd>
		                 <dt>Sales Order No. : </dt>
		                 <dd>N/A</dd>
		                  <dt>SE Remarks : </dt>
		                 <dd>N/A</dd>
		                 <dt>SE Updated On : </dt>
		                 <dd>N/A</dd>
		        </c:when>
		        <c:otherwise>
		                 <dt>SE Follow-Up Status : </dt>
		                 <dd>-</dd>
		                   <dt>SE Follow-Up Remarks : </dt>
		                 <dd>-</dd>
		                 <dt>Project Code : </dt>
		                 <dd>-</dd>
		                 <dt>Offer Value (AED) : </dt>
		                 <dd><fmt:formatNumber pattern="#,###" value="${leadList.offerValue}" /></dd>
		                  <dt>LOI Received?: </dt>
		                  <dd>-</dd>
		                  <dt>LPO Received?: </dt>
		                  <dd>-</dd>
		                 <dt>Sales Order No. : </dt>
		                 <dd>-</dd>
		                 <dt>SE Updated On : </dt>
		                 <dd>-</dd>
		        </c:otherwise>
		        </c:choose>    
		              
				       </dl>
				       </td>
				    </tr>
				    <c:set var="sono" value="${leadList.soNumber}" scope="page" />
                    <c:set var="pcode" value="${leadList.prjctCode}" scope="page" />
				    </c:forEach>
				    </tbody>
				  </table>
				</div>
				
				
			 <%-- Marketing Team Follow-up  --%>	
			<form action="SalesLeads" method="POST"  id="processFour" name="mt_followup_form">	
            <div class="col-md-5">
            
	            <div class="form-group">
	                <label> Final Remarks By Marketing Team:</label> 
		           <textarea  class="form-control" name="mktRemarks"  required>${finalRemarks}</textarea>
	            </div>
	   
            </div>
    
           <div class="col-md-2">
             
             <div class="form-group">
	                <label>Status :</label>
	                <select class="form-control select2" style="width: 100%;" id="mktStatSlct" name="mktStstus" required>
	                 <option value="">Select Lead Status</option>
	                 <option value="1" >Sucsses</option>
	                 <option value="2">Un-Success</option>
	                 <option value="3">Other</option>
	                </select>
              </div>
           </div>
            
             <div class="col-md-3">
             
               <div class="form-group">
               <div class="input-group" style="padding-top: 2.5rem;">
                     <input type="hidden" value="${leadCode}" name="lddi" />
				   	 <input type="hidden" name="p1" value="${P1}" />
				   	 <input type="hidden" name="p2" value="${P2}" />
				   	 <input type="hidden" name="p3" value="${P3}" />
				   	 <input type="hidden" name="p4" value="${P4}" />
				   	 <input type="hidden" name="edocpmees" value="${seempCode}" />
				   	 <input type="hidden" name="ldTyp" value="${leadTyp}" />
				   	 <input type="hidden" name="ldCode" value="${leadUnifCode}" />
				   	  <input type="hidden" name="seg" value="${sEGDetails}" />
				     <input type="hidden" name="action" value="update" />
                     <button type="submit" class="btn btn-primary" > <i class="fa fa-edit"></i>&nbsp;Close Lead</button>
               </div>
              </div>
              
             </div>  
             </form>
             <%-- /Marketing Team Follow-up  --%>	        
             <%--/.col  --%>
          </div>
          
         
         </c:when>
           <%--/.row  --%>
         <%--/.Process-3  --%>
       <c:otherwise>
       
                <div class="alert alert-danger" role="alert">
				  ${MSG}
				</div>
       
       </c:otherwise>    
       
          
          
      </c:choose>
           <%--/.row  --%>
        </div>
         <%--/.box-body  --%>
        <div class="box-footer">  </div>
      </div>
       <%--/.box  --%>
      </div>
      </div>
	
	
    
      
    </section>
     <%--/.content  --%>
      <div id="laoding" class="loader" ><img src="././resources/images/wait.gif"></div>
   </div>
   <%--/.content-wrapper  --%>
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
 <%--page script start  --%>

 <%--page Script  end  --%>

</c:when>
<c:otherwise>

        <body onload="window.top.location.href='logout.jsp'">
   
            
        </body>
  
</c:otherwise>
</c:choose>
</body>
</html>