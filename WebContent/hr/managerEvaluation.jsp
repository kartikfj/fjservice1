<%-- 
    Document   : HR Evaluation Performance , By Manager 
--%>
<%@include file="/hr/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<style>
   #categoryContentTbl .open>.dropdown-menu {display: block; max-height: 314px !important;overflow-y: scroll;}
  </style>
<body class="hold-transition skin-blue sidebar-mini sidebar-collapse sidebar-mini"  style="height: auto !important; min-height: 100% !important;">
 <c:if test="${empty fjtuser.emp_code}"> <jsp:forward page="index.jsp"/> </c:if>
 <c:choose>
 <c:when test="${!empty fjtuser.emp_code and fjtuser.checkValidSession eq 1}">
  <c:set var="profileController" value="profile" scope="page" />
  <c:set var="selfcontroller" value="SelfEvaluation" scope="page" />
  <c:set var="managerController" value="EmployeeEvaluation" scope="page" />
  <c:set var="reportController" value="EvaluationReport" scope="page" />
  <c:set var="dashboardController" value="HrDashboard" scope="page" />
  <sql:query var="rs" dataSource="jdbc/orclfjtcolocal">
		SELECT TCAT.CATEGORY_CODE,CATEGORY_NAME,SESSION_CODE,SESSION_NAME from TRAINING_CODES TC,TRAINING_CATEGORY TCAT where TC.CATEGORY_CODE = TCAT.CATEGORY_CODE ORDER BY TCAT.CATEGORY_CODE,SESSION_CODE			
  </sql:query> 
       
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
              <li class="header"><a  href="logout.jsp"  style="color: #fffbfb !important;"> <i class="fa fa-power-off"></i> Log-Out</a></li>      
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
        <c:if test="${fjtuser.emp_code ne 'E000001' }"> <li><a href="${selfcontroller}"><i class="fa fa-user"></i><span>Self Evaluation</span></a></li> </c:if>
         <li  class="active"><a href="${mangerController}"><i class="fa fa-users"></i><span>Employee Evaluation</span></a></li>
         <li ><a href="${reportController}"><i class="fa fa-table"></i><span>Evaluation Report</span></a></li>            
         <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>      
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper"  style="height: auto !important; min-height: 100% !important;">
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
	  		  		 <div class="panel panel-default" id="user-profile-box" >
	                     <div class="panel-heading" style="padding: 5px 15px !important;">
	                       <c:if test="${EVLMNGRORNOT ge 1}"> 
				                   <span class="btn btn-default" id="pendingBtn"> <i class="fa fa-circle" id="pendingIcon"></i> Pending <i class="fa fa-lg fa-sort-desc" id="pendingArrow"></i></span>
				            </c:if>					            
	                      <h5 class="text-primary" style="margin-top: -20px !important;"> <i class="fa fa-user pull-left fa-lg" aria-hidden="true"> </i> Employee Profile</h5>  
	                      <c:if test="${EVLMNGRORNOT ge 1}"> 
						       <div class="col-md-12 col-xs-12 pull-right" id="selected-user-box"> 					         
					           <form method="POST" action="${managercontroller}" >       
					   		     <div class="form-group form-inline"> 
					 			  <div class="form-group"  >  
									<select class="form-control form-control-sm"  id="employeeList"  name="selectedUser" required style="height: 30px !important;"> 
									 	 <option value=""> Select Employee</option>
							          <c:forEach var="subordinate" items="${EMPLST}">
							             <option value="${subordinate.empCode}" ${subordinate.empCode == selected_subordinate ? 'selected':''} >${subordinate.empName}</option>
							          </c:forEach>   
									 </select>
								</div>
					            <input type="hidden" value="newUserDtls" name="action" /> 
					            <button type="submit" name="refresh" id="refresh" class="btn btn-primary refresh-btn filetrs-r" onclick="preLoader();"  style="line-height: 0.428571 !important;"><i class="fa fa-refresh"></i>  View</button>
					            </div>
					            </form>
		 					</div>
		 				</c:if>
		 				<c:if test="${fjtuser.role eq 'hrmgr'}"> 
						       <div class="col-md-12 col-xs-12 pull-right" id="selected-user-box"> 					         
					           <form method="POST" action="${managercontroller}" >       
					   		     <div class="form-group form-inline"> 
					 			  <div class="form-group"  >  
									<select class="form-control form-control-sm"  id="hrcomntsemployeeList"  name="selectedUser" required style="height: 30px !important;"> 
									 	 <option value=""> Pending HR Comments For Employees</option>
							          <c:forEach var="pendinghrcomntssubordinatelst" items="${EMPLISTFORHRCMNTS}">
							             <option value="${pendinghrcomntssubordinatelst.employeeCode}" ${pendinghrcomntssubordinatelst.employeeCode == selected_subordinate ? 'selected':''} >${pendinghrcomntssubordinatelst.company} # ${pendinghrcomntssubordinatelst.division} # ${pendinghrcomntssubordinatelst.employeeName}</option>
							          </c:forEach>   
									 </select>
								</div>
					            <input type="hidden" value="newUserDtls" name="action" /> 
					            <button type="submit" name="refresh" id="refresh" class="btn btn-primary refresh-btn filetrs-r" onclick="preLoader();"  style="line-height: 0.428571 !important;"><i class="fa fa-refresh"></i>  View</button>
					            </div>
					            </form>
		 					</div>
		 				</c:if> 
	                     </div>
	                     <div class="panel-body">
		                     <c:choose>
		                     	<c:when test="${!empty selected_subordinate and selected_subordinate ne null}">				                     		
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
			                         			<fmt:formatDate value="${joiingDate}" pattern="dd/MM/yyyy"/>
			                         		</span>  
			                         	</th>		                                                                      
			                         	<th data-title="Manager"><span class='user-title'>Manager: </span> <span class='user-content'>${PROFILE.manager}</span></th>     
		                    	 	</tr> 	
								   </tbody>		
				               	   </table>
		                     	</c:when>
		                     	<c:otherwise><p class="text-default">Please select a employee</p></c:otherwise>
		                     </c:choose>
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
			              <h5 class="box-title"><i class="fa fa-dot-circle-o"></i> Evaluation  Updates Summary </h5> 
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
			             
			              <h5 class="box-title"><i class="fa fa-dot-circle-o"></i> Rating Score</h5> 
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
			              <h5 class="box-title"><i class="fa fa-dot-circle-o"></i> <b>STEP 2.</b> Save ratings for each  employee</h5>
			              <p class="margin">
			              	<span class="margin"><i class="fa fa-info"> - </i>  Select rating</span><br/>
			             	<span class="margin"><i class="fa fa-info"> - </i>  Enter your comments (Not Mandatory)</span><br/>
			             	<span class="margin"><i class="fa fa-info"> - </i>  Click on the "<span class="btn btn-xs btn-primary">Save</span> or <span class="btn btn-xs btn-primary">Save Changes</span>" button to save rating and comment.</span>			                
			              </p>
			              <h5 class="box-title"><i class="fa fa-dot-circle-o"></i> <b>STEP 3.</b>  Submit evaluation to employee </h5>
			              <p class="margin">
			              -> Before closing the evaluation, make sure that employee updated their self goal ,
			               final comment and comments against your rating.
			               <br>  -> For that Click on "<button type="button" class="btn btn-default btn-xs">Submit to Employee for update comments</button>" button after updating your ratings and final comment.
			               <br/> -> After clicking on "Submit" button, Portal will disable data entry option and send a email notification to employee to update their comments.   
			               <br/> -> After employee updated  their comments and submitted to you (Portal send a email notification), <br/>
			              	<span class="margin"><i class="fa fa-info"> - </i>  If any ratings/comments updated, Please submit again to employee (Not Mandatory)</span><br/>
			             	<span class="margin"><i class="fa fa-info"> - </i>  If no need to submit,  Close the evaluation (STEP-4)</span><br/>                	
			              </p>		
			             <h5 class="box-title"><i class="fa fa-dot-circle-o"></i> <b>STEP 4.</b> Close evaluation for employee</h5>
			              <p class="margin">
			              -> Click on any of below buttons under final comment category, both actions will restrict employee and manager further entry
			              	<button type="button" class="btn btn-success btn-xs margin"><i class="fa fa-remove"></i> Close Evaluation With Mutual Understand</button>
       	    				<button type="button" class="btn btn-danger btn-xs margin"><i class="fa fa-remove"></i> Close Evaluation With Pending Discussion </button>
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
	                        <h5 class="text-primary"> <i class="fa fa-check fa-lg " aria-hidden="true"></i> Evaluation Summary	                        
			               <span class="totalScore"><span class="margin text-dark"> || </span> Total Score (<span id="actualScore"></span>/<span id="targetScore"></span>)</span>
	                        </h5>
	                        <c:if test="${empty EVLMASTER.managerEntryActive or EVLMASTER.managerEntryActive eq 0}">                      
	                        	<div class="col-md-12 col-xs-12 pull-right" id="notification-btn-box"> <span class="btn btn-sm btn-default"> <i class="fa fa-envelope"></i>  <b>Submit to  ${PROFILE.empName} for update comments</b></span> </div>
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
	  		 <%-- Pending Modal Start --%>
	  		  <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="modal-pending" id="modal-pending" aria-hidden="true">
  				<div class="modal-dialog modal-lg">
   				 <div class="modal-content">	
   					<div class="modal-header">
                		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
                  		<span aria-hidden="true">&times;</span></button>
                		<h4 class="modal-title"></h4>
              		</div>
              		<div class="modal-body"> 
			    	
   					</div>
   				  </div>
  				</div>
     		  </div>
	  		  <%-- Pending Modal End--%>
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


<link href="././resources/css/regularisation_report.css" rel="stylesheet" type="text/css" />
<script src="././resources/js/regularisation_report.js"></script>

<script src="././resources/bower_components/select2/dist/js/select2.full.min.js"></script>
<script src="././resources/bower_components/fastclick/lib/fastclick.js"></script>
<script src="././resources/dist/js/adminlte.min.js"></script>
<script src="././resources/bower_components/jquery-knob/js/jquery.knob.js"></script>



<!-- page script start -->
<script> 

var _url = '${managercontroller}';
var _method = "POST";     
var employee = '${PROFILE.empCode}';
var evaluationYear = '${EVLSETTINGS.evaluationYear}';
var evaluationTerm = '${EVLSETTINGS.evaluationTerm}';
var generalCmmntUpdtdCountByEmp = 0;
var generalCmmntUpdtdCountByMgr = 0;
var generalCmmntUpdtdCountByHr = 0;
var optn = 0;    
var _id = '${EVLMASTER.id}'; 
var actualScore = '${TOTACTUALSCORE}';
var evaluationActvOrNot = '${EVLACTIVEORNOT}';
var managerEntryActiveOrNot = '${EVLMASTER.managerEntryActive}';
var hrEntryActiveOrNot = '${EVLMASTER.hrEntryActive}';
var empEntryActiveOrNot = '${EVLMASTER.empEntryActive}';
var targetScore = 100;
var categorySummary = <%=new Gson().toJson(request.getAttribute("EVLCATSUMMRY"))%>; 
var generalDetails = <%=new Gson().toJson(request.getAttribute("EVLMASTER"))%>; 
var selectedSubordinate = <%=new Gson().toJson(request.getAttribute("selected_subordinate"))%>; 
var ratings = <%=new Gson().toJson(request.getAttribute("EVLRATINGS"))%>;
var topRatingValue = Object.keys(ratings).reduce((a, b) => ratings[a].ratingCode > ratings[b].ratingCode ? ratings[a].ratingCode : ratings[b].ratingCode);
var totalRatingForCategory = 0;
var totalRatingByManager = 0; 
var categoryContent =[];  
var genCommentLength = 1000;
var catCommentLength = 500;


$(function(){ 	
	 $('.loader').hide();
	 if(validateValue(selectedSubordinate)){ 
	 checkGeneralDetails();
	 displayCategorySummary();
	 setTotalScore();
	 }else{$('#notification-btn-box').css( { display:'none'});$('.totalScore').css( { display:'none'});} 
	 if(!validateValue(employee) || !validateValue(_id) || evaluationActvOrNot != 1 || generalDetails['evaluationStatus']  > 0 || managerEntryActiveOrNot == 1){
		 setStyleForUpdateBtns();
		// $('#notification-btn-box').css( { display:'none'});
		// $('.totalScore').css( { display:'none'});
	 }
	 
		 $('#notification-btn-box').on('click', function(e){	
			 if(validateValue(_id)){
			 sendNotificationToEmployee();
			 }else{ 
					alert("Please update evaluation Ratings/Comment...");
					return false;
				}
		 });
	 $('#pendingBtn').on('click', function(e){	
		showPendingList();
	 });
});
function showPendingList(){ 
	$('#loading').show();
	 $.ajax({
		 type: _method, url: _url,  data: {action: "empPndLst" ,hr1:evaluationYear},
    success: function(data) {
    	$('#loading').hide();
    	if(data.length > 0){
    		 var output ="<h3></h3>";
    		 var ttl ="Evaluation Pending Employees";
    		 var output = "<p class='text-red small'>Please complete rating for below employees and submit to them.</p><table class='table small table-bordered' ><thead style='backgrond:gray;'><tr><th class='srlColumn'>#</th><th>Employee Code</th><th>Employee Name</th></tr></thead><tbody>";
    		 var j=0; 
    		 for (var i in data) { 
    			 j=j+1;
    				output+="<tr><td>"+j+"</td>"+"<td>"+data[i].empCode+"</td>"+"<td>"+data[i].empName+"</td></tr>"; 
    		 }
    		 $("#modal-pending .modal-title").html(ttl); 
    		 $("#modal-pending .modal-body").html(output);
    	     $("#modal-pending").modal("show");
    	}else{
    		alert("No Employees pending for evaluation..");
    	} 
    },error:function(data,status,er) {
   	 $('#loading').hide();
   	 alert("No data to display,Please refresh the page!."); }
  });
}
function setTotalScore(){
	 $('#actualScore').html(actualScore);
	 $('#targetScore').html(targetScore);
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

function buildSelect(selectedRating, id) { 
	var select = document.getElementById(id); 
	var options = "";
	if(!validateValue(selectedRating)){options += '<option value="" selected="selected">Choose Your Rating</option>';}
    ratings.map( (item) => { 
        if (item.ratingCode == selectedRating) { 
        	options += '<option value="' + item.ratingCode + '" selected="selected">' + item.ratingDesc + '</option>';
        }else{
        	options += '<option value="' + item.ratingCode + '">' + item.ratingDesc + '</option>';
        }
 
    }); 
    select.innerHTML = options;  
}
function setStyleForUpdateBtns(){
	if(validateValue(_id)){
		if(generalDetails['evaluationStatus']  > 0 || evaluationActvOrNot != 1 || managerEntryActiveOrNot == 1){
			   if(hrEntryActiveOrNot == 0){
				    $('.actnBtn').prop('disabled', false);
					 $('.typingBox').prop('disabled', false);
					 $('.actnBtn,.actionColumn').css( { display:''});
					 $('.mgactionColumn').css( { display:'none'});					
					 $('#notification-btn-box').css( { display:'inline-block'});
			   }else if(hrEntryActiveOrNot == 1){
				   $('.typingBox').prop('disabled', true);
				   $('.mgactionColumn').css( { display:'none'});		
			   }else{
				 $('.actnBtn, .mgtypingBox').prop('disabled', true);	 
				 $('.actnBtn, .finalActnRow, .mgactionColumn').css( { display:'none'});
				 $('#notification-btn-box').css( { display:'none'});
			    }
			   if(evaluationActvOrNot == 1){
					 if( generalDetails['evaluationStatus']  == 0 && managerEntryActiveOrNot == 1 && empEntryActiveOrNot == 0){
						 $('#notification-btn-box').html("");
						 $('#notification-btn-box').html("<b>[ </b><span class='text-info'>Already submitted to ${PROFILE.empName}.<br/> Employee comments updates pending</span><b> ] </b>");
						 $('#notification-btn-box').css( { display:'block'});
					 }
				 } 
			}else{
			 $('.actnBtn').prop('disabled', false);
			 $('.typingBox').prop('disabled', false);
			 $('.actnBtn,.actionColumn').css( { display:''});
			 $('#notification-btn-box').css( { display:'inline-block'});
		}
	}
}
function adjustWrapperHeight(){
	$('.content-wrapper').addClass("cutomMinHeight");
	$('.content-wrapper').css('max-height', '100%');
}
function setGeneralCommentCount(){  
	var goalsEmployee = generalDetails['empGoals'];
	var finalCommentEmployee = generalDetails['empComment'];
	var dmComment = generalDetails['dmComment'];
	var hrComment = generalDetails['hrComment'];
	var areasToImprComment = generalDetails['areastoImprv'];
	var trainingNeeded = generalDetails['trainingNeeded'];
	//alert("trainingNeeded== "+trainingNeeded);
	//alert("fdf "+areasToImprComment);
	if(validateValue(goalsEmployee)){generalCmmntUpdtdCountByEmp = generalCmmntUpdtdCountByEmp + 1;}
	if(validateValue(finalCommentEmployee)){generalCmmntUpdtdCountByEmp = generalCmmntUpdtdCountByEmp + 1;} 
	if(validateValue(dmComment)){generalCmmntUpdtdCountByMgr = generalCmmntUpdtdCountByMgr + 1;}
	if(validateValue(areasToImprComment)){generalCmmntUpdtdCountByMgr = generalCmmntUpdtdCountByMgr + 1;}
	if(validateValue(trainingNeeded)){generalCmmntUpdtdCountByMgr = generalCmmntUpdtdCountByMgr + 1;}
	if(validateValue(hrComment)){generalCmmntUpdtdCountByHr = generalCmmntUpdtdCountByHr + 1;}

}
function getRatingDescription(ratingValue){
    return  validateValue(ratingValue)? (ratings.filter( item => item.ratingCode == ratingValue))[0].ratingDesc : "-";  	 
}
function setStyleForViewBtn(btnId){  
	$('.viewBtn').removeClass("btn-info"); 
	$('.viewBtn').addClass("btn-primary"); 
	$('#'+btnId+'').addClass("btn-info");
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
           			+'<button type="button" title="Employee Score" style="border-right: 2px solid #fff !important;" id="emprating_'+item.code+'"onmouseout="resetemprating(\''+item.code+'\',\'emprating_\' );" onmouseover="hilightemprating(\''+item.code+'\',\'emprating_\');" class="btn btn-employee  bg-evl-'+classBgEmp+'">'+item.updatedContents+"/"+item.total_contents+'</button>' 
           			+'<button type="button" title="Manager Score" id="mgrrating_'+item.code+'"onmouseout="resetemprating(\''+item.code+'\',\'mgrrating_\' );" onmouseover="hilightemprating(\''+item.code+'\',\'mgrrating_\');" class="btn btn-manager  bg-evl-'+classBgMgr+'">'+item.updatedRatings+"/"+item.total_contents+' </button>'
           			+'</div>'
               		//+'<div class="evl-count-btn bg-evl-'+classBg+'">'+item.updatedContents+"/"+item.total_contents+'</div>'
               		+'<h5 class="eval-category-title">'+item.code_desc+'</h5>'
               		+"<div>" 
                    +'<span class="btn btn-primary btn-sm viewBtn" id="_vwBtn'+item.code+'"   onClick="showCategoryWiseDetails(\''+item.code+'\',\''+item.code_desc+'\' , this.id)"><i class="fa fa-share" aria-hidden="true"></i> View</span>'
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
function getGeneralComments(){
	var genclassBgMgr = ""; var genclassBgEmp = ""; var genclassBgHr = "";
	genclassBgMgr = (generalCmmntUpdtdCountByMgr == 3)? 'completed' : 'notCompleted';
	genclassBgEmp = (generalCmmntUpdtdCountByEmp == 2)? 'completed' : 'notCompleted';
	genclassBgHr = (generalCmmntUpdtdCountByHr == 1)? 'completed' : 'notCompleted';
	return  "<li class='list-inline-item evl-cat-list'>"
			+"<div class='px-4'>" 
			+'<div class="btn-group evl-count-btn">'  
   			+'<button type="button"  title="Employee Score" style="border-right: 2px solid #fff !important;" id="emprating_fnl" onmouseout="resetemprating(\'fnl\',\'emprating_\' );" onmouseover="hilightemprating(\'fnl\',\'emprating_\');" class="btn btn-employee bg-evl-'+genclassBgEmp+'">'+generalCmmntUpdtdCountByEmp+'/2</button>' 
   			+'<button type="button"  title="Manager Score" style="border-right: 2px solid #fff !important;" id="mgrrating_fnl" onmouseout="resetemprating(\'fnl\',\'mgrrating_\' );" onmouseover="hilightemprating(\'fnl\',\'mgrrating_\');"  class="btn btn-manager bg-evl-'+genclassBgMgr+'">'+generalCmmntUpdtdCountByMgr+'/3</button>'
   			+'<button type="button" title="HR Score" id="hrrating_fnl" onmouseout="resetemprating(\'fnl\',\'hrrating_\' );" onmouseover="hilightemprating(\'fnl\',\'hrrating_\');" class="btn btn-Hr bg-evl-'+genclassBgHr+'">'+generalCmmntUpdtdCountByHr+'/1</button>'
   			+'</div>'
   			//+'<div class="evl-count-btn bg-evl-'+genclassBg+'">'+generalCmmntUpdtdCountByEmp+'/1</div>'
   			+'<h5 class="eval-category-title">Final Comments</h5>'<%--GENERAL COMMENT EMP SECTION--%>
   			+"<div>" 
        	+'<span class="btn btn-primary btn-sm viewBtn" id="_vwBtnfinal" onClick="showGeneralCommentsDetails(this.id)"><i class="fa fa-share" aria-hidden="true"></i> View</span>'
   			+"</div>"
			+"</div>"
			+"</li>";
}
function showGeneralCommentsDetails(btnId){ 	
	preLoader();
	var empGoal = `${EVLMASTER.empGoals}`;
	var empFinalComment = `${EVLMASTER.empComment}`;
	var trainigNeeded =  `${EVLMASTER.trainingNeeded}`;
	var existingComment = $("#trainingNeeded").attr("comments");
	if( existingComment != "" && existingComment !== undefined ) {
		trainigNeeded = existingComment;
		//alert("Existing comments: "+trainigNeeded);
	}
	var trainigNeededDesc =  `${EVLMASTER.trainingNeededDesc}`;
	//var emptringcodes = '${EMPTRAININGCODES}';
	var output = "<table class='table small table-bordered' id='categoryContentTbl' >"+
	  "<thead style='backgrond:gray;'>"+	 
	  "<tr><th class='srlColumn'>#</th>"+
	  "<th class='contentColumn' colspan='2'>Final Comments</th>"<%-- General --%>
	  +"<th class='actionColumn'>Action</th></tr>"	  
	  "</thead><tbody>"; 
	
   	     $('#loading').hide();   		
			 var j=0; 
			 var empAction = 0; 
			 output+=  "<tr><td>1</td>"+ 
			   		   "<td class='contentColumn'>Employee Goals and Professional Development</td>"+
			   		   "<td class='genViewColumn' colspan='2'>"+checkValue(empGoal).split("\n").join("<br/>")+"</td>"+ 
			  		   "</tr>"; 
			 output+=  "<tr><td>2</td>"+ 
				   	   "<td class='contentColumn'>Employee Final Comment</td>"+
				   	   "<td class='genViewColumn' colspan='2'>"+checkValue(empFinalComment).split("\n").join("<br/>")+"</td>"+ 
				       "</tr>"; 
	    if( generalDetails['evaluationStatus'] == 0 && evaluationActvOrNot == 1 && managerEntryActiveOrNot == 0){
	   	 output+="<tr><td>3</td>"+ 
			"<td class='contentColumn'>Manager Final Comment</td>"+
			"<td class='gentypingColumn'><textarea class='mgtypingBox'  onkeyup='revertSaveBtnStyle(\"dmFinal"+j+"\", this.id, "+genCommentLength+")'  id='dmComment' >"+checkValue(generalDetails['dmComment'])+"</textarea><span class='dmComment'></span></td>"+ 
	    	'<td class="mgactionColumn" id="dmactionColumn"><button type="button" id="dmactnBtn" class="btn btn-primary btn-xs update_details actnBtn" id="dmFinal'+j+'" onClick="updateGeneralContent(this.id)">Save</button></td>'+  
			"</tr>";
	   	 output+="<tr><td>4</td>"+ 
			"<td class='contentColumn'>Areas for Improvement</td>"+
			"<td class='gentypingColumn'><textarea class='mgtypingBox'  onkeyup='revertSaveBtnStyle(\"areastoImprv"+j+"\", this.id, "+genCommentLength+")'  id='areastoImprv' >"+checkValue(generalDetails['areastoImprv'])+"</textarea><span class='areastoImprv'></span></td>"+ 
	    	'<td class="dmactionColumn"><button type="button" class="btn btn-primary btn-xs update_details actnBtn" id="areastoImprv'+j+'" onClick="updateAreastoimprContent(this.id)">Save</button></td>'+  
			"</tr>";
 		 output+="<tr><td>5</td>"+ 
			"<td class='contentColumn'>Training Needs</td>"+
			"<td class='gentypingColumn'>"+
			"<select id='trainingNeeded' class='form-control form-control-sm' multiple='multiple'>"+    		        
            "<c:forEach var='edu' items='${rs.rows}'>"+	                   
						"<option value='${edu.SESSION_CODE}' >${edu.CATEGORY_NAME} "+" - "+"${edu.SESSION_NAME}</option>"+
			     "</c:forEach>"+ 
		     "</select>"+		    
		    "</td>"+
			//"<td class='gentypingColumn'><textarea class='typingBox'  onkeyup='revertSaveBtnStyle(\"trainingneed"+j+"\", this.id, "+genCommentLength+")'  id='trainingneed' >"+checkValue(generalDetails['trainingneed'])+"</textarea><span class='trainingneed'></span></td>"+
			'<td class="actionColumn"><button type="button" class="btn btn-primary btn-xs update_details actnBtn" id="trainingNeeded'+j+'" onClick="updateTrainingNeededContent(this.id)">Save</button></td>'+
			"</tr>";
 
	    }else{	    	
	    	var dmComment = `${EVLMASTER.dmComment}`
	    	var areastoImprv = `${EVLMASTER.areastoImprv}`
	    	var trainingNeeded = `${EVLMASTER.trainingNeeded}`
	    
	   	    output+="<tr><td>3</td>"+ 
			"<td class='contentColumn'>Manager Final Comment</td>"+
			"<td class='gentypingColumn' colspan='2'>"+checkValue(dmComment).split("\n").join("<br/>")+"</td>"+ 
	    	 
			"</tr>";
	    	output+=  "<tr><td>4</td>"+ 
		   	   "<td class='contentColumn'>Areas for Improvement</td>"+
		   	   "<td class='genViewColumn' colspan='2'>"+checkValue(areastoImprv).split("\n").join("<br/>")+"</td>"+ 
		       "</tr>"; 
	    	 output+=  "<tr><td>5</td>"+ 
		   	   "<td class='contentColumn'>Training Needs</td>"+
		   	   "<td class='genViewColumn' colspan='2'>"+checkValue(trainigNeededDesc).split("\n").join("<br/>")+"</td>"+ 
		       "</tr>"; 
	   	 } 
	   if(generalDetails['evaluationStatus'] == 0 && evaluationActvOrNot == 1 && managerEntryActiveOrNot == 1 && ${fjtuser.role == 'hrmgr'}){ 
	    	 output+="<tr><td>6</td>"+ 
				"<td class='contentColumn'>HR Comments & Recommendations</td>"+
				"<td class='gentypingColumn'><textarea class='typingBox'  onkeyup='revertSaveBtnStyle(\"hrFinal"+j+"\", this.id, "+genCommentLength+")'  id='hrComment' >"+checkValue(generalDetails['hrComment'])+"</textarea><span class='dmComment'></span></td>"+ 
		    	'<td class="actionColumn"><button type="button" class="btn btn-primary btn-xs update_details actnBtn" id="hrFinal'+j+'" onClick="updateHRGeneralContent(this.id)">Save</button></td>'+  
				"</tr>";
	    }else{
	    	var hrComment = `${EVLMASTER.hrComment}`
	    	 output+=  "<tr><td>6</td>"+ 
		   	   "<td class='contentColumn'>HR Comments & Recommendations</td>"+
		       "<td class='gentypingColumn' colspan='2'>"+checkValue(hrComment).split("\n").join("<br/>")+"</td>"+ 	    	 
			   "</tr>";
	    }
	   <%-- if(generalDetails['evaluationStatus'] == 0 && evaluationActvOrNot == 1 && managerEntryActiveOrNot == 1 && ${fjtuser.role == 'hrmgr'}){
	    	 output+="<tr><td>5</td>"+ 
				"<td class='contentColumn'>Areas for Improvement</td>"+
				"<td class='gentypingColumn'><textarea class='typingBox'  onkeyup='revertSaveBtnStyle(\"areastoimprv"+j+"\", this.id, "+genCommentLength+")'  id='areastoimprv' >"+checkValue(generalDetails['areastoimprv'])+"</textarea><span class='areastoimprv'></span></td>"+ 
		    	'<td class="actionColumn"><button type="button" class="btn btn-primary btn-xs update_details actnBtn" id="areastoimprv'+j+'" onClick="updateGeneralContent(this.id)">Save</button></td>'+  
				"</tr>";
	    	 output+="<tr><td>6</td>"+ 
				"<td class='contentColumn'>Training Needs nnnnnn</td>"+
				"<td class='gentypingColumn'>"+
				"<select name='eduction' class='form-control form-control-sm' id='trainingneed'>"+
	       		" <option value='NONE'>Select Education</option>"+        
	               "<c:forEach var='edu' items='${emptringcodes}'>"+	                   
							"<option value='${edu.sessionCode}' >${edu.sessionCode}</option>"+
				     "</c:forEach>"+ 
			     "</select></td>"
				//"<td class='gentypingColumn'><textarea class='typingBox'  onkeyup='revertSaveBtnStyle(\"trainingneed"+j+"\", this.id, "+genCommentLength+")'  id='trainingneed' >"+checkValue(generalDetails['trainingneed'])+"</textarea><span class='trainingneed'></span></td>"+
				'<td class="actionColumn"><button type="button" class="btn btn-primary btn-xs update_details actnBtn" id="areastoimprv'+j+'" onClick="updateGeneralContent(this.id)">Save</button></td>'+
				"</tr>";
	    }else{
	    	 output+=  "<tr><td>5</td>"+ 
		   	   "<td class='contentColumn'>Areas for Improvement</td>"+
		   	   "<td class='genViewColumn' colspan='2'>"+checkValue(empFinalComment).split("\n").join("<br/>")+"</td>"+ 
		       "</tr>"; 
	    	 output+=  "<tr><td>6</td>"+ 
		   	   "<td class='contentColumn'>Training Needs</td>"+
		   	   "<td class='genViewColumn' colspan='2'>"+checkValue(empFinalComment).split("\n").join("<br/>")+"</td>"+ 
		       "</tr>"; 
	    }  --%>
	    if(generalDetails['evaluationStatus'] == 0 && evaluationActvOrNot == 1 && managerEntryActiveOrNot == 1 && ${fjtuser.role == 'hrmgr'}){
     		output+="<tr class='finalActnRow'>"+  
       			"<td class='gentviewColumn text-danger' colspan='4'>"+ 
       	    	<%--'<button type="button" class="btn btn-success btn-xs update_details actnBtn margin"   onClick="closeEvaluation(1);" ><i class="fa fa-remove"></i>'+
       	    	' Close Evaluation With Mutual Understand'+
       	    	 '</button> '+  
       	    	'<button type="button" class="btn btn-danger btn-xs update_details actnBtn margin"   onClick="closeEvaluation(2);" ><i class="fa fa-remove"></i>'+
       	    	' Close Evaluation With Pending Discussion'+
       	    	 '</button> --%>
       	    	 '<button type="button" class="btn btn-success btn-xs update_details actnBtn margin"   onClick="closeEvaluation(1);" ><i class="fa fa-remove"></i>'+
       	    	' Close the Application'+
       	    	 '</button> '+  
       	    	 ' </td>';
	      }	 
      		output +=	"</tr>"; 
			 output+="</tbody></table></div>";
			 $("#categoryContent").html(output); 
			 setStyleForViewBtn(btnId);
			 setStyleForUpdateBtns();
			 $('#trainingNeeded').multiselect({
		        	nonSelectedText: 'Select Training',
		            includeSelectAllOption: true
		        });
			
			 selecttrainingcodes(trainigNeeded);
			   
}


<%--function selecttrainingcodes(trainingNeeded) {
	var comments = trainingNeeded;
	comments = "," + comments + ",";
	var checkboxes = document.querySelectorAll("input[type=checkbox]");
	for(var i=0;i<checkboxes.length;i++) { 
	//console.log("value "+checkboxes[i].value.trim());
	    if( comments.indexOf(","+checkboxes[i].value.trim()+",") != -1 ) {
		checkboxes[i].checked = true;
	    }
	}

	}--%>

function selecttrainingcodes(trainingNeeded) {
var comments = trainingNeeded;
comments = "," + comments + ",";
var checkboxes = document.querySelectorAll("input[type=checkbox]");
for(var i=0;i<checkboxes.length;i++) { 
    if( comments.indexOf(","+checkboxes[i].value.trim()+",") != -1 ) {
	checkboxes[i].checked = true;
	checkboxes[i].id = "trainging_needs_"+checkboxes[i].value.trim();	
	$("#"+checkboxes[i].id).prop("checked",true);
	if( checkboxes[i].parentNode && checkboxes[i].parentNode.parentNode && checkboxes[i].parentNode.parentNode.parentNode ) {
		checkboxes[i].parentNode.parentNode.parentNode.className = "active";
		var optionName = getOptionText(checkboxes[i].value.trim());
		if(  $('.multiselect .multiselect-selected-text')[0].innerHTML != "" ){
			 $('.multiselect .multiselect-selected-text')[0].innerHTML = $('.multiselect .multiselect-selected-text')[0].innerHTML + "," +optionName;
		}else {
			 $('.multiselect .multiselect-selected-text')[0].innerHTML = optionName;
		}
		
		 $('.multiselect .multiselect-selected-text')[0].innerHTML =  $('.multiselect .multiselect-selected-text')[0].innerHTML.replace("Select Training,","");
		$('.multiselect .multiselect-selected-text')[0].style.whiteSpace = "normal"
	    document.getElementsByClassName("multiselect dropdown-toggle btn btn-default")[0].title = $('.multiselect .multiselect-selected-text')[0].innerHTML;
		//alert( $('.multiselect .multiselect-selected-text')[0].innerHTML);
		//$('.multiselect dropdown-toggle btn btn-default')[0].title = $('.multiselect .multiselect-selected-text')[0].innerHTML;
		 
	}
	//checkboxes[i].className = "active";
    }
}

}

function getOptionText(value) {
	try {
		var options = $('option', "#trainingNeeded");
        var valueToCompare = value;

        for (var i = 0; i < options.length; i = i + 1) {
            var option = options[i];
            if (option.value === valueToCompare) {
                 return option.innerHTML;
            }
        };
	}catch(e) {
		console.log("Error in getOptionText : "+e);
	}
	return "";
}


function validateUpdatesCounsGenCount(){
	
	var catTotalCount = 0 ;
	var catUpdatedCount = 0
	
	categorySummary.map( item => {
		catTotalCount += item.total_contents;
		catUpdatedCount += item.updatedContents;
		updatedRatings  += item.updatedRatings;
	});  
	return ((catTotalCount + 1) == (catUpdatedCount + generalCmmntUpdtdCountByMgr)) ? true : false;

}
function sendNotificationToEmployee(){
	var catTotalCount = 0 ;
	var catUpdatedCount = 0
	var updatedRatings =0;
	categorySummary.map( item => {
		catTotalCount += item.total_contents;
		catUpdatedCount += item.updatedContents;
		updatedRatings  += item.updatedRatings;
	});		
	if(updatedRatings<catTotalCount){
		alert("Please fill ratings for all the sections and then submit");
		return false;
	}
	var dmcomment = document.getElementById('dmComment');
	var areastoImprv = document.getElementById('areastoImprv');
	var traingneeded = document.getElementById('trainingNeeded');	
	var dmCommentold = generalDetails['dmComment'];	
	var areasToImprCommentold = generalDetails['areastoImprv'];
	if(dmCommentold == null || dmCommentold == ''){
		if(dmcomment == null || (dmcomment != null && dmcomment.value == '')){
			alert("Please add Manager Final Comment and save");
			return false;
		}
	}
	if(areasToImprCommentold == null || areasToImprCommentold == ''){
		if(areastoImprv == null || (areastoImprv !=null && areastoImprv.value == '')){
			alert("Please add Areas for Improvement and save");
			return false;
		}
	}
	 if ((confirm("Please make sure that, for all the section's ratings completed for ${PROFILE.empName}. Any changes after submit is not possible."))) {
		 $('#laoding').show();
	 $.ajax({
		 type: _method,
    	 url: _url, 
    	 data: {action: "ntfyEmp",hr0:employee, hr1:evaluationYear, hr2: evaluationTerm, hr3:'${PROFILE.empName}', hr4: '${PROFILE.manager}', hr5:_id},
     success: function(data) {
    	 if(data.actionStatus == 1){
    		 $('#notification-btn-box').css( { display:'none'});  managerEntryActiveOrNot = 1; launch_notification('Submited to Employee and Email notification sent successfully!.');
    		 $('.actnBtn, .mgtypingBox').prop('disabled', true);	 
    	}else if(data.actionStatus == -5) {
    		managerEntryActiveOrNot = 0; alert("Not Submitted. Please complete employee evaluation rating")
    	}else{}  	
    	 $('#laoding').hide();  
     },error:function(data,status,er) { 
    	 $('#laoding').hide();
    	 alert("Notification Not Send,Please refresh the page and try gain!."); 
    	 }
   });
	 return true;
		} else{return false;} 
}
function validateMandatoryFields(){
	var dmcomment = document.getElementById('dmComment').value;
	var areastoImprv = document.getElementById('areastoImprv').value;
	var traingneeded = document.getElementById('dmComment').value;
	var dmCommentold = generalDetails['dmComment'];
	var hrComment = generalDetails['hrComment'];
	var areasToImprCommentold = generalDetails['areastoImprv'];
	if(dmCommentold == null){
		if(dmcomment == null || dmcomment == ''){
			alert("Please add Manager Final Comment and save");
			return false;
		}
	}
	if(areasToImprCommentold == null){
		if(areastoImprv == null || areastoImprv == ''){
			alert("Please add Areas for Improvement and save");
			return false;
		}
	}
	if(traingneeded == null || traingneeded == ''){
		alert("Please select Training needed and save");
		return false;
	}
	return true;
}
function closeEvaluation(newEvaluationStatus){ 
	var comment = document.getElementById('hrComment').value; 	
	if(validateValue(_id)){
		if(comment == '' || comment == null){
			alert("Please add HR comments and save");
			return false;
		}
		 if ((confirm('Are You sure, You Want to close this evaluation for ${PROFILE.empName}..! Any changes after closing is not possible.'))) { 
		if(empEntryActiveOrNot == 1){
			 $('#laoding').show(); 
			 $.ajax({
    		 type: _method,
        	 url: _url, 
        	 data: {action: "closeEvl", hr0:_id , hr1:employee, hr2:evaluationYear, hr3:generalDetails['evaluationStatus'],  hr4: evaluationTerm, hr5:'${PROFILE.empName}', hr6: '${fjtuser.uname}', hr7: newEvaluationStatus },
         success: function(data) {  
        	 $('#laoding').hide(); 
        	 if(data.actionStatus == 1 ){
        		 hrEntryActiveOrNot = 1;
            	//$('.typingBox').prop('disabled', true);
    			// $('.actnBtn').css( { display:'none'});
    			 generalDetails['evaluationStatus'] = newEvaluationStatus; 
     			 setStyleForUpdateBtns();
        		 launch_notification('Evaluation Closed successfully!.');
			
			//document.getElementsByClassName('actnBtn').disabled = true;
       		 
        	 }else{
        		 $('#laoding').hide(); 
        		 alert("Evaluation not Closed,Please refresh the page and try again!."); 
        	 }
         },error:function(data,status,er) { 
        	 $('#laoding').hide();
        	 alert("Status not updated,Please refresh the page!."); 
        	 }
       });
		
		 return true;
		}else{
			 $('#laoding').hide(); 
			alert("Before closing evaluation, submit once to ${PROFILE.empName} , for doing his part");
			return false;
		}
	   } else{return false;} 
	}else{
		alert("Please update evalution Ratings/Comments....")
		return false;
	}
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
function updateGeneralContent(btnId){ 
	
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
		field = 'dmComment';
		initialComment = generalDetails['dmComment'];
		comment = document.getElementById('dmComment').value; 	
		$('#laoding').show(); 
		if(validateValue(comment)){
			if(checkCommentValidOrNot(comment, 1000)){
			 $.ajax({
	    		 type: _method,
	        	 url: _url, 
	        	 data: {action: "updateGnrl", hr0:_id , hr1:comment, hr2:employee, hr3:evaluationYear, hr4: optn,  hr5: evaluationTerm},
	         success: function(data) {  
	        	 $('#laoding').hide(); 
	        	 if(data.actionStatus == 1 ){
	        		 if(optn == 1){  _id = data.id;  generalDetails['id']=_id;   $('#notification-btn-box').css( { display:'block'});}
	        		 generalDetails[''+field+''] = comment;
	        		 if(!validateValue(initialComment) && generalCmmntUpdtdCountByMgr < 3 ){
	        			 generalCmmntUpdtdCountByMgr = generalCmmntUpdtdCountByMgr + 1;
	        			 displayCategorySummary();
		        		 setStyleForViewBtn('_vwBtnfinal');
	        		 }
	        		 changeUpdatedSaveBtnStyle(btnId);
	        		 launch_notification('Successfully saved your comment');
		        	 
	        		 
	        	 }else{
	        		 alert("Not updated your comment,Please refresh the page!."); 
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
function updateHRGeneralContent(btnId){ 
	
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
		field = 'hrComment';
		initialComment = generalDetails['hrComment'];
		comment = document.getElementById('hrComment').value; 	
		if(comment == '' || comment == null){
			alert("HR Comments should not be empty");
			return false;
		}
		$('#laoding').show(); 
		if(validateValue(comment)){
			if(checkCommentValidOrNot(comment, 1000)){
			 $.ajax({
	    		 type: _method,
	        	 url: _url, 
	        	 data: {action: "updateHRGnrl", hr0:_id , hr1:comment, hr2:employee, hr3:evaluationYear, hr4: optn,  hr5: evaluationTerm},
	         success: function(data) {  
	        	 $('#laoding').hide(); 
	        	 if(data.actionStatus == 1 ){
	        		 if(optn == 1){  _id = data.id;  generalDetails['id']=_id;   $('#notification-btn-box').css( { display:'block'});}
	        		 generalDetails[''+field+''] = comment;
	        		 if(!validateValue(initialComment) && generalCmmntUpdtdCountByHr < 1 ){
	        			 generalCmmntUpdtdCountByHr = generalCmmntUpdtdCountByHr + 1;
	        			 displayCategorySummary();
		        		 setStyleForViewBtn('_vwBtnfinal');
	        		 }
	        		 changeUpdatedSaveBtnStyle(btnId);
	        		 launch_notification('Successfully saved your comment');
		        	 
	        		 
	        	 }else{
	        		 alert("Not updated your comment,Please refresh the page!."); 
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

function updateAreastoimprContent(btnId){ 
	
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
		field = 'areastoImprv';
		initialComment = generalDetails['areastoImprv'];
		comment = document.getElementById('areastoImprv').value; 	
		if(comment == '' || comment == null){
			alert("Areas to Improve should not be empty");
			return false;
		}
		$('#laoding').show(); 
		if(validateValue(comment)){
			if(checkCommentValidOrNot(comment, 1000)){
			 $.ajax({
	    		 type: _method,
	        	 url: _url, 
	        	 data: {action: "updateAreastoImp", hr0:_id , hr1:comment, hr2:employee, hr3:evaluationYear, hr4: optn,  hr5: evaluationTerm},
	         success: function(data) {  
	        	 $('#laoding').hide(); 
	        	 if(data.actionStatus == 1 ){
	        		 if(optn == 1){  _id = data.id;  generalDetails['id']=_id;   $('#notification-btn-box').css( { display:'block'});}
	        		 generalDetails[''+field+''] = comment;
	        		 if(!validateValue(initialComment) && generalCmmntUpdtdCountByMgr < 3 ){
	        			 generalCmmntUpdtdCountByMgr = generalCmmntUpdtdCountByMgr + 1;
	        			 displayCategorySummary();
		        		 setStyleForViewBtn('_vwBtnfinal');
	        		 }
	        		 changeUpdatedSaveBtnStyle(btnId);
	        		 launch_notification('Successfully saved your comment');
		        	 
	        		 
	        	 }else{
	        		 alert("Not updated your comment,Please refresh the page!."); 
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
function updateTrainingNeededContent(btnId){ 
	
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
		field = 'trainingNeeded';
		initialComment = generalDetails['trainingNeeded'];
		
	  //  $("#trainingNeeded :selected").each(function(){
	    //    selectedValues.push($(this).val()); 
	   // });
	    
	    var selectedValues = [];
	    var checkboxes = document.querySelectorAll("input[type=checkbox]");
	    for(var i=0;i<checkboxes.length;i++) { 
	    	if( checkboxes[i].checked == true ) {
	    		selectedValues.push(checkboxes[i].value);
	    	}
	    	
	    }
	    
		
		comment = selectedValues.toString();//document.getElementById('trainingNeeded').value; 	
		$("#trainingNeeded").attr("comments",comment);
		$('#laoding').show(); 
		if(validateValue(comment)){
			if(checkCommentValidOrNot(comment, 1000)){
			 $.ajax({
	    		 type: _method,
	        	 url: _url, 
	        	 data: {action: "trainingNeeded", hr0:_id , hr1:comment, hr2:employee, hr3:evaluationYear, hr4: optn,  hr5: evaluationTerm},
	         success: function(data) {  
	        	 $('#laoding').hide(); 
	        	 if(data.actionStatus == 1 ){
	        		 if(optn == 1){  _id = data.id;  generalDetails['id']=_id;   $('#notification-btn-box').css( { display:'block'});}
	        		 generalDetails[''+field+''] = comment;
	        		 if(!validateValue(initialComment) && generalCmmntUpdtdCountByMgr < 3 ){
	        			 generalCmmntUpdtdCountByMgr = generalCmmntUpdtdCountByMgr + 1;
	        			 displayCategorySummary();
		        		 setStyleForViewBtn('_vwBtnfinal');
	        		 }
	        		 changeUpdatedSaveBtnStyle(btnId);
	        		 launch_notification('Successfully saved your comment');
		        	 
	        		 
	        	 }else{
	        		 alert("Not updated your comment,Please refresh the page!."); 
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
function updateCategoryRating( contNo,code, ratingYN, btnId ){
	
	var catContObjIndex = categoryContent.findIndex( (item => item.content_number == contNo));
	var rating = 0; 
	if($.trim(ratingYN) == 'Y'){ 
		var initialValue = categoryContent[catContObjIndex]['rating']; // already updated rating value
		rating = document.getElementById(("_rtng"+code).concat(contNo)).value;
	}else if(validateValue(categoryContent[catContObjIndex]['emp_comment'])){
		var initialValue = categoryContent[catContObjIndex]['emp_comment'];
	}else if(validateValue(categoryContent[catContObjIndex]['dm_comment'])){
		var initialValue =  categoryContent[catContObjIndex]['dm_comment'];
	}else{
		var initialValue = "";
	}
	 //alert(initialValue);
	var comment = document.getElementById(("_dmc"+code).concat(contNo)).value; 
	
	var empAction = 0;
	 if(validateValue(initialValue)){
		 empAction = 1;
	 }else{empAction = 0;} 
	optn = getOptnValue(_id, empAction);  
	if(optn == 0){
		alert("Please refresh your page and Try again")
		return false;
	}else{
		$('#laoding').show();
		
		switch($.trim(ratingYN)){
			case "Y":
					if(validateValue(rating) && rating > 0 && rating <= 4 ){
						submitSingleCategoryRatingComment(code, contNo, optn,  comment, empAction,  rating, catContObjIndex, btnId, $.trim(ratingYN));
					}else{
						alert("Please choose a rating");
						$('#laoding').hide();
						
					}
				break;
			case "N":
				if(validateValue(comment)){
					submitSingleCategoryRatingComment(code, contNo, optn,  comment, empAction,  0, catContObjIndex, btnId, $.trim(ratingYN));
				}else{
					alert("Please type comment");
					$('#laoding').hide();
				}
				break;
			 default:
			     break;
		   
		}
		
		
	}
	
}
function submitSingleCategoryRatingComment(code, contNo, optn,  comment, empAction,  rating, catContObjIndex, btnId, ratingYN){
	if(validateValue(selectedSubordinate) && selectedSubordinate.length == 7){
	 if(checkCommentValidOrNot(comment, 500)){
		 $.ajax({
   		 type: _method,
       	 url: _url, 
       	 data: {action: "updateEvlRating", hr0:_id , hr1:code, hr2:contNo, hr3:optn, hr4:comment, hr5: employee, hr6: evaluationYear, hr7: evaluationTerm, hr8: rating, hr9: actualScore, hr10: ratingYN  },
        success: function(data) {  
       	 $('#laoding').hide();
      	 
       	 if(data.actionStatus == 1){
       		 categoryContent[catContObjIndex]['dm_comment'] = comment;
       		
       		
       		 if(optn == 1){   _id = data.id; generalDetails['id']=_id;  $('#notification-btn-box').css( { display:'block'});}
       		 if(empAction == 0 && rating != 0){
       		 var objIndex = categorySummary.findIndex((obj => obj.code == code ));
       		 categorySummary[objIndex]['updatedRatings'] = categorySummary[objIndex]['updatedRatings'] + 1;  
       		 }
       		 
       		 displayCategorySummary();  
       		 setStyleForViewBtn('_vwBtn'+code+'');//only if count updated
       		 changeUpdatedSaveBtnStyle(btnId);
       		 if(ratingYN == 'Y'){  categoryContent[catContObjIndex]['rating'] = rating; setTotalRatingofSingleCategory(); $('#actualScore').html(data.totalScore);}
       		
       		 launch_notification('Successfully saved your Rating/Comment');
       		 
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
		alert("Not authorised to update, Please refresh the page and try gain!");
		$('#laoding').hide();
	}
}
function setTotalRatingofSingleCategory(){
	var rating = 0;
	categoryContent.map(item =>{
		if(validateValue(item.rating)){
		rating = rating + parseInt($.trim(item.rating));
		}
	});
	$('#actualScroreCategory').html(rating);
	
}
function disableAllButtons(){  $('.content-wrapper').css({'pointer-events': 'none !important', 'filter': 'blur(1px)'}); }
function enableAllButtons(){ $('.content-wrapper').css({'pointer-events': 'all !important', 'filter': 'none'});	}
function changeUpdatedSaveBtnStyle(btnId){ 	 
	 $('#'+btnId+'').css( { 'background-color':'green'});
	 $('#'+btnId+'').html("Updated");
}
function showCategoryWiseDetails(category, description, btnId){ 
	preLoader();
	  totalRatingForCategory = 0;
	  totalRatingByManager = 0;
	var output = "<table class='table small table-bordered' id='categoryContentTbl' >"+
		 		  "<thead style='backgrond:gray;'>"+
		 		  "<tr><th class='srlColumn'>#</th><th class='contentColumn'>"+description+"</th><th class='typingColumn'>Employee Comment</th><th class='viewColumn'>Manager Comment</th><th>Rating</th><th class='mgactionColumn'>Action</th></tr>"
		 		  "</thead><tbody>"; 
	 $.ajax({
		 type: _method,
   	 url: _url, 
   	 data: {action: "viewSCDtls",  hr0:category, hr1:employee, hr2: evaluationYear, hr3: evaluationTerm },
    success: function(data) {
		 categoryContent = data; 
   	     $('#loading').hide(); 
			 var j=0; 
			 var empAction = 0;
			 for (var i in data) { j=j+1;
       	output+="<tr><td>"+j+"</td>"+ 
      			"<td class='contentColumn'>"+data[i].content_desc+"</td>"+      			 
       	    	"<td class='viewColumn'>"+checkValue(data[i].emp_comment).split("\n").join("<br/>")+"</td>";
       	    if(generalDetails['evaluationStatus'] == 0 && evaluationActvOrNot == 1 && managerEntryActiveOrNot == 0){
       	    	output+="<td class='typingColumn'><textarea class='mgtypingBox'    onkeyup='revertSaveBtnStyle(\"catContent"+j+"\", this.id,"+catCommentLength+")'  id='_dmc"+(data[i].code).concat(data[i].content_number)+"' >"+checkValue(data[i].dm_comment)+"</textarea><span class='_dmc"+(data[i].code).concat(data[i].content_number)+"'></span></td>";
       	    }else{
       	    	output+="<td class='typingColumn'>"+checkValue(data[i].dm_comment).split("\n").join("<br/>")+"</td>";
       	    }
       	    	if($.trim(data[i].ratingReqrdOrNot) == 'Y'){ 
       	    	 totalRatingForCategory = totalRatingForCategory + topRatingValue;
       	    	 if(validateValue(data[i].rating)){totalRatingByManager = totalRatingByManager + parseInt(data[i].rating);}
       	    	if(generalDetails['evaluationStatus']  > 0  || evaluationActvOrNot != 1 || managerEntryActiveOrNot == 1 ){ 
       	    		if(validateValue(data[i].rating)){
       	    			output+= "<td>"+getRatingDescription(parseInt(data[i].rating))+"</td>";
       	    		}else{output+= "<td></td>";}
       	    		
       	    		
       	    	} else{
       	    		output+= "<td><select class='form-control form-control-sm ' onchange='reverSelectSaveBtnStyle(\"catContent"+j+"\")' id='_rtng"+(data[i].code).concat(data[i].content_number)+"'></select></td>";
       	    	}
       	    	
       	     }else{
       	    	 
       	    	output+= "<td id='othrCmntRatingBoxx'><span> N/A</span><select class='form-control form-control-sm' id='_rtng"+(data[i].code).concat(data[i].content_number)+"'></select></td>";
       	     }
       	  output+= '<td class="mgactionColumn"><button type="button" class="btn btn-primary btn-xs update_details actnBtn" id="catContent'+j+'" onClick="updateCategoryRating('+data[i].content_number+', \''+ data[i].code + '\', \''+data[i].ratingReqrdOrNot+'\', this.id)">Save</button></td>'+  
     			"</tr>"; 
			 } 
			 output+="<tr><td colspan='6'><span id = 'othrCmntRatingBox' style='float:right;padding-right:120px'></span></td></tr>";
			 output+="</tbody></table></div>";
			 $("#categoryContent").html(output); 
			 for (var i in data) {
				 if($.trim(data[i].ratingReqrdOrNot) == 'Y' && generalDetails['evaluationStatus'] == 0 && evaluationActvOrNot == 1  &&   managerEntryActiveOrNot == 0){
			 	buildSelect(data[i].rating,  '_rtng'+(data[i].code).concat(data[i].content_number)+'');
				 }else{ 					  
					 $('#_rtng'+(data[i].code).concat(data[i].content_number)+'').css( { display:'none', disabled: true});
				     
				 }
			 }
			 showTotalRatingForEachCategory(totalRatingForCategory, totalRatingByManager, 'othrCmntRatingBox', description);
			 setStyleForViewBtn(btnId);
			 setStyleForUpdateBtns(); 
    },error:function(data,status,er) {
   	 $('#loading').hide();
   	 alert("No data to display,Please refresh the page!."); }
  });
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
function reverSelectSaveBtnStyle(btnId){  
	var buttonText = document.getElementById(btnId).innerHTML;
	if($.trim(buttonText) == 'Updated'){
	 $('#'+btnId+'').css( { 'background-color':'#3c8dbc'});
	 $('#'+btnId+'').html("Save<br/> Changes");
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
function  showTotalRatingForEachCategory(totalRatingForCategory, totalRatingByManager, divId, description){ 
	var data = "<b>  Total Score   : </b>"+ "<span class='badge bg-green' > <b id='actualScroreCategory'>"+totalRatingByManager+"</b><strong> / </strong><span>"+totalRatingForCategory+"</span> </span>"; 
	$('#'+divId+'').html(data);
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
	 return (value == null || value == '' || value == 'undefined' || typeof  value == 'undefined' || typeof value != 'number' || typeof  value == 'NaN' || value == 'NaN' )? '' : $.trim(value);
} 
function checkValue(value){
	 return (value == null || value == '' || value == 'undefined' || typeof  value == 'undefined' || typeof  value == 'NaN' || value == 'NaN' )? '' : $.trim(value);
} 
function validateValue(value){ 
	 return (value == null || value == '' || value == 'undefined' || typeof  value == 'undefined' || typeof  value == 'NaN' || value == 'NaN'  )? false : true;
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

function selectAll(box) {
    for(var i=0; i<box.length; i++) {
        box.options[i].selected = true;
    }
}
function getSeletedval(){
	
    var selectedValues = [];    
    $("#multiselect :selected").each(function(){
        selectedValues.push($(this).val()); 
    });
    return true;
    //alert(selectedValues);
}
function hilightemprating(itemcode,id) {
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
</script>  
<!-- page Script  end -->
</c:when>
<c:otherwise>
        <body onload="window.top.location.href='logout.jsp'"></body> 
</c:otherwise>
</c:choose>
</html>