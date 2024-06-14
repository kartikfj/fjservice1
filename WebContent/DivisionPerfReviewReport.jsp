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
  
.l_left1{width:25%; float:left;padding-right:1%;} 
.l_left2{width:26%; float:left;padding-right:1%;} 
.l_right1{width:25%; float:right;padding-right:1%;}
.l_leftcustome{width:25%; height:20px;float:left; padding-right:1%;}
.l_rightcustome{width:25%; float:right;}
.l_leftbig{width:55%; float:left;padding-right:1%;}    
.l_leftsmall{width:20%; float:left;padding-right:1%;}    
    .container {
        width: 100%;
        max-width: 1070px; /* Adjust max-width as needed */
        margin: 0 auto;
        overflow-y: auto; /* Add scrollbar if content overflows vertically */      
         padding: 20px; 
 		overflow-x: auto;
        border: 1px solid #ccc;
        box-sizing: border-box;
    }

    @media screen and (max-width: 600px) {
        .container {
            padding: 10px; /* Adjust padding for smaller screens */
        }
    }
       #categoryContentTbl .open>.dropdown-menu {display: block; max-height: 314px !important;overflow-y: scroll;}
       
       
/* from head.jsp */  
.navbar-brand>img {  height: 101%;  width: auto;  margin-left: 5px;   margin-right: 6px;}.navbar {border-radius: 0px; }
.navbar ul li{font-style: normal;font-variant-ligatures: normal;font-variant-caps: normal;   font-variant-numeric: normal;   font-variant-east-asian: normal; font-stretch: normal;   line-height: normal;   font-size: 14px;     font-weight: 700;}
.navbar-default .navbar-nav>li>a:hover, .navbar-default .navbar-nav>.open>li>a, .navbar-default .navbar-nav>.open>li>a:focus, .navbar-default .navbar-nav>.open>li>a:hover{background:#fff;color:#008ac1;} 
.tpm{margin-top: 10px;} .table-bordered>thead>tr>th, .table-bordered>tbody>tr>th, .table-bordered>tfoot>tr>th, .table-bordered>thead>tr>td, .table-bordered>tbody>tr>td, .table-bordered>tfoot>tr>td {border: 1px solid #607D8B !important;}
th { background: #3f51b314;}.box-title{letter-spacing: 0.09em; text-transform: uppercase;}.box-header{    border-bottom: 1px solid #9E9E9E;}.modal-header{ background: #335769; letter-spacing: 0.2em;  color: white; }
.modal-content {   -webkit-border-top-right-radius: 20px !important;  -moz-border-top-right-radius: 20px !important; border-top-right-radius: 20px !important;   -webkit-border-top-left-radius: 20px !important;  -moz-border-top-left-radius: 20px !important;    border-top-left-radius: 20px !important; }
.close {  color: #fff;     opacity: 1;} .loader {position: fixed; z-index: 999; height: 2em;width: 2em;overflow: show; margin: auto; top: 0;left: 0;bottom: 0; right: 0;}
.loader:before { content: '';display: block;position: fixed;top: 0; left: 0;width: 100%; height: 100%; background-color: rgba(0,0,0,0.3);} 
#err-msg{color:red;} .filetrs{width:110px;display:inline !important;margin-bottom:5px !important;}.navbar-nav>.notifications-menu>.dropdown-menu>li.header{background-color: #065685 !important;} 
@media only screen and (max-width: 640px) { } 
.hr-eval-timeline .catSummarys {border-top: 3px solid #795548;}.hr-eval-timeline .catSummarys .evl-cat-list {display: block;  position: relative;  text-align: center;  padding-top: 70px;  margin-right: 0;}
.hr-eval-timeline .catSummarys .evl-cat-list:before {content: ""; position: absolute;   height: 36px;  border-right: 2px dashed #795548c4;   top: 0;}
.hr-eval-timeline .catSummarys .evl-cat-list .evl-count-btn { position: absolute;  top: 38px;  left: 0;  right: 0;   width: max-content;  margin: 0 auto;  border-radius: 4px;  padding: 2px 8px;  color: #ffffff;}
@media (min-width: 1140px) {
.hr-eval-timeline .catSummarys .evl-cat-list {  display: inline-block;  width: 14%;  padding-top: 25px; }.hr-eval-timeline .catSummarys .evl-cat-list .evl-count-btn {top: -20px;}
}
.bg-evl-completed { background-color: #009688 !important;  border-color: #009688 !important;}.bg-evl-notCompleted {   /*background-color: red !important;*/} 
.eval-category-title{font-weight: 700;  font-family: monospace;   letter-spacing: 0.001em;  text-transform: uppercase;  background: #222d32; /*#607d8b;*/  padding: 5px 0px;  border-radius: 3px;  font-size: 85%; color:#fff !important;}
.category-summary { margin-top: 10px;}.contentColumn{width:20%;}.typingColumn{width:40%;}.viewColumn{width:20%;}.typingBox{width:100%;}.srlColumn, .actionColumn{width:10px;}.final-instruction{font-weight: bold;padding-right:20px;font-family: monospace;  font-size: 1.3em;}
#user-profile-box{    padding: 0px 0px !important;  letter-spacing: 0.01em;} #user-profile-box h5{ font-family: monospace !important;}.user-title{color: #9c27b0 !important; font-family: monospace;  font-weight: 700;}
#notification-btn-box{margin-top: -35px !important; width:max-content !important;} 
#notification { visibility: hidden;max-width: 50px;   height: 50px;  /*margin-left: -125px;*/margin: auto;  background-color: #fff;   color: #000;    text-align: center;  border-radius: 2px;  position: fixed;  z-index: 1;   left: 0;right:0;   bottom: 70%;  font-size: 17px;  white-space: nowrap;  border: 1px solid #065685;  box-shadow: 0 2px 26px #06568552;  font-family:'monospace';}
#notification #notification_icon{width: 49px; height: 49px;  float: left; padding-top: 12px; padding-bottom: 12px; box-sizing: border-box; background-color: #fff;  border: 1px solid #065685;  color: #065685 !important;}
#notification #notification_desc{color: #000;   padding: 12px;   overflow: hidden;white-space: nowrap;}
#notification.show { visibility: visible;  -webkit-animation: fadein 0.5s, expand 0.5s 0.5s,stay 3s 1s, shrink 0.5s 2s, fadeout 0.5s 2.5s;  animation: fadein 0.5s, expand 0.5s 0.5s,stay 3s 1s, shrink 0.5s 4s, fadeout 0.5s 4.5s;}
@-webkit-keyframes fadein {  from {bottom: 0; opacity: 0;}   to {bottom: 70%; opacity: 1;} }
@keyframes fadein { from {bottom: 0; opacity: 0;}  to {bottom:  70%; opacity: 1;} }
@-webkit-keyframes expand {   from {min-width: 50px}   to {min-width: 350px} }
@keyframes expand { from {min-width: 50px}  to {min-width: 350px} }
@-webkit-keyframes stay {  from {min-width: 350px}   to {min-width: 350px} }
@keyframes stay { from {min-width: 350px} to {min-width: 350px} }
@-webkit-keyframes shrink { from {min-width: 350px;}   to {min-width: 50px;} }
@keyframes shrink {  from {min-width: 350px;}   to {min-width: 50px;} }
@-webkit-keyframes fadeout { visibility: hidden;  from {bottom:  70%; opacity: 1;}  to {bottom:  75%; opacity: 0;}}
@keyframes fadeout { visibility: hidden;  from {bottom:  70%; opacity: 1;}  to {bottom:  75%; opacity: 0;}}
.user-content, .user-title{white-space: nowrap;   display: inline-block;}.cutomMinHeight{ min-height: 100% !important;  }.stickyBox{position: fixed; opacity: 0.8; left: -11px; z-index: 999; margin-top: 10%;}
.stickyBtn{    background-color: #ff9800 !important;  border-color: #ff9800 !important; padding: 4px 4px; border-radius: 4px;height: 50px !important;}.stickyBtn:hover{background-color: #009688 !important; border-color: #009688 !important;color: #fff ;}  
 .btn-app{min-width: 65px !important; color: #fff !important;}
.modal-dialog{ overflow-y: initial !important}#othrCmntRatingBox{color:#ff5722;}
.btn-employee, .btn-employee:hover {background-color: #795548;  border-color: #795548; cursor: none !important;color:#fff !important;}
.btn-manager, .btn-manager:hover{background-color: #607d8b;  border-color: #607d8b; cursor: none !important;color:#fff !important;}
.btn-hr, .btn-hr:hover{background-color: #8b607d;  border-color: #8b607d; cursor: none !important;color:#fff !important;}
.text-dark{color:black;font-weight: 700;}.totalScore{font-weight: 700;}#actualScore, #targetScore{ color:black;}.content{background: #ecf0f5 !important;height: auto !important;} 
#selected-user-box{margin-top: -35px !important; width:max-content !important;}
.generalHTitle{font-weight:700;}.generalPBlock{border:1px solid #000;padding:5px;}
#pendingBtn{border: 1px solid #dadce0;
    -webkit-border-radius: 18px;
    border-radius: 18px;letter-spacing: .25px;
    background: white;z-index: 0;
    -webkit-font-smoothing: antialiased;
    font-family: 'Google Sans', Roboto,RobotoDraft,Helvetica,Arial,sans-serif;margin-left: 40%;color: #616161;}
    #pendingArrow{vertical-align: 0% !important;}
    #pendingIcon{color:#f10b0b;}
    #modal-pending .modal-body{overflow-y: scroll;  max-height: 70%;}
    .ui-datepicker-year, .ui-datepicker-month{background: #000 !important;}
.category-summary { margin-top: 10px;}.mgcontentColumn{width:20%;}.typingColumn{width:60%;}.viewColumn{width:20%;}.mgtypingBox{width:100%;}.srlColumn, .mgactionColumn{width:10px;}.final-instruction{font-weight: bold;padding-right:20px;font-family: monospace;  font-size: 1.3em;}
</style>
            <link href="resources/css/jquery-ui.css" rel="stylesheet">
            <script src="resources/js/jquery-1.10.2.js"></script>
            <script src="resources/js/jquery-ui.js"></script>
            <script src="resources/js/leaveapplication.js?v=15062022"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>           		    
            <!-- Javascript -->
            <script>
            
            window.onload = function() {
                document.getElementById("addRowBtn").addEventListener("click", function() {
                    var table = document.getElementById("categoryContentTbl").getElementsByTagName('tbody')[0];
                    var newRow = table.insertRow(table.rows.length);
                    var cell1 = newRow.insertCell(0);
                    var cell2 = newRow.insertCell(1);
                    var cell3 = newRow.insertCell(2);
                    var cell4 = newRow.insertCell(3);
                    cell1.innerHTML = table.rows.length; // Increment the row number
                    cell2.innerHTML = "<textarea class='mgtypingBox'></textarea>";
                    cell3.innerHTML = "<textarea class='mgtypingBox'></textarea>";
                    cell4.innerHTML = "<textarea class='mgtypingBox'></textarea>";
                });
            };
      
                
            </script>
            
        </head>
        <div class="container">
        
        	<div class="panel panel-default  small" id="fj-page-head-box">
                     <div class="panel-heading" id="fj-page-head">
                        
                        <h4 class="text-left">
                       		Division Performance Review Report
	                       <a href="homepage.jsp" > <i class="fa fa-home pull-right" title="Home"></i></a>
	                       <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a>                   
                       </h4>
                      
                     </div>
            </div>
            <div class="rest_box1">               
                        <form method="POST" action="businesstripleaveappln.jsp">                            
		                     <div class="panel-heading" id="fj-page-head">                        
		                        <h4 class="text-left">
		                       		Division Details:            
		                       </h4>                      
		                     </div>			                
                            <div class="l_one"> 
                                <div class="l_left1">
                                	  <div class="n_text_narrow" id="frdt_label">Business Entity Name</div>
                                	  <input type="hidden" name="subtype" value="" id="subtype" /> 
                                      <input type="text" style="width:95%" class="leave_text" id="travelerUid" name="traveler_emp_code" tabindex="1" value="${param.traveler_emp_code}"  autocomplete="off" required="required">
                                </div>  
                                 <div class="l_left1">
                                	  <div class="n_text_narrow" id="frdt_label">Relevant Line of Business</div>
                                       <input type="text" class="text_area" style="width:95%" id="traveluName" name="traveluName"  required="required">
                                 </div> 
                                 <div class="l_left1">
                                	  <div class="n_text_narrow" id="frdt_label">Divisions Included</div>
                                       <input type="text" class="text_area" style="width:95%" id="traveluDesignation" name="traveluDesignation" tabindex="1" required="required">
                                 </div>    
                                 <div class="l_left1">
                                	  <div class="n_text_narrow" id="frdt_label">Business Head Name</div>
                                       <input type="text" class="text_area" style="width:95%" id="traveluDesignation" name="traveluDesignation" tabindex="1" required="required">
                                 </div>    
                                 <div class="l_left1">
                                	  <div class="n_text_narrow" id="frdt_label">Reporting Currency</div>
                                       <input type="text" class="text_area" style="width:95%" id="traveluDesignation" name="traveluDesignation" tabindex="1" required="required">
                                 </div>    
                                 <div class="l_left1">
                                	  <div class="n_text_narrow" id="frdt_label">Regions Covered</div>
                                       <input type="text" class="leave_text" style="width:60%" id="traveluDivision" name="traveluDivision" tabindex="1" value="${param.traveluDivision}" required="required">
                                </div> 
                                <div class="l_left1">
                                	  <div class="n_text_narrow" id="frdt_label">Date of Report</div>
                                       <input type="text" class="leave_text" style="width:60%" id="traveluDivision" name="traveluDivision" tabindex="1" value="${param.traveluDivision}" required="required">
                                </div>
                                <div class="l_left1">
                                	  <div class="n_text_narrow" id="frdt_label">Business Year</div>
                                       <input type="text" class="leave_text" style="width:60%" id="traveluDivision" name="traveluDivision" tabindex="1" value="${param.traveluDivision}" required="required">
                                </div>  
                              <br/><br/>
                            </div>
                              <br/><br/>  <br/><br/>     
                             <div class="panel-heading" id="fj-page-head">                        
		                        <h4 class="text-left">
		                       		STRATEGIC OBJECTIVES :            
		                       </h4>                      
		                     </div>			                
<!--                             <div class="l_one">  -->
<!--                                 <div class="l_leftbig"> -->
<!--                                 	  <div class="n_text_narrow" id="frdt_label">Business Entity Name</div> -->
<!--                                 	  <input type="hidden" name="subtype" value="" id="subtype" />  -->
<%--                                       <input type="text" style="width:95%" class="leave_text" id="travelerUid" name="traveler_emp_code" tabindex="1" value="${param.traveler_emp_code}"  autocomplete="off" required="required"> --%>
<!--                                 </div>   -->
<!--                                  <div class="l_leftsmall"> -->
<!--                                 	  <div class="n_text_narrow" id="frdt_label">CAPEX</div> -->
<!--                                        <input type="text" class="text_area" id="traveluName" name="traveluName"  required="required"> -->
<!--                                  </div>  -->
<!--                                  <div class="l_leftsmall"> -->
<!--                                 	  <div class="n_text_narrow" id="frdt_label">Status</div> -->
<!--                                        <input type="text" class="text_area"  id="traveluDesignation" name="traveluDesignation" tabindex="1" required="required"> -->
<!--                                  </div>  -->
<!--                               <br/><br/> -->
<!--                             </div> --> 
							 <div class="row category">
					  		  	<div class="col-md-12 col-xs-12" id="categoryContent">	
					  		  		<table class='table small table-bordered' id='categoryContentTbl' >
										<thead style='backgrond:gray;'>
										<tr><th class='srlColumn'>#</th><th class='contentColumn'>Strategic Objectives</th><th class='viewColumn'>CAPEX</th><th class='viewColumn'>Status Update</th><th>	<button type="button" id="addRowBtn">+</button>	</th></tr>
										</thead><tbody>										
											<tr><td>1</td> 
											<td class='typingColumn'><textarea class='mgtypingBox'></textarea> </td>     			 
											<td class='viewColumn'><textarea class='mgtypingBox'></textarea> </td>   
											<td class='viewColumn'><textarea class='mgtypingBox'></textarea> </td>   
											
											</tr>
											</tbody></table> 		
					  		  	</div>
					  		  </div>    
					  		  <div class="row category">
					  		  	<div class="col-md-12 col-xs-12" id="categoryContent">	
					  		  		<table class='table small table-bordered' id='categoryContentTbl' >
										<thead style='backgrond:gray;'>
										<tr><th class='srlColumn'>#</th><th class='contentColumn'>Strategic Projects</th><th class='viewColumn'>CAPEX</th><th class='viewColumn'>Status Update</th><th>	<button type="button" id="addRowBtn">+</button>	</th></tr>
										</thead><tbody>										
											<tr><td>1</td> 
											<td class='typingColumn'><textarea class='mgtypingBox'></textarea> </td>     			 
											<td class='viewColumn'><input type="text" class="mgtypingBox"> </td>   
											<td class='viewColumn'><input type="text" class="mgtypingBox"> </td>   
											
											</tr>
											</tbody></table> 		
					  		  	</div>
					  		  </div>                                        
                            <div class="clear"></div>
                            <div class="s_box2">
                                 <input type="hidden" name="projectDetails" class="sbt_btn" value="" id="projectDetails"/>
                        	     <input type="hidden" name="purpose" class="sbt_btn" value="" id="purpose"/>
                        	     <input type="hidden" name="otherDetails" class="sbt_btn" value="" id="otherDetails"/>
                        	     <input type="hidden" name="t_approver_eid" class="sbt_btn" value="${param.t_approver_eid}" id="t_approver_eid"/>
                        	     <input type="hidden" name="t_comp_code" class="sbt_btn" value="${param.t_comp_code}" id="t_comp_code"/>
                                <input name="applybutton" type="submit" value="Apply" class="sbt_btn" onclick="return verifyFormdata(this)"/>
                                <input name="resetbutton" type="reset" value="Cancel" class="btn_can" />
                            </div>
                        </form>
<%--                     </c:otherwise> --%>
<%--                 </c:choose> --%>
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