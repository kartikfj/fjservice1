<%-- 
    Document   : leaveappln 
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="mainview.jsp" %>
<%@page import="java.util.concurrent.ConcurrentHashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.DateFormatSymbols"%>
<c:choose>
    <c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1}">     
    <jsp:useBean id="experiencecert" class="beans.ExperienceCertificate" scope="request"/>
<%
  DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
  Calendar cal = Calendar.getInstance();
  int currentMonth = cal.get(Calendar.MONTH)+1;  
  int iYear = cal.get(Calendar.YEAR);   
  String currCalDtTime = dateFormat.format(cal.getTime()).substring(0, 10);
  request.setAttribute("currCal", currCalDtTime);
 
 %>
       
        <!DOCTYPE html>
        <head>
            <link href="resources/css/jquery-ui.css" rel="stylesheet">
            <script src="resources/js/jquery-1.10.2.js"></script>
            <script src="resources/js/jquery-ui.js"></script>
            <script src="resources/js/leaveapplication.js?v=15062022"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script> 
            <link rel="stylesheet" type="text/css" href="resources/datatables/datatables-fjtco/css/jquery.dataTables.min.css" />
			<link rel="stylesheet" type="text/css" href="resources/datatables/buttons-fjtco/css/buttons.dataTables.min.css" />
			<link rel="stylesheet" type="text/css" href="resources/datatables/datatables-fjtco/css/select.dataTables.min.css" />
			<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/jquery.dataTables.min.js"></script>
			<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/dataTables.buttons.min.js"></script>
			<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/dataTables.select.min.js"></script> 
          <style type="text/css">
    /* Original CSS styles */
    .page-header { color: #065685; font-weight: bold; border-bottom: 2px solid #065685 !important; text-transform: uppercase; letter-spacing: 0.1em; }
    .payslip { position: relative; background: #fff; border: 1px solid #b9b8b8; padding: 20px; margin: 10px 25px; }
    .pay-subtitle-parent { margin-top: -15px; }
    .payslip-col > .sub-title { background: #daf0f3; padding: 7px 5px; }
    .info-box-content { margin-top: 20%; }
    .info-box-text { text-transform: uppercase; font-weight: bold; }
    .pay-total-title { color: red; font-weight: bold; text-align: center; }
    .pay-total-amount { font-weight: bold; }
    .summary { color: #009688; font-weight: bold; border-bottom: 1px dashed #bbc5f1; }
    .sub-title { color: #000; font-weight: bold; text-align: left; letter-spacing: 0.05em; padding-left: 15px; padding-right: 15px; }
    .small { color: #607D8B !important; }
    hr {
      /*   border: none;
        border-top: 1px double #333;
        color: #333;
        overflow: visible;
        text-align: center;
        height: 0px;
        padding-left: 15px;
        padding-right: 15px;
        margin-top: 0px; */
    }
    body {
        font-family: "Calibri", "sans-serif";
    }
    .watermark {
        background: url("resources/images/fjwatermark.PNG") center center; opacity: 0.6;
        position: absolute;
        width: 90%;
        height: 100%;
        background-repeat: no-repeat;
        background-position: bottom;
    }
   /*  .cmnFld, th.cmnFld > input { max-width: max-content !important; width: 0px !important; }
    .slid, th.slid > input { max-width: 10px !important; width: 10px !important; }
    .cmnFld, th.cmnFld > input { max-width: max-content !important; width: 60px !important; }
    .divnStyltd { width: 30px !important; } */
    .dtlsHeader:hover span.dtlsContent, .dtlsHeader:hover span.lg_dtlsContent {
        display: block; width: 250px; word-wrap: break-word; white-space: normal;
    }

    /* Additional styles for printing */
    @media print {
        body {
            font-family: "Calibri", "sans-serif";
            color: #000 !important; /* Change font color to black for printing */
        }
        .page-header, .summary, .sub-title {
            color: #000 !important; /* Change font color to black for headers and titles */
        }
        .payslip {
            margin: 10mm; /* Increase margin for left side */
            padding: 10mm; /* Increase padding for content */
        }
        .watermark {
            display: none; /* Hide watermark for printing */
        }
    }
</style>

<script>
function downloadSalaryCertificate(empCode) {
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
    printFrameDoc.document.write('</head><body>');
    printFrameDoc.document.write(printArea);
    printFrameDoc.document.write('</body></html>');
    printFrameDoc.document.close();
    setTimeout(function () {
        window.frames["printFrame"].focus();
        window.frames["printFrame"].print();
        document.body.removeChild(printFrame);
    }, 500);
    return false;
}
</script>
          
        </head>
        <div class="container">        
        	<section class="col-xs-12" style="width:90%;"> 		
	 		 </section> 	
	 		  <h4 class="text-left">                   
	               <a href="homepage.jsp" > <i class="fa fa-home pull-right" title="Home"></i></a>  
	               <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a>                   
	          </h4> 
            <div class="rest_box1">
                <c:choose>
                    <c:when test="${pageContext.request.method eq 'POST'}">
                    <jsp:useBean id="currentapp" class="beans.ExperienceCertificate" scope="request"/>                           
                            <jsp:setProperty name="currentapp" property="emp_code" value="${param.emp_code}"/>
                            <c:set var="empDetails" value="${currentapp.salaryCertificateData}"/> 
                              <c:choose>
                              <c:when test="${!empty empDetails}">              
									<section class="payslip col-xs-9 pull-right" >
									 <div class="watermark"></div>
									      <!-- title row -->
									      <div id="experienceCertificate-Box">
									      <div class="row" style="margin-left: auto;margin-right: auto;">
									        <div class="col-xs-12">
									          <h2 style="margin-top:0px;margin-bottom:0px;"><img id="img" style="float: right;" width="100%" src="signature.jsp?signtype=header"/></h2>
									        </div>
									        <!-- /.col -->
									      </div>      
									      <!-- info row -->
									      <div class="row" style="margin-left: auto;margin-right: auto;"> 
									       <!--  <div class="col-sm-12 payslip-col pay-subtitle-parent">
									        	 <h4 class="sub-title" >Experience Certificate<small class="pull-right payslipDate"></small><br/></h4>
									        </div> -->
									      
										        <div class="col-xs-12" style="padding-bottom:2em">
										          <table>
										           <!-- <tr><td style="width:1%;">To</td><td style="width:25%;">: ${fjtuser.uname}</td></tr>
										           <tr><td style="width:1%;">From</td><td style="width:25%;">: HR Manager</td></tr> -->
										           <tr><td style="width:1%;"><b>Date</b></td><td style="width:25%;"><b>:</b> ${currCal}</td></tr>
										          <!--  <tr><td style="width:1%;">Subject</td><td style="width:25%;">: Experience Certificate</td></tr> -->
										           <tr><td style="width:1%;"><b>Reference</b></td><td style="width:25%;"><b>:</b> HR/HQ/EC${empDetails.emp_end_of_service_dt == NULL ? '': 'EX'}/${empDetails.getEmp_com_code()}/<%=iYear %>/${empDetails.emp_code}</td></tr>
										          </table>          
										        </div>	       
										    <h3 class="sub-title" >EMPLOYMENT CERTIFICATE<small class="pull-left"></small><br/> <hr>  </h3>
										   
									        <div class="col-sm-12 payslip-col" id="salarycertSummary">        
												To: Whom it may concern,<br/><br/>
												We hereby certify that the under mentioned employee 
												<c:choose>
													<c:when test ="${empDetails.emp_end_of_service_dt == null || empty empDetails.emp_end_of_service_dt}">
														 is	
													</c:when>
													<c:otherwise>
														has been	
													</c:otherwise>
												</c:choose>	
												 under employment of <b>${empDetails.cost_center},</b>  a member of the FJ Group.<br/><br/>			
												<table>
													<tr><td style="width:2%;"><b>Name:</b></td><td style="width:25%;">	${empDetails.name}</td></tr>
													<tr><td style="width:2%;"><b>Nationality:</b>	</td><td style="width:25%;">${empDetails.nationality}</td></tr>
													<tr><td style="width:2%;"><b>Passport No:</b></td><td style="width:25%;">	${empDetails.passport_Number}</td></tr>
													<tr><td style="width:5%;"><b>Date of Employment:</b></td><td style="width:25%;">	<fmt:parseDate value="${empDetails.join_date}" var="theDate"    pattern="yyyy-MM-dd HH:mm" />
																				<fmt:formatDate value="${theDate}" pattern="dd/MM/yyyy"/></td></tr>
												    <c:if test ="${!empty empDetails.emp_end_of_service_dt}">
															<tr><td style="width:5%;"><b>End of Employment:</b></td><td style="width:25%;">	<fmt:parseDate value="${empDetails.emp_end_of_service_dt}" var="theDate"    pattern="yyyy-MM-dd HH:mm" />
																					<fmt:formatDate value="${theDate}" pattern="dd/MM/yyyy"/></td></tr>
													</c:if>	
													<tr><td style="width:2%;"><b>Designation:</b>	</td><td style="width:25%;">${empDetails.designation}</td></tr>
													<tr><td style="width:2%;"><b>Business Unit:</b></td><td style="width:25%;">	${empDetails.company_name}</td></tr>
													<tr><td style="width:2%;"><b>Place of work:</b></td><td style="width:25%;">	${empDetails.jobLocation}<br/></td></tr>
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
									     		<img  src="signature.jsp?signtype=footer&compCode=${empDetails.cc_code}"/>
									        </div><br/><br/><br/><br/>
									       <div class="col-sm-12" style="padding-top:60px" id="salarycertSummary">
									     	 <b>Note:</b>
													 <c:choose>
														<c:when test ="${empDetails.emp_end_of_service_dt == null || empty empDetails.emp_end_of_service_dt}">
															This certificate is generated automatically and valid for one month only. Any correction or change will cease this certificate.<br/><br/><br/><br/><br/><br/><br/><br/>		
														</c:when>
														<c:otherwise>
															 This certificate is generated automatically. Any correction or change will cease this certificate.<br/><br/><br/><br/><br/><br/><br/><br/>
														</c:otherwise>
													</c:choose>	
													<c:if test ="${empty empDetails.emp_end_of_service_dt}">
													<br/>
													</c:if>
											 </div>  
											  <div class="col-sm-12" id="salarycertSummary"> 
												<footer style="Margin:0;padding-bottom:30px;margin:0;text-align:center;border-top: 1px solid black;">				 			
														FJ Group, P.O. Box: 1871, Dubai, United Arab Emirates, TEL: +971 4810 5105					
												  </footer> 	
											  </div>											
									      </div>      <!-- /.row --> 
									       
									     </div>  
									      <!-- this row will not appear when printing -->
									      <div class="row no-print">
									        <div class="col-xs-12">
									          <button type="button" class="btn btn-sm btn-default  pull-left" style="margin-top: 10px;" onClick="downloadSalaryCertificate('${empDetails.emp_code}');">
									            <i class="fa fa-download"></i> Download PDF
									          </button>
									        </div>
									      </div>
									      
									    </section>
                           </c:when>
                           <c:otherwise>
                           <!--  <form method="POST" action="experienceCert.jsp">  
	                         <jsp:setProperty name="experiencecert" property="emp_code" param="emp_code"/> 
	                            <div class="l_one">	                               
                               	  <div class="n_text_narrow" id="frdt_label">Emp Code<span>*</span>&nbsp;&nbsp;<span style="text-decoration:none; color: red">Invalid User/They don't have this feature.</span></div> 
                               	  <input type="hidden" name="subtype" value="" id="subtype" /> 
                                  <input type="text" style="width:15%" class="leave_text" id="emp_code" name="emp_code" tabindex="1" required="required">                                  
                                  <input name="applybutton" type="submit" value="Submit" class="sbt_btn" />
                                 </div>
                             </form>   -->                        	
                           </c:otherwise>
                           </c:choose>
                        

                    </c:when>
                    <c:otherwise>                        	                          	                         
	                         <form method="POST" id="experienceCert" action="experienceCert.jsp">  
	                         <jsp:setProperty name="experiencecert" property="emp_code" param="emp_code"/> 
                               	  <input type="hidden" name="emp_code" value="" id="employee_code" /> 
                             </form>
				                 <div class="box-body padding" style="/*display:flex;*/">	         
					              <table class="table table-bordered small bordered display"  id="displayPos" style="display:none;">
					                
					                <thead>
					           
					                <tr>
					                  <th class="slid">Comp Code</th> 
					                  <th class="slid">Division</th> 
					                  <th class="slid">Emp ID</th> 
					                  <th class="cmnFld">Emp Name</th>
					                  <th class="slid">Designation</th> 
					                  <th class="cmnFld">Action</th>
					                </tr>
					                </thead>
					                <tbody>
						                <c:forEach var="request" items="${empDetails}" >
						                <c:set var="rqstscount" value="${rqstscount + 1}" scope="page" />
						                <tr>		                
						                  <td class="divnStyltd dtlsHeader">${request.emp_comp_code}</td>   
						                  <td class="divnStyltd dtlsHeader">${request.division}</td>   
						                   <td class="divnStyltd dtlsHeader">${request.emp_code}</td>
						                  <td class="divnStyltd dtlsHeader">${request.name}</td>
						                  <td class="divnStyltd dtlsHeader">${request.designation}</td>		                   
						                  <td style="width:5px"><input type="button" value="Open Certificate" onclick="openExperienceCert('${request.emp_code}','${request.emp_comp_code}');"/></td>  
						                </tr>
						               </c:forEach>      
					              </tbody></table>
					             
					            </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="att_searchbox">             
            </div>            
        </div>   


        <div class="clear"></div>
    </body>
</html>
</c:when>
<c:otherwise>
    <html>
        <body onload="window.top.location.href = 'logout.jsp'">
        </body>

    </body>
</html>
</c:otherwise>
</c:choose>