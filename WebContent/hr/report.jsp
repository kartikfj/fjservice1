<%-- 
    Document   : HR Evaluation Performance , Reports 
--%>
<%@include file="/hr/header.jsp" %>
<style>
.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {  padding: 3px 5px !important;}.scoreValue{text-align:right;}.reportDtls{text-align:center !important;}
 #fullReport-Box{ height: 842px;
        width: 595px;
        /* to centre page on screen*/
        margin-left: auto;
        margin-right: auto;background: #ecf0f5; display:none;}
        .user-content{font-size:73%;}
        
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
         <c:if test="${fjtuser.emp_code ne 'E000001' }"><li><a href="${selfcontroller}"><i class="fa fa-user"></i><span>Self Evaluation</span></a></li> </c:if>
         <c:if test="${EVLMNGRORNOT ge 1}"><li><a href="${managerController}"><i class="fa fa-users"></i><span>Employee Evaluation</span></a></li></c:if>
         <li  class="active"><a href="${reportController}"><i class="fa fa-table"></i><span>Evaluation Report</span></a></li>            
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
	  		  <%--selection Start --%>
	  		  <div class="row">	  		  
	  		  	<div class="col-md-12 col-xs-12"> 
	  		  		  
					           <form method="POST" action="${reportController}" >       
					   		     <div class="form-group form-inline"> 
					 			  <div class="form-group"  >  
					 			   <select class="form-control form-control-sm"  id="evlYr"  name="evlYr" required> 
					 			    <option value=""> Select Evaluation Year</option>
					 			     <c:forEach var="item" items="${EVLYRS}">
							             <option value="${item.evaluationYear}" ${item.evaluationYear == selectedEvlYear ? 'selected':''} >${item.evaluationYear}</option>
							          </c:forEach> 
					 			   </select>
					 			   <select class="form-control form-control-sm"  id="evlTerm"  name="evlTerm" required> 
					 			   	 <option value=""> Select Evaluation Term</option>
					 			   	 <option  value="1" ${selectedTerm == 1 ? 'selected':''}> Term-1</option>
					 			   	 <option  value="2" ${selectedTerm == 2 ? 'selected':''}> Term-2</option>
					 			   </select>
					 			   <%-- 
									<select class="form-control form-control-sm"  id="employeeList"  name="selectedUser" required> 
									 	 <option value=""> Select Employee</option>
									 	  <option value="${fjtuser.emp_code}" ${fjtuser.emp_code == selected_subordinate ? 'selected':''} >${fjtuser.uname}</option>
							          <c:forEach var="subordinate" items="${EMPLST}">
							             <option value="${subordinate.empCode}" ${subordinate.empCode == selected_subordinate ? 'selected':''} >${subordinate.empName}</option>
							          </c:forEach>   
									 </select>
							    --%>
								</div>
					            <input type="hidden" value="newEvlYrDtls" name="action" /> 
					            <button type="submit" name="refresh" id="refresh" class="btn btn-primary refresh-btn filetrs-r" onclick="preLoader();" ><i class="fa fa-refresh"></i>  View</button>
					            </div>
					            </form>
		 				
	  		  	</div>
	  		  </div>	  		  
	  		  <%-- selection end  --%> 
	  		   
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
			             <span class="margin"><i class="fa fa-info"> - </i>  Maximum rating for each   category is <b>16</b></span><br/>
			             <span class="margin"><i class="fa fa-info"> - </i>  Maximum rating for each question is <b>4</b> </span><br/>
			             <span class="margin"><i class="fa fa-info"> - </i>  No Rating for question 'Other Comments' </span>
			             </P> 
			             
			              <h5 class="box-title"><i class="fa fa-dot-circle-o"></i>Rating Score</h5> 
			             <p> 
			             	<c:forEach items="${EVLRATINGS}" var="rating">
			             		<span class="margin"><a class="label label-default">${rating.ratingCode}</a> - <b>${rating.ratingDesc}</b></span>
			             	</c:forEach>
			             </p>   	
   					</div>
   				  </div>
  				</div>
     		  </div>
	  		  <%-- Help End--%>
	  		  
	  		
	  		  
	  		  <%-- Evaluation Category Count Section Start --%>
	  		  <div class="row">
	  		  	<div class="col-md-6 col-xs-12">
	  		  		 <div class="panel panel-default" id="user-profile-box">
	                     <div class="panel-heading" >
	                        <h5 class="text-primary"> <i class="fa fa-check fa-lg " aria-hidden="true"></i> Employee Performance Summary </h5>
	                     </div>
	                     <div class="panel-body">
					   	<table class="table table-bordered small bordered no-padding table-striped" id="report-table">
                <thead>
                  <tr>
                  <th  rowspan="2" style="vertical-align:middle !important;" >Employees</th> 
                  <th colspan="7" style="text-align:center !important;">Score</th>
				  <th rowspan="2" >Details</th> 
                 <%-- <th rowspan="2" >Graphical<br/> Analysis</th>  --%> 
				</tr><tr>
                  <c:forEach var="category" items="${EVLCATSUMMRY}">
                  <th>${category.code_desc}</th>
                  </c:forEach> 
                  <th>Total</th>                         
                </tr>              
                </thead>
                <tbody id="categoryScore"> 
              </tbody>
              
              </table>
			       		</div>
	  		  		</div>
	  		  </div>
	  		  <c:if test="${fjtuser.role eq 'hrmgr' or fjtuser.role eq 'mg'}">
	  		  <%-- HR MANGER SECTION START --%> 
	  		  	<div class="col-md-6 col-xs-12">
	  		  	 <div class="panel panel-default" id="user-profile-box">
	                     <div class="panel-heading" >
	                        <h5 class="text-primary"> <i class="fa fa-check fa-lg " aria-hidden="true"></i> Evaluation Summary for  All Division</h5>
	                     </div>
	                     <div class="panel-body">
	                     <table  class="table table-bordered  bordered no-padding table-striped"  >
	                       <tr>
	                       <td>Final Report</td><td>
	                       <button  class="btn btn-xs btn-danger" onClick="getEvaluationDetailsForManagment()"><i class="fa fa-eye"></i> View</button> </td>
	                       </tr> 
	                     </table>
	                     </div>
	             </div>
	  		  	</div> 
	  		  <%-- HR MANGER SECTION END --%>
	  		 </c:if>
	  		 </div>
	  		  <%-- Evaluation Category Count Section End   --%>  
	  		  
	  		  <%-- Evaluation Category Content Section Start --%>
	  		  <div class="row category">
	  		  	<div class="col-md-12 col-xs-12" id="categoryContent">
	  		  		
	  		  	</div>
	  		  </div>
	  		  <%-- START FULL REPORT --%>
	  		    <div id="fullReport-Box">
	  		    	
	  		    </div>
	  		  <%-- END FULL REPORT --%>
	  		  <%-- Evaluation Category Content Section  End   --%>  
	  		    <div id="laoding" class="loader" ><img src="resources/images/wait.gif"></div>
	  		    <%-- View Report Start --%>
	  		   <div class="row">
	  		   	   <div class="modal fade" id="excelReport-Modal" role="dialog" >					
					        <div class="modal-dialog" style="width:95%;">
					     		<!-- Modal content-->
							      	<div class="modal-content">
								        	<div class="modal-header">
								         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
								          		<h4 class="modal-title"> </h4>
								        	</div>
								        	<div class="modal-body small" style="overflow-y: scroll;max-height: 75%;margin-top: 0px;margin-bottom: 10px;"> 
								        	<div id="table_div"></div> 
								        	</div>
									        <div class="modal-footer">
									          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									        </div>
								     </div>								     								     
						   	 </div>   	 		   	 
		 			</div>
					<div class="modal fade" id="report_modal-main" role="dialog" >
					
					        <div class="modal-dialog" style="width:95%;">
					     		<!-- Modal content-->
							      	<div class="modal-content">
								        	<div class="modal-header">
								         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
								          		<h4 class="modal-title">  EMPLOYEE PERFORMANCE EVALUATION <span style="margin-right:20%;" class='btn btn-danger btn-xs pull-right' id='downloadReport'><i class="fa fa-lg fa-print" aria-hidden="true"></i> Print</span> </h4>
								        	</div>
								        	<div class="modal-body small" style="overflow-y: scroll;max-height: 75%;margin-top: 0px;margin-bottom: 10px;"> 
								        	<div id="table_div"></div> 
								        	</div>
									        <div class="modal-footer">
									          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									        </div>
								     </div>
								     
								     
						   	 </div>   	 		   	 
		 			</div>
	  
				</div>
	  		    <%-- View Report End --%>
	  		    <%-- Graph Start --%>
	  		   <div class="row"> 
	  		   <div class="modal fade" id="graph_modal-main" role="dialog" tabindex="-1"   aria-hidden="true">
					
					        <div class="modal-dialog" style="s text-align: center;  vertical-align: middle;">
					     		<!-- Modal content-->
							      	<div class="modal-content">
								        	<div class="modal-header">
								         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
								          		<h4 class="modal-title"> </h4>
								        	</div>
								        	<div class="modal-body" > 
								        	<div id="chart_div" ></div> 
								        	</div>
									        <div class="modal-footer">
									          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									        </div>
								     </div>
								     
								     
						   	 </div>   	 		   	 
		 			</div>
	  
	  

				</div>
	  		    <%-- Graph End --%>
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
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<!-- page script start -->
<script> 

var _url = '${reportController}';
var _method = "POST"; 
//google.charts.load('current', {'packages':['corechart', 'line']});
var evaluationYear = '${EVLSETTINGS.evaluationYear}';
var evaluationTerm = '${EVLSETTINGS.evaluationTerm}';
var categorySummary = <%=new Gson().toJson(request.getAttribute("EVLCATSUMMRY"))%>; 
var role= '${fjtuser.role}';
var targetScore = 100;
var categoryScore = <%=new Gson().toJson(request.getAttribute("EMPSCATGRYSCORE"))%>;
var ratings = <%=new Gson().toJson(request.getAttribute("EVLRATINGS"))%>; 
var topRatingValue = Object.keys(ratings).reduce((a, b) => ratings[a].ratingCode > ratings[b].ratingCode ? ratings[a].ratingCode : ratings[b].ratingCode);
var managmentData = [];
$(function(){ 	
	 $('.loader').hide();
	 dispalyCategoryScores();
	 $('#downloadReport').on('click', function(e){	
		 dowlnoadFullReport();
		 });
	 
});
function dispalyCategoryScores(){
	if(categoryScore.length > 0){
		var output = "";
		categoryScore.map( item => { 
			console.log("item df "+item.categoryMapping);
		  output += "<tr>";
		  output += "<td class='scoreEmp'>"+item.subordinateName+"</td>"; 
		  for (var key in item.categoryMapping) {
			    console.log('Key: ' + key + '. Value: ' + item.categoryMapping[key]);
			    output += "<td class='scoreValue'>"+item.categoryMapping[key]+"</td>"; 
			}
		 // output += "<td class='scoreValue'>"+item.adap+"</td>"; 
		 // output += "<td class='scoreValue'>"+item.csrv+"</td>"; 
		//  output += "<td class='scoreValue'>"+item.dlry+"</td>"; 
		 // output += "<td class='scoreValue'>"+item.ipsk+"</td>"; 
		 // output += "<td class='scoreValue'>"+item.ldrp+"</td>"; 
		 // output += "<td class='scoreValue'>"+item.qlty+"</td>"; 
		  output += "<td class='scoreValue'>"+item.total+" / "+targetScore+"</td>";
		  output += "<td class='reportDtls'><span class='btn btn-sm btn-default' onClick='getUserEvaluationDetails(\""+item.subordinateCode+"\", \""+item.total+"\")'><i class='fa  fa-file-pdf-o text-danger' style='font-weight:bold;''></i><span></td>";
		/*  output += "<td class='reportDtls'>"+
		  			"<span class='btn btn-sm btn-default' onClick='getUserGraphicalEvaluation(\""+item.subordinateCode+"\", \""+item.total+"\")'>"+
		  			"<i class='fa fa-line-chart text-success' style='font-weight:bold;''></i><span>"+
		  			"</td>";*/
		  output += "</tr>"; 
	}); 
	}else{output += " No Data Found";}
	$("#categoryScore").html(output); 

}
function getUserGraphicalEvaluation(userId, score){ 
	//google.charts.setOnLoadCallback(getGraph);
	 var output ="<h3></h3>";
	 var ttl ="Graphical Analyis";
	  var output=" Will update soon..!"
	 $("#graph_modal-main  .modal-title").html(ttl); 
	 $("#graph_modal-main .modal-body").html(output);
     $("#graph_modal-main").modal("show");
      
   //google.charts.load('current', {packages: ['corechart', 'line']});

}
function drawBasic() {

	 var data = google.visualization.arrayToDataTable([
         ['Evl. Year', 'Evl. Term-1', 'Evl. Term-2'],
         ['2020',  25,      40],
         ['2021',  62,      48], 
       ]);

       var options = {
         title: 'Employee Performance Analysis - For  Last 2 Years',
         curveType: 'function',
         legend: { position: 'bottom' }
       };

       var chart = new google.visualization.LineChart(document.getElementById('chart_div'));

       chart.draw(data, options);
    }

function getGraph() { 
    var data = google.visualization.arrayToDataTable([
      ['Year', 'Term-1', 'Term-2'], 
      ['2020',  70, 16], 
      ['2021',  30, 45], 
    ]);

    var options = {
    		  'title':'Employee Evaluation Performance For - Last 2 Years Analysis',
			  'vAxis': {title: 'Score' ,  viewWindow:{min:0}
				  ,ticks:[0,10,20, 30, 40, 50, 60, 70, 80, 90, 100]
				  ,gridlines: {  color: "#607d8bcc"}
              },			 
             'is3D':true,
             titleTextStyle: {
   		      color: '#000',
   		      fontSize: 12,
   		      fontName: 'Arial',
   		      bold: true
   		   },
              'chartArea': {
			        top: 25,
			        right: 90,
			        bottom: 50,
			        left: 25,
			        height: '100%',
			        width: '100%'
			      },
			     
			      'height': 380, 
			      'legend': {
			        position: 'right'
			      }
           ,colors: ['#01b8aa', '#EF851C'],
           
           pointSize:10,
           series: {
               0: { pointShape: 'circle'},
               1: { pointShape: 'circle'}
               
           }
    };

    var chart = new google.visualization.LineChart(document.getElementById('chart_div'));

    chart.draw(data, options);
    
   
}
function getUserEvaluationDetails(userId, score){
	 $("#fullReport-Box").html("");	  
	 $("#report_modal-main .modal-body").html("");	 
	if(validateValue(userId) &&  userId.length == 7){ 
	  profileOutput ="", categoryOutput="", generalOutput="",performanceSummary="";
		var obj;
		var output ="";
			 $.ajax({
	    		 type: _method,
	        	 url: _url, 
	        	 data: {action: "viewUsrEvlDtls", hr0:userId, hr1:evaluationYear, hr2:evaluationTerm},
	         success: function(data) {  
	        	 $('#laoding').hide();
	        	 var profile = JSON.parse(data["Profile"]);//JSON.parse(data['map']['Profile']);
	        	 var category = JSON.parse(data["Category"]);//JSON.parse(data['map']['Category']);
	        	 var general = JSON.parse(data["General"]);//JSON.parse(data['map']['General']); 
	        	 profileOutput  +=  getProfileData(profile, score);
	        	 performanceSummary+= showPerformanceSummary(score);
	        	 categoryOutput +=  getCategoryData(category);
	        	 generalOutput  +=  getGeneralData(general);
           	output += profileOutput;
           	output+=performanceSummary;
           	output += categoryOutput;
        	output += generalOutput; 
	        	 $("#fullReport-Box").html(output);	  
	        	 $("#report_modal-main .modal-body").html(output);	        	 
	             $("#report_modal-main").modal("show");
	         },error:function(data,status,er) { 
	        	 $('#laoding').hide();
	        	 alert("Please refresh the page!."); 
	        	 
	        	 }
	       });
		  }else{
			  $('#laoding').hide();
			  alert("Not authorised action, Please refresh your page and try gain");
		  } 		
}
function getEvaluationDetailsForManagment(){   
	 $("#excelReport-Modal .modal-body").html("");	 
	if(role === 'hrmgr' || role === 'mg'){   
		var title = "Evaluation Report for all division "+evaluationYear+" TERM-"+evaluationTerm;
		
		var output ="";
			 $.ajax({
	    		 type: _method,
	        	 url: _url, 
	        	 data: {action: "viewMangmentGeneralReport", hr1:evaluationYear, hr2:evaluationTerm},
	         success: function(data) {  
	        	 $('#laoding').hide();
	        	 var output="<table id='report-excl' class='table table-bordered small'><thead><tr>"+"<th width='10px'>Company</th><th width='30px'>Division</th><th>Employee Code</th> <th>Employee Name</th><th>Evaluator</th>"+
	        	 "<th>Manager</th><th>Actual Score</th><th>Status</th><th>Details</th>"+
	        	 "</tr></thead><tbody>";
	        	 var j=0; for (var i in data) {j=j+1; output+="<tr><td>" + $.trim(data[i].company) + "</td>"+ "<td>" + $.trim( data[i].division ) + "</td>"+"<td>" + $.trim( data[i].employeeCode ) + "</td>"+
	        	 "<td>" + $.trim( data[i].employeeName ) + "</td><td>" + $.trim(data[i].evaluatorName) + "</td>"+ "<td>" + $.trim(data[i].managerName )+ "</td><td>" + $.trim(data[i].total) + "</td>"+
	        	 '<td>' + getStatusDescription($.trim(data[i].status)) + '</td><td><button class="btn btn-xs btn-danger" onClick="getUserEvaluationDetails(\''+$.trim(data[i].employeeCode)+'\',\''+$.trim(data[i].total)+'\')" >View</button></td></tr>'; }
	        	 
	        	
	        	 output+="</tbody></table>";  
	        	 $("#excelReport-Modal .modal-title").html(title);	  
	        	 $("#excelReport-Modal .modal-body").html(output);	        	 
	             $("#excelReport-Modal").modal("show");
	             $('#report-excl').DataTable( {
	            	 "autoWidth": false,
	            	    dom: 'Bfrtip', 
	            	    "columnDefs" : [{"targets":3, "type":"date-eu"}],
	            	    "pageLength": 15,
	            	    "order": [[ 4, "asc" ], [ 3, "asc" ]],
	            	    buttons: [
	            	        {
	            	            extend: 'excelHtml5',
	            	            text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"> Export</i>',
	            	            filename: title,
	            	            title: title,
	            	            messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'	,
	            	        	exportOptions: { columns: ':not(:last-child)', }
	            	        }	            	      	            	       
	            	    ]
	            	} );
	         },error:function(data,status,er) { 
	        	 $('#laoding').hide();
	        	 alert("Please refresh the page!."); 
	        	 
	        	 }
	       });
		  }else{
			  $('#laoding').hide();
			  alert("Not authorised action, Please refresh your page and try gain");
		  } 		
}
function getStatusDescription(status){
	if(status === "Y"){
		return "<b class='text-success'>Evaluation closed successfully.</b>";
	}else if(status === "Y-PD"){
		return "<b class='text-warning'>Evaluation Closed, But Pending discussion with employee</b>";
	}else if(status === "N"){
		return "<b class='text-danger'>Evaluation not closed/started</b>";
	}else if(status === "N-EPE"){
		return "<b class='text-info'>Evaluator submitted to employee. Evaluation Pending With Employee</b>";
	}else if(status === "N-EPM"){
		return "<b class='text-info'>Employee action completed. Evaluation Pending With Evaluator.</b>";
	}else{return "";}
}
function getProfileData(profile, score){
	var output = '<table class="col-md-12 table table-bordered">'+       		 
    '<tbody>'+      		
    '<tr>'+ 
   '<th><span class="user-title">Employee Code :  </span> <span class="user-content">'+profile.empCode+'</span></th>'+
	 '<th><span class="user-title">Employee Name : </span> <span class="user-content">'+profile.empName+'</span></th>'+
	 '<th><span class="user-title">Division :  </span> <span class="user-content">'+profile.division+'</span></th>'+
 	 '<th><span class="user-title">Job Title :  </span> <span class="user-content">'+profile.jobTitle+'</span></th>'+
   '</tr><tr><th><span class="user-title">Evaluation For :  </span> <span class="user-content"> ${EVLSETTINGS.evaluationYear}, TERM-${EVLSETTINGS.evaluationTerm}</span></th>'+ 
   '<th><span class="user-title">Joining Date : </span>'+
   '<span class="user-content">'+$.trim(profile.joiningDate).substring(0, 10).split("-").reverse().join("/")+'</span></th>'+		                                                                      
   '<th><span class="user-title">Manager: </span> <span class="user-content">'+profile.manager+'</span></th>'+    
   '<th ><span class="user-title">Total Score: </span> <span class="user-content">'+score+'<b> / </b>'+targetScore+'</span></th>'+    
'</tr>'+ 		
'</tbody>'+ 			
'</table>';
return output;
}
function showPerformanceSummary (score){
	//var totalpercentage = Math.floor((score/targetScore)*100);
	
	<%--var output = '<table class="col-md-12 table table-bordered" style="width:30%">'+       		 
    '<tbody>'+ 
     '<tr>'+
     '<th colspan="2"><span>Performance Evaluation Summary </span> </th>'+
     '</tr>'+    
     '<tr>'+
     '<td><span class="user-content">Overall Your Performance Rating</span></td>'+
     '<td><span class="user-content">'+totalpercentage+'%</td>'+	
	 '</tr>'+
  '</tbody>'+ 			
 '</table>'; --%>
 var output = '<table class="col-md-12 table table-bordered">'+       		 
 '<tbody>'+ 
 <%--  '<tr>'+
  '<th colspan="5"><span>Performance Scale </span> </th>'+ 
  '</tr>'+  --%>
  '<tr>'+
  '<td rowspan="2"><h3><span class="user-content">Performance Evaluation Summary</span></h3></td>'+ 
     '<td width="15%"><span class="user-content">90 & above </span></td>'+
	 '<td width="15%"><span class="user-content">80 - 89 </span></td>'+
	 '<td width="15%"><span class="user-content">70 - 79  </span></td>'+
	 '<td width="15%"><span class="user-content">60 - 69  </span></td>'+
	 '<td width="15%"><span class="user-content">59 & below  </span></td>'+
'</tr>'+
'<tr>'+ 
  '<td><span class="user-content">Excellent </span></td>'+
  '<td><span class="user-content">Very Good </span></td>'+
  '<td><span class="user-content">Good  </span></td>'+
  '<td><span class="user-content">Average  </span></td>'+
  '<td><span class="user-content">Poor  </span></td>'+
'</tr>'+
'</tbody>'+ 			
'</table>';
return output;
}
function getCategoryData(category){
	
	var output ="";
	var uniqueCategories = [...new Set(category.map(item => item.code_desc))]; 
	uniqueCategories.map( categoryDesc => {		
		var finalratingbycate = 0;
		totalRatingForCategory = 0;
		output +='<table class="col-md-12 table table-bordered small"><thead>'+
		'<tr><th width="1%">SL</th><th width="49%">'+categoryDesc+'</th><th width="20%">Employee Comment</th><th width="20%">Manager Comment</th><th width="10%">Rating</th></tr></thead><tbody>';
		category.map( item => {
			if($.trim(item.code_desc) == $.trim(categoryDesc)){
				finalratingbycate = finalratingbycate+item.finatRating;	
		        output += 	'<tr><td>'+item.content_number+'</td><td>'+item.contentDetails+'</td><td>'+checkValue(item.emp_comment).split("\n").join("<br/>")+'</td><td>'+checkValue(item.dm_comment).split("\n").join("<br/>")+'</td>';
				 if($.trim(item.ratingReqrdOrNot) == 'Y'){
					 totalRatingForCategory = totalRatingForCategory + topRatingValue;
					 output +=  '<td>'+getRatingDescription(item.finatRating)+'</td></tr>';
					}else{
						 output +=  '<td> <b> Score By Category: </b> <span class="badge bg-green" > <b id="actualScroreCategory">'+finalratingbycate+"</b><strong> / </strong><span>"+totalRatingForCategory +'</span> </span></td></tr>';
						}
					}
			});		
	 });

	  output += '</tbody></table>';
	  return output;
}
function getGeneralData(general){
	var output ="";
	output +="<div class='general'><h5 class='generalHTitle'>GOALS AND PROFESSIONAL DEVELOPMENT </h5>";
	output +="<p class='generalPBlock'>"+checkValue(general.empGoals).split("\n").join("<br/>")+"</p>"; 
	output +="</div><div class='general'><h5 class='generalHTitle'>EMPLOYEE<sup>'</sup>S COMMENTS</h5>";
	output +="<p class='generalPBlock'>"+checkValue(general.empComment).split("\n").join("<br/>")+"</p>";
	output +="</div><div class='general'><h5 class='generalHTitle'>MANAGER<sup>'</sup>S COMMENTS</h5>";
	output +="<p class='generalPBlock'>"+checkValue(general.dmComment).split("\n").join("<br/>")+"</p>";	
	output +="</div><div class='general'><h5 class='generalHTitle'>AREA<sup>'</sup>S FOR IMPROVEMENT</h5>";
	output +="<p class='generalPBlock'>"+checkValue(general.areastoImprv).split("\n").join("<br/>")+"</p>";
	output +="</div><div class='general'><h5 class='generalHTitle'>TRAINING NEEDS</h5>";
	output +="<p class='generalPBlock'>"+checkValue(general.trainingNeeded).split("\n").join("<br/>")+"</p>";
	output +="</div><div class='general'><h5 class='generalHTitle'>HR<sup>'</sup>S COMMENTS & RECOMMENDATIONS</h5>";
	output +="<p class='generalPBlock'>"+checkValue(general.hrComment).split("\n").join("<br/>")+"</p>";
	output +="</div><div class='general'><h5 class='generalHTitle'>Evaluation Closed Status</h5>";
	output +="<p class='generalPBlock'>"+checkValue(general.evlCloseStstus)+"</p></div>";
	return output;
}
function getRatingDescription(ratingValue){ 
    return  validateValue(ratingValue) ? (ratings.filter( item => item.ratingCode == ratingValue))[0].ratingDesc : "-";  
}
function validateValue(value){ 
	 return (value == null || value == '' || value == 'undefined' || typeof  value == 'undefined' || typeof  value == 'NaN' || value == 'NaN')? false : true;
}
function checkRating(value){ 
	 return (value == null || value == '' || value == 'undefined' || typeof  value == 'undefined' || typeof value != 'number' || typeof  value == 'NaN' || value == 'NaN' )? '' : $.trim(value);
} 
function checkValue(value){ 
	 return (value == null || value == '' || value == 'undefined' || typeof  value == 'undefined' || typeof  value == 'NaN' || value == 'NaN' )? '' : $.trim(value);
}
function dowlnoadFullReport(){ 	    
      		    var printArea = document.getElementById("fullReport-Box").innerHTML;
                var printFrame = document.createElement('iframe');
                printFrame.name = "printFrame";
                printFrame.style.position = "absolute";
                printFrame.style.top = "-1000000px";
                document.body.appendChild(printFrame);
                var printFrameDoc = 
					    (printFrame.contentWindow) ? printFrame.contentWindow 
					    : (printFrame.contentDocument.document) ? printFrame.contentDocument.document : printFrame.contentDocument;
                printFrameDoc.document.open();
                printFrameDoc.document.write('<html><head><title>FJ Group, Employee Performance Evaluation</title>');
    			printFrameDoc.document.write('<link href="././resources/abc/style.css" rel="stylesheet" type="text/css" />');
    			printFrameDoc.document.write('<link href="././resources/abc/responsive.css" rel="stylesheet" type="text/css" />');
    			printFrameDoc.document.write('<link rel="stylesheet" href="././resources/abc/bootstrap.min.css">'); 
    			printFrameDoc.document.write('<link rel="stylesheet" href="././resources/bower_components/font-awesome/css/font-awesome.min.css">');
    			printFrameDoc.document.write('<link rel="stylesheet" href="././resources/dist/css/skins/_all-skins.min.css">');
    			printFrameDoc.document.write('<link rel="stylesheet" type="text/css" href="././resources/datatables/datatables-fjtco/css/jquery.dataTables.min.css" />');
    			printFrameDoc.document.write('<link rel="stylesheet" type="text/css" href="././resources/datatables/buttons-fjtco/css/buttons.dataTables.min.css" />');
    			printFrameDoc.document.write('<link rel="stylesheet" href="././resources/dist/css/AdminLTE.min.css">');
    			printFrameDoc.document.write('<link rel="stylesheet" href="././resources/css/evaluationReport.css?v=1.0.0">');
                printFrameDoc.document.write('</head><body>');
                printFrameDoc.document.write(printArea);
                printFrameDoc.document.write('</body></html>');
                printFrameDoc.document.close();
                setTimeout(function () {
                    window.frames["printFrame"].focus(); 
                    window.frames["printFrame"].print(); 
                    document.body.removeChild(printFrame);
     //printFrameDoc.document.close();
                }, 500);
                return false;
}

</script>  
<!-- page Script  end -->
</c:when>
<c:otherwise>
        <body onload="window.top.location.href='logout.jsp'"></body> 
</c:otherwise>
</c:choose>
</html>