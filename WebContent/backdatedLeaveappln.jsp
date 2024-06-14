<%-- 
    Document   : backdatedLeaveappln.jsp 
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="mainview.jsp" %>
<%@page import="java.util.concurrent.ConcurrentHashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:choose>
    <c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1}">
     	<jsp:setProperty name="leave" property="emp_code" value="${param.emp_code}"/>     	
    	<jsp:useBean id="leave" class="beans.Leave" scope="session"/>
    	<c:set var="pendsize" value="${leave.allPendingLeaveApplications}"/>
    	<c:set var="encashsize" value="${leave.allPendingEncashmentApplications}"/>
        <c:set var="pendsize" value="${leave.allApprovedLeaveApplications}"/>
       
       
	    <jsp:useBean id="backdatedleave" class="beans.BackDatedLeaveApplication" scope="request"/>
        <jsp:useBean id="hday" class="beans.Holiday" scope="session"/>
        <jsp:setProperty name="hday" property="compCode" value="${param.comp_code}"/>
        <jsp:useBean id="cmp_param" class="beans.CompParam" scope="session"/>
<%--         <jsp:setProperty name="backdatedleave" property="cur_procm_startdt" value="${cmp_param.currentProcMonthStartDate}"/> --%>
        <jsp:setProperty name="backdatedleave" property="emp_code" value="${param.emp_code}"/>
        <jsp:setProperty name="backdatedleave" property="comp_code" value="${param.comp_code}"/>
<%--         <c:set var="hdaysize" value="${hday.allHolidaysofCurYear}"/>   --%>
<%--         <c:set var="pendsize" value="${backdatedleave.pendbusinesstripleaveapplications}"/> --%>
<%--        <c:set var="pendsize" value="${backdatedleave.allPendingLeaveApplications}"/>  --%>
        <%  java.util.Date start_dt = ((beans.CompParam) request.getSession().getAttribute("cmp_param")).getCurrentProcMonthStartDate();
            Calendar cal = Calendar.getInstance();
            cal.setTime(start_dt);
            int month = cal.get(Calendar.MONTH);
            int day = cal.get(Calendar.DAY_OF_MONTH);
            int year = cal.get(Calendar.YEAR);
            String today = day + "/" + month + "/" + year;
        %>
       
        <!DOCTYPE html>
        <head>
          <style>
          input[type="date"]::-webkit-clear-button {
    display: none;
}

/* Removes the spin button */
input[type="date"]::-webkit-inner-spin-button { 
    display: none;
}

/* Always display the drop down caret */
input[type="date"]::-webkit-calendar-picker-indicator {
    color: #2c3e50;
}

hr{margin-top:15px;margin-bottom:10px;border:0;border-top:1px solid #eeeeee;}

/* A few custom styles for date inputs */
input[type="date"] {
    appearance: none;
    -webkit-appearance: none;
    color: #95a5a6;
    font-family: "Helvetica", arial, sans-serif;
    font-size: 18px;
    border:1px solid #ecf0f1;
    background:#ecf0f1;
    padding:5px;
    display: inline-block !important;
    visibility: visible !important;
}

input[type="date"], focus {
    color: #95a5a6;
    box-shadow: none;
    -webkit-box-shadow: none;
    -moz-box-shadow: none;
}
  
.l_left1{width:48%; float:left; padding-right:1%;} 
.l_left2{width:26%; float:left;padding-right:1%;} 
.l_right1{width:49%; float:right;padding-right:1%;}
.l_leftcustome{width:50%; height:50px;float:left; padding-right:1%;}
.l_rightcustome{width:50%; float:right;}
.l_one{width:50%; float:left; margin: 0 0 0.5em 0;font-family: Arial, Helvetica, sans-serif;}
.l_left{width:48%; float:left; padding-right:1%;border-right:#B4B4B4 1px dotted;}
.l_right{width:49%; float:right;}
.l_one1{width:60%; float:left; margin: 0 0 0.5em 0;font-family: Arial, Helvetica, sans-serif;}
.l_one2{width:40%; float:left; margin: 0 0 0.5em 0;font-family: Arial, Helvetica, sans-serif;}    
hr{margin-top:15px;margin-bottom:10px;border:0;border-top:1px solid #eeeeee;}
</style>
            <link href="resources/css/jquery-ui.css" rel="stylesheet">
            <script src="resources/js/jquery-1.10.2.js"></script>
            <script src="resources/js/jquery-ui.js"></script>
            <script src="resources/js/leaveapplication.js?v=15062022"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>           		    
            <!-- Javascript -->
            <script>
            
            function verifyFormdata() {
                var fromdt = document.getElementById("datepicker-13").value;
                var todt = document.getElementById("datepicker-14").value;
                var reason = document.getElementById("reason").value;
                var leaveaddr = document.getElementById("leaveaddr").value;
                if (fromdt == null || todt == null || reason == null || leaveaddr == null) {
                    alert("Please fill the details properly");
                    return false;
                } else if (fromdt.trim().length == 0 || todt.trim().length == 0 || reason.trim().length == 0 || leaveaddr.trim().length == 0) {
                    alert("Please fill the details properly");
                    return false;
                }                
                return true;
              }
            //-- By Nufail for company code Start -->          
             var hr22LvPolicy = true;
            $(document).ready(function() { 
            	
            	var date = new Date();
            	var day = date.getDate();
            	var month = date.getMonth() + 1;
            	var year = date.getFullYear();
            	if (month < 10) month = "0" + month;
            	if (day < 10) day = "0" + day;
            	var today = day + "/" + month + "/" + year;
            	//document.getElementById("dateofReq").value = today;
            	//document.getElementById("dateofReq").disabled=true;
            	
            	 var companyCode="${fjtuser.emp_com_code}";
                 var calCode="${fjtuser.calander_code}";
                
                 if(calCode == 'SAT-THU' || calCode ==  'SUN-FRI'){hr22LvPolicy = false;}
                // console.log(companyCode+" "+calCode+" "+hr22LvPolicy);
             });
             var lvDfltYear='<%=year%>';
                var Applnlst = [];
                var appln, stdt, parts1, parts2, todt;
                <c:forEach items="${backdatedleave.pendleaveapplications}" var = "lvappl">
	                appln = new Object(); // 
	                stdt = '<c:out value="${lvappl.fromdate}"/>';
	                parts1 = stdt.split('-');
	                appln.startdate = new Date(parts1[0], Number(parts1[1]) - 1, parts1[2]);
	                todt = '<c:out value="${lvappl.todate}"/>';
	                parts2 = todt.split('-');
	                appln.enddate = new Date(parts2[0], Number(parts2[1]) - 1, parts2[2]);
	                Applnlst.push(appln);
                </c:forEach>
                <c:forEach items="${leave.pendleaveapplications}" var = "lvappl">
	                appln = new Object(); // 
	                stdt = '<c:out value="${lvappl.fromdate}"/>';
	                parts1 = stdt.split('-');
	                appln.startdate = new Date(parts1[0], Number(parts1[1]) - 1, parts1[2]);
	                todt = '<c:out value="${lvappl.todate}"/>';
	                parts2 = todt.split('-');
	                appln.enddate = new Date(parts2[0], Number(parts2[1]) - 1, parts2[2]);
	                Applnlst.push(appln);
                </c:forEach>
                <c:forEach items="${leave.apprleaveapplications}" var = "lvappl">
	                appln = new Object(); // 
	                stdt = '<c:out value="${lvappl.fromdate}"/>';
	                parts1 = stdt.split('-');
	                appln.startdate = new Date(parts1[0], Number(parts1[1]) - 1, parts1[2]);
	                todt = '<c:out value="${lvappl.todate}"/>';
	                parts2 = todt.split('-');
	                appln.enddate = new Date(parts2[0], Number(parts2[1]) - 1, parts2[2]);
	                Applnlst.push(appln);
                </c:forEach>
                var hdaylist = [];
                <c:forEach items="${hday.holidayList}" var="hdayitem">
               		 hdaylist.push('<c:out value="${hdayitem}"/>');
                </c:forEach> 
                ////nufail - exclude week days and hloidays /////
                function formatDate(date) {
					     var d = new Date(date),
					         month = '' + (d.getMonth() + 1),
					         day = '' + d.getDate(),
					         year = d.getFullYear();				
					     if (month.length < 2) month = '0' + month;
					     if (day.length < 2) day = '0' + day;					
					     return [year, month, day].join('-');
					 }
              
                $(function () {      
                	//var date = new Date(); 
                	//date. setDate(date. getDate() - 10);                 	        	
                	 $("#datepicker-13").datepicker({ maxDate: '+1Y', dateFormat: 'dd/mm/yy',  beforeShowDay: DisableCustomDaysForLeaveStart,firstDay: 0, onSelect: function (dateText, inst) {
                     $("#datepicker-14").datepicker("option", "minDate", $("#datepicker-13").datepicker("getDate"));
                     $("#datepicker-14").datepicker('enable');
                     $("#datepicker-14").datepicker('setDate', null);                         
                     }});
                    
                $("#datepicker-14").datepicker({maxDate: '+1Y', dateFormat: 'dd/mm/yy', beforeShowDay: DisableCustomDaysForLeaveStart, firstDay: 0, onSelect: CalculateLeaveDetails});
                <c:if test="${pageContext.request.method eq 'POST' and param.operationbutton eq 'Calculate'}">
                    var selfromdate = "${param.fromdate}";
                    var parts = selfromdate.split("/");
                    $("#datepicker-13").datepicker("setDate", new Date(parts[2], parts[1] - 1, parts[0]));
                    $("#datepicker-14").datepicker("option", "minDate", $("#datepicker-13").datepicker("getDate"));
                    <c:if test="${!empty param.todate}">
                    var seltodate = "${param.todate}";
                    var toparts = seltodate.split("/");
                    $("#datepicker-14").datepicker("setDate", new Date(toparts[2], toparts[1] - 1, toparts[0]));
                    </c:if>
                    $("#datepicker-14").datepicker('enable');
                </c:if>
                $("#datepicker-15").datepicker({minDate:0, maxDate: '+1Y', dateFormat: 'dd/mm/yy',  beforeShowDay: DisableCustomDaysForLeaveStart,firstDay: 0, onSelect: function (dateText, inst) {                                        
                    }});
                $("#datepicker-16").datepicker({minDate:0, maxDate: '+1Y', dateFormat: 'dd/mm/yy',  beforeShowDay: DisableCustomDaysForLeaveStart,firstDay: 0, onSelect: function (dateText, inst) {                                        
                }});

                });
                
                function CalculateLeaveDetails(datetext) {               	
                    var d1 = $("#datepicker-13").datepicker('getDate');
                    var d2 = $('#datepicker-14').datepicker('getDate');
                   // console.log("d2.getDate() + 1 " + (d2.getDate() + 1));
                    var nextDayDate = $('#datepicker-14').datepicker('getDate');
                    nextDayDate.setDate(d2.getDate() + 1);
                   // console.log("nextDay " + nextDayDate);
                    var diff = 0;
                    if (!d1) {
                        alert("Please enter a leave start date!");
                       $('#nolvdays').val("");
                       $('#totaldays').val("");
                       $('#balancedays').val("");
                        return;
                    }
                    var i = 0;
                    while (i < Applnlst.length) {
                        if (d1 <= Applnlst[i].startdate && d2 >= Applnlst[i].enddate) {
                            alert("Cannot Apply. There is already an applied leave in the range.");
                            $("#datepicker-14").datepicker('setDate', null);
                            $("#datepicker-13").datepicker('setDate', null);
                            manageFormElements(1);
                            return;
                        }
                        ++i;
                    }
                    if (d1 && d2) {                    	
                        diff = Math.floor((d2.getTime() - d1.getTime()) / 86400000); 
                        var totDays = diff+1;
                        if (diff == 0) {
                            var currentleavesel = document.getElementById("leavetype").value;
                            if (currentleavesel == 'CASUAL' || currentleavesel == 'SLV' || currentleavesel == 'SLVI' || currentleavesel == 'COMPASIONATE' ) {
                                $('#h_chkbox').attr('disabled', false);
                            } else
                                $('#h_chkbox').attr('disabled', true);
                        }
                        diff = diff + 1;

                        var currentleavesel = document.getElementById("leavetype").value;
                        //console.log(hr22LvPolicy+" "+currentleavesel);
                        if(hr22LvPolicy && (currentleavesel == 'AN30' || currentleavesel == 'AN15' || currentleavesel == 'AN30FJC')){
                        	 var weekendDays = calExcludeWeekHdayDays(d1,d2);
                        	 diff = diff - weekendDays;
                        }
                       
                        var balanceDays = ($('#currentLeaveBalance').val() - diff) ; //balance days after selecting from and to date
                    	 //console.log("weekdays : "+weekendDays)
                        $('#leavedays').val(diff);
                        $('#totaldays').val(totDays);
                        $('#balancedays').val((balanceDays > 0) ? balanceDays : 0);
                        var dd = nextDayDate.getDate();
                        var mm = nextDayDate.getMonth() + 1;
                        //console.log(mm);
                        var y = nextDayDate.getFullYear();
                        //console.log(dd + "/" + mm + "/" + y);
                        $('#resumedate').val($.datepicker.formatDate('dd/mm/yy', nextDayDate));
                    }
                }
                function calExcludeWeekHdayDays(start,end) {
             	   var leaveType=document.getElementById("leavetype").value;
             	  // console.log("holiday list");
                	  //console.log(hdaylist);
             	  var calendarCode="${fjtuser.calander_code}";
                	 // console.log("cc :"+calendarCode);
             	  var dayMilliseconds = 1000 * 60 * 60 * 24;
             	  var weekendDays = 0;
             	  if(calendarCode === 'SUN-THU'){
             		//  console.log('SUN-THU');
             	  while (start.getTime() <= end.getTime()) {
             	    var day = start.getDay();
             	    //console.log($.inArray(formatDate(start), hdaylist));          	    
             	    if (day == 5 || day == 6 || ($.inArray(formatDate(start), hdaylist) != -1)) {
             	    	
             	        weekendDays++;
             	    }
             	    start = new Date(+start + dayMilliseconds);
             	  }
             	  }else if(calendarCode === 'MON-FRI'){ 
                 	  while (start.getTime() <= end.getTime()) {
                 	    var day = start.getDay();
                 	   // console.log("Day : "+day);
                 	    //console.log($.inArray(formatDate(start), hdaylist));          	    
                 	    if (day == 0 || day == 6 || ($.inArray(formatDate(start), hdaylist) != -1)) {
                 	    	
                 	        weekendDays++;
                 	    }
                 	    start = new Date(+start + dayMilliseconds);
                 	  }
             		  
             	  }else if((leaveType == 'AN60' || leaveType == 'AN30' || leaveType == 'AN30FJC' || leaveType == 'AN15') && ( calendarCode === 'SAT-THU' || calendarCode === 'MON-SAT')){
             		 // console.log(calendarCode);
             		//  console.log(leaveType);
             		  while (start.getTime() <= end.getTime()) {
                   	    var day = start.getDay();
                         
                   	    if (day == 5||  day == 6 || ($.inArray(formatDate(start), hdaylist) != -1)) {
                   	        weekendDays++;
                   	    }
                   	    start = new Date(+start + dayMilliseconds);
             	  }
             		  
             	  }
             	  else{
             		  //console.log(calendarCode);
             		  //console.log(leaveType);
             		  while (start.getTime() <= end.getTime()) {
                   	    var day = start.getDay();
                         
                   	    if (day == 5|| ($.inArray(formatDate(start), hdaylist) != -1)) {
                   	        weekendDays++;
                   	    }
                   	    start = new Date(+start + dayMilliseconds);
             	  }
 				
 					}

 				  return weekendDays;
                 }
                $(function () {
                 var leaveType=document.getElementById("leavetype").value;
               // console.log("document ready function : "+leaveType);
                if(leaveType == 'AN30' || leaveType == 'AN60' || leaveType == 'CASUAL' || leaveType == 'CHRISTMAS' || leaveType == 'AN30FJC' || leaveType == 'AN15'){
                	//settings for blocking or restictrion to apply annual leave, casual and occasion backdate , so set minimum date is current date ie zero 
                	 $("#datepicker-13").datepicker({minDate: 0, maxDate: '+1Y', dateFormat: 'dd/mm/yy', beforeShowDay: DisableCustomDaysForLeaveStart, firstDay: 0, onSelect: function (dateText, inst) {
                         $("#datepicker-14").datepicker("option", "minDate", $("#datepicker-13").datepicker("getDate"));
                         $("#datepicker-14").datepicker('enable');
                         $("#datepicker-14").datepicker('setDate', null);
                         manageFormElements(1);
                         invokeCalculate();
                     }});
                	
                }
                else{
                	//no restriction for other leaves for applying back date
                	 $("#datepicker-13").datepicker({minDate: new Date(<%=year%>, <%=month%>, -1, <%=day%>), maxDate: '+1Y', dateFormat: 'dd/mm/yy', beforeShowDay: DisableCustomDaysForLeaveStart, firstDay: 0, onSelect: function (dateText, inst) {
                         $("#datepicker-14").datepicker("option", "minDate", $("#datepicker-13").datepicker("getDate"));
                         $("#datepicker-14").datepicker('enable');
                         $("#datepicker-14").datepicker('setDate', null);
                         manageFormElements(1);
                         invokeCalculate();
                     }});
                }
                   
                    
                    
             $("#datepicker-14").datepicker({minDate: new Date(<%=year%>, <%=month%>, -1, <%=day%>), maxDate: '+1Y', dateFormat: 'dd/mm/yy', beforeShowDay: DisableCustomDaysForLeaveEnd, firstDay: 0, disabled: true, onSelect: CalculateLeaveDetails});
                <c:if test="${pageContext.request.method eq 'POST' and param.operationbutton eq 'Calculate'}">
                    var selfromdate = "${param.fromdate}";
                    var parts = selfromdate.split("/");
                    $("#datepicker-13").datepicker("setDate", new Date(parts[2], parts[1] - 1, parts[0]));
                    $("#datepicker-14").datepicker("option", "minDate", $("#datepicker-13").datepicker("getDate"));
                    <c:if test="${!empty param.todate}">
                    var seltodate = "${param.todate}";
                    var toparts = seltodate.split("/");
                    $("#datepicker-14").datepicker("setDate", new Date(toparts[2], toparts[1] - 1, toparts[0]));
                    </c:if>
                    $("#datepicker-14").datepicker('enable');
                </c:if>

                });
                function DisableCustomDaysForLeaveStart(date) {
                    // var day = date.getDay();
                    var i = 0;
                    while (i < Applnlst.length) {
                        if (date >= Applnlst[i].startdate && date <= Applnlst[i].enddate) {
                            return [false, "", "Leave"];
                        }

                        ++i;
                    }
                    var leavetype = document.getElementById("leavetype").value;
                    if (leavetype != 'AN60' && leavetype != 'AN30' && leavetype != 'AN30FJC' && leavetype != 'AN15')
                        return [true];
                    //disable public holidays
                    var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
                    if ($.inArray(string, hdaylist) == -1)
                        return [true];
                    else
                        return [false, "", "Holiday"]
                }

                //////////////////////////////////
                function DisableCustomDaysForLeaveEnd(date) { 
                
                if(!hr22LvPolicy){
                    var day = date.getDay();
                    var leavetype = document.getElementById("leavetype").value;
                <c:choose>
                    <c:when test="${fjtuser.calander_code eq 'SUN-THU'}">
                    if (((day == 4 || day == 3 || day == 5) && (leavetype == 'AN60' || leavetype == 'AN30'  || leavetype == 'AN30FJC' || leavetype == 'AN15')) || day == 5) {
                        return [false];
                    }
                    </c:when>
                    <c:otherwise>
                    if (((day == 4 || day == 3) && (leavetype == 'AN60' || leavetype == 'AN30'  || leavetype == 'AN30FJC' || leavetype == 'AN15' )) || day == 4) {
                        return [false];
                    }
                    </c:otherwise>
                </c:choose>

                    else {
                        var resumedate = new Date(date.getFullYear(), date.getMonth(), date.getDate());
                        resumedate.setHours(0, 0, 0, 0);
                        resumedate.setDate(date.getDate() + 1);
                        //  console.log(date+": resume date:" + resumedate);
                        var i = 0;
                        while (i < Applnlst.length) {
                            if ((resumedate >= Applnlst[i].startdate && resumedate <= Applnlst[i].enddate) || (date >= Applnlst[i].startdate && date <= Applnlst[i].enddate)) {
                                return [false, "", "Leave"];
                            }
                            ++i;
                        }
                        //disable public holidays
                        var string = jQuery.datepicker.formatDate('yy-mm-dd', resumedate);
                        if ($.inArray(string, hdaylist) == -1)
                            return [true];
                        else
                            return [false, "", "Holiday"]
                    }
                }else{
                  //by nufail, disabled end date / resume date restriction on friday, sat , thusday and  holiday
                  return [true];
                }
                }
                function pad(num, size) {
                    var s = num+"";
                    while (s.length < size) s = "0" + s;    
                    return "E"+s;
                }

                function checkUid(uidbox){
                   //var uid = document.getElementById('fjuid').value;  
                   var uid = uidbox.value;
                   if(uid!=null)
                        uid = uid.trim();
                    if(uid.length == 0)
                    {
                       // alert("Please enter user id!");
                        return false;
                    }
                 
                    var reg = /^[eE]\d{6}$/;            //new RegExp('^[eE]\d{6}$');
                    var reg2 = /^\d{1,6}$/;             //new RegExp('/^\d{1,6}$/');                    
                   
                    if(reg.test(uid)){
                        //valid format - send it to server to check if it is a new user
                       // alert("valid format");//subtype
                       document.getElementById('subtype').value="uidchk";
                      // console.log(uidbox.form);
                      window.sessionStorage.setItem("lastlogin",uid); 
                       uidbox.form.submit();
                       return true;
                    }
                    else if(reg2.test(uid)){
                        var newuid = pad(uid,6);
                        uidbox.value = newuid;
                       document.getElementById('subtype').value="uidchk";
                      // console.log(uidbox.form);
                      window.sessionStorage.setItem("lastlogin",uid);                     
                       uidbox.form.submit();
                       
                       // alert(newuid);
                        return true;
                    }
                    else{
                        alert("invalid format for ID ");
                         uidbox.value="";
                        return false;
                    }  
                }
                function verifyEnter(event){
                    if (event.which === 13) {
                        event.stopPropagation();
                        event.preventDefault();
                        var uid = document.getElementById('traveler_emp_code').value;       
                        if(uid!=null)
                        uid = uid.trim();   
                        if(uid.length == 0)
                        {
                            alert("Please enter empcode");
                            return false;
                        }                          
                        }
                }
                function displaychekinoutdiv(radiobtnval){         
                   
                     var yesorno = radiobtnval.value; 
                     if(yesorno!=null && yesorno == 'Yes'){
                     	$('#chkindiv').show(0);
                        $('#chkoutdiv').show(0);
                     }
                     else{
                      	$('#chkindiv').hide(0); 
                        $('#chkoutdiv').hide(0);     
                     }
                }
            </script>
            
        </head>
        <div class="container">
        
        	<div class="panel panel-default  small" id="fj-page-head-box">
                     <div class="panel-heading" id="fj-page-head">
                        
                        <h4 class="text-left">
                       		Back Dated Leave Application
	                       <a href="homepage.jsp" > <i class="fa fa-home pull-right" title="Home"></i></a>
	                       <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a>                   
                       </h4>
                      
                     </div>
            </div>
            <div class="rest_box1">
                <c:choose>
                    <c:when test="${pageContext.request.method eq 'POST'}"> 
                       <c:if test="${!empty param.applybutton and param.applybutton eq 'Apply'}"> 
                            <c:set var="appstatus" value="${0}"/>                            
                             <jsp:setProperty name="backdatedleave" property="fromdateStr" param="fromdate"/>
                             <jsp:setProperty name="backdatedleave" property="todateStr" param="todate"/> 
                             <jsp:setProperty name="backdatedleave" property="reason" param="reason"/>
                             <jsp:setProperty name="backdatedleave" property="leavedays" param="leavedays"/>
                             <jsp:setProperty name="backdatedleave" property="totaldays" param="totaldays"/>
<%--                              <jsp:setProperty name="backdatedleave" property="leavebalance" param="leavebalance"/> --%>
                             <jsp:setProperty name="backdatedleave" property="leaveaddr" param="leaveaddr"/>
                             <jsp:setProperty name="backdatedleave" property="resumedateStr" param="resumedatee"/>
                             <jsp:setProperty name="backdatedleave" property="approverId" param="approverId"/>
                             <jsp:setProperty name="backdatedleave" property="leavetype" param="leavetype" /> 
                             <jsp:setProperty name="backdatedleave" property="comp_code" param="companyCode"/> 
                             <jsp:setProperty name="backdatedleave" property="emp_code" param="emp_code"/>   
                             <jsp:setProperty name="backdatedleave" property="emp_name" param="EmpName"/>                              
                            <c:set var="appstatus" value="${backdatedleave.sendBackDatedLVApplnForApproval}"/>
<%--                             <c:set var="refresh" value="${backdatedleave.pendbusinesstripleaveapplications}"/>  --%>
                            <c:choose>
                                <c:when test="${appstatus eq 1}">
                                    <div class="l_one">
                                        <div class="n_text_msg">
                                            Your application is submitted for approval. 
                                        </div>
                                    </div>
                                </c:when>
                                <c:when test="${appstatus eq 0}">
                                    <div class="l_one">
                                        <div class="n_text_msg">
                                            Can not Apply. Another application exists in the same range. 
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="l_one">
                                        <div class="n_text_msg">
                                            An error has occurred while processing your application. Try again later.${appstatus}
                                        </div>
                                    </div>
                                </c:otherwise>   
                            </c:choose>

                        </c:if> 
        
                        <c:if test="${param.subtype eq 'uidchk'}">                                                				
	                          <jsp:setProperty name="backdatedleave" property="emp_code" param="emp_code"/>	
	                         	 <c:set var="loginstatus" value="${backdatedleave.checkUid}"/> 
	                            	                         
	                         <form method="POST" action="backdatedLeaveappln.jsp">
	                           <div class="panel-heading" id="fj-page-head">                        
			                                          
		                       </div>	
	                         <%--  <div class="l_one"> --%> 
	                         <div class="l_left">
	                            <div class="l_one">	                               
                               	  <div class="n_text_narrow" id="frdt_label">Emp Code<span>*</span></div>
                               	  <input type="hidden" name="subtype" value="" id="subtype" /> 
                                  <input type="text" class="leave_text" id="emp_code" name="emp_code" tabindex="1" onblur="return checkUid(this);" onkeypress="verifyEnter(event);" value="${param.emp_code}" required="required">
                                   <c:if test="${loginstatus eq -1}"><div class="l_right" style="text-decoration:none; color: red">Invalid User</div>
                                   </c:if>	
                                 </div>
                                 <div class="l_one">
                                	  <div class="n_text_narrow" id="frdt_label">Emp Name</div>
                                       <input type="text" class="text_area"  id="EmpName" name="EmpName"  tabindex="2" value="${backdatedleave.emp_name}" required="required">
                                 </div> 
	                              <div class="l_one">
	                                    <div class="n_text_narrow">Leave Type<span>*</span></div>
	                                    <select id="leavetype" name="leavetype" class="select_box" onchange="return manageFormElements(2);">
	                                        <c:forEach var="entry" items="${backdatedleave.emp_leave_types}">
	                                            <c:choose>
	                                              <c:when test="${entry.key eq 'AN60' or entry.key eq 'AN30' or entry.key eq 'AN15'}">
	                                                    <option value="${entry.key}" data-bal="${entry.value.balance}" selected="selected" >${entry.value.lv_desc}</option> 
	                                                </c:when>	                                               
	                                                <c:otherwise>
	                                                    <option value="${entry.key}" data-bal="${entry.value.balance}" >${entry.value.lv_desc}</option> 
	                                                </c:otherwise>
	                                            </c:choose>
	
	                                        </c:forEach>   
	
	                                    </select>
	                                    <input type="hidden" name="leavebalance" id="leavebalance" />
	                                </div>
                                  <div class="l_one">
	                                	  <div class="n_text_narrow" id="frdt_label">Approver ID</div>
	                                       <input type="text" class="text_area" id="approverId" name="approverId" tabindex="3" value="${backdatedleave.approverId}" required="required">
	                               </div>
                                  <div class="l_one">
                                	  <div class="n_text_narrow" id="frdt_label">Division</div>
                                      <input type="text" class="leave_text" id="traveluDivision" name="travelUDivision" tabindex="4" value="${backdatedleave.emp_divn_code}" required="required">
                                 </div> 
                                  <div class="l_one">
                                	  <div class="n_text_narrow" id="frdt_label">Company Code</div>
                                      <input type="text" class="leave_text" id="companyCode" name="companyCode" tabindex="4" value="${backdatedleave.comp_code}" required="required">
                                 </div> 
                                  <div class="l_one">
                                    <div class="n_text_narrow" id="frdt_label">From Date<span>*</span></div>
                                    <input class="select_box2" readonly type="text" id="datepicker-13" name="fromdate" autocomplete="off">
                                    <input name="operationbutton" type="hidden" value="" id="calbutton" />
                                </div>
                                <div class="l_one">
                                    <div class="n_text_narrow">To Date<span>*</span></div>
                                    <input type="text" readonly class="select_box2"  id="datepicker-14" name="todate">
                                </div>
                                <div class="l_one">
                                    <div class="n_text_narrow">Leave Reason <span>*</span></div>
                                    <textarea name="reason" cols="5" rows="2" class="mybox" id="reason"></textarea>
                                </div>
                                <div class="l_one">
                                    <div class="n_text_narrow">Leave Address </div>
                                    <textarea name="leaveaddr" maxlength="30" cols="10" rows="2" class="mybox" id="leaveaddr">${param.leaveaddr}</textarea>
                                </div>   

                               </div> 
							<input type="hidden" name="totalleave" id="totalleave" value="${cur_accur}"/>
                            <div class="l_right">
<!--                                 <div class="l_one"> -->
<!--                                     <div class="n_text_msg1" id="initbalance" style="width:96%;"> -->
<%--                                         Current leave balance : <c:out value="${cur_accur}"/> --%>
<%--                                         <input type="hidden" name="currentLeaveBalance" id="currentLeaveBalance" value="${cur_accur}" disabled class="disabled_input"/> --%>
<!--                                     </div>    -->
<!--                                 </div> -->
                                <div class="l_one1">
                                    <div class="n_text_msg1" style="width:48%;">
                                        No. of leave days&nbsp;:<input style="width: 50px; border:none;background:white;color:black;" type="text" id="leavedays" class="disabled_input" name="leavedays"  tabindex="-1" onblur="return checkvalue();"/>
                                    </div> 
                                    
	                                 <div class="n_text_msg1" style="width:48%;">
	                                   No. of Calendar Days&nbsp;: <input style="width: 50px;border:none;background:white;color:black;"  type="text" id="totaldays" class="disabled_input" name="totaldays"   tabindex="-1" />
	                                 </div> 
                                </div> 
                                 <div class="l_one2">
<!-- 	                                 <div class="n_text_msg1" style="width:48%;"> -->
<!-- 	                                   Balance Days&nbsp;: <input style="width: 50px; border:none;background:white;color:black;"  type="text" id="balancedays" name="balancedays" disabled="true" class="disabled_input"  tabindex="-1" /> -->
<!-- 	                                 </div>  -->
	                                  <div class="n_text_msg1" style="width:98%;">
                                        Resume date&nbsp;:<input style="width: max-content; border:none;background:white;color:black;" type="text" readonly id="resumedate" name="resumedatee" class="disabled_input" tabindex="-1"/>
                                    </div> 
                                </div>
                            </div>                     
                            <div class="clear"></div>
	                            <div class="s_box2">
	                                 <input type="hidden" name="projectDetails" class="sbt_btn" value="" id="projectDetails"/>
	                        	     <input type="hidden" name="purpose" class="sbt_btn" value="" id="purpose"/>
	                        	     <input type="hidden" name="otherDetails" class="sbt_btn" value="" id="otherDetails"/>
	                        	     <input type="hidden" name="approverId" class="sbt_btn" value="${backdatedleave.approverId}" id="t_approver_eid"/>
	                        	     <input type="hidden" name="comp_code" class="sbt_btn" value="${backdatedleave.comp_code}" id="t_comp_code"/>
	                                <input name="applybutton" type="submit" value="Apply" class="sbt_btn" onclick="return verifyFormdata(this);"/>
	                                <input name="resetbutton" type="reset" value="Cancel" class="btn_can" />
	                            </div>
	                        </form> 
                    </c:if>  
                    </c:when>	
                   
                    <c:otherwise>
                        <form method="POST" action="backdatedLeaveappln.jsp"> 
		                     		                
                           <div class="l_left">
                            <div class="panel-heading" id="fj-page-head">                        
		                                             
		                     </div>
                                <div class="l_one">
                                	  <div class="n_text_narrow" id="frdt_label">Emp Code<span>*</span></div>
                                	  <input type="hidden" name="subtype" value="" id="subtype" /> 
                                      <input type="text" class="leave_text" id="travelerUid" name="emp_code" tabindex="1"  onblur="return checkUid(this);" onkeypress="verifyEnter(event);"  autocomplete="off" required="required">
                                </div>  
                                <div class="l_one">
                                	  <div class="n_text_narrow" id="frdt_label">Emp Name</div>
                                       <input type="text" class="text_area"  id="EmpName" name="EmpName"  tabindex="2" value="${backdatedleave.emp_name}" required="required">
                                 </div> 
	                              <div class="l_one">
	                                    <div class="n_text_narrow">Leave Type<span>*</span></div>
	                                    <select id="leavetype" name="leavetype" class="select_box" onchange="return manageFormElements(2);">
	                                        <c:forEach var="entry" items="${leave.emp_leave_types}">
	                                            <c:choose>
	                                              <c:when test="${entry.key eq 'AN60' or entry.key eq 'AN30' or entry.key eq 'AN15'}">
	                                                    <option value="${entry.key}" data-bal="${entry.value.balance}" selected="selected" >${entry.value.lv_desc}</option> 
	                                                </c:when>	                                               
	                                                <c:otherwise>
	                                                    <option value="${entry.key}" data-bal="${entry.value.balance}" >${entry.value.lv_desc}</option> 
	                                                </c:otherwise>
	                                            </c:choose>
	
	                                        </c:forEach>   
	
	                                    </select>
	                                    <input type="hidden" name="leavebalance" id="leavebalance" />
	                                </div>
                                  <div class="l_one">
	                                	  <div class="n_text_narrow" id="frdt_label">Approver ID</div>
	                                       <input type="text" class="text_area" id="approverId" name="approverId" tabindex="3" value="${backdatedleave.approverId}" required="required">
	                               </div>
                                  <div class="l_one">
                                	  <div class="n_text_narrow" id="frdt_label">Division</div>
                                      <input type="text" class="leave_text" id="traveluDivision" name="travelUDivision" tabindex="4" value="${backdatedleave.emp_divn_code}" required="required">
                                 </div> 
                                  <div class="l_one">
                                	  <div class="n_text_narrow" id="frdt_label">Company Code</div>
                                      <input type="text" class="leave_text" id="companyCode" name="companyCode" tabindex="4" value="${backdatedleave.comp_code}" required="required">
                                 </div> 
                                  <div class="l_one">
                                    <div class="n_text_narrow" id="frdt_label">From Date<span>*</span></div>
                                    <input class="select_box2" readonly type="text" id="datepicker-13" name="fromdate" autocomplete="off">
                                    <input name="operationbutton" type="hidden" value="" id="calbutton" />
                                </div>
                                <div class="l_one">
                                    <div class="n_text_narrow">To Date<span>*</span></div>
                                    <input type="text" readonly class="select_box2"  id="datepicker-14" name="todate">
                                </div>
                                <div class="l_one">
                                    <div class="n_text_narrow">Leave Reason <span>*</span></div>
                                    <textarea name="reason" cols="5" rows="2" class="mybox" id="reason"></textarea>
                                </div>
                                <div class="l_one">
                                    <div class="n_text_narrow">Leave Address </div>
                                    <textarea name="leaveaddr" maxlength="30" cols="10" rows="2" class="mybox" id="leaveaddr">${param.leaveaddr}</textarea>
                                </div>            

                            </div>                           
							<div class="l_right">

                                <div class="l_one1">
                                    <div class="n_text_msg1" style="width:50%;">
                                        No. of leave days&nbsp;:<input style="width: 50px; border:none;background:white;color:black;" type="text" id="leavedays" class="disabled_input" name="leavedays"  tabindex="-1" onblur="return checkvalue();"/>
                                    </div> 
                                    
	                                 <div class="n_text_msg1" style="width:49%;">
	                                   No. of Calendar Days&nbsp;: <input style="width: 60px;border:none;background:white;color:black;"  type="text" id="totaldays" class="disabled_input" name="totaldays"   tabindex="-1" />
	                                 </div> 
                                </div> 
                                
                                 <div class="l_one2">
	                                  <div class="n_text_msg1" style="width:98%;">
                                        Resume date&nbsp;:<input style="width: max-content; border:none;background:white;color:black;" type="text" readonly id="resumedate" name="resumedatee" class="disabled_input" tabindex="-1"/>
                                    </div> 
                                </div>

                            </div>
                           
                            <div class="clear"></div>
                            <hr style="height:1px;border-width:0;color:gray;background-color:gray">
                            <div class="s_box2">
                                <input name="operationbutton" type="hidden" value="" id="calbutton" />
                                <input name="applybutton" type="button" value="Apply" class="sbt_btn" onclick='invokeApply(this);' />
                                <input name="resetbutton" type="reset" value="Cancel" class="btn_can" />
                                
                            </div>
                             
                        </form>
                    </c:otherwise>
                </c:choose>
            </div>
	
 
        </div>   


        <div class="clear"></div>
    </body>
</html>
</c:when>
<c:otherwise>
    <html>
        <body onload="window.top.location.href = 'logout.jsp'">
        </body>

    </body>
</html>
</c:otherwise>
</c:choose>