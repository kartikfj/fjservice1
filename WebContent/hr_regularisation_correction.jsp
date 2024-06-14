<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<style>
 .navbar {margin-bottom: 8px !important;}
 .panel-default>.panel-heading { background-color: #ffff !important; }
 h4 { color:#0066b3 !important; }
   
</style>
<%@include file="mainview.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<c:choose>
<c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1 and ( fjtuser.role eq 'hr' or fjtuser.role eq 'hrmgr' )}" >
<html>
<head>
		<link href="resources/css/jquery-ui.css" rel="stylesheet">
		<script src="resources/js/jquery-1.10.2.js"></script>
		<script src="resources/js/jquery-ui.js"></script> 
		<script src="resources/js/backendRegultn.js?v=3"></script>  
    <style> 
     .loader {position: fixed; z-index: 999; height: 2em;width: 2em;overflow: show; margin: auto; top: 0;left: 0;bottom: 0; right: 0;}
.loader:before { content: '';display: block;position: fixed;top: 0; left: 0;width: 100%; height: 100%; background-color: rgba(0,0,0,0.3);}
    .table>thead>tr>th {color: #fff;
    background-color: #000;}
#leveRprt-table_wrapper{margin-top:-17px;}.message{text-align:center;}
    </style>

<script type="text/javascript">
//TO AVOID RE-SUBMISSION START
if ( window.history.replaceState ) {
        window.history.replaceState( null, null, window.location.href );
    }
//TO AVOID RE-SUBMISSION END   	
    $(function () { 
    	 $('#laoding').hide();
    	 setFields();
        $("#datetoregularise").datepicker({ "dateFormat" : "dd/mm/yy", yearRange: "2022:2030", "minDate" : "-40D",  maxDate: '-4D'});  
        $('#regForm').submit(function(evnt) {  	
   	    	var d1=document.forms["regForm"]["empCode"].value;
   	    	var d2=document.forms["regForm"]["datetoregularise"].value;
   	    	var d3=document.forms["regForm"]["reason"].value; 
   	    	if( checkValidOrNot(d1) && checkValidOrNot(d2) && checkValidOrNot(d3) ){
   	    		if ((confirm('Are You sure, You Want to send regularisation request...? System will send automated regularisation email request to employee Manager / Approver!'))) { 
   	   			 preLoader();
   	   			 return false;
   	   			 }
   	   		 else{return false;}
   	    	}else{
   	    		$('#laoding').hide();
   	    		alert("Please fill all details");
   	    		return false;
   	    	}
   		});
         
    });
    function setDeafultToDate(){
    	$( "#todate" ).datepicker("option", "minDate", $("#fromdate").datepicker('getDate')); 	 
    } 
</script>

</head>
<body>
<c:set var="data" value="${REGOUT}" scope="page" /> 
<div class="container" style="margin-top: -7px !important;">
   	<div class="container-fluid" style="margin-top: -2px !important;">
   	<div class="row" >
             
      
               		 <div class="panel panel-default  small" >
                     <div class="panel-heading" style="padding:4px 8px !important;">
                        <h4 class="text-center">Regularisation Correction<span class="fa fa-file pull-right"></span>
                        <a href="homepage.jsp" > <i class="fa fa-home pull-right" title="Home"></i></a> 
					    <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a>
                        </h4>
                     </div>
                     </div>
    
<div  class="fjtco-table" >
<form  class="form-inline" method="post" id="regForm"> 

             <i class="fa fa-filter" style="font-size: 24px;color: #065685;"></i>
                 <input type="hidden" id="fjtco"  name="action" value="getRegDetails" />
                  <div class="form-group">
                <input  class="form-control form-control-sm"   maxlength="7" placeholder="Enter Employee Code"  type="text" id="empCode" name="empCode" autocomplete="off"  onblur="return checkUid(this);" onkeypress="verifyEnter(event);"  required/>
         </div>
                  
                  <div class="form-group">
                <input  class="form-control form-control-sm"   placeholder="Select Date to Regularise"  type="text" id="datetoregularise" name="datetoregularise" onChange="setDeafultToDate();" autocomplete="off" readonly required/>
         </div> 
		<div class="form-group" id="nmlstforrprt">  
		  <textarea rows="1" class="form-control form-control-sm"  id="reason" name="reason" placeholder="Reason" required></textarea> 
		
		</div>
<div class="form-group">
<button type="submit" class="btn btn-primary" >Regularise</button></div>
</form>

<div id="validEmpDetails"></div>
<c:if test="${!empty data}">
<div class="tb"> 
<table class='table table-bordered small' id="cancellation-table">
<thead><tr><th>Employee</th>
<c:if test="${data.optnStatus eq 1 }"><th>Approver</th></c:if>
<th>Date To Regularise</th><th>Reason</th> <th>Status</th> </tr></thead> 	   
			<tr>            
			<td> 
			<c:choose>
			<c:when test="${data.optnStatus ne 1 }">${data.employeeCode}</c:when>
			<c:otherwise> ${data.employeeName} </c:otherwise>
			</c:choose> 
			</td>
			<c:if test="${data.optnStatus eq 1 }"><td>${data.approverName}</td> </c:if>
			<td>
			<fmt:parseDate pattern="dd/MM/yyyy" value="${data.dateToRegularise}" var="dateToRegularise" />
            <fmt:formatDate value="${dateToRegularise}" pattern="dd/MM/yyyy" />
			</td> 
			<td>${data.reason}</td>
			<td>
			<c:choose>
			<c:when test="${data.optnStatus eq 1 }"><b class="text-success">${data.optnMessage}</b></c:when>
			<c:otherwise><b class="text-danger">${data.optnMessage}</b></c:otherwise>
			</c:choose> 	
			</td> 
			</tr>		 
	  </table> <br/>
	  </div>
	  </c:if>
	  
 </div>
</div>

</div></div>

<div id="laoding" class="loader" ><img src="././resources/images/wait.gif"></div> 

</body></html>

</c:when>
<c:otherwise>
    <html>
        <body onload="window.top.location.href='logout.jsp'">
        </body>
            
        </body>
    </html>
</c:otherwise>
</c:choose>
