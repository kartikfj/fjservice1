<%-- 
    Document   : PUMP SERVICE PORTAL , REPORT PAGE 
--%>
<%@include file="/service/header.jsp" %>
<%@page import="com.google.gson.Gson"%> 
<script>var nonSelectedCustTxt = 'Select Field Staff', slctdStaffLsts = 'All';</script>
<script src="resources/js/selectMultiple.js?v=1.0.0"></script> 
<style>
@media only screen and (max-width: 375px) {
 .small-box>.inner>p {font-size: 60px important;}
} 
.txt-trim + [title]  {  border: 5px solid blue;}
table.dataTable td { width:max-content !important;}
table.dataTable{border-collapse: collapse !important;}
.table>tbody>tr>td{line-height: 1.1 !important;vertical-align: middle !important;font-weight: 600; text-align: right;}
table.dataTable thead th{    padding: 3px 8px !important;}
.filetrs-r{ display: inline !important;  margin-bottom: 5px !important;}

.small-box>.inner{color:#009688 !important;text-align:center;}
.sbicon{padding-right: 0px !important;
    padding-left: 0px !important;}
.sbicon img{   padding-top: 5px;  
    z-index: 2;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: center center no-repeat;
    -webkit-background-size: contain;
    -moz-background-size: contain;
    -o-background-size: contain;
    background-size: contain;}
    .small-box{border-radius: 7px;}
.sb{   background: linear-gradient(45deg, #fffefe,#ffffff9c);
    -webkit-box-shadow: 0px 0px 15px #9ba8b1;
    -moz-box-shadow: 0px 0px 15px #9ba8b1;
    box-shadow: 0px 0px 15px #9ba8b1;
    border: 1px solid #9ba8b1c9;
    height: 75px !important; }
    .sb h3{    font-size: 25px;}
.sb2{    background: linear-gradient(45deg, #cddc39,#027d72);}
.sb3{background: linear-gradient(45deg, #a954fd,#f09ff5);}
.sb4{background: linear-gradient(45deg, #79c3ff,#0043ef);}
.small-box>.inner>p{	font-family: proxima_nova_rgregular, Arial, sans-serif;
    font-size: 11.28px;
    height: 13.28px;
    text-align: center;
    color: #009688;
    font-weight: bold;
    font-style: normal;
    text-decoration: none;margin-top: -10px;}
    sup{font-size: 60% !important;}
 .box {  
    border-top: 3px solid #2a5779 !important;  
}  .box-header{background:#2a5779 !important;color:#fff !important;} 
.dt-buttons{display:none;}
.serviceGraph{    background: #f9fbfc;
    padding: 0px;
    border-radius: 5px;
    border: 1px solid #009688;margin-left:10px;    margin-bottom: 10px;}
    
   
 .noData{color:red;position: relative;
    top: 40%;
    left: 33%;}
 #slctdStaffLsts{color:#ffeb3b;}

</style>
<body class="hold-transition skin-blue sidebar-mini sidebar-collapse sidebar-mini">
 <c:if test="${empty fjtuser.emp_code}"> <jsp:forward page="index.jsp"/> </c:if>
 <c:choose>
 <c:when test="${!empty fjtuser.emp_code and fjtuser.checkValidSession eq 1}">
 
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
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>

      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
 
          <!-- User Account: style can be found in dropdown.less -->
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
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- Sidebar user panel -->
      <!-- sidebar menu -->
      <ul class="sidebar-menu" data-widget="tree">
         <c:if test="${USRTYP eq 'VU' or USRTYP eq 'MU'  or USRTYP eq 'OU'}">
      	 <li class="active"><a href="ServiceReports"><i class="fa fa-bar-chart"></i><span>Reports</span></a></li>
      	 </c:if>
         <li><a href="ServiceController"><i class="fa fa-table"></i><span>Service Requests</span></a></li>            
         <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>      
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1> Service Reports <small>Service Portal</small></h1>
      <ol class="breadcrumb">
        <li><a href="homepage.jsp"><i class="fa fa-calendar"></i> Home</a></li>
        <li class="active">Service Portal</li>
      </ol>
    </section>   
    <!-- Main content -->	    
	    <%--Office Staff Entry Section Start--%>
	    <section class="content">          	    
	     <div class="row entry-btn-div">
	       <div class="col-md-10 col-xs-12"> 
           <form method="POST" action="ServiceReports" >       
   		     <div class="form-group form-inline">
   		      <input  class="form-control form-control-sm filetrs"   placeholder="Select Start Date"  type="text" id="fromdate" name="fromdate" value="${filters.startDate}" autocomplete="off"   required/>			
			  <input  class="form-control form-control-sm filetrs"    type="text" id="todate" placeholder="Select To Date"  name="todate"  value="${filters.toDate}"  autocomplete="off" required/>	 
 			  <div class="form-group" id="multiSelectFrm"> 
 			   <c:set var="all" value="All" scope="page" /> 
 			   <select class="form-control form-control-sm"   style="margin-top: -5px;" id="divn"  name="divn" required> 	  					 
				    <c:forEach var="item"  items="${DIVNLST}" >
									    <option value="${item.division}" ${item.division == SDIVN ? 'selected':''} >${item.division}</option>				   
			        </c:forEach>      
			   </select>
 			 
			  <select class="form-control form-control-sm"   style="margin-top: -5px;" id="slc"  name="slc" required> 	
				 <option value="All" ${all == SFSL ? 'selected':''} >All</option>
				 <c:if test="${USRTYP ne 'MU'}">						 
				    <c:forEach var="fldUsr"  items="${FUSR}" >
									    <option value="${fldUsr.fldStaffCode}" ${fldUsr.fldStaffCode == SFSL ? 'selected':''} >${fldUsr.fldStaffName}</option>				   
			         </c:forEach> 
			     </c:if>     
			 </select>
			</div>
            <input type="hidden" value="custVw" name="action" />
            	<input type="hidden" value="${USRTYP}" name="usrTyp" />
            <button type="submit" name="refresh" id="refresh" class="btn btn-primary refresh-btn filetrs-r" onclick="preLoader();" ><i class="fa fa-refresh"></i> Refresh Reports</button>
            </div>
            </form>
          </div>
            <%--  <div class="col-md-2 col-xs-12"> <span class="btn btn-warning"  data-toggle="modal" data-target="#modal-serviceUserUpdate"><i class="fa fa-pencil"></i> Update Hourly Rate</span> </div>--%>	 
	     </div> 
	    <%-- BOX DETAILS START --%>	 
	    <div class="row">
	    <div class="col-md-4  col-sm-12 col-xs-12"> 
		        <div class="col-md-6 col-sm-6 col-xs-12">
		          <!-- small box -->
		          <div class="small-box  sb col-xs-12">          
		            <div class="sbicon col-xs-3">
		              <img src="././resources/images/fjsp_productivity.svg" alt="" width="62" height="62" title="fjasp">
		            </div> 
		             <div class="inner col-xs-9">
		              <h3><span id="pdctvtyVal"></span><sup style="font-size: 20px;color:#777 !important;">%</sup></h3>
		
		              <p>Productivity</p>
		            </div>
		          </div>
		        </div>
		        <!-- ./col -->
		        <div class="col-md-6 col-sm-6 col-xs-12">
		          <!-- small box -->
		          <div class="small-box sb col-xs-12">          
		            <div class="sbicon col-xs-3">
		               <img src="././resources/images/fjsp_workinghours.svg" alt="" width="62" height="62" title="fjasp">
		            </div> 
		            <div class="inner  col-xs-9">
		              <h3 id="hrsVal"></h3>
		
		              <p>Avg. Productive Hrs/Day/Person</p>
		            </div> 
		          </div>
		        </div>
		        <!-- ./col -->
		        <div class="col-md-6 col-xs-12">
		          <!-- small box -->
		          <div class="small-box sb col-xs-12">          
		            <div class="sbicon col-xs-3">
		               <img src="././resources/images/fjsp_service.svg" alt="" width="62" height="62" title="fjasp">
		            </div> 
		            <div class="inner col-xs-9">
		              <h3><span id="srvcVal"></span>/<span id="vstsVal"></span></h3> 
		              <p>Avg. Service (Calls Vs Visits) / Day</p>
		            </div> 
		          </div>
		        </div>
		        <!-- ./col -->
		    <!--     <div class="col-md-6 col-sm-6 col-xs-12">
		          small box
		          <div class="small-box sb col-xs-12">          
		            <div class="sbicon col-xs-3">
		               <img src="././resources/images/fjsp_visits.svg" alt="" width="62" height="62" title="fjasp">
		            </div> 
		            <div class="inner col-xs-9">
		              <h3 id="vstsVal"></h3>
		
		              <p>Avg. Service Visit / Day</p>
		            </div> 
		          </div>
        	 </div> -->
         <div class="col-md-6 col-sm-6 col-xs-12">
          <!-- small box -->
          <div class="small-box sb col-xs-12">          
            <div class="sbicon col-xs-3">
               <img src="././resources/images/fjsp_expense.svg" alt="" width="62" height="62" title="fjasp">
            </div> 
            <div class="inner col-xs-9">
              <h3><span id="expVal"></span>&nbsp;<span class="small">AED</span></h3>

              <p>Avg. Service Expnd. / Day</p>
            </div> 
          </div>
        </div>
       </div>
        <!-- ./col -->
        <div class="col-md-8 col-sm-12 col-xs-12">
	         <div class="col-md-5 col-sm-12 col-xs-12 serviceGraph">
	        	 <div id="srvcTypVsCalls" style="width: 100%; height: 200px;"></div>
	         </div> 
	         <div class="col-md-5 col-sm-12 col-xs-12 serviceGraph">
	        	 <div id="srvcTypVsCost" style="width: 100%; height: 200px;"></div>
	         </div>
        </div>
      </div>
      
	    <%-- BOX DETAILS END --%>    
	    <%-- TABLUAR DETAILS START --%>
	   <div class="row">
        <div class="col-lg-12 col-md-12 col-xs-12">
          <div class="box box-default">
            <div class="box-header">
              <h3 class="box-title pull-left"><b>SERVICE REPORT DETAILS FROM ${filters.startDate} TO ${filters.toDate} </b></h3>
              <button class="btn btn-sm btn-danger pull-right" id="ExportReporttoExcel"><i class="fa fa-file-excel-o"></i> Download</button>
               <span class="small pull-left"> ( Total Days : <b id="totSelcdDays"></b> || Active Days : <b id="actvDays"></b>)</span>
              <%-- <br/><span class="small pull-left"> Selected Field Staff : <b id="slctdStaffLsts"></b></span>--%>
              </div> 
            <!-- /.box-header --> 
            <div class="box-body table-responsive small">
              <table class="table table-bordered small bordered no-padding" id="report-table">
                <thead>
                  <tr>
                  <th>Service Type.</th> 
                  <th>Total <br/> Services Call</th>
                  <th>Total <br/> Visits</th>
                  <th>Total <br/> Man Power</th>  
                  <th>Total <br/> Service Hours</th> 
                  <th>Total <br/> Cost Incurred</th> 
                  <%-- <th>Total <br/> Other Expense</th>  --%>           
                </tr>                
                </thead>
                <tbody> 
                <c:forEach var="reports" items="${SRVSRPRTS}" >    
	                <tr>
	                  <td style="text-align:left !important;">${reports.type}</td> 
	                  <td>${reports.totalServiceCalls}</td> 
	                  <td>${reports.totalVisits}</td> 
	                  <td>${reports.totalManPwr}</td>  
	                  <td>${reports.totalServiceHrs}</td>  
	                  <td>${reports.totalCost}</td>
	                  <%-- <td>${reports.totalOtherExp}</td>  --%>  
	                </tr> 
                </c:forEach> 
                <tr style="background-color: #eaeaea !important;text-align:right !important;color:red !important;">
                	  <td>Total</td> 
	                  <td id="totSrvcCallsId"></td> 
	                  <td id="totVstsId"></td> 
	                  <td id="totManPwrId"></td>  
	                  <td id="totHrsId"></td>  
	                  <td id="totCostId"></td>
                </tr>
              </tbody></table>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>  
        <div class="col-xs-12">${MSG}</div>
      </div>
	  <%-- TABULAR DETAILS END --%>
	  	     <div class="modal fade" id="modal-serviceUserUpdate" data-backdrop="static" data-keyboard="false">
          <div class="modal-dialog">
            <div class="modal-content">
              <div class="modal-header etry-vst-modal-header">
                <button type="button" class="close cls-btn-cust" data-dismiss="modal" aria-label="Close">
                  	<span aria-hidden="true">&times;</span></button>
                	<h4 class="modal-title">Service Portal Users</h4>
              </div>
              <div class="modal-body">
                <form id="vstEntry" name="vstEntry">
                <div class="box-body">      						                  
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
	    </section>
	     <div class="row">
	     <div class="col-md-12 col-sm-12">
	      <div id="laoding" class="loader" ><img src="././resources/images/wait.gif"></div>
	     </div> 
	     </div>
    	<%--Field Staff Entry Section End--%>   
    <!-- /.content -->
   </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <div class="pull-right hidden-xs">
      <b>Version</b> 2.0.0
    </div>
    <strong>Copyright &copy; 1988-${CURR_YR} <a href="http://www.faisaljassim.ae">FJ-Group</a>.</strong> All rights reserved.
  </footer>

  
</div>
<script src="././resources/bower_components/select2/dist/js/select2.full.min.js"></script>
<script src="././resources/bower_components/fastclick/lib/fastclick.js"></script>
<script src="././resources/dist/js/adminlte.min.js"></script>
<script src="././resources/bower_components/jquery-knob/js/jquery.knob.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<!-- page script start -->
<script>
var usrTyp = '${USRTYP}';
var title = 'Service Reports From ';
var defStartDate = '${filters.startDate}';
var defEndtDate = '${filters.toDate}';
var reportsList = <%=new Gson().toJson(request.getAttribute("SRVSRPRTS"))%>; 
var holidays = <%=new Gson().toJson(request.getAttribute("holyDYS"))%>; 
var fieldStaffs = <%=new Gson().toJson(request.getAttribute("FUSR"))%>;
var slctdStaffs = `<%=request.getAttribute("SFSL")%>`; 
var fieldStaffUnqueCount = <%=request.getAttribute("UNQFLDSTFCOUNT")%>; 
google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(function (){
	drawServicePieChartCalls('srvcTypVsCalls', 'totalServiceCalls', 'Service type Vs Total Service Calls');
});
google.charts.setOnLoadCallback(function (){
	drawServicePieChartCalls('srvcTypVsCost', 'totalCost', 'Service Type Vs Total Cost Incurred');
});
var totaldays = 0, totSericeCalls = 0, totVisits = 0, totManPwrs = 0, totalServiceHrs = 0, totCostIncurrd = 0, totOthExp = 0, table, holidayList = [];
var totalActiveDays = totalActiveDaysCalculation(defStartDate, defEndtDate);
$(function(){  
	 $('.loader').hide();    	 
	 $("#fromdate").datepicker({ "dateFormat" : "dd/mm/yy", yearRange: "2020:2030", maxDate : 0});
	 $("#todate").datepicker({"dateFormat" : "dd/mm/yy",maxDate : 0 }); 
	 $('#regularisation_list').multiselect({
         includeSelectAllOption: true
     });
	 reportsList.map( (report) => {  
		  totSericeCalls += report.totalServiceCalls;
		  totVisits += report.totalVisits;
		  totManPwrs += report.totalManPwr;
		  totalServiceHrs += report.totalServiceHrs;
		  totCostIncurrd += report.totalCost;
		  totOthExp += report.totalOtherExp;
		}); 	
	 setBoxValues(totalActiveDays);
	 showSelectedStaffList();
     $("#totSrvcCallsId").html(($.isNumeric(totSericeCalls))? formatNumber(totSericeCalls) : 0);
     $("#totVstsId").html(($.isNumeric(totVisits))? formatNumber(totVisits) : 0);
     $("#totManPwrId").html(($.isNumeric(totManPwrs))? formatNumber(totManPwrs) : 0);
     $("#totHrsId").html(($.isNumeric(totalServiceHrs))? formatNumber((totalServiceHrs).toFixed(2)) : 0);
     $("#totCostId").html(($.isNumeric(totCostIncurrd))? formatNumber((totCostIncurrd).toFixed(2)) : 0);
     
	 downloadReports();
	 $("#ExportReporttoExcel").on("click", function() {
		    table.button( '.dt-button' ).trigger();
		});
	
});
 function showSelectedStaffList(){
	 var staffList = 'All';
	 if(slctdStaffs === null || typeof slctdStaffs === 'undefined' || slctdStaffs  === '' || slctdStaffs == 'All' ){
		 staffList = "All";
	 }else{
		 staffList = slctdStaffs;
	 }
	  $("#slctdStaffLsts").html(staffList); 
 }
 function setBoxValues(totalActiveDays){ 
	 // console.log("Active days "+totalActiveDays);
	 // console.log("Mn pwrs "+totManPwrs);
	 var productivity = 0,
	 	 avgPdtctvtyHrsDay = 0,  
	 	 avgServiceCallsDay = 0,
	 	 avgServiceVstDay = 0,
	 	 avgServiceExpediture = 0;
	 
	 if(totalActiveDays > 0){
	  var perDayManpowers = totManPwrs/totalActiveDays;
	  var perDayServiceHrs = totalServiceHrs/ (totalActiveDays * 8 );
	 // console.log(perDayManpowers+" "+totalServiceHrs);
	//  productivity = ((totalServiceHrs/ (8 * totalActiveDays * totManPwrs ) )*100).toFixed(2);
	if(fieldStaffUnqueCount == 0){
		productivity = 0;
		avgPdtctvtyHrsDay = 0;
	}else{
		/*//backup
		 productivity = ((totalServiceHrs/ (8 * totalActiveDays * fieldStaffUnqueCount ) )*100).toFixed(2);
		 avgPdtctvtyHrsDay = (( totalServiceHrs / totalActiveDays) / fieldStaffUnqueCount ).toFixed(2);
		 */
		// console.log("totalServiceHrs : "+totalServiceHrs+" / fieldStaffUnqueCount : "+fieldStaffUnqueCount);
		 productivity = ((totalServiceHrs/ (8 *  fieldStaffUnqueCount ) )*100).toFixed(2);
		 avgPdtctvtyHrsDay = ( totalServiceHrs / fieldStaffUnqueCount ).toFixed(2);
	}
	 
	//  avgPdtctvtyHrsDay = (totalServiceHrs / (8 * totalActiveDays * perDayManpowers ) ).toFixed(2); 
	  
	  avgServiceCallsDay = Math.round(totSericeCalls/totalActiveDays);
	  avgServiceVstDay = Math.round(totVisits/totalActiveDays);
	  avgServiceExpediture = (((totalServiceHrs * 18 ) + totOthExp )/totalActiveDays).toFixed(2) ;
	 }  
	 $("#pdctvtyVal").html(($.isNumeric(productivity))? productivity : 0);
	 $("#hrsVal").html(($.isNumeric(avgPdtctvtyHrsDay))? avgPdtctvtyHrsDay : 0);
	 $("#srvcVal").html(($.isNumeric(avgServiceCallsDay))? avgServiceCallsDay : 0);
	 $("#vstsVal").html(($.isNumeric(avgServiceVstDay))? avgServiceVstDay : 0);
	 $("#expVal").html(($.isNumeric(avgServiceExpediture))? avgServiceExpediture : 0);
	 $("#actvDays").html(totalActiveDays); 
	 $("#totSelcdDays").html(totaldays); 
 }
function preLoader(){ $('#loading').show();}	
function totalActiveDaysCalculation(startDt, endDt) {
	 holidays.map((item)=> {  holidayList.push(item.holiday); });  
	 var activeDays = 0, weekDays = 0;
	 var holidayLength = holidayList.length;
	 var date1 = moment(startDt, "DD/MM/YYYY");
	 var date2 = moment(endDt, "DD/MM/YYYY");
	 totaldays = date2.diff(date1, 'days')+1 ;
	 var currentDay = date1;  
	  while (currentDay.isSameOrBefore(date2)) { 
		  if( (currentDay.day() == 5 && currentDay.year() <= 2021 ) || (currentDay.day() == 6 && currentDay.year() >= 2022 )){		
			  console.log("year "+currentDay.year());
			  weekDays++;
		  }else if(holidayLength > 0 && holidayList.includes(currentDay.format('YYYY-MM-DD'))){ 
			  weekDays++;
			  holidayLength--;
		  }
		  currentDay = currentDay.add(1, 'days');
		
		  }
	  activeDays = totaldays - weekDays;   
	  return (activeDays > 0 )? activeDays : 0;
	}
  function downloadReports(){
	  table = $('#report-table').DataTable({   dom: 'Bfrtip', "paging":   false,
		  //stateSave: true,	  
		   "ordering": false, "info":false, "searching": false,   
	   buttons: [{ extend: 'excelHtml5', text:      '<i class="fa fa-file-excel-o" style="color: #fff; font-size: 1.5em;">Download</i>', filename: title+' '+defStartDate+' to '+defEndtDate+'',
	   title: title+' '+defStartDate+' to '+defEndtDate+'', messageTop: 'The information in this file is copyright to FJ-Group.'}]
	 } ); 
  }
  function formatNumber(num) {
		 if(typeof num !== 'undefined' && num !== '' && num != null){
			 return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
		 }else{ return 0;}
		
		 }
  function drawServicePieChartCalls(id, graphContType, titleDesc) {
		 var arr = []; 
		 arr[0] =  ['Service Type', 'Total Visits'];
		 var j = 0;   
	    reportsList.map( item => {
	      j++;
	      arr[j]=[item.type, item[graphContType]];
	    });
	  var data = google.visualization.arrayToDataTable(arr);
	  var options = {
	    title: titleDesc,
	    is3D: true, 
	    pieSliceTextStyle: {
            color: 'white',
          },  
          slices: {    
              7: {offset: 0.4},
    },
    legend:{ /* position: 'labeled', */ textStyle: {color: 'blue', fontSize: 10, textStyle: {bold:true, fontName: 'monospace'}}},
    chartArea:{left:5,top:20,width:'100%',height:'80%'},
    backgroundColor:{fill: '#f9fbfc'},
    sliceVisibilityThreshold:0, 
	  };
	  if (totSericeCalls == 0) {
		   $("#"+id+"").html("<span class='noData' >No Data Available!</span>"); 
		   $('#srvcTypVsCalls,#srvcTypVsCost').css('background-color','#e1ecf5');		   
		} else {

			  var chart = new google.visualization.PieChart(document.getElementById(id));

			  chart.draw(data, options); 
		}
	}
  function selectAll(box) {
      for(var i=0; i<box.length; i++) {
          box.options[i].selected = true;
      }
  }
  function getSeletedval(){
		
	    var selectedValues = [];    
	    $("#regularisation_list :selected").each(function(){
	        selectedValues.push($(this).val()); 
	    });
	    return true;
	    //alert(selectedValues);
	   
	
}
</script>
<!-- page Script  end -->

</c:when>
<c:otherwise>

        <body onload="window.top.location.href='logout.jsp'">
   
            
        </body>
  
</c:otherwise>
</c:choose>
</html>