<%-- 
    Document   : mainview  
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% 
        response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
        response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
        response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
        response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
%>
<jsp:useBean id="fjtuser" class="beans.fjtcouser" scope="session"/>
<c:choose>
<c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1}">
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/><title>FJ Group</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="resources/abc/style.css?v=27052022-04" rel="stylesheet" type="text/css" />
<link href="resources/abc/responsive.css?v=31122020" rel="stylesheet" type="text/css" />
  <link rel="stylesheet" href="resources/abc/bootstrap.min.css">
  <script src="resources/abc/jquery.min.js"></script>
  <script src="resources/abc/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
<script src="resources/js/mainview.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet" />
  <style>
.navbar-brand { padding: 0px;}.navbar-brand>img { height: 101%; width: auto; margin-left: 5px; margin-right: 6px;}.navbar { border-radius: 0px; }
.navbar ul li{font-style: normal;  font-variant-ligatures: normal; font-variant-caps: normal; font-variant-numeric: normal;   font-variant-east-asian: normal; font-stretch: normal; line-height: normal;  font-size: 14px;  font-weight: 700;}
.navbar-default {  background-color: #375988 !important;  border-color: #375988 !important;}.navbar-nav>li  {  padding-top: 5px !important;} 
.navbar-brand{height:62px !important}.navbar-default .navbar-nav>li>a:hover, .navbar-default .navbar-nav>.open>li>a, .navbar-default .navbar-nav>.open>li>a:focus, .navbar-default .navbar-nav>.open>li>a:hover{
background:#fff;color:#008ac1;}
.myimg{width:50px; height:40px; object-fit:cover; border-radius:75%;}
.button {background-color: #0c6599; border-color: solid 5px #065685; box-shadow: 0px 0px 14px -7px #f09819; color: white; padding: 7px 15px;  text-align: center;  text-decoration: none;  display: inline-block;  border-radius: 15px;
  font-size: 12px;
  margin: 4px 2px;
  cursor: pointer;
  padding-top:10px; 
    
}
.button:hover{ background-color: white;outline-color: transparent;outline-style:solid;box-shadow: 0 0 0 4px #0065b3;transition: 0.7s;}
.navbar-text {position: absolute;width: 100%; left: 0; text-align: center; margin: auto; padding-top: 10px;font-size: 35px;}
 @keyframes blinker {50% {opacity: 0; }}
#fj-page-head{padding:4px 8px !important;color:#065685;margin-top:-20px;}#fj-page-head-box{border: none;}
</style>

    </head>
    <body>
    <c:if test="${empty fjtuser.emp_code}">            
        <jsp:forward page="index.jsp"/>
        </c:if>
       <div class="container">
  <nav class="navbar navbar-default">
    <div class="container-fluid">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar1">
          <span class="sr-only">Toggle navigation</span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
        </button>
        <a class="navbar-brand" href="#"><img src="resources/images/logo_t5.jpg" alt="Dispute Bills">
        </a>
          <a class="visible-xs" href="homepage.jsp"><i class=" fa fa-2x fa-home" style="float: left;padding: 9px 10px;margin-right: 15px;color: cornsilk;" aria-hidden="true"></i></a>
          <a class="visible-xs" href="logout.jsp"><i class=" fa fa-2x fa-power-off" style="float: right;padding: 11px 6px;margin-right: 15px;color: cornsilk;" aria-hidden="true"></i></a>
           <p class="hidden-xs navbar-text" style="color: #fff">Welcome to FJ Portal</p> 
          <!--  <p>
          <marquee class="navbar-text" style="color: #fff" behavior="scroll" direction="left">Welcome to FJ Portal</marquee>
          </p>-->
      </div>
      <div id="navbar1" class="navbar-collapse collapse">
       <%--  <ul class="nav navbar-nav">
          <li class="dropdown">
            <a id="home_tab" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Attnd & Leaves <span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
              <li><a href="calendar.jsp">Attendance</a></li>
              <li><a href="leaveappln.jsp">Leave applications</a></li>
              <c:if test="${!empty fjtuser.subordinatelist}">
                <li><a href="approvalrequests.jsp" >Leave Approval</a></li>
                <li><a href="approvalregularisation.jsp" >Regularisation Approval</a></li>
                </c:if>
            </ul>
          </li>
		  <li class="dropdown">
            <a id="report_tab" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Reports <span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
            
              <li><a href="regularisationHistory.jsp" >Regularisation request history</a></li>
              <li><a href="leaveHistory.jsp" >Leave request history</a></li>
                 <c:if test="${fjtuser.role eq 'hr'}">             
                <li><a href="AppraisalReport" >Appraisal Report</a></li>              
               </c:if>
              <c:if test="${!empty fjtuser.subordinatelist}">
  			<li><a href="Regularisation_Report" >Regularisation Report</a></li>  
  			<li><a href="Leave_Report" >Leave Report</a></li>   
  			</c:if>
  				<li><a href="Payslip">Payslip</a></li>
            </ul>
          </li>
             <c:if test="${fjtuser.role eq 'hr' or fjtuser.role eq 'hrmgr'}">
		  <li class="dropdown">
            <a id="setting_tab" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">HR Settings <span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
           
                <li><a href="staffworkschedule.jsp" >Staff Work Schedule</a></li>
                <li><a href="labourworkschedule.jsp" >Labour Work Schedule</a></li>
                <li><a href="holidaycalendar.jsp" >Holiday calendar</a></li>
                <li><a href="editsysparams.jsp" >Processing month settings</a></li>
                <li><a href="muster.jsp" >Muster roll</a></li>
                <li><a href="LeaveCancellation" >Leave Cancellation</a></li>
                <li><a href="HrRegularisationCorrectionController" >Regularisation Correction</a></li>
               
              
            </ul>
          </li>
          </c:if>
          <li><a href="hrpolicies.jsp" >HR Manual</a></li>
          <li><a href="insurance.jsp" >Med. Insurance</a></li> 
         <c:choose>
          	<c:when test="${fjtuser.salesDMYn eq 1 or fjtuser.role eq 'mg'}">
          		<li class="dropdown"><a href="DisionInfo.jsp">Dashboard</a></li>
          	</c:when>
          	<c:when test="${fjtuser.sales_code ne null and fjtuser.salesDMYn ne 1}">
          		 <li class="dropdown"><a href="sip.jsp">Dashboard</a></li>
          	</c:when>
          	<c:when test="${fjtuser.role eq 'hrmgr' }"> 
          	 <li class="dropdown"><a href="HrDashboard">Dashboard</a></li>
          	</c:when>
          	<c:otherwise></c:otherwise>
          </c:choose>  
         <li class="dropdown"><a href="SelfEvaluation">Emp. Evaluation</a></li>
        </ul> --%>
		<ul class="nav navbar-nav navbar-right">
		<li> <a id="setting_tab" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"> <img id="img" class="myimg" src="profileImage.jsp?" onmouseout="resetImg();" onmouseover="enlargeImg();"/>&nbsp;&nbsp;
		     <c:choose>	          
		          <c:when test="${fjtuser.uname.length() > 35}"> 
		                 ${fjtuser.uname.substring(0,30)}
		          </c:when>
		          <c:otherwise>
		          	${fjtuser.uname}
		          </c:otherwise>
	          </c:choose>
            <span class="caret"></span>
            </a>
            <ul class="dropdown-menu" role="menu">
            	<li><a href="profile" ><span class="glyphicon glyphicon-user"></span> Profile</a></li>
                <li><a href="personalsettings.jsp" ><span class="glyphicon glyphicon-lock"></span> Change Password</a></li>
                <li><a href="logout.jsp"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
            </ul>
         </li>
		</ul>
      </div>
      <!--/.nav-collapse -->
    </div>
    <!--/.container-fluid -->
  </nav>
</div>
 <!-- script to set display property -->
    <script>
      function enlargeImg() {
        // Set image size to 1.5 times original
         img = document.getElementById("img");
        img.style.transform = "scale(2.0)";
        // Animation effect
        img.style.transition = "transform 0.25s ease";
      }
      function resetImg() {
          // Set image size to 1.5 times original
           img = document.getElementById("img");
           img.style.transform = "scale(1)";
          // Animation effect
          img.style.transition = "transform 0.25s ease";
        }
      </script>
</c:when>
<c:otherwise>
    <html>
        <body onload="window.top.location.href='logout.jsp'">
        </body>
            
        </body>
    </html>
</c:otherwise>
</c:choose>