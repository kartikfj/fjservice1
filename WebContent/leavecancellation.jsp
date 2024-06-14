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
        $("#fromdate").datepicker({ "dateFormat" : "dd/mm/yy", yearRange: "2020:2030", "minDate" : "-30D"}); 
        $("#todate").datepicker({"dateFormat" : "dd/mm/yy", yearRange: "2020:2030", "minDate" : "-30D"}); 
        $('#dltLeave').submit(function(evnt) {  		 
   		    var validation_01 = '${dijf}';  var validation_02 = '${dirp}'; var validation_03 = '${dipym}'; var validation_04 = '${typ}'; var validation_05 = '${empCd}';
   	    	var d1=document.forms["dltLeave"]["id_fj_02"].value;
   	    	var d2=document.forms["dltLeave"]["id_pr_03"].value;
   	    	var d3=document.forms["dltLeave"]["id_my_01"].value;
   	    	var d4=document.forms["dltLeave"]["lvType"].value;
   	    	var d5=document.forms["dltLeave"]["empCode"].value;
   	    	if( (validation_01 == d1 ) && (validation_02 == d2) && (validation_03 == d3) && (validation_04 == d4) && (validation_05 == d5) ){
   	    		if ((confirm('Are You sure, You Want to delete this leave!'))) { 
   	   			 preLoader();
   	   			 return true;
   	   			 }
   	   		 else{return false;}
   	    	}else{
   	    		alert("Something went wrong!. Please try again later");
   	    		return false;
   	    	}
   		});
    });
    function setDeafultToDate(){
    	$( "#todate" ).datepicker("option", "minDate", $("#fromdate").datepicker('getDate')); 	 
    }
    function preLoader(){ $('#laoding').show();}	
</script>

</head>
<body>

<div class="container" style="margin-top: -7px !important;">
   	<div class="container-fluid" style="margin-top: -2px !important;">
   	<div class="row" >
             
      
               		 <div class="panel panel-default  small" >
                     <div class="panel-heading" style="padding:4px 8px !important;">
                        <h4 class="text-center">Employee Leave Cancellation<span class="fa fa-file pull-right"></span>
                        <a href="homepage.jsp" > <i class="fa fa-home pull-right" title="Home"></i></a> 
					    <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a></h4>
                     </div>
                     </div>
    
<div  class="fjtco-table" >
<form  class="form-inline" method="post"> 

             <i class="fa fa-filter" style="font-size: 24px;color: #065685;"></i>
                 <input type="hidden" id="fjtco"  name="action" value="getLeaveDetails" />
                  <div class="form-group">
                <input  class="form-control form-control-sm"   maxlength="7" placeholder="Enter Employee Code"  type="text" id="empCode" name="empCode" autocomplete="off"  required/>
         </div>
                  
                  <div class="form-group">
                <input  class="form-control form-control-sm"   placeholder="Select Start Date"  type="text" id="fromdate" name="fromdate" onChange="setDeafultToDate();" autocomplete="off" readonly required/>
         </div>
            
            <div class="form-group">
                <input  class="form-control form-control-sm"    type="text" id="todate" placeholder="Select End Date" autocomplete="off"  name="todate" readonly required/>
           </div>
          
           
         

<div class="form-group" id="nmlstforrprt">  
  
<select class="form-control form-control-sm"  id="leave_type" name="leaveCat"  required>
     <option value="" >Select Leave Category</option>
     <option value="1" >LWP</option>
     <option value="2" >Other</option>
	
    
</select>

</div>
<div class="form-group">
<button type="submit" class="btn btn-primary" >Get Leave Details</button></div>
</form>
<c:if test="${!empty LV_DTLS}">
<div class="tb">
 

<table class='table table-bordered small' id="cancellation-table">
<thead><tr>


<th>Employee Name</th><th>Leave Type</th><th>Applied Date</th><th>From date</th><th>To Date</th>
<th>Reason</th><th>No: of Days</th><th>Action</th>

</tr></thead>

       <c:forEach var="REG_REP"  items="${LV_DTLS}" >
					   
			<tr>            
			<td>${REG_REP.uid}</td>
			<td>${REG_REP.type}</td>
			<td>
			<fmt:parseDate pattern="yyyy-MM-dd" value="${fn:substring(REG_REP.applied_dt, 0, 10)}" var="parsedDate" />
            <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy" />
			</td>
			<td>
			<fmt:parseDate pattern="yyyy-MM-dd" value="${REG_REP.fromDate}" var="parsedDate" />
            <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy" />
			</td>
			<td>
			<fmt:parseDate pattern="yyyy-MM-dd" value="${REG_REP.toDate}" var="parsedDate" />
            <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy" />
			</td>
			<td>${REG_REP.reason}</td>
			<td>${REG_REP.leave_days}</td>
			<td>
			<form method="POST"   id="dltLeave" name="dltLeave">
					 <input type="hidden" value="delete" name="action" />
				   	 <input type="hidden" value="" name="hrId" />
				   	 <input type="hidden" name="strtDt" value="${dateStart}" />
				   	 <input type="hidden" name="toDt" value="${dateTo}" />
				   	 <input type="hidden" name="reason" value="${REG_REP.reason}" />
				   	 <input type="hidden" name="lvCatg" value="${REG_REP.type}" />
				   	 <input type="hidden" name="empCode" value="${REG_REP.uid}" />
				   	 <input type="hidden" name="lvType" value="${typ}" />
				   	 <input type="hidden" name="id_my_01" value="${dipym}" />
				   	 <input type="hidden" name="id_fj_02" value="${dijf}" />
				   	 <input type="hidden" name="id_pr_03" value="${dirp}" />
				     <button type="submit"   class="btn btn-danger btn-xs"  >
					 <i class="fa fa-trash" aria-hidden="true"></i> Delete
					 </button> 	 
				   	 
		   </form>
		   </td>
			</tr>		   
	   </c:forEach>
	  </table> <br/>
	  </div>
	  </c:if>
	  <span class="message">${MSG}</span>
 </div>
</div>

</div></div>

<div id="laoding" class="loader" style="display:none;"><img src="././resources/images/wait.gif"></div> 

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
