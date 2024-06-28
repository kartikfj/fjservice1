 

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
	<link href="resources/css/jquery-ui.css" rel="stylesheet">
	<script src="resources/js/jquery-1.10.2.js"></script>
	<script src="resources/js/jquery-ui.js"></script>
	<script src="resources/js/appraisal.js"></script>
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

.table>tbody>tr>td{padding: 5px !important;
    
    
   }
   
   
   .aprsl-dtls {
   
    background: white;
    padding: 3px;
    font-size: 65%;
    font-weight: bold;
}
    </style>
	<script>
	$( document ).ready(function() {
		document.getElementById('rval').value = document.getElementById('div_code_sel').value;
	$('#div_code_sel').on('change', function() {
		var value1=this.value ;
		document.getElementById('rval').value=value1;
		});
	$('#div_code_sel').on('load', function() {
		var value1=this.value ;
		document.getElementById('rval').value=value1;
		});
	
	});
	</script>
</head>
<c:choose>
 <c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1 and fjtuser.role eq 'hr'}"> 
  <sql:query var="rs2" dataSource="jdbc/orclfjtcolocal">
            SELECT COMP_CODE FROM FJPORTAL.FM_COMPANY where COMP_FRZ_FLAG = 'N' order by COMP_CODE
        </sql:query>
         <sql:query var="rs5" dataSource="jdbc/fjco_local">
                     select  distinct year from appraisalhr_new  order by year desc
                    
                </sql:query>
        <c:choose>
        
            <c:when test="${pageContext.request.method != 'POST'}">
                <sql:query var="rs3" dataSource="jdbc/orclfjtcolocal">
                    SELECT distinct EMP_DIVN_CODE from FJPORTAL.PM_EMP_KEY where EMP_COMP_CODE=?
                    <sql:param>${rs2.rows[0].COMP_CODE}</sql:param>
                </sql:query> 
                
                 
            </c:when>
            <c:when test="${pageContext.request.method eq 'POST' and !empty param.comp_code_sel}">     
                <sql:query var="rs3" dataSource="jdbc/orclfjtcolocal">
                    SELECT distinct EMP_DIVN_CODE from FJPORTAL.PM_EMP_KEY where EMP_COMP_CODE=?
                    <sql:param>${param.comp_code_sel}</sql:param>
                </sql:query>       
            </c:when>
            <c:when test="${pageContext.request.method eq 'POST' and !empty param.compcode and !empty param.divcode}">     
                <sql:query var="rs3" dataSource="jdbc/orclfjtcolocal">
                    SELECT distinct EMP_DIVN_CODE from FJPORTAL.PM_EMP_KEY where EMP_COMP_CODE=?
                    <sql:param>${param.compcode}</sql:param>
                </sql:query> 
                <jsp:useBean id="aprslreport" class="utils.AppraisalReportDbUtil" scope="request"/>
                <jsp:setProperty name="aprslreport" property="compcode" param="compcode"/>
                <jsp:setProperty name="aprslreport" property="sectionCode" param="divcode"/>
               
            </c:when>
         
        
        </c:choose>
 
 
 
 
 
 
 
 
 
 
 
 
 
    
<body>

      	 <div class="container">
  	
  		<div class="panel panel-default  small" >
                     <div class="panel-heading" style="padding:4px 8px !important;">
                        <h4 class="text-center">
                        Attendance Status Report for Particular Day
                        </h4>
                     </div>
                     </div>
    <div id="individual" class="fjtco-table" >
   

        

      
   
      <h4>Set Company, Division & Date for Attendance Status Report</h4>
            <div class="row">
          
        	<input type="hidden" id="fjtco" name="fjtco" value="list" />
        
        
         
            
            
           
            
           
      
    
       
      
        
        
        <div class="col-md-2">

       
                    <form method="post" id="theform">
                    
                        <select name="comp_code_sel" class="select_box" id="comp_code_sel" style="width: 100% !important;" onchange="this.form.submit();" autocomplete="off">
                            <option value="" >Select Company</option>
                            <c:forEach var="current2" items="${rs2.rows}">
                                <c:choose>
                                    <c:when test="${!empty param.compcode and param.compcode eq current2.COMP_CODE}">
                                        <option value="${current2.COMP_CODE}" selected="selected">${current2.COMP_CODE}</option>
                                    </c:when>
                                    <c:when test="${!empty param.comp_code_sel and param.comp_code_sel eq current2.COMP_CODE}">
                                        <option value="${current2.COMP_CODE}" selected="selected">${current2.COMP_CODE}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${current2.COMP_CODE}">${current2.COMP_CODE}</option>
                                    </c:otherwise>
                                </c:choose>
                               
                            </c:forEach>                         
                        </select>
                    </form>                   
                  </div> 
                  
                  
                  <div class="col-md-2">
                 
                   
                    <select name="div_code_sel" class="select_box" id="div_code_sel" style="width: 100% !important;" onchange="this.form.submit();" autocomplete="off">
                         <option value="" >Select Division</option>
                        <c:forEach var="current3" items="${rs3.rows}">
                            <c:choose>
                                <c:when test="${!empty param.divcode and param.divcode eq current3.EMP_DIVN_CODE}">
                                    <option value="${current3.EMP_DIVN_CODE}" selected="selected">${current3.EMP_DIVN_CODE}</option>
                                </c:when>
                                <c:when test="${!empty param.div_code_sel and param.div_code_sel eq current3.EMP_DIVN_CODE}">
                                    <option value="${current3.EMP_DIVN_CODE}" selected="selected">${current3.EMP_DIVN_CODE}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${current3.EMP_DIVN_CODE}">${current3.EMP_DIVN_CODE}</option>
                                    
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>                         
                    </select>
                </div>    
        
     
        
         <form name="rprt_frm" method="post" action="AppraisalReport">
            <div class="col-md-2 col-sm-4 col-xs-12">
            
               <select class="form-control form-control-sm" name="syr" id="syr" style="width: 100% !important;">
  						
  					<option value="" >Select Year</option>
   						<c:forEach var="sub1"  items="${yearlist}" >
					  	<option value="${sub1.year}"> ${sub1.year}</option>
					  	</c:forEach>
					  	
					  	
					  	 <c:forEach var="current5" items="${rs5.rows}">
                                
                                      
                                        <option value="${current5.year}">${current5.year}</option>
                                   
                                
                            </c:forEach>   
					  	
					  	
					  	
					  	
						</select>
            </div>
        <input type="hidden" name="aprslreportval" id ="rval" value="0">
        <input type="hidden" name="fjtco" id ="fjtco" value="fjaprslrprt">
         <div class="col-md-2 col-sm-4 col-xs-12">
                <input type="submit"   class="btn btn-primary" value="Process Report" name="save" id="save" />
               ${div_code_sel_for_rprt}
            </div>
        
        </form>
      
            			
       
        </div>  <br/> </div>  
        
        <div id="individual" class="fjtco-table" id="aprsl_report" >
      <h4>Attendance Status Report</h4>
        <table class="table table-striped"  >
  <thead class="small">
    <tr>
      <th scope="col">#</th>
      <th  scope="col">Company</th>
      <th scope="col">EMP Code</th>
      <th scope="col">Employee Name</th>
      <th scope="col">Division</th>
      <th scope="col">Status</th>
      
    </tr>
  </thead>
  <tbody class="small">
   

        
        <c:set var="count" value="0" scope="page" />

         
      
       <c:forEach var="Alist" items="${ATTENDENCELIST}">
         <c:set var="count" value="${count + 1}" scope="page" />
       <tr> <td >${count}</td>
      <td>${Alist.emp_id}</td><td>${Alist.year}</td><td>${Alist.company}</td><td>${Alist.gs_appr_id}</td><td>${Alist.gs_appr_name}</td></tr>
       </c:forEach>
      

   </tbody>
</table>

</div>

</c:when>
<c:otherwise>
    <html>
        <body onload="window.top.location.href='logout.jsp'">
        </body>
            
        </body>
    </html>
</c:otherwise>
</c:choose>
