<%-- 
    Document   : businesstripleaveappln.jsp 
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
     	<jsp:setProperty name="leave" property="emp_code" value="${param.traveler_emp_code}"/>
    	<jsp:useBean id="leave" class="beans.Leave" scope="session"/>
    	<c:set var="pendsize" value="${leave.allPendingLeaveApplications}"/>
    	<c:set var="encashsize" value="${leave.allPendingEncashmentApplications}"/>
        <c:set var="pendsize" value="${leave.allApprovedLeaveApplications}"/>
       
	    <jsp:useBean id="businessleave" class="beans.BusinessTripLVApplication" scope="request"/>
        <jsp:useBean id="hday" class="beans.Holiday" scope="session"/>
        <jsp:setProperty name="hday" property="compCode" value="${param.t_comp_code}"/>
        <jsp:useBean id="cmp_param" class="beans.CompParam" scope="session"/>
        <jsp:setProperty name="businessleave" property="cur_procm_startdt" value="${cmp_param.currentProcMonthStartDate}"/>
        <jsp:setProperty name="businessleave" property="emp_code" value="${param.traveler_emp_code}"/>
        <jsp:setProperty name="businessleave" property="comp_code" value="${param.t_comp_code}"/>
        <c:set var="hdaysize" value="${hday.allHolidaysofCurYear}"/>  
        <%-- <c:set var="pendsize" value="${businessleave.pendbusinesstripleaveapplications}"/>--%>
       <c:set var="pendsize" value="${businessleave.allPendingLeaveApplications}"/> 
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
                var country = document.getElementById("country").value;
                var projectDetails = document.getElementById("projectDetails").value;
                var purpose = document.getElementById("purpose").value; 
               /*  var travelerUid = document.getElementById("travelerUid").value;
                var traveluName = document.getElementById("traveluName").value;
                var traveluDesignation = document.getElementById("traveluDesignation").value;
                var traveluDivision = document.getElementById("traveluDivision").value;
                var dateofReq = document.getElementById("dateofReq").value;  
                var fromAirport = document.getElementById("fromAirport").value;
                var pfromTime = document.getElementById("pfromTime").value;
                var retrunAirport = document.getElementById("retrunAirport").value;
                var preturnTime = document.getElementById("preturnTime").value;               			
                var estimatedTravelBudget = document.getElementById("estimatedTravelBudget").value; */
                var yesorno = document.getElementsByName("hotelBookReq");                
                if(yesorno!=null && yesorno[0].checked){                   	
                	 var checkin = document.getElementById("datepicker-15").value;
                	 var checkout = document.getElementById("datepicker-16").value;
                	 if (checkin.trim().length == 0  || checkout.trim().length == 0 ) {
	                	alert("Please fill the Check-In/Check-Out Detils");
	                    return false;
                	 }
                }
                
                if (fromdt == null || todt == null || country == null || projectDetails == null || purpose == null) {
                    alert("Please fill the details properly");
                    return false;
                } else if (fromdt.trim().length == 0 || todt.trim().length == 0 || country.trim().length == 0 || projectDetails.trim().length == 0 || purpose.trim().length == 0) {
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
            	document.getElementById("dateofReq").value = today;
            	document.getElementById("dateofReq").disabled=true;
            	
            	 var companyCode="${fjtuser.emp_com_code}";
                 var calCode="${fjtuser.calander_code}";
                
                 if(calCode == 'SAT-THU' || calCode ==  'SUN-FRI'){hr22LvPolicy = false;}
                // console.log(companyCode+" "+calCode+" "+hr22LvPolicy);
             });
             var lvDfltYear='<%=year%>';
                var Applnlst = [];
                var appln, stdt, parts1, parts2, todt;
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
                	 $("#datepicker-13").datepicker({minDate:0, maxDate: '+1Y', dateFormat: 'dd/mm/yy',  beforeShowDay: DisableCustomDaysForLeaveStart,firstDay: 0, onSelect: function (dateText, inst) {
                     $("#datepicker-14").datepicker("option", "minDate", $("#datepicker-13").datepicker("getDate"));
                     $("#datepicker-14").datepicker('enable');
                     $("#datepicker-14").datepicker('setDate', null);                         
                     }});
                    
                $("#datepicker-14").datepicker({minDate: new Date(<%=year%>, <%=month%>, -1, <%=day%>), maxDate: '+1Y', dateFormat: 'dd/mm/yy', beforeShowDay: DisableCustomDaysForLeaveStart, firstDay: 0, disabled: true, onSelect: CalculateLeaveDetails});
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
                   console.log("d2.getDate() + 1 " + (d2.getDate() + 1));
                    var nextDayDate = $('#datepicker-14').datepicker('getDate');
                    nextDayDate.setDate(d2.getDate() + 1);
                   // console.log("nextDay " + nextDayDate);
                    var diff = 0;
                    if (!d1) {
                        alert("Please enter a leave start date!");                       
                        return;
                    }
                    var i = 0;
                    while (i < Applnlst.length) {
                       // if ((d1 <= Applnlst[i].startdate || d2 <= Applnlst[i].startdate) && (d1 <= Applnlst[i].enddate) || d2 <= Applnlst[i].enddate) {
                    	   if ((d1 <= Applnlst[i].startdate && d2 >= Applnlst[i].enddate) || (d1 >= Applnlst[i].startdate && d1 <= Applnlst[i].enddate) || (d2 >= Applnlst[i].startdate && d2 <= Applnlst[i].enddate)) {
                            alert("Cannot Apply. There is already an applied leave in the range.");
                            $("#datepicker-14").datepicker('setDate', null);
                            $("#datepicker-13").datepicker('setDate', null);
                          //  manageFormElements(1);
                            return;
                        }
                        ++i;
                    }                
                }
                function DisableCustomDaysForLeaveStart(date) {
                    // var day = date.getDay();
                    var i = 0;
                    while (i < Applnlst.length) {
                        if (date >= Applnlst[i].startdate && date <= Applnlst[i].enddate) {
                            return [false, "", "Leave/Business trip"];
                        }

                        ++i;
                    }                    
                    //disable public holidays
                  var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
                    if ($.inArray(string, hdaylist) == -1)
                        return [true];
                    else
                        return [false, "", "Holiday"]
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
                       		Business Trip Application
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
                            <jsp:setProperty name="businessleave" property="fromdateStr" param="fromdate"/>
                            <jsp:setProperty name="businessleave" property="todateStr" param="todate"/> 
                            <jsp:setProperty name="businessleave" property="purpose" param="purpose"/>
                            <jsp:setProperty name="businessleave" property="country" param="country"/>
                            <jsp:setProperty name="businessleave" property="projectDetails" param="projectDetails"/>
                            <jsp:setProperty name="businessleave" property="otherDetails" param="otherDetails"/>
                            <jsp:setProperty name="businessleave" property="travelerUid" param="traveler_emp_code"/>
                            <jsp:setProperty name="businessleave" property="travelUName" param="travelUName"/> 
                            <jsp:setProperty name="businessleave" property="travelUDivision" param="travelUDivision"/>
                            <jsp:setProperty name="businessleave" property="travelUDesignation" param="travelUDesignation"/>
                            <jsp:setProperty name="businessleave" property="fromAirport" param="fromAirport"/>
                            <jsp:setProperty name="businessleave" property="pfromTime" param="pfromTime"/>
                            <jsp:setProperty name="businessleave" property="retrunAirport" param="retrunAirport"/>
                            <jsp:setProperty name="businessleave" property="preturnTime" param="preturnTime"/> 
                            <jsp:setProperty name="businessleave" property="luggageAllwReq" param="luggageAllwReq"/>
                            <jsp:setProperty name="businessleave" property="handBagReq" param="handBagReq"/>
                            <jsp:setProperty name="businessleave" property="hotelBookReq" param="hotelBookReq"/>
                            <jsp:setProperty name="businessleave" property="strcheckInDate" param="checkInDate"/>
                            <jsp:setProperty name="businessleave" property="strcheckOutDate" param="checkOutDate"/>
                          <!--   <jsp:setProperty name="businessleave" property="reqdateStr" param = "dateofReq" /> -->
                            <jsp:setProperty name="businessleave" property="traveleIns" param="traveleIns"/>
                            <jsp:setProperty name="businessleave" property="traveleReqSelfClient" param="traveleReqSelfClient"/> 
                            <jsp:setProperty name="businessleave" property="estimatedTravelBudget" param="estimatedTravelBudget"/>
                            <jsp:setProperty name="businessleave" property="paymentCharges" param="paymentCharges"/>
                            <jsp:setProperty name="businessleave" property="t_approver_eid" param="t_approver_eid"/>
                            <jsp:setProperty name="businessleave" property="t_comp_code" param="t_comp_code"/>
                            <jsp:setProperty name="businessleave" property="emp_name" value="${fjtuser.uname}"/>
                            <jsp:setProperty name="businessleave" property="emp_code" value="${fjtuser.emp_code}"/>
                            <jsp:setProperty name="businessleave" property="authorised_by" value="${fjtuser.approver}"/>
                            <jsp:setProperty name="businessleave" property="comp_code" value="${fjtuser.emp_com_code}"/> 
                            <jsp:setProperty name="businessleave" property="approver_eid" value="${fjtuser.approverId}"/>                                   
                            <c:set var="appstatus" value="${businessleave.sendBusinessTripApplicationForApproval}"/>
                            <c:set var="refresh" value="${businessleave.pendbusinesstripleaveapplications}"/> 
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
                        <c:if test="${!empty param.cancelleave and param.cancelleave eq 'Cancel'}">                           
                              <jsp:useBean id="cancelapp" class="beans.BusinessTripLVApplication" scope="request"/>
                              <jsp:setProperty name="cancelapp" property="emp_name" value="${fjtuser.uname}"/>
                              <jsp:setProperty name="cancelapp" property="emp_code" value="${fjtuser.emp_code}"/>
                              <jsp:setProperty name="cancelapp" property="approver_eid" value="${fjtuser.approverId}"/>
                              <jsp:setProperty name="cancelapp" property="comp_code" value="${fjtuser.emp_com_code}"/> 
                              <jsp:setProperty name="cancelapp" property="applied_dateFromStr" param="applied_date"/>                                                        
                              <c:set var="appstatus" value="${cancelapp.cancelBusinessLeaveApplication}"/>
                              <c:set var="refresh" value="${cancelapp.pendbusinesstripleaveapplications}"/>                                             
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
                        <c:if test="${param.subtype eq 'uidchk'}">                                                				
	                          <jsp:setProperty name="businessleave" property="traveler_emp_code" param="traveler_emp_code"/> 
	                          <c:set var="loginstatus" value="${businessleave.checkUid}"/> 	                         
	                         <form method="POST" action="businesstripleaveappln.jsp">
	                           <div class="panel-heading" id="fj-page-head">                        
			                        <h4 class="text-left">
			                       		Employee Details:            
			                       </h4>                      
		                       </div>	
	                         <%--  <div class="l_one"> --%> 
	                         <div class="l_left">
	                            <div class="l_one">	                               
                               	  <div class="n_text_narrow" id="frdt_label">Emp Code<span>*</span></div>
                               	  <input type="hidden" name="subtype" value="" id="subtype" /> 
                                  <input type="text" class="leave_text" id="travelerUid" name="traveler_emp_code" tabindex="1" onblur="return checkUid(this);" onkeypress="verifyEnter(event);" value="${param.traveler_emp_code}" required="required">
                                   <c:if test="${loginstatus eq -1}"><div class="l_right" style="text-decoration:none; color: red">Invalid User</div>
                                   </c:if>	
                                 </div>
                                 <div class="l_one">
                                	  <div class="n_text_narrow" id="frdt_label">Name of Passenger</div>
                                       <input type="text" class="text_area"  id="traveluName" name="travelUName"  tabindex="2" value="${businessleave.travelUName}" required="required">
                                 </div> 
                                  <div class="l_one">
	                                	  <div class="n_text_narrow" id="frdt_label">Designation</div>
	                                       <input type="text" class="text_area" id="traveluDesignation" name="travelUDesignation" tabindex="3" value="${businessleave.travelUDesignation}" required="required">
	                               </div>
                                  <div class="l_one">
                                	  <div class="n_text_narrow" id="frdt_label">Division</div>
                                      <input type="text" class="leave_text" id="traveluDivision" name="travelUDivision" tabindex="4" value="${businessleave.travelUDivision}" required="required">
                                 </div>    
                                  <div class="l_one">
                                	  <div class="n_text_narrow" id="frdt_label">Date of Request<span>*</span></div>
                                      <input type="text" class="select_box" style="width:45%" id="dateofReq" name="dateofReq"  autocomplete="off" value="${param.dateofReq}" required="required">	                                      
		                          </div> 
		                          <div class="l_one">
                                	  <div class="n_text_narrow" id="frdt_label">Date of Travel<span>*</span></div>
                                      <input type="text" id="datepicker-13" style="width:95%" class="select_box" name="fromdate" autocomplete="off" value="${param.fromdate}"  required="required">
	                              </div>                             
	                             <div class="l_one">
                                      <div class="n_text_narrow">Date of Return<span>*</span></div>
                                      <input type="text" class="select_box"  style="width:47%" id="datepicker-14" name="todate" autocomplete="off" value="${param.todate}" required="required"/>
                                  </div>
                                  <div class="l_one">
								    <div class="n_text_narrow">Country<span>*</span></div>
								    <textarea name="country" style="width:95%" maxlength="50"  class="mybox" id="country" required="required">${param.country}</textarea>
				                      <%--  <select name="country" class="select_box" id="country" autocomplete="off">
				                            <c:forEach var="country" items="${countrieslist}">
				                            	 <option value="${country.key}">${country.value}</option>
				                            </c:forEach>                         
				                        </select> --%>
                                   </div>
                                   <div class="l_one">
                                    <div class="n_text_narrow">Project Detail <span>*</span></div>
                                    <textarea name="projectDetails" style="width:95%" maxlength="100"  class="mybox" id="projectDetails" required="required">${param.projectDetails}</textarea>
                                </div>
                                 <div class="l_one">
                                    <div class="n_text_narrow">Purpose <span>*</span></div>
                                    <textarea name="purpose" style="width:95%" maxlength="200" cols="10" rows="2" class="mybox" id="purpose" required="required">${param.purpose}</textarea>
                                </div>
                                 <div class="l_one">
                                    <div class="n_text_narrow">Other Remarks </div>
                                    <textarea name="otherDetails" style="width:95%" maxlength="200" cols="10" rows="2" class="mybox" id="otherDetails">${param.otherDetails}</textarea>
                                </div>
                               </div> 
                               <div class="l_right">	  	
	                             <div class="panel-heading" id="fj-page-head">                        
			                        <h4 class="text-left">
			                       		Travel Details:            
			                       </h4>                      
			                     </div> 
                                   <div class="l_one">
                                      <div class="n_text_narrow">Traveling from Airport<span>*</span></div>
                                      <input type="text" class="select_box"  style="width:95%" id="fromAirport" name="fromAirport" autocomplete="off" value="${param.fromAirport}" required="required"/>
                                  </div> 
                                   <div class="l_one">
                                      <div class="n_text_narrow">Preferable Time<span>*</span></div>
                                      <input type="text" class="select_box" style="width:95%" id="pfromTime" name="pfromTime" autocomplete="off" value="${param.pfromTime}" required="required"/>
                                  </div>  
                                   <div class="l_one">
                                      <div class="n_text_narrow">Return from Airport<span>*</span></div>
                                      <input type="text" class="select_box"  style="width:95%" id="retrunAirport" name="retrunAirport" autocomplete="off" value="${param.retrunAirport}" required="required"/>
                                  </div> 
                                   <div class="l_one">
                                      <div class="n_text_narrow">Preferable Time<span>*</span></div>
                                      <input type="text" class="select_box"  style="width:95%" id="preturnTime" name="preturnTime" autocomplete="off" value="${param.preturnTime}" required="required"/>
                                  </div> 
                                    <div class="l_leftcustome">
                                       <div class="n_text_narrow">Luggage Allowance Required <span>*</span></div>                                     
                                   </div>  
                                    <div class="l_leftcustome">
									    <label class="radio-inline">
									      <input type="radio" id="luggageallyes" name="luggageAllwReq" value="Yes">Yes
									    </label>
									    <label class="radio-inline">
									      <input type="radio" id="luggageallno" name="luggageAllwReq" checked value="No">No
									    </label>									   
                                   </div> 
                                   <div class="l_leftcustome">
                                       <div class="n_text_narrow">Only Hand Bag <span>*</span></div>                                      
                                   </div> 
                                   <div class="l_leftcustome">
                                      <label class="radio-inline">
                                      	<input type="radio" id="handbagyes" name="handBagReq" value="Yes">Yes
									  </label>	
									  <label class="radio-inline">
									  	<input type="radio" id="handbagno" name="handBagReq" checked value="No">No								  
									  </label>
                                   </div>                                    
                                   <div class="l_leftcustome">
                                       <div class="n_text_narrow">Hotel Booking required<span>*</span></div>                                      
                                   </div> 
                                   <div class="l_leftcustome">
                                      <label class="radio-inline">
                                      	<input type="radio" id="hotelbookyes" name="hotelBookReq" value="Yes" onclick="displaychekinoutdiv(this);">Yes
									  </label>
									  <label class="radio-inline">
									  	<input type="radio" id="hotelbookno" name="hotelBookReq" checked value="No" onclick="displaychekinoutdiv(this);">No							  
									  </label>
                                   </div>  
                                   <!--  <div id="chkinoutdiv" style="width:50%" class="l_leftcustome" style="display: none;"> -->
                                       <div class="l_leftcustome" id="chkindiv" style="display: none;">
	                                       <div class="n_text_narrow">Check-In Date<span>*</span></div>
	                                       <input type="text" class="select_box"  id="datepicker-15" name="checkInDate" value="${param.checkInDate}"/>
                                       </div>   
                                       <div class="l_leftcustome" id="chkoutdiv" style="display: none;">                                                                   
	                                       <div class="n_text_narrow">Check-Out Date<span>*</span></div>
	                                       <input type="text" class="select_box"  id="datepicker-16" name="checkOutDate" value="${param.checkOutDate}"/>
                                        </div>
                                  <!--   </div>-->                                   
                                   <div class="l_leftcustome">
                                       <div class="n_text_narrow">Travel Insurance Required <span>*</span></div>                                       
                                   </div>  
                                    <div class="l_leftcustome">
                                      <label class="radio-inline">
                                      	<input type="radio" id="traveleinsyes" name="traveleIns" value="Yes">Yes
									  </label>
									  <label class="radio-inline">
									 	 <input type="radio" id="traveleinsno" name="traveleIns" checked value="No">No								  
									  </label>									  
                                   </div> 
                                   <div class="l_leftcustome">
                                       <div class="n_text_narrow">Travel Request <span>*</span></div>                                       
                                   </div>   
                                   <div class="l_leftcustome">
                                      <label class="radio-inline">
                                      	<input type="radio" id="travelereqself" name="traveleReqSelfClient" checked value="Self">Self
									  </label>
									  <label class="radio-inline">	
									  	<input type="radio" id="travelereqclient" name="traveleReqSelfClient"  value="Client">Client							  
									  </label>
                                   </div>
                                   <div class="l_leftcustome">
                                       <div class="n_text_narrow">Payment Charges  <span>*</span></div>                                      
                                   </div> 
                                   <div class="l_leftcustome">
                                      <label class="radio-inline">
                                      	<input type="radio" id="paymentChargesDivison" name="paymentCharges" checked value="Division Account">Division Account
									  </label>
									  <label class="radio-inline">	
									  	<input type="radio" id="paymentChargesClient" name="paymentCharges"  value="Client Account">Client Account						  
									  </label>
                                   </div>                                       
                                    <div class="l_leftcustome">
                                       <div class="n_text_narrow">Estimated Travel Budget <span>*</span></div>
                                       <input type="text" class="select_box" style="width:60%" id="estimatedTravelBudget" name="estimatedTravelBudget" value="${param.estimatedTravelBudget}" required="required"/>
                                   </div>
                              </div>      
                                
                          <%--  </div>      --%>                       
                            <div class="clear"></div>
	                            <div class="s_box2">
	                                 <input type="hidden" name="projectDetails" class="sbt_btn" value="" id="projectDetails"/>
	                        	     <input type="hidden" name="purpose" class="sbt_btn" value="" id="purpose"/>
	                        	     <input type="hidden" name="otherDetails" class="sbt_btn" value="" id="otherDetails"/>
	                        	     <input type="hidden" name="t_approver_eid" class="sbt_btn" value="${businessleave.t_approver_eid}" id="t_approver_eid"/>
	                        	     <input type="hidden" name="t_comp_code" class="sbt_btn" value="${businessleave.t_comp_code}" id="t_comp_code"/>
	                                <input name="applybutton" type="submit" value="Apply" class="sbt_btn" onclick="return verifyFormdata(this);"/>
	                                <input name="resetbutton" type="reset" value="Cancel" class="btn_can" />
	                            </div>
	                        </form> 
                    </c:if>  
                    </c:when>	
                   
                    <c:otherwise>
                        <form method="POST" action="businesstripleaveappln.jsp"> 
		                     		                
                           <div class="l_left">
                            <div class="panel-heading" id="fj-page-head">                        
		                        <h4 class="text-left" style="width:50%;align:right">
		                       		Employee Details:            
		                       </h4>                      
		                     </div>
                                <div class="l_one">
                                	  <div class="n_text_narrow" id="frdt_label">Emp Code<span>*</span></div>
                                	  <input type="hidden" name="subtype" value="" id="subtype" /> 
                                      <input type="text" class="leave_text" id="travelerUid" name="traveler_emp_code" tabindex="1" value="${param.traveler_emp_code}" onblur="return checkUid(this);" onkeypress="verifyEnter(event);"  autocomplete="off" required="required">
                                </div>  
                                <div class="l_one">
                                	   <div class="n_text_narrow" id="frdt_label">Name of Passenger</div>
                                       <input type="text" class="text_area" id="traveluName" name="traveluName"  required="required">
                                 </div>  
                                 <div class="l_one">
                                	  <div class="n_text_narrow" id="frdt_label">Designation</div>
                                       <input type="text" class="text_area" id="traveluDesignation" name="traveluDesignation" tabindex="1" required="required">
                                 </div> 
                                 <div class="l_one">
                                	  <div class="n_text_narrow" id="frdt_label">Division</div>
                                       <input type="text" class="leave_text"  id="traveluDivision" name="traveluDivision" tabindex="1" value="${param.traveluDivision}" required="required">
                                </div> 
                                 <div class="l_one">
                                	  <div class="n_text_narrow" id="frdt_label">Date of Request<span>*</span></div>
                                      <input type="text" class="select_box" id="dateofReq" name="dateofReq" autocomplete="on" required="required">	                                      
                               </div>                  
                               <div class="l_one">
                               	  <div class="n_text_narrow" id="frdt_label">Date of Travel<span>*</span></div>
                                  <input type="text" id="datepicker-13" class="select_box" name="fromdate" value="${param.fromdate}" autocomplete="off" required="required">
                               </div>
                               	<div class="l_one">
                                    <div class="n_text_narrow">Date of Return<span>*</span></div>
                                    <input type="text" readonly class="select_box" id="datepicker-14" name="todate" value="${param.todate}"/>
                                 </div>  
                                 <div class="l_one">
								    <div class="n_text_narrow">Country<span>*</span></div>
								    <textarea name="country" style="width:95%" maxlength="50"  class="mybox" id="country">${param.country}</textarea>
				                      <%--  <select name="country" class="select_box" id="country" autocomplete="off">
				                            <c:forEach var="country" items="${countrieslist}">
				                            	 <option value="${country.key}">${country.value}</option>
				                            </c:forEach>                         
				                        </select> --%>
                                  </div> 
                                <div class="l_one">
                                    <div class="n_text_narrow">Project Detail <span>*</span></div>
                                    <textarea name="projectDetails"  maxlength="100"  class="mybox" id="projectDetails">${param.projectDetails}</textarea>
                                </div>
                                 <div class="l_one">
                                    <div class="n_text_narrow">Purpose <span>*</span></div>
                                    <textarea name="purpose" maxlength="200" cols="10" rows="2" class="mybox" id="purpose">${param.purpose}</textarea>
                                </div>
                                 <div class="l_one">
                                    <div class="n_text_narrow">Other Remarks </div>
                                    <textarea name="otherDetails" maxlength="200" cols="10" rows="2" class="mybox" id="otherDetails">${param.otherDetails}</textarea>
                                </div>
                            </div>                           
                            <div class="l_right">	
                             <div class="panel-heading" id="fj-page-head">                        
		                        <h4 class="text-right" style="width:50%;align:left">
		                       		Travel Details:            
		                       </h4>                      
		                     </div>	  
                                  <div class="l_one">
	                                   <div class="n_text_narrow">Traveling from Airport<span>*</span></div>
	                                   <input type="text" class="select_box" id="fromAirport" name="fromAirport" value="${param.fromAirport}"/>
	                               </div> 
                                   <div class="l_one">
                                      <div class="n_text_narrow">Preferable Time<span>*</span></div>
                                      <input type="text" class="select_box" id="pfromTime" name="pfromTime" value="${param.pfromTime}"/>
                                  </div> 
                                 <div class="l_one">
                                      <div class="n_text_narrow">Return from Airport<span>*</span></div>
                                      <input type="text" class="select_box" id="retrunAirport" name="retrunAirport" value="${param.retrunAirport}"/>
                                    </div>
                                     <div class="l_one">
                                      <div class="n_text_narrow">Preferable Time<span>*</span></div>
                                      <input type="text" class="select_box" id="preturnTime" name="preturnTime" value="${param.preturnTime}"/>
                                  </div> 
                                  <div class="l_leftcustome">
                                       <div class="n_text_narrow">Luggage Allowance Required <span>*</span></div>                                     
                                   </div>  
                                    <div class="l_leftcustome">
                                        <label class="radio-inline">
                                        	<input type="radio" id="luggageallyes" name="luggageAllwReq" value="Yes">Yes
									    </label>
										<label class="radio-inline">	
											<input type="radio" id="luggageallno" name="luggageAllwReq" checked value="No">No								  
									    </label>
                                   </div>
                                      <div class="l_leftcustome">
	                                       <div class="n_text_narrow">Hotel Booking required<span>*</span></div>                                      
	                                   </div> 
	                                   <div class="l_leftcustome">
	                                      <label class="radio-inline">
	                                      	<input type="radio" id="hotelbookyes" name="hotelBookReq" value="Yes" onclick="displaychekinoutdiv(this);">Yes
										  </label>
										  <label class="radio-inline">
										  	<input type="radio" id="hotelbookno" name="hotelBookReq" checked value="No" onclick="displaychekinoutdiv(this);">No								  
										  </label>
	                                </div> 
	                                  <div class="l_leftcustome" id="chkindiv" style="display: none;">
	                                       <div class="n_text_narrow">Check-In Date<span>*</span></div>
	                                       <input type="text" readonly class="select_box"  id="datepicker-15" name="checkInDate" value="${param.checkInDate}"/>
	                                    </div>   
	                                    <div class="l_leftcustome" id="chkoutdiv" style="display: none;">                                                                   
	                                     <div class="n_text_narrow">Check-Out Date<span>*</span></div>
	                                     <input type="text" readonly class="select_box"  id="datepicker-16" name="checkOutDate" value="${param.checkOutDate}"/>
	                                  </div>
	                               <div class="l_leftcustome">
	                                       <div class="n_text_narrow">Travel Insurance Required <span>*</span></div>                                       
	                                   </div>  
	                                    <div class="l_leftcustome">
	                                      <label class="radio-inline">
	                                      	<input type="radio" id="traveleinsyes" name="traveleIns" value="Yes">Yes
										  </label>
										  <label class="radio-inline">	
										  	<input type="radio" id="traveleinsno" name="traveleIns" checked value="No">No							  
										  </label>
	                                 </div> 
	                                  <div class="l_leftcustome">
	                                       <div class="n_text_narrow">Only Hand Bag <span>*</span></div>                                      
	                                   </div> 
	                                   <div class="l_leftcustome">
	                                   	  <label class="radio-inline">
	                                      	<input type="radio" id="handbagyes" name="handBagReq" value="Yes">Yes
	                                      </label>
										  <label class="radio-inline">	
										  	<input type="radio" id="handbagno" name="handBagReq" checked value="No">No								  
										  </label>
	                                  </div>
	                                  <div class="l_leftcustome">
	                                       <div class="n_text_narrow">Travel Request <span>*</span></div>                                       
	                                   </div>   
	                                   <div class="l_leftcustome">
	                                      <label class="radio-inline">
	                                      	<input type="radio" id="travelereqself" name="traveleReqSelfClient" checked value="Self">Self
										  </label>
										  <label class="radio-inline">	
											  	<input type="radio" id="travelereqclient" name="traveleReqSelfClient"  value="Client">Client								  
										 </label>
	                                 </div> 
	                                 <div class="l_leftcustome">
	                                       <div class="n_text_narrow">Payment Charges  <span>*</span></div>                                       
	                                   </div>  
	                                   <div class="l_leftcustome">
	                                      <label class="radio-inline">
	                                      	<input type="radio" id="paymentChargesDivison" name="paymentCharges" checked value="Division Account">Division Account
										  </label>
										  <label class="radio-inline">	
										  	<input type="radio" id="paymentChargesClient" name="paymentCharges"  value="Client Account">Client Account						  
										  </label>
	                                   </div>	
	                                 <div class="l_leftcustome">
	                                       <div class="n_text_narrow">Estimated Travel Budget <span>*</span></div>
	                                       <input type="text" class="select_box" style="width:60%" id="estimatedTravelBudget" name="estimatedTravelBudget" value="${param.estimatedTravelBudget}"/>
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
                <h1>Business Trip Application Status</h1>
            </div>
            <c:choose> 
                <c:when test="${!empty businessleave.pendbusinesstripleaveapplications}">
                 <jsp:setProperty name="businessleave" property="emp_code" value="${fjtuser.emp_code}"/>
                    <div class="table-responsive">  
                        <table class="table" cellpadding="1" cellspacing="1">
                            <thead>
                                <tr bgcolor="#2c2c2c" style="color:#FFFFFF;">                                    
                                    <th class="tab_h">From Date</th>
                                    <th class="tab_h">To Date</th>
                                    <th class="tab_h">Country</th>
                                    <th class="tab_h">Customer/Project Details</th>
                                    <th class="tab_h">Purpose</th>
                                    <th class="tab_h">Other Remarks</th>   
                                    <th class="tab_h"> </th>   
                                </tr>                
                            </thead>
                            <tbody>
                                <c:forEach items="${businessleave.pendleaveapplications}" var = "current">
                                    <fmt:formatDate pattern="dd-MM-yyyy" var="cfmdt" value="${current.fromdate}" />
                                    <fmt:formatDate pattern="dd-MM-yyyy" var="ctodt"  value="${current.todate}" />                                   
                                    <tr bgcolor="#e1e1e1" style="color:#FFFFFF;">                                        
                                        <td class="tab_h2"><c:out value="${cfmdt}"/></td>
                                        <td class="tab_h2"><c:out value="${ctodt}"/></td>
                                        <td class="tab_h2">${current.country}</td>
                                        <td class="tab_h2">${current.purpose}</td> 
                                        <td class="tab_h2">${current.projectDetails}</td>
                                         <td class="tab_h2">${current.otherDetails}</td>
                                        
                                        <td class="tab_h2">
                                            <form method="post">
                                                <input type="hidden" name="emp_code" value="${fjtuser.emp_code}"/>
                                                <input type="hidden" name="applied_date" value="${current.applied_dateinMillis}"/>                                                
                                                <input type="submit" class="btn_can" name="cancelleave" value="Cancel" onclick="return confirm('This will cancel your Business trip application. Do you want to proceed?');"/>
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