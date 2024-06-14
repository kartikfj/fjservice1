<%-- 
    Document   : customerVisitPlanner.js 
--%>
<%@ include file="mainview.jsp" %>
<%@ taglib  prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib  uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@ page    contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.DateFormatSymbols"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="beans.CustomerVisitPlanner"%>
<%@page import="com.google.gson.Gson"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>
<%
  DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
  Calendar cal = Calendar.getInstance();
  int iYear = cal.get(Calendar.YEAR);  
  int iMonth = cal.get(Calendar.MONTH)+1;
  int iDay =  cal.get(Calendar.DATE);
  String cur_uid = (String)(request.getParameter("cur_usr"));
  beans.fjtcouser current_user = null;
  String currCalDtTime = dateFormat.format(cal.getTime());
  request.setAttribute("currCal", currCalDtTime);
  request.setAttribute("currYr", iYear);
  request.setAttribute("currMth", currCalDtTime);
  beans.fjtcouser login_user = (beans.fjtcouser)request.getSession().getAttribute("fjtuser");
  java.util.concurrent.ConcurrentHashMap ml= login_user.getSubordinatelist();
  String thisday = ""+ iYear + "-"+(iMonth+1)+"-"+(iDay);
  if(cur_uid == null ||  login_user.getEmp_code().equals(cur_uid)){
	    current_user=  login_user;
	 }else{
	    current_user =(beans.fjtcouser) ml.get(cur_uid);
	 }
  CustomerVisitPlanner cv = new CustomerVisitPlanner();
  List<CustomerVisitPlanner>  custVisitDays= cv.getMonthlyCustomerVisitDays(iMonth+1, iYear, current_user.getSales_code(), current_user.getEmp_code());
  request.setAttribute("CUSTVISITDAYS",custVisitDays); 
 %>
<head>

<!--  link rel="stylesheet" href="resources/css/dailyTask.css?v=31122020">-->
<link rel="stylesheet" href="resources/timeSelection/jquery.ui.timepicker.css?v=0.3.3" type="text/css" />
<script type="text/javascript" src="resources/timeSelection/ui-1.10.0/jquery.ui.core.min.js"></script>  
<script type="text/javascript" src="resources/timeSelection/jquery.ui.timepicker.js?v=0.3.3"></script>
<link rel="stylesheet" type="text/css" href="resources/datatables/datatables-fjtco/css/jquery.dataTables.min.css" />
<link rel="stylesheet" type="text/css" href="resources/datatables/buttons-fjtco/css/buttons.dataTables.min.css" />
<link rel="stylesheet" type="text/css" href="resources/datatables/datatables-fjtco/css/select.dataTables.min.css" />
<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/dataTables.buttons.min.js"></script>
<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/dataTables.select.min.js"></script>


<script src="https://code.jquery.com/jquery-migrate-3.0.0.min.js"></script>
<!-- <link rel="stylesheet" type="text/css" href="resources/css/bootstrap-clockpicker.min.css"> -->
<link rel="stylesheet" href="resources/bower_components/fullcalendar/dist/fullcalendar.min.css">
<link rel="stylesheet" href="resources/dist/css/AdminLTE.min.css">
<link rel="stylesheet" href="resources/dist/css/skins/_all-skins.min.css">
<link rel="stylesheet" type="text/css" href="resources/abc/style.css?v=27052022-04" />
<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.flash.min.js"></script>
<script type="text/javascript" src="resources/datatables/ajax/excelmake/jszip.min.js"></script>
<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.html5.min.js"></script>
<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.print.min.js"></script> 
<!-- <link href="resources/css/jquery-ui.css" rel="stylesheet"> -->
<script src="resources/js/daily-task.js?v=05052021v9"></script>
<script src="resources/js/customerVisitPlanner.js?v=05052021v9"></script>


 <script type="text/javascript">
     $(document).ready(function() {
    	 
    	   $('#fromTime').timepicker({
               showPeriodLabels: false
           });
    	   $('#toTime').timepicker({
               showPeriodLabels: false
           });
    	   $('#upfromTime').timepicker({
               showPeriodLabels: false
           });
    	   $('#uptoTime').timepicker({
               showPeriodLabels: false
           });
    	 }); 
							      
     
     </script>

<c:set var="actionTypes" value="<%=login_user.getVisitActions()%>" scope="page" />

<script>
var prjectsTable, docId,   projectName, party, visitTpe = 0, action, regOptnSts = 3, fromTime, toTime, actionDesc, visitCount = 0, alrdyUpdtdVstCnt = 0; cvDetails = [];
var today = new Date().toJSON().slice(0,10).split('-').reverse().join('/');
var projects ;  
</script> 
<style>
@media ( max-width : 375px) {
#sid,#caljump{width: 100% !important;}
#frmclock{float:left !important;}
}
.ui-timepicker-table {width: 295px !important;}
#ui-timepicker-div{ background: rgb(6, 86, 133);color:#ffffff;border-radius:5px;} 
.ui-timepicker-hours table td, .ui-timepicker-minutes table td{border: 1px solid #ffffff; }
.ui-timepicker-hour-cell:hover,    .ui-timepicker-minute-cell:hover{background: #03A9F4;color:rgb(6, 86, 133) !important;}        
.ui-timepicker-title{font-weight: bold;}
 .ui-timepicker-hours .ui-timepicker{background: #FFC107 !important; color: #060606 !important;}
 .ui-timepicker-minutes .ui-timepicker{background: #009688 !important; color: #060606 !important;}
 .ui-timepicker-title{font-weight: bold;}
 .ui-state-default{ color:#ffffff !important;}  
#slctSegRegTyp{border-bottom: 1px solid #065685;  padding-top: 0.5em;}
#err-msg{color:red;}
.fc-toolbar::after{content:'Customer Visit Planner can be entered for 15 future days.';color:#f44336;}
.mr-1{margin-right: 5px !important;}
.btn-primary{   margin-top:3px; font-weight:bold;   color: #065685;  background-color: #ffffff; border: 1px solid #065685;}
.modal-header .close {margin-top: -20px !important;}
 .custVisit{
  background:#f9f9f9 !important;
 color:#000 !important; 
     border: 2px solid #286090;
 }
 .cust-scrll-box{overflow: scroll; max-height: 155px;}
  .smalll {font-size: 70%;}
 .fc-view-container{border:1px solid #4696e5 !important;}.fc-unthemed td.fc-today{background: #c2ecff !important;}
 .fc-unthemed td, .fc-unthemed th{border-color:#4696e5 !important;}
 table.dataTable tbody td {padding: 4px 5px !important;font-size: 80% !important;}
 table.dataTable tr.selected, table.dataTable.display tbody>tr.odd.selected>.sorting_1, table.dataTable.display tbody>tr.even.selected>.sorting_1{background:green !important;color:white !important;}
 .taskDetailBox
{
	background:#fff;
	height:max-content;
	padding-bottom:10px;
    box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important;
   
}
.evntdesc{	
	background:white;
	border:1px solid #d2d6de;
	height:max-content;
	padding:7px;
	margin-bottom:5px;
    box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important;
   
	
}
#requestformdiv{width:max-content;z-index: 999;}
#evntDtls .evntdesc .closeon{
    color: white;
    border-radius: 3px;
    padding: 1px 6px;
    border: 1px solid #080808;
    background: #080808;
    cursor: pointer;}
 #evntDtls .evntdesc .editon{
    color: white;
    padding: 1px 4px;
    border-radius: 3px;
    border: 1px solid #4696e5;
    background: #4696e5;
    cursor: pointer;}
 #evntDtls .evntdesc p .deleteon{
    color: white;
    border-radius: 3px;
    padding: 1px 6px;
    border: 1px solid red;
    background: red;
    cursor: pointer;}
.desc-text{
	color: #000000;
    font-family: monospace;
    padding: 5px 0px 5px 5px;
}
#leftHeader{color: #3F51B5 !important;border-bottom: 1px solid;}
#fromTime, #toTime{width: 70px;}
</style>
</head>
<c:choose>
 <c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1}">
 <c:set var="deCpme" value="${fjtuser.emp_code}" scope="page" />
 <body>
 <div class="container" style="margin-top: -19px;">
		   <div class="col-md-12 col-sm-12 taskDetailBox">
			  <div class="row" style="padding-top: 5px;">
			  <div class="col-md-5" style="color:black !important;" >			  
			  <h3 id="leftHeader"><i class="fa fa-tasks" aria-hidden="true"></i>
				  Customer Visit Planner Details  <span id="evntDay"></span>
				  <span class="pull-right">
				   <!-- <a href="#" data-toggle="modal" data-target="#help-modal"> <i class="fa fa-info-circle pull-left" style="color: #2196f3;font-size: 20px;margin-top: 4px;"></i></a> -->  
				   <a href="homepage.jsp" > <i class="fa fa-home" style="color: #2196f3;font-size: 20px;" title="Home"></i></a>  
				   <a href="DailyTask" style="color:#fff;" > <i class="fa fa-refresh" style="color: #2196f3;font-size: 20px;"></i></a>
				   <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" style="color: #2196f3;font-size: 20px;" title="Back"></i></a>
				  </span>
				  </h3>			  			  
				<!--  <h4><i class="fa fa-angle-double-right" aria-hidden="true"></i> Task Details  <span id="evntDay"></span></h4> --> 
		<!-- 	<c:if test="${!empty fjtuser.subordinatelist}">  
			  <form class="form-group   form-inline pull-right" name="taskReport" style="margin-top:-35px;">
			  <input  class="form-control form-control-sm"   placeholder="Select Start Date" style="width:100px;"  type="text" id="reportDate" name="reportDate" autocomplete="off" required/>
			  <input  type="hidden" id="dmCode" name="dmCode" value="${fjtuser.emp_code}" required/>
			  <button type="button" class="btn btn-sm btn-primary"  onclick="getEmplyeeeDailyTaskReport();">View Report</button>
			  </form>
			</c:if>		 -->	  
				<div id="evntDtls" class="pre-scrollable" style="max-height: 500px !important;width: 100%;"></div>
			  </div> 
			  <div class="col-md-7 dtask-right">
			  <div class="box box-primary">
              <div class="box-body no-padding">
              <!-- THE CALENDAR -->
               <form class="form-inline" method="POST" action="DailyTask">                
              <div id='caljump' style="padding-top: 10px;    width: max-content;">              
				  		<select class="select_month"  name="sid" id="sid"   required>
   					<option selected value="${fjtuser.emp_code}" >${fjtuser.uname}</option>
					  <c:forEach var="subList"  items="${SUB_EMP_LIST}" >					   
					  <option value="${subList.emp_code}" >${subList.emp_name} </option>					   
					  </c:forEach>					  
					</select>
				          <select id='months' class="select_month"  name="iMonth">
				           <%
                                 for(int im=1;im<=12;im++)
                                {
                                if(im==iMonth)
                                {
                               %>
                                <option value="<%=im%>" selected="selected"><%=new DateFormatSymbols().getMonths()[im-1]%></option>
                                <%
                                }
                                else
                                {
                                  %>
                                <option value="<%=im%>"><%=new DateFormatSymbols().getMonths()[im-1]%></option>
                                <%
                                }
                              }
                            %>                                                           
                      </select> 
				    	  <select id="years" class="select_month" name="syear" id="syear">  					  						
   						 <%
                        // start year and end year in combo box to change year in calendar
                         for(int iy=iYear;iy>=2019;iy--)
                            {                            
                             %>
                             <c:set var="syrtemp1" value="<%=iy%>" scope="page" />
                             <option value="<%=iy%>" ${syrtemp1  == selected_Year ? 'selected':''}> <%=iy%></option>
                            <%                             
                        }
                        %>
						</select>					 	
				    <!--   <a href="DailyTask" > <i class="fa fa-refresh" style="color: #4696e5;font-size: 18px;"></i></a>-->
				    	
					 <input type="hidden" name="fjtco" value="" />
   					<button type="button" id="goToDate" class="btn btn-primary btn-xs select_month"  style="padding: 3px 8px;">Details</button> 
   					
			  </div>			
			  </form>		
          
            <div class="select_month pull-right" style="margin-top: 1px; margin-right: 0px;">
			<div id="export">		
			 <table id="dailytask_table" style="display:none;color: green; font-size: 2em;    margin-left: 6px;">
             <thead>           
             <tr> <th>Task</th><th>Sales Code</th><th>Date</th>   <th>Time</th>
             <th>Details</th> </tr>
             </thead> <tbody> <c:forEach var="dtaa"  items="${EMPTSKLIST}" > 
             <tr>
             <td>${dtaa.ttyp07}</td><td>${dtaa.tendb11}</td>
             <td><i style="color:#065685;"> <fmt:parseDate value="${dtaa.twd05}" var="theDate"    pattern="yyyy-MM-dd" />
             <fmt:formatDate value="${theDate}" pattern="dd/MM/yyyy"/> </i> </td> 
             <td>${dtaa.tst09} to ${dtaa.tet10}</td> <td>
             <c:choose>
             	<c:when test="${dtaa.tid01 eq 'cv'}">
             	 <b>Doc. Id : </b> ${dtaa.cvdid}<br/> 
             	 <b>Project/ Party : </b>${dtaa.cvpopn}<br/>
             	 <b>Description : </b>${dtaa.tdesc08}<br/>
             	 <b>Customer : </b>${dtaa.partyName}<br/>
             	</c:when>
             	<c:otherwise>
             		${dtaa.tdesc08}
             	</c:otherwise>
             </c:choose>   
             </td>
              </tr>             
              </c:forEach> </tbody>  </table>            
			 </div>
			  <span style="margin-left:-10px;margin-left: 0px;">Export</span>
			  </div> 
              <div id="calendar" style="margin-top: -13px;"></div>
            </div>
            <!-- /.box-body -->
          </div></div>
          </div>
	    </div>
	</div>
<script type="text/javascript" src="resources/js/bootstrap-clockpicker.min.js"></script>
<!-- fullCalendar -->
<script src="resources/bower_components/moment/moment.js"></script>
<script src="resources/bower_components/fullcalendar/dist/fullcalendar.min.js"></script>
<script type="text/javascript"> 
var custdetails = <%=new Gson().toJson(request.getAttribute("CUSTVISITDAYS"))%>;
<%--var pattern = /['";<=>? \\\^`|~]/;--%>
$(function() {		
	 $('#laoding').hide();
	var subOrdActv="N";
	//var custdetails = "${custTypes}";
	//alert("custdetails== "+custdetails);
	var today = new Date();
	//var dt = JSON.parse("[\"${EMPTSKLIST}\"]");
	var enddate = new Date(); 
	enddate. setDate(enddate. getDate() + 15);
	var tempname="${fjtuser.uname}";
	var tempcmp="${fjtuser.emp_com_code}";
	

    //timepicker
    $('.clockpicker').clockpicker()
	.find('input').change(function(){
		console.log(this.value);
	});
    var input = $('#single-input').clockpicker({
	placement: 'bottom',
	align: 'left',
	autoclose: true,
	'default': 'now'
    });
	// page is now ready, initialize the calendar...
     var selectedDay,selectedMonth,selectedYr;	   
	 $('#calendar').fullCalendar({		  
		  header    : {  left  : '', center: 'title', right : '',  },
		  buttonText: {	 month: 'month' },			  
		  editable: false, timeFormat: 'H(:mm)',  minTime: 0, maxTime: 24, eventLimit: 3,
		//  validRange: {start : today, end : enddate},
		  events: [
		      <c:forEach var="dtaa" items="${EMPTSKLIST}">  
		    	 {
 		          title  : '${dtaa.tst09} ${dtaa.ttyp07}',
 		          description: `${fn:replace(dtaa.tdesc08, "'", "\\'")}`,
 		         // id : `${dtaa.tid01}`,
 		          id : `${dtaa.sysid}`,
 		          sdtime:`${dtaa.tst09}`,
 		          edtime:`${dtaa.tet10}`, 	
 		          sysid:`${dtaa.sysid}`,
 		          start  : moment('${dtaa.twd05}').format('YYYY-MM-DD'),
 		          end    : moment('${dtaa.twd05}').format('YYYY-MM-DD'),
 		          docId : `${dtaa.cvdid}`,
 		          project : `${fn:replace(dtaa.cvpopn, "'", "\\'")}`,
 		          customer : `${fn:replace(dtaa.partyName, "'", "\\'")}`,
 		          contactPerson : `${fn:replace(dtaa.contactPerson, "'", "\\'")}`,
 		          contactNumber : `${fn:replace(dtaa.contactNumber, "'", "\\'")}`,
 		          backgroundColor: 'green', 
	              borderColor    : 'green', 
	              allday:true
 		        },		    
		    	 </c:forEach>		       
 		       ], 		     
		 eventClick: function(calEvent, jsEvent, view) {			
			 var edCpme=$.trim($('#sid').val());
			 var empCode=$.trim('${deCpme}');
			 var descCrte=calEvent.description.split("\n").join("<br/>");
			 var docsId=calEvent.docId;
			 var project=calEvent.project.split("\n").join("<br/>");
			 
			 var taskDtls ="";
			 var id=calEvent.id;	
			
			/*	if(userIsOrigOrNot(edCpme,empCode)){ 		
				subOrdActv="Y"; 				
				taskDtls  += '<div class="evntdesc">';	
					if(calEvent.id != 'cv'){						
						var randomNum = Math.floor(Math.random()*100);
						var randomId = "close"+calEvent.sysid+randomNum+"";
						var randomFunc = "closeEventController('close"+calEvent.sysid+randomNum+"')";
						var customer = checkUndefinedorNot(calEvent.customer);
						taskDtls  += "<span id="+randomId+" onclick="+randomFunc+"  class='closeon pull-right'>";
					}else{
						var randomFunc = "closeEventController('close"+calEvent.sysid+"')";
						//var randomFunc = "closeEventController('close"+calEvent.id+"')";
						var randomId = "close"+calEvent.sysid+"";
						taskDtls  += "<span id="+randomId+" onclick="+randomFunc+"  class='closeon pull-right'>"; 
					}
					taskDtls += '<i class="fa fa-close"></i></span><div class="form-inline">'+
		            '<div class="form-control" style="font-weight: bold;color: black;">'+calEvent.title.substring(6)+'</div>'+
		            '<div class="form-control" style="color: black;"><i class="fa fa-calendar" aria-hidden="true" style="color:blue;"></i> '+moment(calEvent.start).format('YYYY-MM-DD').split("-").reverse().join("/")+'</div>'+
		            '<div class="form-control" style="color: black;"><i class="fa fa-clock-o" aria-hidden="true" style="color:blue;"></i> '+calEvent.sdtime+'-'+calEvent.edtime+'  </div></div>';
				      if(calEvent.id != 'cv'){ 
			            	taskDtls += '<p class="desc-text">'+descCrte+'</P>';    	            	
			            }else{
			            	taskDtls += '<b style="color: red;padding:5px;10px;15px;2px;"><u> Customer Visit if</u></b><br/>';
			            	taskDtls += '<p class="desc-text"><b>Doc. Id : </b>'+docsId+'<br/>'; 	
			            	taskDtls += '<b>Action Type : </b>'+calEvent.title+'<br/>'; 	
			            	taskDtls += ' <b>Project/Party : </b>'+project+'<br/>';
			            	taskDtls += '  <b>Action Description : </b>'+descCrte+'<br/>';
			            	taskDtls += '  <b>Customer : </b>'+customer+'</P>';
		            }
			            taskDtls += '</div>';  
				}
				else{ */
					//subOrdActv="N"; 
					var evendate = moment(calEvent.start).format('YYYY-MM-DD').split("-").reverse().join("/");
					 var today = new Date();	
					 var day= today.getDate();
					 var month = (today.getMonth()+1);
					 var year = today.getFullYear();
					 var currentDay;
					 if (day < 10) {day = '0' + day;}
					 if (month < 10) {month = '0'+ month;}
					 currentDay = day + "/" + month + "/" + year;
					 
					taskDtls='<div class="evntdesc" id="evntdesc_'+calEvent.sysid+'">';
					if(calEvent.id != 'cv'){
						var randomNum = Math.floor(Math.random()*100);
						var randomId = "close"+calEvent.sysid;
						var randomFunc = "closeEventController('close"+calEvent.sysid+"')";						
						var customer = checkUndefinedorNot(calEvent.customer);
						taskDtls  += "<span id="+randomId+" onclick="+randomFunc+"  class='closeon pull-right'>";
					}else{
						var randomFunc = "closeEventController('close"+calEvent.id+"')";
						var randomId = "close"+calEvent.id+"";
						taskDtls  += "<span id="+randomId+" onclick="+randomFunc+"  class='closeon pull-right'>"; 
					}
					taskDtls  += '<i class="fa fa-close"></i></span><div class="form-inline">'+
		            '<div class="form-control" style="font-weight: bold;color: black;">'+calEvent.title.substring(6)+'</div>'+
		            '<div class="form-control" style="color: black;"><i class="fa fa-calendar" aria-hidden="true" style="color:blue;"></i> '+moment(calEvent.start).format('YYYY-MM-DD').split("-").reverse().join("/")+'</div>'+
		            '<div class="form-control" style="color: black;"><i class="fa fa-clock-o" aria-hidden="true" style="color:blue;"></i> '+calEvent.sdtime+'-'+calEvent.edtime+'  </div></div>';	            
		            //'<p><span id="delete'+calEvent.id+'" class="deleteon"><i class="fa fa-delete">Delete</i></span> ||'+
		           // if(calEvent.id != 'cv'){ 
		            //	taskDtls += '<p class="desc-text">'+descCrte+'</P>';
		            //	taskDtls += '<span class="editon" id="edit'+calEvent.id+'"><i class="fa fa-edit">Edit gf</i></span></P>';   	            	
		           // }else{
		            	taskDtls += '<b style="color: red;padding:5px;10px;15px;5px;"><u> Planned Customer Visit</u></b><br/>';
		            	taskDtls += '<p class="desc-text"><b>Doc. Id : </b>'+docsId+'<br/>'; 
		            	//taskDtls += '<b>Visit Type : </b>'+title+'<br/>'; 
		            	taskDtls += '<b>Action Type : </b>'+calEvent.title+'<br/>'; 	
		            	taskDtls += ' <b>Project/Party : </b>'+calEvent.project+'<br/>';
		            	taskDtls += '  <b>Contact Person : </b>'+calEvent.contactPerson+'<br/>'; 
		            	taskDtls += '  <b>Action Description : </b>'+calEvent.description+'<br/>'; 
		            	taskDtls += '  <b>Customer : </b>'+customer+'</P>';
		            	 if(evendate == currentDay){
		            		taskDtls += '<span class="editon" id="update'+calEvent.sysid+'"><i class="fa fa-edit">Mark it as Visited</i></span></P>';   
		            	}else if(evendate <= currentDay){ 
		            		//taskDtls += '<span class="editon" id="edit'+calEvent.sysid+'"><i class="fa fa-edit">Edit</i></span></P>';
		            	}else{ 
		            		taskDtls += '<span class="editon" id="edit'+calEvent.sysid+'"><i class="fa fa-edit">Edit</i></span></P>';
		            	}
	            	
	            	
	           // }
		            taskDtls += '</div>';							
	           // }	
				
			    $('#evntDtls').append(taskDtls);
			    $('#evntDtls').find('#delete'+calEvent.sysid+'').click(function() {
			    if(typeof calEvent.id == undefined || calEvent.sysid == null ){	 
			    alert("refresh the page");
			    jsEvent.preventDefault();
				}else{ //alert('clicked on'+calEvent.id);
			    removeEventController(calEvent.sysid);
		        $('#calendar').fullCalendar('removeEvents',calEvent.sysid);
				}
		        }); 
			  /*  $('#evntDtls').find('#close'+calEvent.id+'').click(function() {
			    	alert('hi');
			    closeEventController(calEvent.id);    
		        }); */
			    $('#evntDtls').find('#edit'+calEvent.sysid+'').click(function() {			    	
			    updateEditEventController(calEvent);	     
		        }); 
			    $('#evntDtls').find('#update'+calEvent.sysid+'').click(function() {			    	
				    markitasvisitedController(calEvent);	     
			     });
		        },		    		  
		  dayClick: function(date, jsEvent, view) {
			    $('#desc').val('');
			    $('#err-msg').html('');
			    var empCode=$.trim('${deCpme}');
			    var subOrd=$.trim($('#sid').val());			    			    
			    var defday = new Date();
			    var clickdday = new Date(date);			  			    
				selectedMonth = clickdday.getMonth() + 1; 
				selectedYr = clickdday.getFullYear();
				selectedday=clickdday.getDate();
				var thisday = ""+ selectedYr + "-"+(selectedMonth+1)+"-"+selectedday;
				var daystring = ""+(selectedday<=9?"0"+selectedday:selectedday)+"/"+((selectedMonth+1)<=9?"0"+(selectedMonth):(selectedMonth))+"/"+selectedYr+"";
				document.getElementById("regularise_date").value = daystring;
		        var dateDiffrnc = dateDiffInDaysForCustVisitPr(today,date);
		        var previous_date = document.getElementById("previous_date").value;
		        var alrdyUpdtdVsts = 0;		        
		        if(document.getElementById("previous_date").value === document.getElementById("regularise_date").value){		        	
		        	alrdyUpdtdVsts = document.getElementById('alrdyUpdtdVsts').value;		
		        } 
				if(date <= today || dateDiffrnc > 15 ){jsEvent.preventDefault();}// Daily Task 3 Dyas gap allowed by RK
				else{selectedDay=date.format();
				document.getElementById("selected_date").value = selectedDay;
				visitdetails(custdetails,selectedday,alrdyUpdtdVsts,daystring);
		        $("#evntDtls").empty();
		        clearAllFields();		        
		        $('#evntDay').html(daystring);//display day date after "Task Details custRqstBox"
		       // $("#createEventModal .modal-title").html("Customer Visit Planner for  "+moment(date).format('YYYY-MM-DD').split("-").reverse().join("/"));
               // $('#createEventModal').modal('show');
               }			  				 			     			    
			  },			
			  
	  });	
	  $('#submitButton').on('click', function(e){		  		  
		    // We don't want this to act as a link so cancel the link action
		    e.preventDefault();
		    
		    if($('#desc').val().length < 10){
		    	$('#err-msg').html('Minimum 10 character required!');
		    	return false;
		    }else if($('#desc').val().length > 300){
		    	$('#err-msg').html('Maximum 300 character allowed!');
		    	return false;
		    }else{
		    	$('#err-msg').html(''); 
		    	doSubmit(selectedDay,selectedMonth,selectedYr,tempname,tempcmp);
		        	/* if (!pattern.test($.trim($('#desc').val()))) { 
		    		doSubmit(selectedDay,selectedMonth,selectedYr,tempname,tempcmp);
		    	}else{
		    		 $('#errMsgup').html("Special characters <b>( \' \? \= \| \" \; \` \^ \/ < > ~ | )</b>  not Allowed!");
		    		  //$('#err-msg').html("Special characters not Allowed!");
		    		return false;
		    	} */
		    }
		  });
	      /* $('#months').on('change', function() {  $('#calendar').fullCalendar('gotoDate', $(this).val());  });*/
	        $('#goToDate').on('click', function(e){
		    var goMonth = $('#months option:selected').val();
			var goYear=$('#years option:selected').val();
			goToNewCalendarDate(goYear,goMonth);
	 
		  });	   
});

$(document).ready(function() {

	 $('#dailytask_table').DataTable( {
	        dom: 'Bfrtip',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
	                filename: "Employee : ${deCpme}  Customer Visit Planner Details -  ${currMth}/${currYr}",
	                title: "Employee : ${deCpme} Customer Visit Planner Details -  ${currMth}/${currYr}",
	                messageTop: 'Data Exported on : ${currCal}.',
	                messageBottom: 'The information in this file is copyright to Faisal Jassim Group. '
	                
	                
	            }
	          
	           
	        ]
	    } );
	     
});
function checkUndefinedorNot(data){
	if((typeof data === 'undefined' ) || data  == 'undefined' || data == '' || data == null){
		return "-";
	}else{return data;}
}

</script>



 <!-- Modal -->
  <div class="modal fade" id="createEventModal" role="dialog" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <%--<div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
         <h4 class="modal-title">Add Task for </h4>
        </div> --%>
        <div class="modal-body">
         
         <form name="createEvent">         
            <div class="rqstDvHeader" style="margin-bottom: 0em">
		        <span id="formheading" class="pull-left"></span>
		        <!-- <span class="pull-right"><i class="fa fa-window-close fa-lg closeRqst" onclick="closeRequestWindow();"></i></span> -->
	        </div>
	        <div id="slctSegRegTyp"> 							 	
				<label id="custlabel">
					<!-- <input class="form-control"  type="radio" name="tab" value="custvst" id="rcustvst" onclick="custVisitBox();" /> -->					
				</label>							
			  </div> 	
			 <div id="custRqstBox" style="display: block; pointer-events: auto;padding-top:5px;">  
                     	      
          		     <div id="custvisit" >
          		     <div align="right" style="margin-bottom:5px;">
			    		<button type="button" name="add" id="newVst" class="btn btn-success btn-xs"  data-toggle="modal" data-target="#modal-new-visit" ><i class="fa fa-plus" > </i>New Visit</button>
			   		</div>
          		          <div class="table-responsive pre-scrollable cust-scrll-box"> 
						     <table class="table table-bordered smalll" id="user_data">
						     <thead>
						      <tr>
						       <th>DOC ID</th> <th>Action</th> <th>Project/Party</th>					      
						       <th>From</th> <th>To</th>  <th>Contact-Name</th> <th>Contact-No.</th> <th>Description</th>
						       <th></th>
						      </tr>
						      </thead>
						      <tbody></tbody>
						     </table>
						     </div>
						   
          		     		<form>
          		     		<div align="center">
          		     		  <input type="hidden" name="iYear" value="${iYear}"/>
				              <input type="hidden" name="idate" value="" id="idate"/>
				              <input type="hidden" name="ichkin" value="" id="ichkin"/>
				              <input type="hidden" name="regularise_date" value="" id="regularise_date"/>
				              <input type="hidden" name="previous_date" value="" id="previous_date"/>
				               <input type="hidden" name="selected_date" value="" id="selected_date"/>
				              <input type="hidden" name="regOptnSts" value="1" id="regOptnSts"/> 
				              <input type="hidden" name="alrdyUpdtdVsts" value="0" id="alrdyUpdtdVsts"/>
				              <input type="hidden" name="cvAYn" value="1" id="cvAYn"/> 
				             
						      <input type="button" class="sbt_btn3" id="apply_btn2" onclick="Apply(this);" name="actn" value="Submit"/>
						    </div>
          		     	  </form>	     	          		    
          		     </div>
          		   </div>          		 
		    </form>
		    
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
  
 <div class="modal fade" id="updateEventModal"  data-backdrop="static" data-keyboard="false">
  <div class="modal-dialog modal-lg"  >
    <div class="modal-content">
      <div class="modal-header">
		  <h5 class="modal-title">Customer Visit Form</h5>
		  <button type="button" class="close" data-dismiss="modal">&times;</button>
	  </div>
 <div class="modal-body"> 
  		 
   <!--  Process - 1 -->
   <div class="row" id="vst-entry-block">
    		<div class=" col-md-12 col-xs-12" id="errMsg"></div>
     <div class="col-md-12 col-xs-12 form-inline">	
      <div class="form-group col-md-4 col-xs-12">
      	 <label class="label-control entry-vst-flds small"><i class="fa fa-angle-down mr-1 text-info" aria-hidden="true"></i>Visit Type</label>
      	 <input type="text" class="form-control"  id="upvstTyp" name="upvstTyp" readonly>
           <!--  select class="form-control select2 input-sm" style="width: 100%;" id="vstTyp" name="vstTyp" onChange="checkVisitType()" readonly>
             <option value="">Select</option>					                
                <option value="1" class="">General</option>
                <option value="2" class="">Follow-Up</option>
           </select>-->
      </div>
      <div class="form-group  col-md-4 col-xs-12">
      	 <label class="label-control entry-vst-flds small"><i class="fa fa-angle-down mr-1 text-info" aria-hidden="true"></i>Action type</label>
      	  <input type="text" class="form-control"  id=upvisitActn name="upvisitActn" readonly>        
       </div>
       <div class="form-group  col-md-4 col-xs-12" id="timeBlock" >
	 <div class="input-group  pull-center"  id="fromDiv"  >	 
	 	    <label class="label-control entry-vst-flds small"><i class="fa fa-clock-o mr-1 text-info" aria-hidden="true"></i>From</label>							  
		   <input type="text" class="form-control"  id="upfromTime" name="fromTime" value="08:00" required onChange="clearErrorTimingMessage()" />									  
	</div>
	<div class="input-group  pull-center"  id="toDiv"  >
		 <label class="label-control entry-vst-flds small"><i class="fa fa-clock-o mr-1 text-info" aria-hidden="true"></i>To</label>								 
		 <input type="text" class="form-control"    id="uptoTime"  name="toTime" value="18:00"  required onChange="clearErrorTimingMessage()" /> 									  
	</div>
</div>
<div class="form-group  col-sm-6 col-md-6 col-xs-12" style="padding-top:5px;"> 
<div class="input-group  pull-center"  >	 
<label><i class="fa fa-comments mr-1 text-info" aria-hidden="true"></i>Contact Person Name</label> 
         <input type="text" class="form-control"    id="upcustName"  name="custNam" value=""  onkeypress="clearErrorMessage()" readonly/> 
         </div>
    </div>     
   <div class="form-group  col-sm-6 col-md-6 col-xs-12" style="padding-top:5px;"> 
		<div class="input-group  pull-center"  >	 
		 	<label><i class="fa fa-comments mr-1 text-info" aria-hidden="true"></i>Contact Person No.</label> 
		          <input type="text" class="form-control"    id="upcustContctNo"  name="custContctNo" value=""  onkeypress="clearErrorMessage()" readonly/> 
		 </div>
     </div> 
	 <div class="form-group  col-sm-12 col-md-12 col-xs-12" style="padding-bottom:5px;"> 
		<label><i class="fa fa-comments mr-1 text-info" aria-hidden="true"></i>Action Description</label> 
		<textarea class="form-control" rows="1" placeholder="Enter Description..."  value="" name="actionDesc" id="upactionDesc" style="width:100%"  maxlength="200" wrap="hard" onkeypress="clearErrorMessage()" required></textarea>
		 </div> 
    </div>  		        					       
     <div class=" col-md-12 col-xs-12">
         <div id="updateflwUpBlck">    
         <h5> <b>Select Project From Below List (Last 12 months projects only!) </b> </h5>
              <div id="flUpMessage"></div>
            	 <div id="updateflUpContent"></div>				                	 
           	</div>
           	 <div id="updategnrlBlck"> 
            	 <div class="form-inline" id="gnrlVstContent">  
          			    <div class="form-group col-xs-12"> 
          			     <label><i class="fa fa-comments mr-1 text-info" aria-hidden="true"></i>Project / Party Details</label> 
            <textarea class="form-control" rows="1" placeholder="Enter Project Details..."  value="" name="genProject" id="upgenProject" style="width:100%"  maxlength="200" wrap="hard" onkeypress="clearErrorMessage()"></textarea>
          			   </div> 
            	 </div>
            	 
           	</div>
           </div>
           <input type="hidden" id="upsysid" />
 	</div> 
 	<div class="modal-footer">              
       <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Close</button>	
       <button type="button" id ="updateButton" class="btn btn-primary pull-right">Update</button>
      </div>
 				                
    </div>                
      
    </div>
    <!-- /.modal-content -->
  </div>        
  <!-- /.modal-dialog -->         
</div>
  	<div class="modal fade" id="help-modal" data-backdrop="static" data-keyboard="false">
		 <div class="modal-dialog  modal-sm"  >
			<div class="modal-content">
				 <div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					 <h4 class="modal-title">Daily Task Help</h4>
					 </div>
					<div class="modal-body">
					    <ol>
							 <li>Click on the date box in calendar to add daily task</li>
							 <li>Click on already added task (green color) to display the task details.</li>
							 <li>Previous date  'daily task' entry  not allowed, only same day entry</li>
							 </ol>              
					 </div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default pull-left"
											data-dismiss="modal">Close</button>

									</div>
								</div>
								<!-- /.modal-content -->
							</div>
							<!-- /.modal-dialog -->
						</div>
						
					<div class="modal fade" id="report-modal" role="dialog" >
								<div class="modal-dialog" style="width: 97%;">
									<!-- Modal content-->
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal">&times;</button>
											<h4 class="modal-title"></h4>
										</div>
										<div class="modal-body small">
											<div id="table_div"></div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default"
												data-dismiss="modal">Close</button>
										</div>
									</div>
								</div>
					</div>
       <div class="modal fade" id="modal-new-visit"  data-backdrop="static" data-keyboard="false">
          <div class="modal-dialog modal-lg"  >
            <div class="modal-content">
              <div class="modal-header">
		        <h5 class="modal-title">Customer Visit Form</h5>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
              <div class="modal-body"> 	  		 
			        <!--  Process - 1 -->
			        <div class="row" id="vst-entry-block">
			         		<div class=" col-md-12 col-xs-12" id="errMsg"></div>
					        <div class="col-md-12 col-xs-12 form-inline">	
					         <div class="form-group col-md-4 col-xs-12">
					         	 <label class="label-control entry-vst-flds small"><i class="fa fa-angle-down mr-1 text-info" aria-hidden="true"></i>Visit Type</label>
					              <select class="form-control select2 input-sm" style="width: 100%;" id="vstTyp" name="vstTyp" onChange="checkVisitType()" required>
					                <option value="">Select</option>					                
				                    <option value="1" class="">General</option>
				                    <option value="2" class="">Follow-Up</option>
					              </select>
					         </div>
					         <div class="form-group  col-md-4 col-xs-12">
					         	 <label class="label-control entry-vst-flds small"><i class="fa fa-angle-down mr-1 text-info" aria-hidden="true"></i>Action type</label>
					              <select class="form-control select2 input-sm" style="width: 100%;" id="visitActn" name="visitActn"  onChange="clearErrorMessage()" required>
					                <option value="">Select</option>					                
				                    <c:forEach var="item" items="${actionTypes}">
				                    	 <option value="${item.actionType}">${item.actionType}</option>	
				                    </c:forEach>
					              </select>
					         </div>
					         <div class="form-group  col-md-4 col-xs-12" id="timeBlock" >
								 <div class="input-group  pull-center"  id="fromDiv"  >	 
								 	    <label class="label-control entry-vst-flds small"><i class="fa fa-clock-o mr-1 text-info" aria-hidden="true"></i>From</label>							  
									   <input type="text" class="form-control"  id="fromTime" name="fromTime" value="08:00" readonly required onChange="clearErrorTimingMessage()" />									  
								</div>
								<div class="input-group  pull-center"  id="toDiv"  >
									 <label class="label-control entry-vst-flds small"><i class="fa fa-clock-o mr-1 text-info" aria-hidden="true"></i>To</label>								 
									 <input type="text" class="form-control"    id="toTime"  name="toTime" value="18:00"  readonly required onChange="clearErrorTimingMessage()" /> 									  
								</div>
							</div>
							<div class="form-group  col-sm-6 col-md-6 col-xs-12" style="padding-top:5px;"> 
							 <div class="input-group  pull-center"  >	 
							 <label><i class="fa fa-comments mr-1 text-info" aria-hidden="true"></i>Contact Person Name</label> 
				             <input type="text" class="form-control"    id="custName"  name="custNam" value=""  onkeypress="clearErrorMessage()" required/> 
				             </div>
               			    </div>     
               			   <div class="form-group  col-sm-6 col-md-6 col-xs-12" style="padding-top:5px;"> 
							<div class="input-group  pull-center"  >	 
							 <label><i class="fa fa-comments mr-1 text-info" aria-hidden="true"></i>Contact Person No.</label> 
				             <input type="text" class="form-control"    id="custContctNo"  name="custContctNo" value=""  onkeypress="clearErrorMessage()" required/> 
				             </div>
               			    </div> 
               			    <div class="form-group  col-sm-12 col-md-12 col-xs-12" style="padding-bottom:5px;"> 
							 <label><i class="fa fa-comments mr-1 text-info" aria-hidden="true"></i>Action Description</label> 
				             <textarea class="form-control" rows="1" placeholder="Enter Description..."  value="" name="actionDesc" id="actionDesc" style="width:100%"  maxlength="200" wrap="hard" onkeypress="clearErrorMessage()" required></textarea>
               			    </div> 
					       </div>  		        					       
					        <div class=" col-md-12 col-xs-12">
					            <div id="flwUpBlck">    
					            <h5> <b>Select Project From Below List (Last 12 months projects only!) </b> </h5>
					                 <div id="flUpMessage"></div>
				                	 <div id="flUpContent"></div>				                	 
			                	</div>
			                	 <div id="gnrlBlck"> 
				                	 <div class="form-inline" id="gnrlVstContent">  
			               			    <div class="form-group col-xs-12"> 
			               			     <label><i class="fa fa-comments mr-1 text-info" aria-hidden="true"></i>Project / Party Details</label> 
							             <textarea class="form-control" rows="1" placeholder="Enter Project Details..."  value="" name="genProject" id="genProject" style="width:100%"  maxlength="200" wrap="hard" onkeypress="clearErrorMessage()" required></textarea>
			               			   </div> 
				                	 </div>
				                	 
			                	</div>
			                </div>
					    	</div>  			                
			         </div>                
              <div class="modal-footer">              
	              <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Close</button>	
	              <button type="button" id ="save" class="btn btn-primary pull-right">Save</button>
              </div>
            </div>
            <!-- /.modal-content -->
          </div>        
          <!-- /.modal-dialog -->         
        </div>
      
<div id="content1"></div>
<div id="laoding" class="loader"><img src="resources/images/wait.gif"></div>
</body>

</html>
</c:when>
<c:otherwise>
    <html>
        <body onload="window.top.location.href='logout.jsp'">
        </body>
            
        </body>
    </html>
</c:otherwise>
</c:choose>