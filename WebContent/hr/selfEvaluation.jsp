<%-- 
    Document   : HR Evaluation Performance , By Employee 
--%>
<%@include file="/hr/header.jsp" %> 
<body class="hold-transition skin-blue sidebar-mini sidebar-collapse sidebar-mini" style="height: auto !important; min-height: 100% !important;">
 <c:if test="${empty fjtuser.emp_code}"> <jsp:forward page="index.jsp"/> </c:if>
 <c:choose>
 <c:when test="${!empty fjtuser.emp_code and fjtuser.checkValidSession eq 1}">
 <c:set var="profileController" value="profile" scope="page" />
  <c:set var="selfcontroller" value="SelfEvaluation" scope="page" />
  <c:set var="mangerController" value="EmployeeEvaluation" scope="page" />
  <c:set var="reportController" value="EvaluationReport" scope="page" />
     <c:set var="dashboardController" value="HrDashboard" scope="page" />
<div class="wrapper">
  <header class="main-header">
    <!-- Logo -->
    <a href="#" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>FJ</b>P</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg">
         <i class="fa fa-edit"></i> <b>FJ-Portal</b>
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
              <li class="header"><a  href="logout.jsp" style="color: #fffbfb !important;"> <i class="fa fa-power-off"></i> Log-Out</a></li>      
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
         <li><a href="${profileController}"><i class="fa fa-address-card"></i><span>Profile</span></a></li> 
         <c:if test="${fjtuser.role eq 'hrmgr' }"><li><a href="${dashboardController}"><i class="fa fa-dashboard"></i><span>HR Dashbaord</span></a></li></c:if>  
         <li class="active"><a href="${selfcontroller}"><i class="fa fa-user"></i><span>Self Evaluation</span></a></li> 
        <c:if test="${EVLMNGRORNOT ge 1}"><li ><a href="${mangerController}"><i class="fa fa-users"></i><span>Employee Evaluation</span></a></li>  </c:if>  
        <li ><a href="${reportController}"><i class="fa fa-table"></i><span>Evaluation Report</span></a></li>       
         <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>      
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper" style="height: auto !important; min-height: 100% !important;">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>HR <small>Employee Performance Evaluation</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="homepage.jsp"><i class="fa fa-calendar"></i> Home</a></li>
        <li class="active">HR Portal</li>
      </ol>
    </section>   
    <!-- Main content -->	    
	  
	    <section class="content">
	  		  <%-- Employee profile Section Start --%>
	  		  <div class="row">
	  		  	<div class="col-md-12 col-xs-12"> 
	  		  		 <div class="panel panel-default" id="user-profile-box">
	                     <div class="panel-heading" >
	                        <h5 class="text-primary"> <i class="fa fa-user pull-left fa-lg" aria-hidden="true"> </i>Profile</h5>
	                     </div>
	                     <div class="panel-body">
	                     	 <table class="col-md-12  table-striped table-condensed small">        		 
		        			 <tbody>       		
		        			 <tr  style="background-color:white;">		        			 
		                         <th data-title="Employee Code"><span class='user-title'>Employee Code :  </span> <span class='user-content'> ${PROFILE.empCode} </span></th>
		        				 <th data-title="Employee Name"><span class='user-title'>Employee Name : </span> <span class='user-content'> ${PROFILE.empName}</span></th>
		        				 <th data-title="Division"><span class='user-title'>Division :  </span> <span class='user-content'> ${PROFILE.division} </span></th> 
		                       	 <th data-title="Job Title"><span class='user-title'>Job Title :  </span> <span class='user-content'> ${PROFILE.jobTitle}</span></th>
		                         <th data-title="Evaluation For"><span class='user-title'>Evaluation For :  </span> <span class='user-content'> ${EVLSETTINGS.evaluationYear}, TERM-${EVLSETTINGS.evaluationTerm}</span></th> 
		                         <th data-title="Joining Date"><span class='user-title'>Joining Date : </span>
		                          <span class='user-content'>
		                         	<fmt:parseDate value="${PROFILE.joiningDate}" var="joiingDate"  dateStyle="short"   pattern="yyyy-MM-dd HH:mm" />
		                         	<fmt:formatDate value="${joiingDate}" pattern="dd/MM/yyyy"/></span>  
		                         </th>		                                                                      
		                         <th data-title="Manager"><span class='user-title'>Manager: </span> <span class='user-content'>${PROFILE.manager}</span></th>     
		                     </tr> 		
						   </tbody>		
		               	   </table>
	                     </div>
                     </div>   
	  		  	</div>
	  		  </div>	  		  
	  		  <%-- Employee profile Section End   --%> 
	  		  
	  		  <%-- Help Start --%>
	  		  <div class="stickyBox">
	  		  	<a class="btn btn-app stickyBtn" data-toggle="modal" data-target="#modal-help"> 
                <i class="fa fa-bullhorn"></i> Help
              </a>
	  		  </div>
	  		  <div class="modal fade bd-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="modal-help" id="modal-help" aria-hidden="true">
  				<div class="modal-dialog modal-lg">
   				 <div class="modal-content">	
   					<div class="modal-header">
                		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  		<span aria-hidden="true">&times;</span></button>
                		<h4 class="modal-title">HR Evaluation Performance Help</h4>
              		</div>
              		<div class="modal-body"> 
			   <h5 class="box-title"><i class="fa fa-dot-circle-o"></i> Evaluation Updates Summary </h5> 
			             <p> 
			               <span class="margin"><a class="btn btn-success">4/4 </a> - <b>All Questions Updated</b></span>
			              <span class="margin"><a class="btn btn-employee">2/4 </a> - <b>By Employee, Pending</b></span>
			              <span class="margin"><a class="btn btn-manager">2/4</a> -  <b>By Manager, Pending</b></span>
			             </p> 	
			           <h5 class="box-title"><i class="fa fa-dot-circle-o"></i> Rating General Details</h5>
			             <P>
			             <span class="margin"><i class="fa fa-info"> - </i>  Maximum score for each category is <b>16</b>, Except category DELIVERY (Max. score is <b>20</b>)</span><br/>
			             <span class="margin"><i class="fa fa-info"> - </i>  Maximum rating for each question is <b>4</b> </span><br/>
			             <span class="margin"><i class="fa fa-info"> - </i>  No Rating for question 'Other Comments' </span>
			             </P> 
			             
			              <h5 class="box-title"><i class="fa fa-dot-circle-o"></i>Rating Score</h5> 
			             <p> 
			             	<c:forEach items="${EVLRATINGS}" var="rating">
			             		<span class="margin"><a class="label label-default">${rating.ratingCode}</a> - <b>${rating.ratingDesc}</b></span>
			             	</c:forEach>
			             </p> 
			             <h4 class="box-title"><i class="fa fa-arrow-right"></i> <b>STEPS</b></h4> 
			              <h5 class="box-title"><i class="fa fa-dot-circle-o"></i> <b>STEP 1.</b>  View category details</h5>
			              <p class="margin">
			                Click on the "<span class="btn btn-xs btn-primary"><i class="fa fa-share" aria-hidden="true"></i>  View</span>" button to see the each category details. 
			              </p>	
			              <h5 class="box-title"><i class="fa fa-dot-circle-o"></i> <b>STEP 2.</b> Save comments</h5>
			               <p class="margin">
			               -> Save your comment after manager updated your evaluation rating, System will send auto mail notification to you after manager submitted rating. <br/>
			             	<span class="margin"><i class="fa fa-info"> - </i>  Enter your comments</span><br/>
			             	<span class="margin"><i class="fa fa-info"> - </i>  Click on the "<span class="btn btn-xs btn-primary">Save</span> or <span class="btn btn-xs btn-primary">Save Changes</span>" button to save your comment.</span>			                
			              </p> 
			                  <h5 class="box-title"><i class="fa fa-dot-circle-o"></i> <b>STEP 3.</b>  Submit to manager </h5>
			              <p class="margin">
			              -> After updating your self goal, final comment and comments against manager rating, Please click on "<button type="button" class="btn btn-default btn-xs">Submit to ${PROFILE.manager}</button>" button. 
			               <br/> -> After clicking on "Submit" button, Portal will disable data entry option and send a email notification to manager.    
			               <br/> -> If manager submitted again, please update your comment and submit again                	
			              </p>		
   					</div>
   				  </div>
  				</div>
     		  </div>
	  		  <%-- Help End--%>
	  		  
	  		   <%-- Notification start --%>
	  		  <div class="row">
	  		  	<div id="notification"><div id="notification_icon"><i class="fa fa-lg fa-bell" aria-hidden="true"></i></div><div id="notification_desc"></div></div>
	  		  </div>
	  		  <%-- Notification end --%>
	  		  
	  		  <%-- Evaluation Category Count Section Start --%>
	  		  <div class="row">
	  		  	<div class="col-md-12 col-xs-12">
	  		  		 <div class="panel panel-default" id="user-profile-box">
	                     <div class="panel-heading" >
	                        <h5 class="text-primary"> 
	                        <i class="fa fa-check fa-lg " aria-hidden="true"></i> Evaluation Summary  
	                        <span class="margin text-dark"> || </span> <span class="totalScore">Total Score (<span id="actualScore"></span>/<span id="targetScore"></span>)</span>	                        
	                        </h5>
	                        <c:if test="${EVLMASTER.empEntryActive eq 0 and  EVLMASTER.managerEntryActive eq 1 and EVLACTIVEORNOT eq 1 }">
	                         <div class="col-md-12 col-xs-12 pull-right" id="notification-btn-box"> <span class="btn btn-sm btn-default"> <i class="fa fa-envelope"></i>  <b>Submit to  ${PROFILE.manager} and HR Manager</b></span> </div>
	                        </c:if>
	                     </div>
	                     <div class="panel-body">
					        <div class="category-summary">
					            <div class="category-summary-body">	
					                <div class="hr-eval-timeline" dir="ltr" id="categoryList"> 	 
					                </div>
					            </div>
					        </div> 
			       		</div>
	  		  		</div>
	  		  </div>
	  		 </div>
	  		  <%-- Evaluation Category Count Section End   --%>  
	  		  
	  		  <%-- Evaluation Category Content Section Start --%>
	  		  <div class="row category">
	  		  	<div class="col-md-12 col-xs-12" id="categoryContent">
	  		  		
	  		  	</div>
	  		  </div>
	  		  <%-- Evaluation Category Content Section  End   --%>  
	  		  
    			<div id="laoding" class="loader" ><img src="resources/images/wait.gif"></div>
	    </section>
    <!-- /.content -->
   </div> 
  <!-- /.content-wrapper -->

<%@include file="/hr/footer.jsp" %>
  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">    </aside>
  <!-- /.control-sidebar --> 
  <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->
<script src="././resources/bower_components/select2/dist/js/select2.full.min.js"></script>
<script src="././resources/bower_components/fastclick/lib/fastclick.js"></script>
<script src="././resources/dist/js/adminlte.min.js"></script>
<script src="././resources/bower_components/jquery-knob/js/jquery.knob.js"></script>
<!-- page script start -->
<script> 
//alert("employee=== "+employee);
var _url = 'SelfEvaluation';
var _method = "POST";     
var employee = '${EVLMASTER.evltnEmp}';
if(employee == null || employee=== ""){
	employee = '${fjtuser.emp_code}';
}
var evaluationYear = '${EVLSETTINGS.evaluationYear}';
var evaluationTerm = '${EVLSETTINGS.evaluationTerm}';
var generalCmmntUpdtdCountByEmp = 0;
var generalCmmntUpdtdCountByMgr = 0;
var generalCmmntUpdtdCountByHr = 0;
var optn = 0;
var _id = '${EVLMASTER.id}'; 
var employeeEntryActiveOrNot = '${EVLMASTER.empEntryActive}';
var managerEntryActiveOrNot = '${EVLMASTER.managerEntryActive}';
var actualScore = '${TOTACTUALSCORE}';
var evaluationActvOrNot = '${EVLACTIVEORNOT}';
var targetScore = 100;
var categorySummary = <%=new Gson().toJson(request.getAttribute("EVLCATSUMMRY"))%>; 
var generalDetails = <%=new Gson().toJson(request.getAttribute("EVLMASTER"))%>; 
var ratings = <%=new Gson().toJson(request.getAttribute("EVLRATINGS"))%>; 
var topRatingValue = Object.keys(ratings).reduce((a, b) => ratings[a].ratingCode > ratings[b].ratingCode ? ratings[a].ratingCode : ratings[b].ratingCode);
var categoryContent =[]; 
var genCommentLength = 1000;
var catCommentLength = 500;
$(function(){ 	
	 $('.loader').hide();
	 checkGeneralDetails();
	 displayCategorySummary(); 
	 setTotalScore();
	 if(!validateValue(employee) || !validateValue(_id) || evaluationActvOrNot != 1 || generalDetails['evaluationStatus']  > 0){
		 setStyleForUpdateBtns(); 
	 }
	 $('#notification-btn-box').on('click', function(e){
		 if(actualScore > 0){
			if(managerEntryActiveOrNot == 1) {
			 if(validateValue(_id)){ 
			 	checkEmployeesComentCount();
			 }else{
				 alert("Please update evaluation comments...");
				return false;
			 }
		 } /*else{
			 alert("Manager not submitted your final rating. Please update your comment after recieving mail notification from manager.");
				return false;
			 }*/
			 
		 }/*else{
			 alert("Manager not updated any rating. Please comment  and  submit after manager updated rating.");
			return false;
		 }*/
	 }); 
});
function setTotalScore(){
	 $('#actualScore').html(actualScore);
	 $('#targetScore').html(targetScore);
}
function initFix(){
    $('body').layout('fix');
}
function checkGeneralDetails(){
	 if(!validateValue(_id)){
		 generalDetails = { 
			 'empComment': '',
			 'empGoals': '',
			 'dmComment': '',
			 'hrComment': '',
			 'areastoImprv': '',
			 'trainingNeeded': '',
			 'evaluationStatus': 0, 
			 'evltnEmp': '',
			 'id': ''
		 };
	 }
     setGeneralCommentCount(); 

}
function sendNotificationToManager(){ 
	var empcomment = document.getElementById('finalComment');
	var empgoals = document.getElementById('goalsCommnt');
    var empcommentold = generalDetails['empComment'];
    var empgoalsold = generalDetails['empGoals'];
    
	if(empcommentold == null || empcommentold == ''){
			if(empcomment == null || (empcomment != null && empcomment.value == '')){
				alert("Please add Employee Final Comment and save");
				return false;
			}
	}
	if(empgoalsold == null || empgoalsold == ''){
		if(empgoals == null ||  (empgoals != null && empgoals.value == '')){
			alert("Please add Employee Goals and Professional Development and save");
			return false;
		}
	}
	 if ((confirm('Please make sure that you commented against manager ratings(If any), self goal and final comments. Any changes after submit is not possible. Are You sure, You Want to submit to Manager!'))) { 
		 $('#laoding').show(); 
			 $.ajax({
				 type: _method,
		   	 url: _url, 
		   	 data: {action: "ntfyMngr",hr0:'${PROFILE.managerCode}', hr1:evaluationYear, hr2: evaluationTerm, hr3:'${PROFILE.empName}', hr4: '${PROFILE.manager}', hr5:_id},
		    success: function(data) { 
		   	 if(data.actionStatus == 1){ 
		   		 $('#notification-btn-box').css( { display:'none'}); employeeEntryActiveOrNot = 1; managerEntryActiveOrNot = 0;  
		   		setStyleForUpdateBtns();
		   		 launch_notification('Submited to Manager and Email notification sent successfully!.');
		   		 }else{alert("Mail not send. Please refresh page and try again");}   	
		   	 $('#laoding').hide();  
		   	 
		    },error:function(data,status,er) { 
		   	 $('#laoding').hide();
		   	 alert("Notification Not Send,Please refresh the page and try gain!."); 		   	
		   	 }
		  });
	   return true;
	} else{return false;} 
}

function checkEmployeesComentCount(){   
	 $('#laoding').show(); 
	 $.ajax({
	type: _method,
   	 url: _url, 
   	 data: {action: "chkEmpCmntCount", hr1:evaluationYear, hr2: evaluationTerm,  hr3:_id},
    success: function(data) {  
    	$('#laoding').hide();   
    	if(parseInt(data) > 0){
    		sendNotificationToManager();
    	}else{
     		alert("Before Submitting to ${PROFILE.manager}, make sure to finish your comments/part");
    	}
    },error:function(data,status,er) { 
    	 $('#laoding').hide(); 
  		alert("Please refresh  page and try again");	
   	 }
  }); 
	// console.log("result 2", result);
	 return result;
}
function setStyleForUpdateBtns(){
	if(validateValue(_id)){
		if(generalDetails['evaluationStatus']  > 0 || evaluationActvOrNot != 1 || employeeEntryActiveOrNot == 1 || managerEntryActiveOrNot == 0){ 
	
		 $('.actnBtn, .typingBox').prop('disabled', true);	 
		 $('.actnBtn, .finalActnRow, .actionColumn').css( { display:'none'});
		 $('#notification-btn-box').css( { display:'none'});
		 if(evaluationActvOrNot == 1){
			 if( generalDetails['evaluationStatus']  == 0 && employeeEntryActiveOrNot == 1){
				 $('#notification-btn-box').html("");
				 $('#notification-btn-box').html("<b>[ </b><span class='text-info'>Already submitted to ${PROFILE.manager}.<b> ] </b>");
				 $('#notification-btn-box').css( { display:'block'});
			 }
		 } 
		}else{
			 $('.actnBtn').prop('disabled', false);
			 $('.typingBox').prop('disabled', false);
			 $('.actnBtn').css( { display:'inline-block'});
			 $('#notification-btn-box').css( { display:'inline-block'});
		}
	}
}
function setGeneralCommentCount(){ 
	var goals = generalDetails['empGoals'];
	var finalComment = generalDetails['empComment'];
	var dmComment = generalDetails['dmComment'];
	var hrComment = generalDetails['hrComment'];
	var areasToImprComment = generalDetails['areastoImprv'];
	var trainingNeeded = generalDetails['trainingNeeded'];
	if(validateValue(goals)){generalCmmntUpdtdCountByEmp = generalCmmntUpdtdCountByEmp + 1;}
	if(validateValue(finalComment)){generalCmmntUpdtdCountByEmp = generalCmmntUpdtdCountByEmp + 1;}
	if(validateValue(dmComment)){generalCmmntUpdtdCountByMgr = generalCmmntUpdtdCountByMgr + 1;}
	if(validateValue(areasToImprComment)){generalCmmntUpdtdCountByMgr = generalCmmntUpdtdCountByMgr + 1;}
	if(validateValue(trainingNeeded)){generalCmmntUpdtdCountByMgr = generalCmmntUpdtdCountByMgr + 1;}
	if(validateValue(hrComment)){generalCmmntUpdtdCountByHr = generalCmmntUpdtdCountByHr + 1;}

}
function displayCategorySummary(){ 
	
	var output = "";
	$("#categoryList").html(output);
	var classBgEmp, classBgMgr = "";
	if(categorySummary.length > 0){
		output += "<ul class='list-inline catSummarys'>";
		categorySummary.map( item => {
		classBgEmp = (item.updatedContents == item.total_contents)? 'completed' : 'notCompleted';
		classBgMgr = (item.updatedRatings == item.total_contents)? 'completed' : 'notCompleted';
		  output += "<li class='list-inline-item evl-cat-list'>"
           			+"<div class='px-4'>" 
           			+'<div class="btn-group evl-count-btn">'  
           			+'<button type="button"  title="Employee Score" id="emprating_'+item.code+'"onmouseout="resetemprating(\''+item.code+'\',\'emprating_\' );" onmouseover="hilightemprating(\''+item.code+'\',\'emprating_\');" style="border-right: 2px solid #fff !important;"  class="btn btn-employee bg-evl-'+classBgEmp+'">'+item.updatedContents+"/"+item.total_contents+'</button>' 
           			+'<button type="button"  title="Manager Score" id="mgrrating_'+item.code+'"onmouseout="resetemprating(\''+item.code+'\',\'mgrrating_\' );" onmouseover="hilightemprating(\''+item.code+'\',\'mgrrating_\');" class="btn btn-manager bg-evl-'+classBgMgr+'">'+item.updatedRatings+"/"+item.total_contents+' </button>'
           			+'</div>'
               	//	+'<div class="evl-count-btn bg-evl-'+classBg+'">'+item.updatedContents+"/"+item.total_contents+'</div>'
               		+'<h5 class="eval-category-title">'+item.code_desc+'</h5>'
               		+"<div>" 
                    +"<span class='btn btn-primary btn-sm viewBtn' id='_vwBtn"+item.code+"' onClick='showCategoryWiseDetails(\""+item.code+"\",\""+item.code_desc+"\" ,this.id)'><i class='fa fa-share' aria-hidden='true'></i> View</span>"
               		+"</div>"
           			+"</div>"
       				+"</li>";
	});
    output += getGeneralComments();
	output += "</ul>";
	}else{output += " No Data Found";}
	$("#categoryList").html(output); 
	adjustWrapperHeight();
}
function hilightemprating(itemcode,id) {
  // alert("item code"+id);
     img = document.getElementById(id+itemcode);
    img.style.transform = "scale(2.0)";    
    // Animation effect
    img.style.transition = "transform 0.25s ease";
  }
function resetemprating(itemcode,id) {
    // Set image size to 1.5 times original
     img = document.getElementById(id+itemcode);
     img.style.transform = "scale(1)";
    // Animation effect
    img.style.transition = "transform 0.25s ease";
  }
function adjustWrapperHeight(){
	$('.content-wrapper').addClass("cutomMinHeight");
	$('.content-wrapper').css('max-height', '100%');
}
function getGeneralComments(){
	var genclassBgEmp, genclassBgMgr = "" , genclassBgHr = "";
	genclassBgEmp = (generalCmmntUpdtdCountByEmp == 2)? 'completed' : 'notCompleted';
	genclassBgMgr = (generalCmmntUpdtdCountByMgr == 3)? 'completed' : 'notCompleted';
	genclassBgHr = (generalCmmntUpdtdCountByHr == 1)? 'completed' : 'notCompleted';
	
	return  "<li class='list-inline-item evl-cat-list'>"
			+"<div class='px-4'>" 
			+'<div class="btn-group evl-count-btn">'  
   			+'<button type="button" title="Employee Score" style="border-right: 2px solid #fff !important;"  id="emprating_fnl" onmouseout="resetemprating(\'fnl\',\'emprating_\' );" onmouseover="hilightemprating(\'fnl\',\'emprating_\');" class="btn btn-employee bg-evl-'+genclassBgEmp+'">'+generalCmmntUpdtdCountByEmp+'/2</button>' 
   			+'<button type="button" title="Manager Score" style="border-right: 2px solid #fff !important;"  id="mgrrating_fnl" onmouseout="resetemprating(\'fnl\',\'mgrrating_\' );" onmouseover="hilightemprating(\'fnl\',\'mgrrating_\');" class="btn btn-manager bg-evl-'+genclassBgMgr+'">'+generalCmmntUpdtdCountByMgr+'/3</button>'
   			+'<button type="button" title="HR Score" id="hrrating_fnl" onmouseout="resetemprating(\'fnl\',\'hrrating_\' );" onmouseover="hilightemprating(\'fnl\',\'hrrating_\');" class="btn btn-Hr bg-evl-'+genclassBgHr+'">'+generalCmmntUpdtdCountByHr+'/1</button>'
   			+'</div>'
   			//+'<div class="evl-count-btn bg-evl-'+genclassBg+'">'+generalCmmntUpdtdCountByEmp+'/2</div>'
   			+'<h5 class="eval-category-title">Final Comments</h5>'<%--GENERAL COMMENT EMP SECTION--%>
   			+"<div>" 
        	+"<span class='btn btn-primary btn-sm viewBtn' id='_vwBtnfinal' onClick='showGeneralCommentsDetails(this.id)''><i class='fa fa-share' aria-hidden='true'></i> View</span>"
   			+"</div>"
			+"</div>"
			+"</li>";
}
function showGeneralCommentsDetails(btnId){ 
	preLoader();
	var hrComment = `${EVLMASTER.hrComment}`;
	var imprareas = `${EVLMASTER.areastoImprv}`;
	var trainingneeds = `${EVLMASTER.trainingNeeded}`;
	var trainigNeededDesc =  `${EVLMASTER.trainingNeededDesc}`;
	var output = "<table class='table small table-bordered' id='categoryContentTbl' >"+
	  "<thead style='backgrond:gray;'>"+
	  "<tr><th class='srlColumn'>#</th><th class='contentColumn' colspan='2'>Final Comments</th>"<%-- General --%>
	  +"<th class='actionColumn'>Action</th></tr>"
	  "</thead><tbody>"; 
	 
   	     $('#loading').hide(); 
			 var j=0; 
			 var empAction = 0; 
				if(generalDetails['evaluationStatus']  == 0 &&  employeeEntryActiveOrNot == 0 && evaluationActvOrNot == 1  && managerEntryActiveOrNot == 1){ 
       		 output+="<tr><td>1</td>"+ 
      			"<td class='contentColumn'>Employee Goals and Professional Development</td>"+
      			"<td class='gentypingColumn'><textarea class='typingBox'   id='goalsCommnt'  onkeyup='revertSaveBtnStyle(\"goal"+j+"\", this.id, "+genCommentLength+")'  >"+checkValue(generalDetails['empGoals'])+"</textarea><span class='goalsCommnt'></span></td>"+ 
      	    	'<td class="actionColumn"><button type="button" class="btn btn-primary btn-xs update_details actnBtn" id="goal'+j+'" onClick="updateGeneralContent(1, this.id)">Save</button></td>'+  
     			"</tr>"; 
     		 output+="<tr><td>2</td>"+ 
      			"<td class='contentColumn'>Employee Final Comment</td>"+
      			"<td class='gentypingColumn'><textarea class='typingBox'   id='finalComment' onkeyup='revertSaveBtnStyle(\"final"+j+"\", this.id, "+genCommentLength+")'>"+checkValue(generalDetails['empComment'])+"</textarea><span class='finalComment'></span></td>"+ 
      	    	'<td class="actionColumn"><button type="button" class="btn btn-primary btn-xs update_details actnBtn" id="final'+j+'"  onClick="updateGeneralContent(2, this.id)">Save</button></td>'+  
     			"</tr>"; 
				}else{
					 output+="<tr><td>1</td>"+ 
		      			"<td class='contentColumn'>Employee Goals and Professional Development</td>"+
		      			"<td class='gentypingColumn'>"+checkValue(generalDetails['empGoals']).split("\n").join("<br/>")+"</td>"+ 
		      	    	'<td class="actionColumn"></td>'+  
		     			"</tr>"; 
		     		 output+="<tr><td>2</td>"+ 
		      			"<td class='contentColumn'>Employee Final Comment</td>"+
		      			"<td class='gentypingColumn'>"+checkValue(generalDetails['empComment']).split("\n").join("<br/>")+"</td>"+ 
		      	    	'<td class="actionColumn"></td>'+  
		     			"</tr>"; 
				}
			var dmComment = `${EVLMASTER.dmComment}`;
     		 output+="<tr><td>3</td>"+ 
      			"<td class='contentColumn'>Manager Final Comment</td>"+
      			"<td class='genViewColumn' colspan='2'>"+checkValue(dmComment).split("\n").join("<br/>")+"</td>"+ 
     			"</tr>"; 
      		output+="<tr><td>4</td>"+ 
       			"<td class='contentColumn'>Areas for Improvement</td>"+
       			"<td class='genViewColumn' colspan='2'>"+checkValue(imprareas).split("\n").join("<br/>")+"</td>"+ 
      			"</tr>"; 
      		output+="<tr><td>5</td>"+ 
       			"<td class='contentColumn'>Training Needs</td>"+
       			"<td class='genViewColumn' colspan='2'>"+checkValue(trainigNeededDesc).split("\n").join("<br/>")+"</td>"+ 
      			"</tr>"; 
      		output+="<tr><td>6</td>"+ 
       			"<td class='contentColumn'>HR Comments & Recommendations</td>"+
       			"<td class='genViewColumn' colspan='2'>"+checkValue(hrComment).split("\n").join("<br/>")+"</td>"+ 
      			"</tr>"; 
			 output+="</tbody></table></div>";
			 $("#categoryContent").html(output); 
			 setStyleForViewBtn(btnId);
			 setStyleForUpdateBtns();
			   
}
function disableAllButtons(){  $('.content-wrapper').css({'pointer-events': 'none !important', 'filter': 'blur(1px)'}); }
function enableAllButtons(){ $('.content-wrapper').css({'pointer-events': 'all !important', 'filter': 'none'});	}
function validateUpdatesCounsGenCount(){
	
	var catTotalCount = 0 ;
	var catUpdatedCount = 0
	
	categorySummary.map( item => {
		catTotalCount += item.total_contents;
		catUpdatedCount += item.updatedContents;
	});  
	return ((catTotalCount + 2) == (catUpdatedCount + generalCmmntUpdtdCountByEmp)) ? true : false;

}
function checkCommentValidOrNot(comment, count){
	if(/^[a-zA-Z0-9- ,_\n.]*$/.test(comment) == false){
		alert("Please avoid special character from your  comment except  - , _  . ");
	    return false
	}else{
		if(comment.length > count){
			alert("Maximum characters allowed is "+count+" ");
		}else{
			return true;
		}
		
	}
}
function updateGeneralContent(code, btnId ){ 
	var comment =""; 
	var initialComment = "";
	var field ="" 
	var optn = 0;
	 if(_id == null || _id == '' || _id == 'undefined' || typeof  _id === 'undefined' || typeof(parseInt(_id)) !== 'number'){ 
		 optn = 1;
	 }else if(typeof(parseInt(_id)) === 'number' && _id > 0){
		optn = 2;
	 }else{
		 optn = 0;
	 }
	if(code == 1){// employee goals
		field = 'empGoals';
		initialComment = generalDetails['empGoals'];
		comment = document.getElementById('goalsCommnt').value;
	}else if(code == 2){// employee final comment
		field = 'empComment';
		initialComment = generalDetails['empComment'];
		comment = document.getElementById('finalComment').value;
	}else{
		comment = "";
	}
	
		$('#laoding').show();
		  
		if(validateValue(comment)){
		  if(checkCommentValidOrNot(comment, 1000)){
			 $.ajax({
	    		 type: _method,
	        	 url: _url, 
	        	 data: {action: "updateGnrl", hr0:_id , hr1:comment, hr2:employee, hr3:evaluationYear, hr4: optn, hr5: code, hr6:evaluationTerm},
	         success: function(data) {  
	        	 $('#laoding').hide(); 
	        	 if(data.actionStatus == 1 ){
	        		 if(optn == 1){   _id = data.id; generalDetails['id']=_id;  $('#notification-btn-box').css( { display:'block'});}
	        		 generalDetails[''+field+''] = comment;
	        		 if(!validateValue(initialComment) && generalCmmntUpdtdCountByEmp < 2){
	        			 generalCmmntUpdtdCountByEmp = generalCmmntUpdtdCountByEmp + 1;	        			 
	        			 displayCategorySummary();
	        			 setStyleForViewBtn('_vwBtnfinal');
	        		 }
	        		 changeUpdatedSaveBtnStyle(btnId);
	        		 launch_notification('Your Comments Saved successfully!.'); 
	        	 }else{
	        		 alert("Status not updated,Please refresh the page!."); 
	        	 }
	        	 
	         },error:function(data,status,er) { 
	        	 $('#laoding').hide();
	        	 alert("Status not updated,Please refresh the page!."); 
	        	 
	        	 }
	       });
		  }else{
			  $('#laoding').hide();
		  }
		}else{
			alert("Please type comment");
			$('#laoding').hide();
		}
		
	
	
}
function changeUpdatedSaveBtnStyle(btnId){ 	 
	 $('#'+btnId+'').css( { 'background-color':'green'});
	 $('#'+btnId+'').html("Updated");
}
function remainingCharLength(inputFldId, maxchar){  
	 var len = document.getElementById(inputFldId).value.length; 
	    if(len > maxchar){
	        return false;
	    }
	    else if (len > 0) {
	        $('.'+inputFldId+'').html( "Remaining characters: " +( maxchar - len ) );
	    }
	    else {
	        $('.'+inputFldId+'').html( "Remaining characters: " +( maxchar ) );
	    } 
	
}
function revertSaveBtnStyle(btnId, inputFldId, maxchar){ 
	remainingCharLength(inputFldId, maxchar);
	var buttonText = document.getElementById(btnId).innerHTML;
	if($.trim(buttonText) == 'Updated'){
	 $('#'+btnId+'').css( { 'background-color':'#3c8dbc'});
	 $('#'+btnId+'').html("Save<br/> Changes");
	}
}
function updateCategoryContent( contNo,code, ratingYN, btnId ){  
	var catContObjIndex = categoryContent.findIndex( (item => item.content_number == contNo));	 
	var dmRating = categoryContent[catContObjIndex]['rating'];
	var empCommentInitial = categoryContent[catContObjIndex]['emp_comment']; 
	var dmComment = categoryContent[catContObjIndex]['dm_comment']; 
	var comment = document.getElementById((""+code).concat(contNo)).value;	
	var empAction = 0;
	
	 if(validateValue(empCommentInitial)){
		 empAction = 1;
	 }else{empAction = 0;}
	 
	 
	if(validateValue(dmRating) && $.trim(ratingYN) == 'Y'  && validateValue(_id) ){ // dm
		optn = 3; // update existing in txn
	}else if( $.trim(ratingYN) == 'N' && validateValue(_id) &&  !validateValue(empCommentInitial) && !validateValue(dmComment) ){//dm & emp not commented,  new non rating record
		optn = 2; 
	}else if( $.trim(ratingYN) == 'N' && validateValue(_id) &&  ( validateValue(empCommentInitial) || validateValue(dmComment)) ){// employe alredy update, so new update  in existing
		optn = 3; 
	}else if($.trim(ratingYN) == 'N' && !validateValue(_id) &&  !validateValue(empCommentInitial) &&  !validateValue(dmComment) ){
		optn = 1;
	}else{
		optn = getOptnValue(_id, empAction); 
	}
	
	if(optn == 0){
		alert("Please refresh your page and Try again")
		return false;
	}else if($.trim(ratingYN) == 'Y' && !validateValue(_id) ){
		optn = 0;
		alert("Manager Rating not completed for this, Please try after manager updated rating for this.")
		return false;
	}else{
		$('#laoding').show(); 
		 
		if(validateValue(comment)){
		   if(checkCommentValidOrNot(comment, 500)){
			 $.ajax({
	    		 type: _method,
	        	 url: _url, 
	        	 data: {action: "updateEvlSCtgry", hr0:_id , hr1:code, hr2:contNo, hr3:optn, hr4:comment, hr5:employee, hr6:evaluationYear, hr7:evaluationTerm},
	         success: function(data) {  
	        	 $('#laoding').hide();  
	        	 if(data.actionStatus == 1){
	        		 categoryContent[catContObjIndex]['emp_comment'] = comment;
	        		 if(optn == 1){ _id = data.id; generalDetails['id']=_id;  $('#notification-btn-box').css( { display:'block'});}
	        		 if(empAction == 0  && $.trim(ratingYN) == 'Y'){
	        		 var objIndex = categorySummary.findIndex((obj => obj.code == code ));
	        		 categorySummary[objIndex]['updatedContents'] = categorySummary[objIndex]['updatedContents'] + 1;  
	        		 displayCategorySummary();
	        		 setStyleForViewBtn('_vwBtn'+code+'');
	        		 }	    
	        		 changeUpdatedSaveBtnStyle(btnId);
	        		 launch_notification('Your Comments Saved successfully!.'); 
	        	 }else{
	        		 alert("Status not updated,Please refresh the page!."); 
	        	 }
	        	 
	         },error:function(data,status,er) { 
	        	 $('#laoding').hide();
	        	 alert("Status not updated,Please refresh the page!."); 
	        	 
	        	 }
	       });
		   }else{
				  $('#laoding').hide();
		 }
		}else{
			alert("Please type comment");
			$('#laoding').hide();
		}
		
	}
	
}
function showCategoryWiseDetails(category, description, btnId){ 
	preLoader();
	var output = "<table class='table small table-bordered' id='categoryContentTbl' >"+
		 		  "<thead style='backgrond:gray;'>"+
		 		  "<tr><th class='srlColumn'>#</th><th class='contentColumn'>"+description+"</th><th class='typingColumn'>Employee Comment</th><th class='viewColumn'>Manager Comment</th><th>Rating</th><th class='actionColumn'>Action</th></tr>"
		 		  "</thead><tbody>"; 
	 $.ajax({
		 type: _method,
   	 url: _url, 
   	 data: {action: "viewSCDtls",  hr0:category, hr1:employee, hr2: evaluationYear, hr3: evaluationTerm },
    success: function(data) {
		 categoryContent = data; 
		 var totalRatingForCategory = 0;
		 var totalRatingByManager = 0;
   	     $('#loading').hide(); 
			 var j=0; 
			 var empAction = 0;
			 for (var i in data) { j=j+1;
			 
			 if($.trim(data[i].ratingReqrdOrNot) == 'Y' && !validateValue(data[i].rating) ){
				 totalRatingForCategory = totalRatingForCategory + topRatingValue;
       	output+="<tr><td>"+j+"</td>"+ 
      			"<td class='contentColumn'>"+data[i].content_desc+"</td>"+"<td class='typingColumn'>"+checkValue(data[i].emp_comment).split("\n").join("<br/>")+"</td>"+ 
       	    	"<td class='viewColumn'>"+checkValue(data[i].dm_comment).split("\n").join("<br/>")+"</td>"+"<td >"+getRatingDescription(data[i].rating)+"</td>"+
       	    	'<td class="actionColumn"></td>'+  
     			"</tr>"; 
			 }else if($.trim(data[i].ratingReqrdOrNot) == 'Y' && validateValue(data[i].rating) ){ 
				    totalRatingForCategory = totalRatingForCategory + topRatingValue;
				 	totalRatingByManager = totalRatingByManager + parseInt(data[i].rating);
			       	output+="<tr><td>"+j+"</td><td class='contentColumn'>"+data[i].content_desc+"</td>"; 
			       	if(generalDetails['evaluationStatus']  == 0  &&  employeeEntryActiveOrNot == 0 && evaluationActvOrNot == 1 && managerEntryActiveOrNot == 1 ){ 
			       		output+="<td class='typingColumn'><textarea class='typingBox' onkeyup='revertSaveBtnStyle(\"catContent"+j+"\", this.id, "+catCommentLength+")'  id="+(data[i].code).concat(data[i].content_number)+" >"+checkValue(data[i].emp_comment)+"</textarea><span class="+(data[i].code).concat(data[i].content_number)+"></span></td>"; 
			       	}else{output+="<td class='typingColumn'>"+checkValue(data[i].emp_comment).split("\n").join("<br/>")+"</td>"; }
			       	output+= "<td class='viewColumn'>"+checkValue(data[i].dm_comment).split("\n").join("<br/>")+"</td>"+"<td >"+getRatingDescription(data[i].rating)+"</td>"+
			       	    	'<td class="actionColumn"><button type="button" class="btn btn-primary btn-xs update_details actnBtn" id="catContent'+j+'" onClick="updateCategoryContent('+data[i].content_number+', \''+ data[i].code + '\', \''+data[i].ratingReqrdOrNot+'\', this.id)">Save</button></td>'+  
			     			"</tr>";  
			 }else if($.trim(data[i].ratingReqrdOrNot) == 'N'  ){
			       	output+="<tr><td>"+j+"</td> <td class='contentColumn'>"+data[i].content_desc+"</td>";
			       	
	      		 	if(generalDetails['evaluationStatus']  == 0 &&  employeeEntryActiveOrNot == 0 && evaluationActvOrNot == 1 && managerEntryActiveOrNot == 1){ 
	      		 		output+="<td class='typingColumn'><textarea class='typingBox'  onkeyup='revertSaveBtnStyle(\"catContent"+j+"\", this.id, "+catCommentLength+")'   id="+(data[i].code).concat(data[i].content_number)+" >"+checkValue(data[i].emp_comment)+"</textarea><span class="+(data[i].code).concat(data[i].content_number)+"></span></td>";
			       	}else{output+="<td class='typingColumn'>"+checkValue(data[i].emp_comment).split("\n").join("<br/>")+"</td>"; }
	      		 	output+="<td class='viewColumn'>"+(validateValue(data[i].dm_comment)? (data[i].dm_comment).split("\n").join("<br/>") :"")+"</td>"+
	       	    	"<td id='othrCmntRatingBoxx'><span> N/A</span></td>";
	       	 	if(generalDetails['evaluationStatus']  == 0  &&  employeeEntryActiveOrNot == 0 && evaluationActvOrNot == 1 && managerEntryActiveOrNot == 1 ){
	       	    	output+='<td class="actionColumn"><button type="button" class="btn btn-primary btn-xs update_details actnBtn" id="catContent'+j+'" onClick="updateCategoryContent('+data[i].content_number+', \''+ data[i].code + '\', \''+data[i].ratingReqrdOrNot+'\', this.id)">Save</button></td>';
	       	 	}else{output+='<td class="actionColumn"></td>';  
	       	 	}
	       	    	output+="</tr>";  
	 		}else{ }
		} 	
			 output+="<tr><td colspan='6'><span id = 'othrCmntRatingBox' style='float:right;padding-right:120px'></span></td></tr>";
			 output+="</tbody></table></div>";
			 
			 $("#categoryContent").html(output); 
			 showTotalRatingForEachCategory(totalRatingForCategory, totalRatingByManager, 'othrCmntRatingBox', description);
			 setStyleForViewBtn(btnId);
			 setStyleForUpdateBtns();
    },error:function(data,status,er) {
   	 $('#loading').hide();
   	 alert("No data to display,Please refresh the page!."); }
  });
}
function  showTotalRatingForEachCategory(totalRatingForCategory, totalRatingByManager, divId, description){
	var data = "<b>  Total Score   : </b>"+ "<span class='badge bg-green' > "+totalRatingByManager+"<strong> / </strong>"+totalRatingForCategory+" </span>";
	$('#'+divId+'').html(data);
}
function getRatingDescription(ratingValue){ 
	   return  validateValue(ratingValue) ? (ratings.filter( item => item.ratingCode == ratingValue))[0].ratingDesc : "-";  	 
}
function setStyleForViewBtn(btnId){ 
	$('.viewBtn').removeClass("btn-info"); 
	$('.viewBtn').addClass("btn-primary"); 
	$('#'+btnId+'').addClass("btn-info");
}
function getOptnValue(id, empAction){  
	  if(id == null || id == '' || id == 'undefined' || typeof  id === 'undefined' || typeof(parseInt(id)) !== 'number'){ 
		 return 1;
	 }else if(typeof(parseInt(id)) === 'number' && id > 0){
		 if(empAction == 0 ){
			  return 2;
		 }else if(empAction == 1){
			 return 3;
		 }else{
			 return 0;
		 }
	 }else{
		 return 0;
	 }
} 
function checkRating(value){ 
	 return (value == null || value == '' || value == 'undefined' || typeof  value == 'undefined' || typeof value != 'number' || typeof  value == 'NaN' || value == 'NaN')? '' : $.trim(value);
} 
function checkValue(value){ 
	 return (value == null || value == '' || value == 'undefined' || typeof  value == 'undefined' || typeof  value == 'NaN' || value == 'NaN')? '' : $.trim(value);
} 
function validateValue(value){ 
	 return (value == null || value == '' || value == 'undefined' || typeof  value == 'undefined' || typeof  value == 'NaN' || value == 'NaN')? false : true;
} 
function preLoader(){ $('#loading').show();}  

function clearErrorMessage(){	
	$('#err-msg').html("");    
}
function launch_notification(content) { 
    var x = document.getElementById("notification");
     $("#notification_desc").html(content); 
    x.className = "show";
    setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
}
</script>  
<!-- page Script  end -->
</c:when>
<c:otherwise>
        <body onload="window.top.location.href='logout.jsp'"></body> 
</c:otherwise>
</c:choose>
</html>