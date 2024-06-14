<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<style>
 .navbar {margin-bottom: 8px !important;}
 .panel-default>.panel-heading { background-color: #ffff !important; }
 h4 { color:#0066b3 !important; }
 .tb{ max-height: calc(100% - 200px); overflow-y: scroll; /*overflow-x: scroll;*/}
 #nmlstforrprt .open>.dropdown-menu {isplay: block; max-height: 314px !important;overflow-y: scroll;}

</style>
<%@include file="mainview.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<c:choose>
<c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1}">
<html>
<head>
<link href="resources/css/jquery-ui.css" rel="stylesheet">
<script src="resources/js/jquery-1.10.2.js"></script>
<script src="resources/js/jquery-ui.js"></script>
<link href="resources/css/regularisation_report.css" rel="stylesheet" type="text/css" />
<script src="resources/js/regularisation_report.js"></script>
<!--  <script src="http://cdn.rawgit.com/davidstutz/bootstrap-multiselect/master/dist/js/bootstrap-multiselect.js"
    type="text/javascript"></script>-->
    <style>
     .fjtco-table {
    /* background-color: #ffff; */
    background-color: #e5f0f7;
    padding: 0.01em 16px;
    margin: 20px 0;
    box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important;
    }</style>
<script type="text/javascript">

    $(function () {
        $('#regularisation_list').multiselect({
            includeSelectAllOption: true
        });
    });
    

	
    $(function () {
        $("#fromdate").datepicker();
        $("#fromdate").datepicker("option", "dateFormat", "yy-mm-dd");
    });
	function getSeletedval(){
		
		    var selectedValues = [];    
		    $("#regularisation_list :selected").each(function(){
		        selectedValues.push($(this).val()); 
		    });
		    return true;
		    //alert(selectedValues);
		   
		
	}
	 function selectAll(box) {
	        for(var i=0; i<box.length; i++) {
	            box.options[i].selected = true;
	        }
	    }
</script>

</head>
<body>

<div class="container" style="margin-top: -7px !important;">
   	<div class="container-fluid" style="margin-top: -2px !important;">
   	<div class="row" >
             
      
               		 <div class="panel panel-default  small" >
                     <div class="panel-heading" style="padding:4px 8px !important;">
                        <h4 class="text-center">S.Eng Attendance Report<span class="fa fa-file pull-right"></span></h4>
                     </div>
                     </div>
    
<div  class="fjtco-table" ><br/>
<form  class="form-inline" method="post" action="SEgAttendance"> 

             <i class="fa fa-filter" style="font-size: 24px;color: #065685;"></i>
                 <input type="hidden" id="fjtco" name="fjtco" value="report" />
                  <input type="hidden" id="uid" name="uid" value="E003006" />
                  <div class="form-group">
                <input  class="form-control form-control-sm"   placeholder="Select Start Date"  type="text" id="fromdate" name="fromdate" required/>
         </div>
            
            
          
           
         <div class="form-group" id="nmlstforrprt">  
  
<select class="form-control form-control-sm"  id="regularisation_list" multiple="multiple" name="slc" required>
   
    <c:forEach var="sub2"  items="${SUB_NAME_LIST}" >
					    <option value="'${sub2.sub_ord_id}'" ${sub2.sub_ord_id == selected_id ? 'selected':''} >${sub2.sub_ord_name}</option>
					   
	</c:forEach>
   
    
</select>
</div>
<div class="form-group">
<button type="submit" class="btn btn-primary"  onclick="getSeletedval();">Details</button></div>
</form>
<c:if test="${!empty R_R_LIST}">
<div class="tb">
<table class='table table-bordered small' >
<thead><tr>


<th>Employee Name</th><th>Applied Date</th><th>Date to Regularise</th><th>Reason</th>
<th>Authorised by</th><th>Status</th><th>Authorised date</th><th>Company</th><th>Project Code</th>

</tr></thead>

       <c:forEach var="REG_REP"  items="${R_R_LIST}" >
					   
			<tr>            
			<td>${REG_REP.uid}</td>
			<td>
			<fmt:parseDate pattern="yyyy-MM-dd" value="${fn:substring(REG_REP.applied_dt, 0, 10)}" var="parsedDate" />
            <fmt:formatDate value="${parsedDate}" pattern="MM/dd/yyyy" />${fn:substring(REG_REP.applied_dt, 10, 16)}
			</td>
			<td>${REG_REP.dt_to_regul}</td>
			<td>${REG_REP.reason}</td>
			<td>${REG_REP.authorized}</td>
		
			<td><c:choose >
				 		<c:when test="${REG_REP.status == '3'}">
				 		<b style="color: #dc3912;">Rejected</b>
				 		</c:when>
				 		<c:when test="${REG_REP.status == '4'}">
				 		<b style="color: #109618;">Approved</b>
				 		</c:when><c:when test="${REG_REP.status == '1'}">
				 		<b style="color: #337ab7;">Request Sent</b>
				 		</c:when>
				 		<c:otherwise>${REG_REP.status}
				 		</c:otherwise>
				</c:choose></td>
			<td>
			<fmt:parseDate pattern="yyyy-MM-dd" value="${REG_REP.authorized_dt}" var="parsedDate" />
            <fmt:formatDate value="${parsedDate}" pattern="MM/dd/yyyy" />
			</td>
			<td>${REG_REP.company}</td>
			<td>${REG_REP.project}</td>
			</tr>		   
	   </c:forEach>
	  </table> 
	  </div>
	  </c:if>
 </div>
</div>

</div></div></body></html>

</c:when>
<c:otherwise>
    <html>
        <body onload="window.top.location.href='logout.jsp'">
        </body>
            
        </body>
    </html>
</c:otherwise>
</c:choose>
