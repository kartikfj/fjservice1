<%-- 
    Document   : Appraisal Page for Each User 
--%>


<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="resources/css/responsive_appraisal_table.css" rel="stylesheet" type="text/css" />
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-glyphicons.css" rel="stylesheet" />
<script>
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip(); 
});
</script>
  <style>
  
  h4, .text-center {
     color:#065685 !important;
     text-style:bold  !important;
  }
  .panel-default>.panel-heading {
   
    background-color: #ffff !important;
    }
  
  .fjtco-table {
    background-color: #ffff;
    padding: 0.01em 16px;
    margin: 20px 0;
    box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important;
    }
  .row {
   margin-left: 0px;
   margin-right: 0px;
  }
  .panel-body {
    padding: 10px;
}
  .panel-heading {
    padding: 5px 10px !important;
    }
  .panel {
    margin-bottom: 5px;
    }
   .panel-default>.panel-heading{
    color: #333;
    background-color: #fff; 
    border-color: #065685;
   }
.navbar-brand {
  padding: 0px;
}
.navbar-brand>img {
  height: 100%;
  width: auto;
}
</style>
</head>
<c:choose>
<c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1}">
<body>
  
 			 <div class="row">	<!-- Individual goal start here -->	       
								
     							<div id="individual" class="fjtco-table">
     							<h4>Individual Goals - (Weightage 50%)</h4>
     							<table class="table table-striped small"><thead><tr><th>#</th><th>Goals</th><th>Target</th>
									
										
									            
							            <th>Goals Approved?</th>
										<th>Mid-Term Progress by Appraisee</th>
										<th>Mid-Term Review by Approver</th>
									
										<th>Mid-Term Completed?</th>
										<th>Final Appraisal Progress by Appraisee</th>
										<th>Final Appraisal Remarks by Approver</th>
										
										<th>Final Appraisal Completed?</th> 
								
									
									</tr>
									</thead>
									<tbody >
										

          
          <c:set var="icount" value="0" scope="page" />
          <c:set var="gs_type_i" value="individual" scope="page" />
        <c:forEach var="tgl_i" items="${FT_GOAL_LIST}">
        
       <c:if test ="${tgl_i.goal_type == gs_type_i}"  >
		<c:set var="icount" value="${icount + 1}" scope="page" />
      					 <tr>
							      <th scope="row">${icount}</th>
							      <td><span id="g">
							       <textarea rows="4" cols="40" readonly name="fjgroup">  ${tgl_i.goal}</textarea>
							    
							      
							      
							      </span></td>
							     
							      <td> <textarea rows="4" cols="30" readonly name="fjgroup">${tgl_i.target}</textarea></td>
							      
							   
                    <td>
                     <c:choose >
		 		<c:when test="${tgl_i.gs_approved == 'YES'}">
		 		<span data-toggle="tooltip"  data-html="true" title="<em>Approved on: <u> ${tgl_i.gs_apprddate}
				 	 </u></em> <br/> <em>Approved by: <u>  ${fjtuser_app_name.uname}" style="color:green;" 
				 	 class="glyphicon glyphicon-ok icon-success"></span>
		 		
		 		</c:when>
		 		<c:when test="${tgl_i.gs_approved == 'NO'}">
		 		<span data-toggle="tooltip" title=" ${tgl_i.gs_apprddate} - ${fjtuser_app_name.uname}" style="color:red;" class="glyphicon glyphicon-remove icon-remove"></span>
		 		
		 		</c:when>
				</c:choose>
                   </td>
                    <td><textarea rows="4" cols="30" readonly name="fjgroup">${tgl_i.mdprogress}</textarea></td>
			        <td>${tgl_i.mdprogressA}</td>
			       
                    
                 <td> <c:choose >
		 		<c:when test="${tgl_i.mid_approved == 'YES'}">
		 		<span data-toggle="tooltip"  data-html="true" title="<em>Approved on: <u> ${tgl_i.mid_apprddate}
				 	 </u></em> <br/> <em>Approved by: <u>  ${fjtuser_app_name.uname}" style="color:green;" 
				 	 class="glyphicon glyphicon-ok icon-success"></span>
		 		</c:when>
		 		<c:when test="${tgl_i.mid_approved == 'NO'}">
		 		<span data-toggle="tooltip" title=" ${tgl_i.mid_apprddate} - ${fjtuser_app_name.uname}" style="color:red;" class="glyphicon glyphicon-remove icon-remove"></span>
		 		</c:when>
				</c:choose>
				</td>
				<td><textarea rows="4" cols="30" readonly name="fjgroup">${tgl_i.finalap}</textarea></td>
			       
			        <td>${tgl_i.finalapA}</td>
			        
				 <td> <c:choose >
		 		<c:when test="${tgl_i.fin_approved == 'YES'}">
		 		<span data-toggle="tooltip"  data-html="true" title="<em>Approved on: <u> ${tgl_s.fin_apprddate}
				 	 </u></em> <br/> <em>Approved by: <u>  ${fjtuser_app_name.uname}" style="color:green;" 
				 	 class="glyphicon glyphicon-ok icon-success"></span>
		 		
		 		</c:when>
		 		<c:when test="${tgl_i.fin_approved == 'NO'}">
		 		<span data-toggle="tooltip" title=" ${tgl_i.fin_apprddate} - ${fjtuser_app_name.uname}" style="color:red;" class="glyphicon glyphicon-remove icon-remove"></span>
		 		</c:when>
		        <c:otherwise>
		 		 
				</c:otherwise>
				</c:choose>
						        	
		
		 
    </tr>
  
  
  
  
  
 
		
    </c:if>
        </c:forEach>
									</tbody>
									</table>
								</div>
					  			   <!-- Strategic goal start here -->
					  			   <div id="strategic"  class="fjtco-table">
					  			   <h4>Strategic Goals - (Weightage 50%) </h4>         

					       			    <table class="table table-striped small">
										<thead>
										<tr>
										<th>#</th><th>Goals</th><th>Target</th>
										
										
							            <th>Goals Approved?</th>
										<th>Mid-Term Progress by Appraisee</th>
										<th>Mid-Term Review by Approver</th>
										
										<th>Mid-Term Completed?</th>
										<th>Final Appraisal Progress by Appraisee</th>
										<th>Final Appraisal Remarks by Approver</th>
										
										<th>Final Appraisal Completed?</th> 
									
									
									</tr>
									</thead>
									<tbody >
									
									
							  <c:set var="scount" value="0" scope="page" />
					          <c:set var="gs_type_s" value="strategic" scope="page" />
					          <c:forEach var="tgl_s" items="${FT_GOAL_LIST}">
					          <c:if test = "${tgl_s.goal_type == gs_type_s}">
                              <c:set var="scount" value="${scount + 1 }" scope="page" />
		
       						 <tr>
							      <th scope="row">${scount}</th>
							      <td><span id="g"><textarea rows="4" cols="40" readonly name="fjgroup">${tgl_s.goal}</textarea></span></td>
							      <td><textarea rows="4" cols="30" readonly name="fjgroup">${tgl_s.target}</textarea></td>
							      
							    
        
        
        			
                    <td>
                     <c:choose >
		 		<c:when test="${tgl_s.gs_approved == 'YES'}">
		 		<span data-toggle="tooltip" title=" ${tgl_s.gs_apprddate} - ${fjtuser_app_name.uname}" style="color:green;" class="glyphicon glyphicon-ok icon-success"></span>
		 		
		 		</c:when>
		 		<c:when test="${tgl_s.gs_approved == 'NO'}">
		 		<span data-toggle="tooltip" title=" ${tgl_s.gs_apprddate} - ${fjtuser_app_name.uname}" style="color:red;" class="glyphicon glyphicon-remove icon-remove"></span>
		 		
		 		</c:when>
				</c:choose>
                   </td>
                    <td><textarea rows="4" cols="30" readonly name="fjgroup">${tgl_s.mdprogress}</textarea></td>
			        <td>${tgl_s.mdprogressA}</td>
			        
                    
                 <td> <c:choose >
		 		<c:when test="${tgl_s.mid_approved == 'YES'}">
		 		<span data-toggle="tooltip"  data-html="true" title="<em>Approved on: <u> ${tgl_s.mid_apprddate}
				 	 </u></em> <br/> <em>Approved by: <u>  ${fjtuser_app_name.uname}" style="color:green;" 
				 	 class="glyphicon glyphicon-ok icon-success"></span>
		 		
		 		</c:when>
		 		<c:when test="${tgl_s.mid_approved == 'NO'}">
		 		<span data-toggle="tooltip" title=" ${tgl_s.mid_apprddate} - ${fjtuser_app_name.uname}" style="color:red;" class="glyphicon glyphicon-remove icon-remove"></span>
		 		</c:when>
				</c:choose>
				</td>
				<td><textarea rows="4" cols="30" readonly name="fjgroup">${tgl_s.finalap}</textarea></td>
			      
			        <td>${tgl_s.finalapA}</td>
			        
				 <td> <c:choose >
		 		<c:when test="${tgl_s.fin_approved == 'YES'}">
		 		<span data-toggle="tooltip"  data-html="true" title="<em>Approved on: <u> ${tgl_s.fin_apprddate}</u></em> <br/> <em>Approved by: <u>  ${fjtuser_app_name.uname}" style="color:green;" 
				 	 class="glyphicon glyphicon-ok icon-success"></span>
		 		
		 		</c:when>
		 		<c:when test="${tgl_s.fin_approved == 'NO'}">
		 		<span data-toggle="tooltip" title=" ${tgl_s.fin_apprddate} - ${fjtuser_app_name.uname}" style="color:red;" class="glyphicon glyphicon-remove icon-remove"></span>
		 		</c:when>
		        <c:otherwise>
		 		
				</c:otherwise>
				</c:choose></td>
						        	
		
		 
    </tr>
   
    </c:if>
        </c:forEach>
								
								</tbody>
								</table>
								</div><!--  strategic close here -->
		
					
     			<div id="achievement" class="fjtco-table" >
     							<h4>Additional Achievements / Responsibilities (Appraisee)</h4>
							      <table class="table table-striped small">
									<thead>
									<tr ><th colspan="1">#</th> <th>Achievements</th>
									
									</tr>
									</thead>
						<c:set var="acount" value="0" scope="page" />
				        <c:forEach var="tal" items="${ACHV}">
									<c:set var="acount" value="${acount + 1}" scope="page" />
									<tr>
								    <th scope="row">${acount}</th>
									<td  colspan="5">${tal.achievement}</td>
									</tr>
						</c:forEach>
						
							
						</table>
						<br/>
						</div>
						<div id="review" class="fjtco-table" >
	
     							<h4>Employee Evaluation</h4>
     							<table class="table table-striped small">
									<thead>
									<thead>
									<tr>
									<th>Comments</th><th>Rating</th>
									<th>Final Appraisal Sign/Off</th>
									
									</tr>
									</thead>
									<tbody >
									<tr>
									<tr>
									<td>${OVERVIEW.strength}</td>
									
									<td>
									<c:choose>
									<c:when test="${OVERVIEW.rating eq 1}"><strong>Outstanding</strong></c:when>
									<c:when test="${OVERVIEW.rating eq 2}"><strong>Successful</strong></c:when>
									<c:when test="${OVERVIEW.rating eq 3}"><strong>Needs Improvement</strong></c:when>
									<c:otherwise></c:otherwise>
									</c:choose></td>
									
									<td>
									<c:choose>
									<c:when test="${OVERVIEW.sign_off eq 'YES'}">
									
									<span data-toggle="tooltip"  data-html="true" title="<em>Sign Off by: <u> 
									 ${OVERVIEW.appr_id}</u></em>" style="color:green;" class="glyphicon glyphicon-ok icon-success"></span>
									</c:when>
									<c:otherwise></c:otherwise>
									</c:choose>
									</td>
									</tr>
										</tbody></table>
			
			
	
      		</div>

		
		

</div>


</body>
</html>
</c:when>
<c:otherwise>
    <html>
        <body onload="window.top.location.href='logout.jsp'">
        </body>
            
        </body>
    </html>
</c:otherwise>
</c:choose>
