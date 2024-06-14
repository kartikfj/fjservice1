<%-- 
    Document   : Sales Order Budget Approval  
--%>
	<%@page contentType="text/html" pageEncoding="UTF-8"%>
	<%@include file="mainview.jsp"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
	<!DOCTYPE html>
	<html>
	<head>
	<link rel="stylesheet" href="resources/bower_components/font-awesome/css/font-awesome.min.css">
	<!-- Theme style -->
	<link rel="stylesheet" href="resources/dist/css/AdminLTE.min.css">
	<link rel="stylesheet" href="resources/dist/css/skins/_all-skins.min.css">
	<style>
	.box{position: relative;border-radius:3px;background:#2196f31c;border-top:3px solid #065685;margin-bottom: 20px; width: 100%; box-shadow: 0 1px 1px rgba(0,0,0,0.1);}#sorqst>tbody>tr>th,#sorqst>tbody>tr>td,#sorqst>thead>tr>th{ border-top: 1px solid #065685;}.sodtls{border: 1px solid #065685;margin-top: 5px;background: white;padding:7px;} .sodtls table td {font-size: 85%; padding: 5px;  border: none;}
	.row{margin-left:-15px;margin-right:-15px;}.Hdngexps0{color:#dd4b39; font-family:monospace;font-style: italic;font-weight: bold;text-transform: uppercase;}.b0xexps0{margin-left: -15px;border-left: 2px dashed #065685;}.b0xexps0 table tboady tr td{border-bottom:1px solid blue;}.Hdngexps0tr{border-bottom: 1px solid #607D8B;}#sodtls{border: 1px solid #065685; background: white;}#sodtls td {font-size: 85%; padding: 5px;  border: none;}
	.box-title{font-weight: bold;color: black;text-transform: uppercase;}
	.refresh{font-size:21px;cursor: pointer;}.home{font-size:24px;cursor: pointer;}.home-refresh{padding: 3px; margin-top: -7px;   margin-right: -7px;}
	@media ( max-width : 375px) {.box-header .box-title{font-size: 82% !important;}.b0xexps0{margin-left: 0px  !important;border-left: none !important;}.refresh{font-size:18px;cursor: pointer;}.home{font-size:20px;cursor: pointer;}}

	</style>
    </head>
    <c:choose>
	<c:when test="${!empty fjtuser.emp_code and fjtuser.checkValidSession eq 1 }">
	<body>
		<div class="container" style="margin-top: -30px;"><br/>
		<div class="row">
        <div class="col-xs-12">
        <div class="box">
	    <div class="box-header">
	         
	        <h3 class="text-left" >Sales Order Budget Approval Requests 
		         <a href="homepage.jsp" class="home"> <i class="fa fa-home pull-right" title="Home"></i></a>
		         <a href="SOBudgetController.jsp" class="refresh"> <i class="fa fa-refresh pull-right"></i></a>
		         <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a>
	        
	        </h3>
		</div>
        <!-- /.box-header -->            
        <div class="box-body table-responsive no-padding">
        <c:choose>
        <c:when test="${NUSOBR ne null && !empty NUSOBR}">
        <table class="table table-hover" id="sorqst">
        <c:set var="lcount" value="0"/>
        <tr> <th>#</th>  <th>Sales Order No:</th> <th>Details</th> <th>Current Status</th>  <th>Action</th> </tr>
        <c:forEach var="sobdg_list"  items="${NUSOBR}" >
        <tr><c:set var="lcount" value="${lcount + 1 }"/>
        <td>${lcount}</td><td> ${sobdg_list.so_code} - ${sobdg_list.so_number}</td>
        <td> 
        <!-- SO Details Btn Start-->
		<a type="button" class="btn btn-info btn-xs" data-toggle="collapse" data-target="#details${lcount}">SO Details <span class="caret"></span></a>
		<!-- SO Details Btn End-->
		<div id="details${lcount}" class="collapse" style="width: 115% !important;"> 
		
		<c:choose>		
		<c:when test="${sobdg_list.budgetExpencDtls eq null or empty sobdg_list.budgetExpencDtls}">
           <table id="sodtls">
		   <tr><td colspan="3" style="padding:4px;"></td></tr> 
		   <tr> <td><b>Sales Order No</b></td><td> <b>:</b> </td><td> ${sobdg_list.so_code} - ${sobdg_list.so_number}</td></tr> 
		   <tr><td><b>Customer Code </b> </td><td><b> :</b> </td><td>${sobdg_list.customer_code} </td></tr> 
		   <tr><td><b>Customer Name  </b> </td><td><b> :</b> </td><td> ${sobdg_list.customer_name} </td></tr>
		   <tr><td><b>Payment Term  </b> </td><td><b> :</b> </td><td> ${sobdg_list.so_term} </td></tr> 
		   <tr><td><b>Project  </b> </td><td><b> :</b> </td><td>  <span style="color:#0089cd;font-weight: bold;">  ${sobdg_list.project}</span></td></tr> 
		   <tr><td><b>Sales Engineer </b> </td><td><b> :</b> </td><td>  <span style="color:#0089cd;font-weight: bold;">  ${sobdg_list.se_code} -  ${sobdg_list.se_name}</span></td></tr> 
		   <tr><td><b>Total Sales Value </b> </td><td><b> :</b> </td><td>  <fmt:formatNumber pattern='#,###' value='${sobdg_list.total_value}' /> </td></tr> 
		   <tr><td><b>Budgeted Cost </b> </td><td><b> :</b> </td><td> <fmt:formatNumber pattern='#,###' value='${sobdg_list.budget_value}' />  </td></tr> 
		   <tr><td><b>Gross Profit </b> </td><td><b> :</b> </td><td> <fmt:formatNumber pattern='#,###' value='${sobdg_list.profit_amt}' /> </td></tr> 
		   <tr><td><b>Profit % </b> </td><td><b> :</b> </td><td> <span style="color:#0089cd;font-weight: bold;">${sobdg_list.profit_perc}  </span> </td></tr> 
		   <tr><td colspan="3" align="center" bgcolor="#065685" style="padding:3px 0px;color:#fff;"> Sales  Order Budget Submitted on : ${sobdg_list.create_dtime}</td></tr>
		   <tr><td colspan="3" style="padding:4px;"></td></tr>  
		   </table>
        </c:when>        
        <c:otherwise>
        <div class="row  sodtls">
            <div class="col-md-8 col-sm-12">
			<table>
			<tr><td colspan="3" style="padding:4px;"></td></tr> 
			<tr><td><b>Sales Order No</b></td><td> <b>:</b> </td><td> ${sobdg_list.so_code} - ${sobdg_list.so_number}</td></tr> 
			<tr><td><b>Customer Code </b> </td><td><b> :</b> </td><td>${sobdg_list.customer_code} </td></tr> 
			<tr><td><b>Customer Name  </b> </td><td><b> :</b> </td><td> ${sobdg_list.customer_name} </td></tr> 
			<tr><td><b>Payment Term  </b> </td><td><b> :</b> </td><td> ${sobdg_list.so_term} </td></tr> 
			<tr><td><b>Project  </b> </td><td><b> :</b> </td><td>  <span style="color:#0089cd;font-weight: bold;">  ${sobdg_list.project}</span></td></tr> 
			<tr><td><b>Sales Engineer </b> </td><td><b> :</b> </td><td>  <span style="color:#0089cd;font-weight: bold;">  ${sobdg_list.se_code} -  ${sobdg_list.se_name}</span></td></tr>
			<tr><td><b>Total Sales Value </b> </td><td><b> :</b> </td><td>  <fmt:formatNumber pattern='#,###' value='${sobdg_list.total_value}' /> </td></tr> 
			<tr><td><b>Budgeted Cost </b> </td><td><b> :</b> </td><td>   <fmt:formatNumber pattern='#,###' value='${sobdg_list.budget_value}' /> </td></tr> 
			<tr><td><b>Gross Profit </b> </td><td><b> :</b> </td><td> <fmt:formatNumber pattern='#,###' value='${sobdg_list.profit_amt}' /> </td></tr> 
			<tr><td><b>Profit % </b> </td><td><b> :</b> </td><td> <span style="color:#0089cd;font-weight: bold;">${sobdg_list.profit_perc}  </span> </td></tr> 
			<tr><td colspan="3" align="center" bgcolor="#065685" style="padding:5px 5px;color:#fff;"> Sales  Order Budget Submitted on : ${sobdg_list.create_dtime}</td></tr>
			<tr><td colspan="3" style="padding:4px;"></td></tr>  
			</table>				  
		    </div>
		    <div class="col-md-4 col-sm-12 b0xexps0">				 
		    <table> 
			<tr> <th colspan="3" align="center" class="Hdngexps0"> SO Budget Expense Details</th></tr>
			<tr class="Hdngexps0tr"> <th> Expense</th><th>Details</th><th>Amount</th> </tr>
			<c:set var="sobdgExpnsTtl" value="0" scope="page" />
			<c:forEach var="sobd"  items="${sobdg_list.budgetExpencDtls}" >
			<c:set var="sobdgExpnsTtl" value="${sobdgExpnsTtl + sobd.sobd_3}" scope="page" />
			<tr><td> ${sobd.sobd_1} </td><td> ${sobd.sobd_2} </td><td align="right"> <fmt:formatNumber pattern='#,###' value='${sobd.sobd_3}' /> </td> </tr>
			</c:forEach>
			<tr style="border-top:1px solid black;"><td colspan="2" align="right" ><strong>Total :</strong></td><td align="right"><strong><fmt:formatNumber pattern='#,###' value='${sobdgExpnsTtl}' /> </strong></td>
		 	</table>
			</div>				
  		</div>
		</c:otherwise>
		</c:choose>
 		</div>
        </td>
        <td>
            <c:if test="${sobdg_list.so_aprv_status eq null }"> <span class="label label-warning">Pending</span></c:if>
            <c:if test="${sobdg_list.so_aprv_status eq 'N' }"> <span class="label label-danger">Rejected</span></c:if>  
         </td>
         <td>
         <!-- Approval and  reject access only ,if the sales order is not approved or rejected till now, ie the sales order aprvl status is pending (none) -->
            <c:if test="${sobdg_list.so_aprv_status eq null }">
          	<form action="SOBudgetController.jsp" method="POST" style="display: inline !important;" name="so_approve">
	   		<input type="hidden" value="${sobdg_list.so_sys_id}" name="diqinu" />  <input type="hidden" value="${sobdg_list.so_code}" name="docos" />
	   		<input type="hidden" value="${sobdg_list.so_number}" name="umnos" />   <input type="hidden" name="octjf" value="evorppa" />
	     	<button type="submit" id="sd"  class="btn btn-success btn-xs"  onclick="if (!(confirm('Are You sure You Want to Approve this SO Budget !'))) return false" ><span class="fa fa-check"  ></span>
			<span>Approve</span> </button>
		    </form>
			<form action="SOBudgetController.jsp" method="POST" style="display: inline !important;" name="so_reject">
	   		<input type="hidden" value="${sobdg_list.so_sys_id}" name="diqinu" />    <input type="hidden" value="${sobdg_list.so_code}" name="docos" />
	   		<input type="hidden" value="${sobdg_list.so_number}" name="umnos" />     <input type="hidden" name="octjf" value="tcejer" />
	     	<button type="submit" id="sd"  class="btn btn-danger btn-xs"  onclick="if (!(confirm('Are You sure You Want to Reject this SO Budget !'))) return false" ><span class="fa fa-remove"  ></span>
			<span>Reject</span> </button>
			</form>
			</c:if>
		 </td>
         </tr>
         </c:forEach> 
         </table>
         </c:when>
         <c:otherwise> <center>No SO Budget Requests Available</center><br/></c:otherwise>
         </c:choose>
         ${MSG} 
         </div>
         <!-- /.box-body -->
          </div>
          <!-- /.box -->
          </div>
          </div>								
		  </div>
		  <!-- /.content-wrapper -->						
	      <!-- /.container -->
	</c:when>
	<c:otherwise>
		<body onload="window.top.location.href='logout.jsp'">
		</body>
	</c:otherwise>
	</c:choose>
</html>