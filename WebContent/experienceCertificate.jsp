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
  <link href="resources/css/stylev2.css?v=27052022-05" rel="stylesheet" type="text/css" />
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
.summary{color:#009688; font-weight:bold;border-bottom:1px dashed #bbc5f1;}.sub-title{color:#000; font-weight:bold;text-align:left;padding-left:15px;padding-right: 15px;letter-spacing: 0.05em;width:100%}.small{color: #607D8B; !important}
hr {border: none;border-top: 1px double #333;color: #333;overflow: visible;text-align: center;height: 0px;padding-left:15px;padding-right:15px;margin-top: 0px;}

 body{
   font-family:"Calibri", "sans-serif";
}
/*footer{
    margin-top: auto;
}*/
.watermark{
  background:url("resources/images/fjwatermark.PNG") center center ;opacity:0.6; 
  position: absolute;
  width: 90%;
  height: 95%;
  background-repeat: no-repeat;
  background-position: bottom; 
}

/*.container::before {
  content: "";
  display: block;
  width: 100%;
  height: 100%;
  position: absolute;
  top: 0px;
  left: 0px;
  background-image: url("resources/images/fjwatermark.PNG");
  background-size: 100px 100px;
  background-position: 30px 30px;
  background-repeat: no-repeat;
  opacity: 0.7;
}
body:after {
  content: '';
  position: fixed;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  background: url('resources/images/fjwatermark.PNG');
  opacity: 0.3;
  pointer-events: none;
 background-position: center; 
}*/
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
    			printFrameDoc.document.write('<link rel="stylesheet" href="resources/css/certificates.css?v=1.1.22">');    		
                printFrameDoc.document.write('</head><body>');
                printFrameDoc.document.write(printArea); 
                printFrameDoc.document.write('</body>');    			
                printFrameDoc.document.write('</html>');
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
	 		  <h4 class="text-left">                   
	               <a href="homepage.jsp" > <i class="fa fa-home pull-right" title="Home"></i></a>  
	               <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a>                   
	          </h4>  	
	          </div>  

	    <section class="payslip col-xs-9 pull-right" >
	   	 <div class="watermark"></div>
	      <!-- title row -->
	      <div id="experienceCertificate-Box">
	      <div class="row" style="margin-left: auto;   margin-right: auto;">	      
	        <div class="col-xs-12" style="padding-left: 0px;">
	          <h2 style="margin-top:0px;margin-bottom:0px;"><img id="img" style="float: right;" width="100%"  src="signature.jsp?signtype=header"/></h2>
	        </div>
	        <!-- /.col -->
	      </div>      
	      <!-- info row -->
	      <div class="row" style="margin-left: auto;   margin-right: auto;"> 
	       <!--  <div class="col-sm-12 payslip-col pay-subtitle-parent">
	        	 <h4 class="sub-title" >Experience Certificate<small class="pull-right payslipDate"></small><br/></h4>
	        </div> -->
	      
		        <div class="col-xs-12" style="padding-bottom:2em">
		          <table>
		           <!-- <tr><td style="width:1%;">To</td><td style="width:25%;">: ${fjtuser.uname}</td></tr>
		           <tr><td style="width:1%;">From</td><td style="width:25%;">: HR Manager</td></tr> -->
		           <tr><td style="width:1%;"><b>Date</b></td><td style="width:25%;"><b>:</b> ${currCal}</td></tr>
		          <!--  <tr><td style="width:1%;">Subject</td><td style="width:25%;">: Experience Certificate</td></tr> -->
		           <tr><td style="width:1%;"><b>Reference</b></td><td style="width:25%;"><b>:</b> HR/HQ/EC${SALARYINFO.emp_end_of_service_dt == NULL ? '': EX}/${fjtuser.getEmp_com_code()}/<%=iYear %>/${fjtuser.emp_code}</td></tr>
		          </table>          
		        </div>	       
		    <h3 class="sub-title" >EMPLOYMENT CERTIFICATE<small class="pull-left"></small><br/> <hr>  </h3>
		   
	        <div class="col-sm-12 payslip-col" id="salarycertSummary">        
				To: Whom it may concern,<br/><br/>
				We hereby certify that the under mentioned employee 
				<c:choose>
					<c:when test ="${SALARYINFO.emp_end_of_service_dt == null || empty SALARYINFO.emp_end_of_service_dt}">
						is		
					</c:when>
					<c:otherwise>
						 has been	
					</c:otherwise>
				</c:choose>	
				 under employment of <b>${SALARYINFO.cost_center},</b>  a member of the FJ Group.<br/><br/>			
				<table>
					<tr><td style="width:2%;"><b>Name:</b></td><td style="width:25%;">	${fjtuser.uname}</td></tr>
					<tr><td style="width:2%;"><b>Nationality:</b>	</td><td style="width:25%;">${SALARYINFO.nationality}</td></tr>
					<tr><td style="width:2%;"><b>Passport No:</b></td><td style="width:25%;">	${SALARYINFO.passport_Number}</td></tr>
					<tr><td style="width:5%;"><b>Date of Employment:</b></td><td style="width:25%;">	<fmt:parseDate value="${SALARYINFO.join_date}" var="theDate"    pattern="yyyy-MM-dd HH:mm" />
												<fmt:formatDate value="${theDate}" pattern="dd/MM/yyyy"/></td></tr>
					<c:if test ="${!empty SALARYINFO.emp_end_of_service_dt}">
						<tr><td style="width:5%;"><b>End of Employment:</b></td><td style="width:25%;">	<fmt:parseDate value="${SALARYINFO.emp_end_of_service_dt}" var="theDate"    pattern="yyyy-MM-dd HH:mm" />
												<fmt:formatDate value="${theDate}" pattern="dd/MM/yyyy"/></td></tr>
					</c:if>							
					<tr><td style="width:2%;"><b>Designation:</b>	</td><td style="width:25%;">${SALARYINFO.designation}</td></tr>
					<tr><td style="width:2%;"><b>Business Unit:</b></td><td style="width:25%;">	${SALARYINFO.company_name}</td></tr>
					<tr><td style="width:2%;"><b>Place of work:</b></td><td style="width:25%;">	${SALARYINFO.jobLocation}<br/></td></tr>
				 </table> <br/>
				This certificate was issued upon the employee’s request without any liability on the Company.<br/><br/>
				
	        </div>   
	        <div class="col-sm-4 payslip-col" id="payslipSUmmary">
	         Best Regards,<br/>
		       <img width="100px" height="100px" src="signature.jsp?signtype=hrsign"/><br/>		      
		       Ann Ewing<br/>
			   HR Manager<br/>
		    </div>	 
	       <div class="col-xs-6 table-responsive" style="float:right;">				
	     		<img src="signature.jsp?signtype=footer&compCode=${SALARYINFO.cc_code}"/>
	        </div><br/><br/><br/>
	       <div class="col-sm-12" style="padding-top:60px;" id="salarycertSummary">
	     	 <b>Note:</b>
	     	 <c:choose>
				<c:when test ="${SALARYINFO.emp_end_of_service_dt == null || empty SALARYINFO.emp_end_of_service_dt}">
					This certificate is generated automatically and valid for one month only. Any correction or change will cease this certificate.<br/><br/><br/><br/><br/><br/><br/><br/>		
				</c:when>
				<c:otherwise>
					 This certificate is generated automatically. Any correction or change will cease this certificate.<br/><br/><br/><br/><br/><br/><br/><br/>
				</c:otherwise>
			</c:choose>	
									
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