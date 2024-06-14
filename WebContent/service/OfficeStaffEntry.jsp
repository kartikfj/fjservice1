<%-- 
    Document   : PUMP SERVICE PORTAL , FIELD STAFF ENTRY APGE 
--%>
<%@include file="/service/header.jsp" %>
<style>
#viewAssitanttable tbody  td, #viewAssitanttable thead th, #viewAssitanttable thead td{border: 1px solid #1979a9 !important; }
</style>
<body class="hold-transition skin-blue sidebar-mini sidebar-collapse sidebar-mini">
 <c:if test="${empty fjtuser.emp_code}"> <jsp:forward page="index.jsp"/> </c:if>
 <c:choose>
 <c:when test="${!empty fjtuser.emp_code and fjtuser.checkValidSession eq 1}">
  <c:set var="controller" value="ServiceController" scope="page" />
<div class="wrapper">
  <header class="main-header">
    <!-- Logo -->
    <a href="homepage.jsp" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>FJ</b>S</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg">
         <i class="fa fa-edit"></i> <b>FJ-Services</b>
      </span>
    </a>
    <!-- Header Navbar  -->
    <nav class="navbar navbar-static-top">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>

      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
  
          <li class="dropdown user user-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-user-circle"></i>
              <span class="hidden-xs">${fjtuser.uname}</span>
            </a>
          
          </li>
           <%--Settings--%>
          <li class="dropdown notifications-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-gears"></i>
            </a>
            <ul class="dropdown-menu">
              <li class="header"><a  href="logout.jsp"> <i class="fa fa-power-off"></i> Log-Out</a></li>      
            </ul>
          </li>
          
        </ul>
      </div>
    </nav>
  </header>
  <!-- Left side column  -->
  <aside class="main-sidebar">
    <!-- sidebar  -->
    <section class="sidebar">
      <!-- Sidebar user panel --> 
      <!-- sidebar menu  -->
      <ul class="sidebar-menu" data-widget="tree">
      	 <c:if test="${USRTYP eq 'VU' or USRTYP eq 'MU'  or USRTYP eq 'OU'}">
      	 <li><a href="ServiceReports"><i class="fa fa-dashboard"></i><span>Reports</span></a></li>
      	 </c:if>
         <li class="active"><a href="${controller}"><i class="fa fa-dashboard"></i><span>Service Requests</span></a></li>            
         <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>      
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>Service Requests <small>Service Portal</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="homepage.jsp"><i class="fa fa-calendar"></i> Home</a></li>
        <li class="active">Service Portal</li>
      </ol>
    </section>   
    <!-- Main content -->	    
	    <%--Office Staff Entry Section Start--%>
	    <section class="content">
	    <c:set var="vstcount" value="0" scope="page" />
	    <c:set var="ttlFE" value="0" scope="page" />
	    <c:set var="ttlFA" value="0" scope="page" />
	     <div class="row">
	     <div class="col-xs-12 pull-right entry-btn-div">
	         <c:if test="${SRVSRQST.fldStatus eq 1 and (SRVSRQST.finalStatus eq 0 or SRVSRQST.finalStatus eq 2) and SRVSRQST.officeUserId eq fjtuser.emp_code}"> 
	     	  <button type="button" class="btn btn-sm btn-primary pull-right" id="btn-cnfrmation" data-toggle="modal" data-target="#modal-officestaff" onClick="clearFields()">
               <i class="fa fa-plus"></i>Update Status
              </button> 
	        </c:if>
	        <div id="message-block">
		        <div class="alert alert-info alert-dismissible">
		        	<button type="button" class="close cls-btn-cust" data-dismiss="alert" aria-hidden="true" >×</button>
		            <span id="msg-text"></span>
		        </div>
	        </div>
	      </div>
	    </div>
	    <%-- TABLUAR DETAILS START --%>
	    <div class="row">
	     <div class="col-md-12 col-xs-12 pull-right"> 
          <div class="box box-warning">
            <div class="box-header fld-entry-dtls">
              <h3 class="box-title">Request Details</h3>
              <div class="box-tools pull-right">
                <button type="button" class="btn bg-black btn-sm" data-widget="collapse"><i class="fa fa-minus"></i>
                </button> 
              </div>
              </div> 
            <!-- /.box-header --> 
            <div class="box-body table-responsive">
              <table class="table table-bordered small bordered" style="display:flex;">
                <tbody> 
                <tr>
                  <td colspan="2"><strong>Project Code : </strong>${SRVSRQST.soCodeNo}</td>
                </tr><tr>
                  <td colspan="2"><strong>Project : </strong>${SRVSRQST.projectName}</td>
                </tr><tr>                 
                  <td><strong>Customer : </strong>${SRVSRQST.customer}</td> <td><strong>Consultant : </strong>${SRVSRQST.consultant}</td>
                 </tr>
                 <tr>                 
                  <td><strong>Visit Type : </strong>${SRVSRQST.visitType}</td><td><strong>Location : </strong>${SRVSRQST.location}</td>
                </tr><tr>                     
                  <td><strong>Created By : </strong>${SRVSRQST.officeUserName}</td>  <td><strong>Field User : </strong>${SRVSRQST.fieldUserName}</td> 
                </tr><tr>                   
                 <td><strong>Est. Material Cost : </strong>${SRVSRQST.materialCost}</td>
                 <td><strong>Act. Material Cost : </strong> <span id="amctext">${SRVSRQST.actMaterialCost}</span></td>
                </tr>
                <tr>                  
                  <td><strong>Est. Labor Cost : </strong>${SRVSRQST.laborCost}</td>
                  <td><strong>Act. Labor Cost : </strong><span id="alctext">${SRVSRQST.actLaborCost}</span></td>
                </tr>
                <tr>                  
                  <td><strong>Est. Other Cost : </strong>${SRVSRQST.otherCost}</td>
                   <td><strong>Act. Other Cost : </strong><span id="aoctext">${SRVSRQST.actOtherCost}</span></td>
                </tr>
                <tr>                  
                  <td><strong>Intl. Remarks : </strong>${SRVSRQST.ofcInitialRemarks}</td>
                  <td><strong>Final Remarks : </strong><span id="afrtext">${SRVSRQST.ofcFinalRemarks}</span></td>
                </tr> 
                <tr>                  
                  <td><strong>Total Est. Cost : </strong>${SRVSRQST.totalEstCost}</td> 
                   <td><strong>Total Act. Cost : </strong><span id="atctext">${SRVSRQST.totalActCost}</span></td>
                </tr>
                  <tr>                  
                  <td colspan="2">
                  <strong>Total Service Hours : </strong> 
                  <b>
                     <fmt:formatNumber var="totalServiceHrs" type="number" minFractionDigits="2" maxFractionDigits="2" value="${SRVSRQST.totalServiceMinutes/60}" /> 
	                  ${totalServiceHrs}
                  </b>
                             
                  </td>
                </tr>  
                 <tr>                  
                  <td colspan="2">
                  <strong>System Calculated Total Labor Cost : </strong> 
                  <b>${SRVSRQST.totalServiceLaborExpense} </b>                             
                  </td>
                </tr>       
                   <tr>                  
                  <td colspan="2"><strong>Created On : </strong> 
                  <fmt:parseDate value="${SRVSRQST.createdDate}" var="theCrtdDate"  dateStyle="short"   pattern="yyyy-MM-dd HH:mm" />
		           <c:choose>
		           <c:when test="${SRVSRQST.fldStatus eq 0}">
		           	<b style="color:red;"><fmt:formatDate value="${theCrtdDate}" pattern="dd/MM/yyyy HH:mm"/></b>
		           </c:when>
		           <c:otherwise>
		            <b style="color:blue;"><fmt:formatDate value="${theCrtdDate}" pattern="dd/MM/yyyy HH:mm"/></b>
		           </c:otherwise>
		           </c:choose>               
                  </td>
                </tr>         
              </tbody></table>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
      </div>
	  <%-- TABULAR DETAILS END --%>     
	    <%-- TABLUAR DETAILS START --%>
	   <div class="row">
        <div class="col-xs-12">
          <div class="box box-warning">
            <div class="box-header fld-entry-dtls">
              <h3 class="box-title">Visit Details</h3>
              <div class="box-tools pull-right">
                <button type="button" class="btn bg-black btn-sm" data-widget="collapse" ><i class="fa fa-minus"></i>
                </button> 
              </div>
              </div> 
            <!-- /.box-header --> 
            <div class="box-body table-responsive  padding"  style="display:flex;">
              <table class="table table-bordered small bordered" id="fld-entry-lists" style="display:flex;">
                <tbody>
                <tr>
                  <th style="width: 10px">#</th>
                  <th>Visit Date</th>
                  <th>Chk. In-Out</th>
                  <th>No. Of Site Visitors</th>
                  <th>Field Remarks</th>
                  <th>Field Status</th>  
                </tr>   
                <c:forEach var="visits" items="${FLDVSTLSTS}">
                <c:set var="vstcount" value="${vstcount + 1}" scope="page" />
                <c:set var="ttlFE" value="0" scope="page" />
	    		<c:set var="ttlFA" value="0" scope="page" />
                <tr>
                  <td>${vstcount}</td>
                  <td>
                     <fmt:parseDate value="${visits.visitDate}" var="theVisitDate"  dateStyle="short"   pattern="yyyy-MM-dd HH:mm" />
		         	 <fmt:formatDate value="${theVisitDate}" pattern="dd/MM/yyyy"/>
                  </td>
                  <td>${visits.checkin} - ${visits.checkout}</td>
                  <td>
                  	  <c:choose>
                  	<c:when test="${visits.noOfAssistants gt 0}">
                  		<strong>${visits.noOfAssistants}</strong> <span class="btn"  onclick="viewAssitantVisit('${visits.fldVstId}', this);">   <i class="fa fa-2x fa-arrow-circle-o-right text-primary" ></i> </span>
                  	</c:when>
                  	<c:otherwise>
                  		 ${visits.noOfAssistants}
                  	</c:otherwise>
                  </c:choose>              
                   </td>
                  <td>${visits.fieldRemark}</td>
                  <td>
                   <c:choose>
                   	<c:when test="${visits.fldVisitStatus eq 1}"><span class="label label-success">Completed</span></c:when>
                   	<c:otherwise><span class="label label-danger">Not Completed</span></c:otherwise>
                   </c:choose>  
                  </td> 
                </tr> 
               </c:forEach>      
              </tbody></table>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
      </div>
	  <%-- TABULAR DETAILS END --%>	  
	     <div class="modal fade" id="modal-officestaff" data-backdrop="static" data-keyboard="false">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header etry-vst-modal-header">
                <button type="button" class="close cls-btn-cust" data-dismiss="modal" aria-label="Close">
                  	<span aria-hidden="true">&times;</span></button>
                	<h4 class="modal-title">Update Service Request Status</h4>
              </div>
              <div class="modal-body">
                <form id="vstEntry" name="vstEntry">
                <div class="box-body">
           		<div class="row"> 
					<div class="form-group col-xs-12 tpm">
				             <label>Final Remarks</label>
				             <textarea class="form-control" rows="2" placeholder="Enter Remarks..."  name="remarks" id="remarks" style="width:100%" required></textarea>
               			</div>  
					</div> 
					<div class="row"> 
					<h4 class="cost-div">Actual Cost for Service (AED)</h4> 
				    <div class="form-group col-xs-3 tpm"> 
							<label>Material</label>
			      			<input type="number" class="form-control floatNumberField" id="materialCost" step=".01"  min="0" name="materialCost" value="0" style="width:100px" required>	
					</div> 
					<div class="form-group col-xs-3  tpm"> 
							<label>Labor</label>
			      			<input type="number" class="form-control floatNumberField" id="laborCost" step=".01"  min="0" name="laborCost" value="0"  style="width:100px" required>
					</div>
					<div class="form-group col-xs-3 tpm"> 
							<label>Others</label>
			      			<input type="number" class="form-control floatNumberField" id="otherCost" step=".01"  min="0" name="otherCost" value="0"  style="width:100px" required>
					 </div>
					</div> 
					<div class="row"> 
						<div class="form-group col-sm-12 tpm"> 
							<select class="form-control form-control-sm" id="wrkngStatus" name="wrkngStatus">
							    <option value="" >Select Status</option>
							    <option value="1" >Completed</option>
							    <option value="2" >Return to Field Staff</option>
							</select>
					    </div>  	
				   </div>
				   <div class="row"> 
						<div class="form-group col-sm-12 tpm">
				            <span class="small pull-left" id="err-msg"></span>	
				        </div>
				   </div>						                  
               <!-- /.modal body --> 
              <div class="row srvc-form-footer">
              	<div class="col-xs-12">
	                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">Close</button>
	                <button type="submit" id="sbmtVst" class="btn btn-primary pull-right">Submit</button>
                </div>
              </div>
              <div id="laoding_ststus" class="loader" ><img src="././resources/images/wait.gif"></div>
              </div>
              </form>  
              </div>
            </div>
            <!-- /.modal-content -->
          </div>
          <!-- /.modal-dialog -->
        </div>
        <!-- /.modal -->
	     
	     	<div class="row">
					<div class="modal fade" id="fldVstAsstntDtls" role="dialog" >
				        <div class="modal-dialog" style="width:max-content;">
					     		<!-- Modal content-->
							      	<div class="modal-content">
								        	<div class="modal-header">
								         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
								          		<h4 class="modal-title">Field Assistant Visit Details </h4>
								        	</div>
								        	<div class="modal-body"> </div>
									        <div class="modal-footer">
									          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									        </div>
								     </div>								     								     
						   	 </div>   	 		   	 
		 			</div>	  
	</div>
	    </section>
	    <%--Office Staff Entry Section End --%>	     
    
    <div id="laoding" class="loader" ><img src="resources/images/wait.gif"></div>
    <!-- /.content -->
   </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <div class="pull-right hidden-xs">
      <b>Version</b> 1.0.0
    </div>
    <strong>Copyright &copy; 1988-${CURR_YR} <a href="http://www.faisaljassim.ae">FJ-Group</a>.</strong> All rights
    reserved.
  </footer>  
</div>
<script src="././resources/bower_components/select2/dist/js/select2.full.min.js"></script>
<script src="././resources/bower_components/fastclick/lib/fastclick.js"></script>
<script src="././resources/dist/js/adminlte.min.js"></script>
<script src="././resources/bower_components/jquery-knob/js/jquery.knob.js"></script>
<!-- page script start -->
<script>
var _requestId = '${SYSID}';
var _userTyp = '${USRTYP}';
var _url = 'ServiceController';
var _method = "POST";
var vstsCount= parseInt('${vstcount}');
var ttlEstCost = Number('${SRVSRQST.totalEstCost}');
var ttlFETimng = 0, ttlFATimng = 0, totLbrCost=0;
var fldUsers = <%=new Gson().toJson(request.getAttribute("FLDUSRS"))%>; 
$(function(){ 
	 $('.loader').hide();
	<%-- <c:forEach var="params" items="${FLDVSTLSTS}">    
	  ttlFETimng += calTotVisitCost("${params.totMinutes}", 1, "${FSRATES.fieldEngRate}");
	  ttlFATimng += calTotVisitCost("${params.totMinutes}", "${params.noOfAssistants}", "${FSRATES.fieldAsstRate}");
     </c:forEach>
     totLbrCost = (ttlFETimng + ttlFATimng).toFixed(2); 
     --%>
     totLbrCost = '${SRVSRQST.totalServiceLaborExpense}'; 
	  $('#sbmtVst').on('click', function(e){		  		   
		    e.preventDefault();
		    $('#err-msg').html('');
		   if($('#remarks').val().length < 10){
		    	$('#err-msg').html('Please enter atleast 10 character.');
		    	document.getElementById("remarks").focus();
		    	return false;
		    }else if($('#remarks').val().length > 200){
		    	$('#err-msg').html('Maximum 200 Character.');
		    	document.getElementById("remarks").focus();
		    	return false;
		    }else if(!validateCosting()){		    	
		    	$('#err-msg').html('Please enter correct costings.'); 
		    	return false;
		    }else if(validateStatus()){
		    	$('#err-msg').html('Please select a valid status.');
		    	document.getElementById("wrkngStatus").focus();
		    	return false;
		    }else{
		    	$('#err-msg').html('');
		    	var status = parseInt($.trim($('#wrkngStatus').val())); 
		    	if(status == 1 && ttlEstCost > 0){// Final confirmation or completed
		    		if(validateFinalCosting()){		    			
		    			doSubmit(status);
		    		}else{
		    			$('#err-msg').html('Total actual costing should greater than zero.');
		    			return false;
		    		}		    		
		    	}else if(status == 1 && ttlEstCost == 0){
		    		doSubmit(status);
		    	}else if(status == 2){// return to filed staff
		    		doSubmit(status);
		    	}else{// not a valid  status
		    		$('#err-msg').html('Please select  status.');
			    	document.getElementById("wrkngStatus").focus();
			    	return false;
		    		}		         
		    }
		  }); 
});

function calTotVisitCost(totalTime, noOfAsst, rate){  
	   var totVstAmount = (parseInt(noOfAsst) * parseInt(totalTime) * parseInt(rate))/(60); 
	   return totVstAmount;
}

function doSubmit(status){    
    var remarks=$('#remarks').val();
    var materialCost = Number($('#materialCost').val());
	var laborCost = Number($('#laborCost').val());
	var otherCost = Number($('#otherCost').val()); 
	$('#laoding_ststus').show();
    $.ajax({
	    		 type: _method,
	        	 url: _url, 
	        	 data: {action: "updateRqst", rd0:_requestId, rd1:materialCost , rd2:laborCost, rd3:otherCost,
	        		    rd4:remarks, rd5:status },
	         success: function(data) {  
	        	 $('#laoding_ststus').hide();
	        	 if (parseInt(data) == 1) {			              
	        		   $("#modal-officestaff").modal('hide');	        		      		  
	        		   $('#btn-cnfrmation').prop('disabled', true);
	        		   $('#btn-cnfrmation').css( { display:'none'});  	        		  	        			  
	        		   $("#message-block").css('display','block'); 	
	        		   showFinalDeatils(remarks, materialCost, laborCost, otherCost );
	        		   $("#msg-text").html("Successfully updated service request status");
	                }else{ 
	                	$("#message-block").css('display','block'); 	
		        		$("#msg-text").html("Status not updated,Please refresh the page!.");
	                }
	         },error:function(data,status,er) { 
	        	 $('#laoding_ststus').hide();
	        	 alert("Status not updated,Please refresh the page!."); 
	        	 }
	       });
  
}
function showFinalDeatils(remark, mCost, lCost, oCost){
	var total = Number(mCost)+Number(lCost)+Number(oCost);
	$("#atctext").html(total);
	$("#amctext").html(mCost);
	$("#alctext").html(lCost);
	$("#aoctext").html(oCost);
	$("#afrtext").html(remark);
}
function validateFinalCosting(){
	var materialCost = Number($('#materialCost').val());
	var laborCost = Number($('#laborCost').val());
	var otherCost = Number($('#otherCost').val());
	var ttlActCost = materialCost + laborCost + otherCost;
	return (ttlActCost > 0)? true : false ;
}

 
function validateStatus(){
	 var value = $('#wrkngStatus').val(); 
	 return (value == null || value == '' || value === 'undefined')? true : false;
} 

function clearFields(){ 
	$('#laoding_ststus').hide();
	document.getElementById("vstEntry").reset(); 
	document.forms["vstEntry"]["laborCost"].value = totLbrCost;
	}
function preLoader(){ $('#loading').show();}
function validateCosting(mtrlCost, lbrCost, othCost){ 
	var materialCost = Number($('#materialCost').val());
	var laborCost = Number($('#laborCost').val());
	var otherCost = Number($('#otherCost').val());
	if(typeof(materialCost) != 'number'  || typeof(laborCost) != 'number' || typeof(otherCost) != 'number' ){ 
		return false;
	 }else{
		return true;
	 }
}
function viewAssitantVisit(visitId, rowId){
	 $.ajax({
		 type: _method,
   	 url: _url, 
   	 data: {action: "viewFv",  vd0:visitId },
    success: function(data) {  
   	 $('#loading').hide();
   	 var output="<table class='table small' id='viewAssitanttable' >"+
			 "<thead style='backgrond:gray;'>"+
			 "<tr><th>Site Visitors</th><th>Check-In</th><th>Check-Out</th><th>Total Time (Hr)</th><th>Hourly Rate</th></tr>"
			 "</thead><tbody>";	  
			 var j=0; 
			
			 for (var i in data) { j=j+1; 	
			  
				  var _empName = "";
				  var hrMnt = 60;
				  var objAsstnt =  fldUsers.filter( item => item.fldStaffCode == data[i].fldStaffCode);  
					 if(objAsstnt.length == 1){
						_empNamee = objAsstnt[0].fldStaffName;
					 }else{_empNamee = objAsstnt[0].fldStaffCode;} 
					 var ttlHrs =(parseInt($.trim(data[i].ttim))/(hrMnt)).toFixed(2);
       	output+="<tr>"+ 
      			"<td>"+_empNamee+"</input></td>"+ 
       	    "<td>"+data[i].chkIn+"</td>"+ 
               "<td>"+data[i].chkOut+"</td>"+
               "<td>"+ttlHrs+"</td>"+ 
       		  "<td>"+data[i].hourlyRate+"</td>"+
     			"</tr>";
			 
			 } 
			 output+="</tbody></table></div>";
			 $("#fldVstAsstntDtls .modal-body").html(output);$("#fldVstAsstntDtls").modal("show");
    },error:function(data,status,er) {
   	 $('#loading').hide();
   	 alert("No data to display,Please refresh the page!."); }
  });
}
</script>  
<!-- page Script  end -->

</c:when>
<c:otherwise>
        <body onload="window.top.location.href='logout.jsp'"></body>
</c:otherwise>
</c:choose>
</html>