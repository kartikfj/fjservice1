<%-- 
    Document   : PUMP SERVICE PORTAL , FIELD STAFF ENTRY APGE  
    Author     : Nufail Achath
--%>
<%@include file="/service/header.jsp" %>
<style>
@media only screen and (max-width: 640px) {
.popover{top: 151px !important;margin-left: -95px;}
.clockpicker-align-left.popover>.arrow{left: 50% !important;}
}
.fldAsstAdd-btn{margin-left:3px;}.fld-vst-box{margin-bottom:-15px;}
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
    <a href="#" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>FJ</b>S</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg">
         <i class="fa fa-edit"></i> <b>FJ-Services</b>
      </span>
    </a>
    <!-- Header Navbar: style can be found in header.less -->
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
  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <!-- sidebar  -->
    <section class="sidebar">
      <!-- Sidebar user panel --> 
      <!-- sidebar menu:  -->
      <ul class="sidebar-menu" data-widget="tree">
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
	    <%--Field Staff Entry Section Start--%>
	    <section class="content">
	    <c:set var="vstcount" value="0" scope="page" />
	     <div class="row">
	     <div class="col-xs-12 pull-right entry-btn-div">     
	         <c:if test="${SRVSRQST.fldStatus eq 0}"> 
	     	  <button type="button" class="btn btn-sm btn-primary pull-right" id="btn-add-vst" data-toggle="modal" data-target="#modal-entrystaff" onClick="clearFields()">
               <i class="fa fa-plus"></i>Add New Visit
              </button> 
	        </c:if>
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
              <table class="table table-bordered small bordered" >
                <tbody> 
                <tr>
                  <td><strong>Project Code:</strong>${SRVSRQST.soCodeNo}</td>
                 </tr>
                 <tr>
                  <td><strong>Project:</strong>${SRVSRQST.projectName}</td>             
                <tr>                 
                  <td><strong>Customer:</strong>${SRVSRQST.customer}</td>
                </tr>
                <tr>
                  <td><strong>Consultant:</strong>${SRVSRQST.consultant}</td>
                 </tr>
                 <tr>                 
                   <td><strong>Visit Type : </strong>${SRVSRQST.visitType}</td>
                 </tr>
                 <tr>
                   <td><strong>Region : </strong>${SRVSRQST.region}<strong>  Location : </strong>${SRVSRQST.location}</td>
                </tr>
                <tr>                  
                  <td><strong>Office Staff : </strong>${SRVSRQST.officeUserName}</td>
                 </tr>
                <tr>                  
                  <td colspan="2"><strong>Initial OS Remarks:</strong>${SRVSRQST.ofcInitialRemarks}</td>
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
                <c:if test="${SRVSRQST.finalStatus eq 2}">
	     			 <tr><td colspan="2"><span  class="pull-left text-danger">Returned by office staff, <b>Remark : </b> "${SRVSRQST.ofcFinalRemarks}" </span></td></tr> 
	     		</c:if>                       
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
                  <c:if test="${SRVSRQST.fldStatus eq 0}">
                  <th>Action</th> 
                  </c:if>
                </tr> 
                <c:forEach var="visits" items="${FLDVSTLSTS}">
                <c:set var="vstcount" value="${vstcount + 1}" scope="page" />
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
                  <c:if test="${SRVSRQST.fldStatus eq 0}">
                  <td>
                  <button class="btn  btn-xs btn-danger vst-rmv"  onclick="deleteVisit('${visits.fldVstId}', this, '${visits.noOfAssistants}');"><i class="fa fa-remove"></i></button>
                  </td>
                  </c:if>
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
	     <div class="modal fade" id="modal-entrystaff" data-backdrop="static" data-keyboard="false">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header etry-vst-modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  	<span aria-hidden="true">&times;</span></button>
                	<h4 class="modal-title">New Service Visit</h4>
              </div>
              <div class="modal-body">
                <form id="vstEntry" >
                <div class="box-body">
                <div class="row">  
                		<div class="col-xs-12 entry-vst-head">Visit Details</div>
						<div class="col-xs-4">
							 <div class="form-group">
			                    <label class="label-control entry-vst-flds">Date</label>
			                    <input type="text" class="form-control datepicker mob-vst-view" id="visitDate" name="visitDate" required/>
			                </div>
						</div>  
						<div class="col-xs-4">  
							 <div class="input-group clockpicker pull-center" data-placement="left" data-align="top" data-autoclose="true">
							  <label class="label-control entry-vst-flds">Chk-In</label> 
							 <input type="text" class="form-control mob-vst-view"  id="chkIn"  name="chkIn" value="08:00"   required  readonly> 
							</div>
						</div> 
						<div class="col-xs-4">  
							 <div class="input-group clockpicker pull-center" data-placement="left" data-align="top" data-autoclose="true">
							  <label class="label-control entry-vst-flds">Chk-Out</label> 
							 <input type="text" class="form-control mob-vst-view"  id="chkOut"  name="chkOut" value="18:00"  required  readonly> 
							</div>
						</div>  
					</div>
              		<div class="row">  
						<div class="col-xs-12">     
							<div class="input-group">          
			                <input type="number" min="0" max="20" name="noasst" id="noasst" class="form-control">
			                <span class="input-group-addon"><i class="fa fa-user"></i> &nbsp; No. Of Site Visitors<%--Assistants --%></span>
			            </div>
						</div>  
					</div>  
					<div class="row">
						<div class="form-group col-sm-12 tpm fld-vst-box"> 
							<table class="table table-bordered small" id="fldAsstntsDetls">
							 <thead>
								<tr>
									<th>Site Visitor</th><th>From</th><th>To</th><th></th>
								</tr>
								<tr>
									<td>
										<select class="form-control form-control-sm" id="asstUser" >
										  <option value="">Select Site Visitor</option>
										    <c:forEach var="fieldUsers"  items="${FLDUSRS}" >
										    	<option value="${fieldUsers.fldStaffCode}">${fieldUsers.fldStaffName}-${fieldUsers.hourlyRate}</option>
										    </c:forEach>
										</select>
									</td>
									<td>
										<div class="input-group clockpicker pull-center" data-placement="left" data-align="top" data-autoclose="true"> 
										  <input type="text" class="form-control mob-vst-view"  id="asstchkIn"    value="08:00"     readonly> 
										</div>
									</td>
									<td>
										<div class="input-group clockpicker pull-center" data-placement="left" data-align="top" data-autoclose="true"> 
										  <input type="text" class="form-control mob-vst-view"  id="asstchkOut"    value="18:00"    readonly> 
										</div>
									</td>
									<td><span class="btn btn-xs btn-primary pull-right fldAsstAdd-btn" id="addAsstnt" onClick="addFieldAssistant();"><i class="fa fa-plus"></i>Add</span></td>
								</tr>
							</thead>
								<tbody></tbody>
							</table>
							
						</div> 
					</div>					
					<div class="row"> 
						<div class="form-group col-xs-12 ">
				             <label>Visit Remarks</label>
				             <textarea class="form-control" rows="2" placeholder="Enter Remarks..."  name="remarks" id="remarks" style="width:100%"  maxlength="300" wrap="hard" required></textarea>
               			</div>  
					</div>
					<div class="row"> 
						<div class="form-group col-sm-12"> 
							<select class="form-control form-control-sm" id="wrkngStatus" name="wrkngStatus">
							    <option value="" >Select Status</option>
							    <option value="1" >Completed</option>
							    <option value="0" >Not Completed</option>
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
	                <button type="submit" id="sbmtVst" class="btn btn-primary pull-right">Save Visit</button>
                </div>
              </div>
               <div id="laoding_vst" class="loader" ><img src="././resources/images/wait.gif"></div>
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
								          		<h4 class="modal-title">Site Visitors Visit Details </h4>
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
	    <%--Field Staff Entry Section End --%>  
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
var fldUsers = <%=new Gson().toJson(request.getAttribute("FLDUSRS"))%>; 
var assitantCount  = 0, _hrlyrate = 0, fldEng_hrlyrate = 0;  
var noOfAssitants = 0;
var asstVstDetails = [];
var asstEmpName,  asstEmpId, fromTime, toTime;
var fldEngrUid = '${fjtuser.emp_code}'; 
$(function(){ 	
	 $('.loader').hide();	  
	 $("#visitDate").datepicker({ "dateFormat" : "dd/mm/yy", yearRange: "2020:2030", maxDate : 0}); 
	
	  $('.clockpicker').clockpicker({
			placement: 'bottom',
			align: 'left',
			donetext: 'Done'
		}); 
	  setMailFldEngineerHrlyRate();
	  $('#sbmtVst').on('click', function(e){		  		   
		    e.preventDefault();
		   // alert('${vstcount}');
		    $('#err-msg').html('');
		    if(!validateDate()){
		    	$('#err-msg').html('Enter Visit Date');
		    	document.getElementById("visitDate").focus();
		    	return false;
		    }else if(!validateTiming()){
		    	$('#err-msg').html('Check-out time should greater than check-in time.');
		    	document.getElementById("chkOut").focus();
		    	return false;
		    }else if(!validateNumberOfAssitants()){
		    	$('#err-msg').html('Please enter correct no: of Site Visitors.');
		    	document.getElementById("noasst").focus();
		    	return false;
		    }else if($('#remarks').val().length < 10){
		    	$('#err-msg').html('Please enter atleast 10 character.');
		    	document.getElementById("remarks").focus();
		    	return false;
		    }else if($('#remarks').val().length > 200){
		    	$('#err-msg').html('Maximum 200 Character.');
		    	document.getElementById("remarks").focus();
		    	return false;
		    }else if(assitantCount != noOfAssitants){
		    	$('#err-msg').html('Please add only '+noOfAssitants+'  assitants.');
		    	return false;
		    }else if(validateStatus()){
		    	$('#err-msg').html('Please select site working status.');
		    	document.getElementById("wrkngStatus").focus();
		    	return false;
		    }else{
		    	$('#err-msg').html('');
		    	var status = parseInt($.trim($('#wrkngStatus').val()));
		    	var noAsstnts = parseInt($.trim($('#noasst').val()));
		    	if(status == 1){
		    		if ((confirm('Are You sure, You Want to complete field visit for this service request!'))) {
		   			 doSubmit(status, noAsstnts);
		   			 return true;
		   			 }
		   		 else{return false;} 		    		
		    	}else if(status == 0){		
		    		doSubmit(status, noAsstnts);
		    	}else{
		    		$('#err-msg').html('Please select a site working status.');
			    	document.getElementById("wrkngStatus").focus();
			    	return false;
		    		}		         
		    }
		  }); 
	  	$( "#asstUser" ).change(function() {
		 setAsstantEmpDtls();
		 }); 
		 $("#noasst" ).change(function() {
			 $('#err-msg').html("");
			 noOfAssitants = $('#noasst').val();  
			 if(noOfAssitants > assitantCount){
			  	 $('#addAsstnt').prop('disabled', false);
				 $('#addAsstnt').css( { display:'block'}); 
			 }else if(noOfAssitants <= assitantCount){
				 $('#addAsstnt').prop('disabled', true);
				 $('#addAsstnt').css( { display:'none'});
				 if(noOfAssitants < assitantCount){
					 var rmvAsstCount = assitantCount - noOfAssitants; 
				 	$('#err-msg').html("Please delete "+rmvAsstCount+" Site Visitor..");
				 }
			 }else{
				 
			 }
		});
	  	 $(document).on('click', '.remove_details', function(){
	  		  var row_id = $(this).attr("id");
	  		  if(confirm("Are you sure you want to remove this Site Visitors visit details?")){
	  		   $('#'+row_id+'').remove();
	  		 asstVstDetails = asstVstDetails.filter( obj => obj.id !== row_id);
	  		   //console.log("removed details"); 
	  		   assitantCount = assitantCount - 1;
	  		   if(assitantCount < noOfAssitants){ 
	  		    	 $('#addAsstnt').prop('disabled', false);
	  				 $('#addAsstnt').css( { display:'block'}); 
	  		    }
	  		 $('#err-msg').html("");
	  		  }
	  		  else
	  		  {
	  		   return false;
	  		  }
	  		 });
});
function setAsstantEmpDtls(){
	  asstEmpId =  $('#asstUser').val();
	  asstEmpName =  $('#asstUser option:selected').text(); 
	  var objAsstnt =  fldUsers.filter( item => item.fldStaffCode == asstEmpId); 
	 if(objAsstnt.length == 1){
		_hrlyrate = objAsstnt[0].hourlyRate;
	 }else{_hrlyrate = 0;} 
}
function setMailFldEngineerHrlyRate(){
	  var objAsstnt =  fldUsers.filter( item => item.fldStaffCode == fldEngrUid); 
		 if(objAsstnt.length == 1){
			fldEng_hrlyrate = objAsstnt[0].hourlyRate;
		 }else{fldEng_hrlyrate = 0;} 
}
function addFieldAssistant(){ 
    if( visitAsstntDetailsValidate() && ( assitantCount < noOfAssitants)){ 	 
 	   if($.trim($('#addAsstnt').text()) == 'Add')
 	   { 
 		var output ="";   
 		assitantCount = assitantCount + 1;
 		var visitId = Math.floor(Math.random()*100);
 	    output = '<tr id="_v'+visitId+'">';
 	    output += '<td>'+asstEmpName+'</td>';
		output += '<td>'+fromTime+'</td>';
 	    output += '<td>'+toTime+'</td>'; 
 	    output += '<td><button type="button" name="remove_details" class="btn btn-danger btn-xs remove_details" id="_v'+visitId+'"><i class="fa fa-remove"></i></button></td>';
 	    output += '</tr>';
 	    asstVstDetails.push( {"id": '_v'+visitId, "fldStaffCode": $.trim(asstEmpId),  "chkIn": $.trim(fromTime), "chkOut": $.trim(toTime), "ttim":calTotVisitTimeFAsst(fromTime, toTime), "hourlyRate":_hrlyrate} );
 	    if(assitantCount  >= noOfAssitants){
 	    	 $('#addAsstnt').prop('disabled', true);
 			 $('#addAsstnt').css( { display:'none'}); 
 	    } 
 	  $('#fldAsstntsDetls').append(output);
 	   }
 	   else
 	   {
 	    alert("Please Rfresh the page and try again");
 	   }
  
 	  }else{
 		  //$('#errMsg').html("");  
 	  }
}
function validateNumberOfAssitants(){ 
	var val = $('#noasst').val(); 
	return (typeof(Number(val)) == 'number' && val !== 'undefined' && val != null && val != '')? true : false;   
	}
function calTotVisitTimeFAsst(startTime, endTime){
	   var chckIn = moment(startTime, "H:mm:ss");
	   var chckOut = moment(endTime, "H:mm:ss");
	   var totalVisitTime = parseInt(moment.duration(chckOut.diff(chckIn)).asMinutes()); 
	   return totalVisitTime;
}
function doSubmit(status, noAsstnts){   
    var startTime=$('#chkIn').val();
    var endTime=$('#chkOut').val(); 
    var remarks=$('#remarks').val().split("\n").join("<br/>");
    var visitDay=$('#visitDate').val(); 
    var totTimeInMnts = calTotVisitTimeFAsst(startTime, endTime); 
   // var jsonDetails = encodeURIComponent(JSON.stringify((asstVstDetails)));
    var jsonDetails =  JSON.stringify(asstVstDetails); 
    $('#laoding_vst').show();
    $.ajax({
	    		 type: _method,
	        	 url: _url, 
	        	 data: {action: "newVisit", vd0:_requestId,vd1:startTime , vd2:endTime, vd3:remarks,
	        		    vd4:visitDay, vd5:status, vd6: noAsstnts, vd7: totTimeInMnts, vd8:jsonDetails, vd9: fldEng_hrlyrate},
	         success: function(data) {  
	        	 $('#laoding_vst').hide();
	        	 if (parseInt(data) == 1) {			              
	        		   $("#modal-entrystaff").modal('hide');
	        		   vstsCount = vstsCount + 1;
	        		   addRow(vstsCount,startTime, endTime, remarks, visitDay, noAsstnts, status);      		  
	        		   if(status == 1){
	        			   $('#btn-add-vst').prop('disabled', true);
	        			   $('#btn-add-vst, .vst-rmv').css( { display:'none'}); 
	        			   }
	                }else{ 
	                	 alert("Your visit is not saved,Please refresh the page and Try!.");
	                	 $("#modal-entrystaff").modal('hide');
	                }
	         },error:function(data,status,er) { 
	        	 $('#laoding_vst').hide();
	        	 alert("Your visit is not saved,Please refresh the page!."); }
	       }); 
}
function addRow(vstsCount, startTime, endTime, remarks, visitDay, noAsstnts, status) {
	  var table = document.getElementById("fld-entry-lists");
	  var row = table.insertRow(-1);
	  var c1 = row.insertCell(0);
	  var c2 = row.insertCell(1);
	  var c3 = row.insertCell(2);
	  var c4 = row.insertCell(3);
	  var c5 = row.insertCell(4);
	  var c6 = row.insertCell(5);
	  var c7 = row.insertCell(6);	  
	  c1.innerHTML = vstsCount;
	  c2.innerHTML = visitDay;
	  c3.innerHTML = startTime+" - "+endTime;
	  c4.innerHTML = noAsstnts; 
	  c5.innerHTML = remarks;
	  c6.innerHTML = (status == 1)? `<span class="label label-success">Completed</span>` : `<span class="label label-danger">Not Completed</span>`;
	  c7.innerHTML = (status == 1)? '':`<button class='btn  btn-xs btn-danger vst-rmv'  disabled><i class="fa fa-remove"></i></button>`;
	}	
function deleteVisit(visitId, rowId, noOffAstnts){
	if ((confirm('Are You sure, You Want to delete this field visit!'))) { 
			 preLoader();
			 removeVisit(visitId, rowId, noOffAstnts);
			 return true;
			 }
		 else{return false;} 	   
}
function removeVisit(visitId, rowId, noOffAstnts){
	 $.ajax({
		 type: _method,
    	 url: _url, 
    	 data: {action: "rmvFv", vd0:_requestId, vd1:visitId, vd2:_userTyp, vd3: noOffAstnts },
     success: function(data) {  
    	 $('#loading').hide();
    	 if (parseInt(data) == 1) {	
    		  vstsCount = vstsCount - 1;
    		  var index = rowId.parentNode.parentNode.rowIndex;
    		  document.getElementById("fld-entry-lists").deleteRow(index);
            }else{
            	 alert("Field Visit not deleted,Please refresh the page!.");
            }
     },error:function(data,status,er) {
    	 $('#loading').hide();
    	 alert("Your field visit is not deleted,Please refresh the page!."); }
   });
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
			 "<tr><th>Site Visitor</th><th>Check-In</th><th>Check-Out</th><th>Total Time (Hr)</th><th>Hourly Rate</th></tr>"
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
function validateStatus(){
	 var value = $('#wrkngStatus').val(); 
	 return (value == null || value == '' || value === 'undefined')? true : false;
}
function validateDate(){
	 var value = $('#visitDate').val(); 
	 return (value == null || value == '' || value === 'undefined')? false : true;
}
function validateTiming(){
	 var result = false;
	 var ts=$('#chkIn').val();
     var fs=$('#chkOut').val();	
	 var startTime, endTime, timeArr;
	 // split the hours and minutes
	 timeArr = ts.split(':');
	 // Hours is in timeArr[0]; minutes in timeArr[1];
	 startTime = (timeArr[0] * 60) + timeArr[1];
	 // do the same for end time:
	 timeArr = fs.split(':');
	 endTime = (timeArr[0] * 60) + timeArr[1];
	 //  compare both
	 result = parseInt(startTime) <= parseInt(endTime);
	 return result;
}
function validateAsstTiming(){
	 var result = false;
	 var ts=$('#asstchkIn').val();
    var fs=$('#asstchkOut').val();	
    fromTime = ts;
    toTime = fs
	 var startTime, endTime, timeArr;
	 // split the hours and minutes
	 timeArr = ts.split(':');
	 // Hours is in timeArr[0]; minutes in timeArr[1];
	 startTime = (timeArr[0] * 60) + timeArr[1];
	 // do the same for end time:
	 timeArr = fs.split(':');
	 endTime = (timeArr[0] * 60) + timeArr[1];
	 //  compare both
	 result = parseInt(startTime) <= parseInt(endTime);
	 return result;
}
function clearFields(){ 
	document.getElementById("vstEntry").reset(); 
	asstVstDetails = []; 
	$('#fldAsstntsDetls tbody').html("");
	 assitantCount = 0; noOfAssitants = 0;
	 asstEmpName ="";  asstEmpId=""; fromTime="08:00"; toTime="16:00";
  	 $('#addAsstnt').prop('disabled', false);
	 $('#addAsstnt').css( { display:'block'}); 
	}
function preLoader(){ $('#loading').show();}  
function visitAsstntDetailsValidate(){ 
	clearErrorMessage(); 		
		if( $.trim(asstEmpId) == '' || $.trim(asstEmpId) == null || typeof(asstEmpId) == 'undefined'){
		    	$('#err-msg').html("Please select a assistant..");
		    	 document.getElementById("asstUser").focus();
		    	return false;
		    }else if(!validateAsstTiming()){
		    	$('#err-msg').html("<b>To Time</b> should greater or equal to <b>From Time</b> time...");
		    	document.getElementById("asstchkOut").focus();
		    	return false;   	
		    }else if((noOfAssitants == 0) && !validateNumberOfAssitants()){
		    	$('#err-msg').html("Please Enter No. of assistants..");
		    }else{ 
		    	clearErrorMessage();  
		    	return true;
		    }  
}
function clearErrorMessage(){	
	$('#err-msg').html("");    
}
</script>  
<!-- page Script  end -->
</c:when>
<c:otherwise>
        <body onload="window.top.location.href='logout.jsp'"></body> 
</c:otherwise>
</c:choose>
</html>