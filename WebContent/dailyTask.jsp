<%-- 
    Document   : dailyTask 
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
<%@page import="java.time.format.DateTimeFormatter"%>
<% pageContext.setAttribute("newLineChar", "\n"); %>

<%
  DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
  Calendar cal = Calendar.getInstance();
  int iYear = cal.get(Calendar.YEAR);  
  int iMonth = cal.get(Calendar.MONTH)+1;
  String currCalDtTime = dateFormat.format(cal.getTime());
  request.setAttribute("currCal", currCalDtTime);
  request.setAttribute("currYr", iYear);
  request.setAttribute("currMth", currCalDtTime);
  beans.Holiday hhh = (beans.Holiday)request.getSession().getAttribute("holiday");
 %>
<head>
<link href="resources/css/jquery-ui.css" rel="stylesheet">
<link rel="stylesheet" href="resources/css/dailyTask.css?v=31122020"> 
<script src="resources/js/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/bootstrap-clockpicker.min.css">
<link rel="stylesheet" href="resources/bower_components/fullcalendar/dist/fullcalendar.min.css">
<link rel="stylesheet" href="resources/bower_components/fullcalendar/dist/fullcalendar.print.min.css" media="print">
<link rel="stylesheet" href="resources/dist/css/AdminLTE.min.css">
<link rel="stylesheet" href="resources/dist/css/skins/_all-skins.min.css">
<link rel="stylesheet" type="text/css" href="resources/datatables/datatables-fjtco/css/jquery.dataTables.min.css" />
<link rel="stylesheet" type="text/css" href="resources/datatables/buttons-fjtco/css/buttons.dataTables.min.css" />
<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/dataTables.buttons.min.js"></script>
<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.flash.min.js"></script>
<script type="text/javascript" src="resources/datatables/ajax/excelmake/jszip.min.js"></script>
<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.html5.min.js"></script>
<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.print.min.js"></script>
<script src="resources/js/daily-task.js?v=05052021v9"></script>
<style>
@media ( max-width : 375px) {
#sid,#caljump{width: 100% !important;}
#frmclock{float:left !important;}
}
#err-msg{color:red;}
.fc-toolbar::after{content:'Daily task can be entered till 3 back days(Excluding weekends).';color:#f44336;}
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
				  Employee Daily Task  <span id="evntDay"></span>
				  <span class="pull-right">
				   <a href="#" data-toggle="modal" data-target="#help-modal"> <i class="fa fa-info-circle pull-left" style="color: #2196f3;font-size: 20px;margin-top: 4px;"></i></a>  
				   <a href="homepage.jsp" > <i class="fa fa-home" style="color: #2196f3;font-size: 20px;" title="Home"></i></a>  
				   <a href="DailyTask" style="color:#fff;" > <i class="fa fa-refresh" style="color: #2196f3;font-size: 20px;"></i></a>
				   <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" style="color: #2196f3;font-size: 20px;" title="Back"></i></a>
				  </span>
				  </h3>			  			  
				  <h4><i class="fa fa-angle-double-right" aria-hidden="true"></i> Task Details  <span id="evntDay"></span></h4>
			<c:if test="${!empty fjtuser.subordinatelist}">  
			  <form class="form-group   form-inline pull-right" name="taskReport" style="margin-top:-35px;">
			  <input  class="form-control form-control-sm"   placeholder="Select Start Date" style="width:100px;"  type="text" id="reportDate" name="reportDate" autocomplete="off" required/>
			  <input  type="hidden" id="dmCode" name="dmCode" value="${fjtuser.emp_code}" required/>
			  <button type="button" class="btn btn-sm btn-primary"  onclick="getEmplyeeeDailyTaskReport();">View Report</button>
			  </form>
			</c:if>			  
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
             <tr> <th>Task</th><th>Emp: Name</th><th>Date</th>   <th>Time</th>
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
<%--var pattern = /['";<=>? \\\^`|~]/;--%>
$(function() {		
	 $('#laoding').hide();
	var subOrdActv="N";
	var today = new Date();
	//var dt = JSON.parse("[\"${EMPTSKLIST}\"]");	 
	var tempname="${fjtuser.uname}";
	var tempcmp="${fjtuser.emp_com_code}";
	
	 $(function () {
	        $("#reportDate").datepicker();
	        $("#reportDate").datepicker("option", "dateFormat", "dd-mm-yy");
	    });
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
     var selectedDay,selectedMonth,selectedYr,selectedDt;    
	 $('#calendar').fullCalendar({		  
		  header    : {  left  : '', center: 'title', right : '',  },
		  buttonText: {	 month: 'month' },
		  editable: false, timeFormat: 'H(:mm)',  minTime: 0, maxTime: 24, eventLimit: 3,
		  events: [
		      <c:forEach var="dtaa" items="${EMPTSKLIST}">  
		    	 {
 		          title  : '${dtaa.tst09} ${dtaa.ttyp07}',
 		          description: `${fn:replace(dtaa.tdesc08, "'", "\\'")}`,
 		          id : `${dtaa.tid01}`,
 		          sdtime:`${dtaa.tst09}`,
 		          edtime:`${dtaa.tet10}`,
 		          start  : moment('${dtaa.twd05}').format('YYYY-MM-DD'),
 		          end    : moment('${dtaa.twd05}').format('YYYY-MM-DD'),
 		          docId : `${dtaa.cvdid}`,
 		          project : `${fn:replace(dtaa.cvpopn, "'", "\\'")}`,
 		          customer : `${fn:replace(dtaa.partyName, "'", "\\'")}`,
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
			 			
				if(userIsOrigOrNot(edCpme,empCode)){ 				
				subOrdActv="Y"; 				
				taskDtls  += '<div class="evntdesc">';	
					if(calEvent.id == 'cv'){						
						var randomNum = Math.floor(Math.random()*100);
						var randomId = "close"+calEvent.id+randomNum+"";
						var randomFunc = "closeEventController('close"+calEvent.id+randomNum+"')";
						var customer = checkUndefinedorNot(calEvent.customer);
						taskDtls  += "<span id="+randomId+" onclick="+randomFunc+"  class='closeon pull-right'>";
					}else{
						var randomFunc = "closeEventController('close"+calEvent.id+"')";
						var randomId = "close"+calEvent.id+"";
						taskDtls  += "<span id="+randomId+" onclick="+randomFunc+"  class='closeon pull-right'>"; 
					}
					taskDtls += '<i class="fa fa-close"></i></span><div class="form-inline">'+
		            '<div class="form-control" style="font-weight: bold;color: black;">'+calEvent.title.substring(6)+'</div>'+
		            '<div class="form-control" style="color: black;"><i class="fa fa-calendar" aria-hidden="true" style="color:blue;"></i> '+moment(calEvent.start).format('YYYY-MM-DD').split("-").reverse().join("/")+'</div>'+
		            '<div class="form-control" style="color: black;"><i class="fa fa-clock-o" aria-hidden="true" style="color:blue;"></i> '+calEvent.sdtime+'-'+calEvent.edtime+'  </div></div>';
				      if(calEvent.id != 'cv'){ 
			            	taskDtls += '<p class="desc-text">'+descCrte+'</P>';    	            	
			            }else{
			            	taskDtls += '<b style="color: red;padding:5px;10px;15px;2px;"><u> Customer Visit </u></b><br/>';
			            	taskDtls += '<p class="desc-text"><b>Doc. Id : </b>'+docsId+'<br/>'; 	
			            	taskDtls += '<b>Action Type : </b>'+calEvent.title+'<br/>'; 	
			            	taskDtls += ' <b>Project/Party : </b>'+project+'<br/>';
			            	taskDtls += '  <b>Action Description : </b>'+descCrte+'<br/>';
			            	taskDtls += '  <b>Customer : </b>'+customer+'</P>';
		            }
			            taskDtls += '</div>';  
				}
				else{ 
					subOrdActv="N"; 
					taskDtls='<div class="evntdesc">';
					if(calEvent.id == 'cv'){
						var randomNum = Math.floor(Math.random()*100);
						var randomId = "close"+calEvent.id+randomNum+"";
						var randomFunc = "closeEventController('close"+calEvent.id+randomNum+"')";
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
		            if(calEvent.id != 'cv'){ 
		            	taskDtls += '<p class="desc-text">'+descCrte+'</P>';
		            	taskDtls += '<span class="editon" id="edit'+calEvent.id+'"><i class="fa fa-edit">Edit</i></span></P>';   	            	
		            }else{
		            	taskDtls += '<b style="color: red;padding:5px;10px;15px;5px;"><u> Customer Visit </u></b><br/>';
		            	taskDtls += '<p class="desc-text"><b>Doc. Id : </b>'+docsId+'<br/>'; 	
		            	taskDtls += '<b>Action Type : </b>'+calEvent.title+'<br/>'; 	
		            	taskDtls += ' <b>Project/Party : </b>'+project+'<br/>';
		            	taskDtls += '  <b>Action Description : </b>'+descCrte+'<br/>'; 
		            	taskDtls += '  <b>Customer : </b>'+customer+'</P>';
	            	
	            	
	            }
		            taskDtls += '</div>';							
	            }	
				
			    $('#evntDtls').append(taskDtls);
			    $('#evntDtls').find('#delete'+calEvent.id+'').click(function() {
			    if(typeof calEvent.id == undefined || calEvent.id == null ){	 
			    alert("refresh the page");
			    jsEvent.preventDefault();
				}else{ //alert('clicked on'+calEvent.id);
			    removeEventController(calEvent.id);
		        $('#calendar').fullCalendar('removeEvents',calEvent.id);
				}
		        }); 
			  /*  $('#evntDtls').find('#close'+calEvent.id+'').click(function() {
			    	alert('hi');
			    closeEventController(calEvent.id);    
		        }); */
			    $('#evntDtls').find('#edit'+calEvent.id+'').click(function() {			    	
			    updateEventController(calEvent);	     
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
				selectedDt = clickdday.getDate();
				var regltnBackDays =3;
				if (date.isoWeekday() == 4 || date.isoWeekday() == 5 || date.isoWeekday() == 3) {
					regltnBackDays = 5;
			        }  
				
		        var dateDiffrnc = dateDiffInDays(today,date);	
		        //console.log(dateDiffrnc);
				//if(date >= today || dateDiffrnc > 15 || userIsOrigOrNot(empCode,subOrd)){jsEvent.preventDefault();}
				//if(date >= today || dateDiffrnc > 1 || userIsOrigOrNot(empCode,subOrd)){jsEvent.preventDefault();}// WFH new memo Only Same Day and next day Daily Task
		        if(date >= today || dateDiffrnc > regltnBackDays || userIsOrigOrNot(empCode,subOrd)){jsEvent.preventDefault();}// Daily Task 3 Dyas gap allowed by RK
				else{selectedDay=date.format();
		        $("#evntDtls").empty();
		      //  $('#evntDay').html(date.format());//display day date after "Task Details"
		        $("#createEventModal .modal-title").html("Add New Task Details for  "+moment(date).format('YYYY-MM-DD').split("-").reverse().join("/"));
                $('#createEventModal').modal('show');}			  				 			     			    
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
	                filename: "Employee : ${deCpme}  Daily Task Details -  ${currMth}/${currYr}",
	                title: "Employee : ${deCpme} Daily Task Details -  ${currMth}/${currYr}",
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
function addDays(date, days) {
    var result = new Date(date);
    result.setDate(date.getDate() + days);
    return result;
}
</script>



 <!-- Modal -->
  <div class="modal fade" id="createEventModal" role="dialog" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
         <h4 class="modal-title">Add Task for </h4>
        </div>
        <div class="modal-body">
         <form name="createEvent">
			<div class="form-inline" style="padding-bottom:7px;">
			<select class="form-control" id="typ" name="typ" required>
			<option value="In-Office">In-Office</option>
			<option value="Out-Office">Out-Office</option> 
			<option  value="Customer-Visit">Customer-Visit</option>
			<option  value="Consultant-Visit ">Consultant-Visit</option>
			</select>
			<div class="input-group clockpicker pull-center" id="frmclock" data-placement="bottom" data-align="top" data-autoclose="true">	
			<span class="input-group-addon" style="background-color:#000;"><i class="fa fa-clock-o"> from</i></span>
			<input type="text" class="form-control" value="08:00" id="strtTime" style="width:60px;border: 0.05em solid black;"  required  readonly>
			</div>
		    <div class="input-group clockpicker pull-center" data-placement="left" data-align="top" data-autoclose="true">
			<input type="text" class="form-control"  id="endTime" value="18:00" style="width:60px;border: 0.05em solid black;"  required  readonly>
		    <span class="input-group-addon"  style="background-color:#000;"> <i class="fa fa-clock-o"> to</i> </span>
			</div>
			</div>	  
			<textarea  class="form-control" id="desc" placeholder="Enter Description" name="desc" style="margin-bottom: 7px;" maxlength="300" wrap="hard" required></textarea>
		    <span class="small pull-left" id="err-msg"></span><span class="small pull-right">(Maximum 300 character)</span><br/>
		    <button type="submit" class="btn btn-primary"  id="submitButton">Add Task <i class="fa fa-plus"></i></button>
		    </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
  
    <div class="modal fade" id="updateEventModal" role="dialog" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Add Task for </h4>
        </div>
        <div class="modal-body">
         <form  id="tskUpdt_form" >
			<div class="form-inline" style="padding-bottom:7px;">
			<select class="form-control" id="pyttu" required>
			<option value="In-Office">In-Office</option>
			<option value="Out-Office">Out-Office</option>
			<option  value="Customer-Visit">Customer-Visit</option>
			<option  value="Consultant-Visit ">Consultant-Visit</option>
			</select>
			<div class="input-group clockpicker pull-center" data-placement="left" data-align="top" data-autoclose="true">	
			<span class="input-group-addon" style="background-color:#000;"><i class="fa fa-clock-o"> from</i></span>
			 <input type="text" class="form-control" value="08:00" id="tstu" style="width:60px;border: 0.05em solid black;" required  readonly>
			</div>
		     <div class="input-group clockpicker pull-center" data-placement="left" data-align="top" data-autoclose="true">
			<input type="text" class="form-control"  id="tetu" value="18:00" style="width:60px;border: 0.05em solid black;" required readonly>
		    <span class="input-group-addon"  style="background-color:#000;"> <i class="fa fa-clock-o"> to</i> </span>
			</div>
		   </div>	  
		   <textarea  class="form-control" id="csedtu"  style="margin-bottom: 7px;" maxlength="300" wrap="hard" required></textarea>
		   <span class="small pull-right">(Maximum 300 character)</span>
		   <div id="errMsgup" style="color:red"></div>
		   <input type="hidden" value="" id="ditu" />    
		   <button type="submit" class="btn btn-primary" id="updateButton">Update Task <i class="fa fa-plus"></i></button>
		   </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
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