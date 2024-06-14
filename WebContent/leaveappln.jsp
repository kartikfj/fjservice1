<%-- 
    Document   : leaveappln 
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
        <jsp:useBean id="leave" class="beans.Leave" scope="session"/>
        <jsp:useBean id="hday" class="beans.Holiday" scope="session"/>
        <jsp:useBean id="businessleave" class="beans.BusinessTripLVApplication" scope="session"/>
        <jsp:setProperty name="hday" property="compCode" value="${fjtuser.emp_com_code}"/>
        <jsp:useBean id="cmp_param" class="beans.CompParam" scope="session"/>
        <jsp:setProperty name="leave" property="emp_code" value="${fjtuser.emp_code}"/>
        <jsp:setProperty name="leave" property="emp_comp_code" value="${fjtuser.emp_com_code}"/>
        <jsp:setProperty name="leave" property="cur_procm_startdt" value="${cmp_param.currentProcMonthStartDate}"/>
        <jsp:setProperty name="businessleave" property="emp_code" value="${fjtuser.emp_code}"/>
        <jsp:setProperty name="businessleave" property="cur_procm_startdt" value="${cmp_param.currentProcMonthStartDate}"/>
        <c:set var="listsize" value="${leave.currentLeaveBalances}"/>
        <c:set var="pendsize" value="${leave.allPendingLeaveApplications}"/>
        <c:set var="encashsize" value="${leave.allPendingEncashmentApplications}"/>
        <c:set var="pendsize" value="${leave.allApprovedLeaveApplications}"/>
        <c:set var="hdaysize" value="${hday.allHolidaysofCurYear}"/>  
        <c:set var="pendsize" value="${businessleave.allPendingLeaveApplications}"/> 
       
        <%  java.util.Date start_dt = ((beans.CompParam) request.getSession().getAttribute("cmp_param")).getCurrentProcMonthStartDate();
            Calendar cal = Calendar.getInstance();
            cal.setTime(start_dt);
            int month = cal.get(Calendar.MONTH);
            int day = cal.get(Calendar.DAY_OF_MONTH);
            int year = cal.get(Calendar.YEAR);

        %>
       
        <!DOCTYPE html>
        <head>
            <link href="resources/css/jquery-ui.css" rel="stylesheet">
            <script src="resources/js/jquery-1.10.2.js"></script>
            <script src="resources/js/jquery-ui.js"></script>
            <script src="resources/js/leaveapplication.js?v=15062022"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
            <!-- Javascript -->
            <script>
            //-- By Nufail for company code Start -->          
             var hr22LvPolicy = true;
            $(document).ready(function() { 
            	 var companyCode="${fjtuser.emp_com_code}";
                 var calCode="${fjtuser.calander_code}";
                
                 if(calCode == 'SAT-THU' || calCode ==  'SUN-FRI'){hr22LvPolicy = false;}
                // console.log(companyCode+" "+calCode+" "+hr22LvPolicy);
             });
           
            
            //-- By Nufail for Occassional and Casual leave Restriction Start -->
             var lvDfltYear='<%=year%>';
            // console.log("LEAVE YAER DEFAULT "+lvDfltYear)
            //-- By Nufail for Occassional and Casual leave Restriction End -->
                var Applnlst = [];
                var appln, stdt, parts1, parts2, todt;
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
                <c:forEach items="${businessleave.pendleaveapplications}" var = "lvappl">
	                appln = new Object(); // 
	                stdt = '<c:out value="${lvappl.fromdate}"/>';
	                parts1 = stdt.split('-');
	                appln.startdate = new Date(parts1[0], Number(parts1[1]) - 1, parts1[2]);
	                todt = '<c:out value="${lvappl.todate}"/>';
	                parts2 = todt.split('-');
	                appln.enddate = new Date(parts2[0], Number(parts2[1]) - 1, parts2[2]);
	                Applnlst.push(appln);
               </c:forEach>
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
                ////////////////////////////////////
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
                        $('#nolvdays').val(diff);
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
            </script>
            
        </head>
        <div class="container">
        
        	<div class="panel panel-default  small" id="fj-page-head-box">
                     <div class="panel-heading" id="fj-page-head">
                        
                        <h4 class="text-left">
                         Leave Application
	                       <a href="homepage.jsp" > <i class="fa fa-home pull-right" title="Home"></i></a>                         
	                       <a href="leaveappln.jsp"> <i class="fa fa-refresh pull-right"></i></a>                       
	                       <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a>                   
                       </h4>
                      
                     </div>
            </div>
        
         <!--  <div class="att_searchbox">
                <h1>
                Leave Application/ Leave encashment Application   
                              
                <span class="pull-right" style="padding:4px 10px;">
                       <a href="calendar.jsp"> <i class="fa fa-home pull-right"></i></a>                      
                        <a href="leaveappln.jsp"> <i class="fa fa-refresh" ></i></a> 
                </span>
                
                </h1>
            </div>-->
            <div class="rest_box1">
                <c:choose>
                    <c:when test="${pageContext.request.method eq 'POST'}">   
                        <c:if test="${param.operationbutton eq 'Calculate'}">
                            <jsp:setProperty name="leave" property="cur_leave_type" param="leavetype"/>
                            <jsp:setProperty name="leave" property="cur_fromdt" param="fromdate"/>
                            <c:set var="cur_accur" value="${leave.currentAccruedLeave}"/>
                            <c:set var="future_lv" value="${0}"/>

                            <c:if test="${leave.cur_leave_type eq 'AN30' or leave.cur_leave_type eq 'AN60' or leave.cur_leave_type eq 'AN30FJC' or leave.cur_leave_type eq 'AN15'}">
                                <c:set var="future_lv" value="${leave.callfunctionasSQL}"/>
                                <c:set var="joiningdate" value="${leave.joiningDate}"/>
                                <input type="hidden" name="joiningdate" id="joiningdate" value="${joiningdate}"/>
                            </c:if>
                            <c:set var="available_lv" value=""/>
                            <c:if test="${cur_accur ge 0}">
                                <c:set var="available_lv" value="${future_lv + cur_accur}"/>
                            </c:if>
                            <form method="post" id="theform" action="leaveappln.jsp">
                                <div class="l_left">
                                    <div class="l_one">
                                        <div class="n_text_narrow">Leave Type<span>*</span></div>
                                        <select id="leavetype" name="leavetype" class="select_box" onchange="return manageFormElements(2);">
                                            <c:forEach var="entry" items="${leave.emp_leave_types}">
                                                <c:choose>
                                                    <c:when test="${param.leavetype eq entry.key}">                                                    
                                                        <option value="${entry.key}" selected="selected" data-bal="${entry.value.balance}">${entry.value.lv_desc}</option>                                                    
                                                    </c:when>
                                                    <c:when test="${entry.key eq 'LENC'}">
                                                       <c:if test="${fjtuser.calander_code eq 'SAT-THU' or fjtuser.calander_code eq  'MON-SAT' }"> <!-- After Pop Error Message Leave encashment option blocked for staff employees -->
                                                       <option value="${entry.key}" data-bal="${entry.value.balance}" >${entry.value.lv_desc}</option> 
                                                       </c:if>
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
                                        <div class="n_text_narrow" id="frdt_label">From Date<span>*</span></div>
                                        <input class="select_box2" readonly type="text" id="datepicker-13" name="fromdate" value="${param.fromdate}" autocomplete="off"/>
                                        <input name="operationbutton" type="hidden" value="" id="calbutton" />
                                    </div>
                                    <div class="l_one">
                                        <div class="n_text_narrow">To Date<span>*</span></div>
                                        <input type="text" readonly class="select_box2"  id="datepicker-14" name="todate" value="${param.todate}"/>
                                    </div>
                                    <div class="l_one">

                                        <c:choose>
                                            <c:when test="${!empty param.ishalfday}">
                                                <div class="n_text_narrow_hd">
                                                    <input type="checkbox" value="Halfday" name="ishalfday" id="h_chkbox" onchange="changeRadios(this);" checked/><label class="short_label" disabled="true" >  Apply half day :</label>
                                                </div>
                                                <div style="float: right; width: 70%">
                                                    <div id="halfday_opt" class="n_radiobutton_box"> 

                                                        <c:choose>
                                                            <c:when test="${!empty param.halfday and param.halfday eq 'first'}">
                                                                <div class="n_text_left">First Half <input name="halfday" type="radio" value="first" class="radiobutton" id="radiohf" onclick="setHalfDay(this);" checked/></div>  
                                                                <div class="n_text_right">Second Half <input name="halfday" type="radio" value="second" class="radiobutton" id="radiohs" onclick="setHalfDay(this);"/></div>
                                                                </c:when>
                                                                <c:when test="${!empty param.halfday and param.halfday eq 'second'}">
                                                                <div class="n_text_left">First Half <input name="halfday" type="radio" value="first" class="radiobutton" id="radiohf" onclick="setHalfDay(this);" /></div>  
                                                                <div class="n_text_right">Second Half <input name="halfday" type="radio" value="second" class="radiobutton" id="radiohs" onclick="setHalfDay(this);" checked/></div>
                                                                </c:when>
                                                                <c:otherwise>
                                                                <div class="n_text_left">First Half <input name="halfday" type="radio" value="first" class="radiobutton" id="radiohf" onclick="setHalfDay(this);" /></div>  
                                                                <div class="n_text_right">Second Half <input name="halfday" type="radio" value="second" class="radiobutton" id="radiohs" onclick="setHalfDay(this);"/></div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                    </div>    
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="n_text_narrow_hd">
                                                    <input type="checkbox" value="Halfday" name="ishalfday" id="h_chkbox" onchange="changeRadios(this);" disabled="true" /><label class="short_label" disabled="true" >  Apply half day :</label>
                                                </div>
                                                <div style="float: right; width: 70%">
                                                    <div id="halfday_opt" class="n_radiobutton_box">  
                                                        <div class="n_text_left">First Half <input name="halfday" type="radio" value="first" class="radiobutton" id="radiohf" disabled="true" onclick="setHalfDay(this);"/></div>  
                                                        <div class="n_text_right">Second Half <input name="halfday" type="radio" value="second" class="radiobutton" id="radiohs" disabled="true" onclick="setHalfDay(this);"/></div>
                                                    </div>    
                                                </div>
                                            </c:otherwise>
                                        </c:choose>

                                    </div>         
                                    <div class="l_one">
                                        <div class="n_text_narrow">Leave  Reason <span>*</span></div>
                                        <textarea name="reason" cols="10" rows="2" class="mybox" id="reason">${param.reason}</textarea>
                                    </div>
                                    <div class="l_one">
                                        <div class="n_text_narrow">Leave Address </div>
                                        <textarea name="leaveaddr" cols="10" rows="2" class="mybox" id="leaveaddr" maxlength="30">${param.leaveaddr}</textarea>
                                    </div>
                                </div>
                                <div class="l_right">
                                    <div class="l_one">
                                        <div class="n_text_msg1" id="initbalance" style="width:96%;">
                                            Current leave  <%--<c:out value="${leave.emp_leave_types[ param.leavetype ].lv_desc}"/> --%> balance : <c:out value="${cur_accur}"/><br/>
                                             <input type="hidden" name="currentLeaveBalance" id="currentLeaveBalance" value="${cur_accur}" disabled class="disabled_input"/>
                                             <c:if test="${param.leavetype eq 'AN60' or param.leavetype eq 'AN30' or param.leavetype eq 'AN15' or param.leavetype eq 'AN30FJC'}">
                                          <span class="text-info">Leave to be accrued till <c:out value="${param.fromdate}" /> :</span> <c:out value="${future_lv}"/><br/>
                                            <span class="text-info">Total accrued leave balance:</span> <c:out value="${available_lv - (available_lv % 1)}"/>
                                            </c:if>
                                            <input type="hidden" id="ttlmaxaccrvllv" value="${future_lv}"/>
                                        </div>
                                    </div>
                                    <input type="hidden" name="totalleave" id="totalleave" value="${available_lv - (available_lv % 1)}"/>
                                    <div class="l_one">
                                        <div class="n_text_msg1" style="width:48%;">
                                            No. of Leave days&nbsp;: <input style="width: 50px; border:none;background:white;color:black;" type="text" id="nolvdays" name="nolvdays" disabled="true" class="disabled_input" value="${param.nolvdays}" tabindex="-1" onblur="return checkvalue();"/>
                                        </div>   
                                        <div class="n_text_msg1" style="width:48%;">
			                                 No. of Calendar Days&nbsp;: <input style="width: 50px; border:none;background:white;color:black;" style="border:none;background:white;color:black;" type="text" id="totaldays" name="totaldays" disabled="true" class="disabled_input" value="${param.totaldays}" tabindex="-1" />
			                             </div>
                                    </div>  
                                     <div class="l_one">
		                                 <div class="n_text_msg1"  style="width:48%;">
		                                   Balance Days&nbsp;: <input style="width: 50px; border:none;background:white;color:black;"  type="text" id="balancedays" name="balancedays" disabled="true" class="disabled_input"  tabindex="-1" />
		                                 </div>  
		                                 <div class="n_text_msg1" style="width:48%;">
                                            Resume date&nbsp;: <input style="width: max-content; border:none;background:white;color:black;" type="text" readonly id="resumedate" name="resumedate" class="disabled_input" value="${param.resumedate}" tabindex="-1"/>
                                        </div>
                                	</div>
                                    <div class="l_one">
                                        <div class="n_text_msg1" style="width:96%;">
	                                        <span class="text-danger" >		                                          
		                                          <c:choose>
		                                          <c:when test="${ fjtuser.calander_code eq 'SAT-THU' or fjtuser.calander_code eq  'SUN-FRI'}"> 
		                                          All leaves calculation based on <b>calendar</b>days.
		                                          </c:when>
		                                          <c:otherwise>
		                                          Annual Leave calculation based on <b>working</b> days.<br/><br/>
		                                          Other leaves calculation based on <b>calendar</b> days.
		                                          </c:otherwise></c:choose>		                                           
	                                          </span>                                          
                                        </div>
                                    </div>
                                    <div class="l_one">
                                        <div class="n_text_narrow">Authorized by</div>
                                        <div class="d_box">${fjtuser.approverName}</div>
                                    </div>

                                </div>
                                <div class="clear"></div>
                                <div class="s_box2">
                                    <input name="applybutton" type="button" value="Apply" class="sbt_btn" onclick='invokeApply(this);' />
                                    <input name="resetbutton" type="reset" value="Cancel" class="btn_can" />
                                </div>
                            </form>

                        </c:if>
                        <c:if test="${param.operationbutton eq 'Apply'}"> 
                            <c:set var="appstatus" value="${0}"/>
                            <c:choose>
                                <c:when test="${param.leavetype eq 'LENC'}">
                                    <c:if test="${!empty param.fromdate and !empty param.reason and !empty param.nolvdays}"> 
                                        <jsp:useBean id="currentencash" class="beans.LeaveEncashment" scope="request"/>
                                        <c:choose>
                                            <c:when test="${!empty leave.emp_leave_types['AN60']}">
                                                <jsp:setProperty name="currentencash" property="leavetype" value="AN60"/>
                                                <jsp:setProperty name="currentencash" property="lv_desc" value="${leave.emp_leave_types[ 'AN60' ].lv_desc}"/>
                                            </c:when>
                                            <c:when test="${!empty leave.emp_leave_types['AN15']}">
                                                <jsp:setProperty name="currentencash" property="leavetype" value="AN15"/>
                                                <jsp:setProperty name="currentencash" property="lv_desc" value="${leave.emp_leave_types[ 'AN15' ].lv_desc}"/>
                                            </c:when>
                                            <c:otherwise>
                                                <jsp:setProperty name="currentencash" property="leavetype" value="AN30"/>
                                                <jsp:setProperty name="currentencash" property="lv_desc" value="${leave.emp_leave_types[ 'AN30' ].lv_desc}"/>
                                            </c:otherwise>
                                        </c:choose>
                                        <jsp:setProperty name="currentencash" property="effectivedateStr" param="fromdate"/>
                                        <jsp:setProperty name="currentencash" property="reason" param="reason"/>
                                        <jsp:setProperty name="currentencash" property="encashdays" param="nolvdays"/>
                                        <jsp:setProperty name="currentencash" property="emp_name" value="${fjtuser.uname}"/>
                                        <jsp:setProperty name="currentencash" property="emp_code" value="${fjtuser.emp_code}"/>
                                        <jsp:setProperty name="currentencash" property="approver_id" value="${fjtuser.approver}"/>
                                        <jsp:setProperty name="currentencash" property="approverEId" value="${fjtuser.approverId}"/>
                                        <jsp:setProperty name="currentencash" property="comp_code" value="${fjtuser.emp_com_code}"/> 
                                        <c:set var="appstatus" value="${currentencash.sendLeaveEncashmentForApproval}"/>
                                        <c:set var="refresh" value="${leave.allPendingEncashmentApplications}"/>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    <jsp:useBean id="currentapp" class="beans.LeaveApplication" scope="request"/>
                                    <jsp:setProperty name="currentapp" property="fromdateStr" param="fromdate"/>
                                    <jsp:setProperty name="currentapp" property="todateStr" param="todate"/> 
                                    <jsp:setProperty name="currentapp" property="reason" param="reason"/>
                                    <jsp:setProperty name="currentapp" property="leavedays" param="nolvdays"/>
                                    <jsp:setProperty name="currentapp" property="totaldays" param="totaldays"/><!-- Total day days without weekend and holiday -->
                                    <jsp:setProperty name="currentapp" property="leavebalance" param="leavebalance"/>
                                    <jsp:setProperty name="currentapp" property="leaveaddr" param="leaveaddr"/>
                                    <jsp:setProperty name="currentapp" property="resumedateStr" param="resumedate"/>
                                    <jsp:setProperty name="currentapp" property="leavetype" param="leavetype" />
                                    <jsp:setProperty name="currentapp" property="emp_name" value="${fjtuser.uname}"/>
                                    <jsp:setProperty name="currentapp" property="emp_code" value="${fjtuser.emp_code}"/>
                                    <jsp:setProperty name="currentapp" property="approver" value="${fjtuser.approver}"/>
                                    <jsp:setProperty name="currentapp" property="approverId" value="${fjtuser.approverId}"/>
                                    <jsp:setProperty name="currentapp" property="comp_code" value="${fjtuser.emp_com_code}"/>
                                    <jsp:setProperty name="currentapp" property="proc_date" value="${cmp_param.currentProcMonthStartDate}"/>    
                                    <c:set var="appstatus" value="${currentapp.sendApplicationForApproval}"/>
                                    <c:set var="refresh" value="${leave.allPendingLeaveApplications}"/>
                                </c:otherwise>
                            </c:choose>
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
                        <c:if test="${!empty param.cancelleave and !empty param.applntype and param.cancelleave eq 'Cancel'}">
                            <c:choose>
                                <c:when test="${param.applntype eq 'encash'}">
                                    <jsp:useBean id="cancelencash" class="beans.LeaveEncashment" scope="request"/>                                                    
                                    <jsp:setProperty name="cancelencash" property="applied_dateFromStr" param="applieddt"/>
                                    <jsp:setProperty name="cancelencash" property="emp_name" value="${fjtuser.uname}"/>
                                    <jsp:setProperty name="cancelencash" property="emp_code" value="${fjtuser.emp_code}"/>
                                    <jsp:setProperty name="cancelencash" property="approver_id" value="${fjtuser.approver}"/>
                                    <jsp:setProperty name="cancelencash" property="approverEId" value="${fjtuser.approverId}"/>
                                    <jsp:setProperty name="cancelencash" property="comp_code" value="${fjtuser.emp_com_code}"/>
                                    <c:set var="appstatus" value="${cancelencash.cancelEncashApplication}"/>
                                    <c:set var="refresh" value="${leave.allPendingEncashmentApplications}"/>

                                </c:when>
                                <c:otherwise>
                                    <jsp:useBean id="cancelapp" class="beans.LeaveApplication" scope="request"/>
                                    <jsp:setProperty name="cancelapp" property="emp_name" value="${fjtuser.uname}"/>
                                    <jsp:setProperty name="cancelapp" property="emp_code" value="${fjtuser.emp_code}"/>
                                    <jsp:setProperty name="cancelapp" property="approver" value="${fjtuser.approver}"/>
                                    <jsp:setProperty name="cancelapp" property="approverId" value="${fjtuser.approverId}"/>
                                    <jsp:setProperty name="cancelapp" property="comp_code" value="${fjtuser.emp_com_code}"/> 
                                    <jsp:setProperty name="cancelapp" property="applied_dateFromStr" param="applieddt"/> 
                                    <c:set var="appstatus" value="${cancelapp.cancelLeaveApplication}"/>
                                    <c:set var="refresh" value="${leave.allPendingLeaveApplications}"/>
                                </c:otherwise>
                            </c:choose>                   
                            <c:choose>
                                <c:when test="${appstatus eq 1}">
                                    <div class="l_one">
                                        <div class="n_text_msg">
                                            Your application is canceled. 
                                        </div>
                                    </div>
                                </c:when>
                                <c:when test="${appstatus eq 0 or appstatus eq -1}">
                                    <div class="l_one">
                                        <div class="n_text_msg">
                                            Can not cancel. It is processed already. 
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
                    </c:when>

                    <c:otherwise>
                        <c:choose>
                            <c:when test="${!empty leave.emp_leave_types['AN60']}">
                                <jsp:setProperty name="leave" property="cur_leave_type" value="AN60"/>
                            </c:when>
                            <c:when test="${!empty leave.emp_leave_types['AN30FJC']}">
                                <jsp:setProperty name="leave" property="cur_leave_type" value="AN30FJC"/>
                            </c:when>
                            <c:when test="${!empty leave.emp_leave_types['AN15']}">
                                <jsp:setProperty name="leave" property="cur_leave_type" value="AN15"/>
                            </c:when>
                            <c:otherwise>
                                <jsp:setProperty name="leave" property="cur_leave_type" value="AN30"/>
                            </c:otherwise>
                        </c:choose>                           
                        <c:set var="cur_accur" value="${leave.currentAccruedLeave}"/>
                        <form method="post" id="theform" action="leaveappln.jsp">
                            <div class="l_left">
                                <div class="l_one">
                                    <div class="n_text_narrow">Leave Type<span>*</span></div>
                                    <select id="leavetype" name="leavetype" class="select_box" onchange="return manageFormElements(2);">
                                        <c:forEach var="entry" items="${leave.emp_leave_types}">
                                            <c:choose>
                                              <c:when test="${entry.key eq 'AN60' or entry.key eq 'AN30' or entry.key eq 'AN15'}">
                                                    <option value="${entry.key}" data-bal="${entry.value.balance}" selected="selected" >${entry.value.lv_desc}</option> 
                                                </c:when>
                                                <c:when test="${entry.key eq 'LENC'}">
                                                     <c:if test="${ fjtuser.calander_code eq 'SAT-THU' or fjtuser.calander_code eq  'MON-SAT'}"> <!-- FIRST Leave encashment option blocked for staff employees  -->
                                                    <option value="${entry.key}" data-bal="${entry.value.balance}" >${entry.value.lv_desc}</option> 
                                                    </c:if>
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
                                    <div class="n_text_narrow" id="frdt_label">From Date<span>*</span></div>
                                    <input class="select_box2" readonly type="text" id="datepicker-13" name="fromdate" autocomplete="off">
                                    <input name="operationbutton" type="hidden" value="" id="calbutton" />
                                </div>
                                <div class="l_one">
                                    <div class="n_text_narrow">To Date<span>*</span></div>
                                    <input type="text" readonly class="select_box2"  id="datepicker-14" name="todate">
                                </div>
                                <div class="l_one">
                                    <div class="n_text_narrow_hd">
                                        <input type="checkbox" value="Halfday" name="ishalfday" disabled="true" id="h_chkbox" onchange="changeRadios(this);"/><label> Apply half day :</label>
                                    </div>
                                    <div style="float: right; width: 70%">
                                        <div id="halfday_opt" class="n_radiobutton_box" >  
                                            <div class="n_text_left">First Half <input id="radiohf" name="halfday" type="radio" value="first" class="radiobutton" disabled="true" onclick="setHalfDay(this);"/></div>  
                                            <div class="n_text_right">Second Half <input id="radiohs" name="halfday" type="radio" value="second" class="radiobutton" disabled="true" onclick="setHalfDay(this);"/></div>
                                        </div>  
                                    </div>
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
                                <div class="l_one">
                                    <div class="n_text_msg1" id="initbalance" style="width:96%;">
                                        Current leave balance : <c:out value="${cur_accur}"/>
                                        <input type="hidden" name="currentLeaveBalance" id="currentLeaveBalance" value="${cur_accur}" disabled class="disabled_input"/>
                                    </div>   
                                </div>
                                <div class="l_one">
                                    <div class="n_text_msg1" style="width:48%;">
                                        No. of leave days&nbsp;:<input style="width: 50px; border:none;background:white;color:black;" type="text" id="nolvdays"  name="nolvdays" disabled="true" class="disabled_input" tabindex="-1" onblur="return checkvalue();"/>
                                    </div> 
                                    
	                                 <div class="n_text_msg1" style="width:48%;">
	                                   No. of Calendar Days&nbsp;: <input style="width: 50px; border:none;background:white;color:black;"  type="text" id="totaldays" name="totaldays" disabled="true" class="disabled_input"  tabindex="-1" />
	                                 </div>   
                                </div> 
                                 <div class="l_one">
	                                 <div class="n_text_msg1" style="width:48%;">
	                                   Balance Days&nbsp;: <input style="width: 50px; border:none;background:white;color:black;"  type="text" id="balancedays" name="balancedays" disabled="true" class="disabled_input"  tabindex="-1" />
	                                 </div> 
	                                  <div class="n_text_msg1" style="width:48%;">
                                        Resume date&nbsp;:<input style="width: max-content; border:none;background:white;color:black;" type="text" readonly id="resumedate" name="resumedate" class="disabled_input" tabindex="-1"/>
                                    </div> 
                                </div>
                                <div class="l_one">
                                    <div class="n_text_msg1" style="width:96%;">
                                       <span class="text-danger" >
	                                           <c:choose>
		                                          <c:when test="${ fjtuser.calander_code eq 'SAT-THU' or fjtuser.calander_code eq  'SUN-FRI'}"> 
		                                          All leaves calculation based on <b>calendar</b> days.
		                                          </c:when>
		                                          <c:otherwise>
		                                          Annual Leave calculation based on <b>working</b> days.<br/><br/>
		                                          Other leaves calculation based on <b>calendar</b> days.
		                                          </c:otherwise></c:choose>
                                        </span>
                                    </div>
                                </div>
                                <div class="l_one">
                                    <div class="n_text_narrow">Authorized by</div>
                                    <div class="d_box">${fjtuser.approverName}</div>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div class="s_box2">
                                <input name="operationbutton" type="hidden" value="" id="calbutton" />
                                <input name="applybutton" type="button" value="Apply" class="sbt_btn" onclick='invokeApply(this);' />
                                <input name="resetbutton" type="reset" value="Cancel" class="btn_can" />
                            </div>
                        </form>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="att_searchbox">
                <h1>Leave Application Status</h1>
            </div>
            <c:choose> 
                <c:when test="${!empty leave.pendleaveapplications or !empty leave.encashmentapplications}">
                    <div class="table-responsive">  
                        <table class="table" cellpadding="1" cellspacing="1">
                            <thead>
                                <tr bgcolor="#2c2c2c" style="color:#FFFFFF;">
                                    <th class="tab_h">Leave Type</th>
                                    <th class="tab_h">From Date</th>
                                    <th class="tab_h">To Date</th>
                                    <th class="tab_h">Resume On</th>
                                    <th class="tab_h">Leave Days</th>
                                    <th class="tab_h">Total Days</th>
                                    <th class="tab_h">Reason</th>   
                                    <th class="tab_h"> </th>   
                                </tr>                
                            </thead>
                            <tbody>
                                <c:forEach items="${leave.pendleaveapplications}" var = "current">
                                    <fmt:formatDate pattern="dd-MM-yyyy" var="cfmdt" value="${current.fromdate}" />
                                    <fmt:formatDate pattern="dd-MM-yyyy" var="ctodt"  value="${current.todate}" />
                                    <fmt:formatDate pattern="dd-MM-yyyy" var="cresdt" value="${current.resumedate}"/>
                                    <tr bgcolor="#e1e1e1" style="color:#FFFFFF;"> 
                                        <td class="tab_h2">${leave.emp_leave_types[ current.leavetype ].lv_desc}</td>
                                        <td class="tab_h2"><c:out value="${cfmdt}"/></td>
                                        <td class="tab_h2"><c:out value="${ctodt}"/></td>
                                        <td class="tab_h2">${cresdt}</td>
                                        <td class="tab_h2">${current.leavedays}</td>
                                        <td class="tab_h2">${current.totaldays}</td>
                                        <td class="tab_h2">${current.reason}</td> 
                                        <td class="tab_h2">
                                            <form method="post">
                                                <input type="hidden" name="cuid" value="${fjtuser.emp_code}"/>
                                                <input type="hidden" name="applieddt" value="${current.applied_dateinMillis}"/>
                                                <input type="hidden" name="applntype" value="${current.leavetype}"/>
                                                <input type="submit" class="btn_can" name="cancelleave" value="Cancel" onclick="return confirm('This will cancel your leave application. Do you want to proceed?');"/>
                                            </form></td>
                                    </tr>
                                </c:forEach>
                                <c:forEach items="${leave.encashmentapplications}" var = "current">
                                    <fmt:formatDate pattern="dd-MM-yyyy" var="cfmdt" value="${current.effectivedate}" /> 
                                    <tr bgcolor="#e1e1e1" style="color:#FFFFFF;"> 
                                        <td class="tab_h2">Leave Encashment</td> 
                                        <td class="tab_h2"><c:out value="${cfmdt}"/></td>
                                        <td class="tab_h2">&nbsp;</td>
                                        <td class="tab_h2">&nbsp</td>
                                        <td class="tab_h2">${current.encashdays}</td>
                                        <td class="tab_h2">&nbsp;</td>
                                        <td class="tab_h2">${current.reason}</td> 
                                        <td class="tab_h2">
                                            <form method="post">
                                                <input type="hidden" name="cuid" value="${fjtuser.emp_code}"/>
                                                <input type="hidden" name="applieddt" value="${current.applied_dateinMillis}"/>
                                                <input type="hidden" name="applntype" value="encash"/>
                                                <input type="submit" class="btn_can" name="cancelleave" value="Cancel" onclick="return confirm('This will cancel your leave encashment application. Do you want to proceed?');"/>
                                            </form></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>    
                    <div class="rest_box">
                        <div class="l_one">
                            <div class="n_text_msg">
                                No pending leave applications.
                            </div>
                        </div>
                    </div>

                </c:otherwise>
            </c:choose>   
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