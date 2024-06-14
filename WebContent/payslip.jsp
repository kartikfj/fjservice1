<%-- 
    Document   : EMPLOYEE PAY SLIP  
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@include file="mainview.jsp" %>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.DateFormatSymbols"%>
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
.watermark{
  background:url("resources/images/watermarkforpayslip.PNG") center center ;opacity:0.6; 
  position: absolute;
  width: 90%;
  height: 100%;
  background-repeat: no-repeat;
  background-position: top; 
}
 
 
</style>
<script type="text/javascript">
/* function dowlnoadPaySlip(){ 	 
    var printArea = document.getElementById("paySlip-Box");
    var printWindow = window.open('', '', '');    
    // Add the stylesheet link and inline styles to the new document: 
    printWindow.document.write('<link rel="stylesheet" href="resources/css/payslip.css?v=1.0.9">');
    printWindow.document.write('<style type="text/css"></style>');   
    printWindow.document.write('</head><body >');
    printWindow.document.write(printArea.innerHTML);
    printWindow.document.write('</body></html>');
    printWindow.document.close();
    setTimeout(function () {
        printWindow.print();
    }, 500);
    return false; 
}
 */
function dowlnoadPaySlip(){ 	   
    
      		    var printArea = document.getElementById("paySlip-Box").innerHTML;
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
    			printFrameDoc.document.write('<link rel="stylesheet" href="resources/css/payslip.css?v=1.1.9">');
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
 
function validatePaySlip(){
	var syear = document.getElementById("syear").value;	
	var smonth = document.getElementById("smonth").value;
	var selectedDate = new Date(syear, smonth-1);	
	var minDate = new Date(); 
	minDate.setMonth(minDate.getMonth() - 4);		
	 if(selectedDate<minDate){
	 	alert("Playslip can be accessed for last 3 months only.");
	 return false;
	 }else 		
		 return true;
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
 		 <div class="row">
 		 <section class="col-xs-12" style="width:90%;">
 		 <form action="Payslip" method="POST" class="form-inline pull-right"  style="margin-right:15px;">
 		 	<select class="form-control form-control-sm" name="smonth" id="smonth"  required>
                  <%
                 // currentMonth = 1;
                  int mthStart = currentMonth; 
                  if(currentMonth > 3 ){mthStart = currentMonth-3;  }
                  else if(currentMonth == 2){mthStart = currentMonth-1; }
                  else if(currentMonth == 3){mthStart = currentMonth-2; }
                  if(currentMonth == 1){  %>   
                      <option value="10" ${selectedMonth  == 10 ? 'selected':''}>  <%=new DateFormatSymbols().getMonths()[10-1]%></option>    
                      <option value="11" ${selectedMonth  == 11 ? 'selected':''}>  <%=new DateFormatSymbols().getMonths()[11-1]%></option>       
                      <option value="12" ${selectedMonth  == 12 ? 'selected':''}>  <%=new DateFormatSymbols().getMonths()[12-1]%></option> 
                     <% 
                  }else if(currentMonth == 2){  %>          
                      <option value="11" ${selectedMonth  == 11 ? 'selected':''}>  <%=new DateFormatSymbols().getMonths()[11-1]%></option>       
                      <option value="12" ${selectedMonth  == 12 ? 'selected':''}>  <%=new DateFormatSymbols().getMonths()[12-1]%></option>
                      <option value="1" ${selectedMonth  == 1 ? 'selected':''}>  <%=new DateFormatSymbols().getMonths()[1-1]%></option>
                 <% 
                }else if(currentMonth == 2){  %>          
			              <option value="12" ${selectedMonth  == 12 ? 'selected':''}>  <%=new DateFormatSymbols().getMonths()[12-1]%></option>
			              <option value="2" ${selectedMonth  == 2 ? 'selected':''}>  <%=new DateFormatSymbols().getMonths()[2-1]%></option>
			              <option value="1" ${selectedMonth  == 1 ? 'selected':''}>  <%=new DateFormatSymbols().getMonths()[1-1]%></option>
		         <% }else if(currentMonth == 3){  %>          
			              <option value="12" ${selectedMonth  == 12 ? 'selected':''}>  <%=new DateFormatSymbols().getMonths()[12-1]%></option>
			              <option value="1" ${selectedMonth  == 1 ? 'selected':''}>  <%=new DateFormatSymbols().getMonths()[1-1]%></option>
			              <option value="2" ${selectedMonth  == 2 ? 'selected':''}>  <%=new DateFormatSymbols().getMonths()[2-1]%></option>			             
       					 <% }else{
		                	  for(int im=mthStart;im <= currentMonth-1;im++) { %>                  
                      <c:set var="ims" value="<%=im%>" /> 
                      <option value="<%=im%>" ${smonth  == ims ? 'selected':''} >  <%=new DateFormatSymbols().getMonths()[im-1]%></option>
                     <%
                     	}
                  }
                     %>                    
             </select>
             <select class="form-control form-control-sm" name="syear" id="syear" required>
              <% if(currentMonth <= 3){ 
            	  for(int iY=iYear-1;iY<= iYear;iY++) { 
              %>      <c:set var="sYr" value="<%=iY%>" />
             		  <option value="<%=iY%>" ${selectedYr  == sYr ? 'selected':''}><%=iY%></option>
             	<%	
            	  }
            	  }else{%> 
             		<option value="<%=iYear%>" selected="selected"><%=iYear%></option>
             	<%	}%> 
             </select>
  			<input type="hidden" name="fjtco" value="cust" />
   			<button type=submit" id="sf" class="btn btn-primary" onclick="return validatePaySlip()">View</button>
            </form>           
 		 </section>
 		  <div class="col-xs-12" style="width:10%;">
            <h4 class="text-right"> <a href="homepage.jsp" > <i class="fa fa-home pull-right" title="Home"></i></a>
            <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a> </h4>  
          </div>
    	<section class="payslip col-xs-9 pull-right" >
    	  <div class="watermark"></div> 
      <!-- title row -->
      <div id="paySlip-Box">
      <div class="row">
        <div class="col-xs-12">
          <h2 class="page-header"> ${companyName} <span class="pull-right"> Payslip</span> </h2>
        </div>
        <!-- /.col -->
      </div>
      <!-- info row -->
      <div class="row payslip-info"> 
        <div class="col-sm-12 payslip-col pay-subtitle-parent">
        	<h4 class="sub-title" >Payslip for the month of ${monthName}, ${selectedYr}<small class="pull-right payslipDate">Date: ${currCal}</small><br/></h4>
        </div>
        <div class="col-sm-5 payslip-col" id="payslipSUmmary">
        <h4 class="summary">EMPLOYEE SUMMARY</h4>
          <address>
          	<table class="table no-border">
          	<tr>
          		<td style="width:120px;">Employee Code</td><td style="padding:5px;"> : </td><td>${fjtuser.emp_code}</td>
          	</tr>
          	<tr>
          		<td style="width:120px;">Employee Name</td><td style="padding:5px;"> : </td><td>${fjtuser.uname}</td>
          	</tr>
          	<tr>
          		<td style="width:120px;">Division</td><td>:</td><td>${fjtuser.emp_divn_code}</td>
          	</tr>
          	<tr>
          		<td style="width:120px;">Designation</td><td>:</td><td>${fjtuser.designation}</td>
          	</tr>
          	</table>
          </address>
        </div>     
        <div class="col-xs-7 table-responsive">
        <h4 class="summary">PAY DETAILS</h4>
          <table class="table table-striped">
            <thead>
            <tr>
              <th>SL. No.</th>
              <th>Description</th>
              <th style="text-align:right;">Amount</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="pay_list"  items="${PAYSLIP}">
            <c:set var="count" value="${count + 1}" scope="page"/>
            <tr>
              <td>${count}</td>
              <td>${pay_list.description}</td>
              <td align="right"><fmt:formatNumber type="number"   groupingUsed="true" value="${pay_list.amount}" /></td>
            </tr>  
            </c:forEach>   
			
            <tr>          
              <td colspan="2" class="pay-total-title" >Total Net Payable</td>
              <td class="pay-total-amount" style="text-align:right"><fmt:formatNumber type="number" groupingUsed="true"   value="${NETPAY}" /></td>
            </tr>             
            </tbody>
          </table>
        </div> 
      </div>
      <!-- /.row -->
     </div>  
      <!-- this row will not appear when printing -->
      <div class="row no-print">
        <div class="col-xs-12">
          <button type="button" class="btn btn-sm btn-default  pull-left" style="margin-top: -20px;" onClick="dowlnoadPaySlip();">
            <i class="fa fa-download"></i> Download PDF
          </button>
        </div>
      </div> 
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