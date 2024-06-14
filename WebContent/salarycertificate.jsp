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
.summary{color:#009688; font-weight:bold;border-bottom:1px dashed #bbc5f1;}.sub-title{color:#000; font-weight:bold;text-align:left;letter-spacing: 0.05em;padding-left:15px;padding-right: 15px;width:100%}.small{color: #607D8B; !important}
hr {
    border: none;
    border-top: 1px double #333;
    color: #333;
    overflow: visible;
    text-align: center;
    height: 0px;
    padding-left:15px;
    padding-right:15px;
    margin-top: 0px;
}
  body{
   font-family:"Calibri", "sans-serif";
}
.watermark{
  background:url("resources/images/fjwatermark.PNG") center center ;opacity:0.6; 
  position: absolute;
  width: 90%;
  height: 100%;
  background-repeat: no-repeat;
  background-position: bottom; 
}
</style>
<script type="text/javascript">

function downloadSalaryCertificate(empCode){ 	   
    
      		    var printArea = document.getElementById("salaryCertificate-Box").innerHTML;
                var printFrame = document.createElement('iframe');
                printFrame.name = "printFrame";
                printFrame.style.position = "absolute";
                printFrame.style.top = "-1000000px";
                document.body.appendChild(printFrame);
                var printFrameDoc = 
					    (printFrame.contentWindow) ? printFrame.contentWindow 
					    : (printFrame.contentDocument.document) ? printFrame.contentDocument.document : printFrame.contentDocument;
                printFrameDoc.document.open();
                printFrameDoc.document.write('<html><head><title> </title>');
    			printFrameDoc.document.write('<link rel="stylesheet" href="resources/css/certificates.css?v=1.1.10">');
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
<c:choose>
<c:when test ="${SALARYINFO ne null}">
<section>
 	<div class="container"> 		
 		 <div class="row">
 		 <section class="col-xs-12" style="width:90%;"> 		
 		 </section> 	
 		 <div class="col-xs-12" style="width:10%;">
            <h4 class="text-right"> <a href="homepage.jsp" > <i class="fa fa-home pull-right" title="Home"></i></a>
            <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a> </h4>  
          </div>	  
    <section class="payslip col-xs-9 pull-right" >
     <div class="watermark"></div>
      <!-- title row -->
      <div id="salaryCertificate-Box">
      <div class="row" style="margin-left: auto;margin-right: auto;">
        <div class="col-xs-12">
          <h2 style="margin-top:0px;margin-bottom:0px;"><img id="img" width="100%" style="float: right;" src="signature.jsp?signtype=header"/></h2>
        </div>
        <!-- /.col -->
      </div>      
      <!-- info row -->
      <div class="row" style="margin-left: auto;margin-right: auto;">       
	        <div class="col-xs-12" style="padding-bottom:2em">
	          <table>		          
		           <tr><td style="width:1%;"><b>Date</b></td><td style="width:25%;"><b>:</b> ${currCal}</td></tr>		         
		           <tr><td style="width:1%;"><b>Reference</b></td><td style="width:25%;"><b>:</b> HR/HQ/SC/${fjtuser.getEmp_com_code()}/<%=iYear %>/${fjtuser.emp_code}</td></tr>
		          </table>          
		        </div>	       
		 <h3 class="sub-title" >SALARY CERTIFICATE<small class="pull-left"></small><br/> <hr>  </h3>
	    
         <div class="col-sm-12 payslip-col" id="salarycertSummary">        
				To: Whom it may concern,<br/><br/>
				We hereby certify that the under mentioned employee is under employment of <b>${SALARYINFO.cost_center},</b>  a member of the FJ Group.<br/><br/>			
				<table>
					<tr><td style="width:2%;"><b>Name:</b></td><td style="width:25%;">	${fjtuser.uname}</td></tr>
					<tr><td style="width:2%;"><b>Nationality:</b>	</td><td style="width:25%;">${SALARYINFO.nationality}</td></tr>
					<tr><td style="width:2%;"><b>Passport No:</b></td><td style="width:25%;">	${SALARYINFO.passport_Number}</td></tr>
					<tr><td style="width:5%;"><b>Date of Employment:</b></td><td style="width:25%;">	<fmt:parseDate value="${SALARYINFO.join_date}" var="theDate"    pattern="yyyy-MM-dd HH:mm" />
												<fmt:formatDate value="${theDate}" pattern="dd/MM/yyyy"/></td></tr>					
					<tr><td style="width:2%;"><b>Designation:</b>	</td><td style="width:25%;">${SALARYINFO.designation}</td></tr>
					<tr><td style="width:2%;"><b>Business Unit:</b></td><td style="width:25%;">	${SALARYINFO.company_name}</td></tr>
					<tr><td style="width:2%;"><b>Place of work:</b></td><td style="width:25%;">	${SALARYINFO.jobLocation}<br/></td></tr>
					<tr><td style="width:2%;"><b>Gross Salary:</b></td><td style="width:25%;">${SALARYINFO.currency} <fmt:formatNumber type="number"   value="${SALARYINFO.tot_sal}" />/month<br/></td></tr>
				 </table> <br/>
				This certificate was issued upon the employee’s request without any liability on the Company.<br/><br/>
				
	        </div>
	         <div class="col-sm-4 payslip-col" id="payslipSUmmary">	
	         Best Regards,<br/>		
	         	<img width="100px" height="100px" src="signature.jsp?signtype=hrsign"/>	<br/>	         	
				Ann Ewing<br/>
				HR Manager<br/>						
		          
		    </div>	
		    <div class="col-xs-6 table-responsive" style="float:right">				
	     		<img  src="signature.jsp?signtype=footer&compCode=${SALARYINFO.cc_code}"/>
	        </div><br/><br/><br/>
	        
		      	<div class="col-sm-12" style="padding-top:60px" id="salarycertSummary">
		     	 <b>Note:</b>
						This certificate is generated automatically and valid for one month only. Any correction or change will cease this certificate.<br/><br/>
				</div> 
				 <div class="col-sm-12" id="salarycertSummary"> 
					<footer style="Margin:0;padding-bottom:30px;margin:0;text-align:center;border-top: 1px solid black;">				 			
							FJ Group, P.O. Box: 1871, Dubai, United Arab Emirates, TEL: +971 4810 5105					
					  </footer> 	
				  </div>
     	 </div>  	
      <!-- /.row -->
     </div>  
      <!-- this row will not appear when printing -->
      <div class="row no-print">
        <div class="col-xs-12">
          <button type="button" class="btn btn-sm btn-default  pull-left" style="margin-top: 10px;" onClick="downloadSalaryCertificate('${fjtuser.emp_code}');">
            <i class="fa fa-download"></i> Download PDF
          </button>
        </div>
      </div> 
    </section>
	</div>			   
	</div> 
</section>
</c:when>
	<c:otherwise>
		<section>
	 	<div class="container"> 		
	 		 <div class="row">
	 		 <section class="col-xs-12" style="width:90%;"> 
	 		  Kindly note: You don't have this feature. 			
	 		 </section> 
	 		
	 		   <div class="col-xs-12" style="width:10%;">
		 		  <h4 class="text-left">                   
		               <a href="homepage.jsp" > <i class="fa fa-home pull-right" title="Home"></i></a>  
		               <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a>                   
		          </h4>  
	          </div> 
	          </div>
	          </div>
	          </section>
	</c:otherwise>
</c:choose>
</body>
</c:when>
<c:otherwise>
<html>
 <body onload="window.top.location.href='logout.jsp'">
 </body> 
</html>
</c:otherwise>
</c:choose>