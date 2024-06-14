<%-- 
    Document   : EMPLOYEE SALARY CERTIFICATE  
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@include file="mainview.jsp" %>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.DateFormatSymbols"%>
<% 
        response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
        response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
        response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
        response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
%>
<%
  DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
  Calendar cal = Calendar.getInstance();
  int currentMonth = cal.get(Calendar.MONTH)+1;  
  int iYear = cal.get(Calendar.YEAR);   
  String currCalDtTime = dateFormat.format(cal.getTime()).substring(0, 10);
  request.setAttribute("currCal", currCalDtTime);
 
 %>
<!DOCTYPE html>
<html>
<head>
 <link rel="stylesheet" href="resources/bower_components/font-awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="resources/dist/css/AdminLTE.min.css">
<link rel="stylesheet" href="resources/dist/css/skins/_all-skins.min.css">
<link rel="stylesheet" type="text/css" href="resources/datatables/datatables-fjtco/css/jquery.dataTables.min.css" />
<link rel="stylesheet" type="text/css" href="resources/datatables/buttons-fjtco/css/buttons.dataTables.min.css" />
<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/dataTables.buttons.min.js"></script>
<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.flash.min.js"></script>
<script type="text/javascript" src="resources/datatables/ajax/excelmake/jszip.min.js"></script>
<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.html5.min.js"></script>
<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.print.min.js"></script>
<style type="text/css">
.page-header { color: #065685; font-weight: bold;  border-bottom: 2px solid #065685 !important; text-transform:uppercase; letter-spacing: 0.1em;}
.payslip{position: relative; background: #fff;border: 1px solid #b9b8b8; padding: 20px;margin: 10px 25px;}.payslip-info{ }
.pay-subtitle-parent{    margin-top: -15px;}.payslip-col>.sub-title{background: #daf0f3;padding:7px 5px;}.info-box-content{margin-top: 20%;}
.info-box-text { text-transform: uppercase;font-weight: bold;}.pay-total-title{color:red; font-weight:bold;text-align:center;}.pay-total-amount{font-weight:bold;}
.summary{color:#009688; font-weight:bold;border-bottom:1px dashed #bbc5f1;}.sub-title{color:#000; font-weight:bold;text-align:center;letter-spacing: 0.05em;}.small{color: #607D8B; !important}
hr {
    border: none;
    border-top: 1px double #333;
    color: #333;
    overflow: visible;
    text-align: center;
    height: 0px;
    padding-left:15px;
    padding-right:15px;
}
 
</style>
<script type="text/javascript">

function downloadSalaryCertificate(empCode){ 	   
    
      		    var printArea = document.getElementById("experienceCertificate-Box").innerHTML;
                var printFrame = document.createElement('iframe');
                printFrame.name = "printFrame";
                printFrame.style.position = "absolute";
                printFrame.style.top = "-1000000px";    			
                document.body.appendChild(printFrame);
                var printFrameDoc = 
					    (printFrame.contentWindow) ? printFrame.contentWindow 
					    : (printFrame.contentDocument.document) ? printFrame.contentDocument.document : printFrame.contentDocument;
                printFrameDoc.document.open();
                printFrameDoc.document.write('<html><head><title></title>');
    			printFrameDoc.document.write('<link rel="stylesheet" href="resources/css/payslip.css?v=1.1.8">');
                printFrameDoc.document.write('</head><body>');
                printFrameDoc.document.write(printArea);
                printFrameDoc.document.write('</body></html>');
                printFrameDoc.document.close();
                setTimeout(function () {
                    window.frames["printFrame"].focus();
                    window.frames["printFrame"].print();
                    document.body.removeChild(printFrame);
     //printFrameDoc.document.close();
                }, 500);
                return false;
} 

function formatNumber(num) {
	 if(typeof num !== 'undefined' && num !== '' && num != null){
		 return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
	 }else{ return 0;}
	
	 }
</script>
</head>
<c:choose>
<c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1}">
<c:set var="count" value="0" scope="page"/>
<c:set var="smonth" value="0" scope="page"/>
<c:choose>
<c:when test="${selectedMonth ne null or !empty selectedMonth}">
	<c:set var="smonth" value="${selectedMonth}" scope="page"/>
</c:when>
<c:otherwise><c:set var="smonth" value="<%=currentMonth%>" scope="page"/></c:otherwise>
</c:choose>

<body>
<section>
 	<div class="container">
 		 <div class="panel panel-default  small" id="fj-page-head-box">
                <div class="panel-heading" id="fj-page-head">    
	                <div class="col-xs-12 " style="padding-bottom: 10px;">				  			 
				  			  <c:if test="${fjtuser.role ne 'hrmgr'}"> 
				  			 	 <a href="ExperienceCertificate" class="button">Experience Certificate</a>
				  			  </c:if>				  			 
				  			  <c:if test="${fjtuser.role eq 'hrmgr'}"> 
				  			  	<a href="ExperienceCertificate?fjtco=hr" class="button">Experience Certificate</a>
				  			  </c:if>
				  			  <a href="Payslip" class="button">Payslip</a>				  			  
				  			  <a href="SalaryCertificate" class="button">Salary Certificate</a>			
				  			  <a href="PortalITProjects" class="button">Request for IT</a>	
				  			  <a href="Feedback" class="button"> Feedback</a></div>	  			  		  			  
				       	</div>                    
                         <h4 class="text-left">
		                    Employee Certificates
		                   <a href="homepage.jsp" > <i class="fa fa-home pull-right" title="Home"></i></a>  
		                   <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a>                   
		                  </h4>   		  	            
                </div>
            </div>
 		 <div class="row">
	 		 <section class="col-xs-12" style="width:90%;"> 		
	 		 </section> 
		</div>			   
	</div> 
</section>
</body>
</c:when>
<c:otherwise>
<html>
 <body onload="window.top.location.href='logout.jsp'">
 </body> 
</html>
</c:otherwise>
</c:choose>