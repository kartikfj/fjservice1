<%-- 
    Document   : mainview  
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
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

	<%--	<sql:query var="rs" dataSource="jdbc/mysqlfjtcolocal">
				SELECT * FROM FJPORTAL.LOG_DB_DIVN_EMP  WHERE DM_CODE = ? AND ROWNUM=1
		<sql:param value="${fjtuser.emp_code}"/>
		</sql:query>
		<sql:query var="rs2" dataSource="jdbc/mysqlfjtcolocal">
					String sql = "  SELECT * FROM ( " + 
					"    SELECT PO_CODE \"CODE\", EMP_CODE, DM_CODE FROM  LOG_DB_DIVN_EMP  " + 
					"    UNION " + 
					"    SELECT INV_CODE \"CODE\", EMP_CODE, DM_CODE FROM  DEL_DB_DIVN_EMP " + 
					") " + 
					" WHERE EMP_CODE = ? AND ROWNUM=1 ";
		<sql:param value="${fjtuser.emp_code}"/>
	 </sql:query>     --%>	
		<sql:query var="service" dataSource="jdbc/orclfjtcolocal">
				SELECT USER_TYPE, DIVN_CODE FROM FJPORTAL.SERVICE_USER WHERE  EMPID = ?  AND ROWNUM = 1
			<sql:param value="${fjtuser.emp_code}"/>
 		</sql:query> 
 	    <sql:query var="sobudget" dataSource="jdbc/orclfjtcolocal">
				select OTHSOB_PGM_EMAIL1 from FJPORTAL.FJT_OTHSOB_PGM  where OTHSOB_PGM_EMAIL1 = ?
			<sql:param value="${fjtuser.emailid}"/>
 		</sql:query>
 		<sql:query var="sobudgetsub" dataSource="jdbc/orclfjtcolocal">
 			SELECT TXNFIELD_EMP_CODE,TXNFIELD_FLD2 FROM PAYROLL.PT_TXN_FLEX_FIELDS WHERE TXNFIELD_FLD3 = ? AND TXNFIELD_TXN_CODE='EMP' AND TXNFIELD_BLOCK_NUM=1   AND TXNFIELD_EMP_CODE  IN ( SELECT EMP_CODE FROM FJPORTAL.PM_EMP_KEY WHERE   EMP_FRZ_FLAG = 'N' AND (EMP_STATUS = '1' OR EMP_STATUS ='2') )
 		<sql:param value="${fjtuser.emp_code}"/>
 		</sql:query>
 		<sql:query var="logistic" dataSource="jdbc/orclfjtcolocal">
 			  SELECT * FROM ( SELECT PO_CODE CODE, EMP_CODE, DM_CODE FROM  LOG_DB_DIVN_EMP  
					    	UNION
			  				SELECT INV_CODE CODE, EMP_CODE, DM_CODE FROM  DEL_DB_DIVN_EMP 
							) WHERE EMP_CODE = ? AND ROWNUM=1
		  <sql:param value="${fjtuser.emp_code}"/>
 		</sql:query>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title>FJ Group</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="resources/abc/style.css?v=27052022-04" rel="stylesheet" type="text/css" />
<link href="resources/abc/responsive.css?v=31122020" rel="stylesheet" type="text/css" />
  <link rel="stylesheet" href="resources/abc/bootstrap.min.css">
  <script src="resources/abc/jquery.min.js"></script>
  <script src="resources/abc/bootstrap.min.js"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
<script src="resources/js/mainview.js"></script>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet" />
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <style>
.navbar-brand { padding: 0px;}.navbar-brand>img { height: 101%; width: auto; margin-left: 5px; margin-right: 6px;}.navbar { border-radius: 0px; }
.navbar ul li{font-style: normal;  font-variant-ligatures: normal; font-variant-caps: normal; font-variant-numeric: normal;   font-variant-east-asian: normal; font-stretch: normal; line-height: normal;  font-size: 14px;  font-weight: 700;}
.navbar-default {  background-color: #375988 !important;  border-color: #375988 !important;}.navbar-nav>li  {  padding-top: 5px !important;} 
.navbar-brand{height:62px !important}.navbar-default .navbar-nav>li>a:hover, .navbar-default .navbar-nav>.open>li>a, .navbar-default .navbar-nav>.open>li>a:focus, .navbar-default .navbar-nav>.open>li>a:hover{
background:#fff;color:#008ac1;}
#fj-page-head{padding:4px 8px !important;color:#065685;margin-top:-20px;}#fj-page-head-box{border: none;}

.grid {display: grid; grid-template-columns: repeat(auto-fill, minmax(130px,1fr)); gap: 2%;}
.square1 {aspect-ratio: auto; display: flex; align-items: center;padding: 5%; color: #fff; border: 3px solid black;border-radius: 25px;}
.square1 img {width: 100%; min-height: 80%; object-fit: cover; object-position: center; border-radius: 5%;}
.square1 h1 {text-align: center; font-size:15px;}


/*.square {aspect-ratio: auto; display: flex; align-items: center; padding: 5%; background-color: #065685; color: #fff; border: 3px solid black; border-radius: 25px;}*/
.square {aspect-ratio: auto; display: flex; align-items: center; padding: 5%; color: #fff; }
.square img {width: 100%; min-height: 80%; object-fit: cover; object-position: center; border-radius: 5%;}
.square h1 {text-align: center; font-size:15px;}

.myimg{width:50px; height:40px; object-fit:cover; border-radius:75%;}
.square.fullImg {padding: 0;}
.navbar-text {position: absolute;width: 100%; left: 0; text-align: center; margin: auto; padding-top: 10px;font-size: 35px;  }

.square2 {aspect-ratio: auto; display: flex; align-items: center; padding: 5%;  background-color: rgba(0, 0, 0, 0.3); color: #fff; border: 2px solid  #065685; border-radius: 25px;}
.square2 img {width: 100%; min-height: 80%; object-fit: cover; object-position: center; border-radius: 5%;}
.square2 h1 {text-align: center; font-size:15px;}

.square3 {aspect-ratio: auto; display: flex; align-items: center; padding: 5%;  color: #fff;}
.square3 img {width: 100%; min-height: 80%; object-fit: cover; object-position: center; border-radius: 5%;}
.square3 h1 {text-align: center; font-size:15px;}

.square4 {aspect-ratio: auto; display: flex; align-items: center; padding: 5%;   background-color: rgba(0, 0, 0, 0.3); color: #fff;border-radius: 25px;}
.square4 img {width: 100%; min-height: 80%; object-fit: cover; object-position: center; border-radius: 5%;}
.square4 h1 {text-align: center; font-size:15px;}

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
	          	 <a class="visible-xs" href="calendar.jsp"><i class=" fa fa-2x fa-home" style="float: left;padding: 9px 10px;margin-right: 15px;color: cornsilk;" aria-hidden="true"></i></a>
         		 <a class="visible-xs" href="logout.jsp"><i class=" fa fa-2x fa-power-off" style="float: right;padding: 11px 6px;margin-right: 15px;color: cornsilk;" aria-hidden="true"></i></a>
	          	 <p class="hidden-xs navbar-text" style="color: #fff">Welcome to FJ Portal</p>
	      </div>
	      
			
			
	      <div id="navbar1" class="navbar-collapse collapse">		    
			<ul class="nav navbar-nav navbar-right">			
	          <li> <a id="setting_tab" href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
	          <img id="img" class="myimg" src="profileImage.jsp?" onmouseout="resetImg();" onmouseover="enlargeImg();"/>&nbsp;&nbsp;
	          <c:choose>	          
		          <c:when test="${fjtuser.uname.length() > 30}"> 
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
		<div class="grid"> 
		  <div class="square"><a href="calendar.jsp"><h1><b>Attendance</b><img src="resources/images/buttons/attendance.jpg" /></h1></a></div>  
		  <c:choose>		 
		   <c:when test="${fjtuser.role eq 'mg'  and fjtuser.sales_code ne null and !fjtuser.emp_divn_code.contains('MK')}"> 
          	 	<div class="square"><a href="consolidatedData.jsp"><h1><b>Finance Dashboard</b><img src="resources/images/buttons/finance.jpg" /></h1></a></div>
          	 </c:when>
          	  <c:when test="${fjtuser.salesDMYn ge 1  and fjtuser.sales_code ne null and !fjtuser.emp_divn_code.contains('MK')}">
          	   <div class="square"><a href="ConsolidatedReport"><h1><b>Finance Dashboard</b><img src="resources/images/buttons/finance.jpg" /></h1></a></div> 	
          	  </c:when>		  
		   <c:otherwise>
		   </c:otherwise>
		   </c:choose>
		    <c:if test="${fjtuser.emp_code eq 'E001977'}">
              	<div class="square"><a href="consolidatedData.jsp"><h1><b>Finance Dashboard</b><img src="resources/images/buttons/finance.jpg" /></h1></a></div>
              </c:if>
		  <c:choose>
          	<c:when test="${(fjtuser.salesDMYn eq 1 or fjtuser.role eq 'mg') && !fjtuser.emp_divn_code.contains('MK')}">          		 
          		<div class="square"><a href="DisionInfo.jsp"><h1><b>Sales Dashboard</b><img src="resources/images/buttons/salesdashboard.png" /></h1></a></div>          		
          	</c:when>
          	<c:when test="${fjtuser.sales_code ne null and fjtuser.salesDMYn ne 1 and !fjtuser.emp_divn_code.contains('MK')}"> 
          		 <div class="square"><a href="sip.jsp"><h1><b>Sales Dashboard</b><img src="resources/images/buttons/salesdashboard.png" /></h1></a></div>
          	</c:when>           	
          	<c:when test="${fjtuser.role eq 'hrmgr'}">           		
          	 	 <div class="square" onclick="preSendLoaderStyle();" id="hrdashboard"><a href="HrDashboard"><h1><b>HR Dashboard</b><img id="hrdashboard" src="resources/images/buttons/hr-dashboard.png" /></h1></a>          	 	 	 
          	 	 </div>
          	 	 <div class="square" style="display:none;" id="loader"><h1><b>HR Dashboard</b><img src="resources/images/fjpre.gif" /></h1>          	 	 	 
          	 	 </div>   
          	 	 <!--  <div class="square" style="display:none;" id="loader"><h1>HR Dashboard<img src="resources/images/hrdshbrdprogrss.png" /></h1>          	 	 	 
          	 	 </div> -->    	 	
          	</c:when>
          	<c:otherwise></c:otherwise>
          </c:choose> 
          <div class="square"><a href="SelfEvaluation" ><h1><b>Emp.Evaluation</b><img src="resources/images/buttons/empeval.jpg" /></h1></a></div>   
          <div class="square"><a href="certificates.jsp" ><h1><b>Emp.Self Service</b><img src="resources/images/buttons/selfservice.jpg" /></h1></a></div>          
        <!--  <c:choose>
            <c:when test="${fjtuser.role eq 'hrmgr'}">
            	<div class="square"><a href="experienceCert.jsp" ><h1><b>Emp.Self Service</b><img src="resources/images/buttons/selfservice.jpg" /></h1></a></div>
            </c:when>
            <c:otherwise>
            	<div class="square"><a href="ExperienceCertificate" ><h1><b>Emp.Self Service</b><img src="resources/images/buttons/selfservice.jpg" /></h1></a></div>
            </c:otherwise>
          </c:choose>     -->  
          
          <div class="square"><a href="hrpolicies.jsp" ><h1><b> HR Manual</b><img src="resources/images/buttons/hrmanual.png"/></h1></a></div> 
          <c:if test="${fjtuser.role eq 'hr'}">
				<div class="square"><a href="staffworkschedule.jsp" ><h1><b>HR Settings</b><img src="resources/images/buttons/hrsettings.jpg" /></h1></a></div>			           
		  </c:if>
		  <c:if test="${fjtuser.emp_code eq 'E000001' || fjtuser.emp_code eq 'E000063'}"> 
		         <div class="square" onclick="preSendLoaderStyle();" id="hrdashboard"><a href="HrDashboard"><h1><b>HR Dashboard</b><img id="hrdashboard" src="resources/images/buttons/hr-dashboard.png" /></h1></a>          	 	 	 
          	 	 </div>		
          	 	 <div class="square" style="display:none;" id="loader"><h1><b>HR Dashboard</b><img src="resources/images/fjpre.gif" /></h1>          	 	 	 
          	 	 </div>  
		   </c:if>	   	 
		   <div class="square"><a href="https://forms.gle/p6vB5mmmuUCGXiqQ7" ><h1><b> Innovative Idea- Proposal</b><img src="resources/images/buttons/innovativeidea.png"/></h1></a></div> 
		   <!--<c:choose>
		        <c:when test="${fjtuser.emp_divn_code eq 'FN'}">
		        	<div class="square"><a href="LogisticDeliveryController" ><h1>Logistic<img src="resources/images/buttons/logistic.jpg" /></h1></a></div>
		        </c:when>
		        <c:otherwise>
		        	<div class="square"><a href="LogisticPOController" ><h1>Logistic<img src="resources/images/buttons/logistic.jpg" /></h1></a></div>
		        </c:otherwise>
       	   </c:choose>-->
		  <c:choose>
		        <c:when test="${fjtuser.emp_divn_code eq 'FN'}">
		        	<div class="square"><a href="LogisticDeliveryController" ><h1><b>Logistic</b><img src="resources/images/buttons/logistic.jpg" /></h1></a></div>
		        </c:when>
		        <c:when test = "${fjtuser.emp_divn_code eq 'FN' || fjtuser.emp_divn_code eq 'LG' || fjtuser.role eq 'mg' || !empty logistic.rows}">		        	
		        	<div class="square"><a href="LogisticPOController" ><h1><b>Logistic</b><img src="resources/images/buttons/logistic.jpg" /></h1></a></div>
		        </c:when >
       	  </c:choose>
<%-- 		  <c:if test="${fjtuser.role eq 'mkt' or fjtuser.role eq 'mg' or fjtuser.sales_code ne null}"> --%>
	       		 <div class="square"><a href="ProjectLeads" ><h1><b>Marketing</b><img src="resources/images/buttons/marketing.png" /></h1></a></div>  
<%-- 	      </c:if> --%>
	      <div class="square"><a href="insurance.jsp" ><h1><b>Med.Insurance</b><img src="resources/images/buttons/medicalinsurance.jpg" /></h1></a></div> 
		  <div class="square"><a href="regularisationHistory.jsp" ><h1><b>Reports</b><img src="resources/images/buttons/reports.jpg" /></h1></a></div>
	      <c:if test="${!empty service.rows}">  
		 		 <div class="square"><a href="ServiceController" ><h1><b>Service</b><img src="resources/images/buttons/servicereport.jpg" /></h1></a></div> 
		  </c:if>
		  <c:if test="${(!empty sobudget.rows || !empty sobudgetsub.rows) && !fjtuser.emp_divn_code.contains('MK')}"> 
		 		 <div class="square"><a href="SOBudgetController.jsp" ><h1><b>SO Budget</b><img class="rs" src="resources/images/buttons/budget.jpg" /></h1></a></div> 
		  </c:if>	  		  
          <c:if test="${(fjtuser.role eq 'mg' or fjtuser.salesDMYn eq 1  or fjtuser.sales_code ne null) && !fjtuser.emp_divn_code.contains('MK')}">
          		<div class="square"><a href="sipWeeklyReport" ><h1><b>Weekly Report</b><img src="resources/images/buttons/weeklyreport.png" /></h1></a></div> 
          </c:if> 	      
          <div class="square"><a href="https://dms.fjtco.com:7333/fjtcdms/Main/Dashboard.aspx" TARGET = "_blank"><h1><b>DMS</b><img src="resources/images/buttons/dmslogo.png" /></h1></a></div>    
          <c:if test="${fjtuser.emp_code eq 'E004272' || fjtuser.emp_code eq 'E003066'}">
              	<div class="square"><a href="queries.jsp"><h1><b>IT Queries</b><img src="resources/images/buttons/queries.jpeg" /></h1></a></div>
          </c:if>  
          <c:if test="${fjtuser.emp_code eq 'E003426' || fjtuser.emp_code eq 'E003589' || fjtuser.emp_code eq 'E003511' || fjtuser.emp_code eq 'E005034' || fjtuser.emp_code eq 'E004272'}"> 
		         <div class="square"  id="hrdashboard"><a href="CustomerDetails.jsp"><h1><b>KSA Customer Updation</b><img id="hrdashboard" src="resources/images/buttons/custupdate.png" /></h1></a>          	 	 	 
          	 	 </div>		
          	 	   
		   </c:if>	    
		</div>
			
</div>

</c:when>
<c:otherwise>
    <html>
        <body onload="window.top.location.href='logout.jsp'">
        </body>
            
        </body>
    </html>
</c:otherwise>
</c:choose>

 <script>
// $('#laoding').hide();   
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
      function preSendLoaderStyle()
      {
    	  $("#hrdashboard").hide(); 
    	  $("#loader").show(); 
         $("#loader").css({"opacity": "0.7",  "background-size": "60px 60px"});
      }
      </script>