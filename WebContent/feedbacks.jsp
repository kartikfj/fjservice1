<%-- 
    Document   : EMPLOYEE FEEDBACK 
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@include file="mainview.jsp" %>
<!DOCTYPE html>
<html>
<head> 
<style type="text/css"> 
.loader { position: fixed; z-index: 999; 	height: 2em; 	width: 2em; overflow: show; 	margin: auto; 	top: 0; left: 0; bottom: 0; right: 0;}
.loader:before { content: ''; display: block; position: fixed; top: 0; left: 0; width: 100%; height: 100%;background-color: rgba(0, 0, 0, 0.3);}
.container{ padding-right: unset !important;padding-left: unset !important;}.feedback{background: -webkit-linear-gradient(left, #065685, #065685); margin-top: -20px;}.feedback-left{ text-align: center;   color: #fff;  margin-top: 4%;}
.feedback-left input{ border: none;border-radius: 1.5rem; padding: 2%;  width: 60%;background: #f8f9fa; font-weight: bold;color: #383d41; margin-top: 30%;  margin-bottom: 3%;  cursor: pointer;}.feedback-right{background: #f8f9fa; border-top-left-radius: 10% 50%; border-bottom-left-radius: 10% 50%;}
.feedback-left img{ margin-top: 15%; margin-bottom: 0%; width: 60%;}.feedback-left p{ font-weight: lighter; padding: 12%;margin-top: -9%;}.feedback .feedback-form{ padding: 10%;  margin-top: -10%;}.btnFeedback{  float: right; margin-top: 10%;  border: none;   border-radius: 1.5rem;   padding: 10px;  background: #0062cc;  color: #fff;  font-weight: 600;   width: 30%;  cursor: pointer;}
.feedback .nav-tabs{margin-top: 3%; border: none; background: #0062cc; border-radius: 1.5rem; width: 28%; float: right;}.feedback .nav-tabs .nav-link{ padding: 2%; height: 28px; font-weight: 600; color: #fff; margin: 5px;}.feedback .nav-tabs .nav-link:hover{ border: none;}.feedback .nav-tabs .nav-link.active{ width: 100px;color: #0062cc; border: 2px solid #0062cc;}
.feedback-heading{ text-align: center; margin-top: 8%; margin-bottom: -15%;color: #495057;}
.nav-tabs.nav-justified>.active>a, .nav-tabs.nav-justified>.active>a:focus, .nav-tabs.nav-justified>.active>a:hover { color: #0062cc !important;}
.nav-tabs.nav-justified>li>a { color: #ffffff !important;border-bottom: none !important;}  
#fdbckRspnse{ display: none; height: 350px; text-align: center;padding-top: 10%;}.errMsg{color: red; padding: 10px;  margin-top: -10px; text-align: center; font-weight: bold;}
.fdbk-content-icon{margin-left: 8%;margin-top: 2%; margin-bottom: 2%;width: 26%; padding-bottom: 5px;  border-bottom: 3px double #28424f;}
@media (max-width: 991px),@media (max-width: 767px),@media (max-width: 375px){.text-info {  font-size:70% !important;}.fdbk-content-icon{width:50% !important;}.feedback{background:unset !important;}.feedback-left{display:none !important;}.feedback .nav-tabs{width:100% !important;}.feedback .nav-tabs .nav-link.active{width:50% !important;}.feedback .nav-tabs .nav-link{float:left !important;}}
</style>
<script type="text/javascript">
if ( window.history.replaceState ) {  window.history.replaceState( null, null, window.location.href );}
var empId = '${fjtuser.emp_code}';
$(document).ready(function(){  
	 $('#laoding').hide();$('#errMsg').html(""); 
	var type = "";
	$('#btnSbmtSggstn').click(function(){  	
	$('#errMsg1').html(""); 
	   if($.trim($('#btnSbmtSggstn').text()) == 'Submit')  {  
			var empCode = document.getElementById("empCode").value; 
			var details = document.getElementById("suggstnDesc").value;
			if( $.trim(empCode) == '' || $.trim(empCode) == null || $.trim(empCode) != empId ){ 
			    	$('#errMsg1').html("Please enter your employee Code : "+empId);
			    	document.getElementById("empCode").focus();
			    	return false;
			 }else if($.trim(details) == '' || $.trim(details) == null){
				 $('#errMsg1').html("Please enter suggesion details..");
		    	 document.getElementById("suggstnDesc").focus();
		    	 return false;
			 }else if($.trim(details).length < 20){
			    	$('#errMsg1').html('Please enter atleast 20 character for suggesion  details.');
			    	document.getElementById("suggstnDesc").focus();
			    	return false;   	
			 }else if($.trim(details).length > 500){
			    	$('#errMsg1').html('Maximum 500 Character  for  suggesion details.');
			    	document.getElementById("suggstnDesc").focus();
			    	return false;   	
			 }else{
			if(confirm("Are you sure you want to submit this suggestion ?")){
				$('#laoding').show();	
				 type="SUGGESTION";
				 $.ajax({  type: 'POST',
			    	 url: 'Feedback', 
					 data: {fjtco: "fdbackRgstn",  fdbDtls:details, typ: type},  
					 success: function(data) {	
						 $('#laoding').hide();
						 var output="";  
						 if(parseInt($.trim(data)) == 1){
							 output +="<div class='alert alert-success' role='alert'>Your suggestion details updated successfully.</div>";
							 $('#fdbckbox').css('display','none');	 
							  $('#fdbckRspnse').css('display','block');
							  $('#fdbckRspnse').html(output);
						 }else{
							 output +="<div class='alert alert-danger' role='alert'>Your suggestion details not updated. Please try again.</div>";
							 $('#fdbckbox').css('display','none'); 
							  $('#fdbckRspnse').css('display','block');
							  $('#fdbckRspnse').html(output);
						 }							  
							   
						},error:function(data,status,er) {
							 $('#laoding').hide();
							 e.preventDefault();
							alert("please click again");}
						});	
			}else{return false; }
			 }
	   }
	   else{ alert("Please Rfresh the page and try again");} 
	 });
	$('#btnSbmtCmplnt').click(function(){ 
		$('#errMsg2').html(""); 
	   if($.trim($('#btnSbmtCmplnt').text()) == 'Submit') {  
			var details = document.getElementById("complntDesc").value; 
			 if($.trim(details) == '' || $.trim(details) == null){
				 $('#errMsg2').html("Please enter complaint details..");
		    	 document.getElementById("complntDesc").focus();
		    	 return false;
			 }else if($.trim(details).length < 20){
			    	$('#errMsg2').html('Please enter atleast 20 character for complaint  details.');
			    	document.getElementById("complntDesc").focus();
			    	return false;   	
			 }else if($.trim(details).length > 500){
			    	$('#errMsg2').html('Maximum 500 Character  for  complaint details.');
			    	document.getElementById("complntDesc").focus();
			    	return false;   	
			 }else{ 
				  if(confirm("Are you sure you want to submit this complaint ?")){ 
					  $('#laoding').show();	
					  type="COMPLAINT";
						 $.ajax({  type: 'POST',
					    	 url: 'Feedback', 
							 data: {fjtco: "fdbackRgstn",  fdbDtls:details, typ: type},  
							 success: function(data) {	
								 $('#laoding').hide();
								 var output="";  
								 if(parseInt($.trim(data)) == 1){
									 output +="<div class='alert alert-success' role='alert'>Your complaint details updated successfully.</div>";
									 $('#fdbckbox').css('display','none');	 
									  $('#fdbckRspnse').css('display','block');
									  $('#fdbckRspnse').html(output);
								 }else{
									 output +="<div class='alert alert-danger' role='alert'>Your complaint details not updated. Please try again.</div>";
									 $('#fdbckbox').css('display','none'); 
									  $('#fdbckRspnse').css('display','block');
									  $('#fdbckRspnse').html(output);
								 }
									 
									   
								},error:function(data,status,er) {
									 $('#laoding').hide();
									 e.preventDefault();
									alert("please click again");}
								});	
					  } else {  return false; }				
			 }
	   }
	   else{ alert("Please Rfresh the page and try again");}
	 
	});
});
function clearMessages(){ $('.errMsg').html("");  document.getElementById("empCode").value = ""; document.getElementById("complntDesc").value = ""; document.getElementById("suggstnDesc").value = "";}
function clearErrorMessage(){ $('.errMsg').html("");}
</script>
</head>
<c:choose>
<c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1}">
<body>
	<div class="container feedback">
                <div class="row" style="margin-right: 0px; margin-left: 0px;">
                    <div class="col-md-3 feedback-left">
                        <img src="resources/images/fdbck.png" alt=""/>                         
                    </div>
                    <div class="col-md-9 feedback-right">
                     <a href="homepage.jsp" class="pull-right" > <i class="fa fa-2x fa-home" style="color: #2196f3;font-size: 20px;padding:5px;"></i></a> 
                    <a href="Feedback" style="color:#fff;" class="pull-right" > <i class="fa fa-2x fa-refresh" style="color: #2196f3;font-size: 20px;padding:5px;"></i></a>
                    <div id="fdbckbox">
                        <ul class="nav nav-tabs nav-justified" id="myTab" role="tablist">
                            <li class="nav-item active" onClick="clearMessages()">
                                <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Suggestion</a>
                            </li>
                            <li class="nav-item" onClick="clearMessages()">
                                <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">Complaint</a>
                            </li>
                        </ul>
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade in active" id="home" role="tabpanel" aria-labelledby="home-tab">
                                <img src="resources/images/suggestion_fdbck.png" class="fdbk-content-icon">
                                <div class="row feedback-form"> 
                                    <div class="col-md-12">
                                          <div class="form-group">
                                            <input type="text" class="form-control" placeholder="Enter Your Employee Code.." onChange="clearErrorMessage()"  id="empCode" />
                                        </div>  
                                        <div class="form-group"> 
  											<textarea class="form-control"  style="width: 100%;" placeholder="Enter Suggestion Details.." onChange="clearErrorMessage()"  id="suggstnDesc"></textarea>
                                        </div> 
                                        <div id="errMsg1" class="errMsg"></div>
                                        <button type="button" id ="btnSbmtSggstn" class="btnFeedback">Submit</button>
                                    </div>
                                   
                                </div>
                            </div>
                            <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                                 <img src="resources/images/complaint_fdbck.png" class="fdbk-content-icon">
                                <div class="row feedback-form"> 
                                    <div class="col-md-12"> 
                                        <div class="form-group">
                                         	<label for="comment">Details : </label>
  											<textarea class="form-control"  placeholder="Enter Complaint Details.." onChange="clearErrorMessage()"  style="width: 100%;" id="complntDesc"></textarea>
  											<p class="text-info"><b>*** This complaint is completely confidential. ***</b></p> 
                                        </div>
                                        <div id="errMsg2" class="errMsg"></div>
                                        <button type="button" id="btnSbmtCmplnt" class="btnFeedback">Submit</button> 
                                    </div>
                                </div>
                            </div>
                             
                        </div>
                       </div>                      
                        <div id="fdbckRspnse">   </div>
                    </div>
              </div>
	</div> 
<div id="laoding" class="loader"><img src="resources/images/wait.gif"></div>
</body>
</c:when>
<c:otherwise>
<html>
 <body onload="window.top.location.href='logout.jsp'">
 </body> 
</html>
</c:otherwise>
</c:choose>