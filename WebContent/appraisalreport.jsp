<%-- 
    Document   : Appraisal Report for GM Review
    Created on : Sep 18, 2018, 11:21:00 AM
    Author     : Nufail Achath
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
.navbar {
    
    margin-bottom: 8px !important;
    }
    

</style>
<%@include file="mainview.jsp" %>
	<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="resources/datatables/datatables-fjtco/css/jquery.dataTables.min.css" />
	<link rel="stylesheet" type="text/css" href="resources/datatables/buttons-fjtco/css/buttons.dataTables.min.css" />
	<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/dataTables.buttons.min.js"></script>
	<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.flash.min.js"></script>
	<script type="text/javascript" src="resources/datatables/ajax/excelmake/jszip.min.js"></script>
	<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.html5.min.js"></script>
	<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.print.min.js"></script>
   <style>
   
  h4 {
     color:#0066b3 !important;
     
  }
 
 
   .table{
    display: block !important;
    overflow-x:auto !important;
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

.table>tbody>tr>td{padding: 8px 5px !important;
    
    
   }
   
   
   .aprsl-dtls {
   
    background: white;
    padding: 3px;
    font-size: 65%;
    font-weight: bold;
}

div.dt-buttons { float: right; margin-top: -30px; }
.table>tbody>tr>td{ border: 1px solid #f3f3f3 !important;font-size:95% !important;}
table.dataTable thead th{ border: 1px solid #f3f3f3 !important;font-size:85% !important;}
    </style>
	<script>
	$( document ).ready(function() {
		document.getElementById('rval').value = document.getElementById('div_code_sel').value;
		document.getElementById('cval').value = document.getElementById('comp_code_sel').value;
	$('#div_code_sel').on('change', function() {
		var value1=this.value ;
		document.getElementById('rval').value=value1;
		});
	$('#div_code_sel').on('load', function() {
		var value1=this.value ;
		document.getElementById('rval').value=value1;
		});
	$('#comp_code_sel').on('change', function() {
		var value1=this.value ;
		document.getElementById('cval').value=value1;
		});
	$('#comp_code_sel').on('load', function() {
		var value1=this.value ;
		document.getElementById('cval').value=value1;
		});
	
	});
	</script>
</head>
      <c:choose>
       <c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1 and fjtuser.role eq 'hr'}"> 
	        
	      
 
 
 
 
 
 
 
 
 
 
 
 
 
    
<body>

      	 <div class="container">
  	
  		<div class="panel panel-default  small" >
                     <div class="panel-heading" style="padding:4px 8px !important;">
                        <h4 class="text-left">
                        Appraisal Report <a href="homepage.jsp" > <i class="fa fa-home pull-right" title="Home"></i></a>
                        <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a>
                        </h4>
                     </div>
                     </div>
    <div id="individual" class="fjtco-table" >
   

      

      
   
      <h4>Set Appraisal Report</h4>
            <div class="row">
          
        	<input type="hidden" id="fjtco" name="fjtco" value="list" />
        
        
         
            
            
           
            
           
      
    
       
      
        
        
        <div class="col-md-2">

       
                    <form method="post" id="theform">
                    <input type="hidden" name="fjtco" value="gdlfc" />
                        <select name="comp_code_sel" id="comp_code_sel" class="select_box"  style="width: 100% !important;" onchange="this.form.submit();" autocomplete="off">
                            <option value="" >Select Company</option>
                            <c:forEach var="companyLst" items="${CMPNY_LIST}">
                               
                                       <option value="${companyLst.d_c3}" ${companyLst.d_c3  == selected_cmp_code ? 'selected':''}> ${companyLst.d_c3}</option>

                   
                            </c:forEach>                         
                        </select>
                    </form>                   
                  </div> 
                  
                  
                  <div class="col-md-2">
                  
                   
                    <select name="div_code_sel" class="select_box" id="div_code_sel" style="width: 100% !important;" onchange="this.form.submit();" autocomplete="off">
                         <option value="" >Select Division</option>
                        <c:forEach var="divnLst" items="${DVN_LIST}">
                            
                                    <option value="${divnLst.d_c3}" ${divnLst.d_c3  == selected_divnLst ? 'selected':''}> ${divnLst.d_c3}</option>
                              
                        </c:forEach>                         
                    </select>
                </div>    
        
     
        
         <form name="rprt_frm" method="post" action="AppraisalReport">
            <div class="col-md-2 col-sm-4 col-xs-12">
            
               <select class="form-control form-control-sm" name="syr" id="syr" style="width: 100% !important;">
  						
  					<option value="" >Select Year</option>
   						<c:forEach var="sub1"  items="${APRYR}" >
   						<option value="${sub1.d_c3}" ${sub1.d_c3  == selected_apyear ? 'selected':''}> ${sub1.d_c3}</option>
					  	</c:forEach>				  	
					  	
						</select>
            </div>
        <input type="hidden" name="aprdivn" id ="rval" value="0">
        <input type="hidden" name="aprcmp" id ="cval" value="0">
        <input type="hidden" name="fjtco" id ="fjtco" value="fjaprslrprt">
         <div class="col-md-2 col-sm-4 col-xs-12">
                <input type="submit"   class="btn btn-primary" value="Process Report" name="save" id="save" />
               ${div_code_sel_for_rprt}
            </div>
        
        </form>
      
            			
       
        </div>  <br/> </div>  
        <c:if test="${HR_APPR_LIST ne null and !empty HR_APPR_LIST}">
        <div id="individual" class="fjtco-table" id="aprsl_report" >
      <h4>Appraisal Report List of ${selected_cmp_code}/${selected_divnLst} for ${selected_apyear}</h4>
        <table class="table table-striped" id="aprsl_report_table" >
  <thead class="small">
    <tr>
      <th scope="col">#</th>
      <th scope="col">Em. ID</th>
       <th scope="col">Emp. Name</th>
       <th scope="col">Designation</th>
      <th scope="col">Year</th>
      <th scope="col">Company</th>
      <th scope="col">Division</th>
      <th scope="col">Goal's Submission Status</th>
     
      <th scope="col">Goal's Approved</th>
      <th scope="col">Mid Term Submission Status</th>
     
      <th scope="col">Mid Term Approved</th>
      <th scope="col">Final Term Submission Status</th>
    
      <th scope="col">Final Term Approved</th>
      
    </tr>
  </thead>
  <tbody class="small">
   

        
        <c:set var="count" value="0" scope="page" />

          

        <c:forEach var="tempHrAppraisalList" items="${HR_APPR_LIST}">
        <c:set var="count" value="${count + 1}" scope="page" />
       
   
	
        <tr>
      <td scope="row">${count}</td>
      <td>${tempHrAppraisalList.emp_id}</td>
      <td>${tempHrAppraisalList.emp_name}</td>
      <td>${tempHrAppraisalList.designation}</td>
      <td>${tempHrAppraisalList.year}</td>
       <td>${tempHrAppraisalList.company}</td>
      <td>${tempHrAppraisalList.division}</td>
     
      
      <td>
      <c:if test="${tempHrAppraisalList.gs_submit_Status eq 'YES'}">
      <strong style="color:green;">Completed</strong>
      <div class="aprsl-dtls">Date : ${tempHrAppraisalList.gs_submit_date}</div> 
      </c:if>
      <c:if test="${tempHrAppraisalList.gs_submit_Status eq 'NO' or tempHrAppraisalList.gs_submit_Status eq null }"><strong style="color:red;">No Goals Set</strong></c:if>
      </td>
     
     
      <td> 
      
      <c:choose>
      <c:when test="${tempHrAppraisalList.gs_approved_Status eq 'YES'}">
      <strong style="color:green;">Done</strong>
      
      
     <div class="aprsl-dtls">Date : ${tempHrAppraisalList.gs_approved_date}
      <br/>By : ${tempHrAppraisalList.gs_appr_name}</div>
      </c:when>
      <c:when test="${tempHrAppraisalList.gs_approved_Status eq null and tempHrAppraisalList.mid_approved_Status eq 'YES'}"><strong style="color:red;">No</strong></c:when>
       <c:when test="${tempHrAppraisalList.gs_approved_Status eq null and tempHrAppraisalList.mid_approved_Status eq null}"><strong style="color:blue;">Pending</strong></c:when>
      
      </c:choose>
        
      </td>
      
      
       <td>
       
    <c:choose>
      <c:when test="${tempHrAppraisalList.mid_submit_status eq 'YES'}"><strong style="color:green;">Done</strong>
       <div class="aprsl-dtls">Date : ${tempHrAppraisalList.mid_submit_date} </div>
      
    
      </c:when>
      <c:when test="${tempHrAppraisalList.mid_submit_status eq null and tempHrAppraisalList.mid_approved_Status eq 'YES' or  tempHrAppraisalList.mid_submit_status eq null and tempHrAppraisalList.fin_approved_Status eq 'YES'}"><strong style="color:red;">No</strong></c:when>
       <c:when test="${tempHrAppraisalList.mid_submit_status eq null and tempHrAppraisalList.mid_approved_Status eq null}"><strong style="color:blue;">Pending</strong></c:when>
      
      </c:choose>
   
  
       
       
       
        
      </td>
       
       
    
     
      <td> 
      <c:choose>
      <c:when test="${tempHrAppraisalList.mid_approved_Status eq 'YES'}">
      <strong style="color:green;">Done</strong>
      
     
      <div class="aprsl-dtls">Date : ${tempHrAppraisalList.mid_approved_date}
      <br/>By :  ${tempHrAppraisalList.mid_appr_name} </div>
      </c:when>
      <c:when test="${tempHrAppraisalList.mid_approved_Status eq null and tempHrAppraisalList.fin_approved_Status eq 'YES'}"><strong style="color:red;">No</strong></c:when>
       <c:when test="${tempHrAppraisalList.mid_approved_Status eq null and tempHrAppraisalList.fin_approved_Status eq null}"><strong style="color:blue;">Pending</strong></c:when>
      
      </c:choose>
       
      
      </td>
      
      
    <td>
  <c:choose>
     <c:when test="${tempHrAppraisalList.fin_submit_status eq 'YES'}">
      <strong style="color:green;">Done</strong>
      
      <div class="aprsl-dtls">Date : ${tempHrAppraisalList.fin_submit_date}</div> 
     </c:when>
      
      <c:when test="${tempHrAppraisalList.fin_submit_status eq null and tempHrAppraisalList.fin_approved_Status eq null}">
     <strong style="color:blue;">Pending</strong></c:when>
     <c:when test="${tempHrAppraisalList.mid_approved_Status eq null and tempHrAppraisalList.fin_approved_Status eq 'YES'}">
     <strong style="color:red;">No</strong>
     </c:when>
       </c:choose>
    
    </td>
    
    
     
      <td>
      <c:choose>
      <c:when test="${tempHrAppraisalList.fin_approved_Status eq 'YES'}">
      <strong style="color:green;">Done</strong>
       <div class="aprsl-dtls">Date : ${tempHrAppraisalList.fin_approved_date}
      <br/>By :  ${tempHrAppraisalList.fin_appr_name} </div>
      </c:when>
      <c:when test="${tempHrAppraisalList.fin_approved_Status eq null and tempHrAppraisalList.mid_approved_Status eq 'YES'}"><strong style="color:red;">No</strong></c:when>
       <c:when test="${tempHrAppraisalList.fin_approved_Status eq null and tempHrAppraisalList.mid_approved_Status eq null}"><strong style="color:blue;">Pending</strong></c:when>
      
      </c:choose>
      
    
      
      
    
    </tr>
      
    
 
    
        </c:forEach>
   </tbody>
</table>

</div>
</c:if>

</div>

<script>
$(document).ready(function() {
	   $('#aprsl_report_table').DataTable( {
	        dom: 'Bfrtip',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-cloud-download" style="color: green; font-size: 2em;"></i>',
	                filename: "Appraisal Report List of ${selected_cmp_code}/${selected_divnLst} for ${selected_apyea}",
	                title: "Appraisal Report List of ${selected_cmp_code}/${selected_divnLst} for ${selected_apyear}",
	                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	          
	           
	        ]
	    } );
});
</script>
</body>
</c:when>
<c:otherwise>
    <html>
        <body onload="window.top.location.href='logout.jsp'">
        </body>
            
        </body>
    </html>
</c:otherwise>
</c:choose>
