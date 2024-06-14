<%-- 
    Document   : calendar 
--%>
<%@page import="java.util.Date"%>
<%@page import="beans.Holiday"%>
<%@page import="java.sql.Time"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@include file="mainview.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<head>
    <link rel="stylesheet" href="resources/timeSelection/jquery.ui.timepicker.css?v=0.3.3" type="text/css" />
    <script type="text/javascript" src="resources/timeSelection/ui-1.10.0/jquery.ui.core.min.js"></script>  
    <script type="text/javascript" src="resources/timeSelection/jquery.ui.timepicker.js?v=0.3.3"></script>
    <link rel="stylesheet" type="text/css" href="resources/datatables/datatables-fjtco/css/jquery.dataTables.min.css" />
	<link rel="stylesheet" type="text/css" href="resources/datatables/buttons-fjtco/css/buttons.dataTables.min.css" />
	<link rel="stylesheet" type="text/css" href="resources/datatables/datatables-fjtco/css/select.dataTables.min.css" />
	<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/dataTables.buttons.min.js"></script>
	<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/dataTables.select.min.js"></script>
	<script src="././resources/bower_components/moment/moment.js"></script>	
     <script type="text/javascript">
     $(document).ready(function() {
    	 
    	   $('#fromTime').timepicker({
               showPeriodLabels: false
           });
    	   $('#toTime').timepicker({
               showPeriodLabels: false
           });
    	   $('#ffromTime').timepicker({
               showPeriodLabels: false
           });
    	   $('#ftoTime').timepicker({
               showPeriodLabels: false
           });
    	 }); 
							      
     
     </script>
<style>
#cvDetails_tbl thead th, #cvDetails_tbl tbody td{border: 1px solid #03a9f4 !important;padding: 7px; text-align: left;}
.btn-primary{   margin-top:3px; font-weight:bold;   color: #065685;  background-color: #ffffff; border: 1px solid #065685;}
.modal-header .close {margin-top: -20px !important;}
 .custVisit{
  background:#f9f9f9 !important;
 color:#000 !important; 
     border: 2px solid #286090;
 }
 .seg-reg-form{border: 1px solid #fff;  padding: 0px 5px;}
 .tabinactive{background-color: #fff; color: #0065b3; padding: 2px 6px; }
 .tabactive{background-color: #008000; color: #fff; padding:2px 6px;  }
 .custVstChkBox{margin-bottom: 5px; height: 15px; color: white;}
 .divinactive{display:none;}.divactive{display:block;}
 #requestformdiv{width:max-content;z-index: 999;}
 #reminderformdiv{width:max-content;z-index: 999;max-width:50em}
input[type="radio"]{ display:none !important;}
#slctSegRegTyp{border-top: 1px solid #065685;  padding-top: 0.5em;}

.ui-timepicker-table {width: 295px !important;}
#ui-timepicker-div{ background: rgb(6, 86, 133);color:#ffffff;border-radius:5px;} 
.ui-timepicker-hours table td, .ui-timepicker-minutes table td{border: 1px solid #ffffff; }
.ui-timepicker-hour-cell:hover,    .ui-timepicker-minute-cell:hover{background: #03A9F4;color:rgb(6, 86, 133) !important;}        
.ui-timepicker-title{font-weight: bold;}
.ui-state-default{ color:#ffffff !important;}   
 table.dataTable tbody td {padding: 4px 5px !important;font-size: 87% !important;}
 table.dataTable tr.selected, table.dataTable.display tbody>tr.odd.selected>.sorting_1, table.dataTable.display tbody>tr.even.selected>.sorting_1{background:green !important;color:white !important;}
#errMsg{color:red;}
.mr-1{margin-right: 5px !important;}
#vst-entry-block .form-group label{color: #607D8B !important;font-weight:700 !important;}
 [title]{color:blue;} 
 .dataView:hover{cursor: pointer;}
 .ui-timepicker-hours .ui-timepicker{background: #FFC107 !important; color: #060606 !important;}
 .ui-timepicker-minutes .ui-timepicker{background: #009688 !important; color: #060606 !important;}
 #flwUpBlck{border: 1px solid #7c7c7c !important;padding: 2px !important;}
 .cen_icon img{width:40px !important; height:40px !important;}
.cen_icon{margin: 0em 0 0 0;}
#feedback { z-index: 1000;  margin-bottom: 5px;  margin-right: 14px; width:220px; float:right}  
#feedback a {  display: block;   background: #000; height: 30px;  padding-top: 5px;   text-align: center;  color: #ffffff;   font-family: Arial, sans-serif; font-size: 15px;  font-weight: bold; text-decoration: none;
background: linear-gradient(75deg, #ff6140, #FF9800); border-radius: 15px; letter-spacing: 0.05em; text-transform: uppercase; border-bottom: solid 3px #065685; border-left: solid 3px #065685;}
#feedback a:hover { transition: 1s ease-in-out; background: #065685;border-bottom: solid 3px #ff6140; border-left: solid 3px #ff6140; stroke-dashoffset: -480;}
.cust-scrll-box{overflow: scroll; max-height: 155px;}
.fa-stack-1x { margin-top: -1px; }
</style>

</head>
<c:choose>
<c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1}">
<%@ page  language="java" import="java.util.*,java.text.*"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="beans.CustomerVisit"%>
<%@page import="beans.CustomerVisitPlanner"%>
<%!
public int nullIntconv(String inv)
{   
    int conv=0;
        
    try{
        conv=Integer.parseInt(inv);
    }
    catch(Exception e)
    {}
    return conv;
}

private long getDateDiffrncForRegulrznCheck(long sd){
	 Date todayDate = new Date();
	 long todayTime=todayDate.getTime();
	 long dateDiff = (todayDate.getTime() - sd)/(24 * 60 * 60 * 1000);  
	 System.out.println("dateDiff === "+dateDiff);
	 return dateDiff;
}
private long dateDiffInDaysForCustVisitPr(long selectDay){	
	 Date todayDate = new Date();
	 long todayTime=todayDate.getTime();
	 System.out.println("dateDiffInDaysForCustVisitPr === "+selectDay+" -- "+todayTime);
	 long dateDiff = ( selectDay - todayDate.getTime())/(24 * 60 * 60 * 1000);  
	 System.out.println("dateDiffInDaysForCustVisitPr === "+dateDiff);
	 return dateDiff;	
}
%>
<%

 int noofholidays =0;
 int iYear=nullIntconv(request.getParameter("iYear"));
 int iMonth=nullIntconv(request.getParameter("iMonth"));
 String cur_uid = (String)(request.getParameter("cur_usr"));
 String actn = (String)(request.getParameter("actn"));
 beans.fjtcouser current_user = null;
 beans.CompParam theCompParam = ((beans.CompParam)request.getSession().getAttribute("cmp_param"));
 beans.Attendance attendance = (beans.Attendance)request.getSession().getAttribute("attendance");
 beans.fjtcouser login_user = (beans.fjtcouser)request.getSession().getAttribute("fjtuser");
 beans.Holiday hhh = (beans.Holiday)request.getSession().getAttribute("holiday");
 java.util.concurrent.ConcurrentHashMap ml= login_user.getSubordinatelist();
 
 if(cur_uid == null ||  login_user.getEmp_code().equals(cur_uid)){
    current_user=  login_user;
 }else{
    current_user =(beans.fjtcouser) ml.get(cur_uid);
 }
 hhh.setCompCode(current_user.getEmp_com_code());
 theCompParam.setCompanyCode(current_user.getEmp_com_code());
 //System.out.println("current user compcode :"+current_user.getEmp_com_code());
 
 Calendar ca = new GregorianCalendar();
 int iTDay=ca.get(Calendar.DATE);
 int iTYear=ca.get(Calendar.YEAR);
 int iTMonth=ca.get(Calendar.MONTH);
 
 if(iYear==0)
 {
      iYear=iTYear;
      iMonth=iTMonth;     
      hhh.getAllHolidaysofCurYear();
 }
 else if(iYear != iTYear){
    hhh.setCuryear(iYear);
    hhh.getAllHolidaysofCurYear();
 }
 else if(iYear == iTYear){
     hhh.setCuryear(iTYear);
     hhh.getAllHolidaysofCurYear();
 }
 GregorianCalendar cal = new GregorianCalendar (iYear, iMonth, 1); 

 int days=cal.getActualMaximum(Calendar.DAY_OF_MONTH);
 int weekStartDay=cal.get(Calendar.DAY_OF_WEEK);
 theCompParam.setMonth(iMonth+1);
 theCompParam.setYear(iYear);
 
 cal = new GregorianCalendar (iYear, iMonth, days); 
 int iTotalweeks=cal.get(Calendar.WEEK_OF_MONTH); 
 if(current_user.getCalander_code().equalsIgnoreCase("SUN-THU") || current_user.getCalander_code().equalsIgnoreCase("MON-FRI") ){
     attendance.setDStart(theCompParam.getStaffDayStartValuesOfTheMonth());
     attendance.setDEnd(theCompParam.getStaffDayEndValuesOfTheMonth()); 
 }
 else{
     attendance.setDStart(theCompParam.getLabourDayStartValuesOfTheMonth());
     attendance.setDEnd(theCompParam.getLabourDayEndValuesOfTheMonth());
    
     
 }
 attendance.setMonth(iMonth+1);
 attendance.setYear(iYear);
 attendance.setAcno(current_user.getAcsno()); 
 System.out.println("accesscardno== "+current_user.getAcsno());
 attendance.getMonthlyattendance(); 
 beans.Leave leaveO =(beans.Leave)request.getSession().getAttribute("leave");
 leaveO.setEmp_code(current_user.getEmp_code());
 leaveO.setEmp_comp_code(current_user.getEmp_com_code());
 leaveO.setCur_procm_startdt(theCompParam.getCurrentProcMonthStartDate()); 
 leaveO.getAllApprovedLeaveApplications();//fix for diff years 
 //System.out.println(" empcode "+current_user.getEmp_code());	
 CustomerVisit cv = new CustomerVisit();
 CustomerVisitPlanner cvp = new CustomerVisitPlanner();
 List<CustomerVisit>  custVisitDays= cv.getMonthlyCustomerVisitDays(iMonth+1, iYear, current_user.getSales_code(), current_user.getEmp_code());
 List<CustomerVisitPlanner>  custVisitPlannerDays= cvp.getMonthlyCustomerVisitPlannedDays(iMonth+1, iYear, current_user.getSales_code(), current_user.getEmp_code());
 List<CustomerVisitPlanner>  remindersCount= cvp.getMonthlyRemindersDays(iMonth+1, iYear, current_user.getSales_code(), current_user.getEmp_code());
 System.out.println("custVisitPlannerDays== "+custVisitPlannerDays.size());
 %>

<!DOCTYPE html> 
<c:set var="actionTypes" value="<%=login_user.getVisitActions()%>" scope="page" />
<script>
var prjectsTable, prjectsTable1,prjectsTableRemdr, docId,   projectName, party, visitTpe = 0, action, regOptnSts = 0, fromTime, toTime, actionDesc, visitCount = 0, alrdyUpdtdVstCnt = 0; cvDetails = [];
var today = new Date().toJSON().slice(0,10).split('-').reverse().join('/');
var projects,  projects1, projectsfrRmdr,fdocId,fprojectName,fparty,fregOptnSts=0 ,hsysId;
</script> 
<script src="resources/js/calendar.js?v=01062022"></script>
<script src="resources/js/reminder.js?"></script>
<div class="container" style="margin-top: -20px;">
        <% 
            if(current_user.equals(login_user)){
                if(actn!=null && actn.equalsIgnoreCase("Apply")){
                String regdate = (String)(request.getParameter("regularise_date"));
                String reason =  (String)(request.getParameter("reason"));
                beans.Regularisation regn = new beans.Regularisation();
                regn.setApprover_id(current_user.getApprover());
                regn.setApprover_eid(current_user.getApproverId());
                regn.setRegularise_dateStr(regdate);
                regn.setEmp_code(current_user.getEmp_code());
                regn.setEmp_name(current_user.getUname());
                regn.setReason(reason);
                int resp = regn.getSendRegularisationRequest();  
                String responsemessage="";
                 if(resp == 1){
                     responsemessage="Regularisation request sent.";
                 }
                 else{
                     responsemessage="Error in processing. Try Later.";
                 }
                %>
                <%--Regularisation Response Start --%>
                <div id="requestformdiv" class="requestformdiv">
                    <div id="formheading"><%=responsemessage%></div>
                    <img src="resources/images/Closebutton.png" style="float: right" onclick="closeRequestWindow();"/><br/>                 
           		</div>
           		<%-- Regularisation Response End --%>
           		 <div id="reminderformdiv" class="requestformdiv">
                    <div id="formreminderheading"><%=responsemessage%></div>
                    <img src="resources/images/Closebutton.png" style="float: right" onclick="closeRequestWindow1();"/><br/>                 
           		</div>
               <%  
                }else{ 
         %>
       
        <%-- Main Regularisation Form Start --%>
        <div id="requestformdiv" class="requestformdiv custVisit">
	        <div class="rqstDvHeader">
	        <span id="formheading" class="pull-left"></span>
	        <span class="pull-right"><i class="fa fa-window-close fa-lg closeRqst" onclick="closeRequestWindow();"></i></span>
	        </div>
             <% 
             	if(current_user.getOutvisit().equalsIgnoreCase("y")){ // removed current_user for testing ( bug sales engineers getting normal reg screen)
              %>           
                   <div id="custRqstBox">   
                     <div id="slctSegRegTyp">   
							 	<label id="otherlabel"><input class="form-control" type="radio" name="tab" value="normal" id="rother" onclick="otherBox();" checked />
							  	Normal
							  	</label>							  	
							<label id="custlabel">
								<input class="form-control"  type="radio" name="tab" value="custvst" id="rcustvst" onclick="custVisitBox();" />
								Cust-Visit
							</label>							
					  </div>         		     
          		     <div id="other" >
          		      <form  id="requestform" action="regularisationRequest.jsp"  class="seg-reg-form">              		             		      
	          		      Reason:&nbsp;&nbsp;&nbsp;&nbsp;<textarea name="reason" id="thereason" maxlength="100" style="width:14em;height: 2em;"></textarea>        		     
	                     <input type="hidden" name="iYear" value="${iYear}"/>
			             <input type="hidden" name="idate" value="" id="idate"/>
			             <input type="hidden" name="ichkin" value="" id="ichkin"/>
			             <input type="hidden" name="regularise_date" value="" id="regularise_date"/>
			             <input type="hidden" name="regOptnSts" value="1" id="regOptnSts"/> 
			             <input type="hidden" name="alrdyUpdtdVsts" value="0" id="alrdyUpdtdVsts"/> 
			             <br/><br/>
			             <input type="button" class="sbt_btn"  onclick="Apply(this);" name="actn" value="Apply"/>
			             </form>         		     	   
          		     </div>           		      
          		     <div id="custvisit" >
          		     <div align="right" style="margin-bottom:5px;">
			    		<button type="button" name="add" id="newVst" class="btn btn-success btn-xs"  data-toggle="modal" data-target="#modal-new-visit" ><i class="fa fa-plus" > </i>New Visit</button>
			   		</div>
			   			 
          		          <div class="table-responsive pre-scrollable cust-scrll-box"> 
						     <table class="table table-bordered small" id="user_data">
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
						    
          		     	<form   id="requestform"   action="regularisationRequest.jsp"  class="seg-reg-form">
          		     		<div align="center">
          		     		  <input type="hidden" name="iYear" value="${iYear}"/>
				              <input type="hidden" name="idate" value="" id="idate"/>
				              <input type="hidden" name="ichkin" value="" id="ichkin"/>
				              <input type="hidden" name="regularise_date" value="" id="regularise_date"/>
				              <!-- CUST VISIT OPTIONS S****-->
				              <input type="hidden" name="regOptnSts" value="1" id="regOptnSts"/> 
				              <input type="hidden" name="alrdyUpdtdVsts" value="0" id="alrdyUpdtdVsts"/> 
				              <input type="hidden" name="cvAYn" value="<%=current_user.getOutvisit()%>" id="cvAYn"/> 
				              <!-- CUST VISIT OPTIONS E**--> 
						      <input type="button" class="sbt_btn3" id="apply_btn2" onclick="Apply(this);" name="actn" value="Submit & Apply"/>
						    </div>
          		     	</form>         		     	          		    
          		     </div>          		    
          		   </div>       
          		     	        		    
              <%
                  }else{
              %>  	
                    <form    id="requestform"  action="regularisationRequest.jsp">                                                                	
          		     Reason:&nbsp;&nbsp;&nbsp;&nbsp;<textarea name="reason" id="thereason" maxlength="100" style="width:14em;height: 2em"></textarea>       		
                     <%--<br> Conslt Ref:&nbsp; <input type="text" size="18em" name="prjdetail" id="prjdetail"/> --%> 
                     <input type="hidden" name="iYear" value="${iYear}"/>
		             <input type="hidden" name="idate" value="" id="idate"/>
		             <input type="hidden" name="ichkin" value="" id="ichkin"/>
		             <input type="hidden" name="regularise_date" value="" id="regularise_date"/>
		             <input type="hidden" name="regOptnSts" value="0" id="regOptnSts"/> 
		             <input type="hidden" name="alrdyUpdtdVsts" value="0" id="alrdyUpdtdVsts"/> 
		             <br/><br/>
		             <input type="button" class="sbt_btn3" id="apply_btn3" onclick="Apply(this);" name="actn" value="Apply"/>
                     </form>	
              <% }
              %>
               
           
        </div>	  	        
        <%-- Main Regularisation Form End --%>
        <%--Start Customer visit planner and reminders --%>
        <div id="reminderformdiv" class="requestformdiv custVisit">
	        <div class="rqstDvHeader">
	        <span id="formreminderheading" class="pull-left"></span>
	        <span class="pull-right"><i class="fa fa-window-close fa-lg closeRqst" onclick="closeRequestWindow1();"></i></span>
	        </div>
             <% 
             	if(current_user.getOutvisit().equalsIgnoreCase("y")){ // removed current_user for testing ( bug sales engineers getting normal reg screen)
              %>           
                   <div id="custreminderRqstBox">   
                     <div id="slctSegRegTyp">   
							 	<label id="reminderlabel"><input class="form-control" type="radio" name="remindertab" value="1" id="rreminder" onclick="remindersBox();" checked />
							  	Reminders
							  	</label>
							<label id="custvstpllabel">
								<input class="form-control"  type="radio" name="remindertab" value="2" id="rcustvstpl" onclick="custVisitPlannerBox();" />
								Cust-Visit Planner
							</label>							
					  </div>         		     
          		     <div id="reminder" >
          		      <form  id="reminderform" action="regularisationRequest.jsp"  class="seg-reg-form"> 
          		      <div> 
	          		    <div class="form-group col-md-4 col-xs-12" style="padding-top:5px;"> 
				         	 <label>Reminder Type</label>
				              <select class="form-control select2 input-sm" style="width: 100%;height:35px" id="remindervstTyp" name="vstTyp" onChange="checkReminderVisitType()" required>
				                <option value="">Select</option>					                
			                    <option value="1" class="General">General</option>
			                    <option value="2" class="">Follow-Up</option>
				              </select>			          
				         </div> 
				         <!--  <div class="form-group  col-sm-6 col-md-6 col-xs-12" style="padding-top:5px;"> 
							 <div class="input-group  pull-center"  >	 
							 <label>Project Name</label> 
				             <input type="text" class="form-control"    id="rprojectName"  name="custNam" value=""  onkeypress="clearErrorMessage()" required/> 
				             </div>
               			    </div>    -->  
               			   <div class="form-group  col-sm-6 col-md-6 col-xs-12" style="padding-top:5px;"> 
							<div class="input-group  pull-center"  >	 
							 <label>Description</label> 
				             <input type="text" class="form-control"    id="rcustName"  name="custContctNo" value=""  onkeypress="clearErrorMessage()" required/> 
				             </div>
               			    </div> 
               			    <div class=" col-md-12 col-xs-12">
	               			    <div id="frgnrlBlck"> 
	               			    	<!--  <div class="input-group  pull-center"  >	 
									 <label>Project Name</label> 
						             <input type="text" class="form-control"    id="rprojectName"  name="custNam" value=""  onkeypress="clearErrorMessage()" required/> 
						             </div> -->
						         </div>
					            <div id="frflwUpBlck">    
					            <h5> <b>Select Project From Below List (Last 12 months projects only!) </b> </h5>
					                 <div id="frlUpMessage"></div>
				                	 <div id="frflUpContent"></div>				                	 
			                	</div>			                	 
			                </div>        		             		      
	          		     <input type="hidden" name="reason" id="thereminderreason"/> 		     
	                     <input type="hidden" name="iYear" value="${iYear}"/>
			             <input type="hidden" name="idate" value="" id="idate"/>
			             <input type="hidden" name="ichkin" value="" id="ichkin"/>
			             <input type="hidden" name="regularise_date" value="" id="regularise_date"/>
			             <input type="hidden" name="regOptnSts" value="4" id="fregOptnSts"/> 
			             <input type="hidden" name="alrdyUpdtdVsts" value="0" id="alrdyUpdtdVsts"/> 
			             <br/><br/>
			             </div>
			             <input type="button" style="margin-top:10px" class="sbt_btn"  id="rsubmit" onclick="fApply(this);" name="actn" value="Submit"/>
			             </form>         		     	   
          		     </div>           		      
          		     <div id="custvisitplnner" >
          		     <div align="right" style="margin-bottom:5px;">
			    		<button type="button" name="add" id="newVstPl" class="btn btn-success btn-xs"  data-toggle="modal" data-target="#modal-new-visitpl" ><i class="fa fa-plus" > </i>New Visit</button>
			   		</div>
          		          <div class="table-responsive pre-scrollable cust-scrll-box"> 
						     <table class="table table-bordered small" id="user_reminder_data">
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
						    
          		     	<form   id="reminderform"   action="regularisationRequest.jsp"  class="seg-reg-form">
          		     		<div align="center">
          		     		  <input type="hidden" name="iYear" value="${iYear}"/>
				              <input type="hidden" name="idate" value="" id="idate"/>
				              <input type="hidden" name="ichkin" value="" id="ichkin"/>
				              <input type="hidden" name="regularise_date" value="" id="regularise_date"/>
				              <!-- CUST VISIT OPTIONS S****-->
				              <input type="hidden" name="regOptnSts" value="3" id="fregOptnSts"/> 
				              <input type="hidden" name="alrdyUpdtdVsts" value="0" id="alrdyUpdtdVsts"/> 
				              <input type="hidden" name="cvAYn" value="<%=current_user.getOutvisit()%>" id="cvAYn"/> 
				              <!-- CUST VISIT OPTIONS E**--> 
						      <input type="button" class="sbt_btn3" id="fapply_btn2" onclick="fApply(this);" name="actn" value="Submit"/>
						    </div>
          		     	</form>         		     	          		    
          		     </div>
          		   </div>       
          		     	        		    
              <%
                  }else{
              %>  	<div id="slctSegRegTypRem">   
	                    <form    id="reminderform"  action="regularisationRequest.jsp">
	          		     Reminders:&nbsp;&nbsp;&nbsp;&nbsp;<textarea name="reason" id="thereminderreason" maxlength="100" style="width:40em;height: 4em"></textarea>       		
	                     <%--<br> Conslt Ref:&nbsp; <input type="text" size="18em" name="prjdetail" id="prjdetail"/> --%> 
	                     <input type="hidden" name="iYear" value="${iYear}"/>
			             <input type="hidden" name="idate" value="" id="idate"/>
			             <input type="hidden" name="ichkin" value="" id="ichkin"/>
			             <input type="hidden" name="regularise_date" value="" id="regularise_date"/>
			             <input type="hidden" name="regOptnSts" value="0" id="fregOptnSts"/> 
			             <input type="hidden" name="alrdyUpdtdVsts" value="0" id="alrdyUpdtdVsts"/> 
			             <br/><br/>
			             <input type="button" class="sbt_btn3" id="fapply_btn3" onclick="fApply(this);" name="actn" value="Submit"/>
	                     </form>
                     </div>	
              <% }
              %>
               
           
        </div>	  	        
        <%--End ofCustomer visit planner and reminders--%>
      <%
          }
        }
       %>
       <div class="row service-menus">
	       	<div class="col-xs-12 ">  
	       		  <a href="calendar.jsp" class="button">Attendance</a>
			      <a href="leaveappln.jsp" class="button">Leave Application</a>
			      <a href="DailyTask" class="button">Daily Task </a>
			      <a href="businesstripleaveappln.jsp" class="button">Business Trip Application </a>
			      <c:if test="${!empty fjtuser.subordinatelist}">
               		  <a href="approvalrequests.jsp" class="button">Leave Approval</a>
                	  <a href="approvalregularisation.jsp" class="button">Regularisation Approval</a>
                	  <c:if test="${fjtuser.role eq 'hrmgr' and fjtuser.emp_code eq 'E000044'}">   
                	  	 <a href="SickLeaveApproval" class="button">Sick Leave Approval </a>
                	   </c:if>
                  </c:if>
                  <c:if test="${fjtuser.sales_code ne null}">
                    <%  if(current_user.getOutvisit().equalsIgnoreCase("y")){ %>
          		  	  <a href="CustomerVisitPlanner" class="button">Customer Visit Planner</a>
          		  	  <%} %>
          		  </c:if>          		   
                  <h4><a href="homepage.jsp" > <i class="fa fa-home pull-right"></i></a></h4>
	       		  <a href="calendar.jsp"> <i class="btn btn-xs btn-primary fa fa-refresh pull-right"  ></i></a> 
	       	</div>
	       	<div class="col-xs-6 attendance-info">
	       		<span class="calendar-page-title pull-left">Attendance Details</span>  	       		
	       	</div> 
	        <div class="col-xs-6 attendance-info fadeInRight"> 
	       		<span class="card pull-left small info-reg">* Click on the icons in the calendar to apply for regularisation / Cust Visit.</span>
	       		<span class="card pull-left small info-reg">* Regularisation and Customer Visit allowed till 3 back days (Excluding weekends).</span>  	       		
	       	</div>       
       </div>
       
      <%-- Login USR EMPCODE = <%=login_user.getEmp_code()%> - CUR USR EMP CODE = <%=current_user.getEmp_code()%>    LGN USER OV = <%=login_user.getOutvisit()%> - CUR USER OV = <%=current_user.getOutvisit()%> LOG USER SEGC =  <%=login_user.getSales_code()%> -  CUR USER SEGC = <%=current_user.getSales_code()%> --%> 
        <div class="att_searchbox">                          
                <div class="search_section" style="width:96%">
                    <form name="frm" method="post">
                        <select class="select_usr" name="cur_usr">
                            <%
                                if(login_user.getEmp_code().equals(cur_uid)){
                               %> 
                               <option value ="${fjtuser.emp_code}" selected="selected"><c:out value ="${fjtuser.uname}"/></option>
                               <%
                                }else{
                                    %>
                                    <option value ="${fjtuser.emp_code}" ><c:out value ="${fjtuser.uname}"/></option>     
                           <%
                                }
                            
                           
                           Iterator<beans.fjtcouser> itr = ml.values().iterator();
                           while(itr.hasNext()) {
                            beans.fjtcouser sub1 = itr.next();
                            String value = sub1.getEmp_code();
                            
                            if(value.equals(cur_uid)){
                            %>    
                            <option value="<%=value%>" selected="selected"><%=sub1.getUname()%></option>
                            <%
                            }
                            else{
                                %>
                                <option value="<%=value%>" ><%=sub1.getUname()%></option>
                                <%
                            }
                            }
                        %>
                    </select>  
                    <select class="select_month"  name="iMonth">
                                <%
                                 for(int im=0;im<=11;im++)
                                {
                                if(im==iMonth)
                                {
                               %>
                                <option value="<%=im%>" selected="selected"><%=new SimpleDateFormat("MMMM").format(new Date(2008,im,01))%></option>
                                <%
                                }
                                else
                                {
                                  %>
                                <option value="<%=im%>"><%=new SimpleDateFormat("MMMM").format(new Date(2008,im,01))%></option>
                                <%
                                }
                              }
                            %>
                      </select>                        
                    <select class="text_sm"  name="iYear" >
                        <%
                        // start year and end year in combo box to change year in calendar
                         for(int iy=2016;iy<=2030;iy++)
                            {
                            if(iy==iYear)
                            {
                             %>

                             <option value="<%=iy%>" selected="selected"><%=iy%></option>
                            <%
                             }
                            else
                            {
                             %>
                            <option value="<%=iy%>"><%=iy%></option>
                            <%
                            }
                        }
                        %>
                    </select>   
                     <input name="calendar_submit" type="submit" value="Details" class="search_btn" />                     
                     </form>  
                    <!--  <div id="feedback"><a href="Feedback"><i class="fa fa-share" aria-hidden="true"></i> Feedback</a></div> -->                  
                </div>
                 
            </div>
            <div class="rest_box mrl0">
            	<div class="caln">
                <div class="mmyy"><%= new SimpleDateFormat("MMMM").format(new Date(2008,iMonth,01))%> - <%=iYear%></div>
                    <div class="week_sec">
                    <div class="w1">SUN</div>
                    <div class="w1">MON</div>
                    <div class="w1">TUE</div>
                    <div class="w1">WED</div>
                    <div class="w1">THU</div>
                    <div class="w1">FRI</div>
                    <div class="w1">SAT</div>
                    
                    </div>
                        <div class="days_box">
                             <%
                            int cnt =1;
                            for(int i=1;i<=iTotalweeks;i++)
                            {                            
                                for(int j=1;j<=7;j++)
                                {
                                    if(cnt<weekStartDay || (cnt-weekStartDay+1)>days)
                                    {
                              %>
                                    <div class="d1">
                                      <div class="date">&nbsp;<%--Not  a day of current month --%></div>
                                      <div class="cen_icon"></div>
                                    </div>
                              <% 
                                    }
                                    else
                                    { 
                                      
                                    	int thisdate  = cnt-weekStartDay+1;       
                                        
                                      String leavestatus="";
                                      String chkin = attendance.getCheckinOnDay((thisdate));
                                      String chkout = attendance.getCheckoutOnDay((thisdate));
                                      String thisday = ""+ iYear + "-"+(iMonth+1)+"-"+(thisdate);
                                      String thisday1 = ""+ iYear + "-"+(iMonth+1)+"-"+(thisdate);
                                      String daystring = "'"+(thisdate<=9?"0"+thisdate:thisdate)+"/"+((iMonth+1)<=9?"0"+(iMonth+1):(iMonth+1))+"/"+iYear+"'";
                                      DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");     
                                      //System.out.println("chkin : "+chkin+" chkout: "+chkout+" thisday: "+thisday);
                                      
                                      System.out.println("\nProcessing day== "+thisday);
                                    java.util.Date dt,dt1,dt2;  
                                    java.sql.Date sd=null,sd1=null,sd2=null;
                                    int isH=0,status=4,isHH=0;
                                    long daysdiff= 0;
                                    try {
                                        dt = formatter.parse(thisday);                                    
                                        sd= new java.sql.Date(dt.getTime()); 
                                        
                                        isH = hhh.isAHoliday(sd);
                                        //System.out.println(sd+ "Day isH: 0:Past, 1:Holiday, 2:Future, 3:Present "+isH);
                                    } catch (ParseException ex) {
                                       sd=null;
                                    }                                   
                                   
                                    int regltnBackDays = 3; // 3 days back day allowed
                                    //commented as part of adding holidays to regularisation backdays.
                                  /*  if(j == 4 || j == 5 || j == 6){
                                    	regltnBackDays = 5; // 5 days back day allowed                                    	
                                    }*/
                                  	//Added as part of adding holidays to regularisation backdays.
                                    try {
                                    	DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                                    
                                        dt1 = formatter.parse(thisday1);                                    
                                        sd1= new java.sql.Date(dt1.getTime());                                        
                                     
                                        String thisday2 = ""+iYear+"-"+((iMonth+1)<=9?"0"+(iMonth+1):(iMonth+1))+"-"+(thisdate<=9?"0"+thisdate:thisdate);
                                        
                                        System.out.println(" thisday2== "+thisday2);
                                        
                                        for(int k=0;k<=regltnBackDays;k++){                                        	
                                        	LocalDate date = LocalDate.parse(thisday2, formatter1);     
                                        	LocalDate newDate = date.plusDays(k);
                                        	String output = newDate.format(formatter1);                                        	
                                        	dt2 = formatter.parse(output);  
                                        	sd2= new java.sql.Date(dt2.getTime()); 
                                        	isHH = hhh.isAHoliday(sd2);
                                      	  if(isHH == 1){  
                                      		  regltnBackDays = regltnBackDays+isHH;
                                        	}                                      	
                                      	 
                                      	 if((j+k) % 6 == 0 || (j+k) % 7  == 0 ){
                                      		 
                                      	   System.out.println(""+j +"== "+k +"sum "+(j+k) % 6  +"sum2 = "+(j+k) % 7 );
                                   			regltnBackDays=regltnBackDays+1;
                                   		  }
                                      	
                                      }
                                       
                                    } catch (ParseException ex) {
                                      
                                    } 
                                           
                                 System.out.println("thisday== "+thisday +" regltnBackDays==="+regltnBackDays);
                                    if(isH != 3){ //not current day
                                    %>
                                    <div class="d1">
                                    <div class="date"><%=(thisdate)%></div>
                                    <%
                                    }
                                    else{
                                      %>
                                    <div class="dtoday">
                                    <div class="date"><%=(thisdate)%></div>
                                      <%                                        
                                    }   
                                    int custVisitStatus = cv.getCustomVisitDayStatus(custVisitDays, thisdate);
                                    int custVisitPlannerStatus = cvp.getCustomVisitPlannerDayStatus(custVisitPlannerDays, thisdate); 
                                    int reminderStatus = cvp.getReminderDayStatus(remindersCount, thisdate); 
                                    System.out.println("custVisitPlannerStatus == "+custVisitPlannerStatus);
                                    int rgstatus=0;
                                    int businesstrplv=0;
                                    System.out.println("sd== "+sd +"isH== "+isH);
                                      if(sd!=null && isH == 2){  //future dates and not a holiday
                                         leavestatus = leaveO.getLeaveStatusOfDay(sd); 
                                         System.out.println("future day == "+leavestatus);
                                         businesstrplv=leaveO.getBusinessTripLVApplStatus(sd);
                                     
                                         //if(current_user.getSales_code() != null && current_user.getOutvisit().equalsIgnoreCase("y")){
                                        if((theCompParam.getCurrentProcMonthStartDate().getTime() < sd.getTime())){
                                        	 status=16;
                               			  }
                                         if(!leavestatus.isEmpty())
                                             status = 0; //future leave
                                    	 if(businesstrplv != 0){
                                    		 if(businesstrplv == 1){
                                    			 status=13;
                                    		 }else if(businesstrplv == 4){
                                    			 status=14;
                                    		 }else if(businesstrplv == 3){
                                    			 status=15;
                                    		 }
                                    		 	
                                    	 }
                                      }
                                      else if(isH == 1 && sd!=null){ 
                                          status = 5; //holiday
                                          
                                      }
                                      else{
                                       //status = attendance.getDayStatus(thisdate,sd); 
                                       status = attendance.getDayStatusByCalculation(thisdate,sd); 
                                       System.out.println("Day : "+thisdate+" Status: "+status+" Date: "+sd+" custvist :  for day "+thisdate);
                                       //System.out.println("current user : "+current_user.getOutvisit());
                                       //0- absent, 2-single swipe, -1 - earlygo or late come, -3 - both earlygo and late come                                         
                                       if(status == 0 || status == 2 || status == -1 || status == -3){ //absent, single swipe, earlygo or late come or both
                                           if(status==0 && attendance.checkWeekendsDayOrNot(current_user.getCalander_code(),j,iYear)) //weekend 
                                          status = 4; 
                                           leavestatus = leaveO.getLeaveStatusOfDay(sd); 
                                             // if(isH ==3)
                                                 System.out.println("leave status :"+leavestatus);
                                              if(leavestatus == null || leavestatus.length()==0){                                            	  
                                            	 businesstrplv=leaveO.getBusinessTripLVApplStatus(sd);
                                            	 System.out.println("case 13 :"+businesstrplv);
                                            	 if(businesstrplv != 0){
                                            		 if(businesstrplv == 1){
                                            			 status=13;
                                            		 }else if(businesstrplv == 4){
                                            			 status=14;
                                            		 }else if(businesstrplv == 3){
                                            			 status=15;
                                            		 }
                                            		 	
                                            	 }else{
	                                                 rgstatus = attendance.getRegularisationStatus(sd, current_user.getEmp_code());                                                 
	                                                // System.out.println("rg status :"+rgstatus);
	                                                 if(rgstatus == 1) //request sent
	                                                     status=7;
	                                                 else if(rgstatus == 4)
	                                                     status=3; //regularised
	                                                 else if(rgstatus == 3 && status ==2)
	                                                     status=9; //rejected request , single swipe
	                                                 else if(rgstatus == 3 && status ==-1)
	                                                     status=8; //rejected request , late come or early go
	                                                 else if(rgstatus == 3 && status == 0)
	                                                     status=12;  //rejectced request , absent
	                                                 else if(rgstatus ==0 && status==0 && isH !=3) //  if rgstatus=0, status is retained.
	                                                     status=6; //absent 
	                                                 else if((rgstatus ==0 || rgstatus==3) && status==-3) //  early and late
	                                                     status=11;    
	                                                 else if (rgstatus == 0 && isH == 3 ) // current day. show timings only.
	                                                   status =  10;     
	                                            	 }
                                              }
                                              else{ 
                                                  status =0; //leave
                                              }
                                       }
                                                                                 
                                      }
                                       String newdivid = "day_"+thisdate;    
                                       System.out.println("status== "+status +"regltnBackDays=="+regltnBackDays +"date"+thisdate);
                                       int AllowVisitPlanner = 0;
                                    switch (status){
                                           case 0:
                                         %>
                                         <div class="cen_icon"><%=leavestatus%><img src="resources/images/Leave.gif"/></div>
                                         <%
                                            break;
                                           case 1: // Present
                                        	   System.out.println("111  "+current_user.getOutvisit().equalsIgnoreCase("y")+"  cust "+custVisitStatus);
	                                         if((theCompParam.getCurrentProcMonthStartDate().getTime()< sd.getTime()) && (getDateDiffrncForRegulrznCheck( sd.getTime()) <= regltnBackDays ) && custVisitStatus < 7 && current_user.getOutvisit().equalsIgnoreCase("y")){
	                                        	 System.out.println("in if");
	                                         %>
	                                             <div id="day_<%=(thisdate)%>" class="cen_icon" style="height:70%;" onclick="showRegularisationRequest(event, <%=daystring%> , <%=(thisdate)%> , 'Present', <%=custVisitStatus%> );"  >
	                                             <%=chkin%>&nbsp;-&nbsp;<%=chkout%><img src="resources/images/present.gif"/>
	                                             <% if(custVisitStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: blue;"><%=custVisitStatus%></i><%}%> <%--Present & cust visit updated for SEG, but still seg can update upto 7 --%>
	                                             <% if(custVisitPlannerStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: purple;float:right;padding-right:9px;"><%=custVisitPlannerStatus%></i><%} %>
	                                         <% }else{System.out.println("else "); %>
			                                         <div class="cen_icon"><%=chkin%>&nbsp;-&nbsp;<%=chkout%><img src="resources/images/present.gif"/>
			                                         <% if(custVisitStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: green;"><%=custVisitStatus%></i><%}%> <%--Present & cust visit updated for SEG --%>
	                                         		 <% if(custVisitPlannerStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: purple;float:right;padding-right:9px;"><%=custVisitPlannerStatus%></i><%} %>
	                                         <% } %>                                                                     
                                         </div>
                                         <%   
                                            break;
                                           case 2: // Single Swipe
                                           System.out.println("2222222222222222"+regltnBackDays);
                                               if((theCompParam.getCurrentProcMonthStartDate().getTime()< sd.getTime()) && (getDateDiffrncForRegulrznCheck( sd.getTime())<= regltnBackDays)){  // - days gap to regularise for if any punching there, no daily task validation
                                                    String swipeMsg = "'Single swipe :"+chkin+"'";        
                                          			%>
                                         			<div id="<%=(newdivid)%>" class="cen_icon" style="height:70%;" onclick="showRegularisationRequest(event, <%=daystring%> , <%=(thisdate)%> , <%=swipeMsg%>, <%=custVisitStatus%>);"  ><%=chkin%>&nbsp;-&nbsp;<%=chkout%><img src="resources/images/ss1.gif"/>
                                          				<% if(custVisitStatus > 0 && custVisitStatus < 7){ %> <i class="fa fa-2x  fa-check-square-o" style="color: blue;"><%=custVisitStatus%></i> 
                                          				<% }else if(custVisitStatus == 7){ %>  <i class="fa fa-2x  fa-check-square-o" style="color: green;"><%=custVisitStatus%></i> <%}else{}%>
                                          				<% if(custVisitPlannerStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: purple;float:right;padding-right:9px;"><%=custVisitPlannerStatus%></i><%} %>
                                         			</div>
                                        	   <%}else{ %>
			                                        <div id="day_<%=(thisdate)%>" class="cen_icon" ><%=chkin%>&nbsp;-&nbsp;<%=chkout%><img src="resources/images/ss1.gif"/>
			                                        	<% if(custVisitStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: green;"><%=custVisitStatus%></i><%}%>
			                                        	<% if(custVisitPlannerStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: purple;float:right;padding-right:9px;"><%=custVisitPlannerStatus%></i><%} %>
			                                        </div>
                                         		<% }
                                           	break;
                                           case 3: // Regularised  
                                          		%> 
                                          			<div class="cen_icon"><%=chkin%>&nbsp;-&nbsp;<%=chkout%><img src="resources/images/regularised.gif"/>
                                          				<% if(custVisitStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: green;"><%=custVisitStatus%></i><%}%> <%--Regularised & cust visit updated for SEG --%>
                                         				<% if(custVisitPlannerStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: purple;float:right;padding-right:9px;"><%=custVisitPlannerStatus%></i><%} %>
                                         			</div>                                       
                                         		<%
                                           	break;
                                           case 4: // Not a active day on calendar
                                         		 %>
                                         			<div class="cen_icon">&nbsp;<br></div>
                                         		<%
                                           	break;
                                           case 5: // holiday
                                          		%>
                                         			<div class="cen_icon"><%=chkin%>&nbsp;-&nbsp;<%=chkout%><img src="resources/images/holiday.gif"/></div>
                                         		<%
                                           	break;
                                           case 6: // Absent                                     
                                           		if((theCompParam.getCurrentProcMonthStartDate().getTime() < sd.getTime()) && (getDateDiffrncForRegulrznCheck( sd.getTime()) <= regltnBackDays )){  //- days gap to regularise    and daily task validation also   
                                                	 //10-04-2020 -start newly added for daily task regularization only for absent  and staff employees , excluded case for  seg's and labours
                                                	 System.out.println("in 666"+regltnBackDays);
                                                	if( cur_uid != null || attendance.getDailyTaskStatus(sd, current_user.getEmp_code()) >= 1 || current_user.getOutvisit().equalsIgnoreCase("y") || login_user.getCalander_code().equals("SAT-THU")){ %>
	                                         			<div id="<%=(newdivid)%>" class="cen_icon" style="height:70%;" onclick="showRegularisationRequest(event, <%=daystring%> , <%=(thisdate)%> ,'Absent', <%=custVisitStatus%> );">
	                                         			<img src="resources/images/absent.gif"/>
	                                         			<!--  <div style="float:right"> -->
	                                          				<% if(custVisitStatus > 0 && custVisitStatus < 7){ %>  <i class="fa fa-2x  fa-check-square-o" style="color: blue;"><%=custVisitStatus%></i>  <%--Absent & cust visit updated for SEG, but still seg can update upto 7 --%>
	                                         				<% }else if(custVisitStatus == 7){ %>  <i class="fa fa-2x  fa-check-square-o" style="color: green;"><%=custVisitStatus%></i> <%}else{}%>
	                                         				<% if(custVisitPlannerStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: purple;float:right;padding-right:9px;"><%=custVisitPlannerStatus%></i><%} %>
	                                         				
	                                         			</div>
	                                         			
                                         			<% }else{ %>
                                                    	 <div id="<%=(newdivid)%>" class="cen_icon" onclick="showDailyTaskMsg(event, <%=daystring%>);"><img src="resources/images/absent.gif"/></div>
                                                    <%}
                                               	}else{%>                                               			
                                         			<div id="<%=(newdivid)%>" class="cen_icon"><img src="resources/images/absent.gif"/>
                                         				<% if(custVisitStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: green;"><%=custVisitStatus%></i><%}%>
                                         				<% if(custVisitPlannerStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: purple;float:right;padding-right:9px;"><%=custVisitPlannerStatus%></i><%} %>
                                         			</div>
                                         		<%}
                                           	break;
                                           case 7: // Regularization & Cust Visit Request Sent
                                          		%>
                                         			<div class="cen_icon" ><%=chkin%>&nbsp;-&nbsp;<%=chkout%><img src="resources/images/outduty.gif"/>
                                         				<% if(custVisitStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: green;"><%=custVisitStatus%></i><%}%> <%--Regularisation Reqst sent & cust visit updated for SEG --%>
                                         				<% if(custVisitPlannerStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: purple;float:right;padding-right:9px;"><%=custVisitPlannerStatus%></i><%} %>
                                         			</div>                                          
                                         		<%
                                          	 break;
                                           case 8: // Rejected Reg Rqst, late
                                          		if((theCompParam.getCurrentProcMonthStartDate().getTime()< sd.getTime()) && (getDateDiffrncForRegulrznCheck( sd.getTime())<= regltnBackDays )){  //- days gap to regularise
                                                    String swipemsg = "'"+chkin+" - "+chkout+"'";                                         
                                          			%>
                                         				<div id="<%=(newdivid)%>" class="cen_icon" style="height:70%;" onclick="showRegularisationRequest(event, <%=daystring%> , <%=(thisdate)%>, <%=swipemsg%>, <%=custVisitStatus%> );"><%=chkin%>&nbsp;-&nbsp;<%=chkout%><img src="resources/images/rejected.gif"/>
	                                         				<% if(custVisitStatus > 0 && custVisitStatus < 7){ %> <i class="fa fa-2x  fa-check-square-o" style="color: blue;"><%=custVisitStatus%></i> 
	                                         				<% }else if(custVisitStatus == 7){ %>  <i class="fa fa-2x  fa-check-square-o" style="color: green;"><%=custVisitStatus%></i> <%}else{}%>
	                                         				<% if(custVisitPlannerStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: purple;float:right;padding-right:9px;"><%=custVisitPlannerStatus%></i><%} %>
                                         				</div>
                                         			<%
                                          		}else{ %>
                                         				<div id="<%=(newdivid)%>" class="cen_icon" ><%=chkin%>&nbsp;-&nbsp;<%=chkout%><img src="resources/images/rejected.gif"/>
                                         					<% if(custVisitStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: green;"><%=custVisitStatus%></i><%}%>
                                         					<% if(custVisitPlannerStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: purple;float:right;padding-right:9px;"><%=custVisitPlannerStatus%></i><%} %>
                                         				</div>
                                         		<% }
                                           	break;
                                           case 9: // rejected request , single swipe
                                               if((theCompParam.getCurrentProcMonthStartDate().getTime()< sd.getTime()) && (getDateDiffrncForRegulrznCheck( sd.getTime())<= regltnBackDays )){  //- days gap to regularise
                                                   String swipeMsg = "'Single swipe :"+chkin+"'";
                                          		%>
                                         			<div id="<%=(newdivid)%>" class="cen_icon" style="height:70%;" onclick="showRegularisationRequest(event, <%=daystring%> , <%=(thisdate)%> , <%=swipeMsg%>, <%=custVisitStatus%> );"  ><%=chkin%>&nbsp;-&nbsp;<%=chkout%><img src="resources/images/rejected.gif"/>
                                         				<% if(custVisitStatus > 0 && custVisitStatus < 7){ %> <i class="fa fa-2x  fa-check-square-o" style="color: blue;"><%=custVisitStatus%></i> 
                                         				<% }else if(custVisitStatus == 7){ %>  <i class="fa fa-2x  fa-check-square-o" style="color: green;"><%=custVisitStatus%></i> <%}else{}%>
                                         				<% if(custVisitPlannerStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: purple;float:right;padding-right:9px;"><%=custVisitPlannerStatus%></i><%} %>
                                         			</div>
                                         		<% }else{ %>
                                         			<div id="day_<%=(thisdate)%>" class="cen_icon" ><%=chkin%>&nbsp;-&nbsp;<%=chkout%><img src="resources/images/rejected.gif"/>
                                         				<% if(custVisitStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: green;"><%=custVisitStatus%></i><%}%>
                                         				<% if(custVisitPlannerStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: purple;float:right;padding-right:9px;"><%=custVisitPlannerStatus%></i><%} %>
                                         			</div>
                                         		<% }
                                            break;
                                           case -1: // Late
                                               if((theCompParam.getCurrentProcMonthStartDate().getTime()< sd.getTime()) && (getDateDiffrncForRegulrznCheck( sd.getTime())<= regltnBackDays) ){  //- days gap to regularise
                                                    String swipemsg = "'"+chkin+" - "+chkout+"'";
                                          		%>
                                         			<div id="<%=(newdivid)%>" class="cen_icon" style="height:70%;" onclick="showRegularisationRequest(event, <%=daystring%> , <%=(thisdate)%>, <%=swipemsg%>, <%=custVisitStatus%> );"><%=chkin%>&nbsp;-&nbsp;<%=chkout%><img src="resources/images/late.gif"/>
                                         			<% if(custVisitStatus > 0 && custVisitStatus < 7){ %> <i class="fa fa-2x  fa-check-square-o" style="color: blue;"><%=custVisitStatus%></i> 
                                         			<% }else if(custVisitStatus == 7){ %>  <i class="fa fa-2x  fa-check-square-o" style="color: green;"><%=custVisitStatus%></i> <%}else{}%>
                                         			<% if(custVisitPlannerStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: purple;float:right;padding-right:9px;"><%=custVisitPlannerStatus%></i><%} %>
                                         			</div>
                                         		<% }else{ %>
                                         			<div id="<%=(newdivid)%>" class="cen_icon" ><%=chkin%>&nbsp;-&nbsp;<%=chkout%><img src="resources/images/late.gif"/>
                                         				<% if(custVisitStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: green;"><%=custVisitStatus%></i><%}%>
                                         				<% if(custVisitPlannerStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: purple;float:right;padding-right:9px;"><%=custVisitPlannerStatus%></i><%} %>
                                        			</div>
                                         		<%}  
                                           break;
                                          case 10: // Same Day
                                          		if(chkin.equalsIgnoreCase(chkout)){ // if same day date is shown only check and chckout same
                                        	  		if(custVisitStatus < 7 && current_user.getOutvisit().equalsIgnoreCase("y")){ %> 
                                         				<div id="day_<%=(thisdate)%>"  class="cen_icon" style="height:70%;" onclick="showRegularisationRequest(event, <%=daystring%> , <%=(thisdate)%> , 'Present', <%=custVisitStatus%>);"><%=chkin%>&nbsp;
                                         					<% if(custVisitStatus > 0){ %> <br/><i class="fa fa-2x  fa-check-square-o" style="color: blue;"><%=custVisitStatus%></i><%}%> <%--Same day & cust visit updated for SEG, but still seg can update upto 7 --%>
                                         					<% if(custVisitPlannerStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: purple;float:right;padding-right:9px;"><%=custVisitPlannerStatus%></i><%} %>
                                         				</div>
                                         			<% }else  if(custVisitStatus >= 7 && current_user.getOutvisit().equalsIgnoreCase("y")){ %>
                                    		 			<div id="day_done"  class="cen_icon" style="height:70%;" ><%=chkin%> &nbsp;-&nbsp;<%=chkout%>&nbsp;
                                    		    			<br/><i class="fa fa-2x  fa-check-square-o" style="color: green;"><%=custVisitStatus%></i> <%--Same dayt &  7cust visit completed for SEG, no more updates --%>
                                    		 				<% if(custVisitPlannerStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: purple;float:right;padding-right:9px;"><%=custVisitPlannerStatus%></i><%} %>
                                    		 			</div>
                                         			<%}else{ %>
                                             			<div class="cen_icon"><%=chkin%>&nbsp;
                                             				<% if(custVisitStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: green;"><%=custVisitStatus%></i><%}%>
                                         					<% if(custVisitPlannerStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: purple;float:right;padding-right:9px;"><%=custVisitPlannerStatus%></i><%} %>
                                             			</div>
                                             		<% }                                           
                                          	  } else{
                                        	  		if(custVisitStatus < 7 && current_user.getOutvisit().equalsIgnoreCase("y")){ %>
                                          		 		<div id="day_<%=(thisdate)%>"  class="cen_icon" style="height:70%;" onclick="showRegularisationRequest(event, <%=daystring%> , <%=(thisdate)%> , 'Present', <%=custVisitStatus%> );"><%=chkin%> &nbsp;-&nbsp;<%=chkout%>&nbsp;
                                          		 			<% if(custVisitStatus > 0){ %> <br/><i class="fa fa-2x  fa-check-square-o" style="color: blue;"><%=custVisitStatus%></i><%}%> <%--Same day  & cust visit updated for SEG, but still seg can update upto 7 --%>
                                          		 			<% if(custVisitPlannerStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: purple;float:right;padding-right:9px;"><%=custVisitPlannerStatus%></i><%} %>
                                          		 		</div>
                                           			<% }else  if(custVisitStatus >= 7 && current_user.getOutvisit().equalsIgnoreCase("y")){ %>
                                    		 			<div id="day_done"  class="cen_icon" style="height:70%;" ><%=chkin%> &nbsp;-&nbsp;<%=chkout%>&nbsp;
                                    		    			<br/><i class="fa fa-2x  fa-check-square-o" style="color: green;"><%=custVisitStatus%></i> <%--Same dayt &  7cust visit completed for SEG, no more updates --%>
                                    		 				<% if(custVisitPlannerStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: purple;float:right;padding-right:9px;"><%=custVisitPlannerStatus%></i><%} %>
                                    		 			</div>
                                          			<% }else{ %>
                                             	 		<div class="cen_icon"><%=chkin%> &nbsp;-&nbsp;<%=chkout%>&nbsp;</div>
                                              		<% }     
                                            	}%>                                            	
                                          	<%
                                          	break;                                        
                                          case 11: // Late
                                        	  if((theCompParam.getCurrentProcMonthStartDate().getTime()< sd.getTime()) && (getDateDiffrncForRegulrznCheck( sd.getTime())<= regltnBackDays )){  //  days gap to regularise
                                                  String swipemsg = "'"+chkin+" - "+chkout+"'";
                                       		  %>
                                       				<div id="<%=(newdivid)%>" class="cen_icon" style="height:70%;" onclick="showRegularisationRequest(event, <%=daystring%> , <%=(thisdate)%>, <%=swipemsg%> , <%=custVisitStatus%>);"><%=chkin%>&nbsp;-&nbsp;<%=chkout%><img src="resources/images/late.gif"/>                                      
                                       					<% if(custVisitStatus > 0 && custVisitStatus < 7){ %> <i class="fa fa-2x  fa-check-square-o" style="color: blue;"><%=custVisitStatus%></i> 
                                         				<% }else if(custVisitStatus == 7){ %>  <i class="fa fa-2x  fa-check-square-o" style="color: green;"><%=custVisitStatus%></i> <%}else{}%>
                                         				<% if(custVisitPlannerStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: purple;float:right;padding-right:9px;"><%=custVisitPlannerStatus%></i><%} %>
                                       				</div>
                                       		  <% }else{ %>
                                       				<div id="<%=(newdivid)%>" class="cen_icon" ><%=chkin%>&nbsp;-&nbsp;<%=chkout%><img src="resources/images/late.gif"/>
                                       					<% if(custVisitStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: green;"><%=custVisitStatus%></i><%}%>
                                       					<% if(custVisitPlannerStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: purple;float:right;padding-right:9px;"><%=custVisitPlannerStatus%></i><%} %>
                                       				</div>
                                       		 <% }
                                          	break;
                                          case 12: // Absent & rejected request                                       
                                              if((theCompParam.getCurrentProcMonthStartDate().getTime() < sd.getTime()) && (getDateDiffrncForRegulrznCheck( sd.getTime()) <= regltnBackDays )){  //- days gap to regularise    and daily task validation also   
                                                   	 //10-04-2020 -start newly added for daily task regularization only for absent cases and non seg's 
                                                   	if( cur_uid != null || attendance.getDailyTaskStatus(sd, current_user.getEmp_code()) >= 1 || current_user.getOutvisit().equalsIgnoreCase("y") || login_user.getCalander_code().equals("SAT-THU")){
                                            		 %>
	                                            		<div id="<%=(newdivid)%>" class="cen_icon" style="height:70%;" onclick="showRegularisationRequest(event, <%=daystring%> , <%=(thisdate)%> ,'Absent', <%=custVisitStatus%> );"><img src="resources/images/rejected.gif"/>
	                                             		    <%--Absent & cust visit updated for SEG, but still seg can update upto 7 --%>
	                                            			<% if(custVisitStatus > 0 && custVisitStatus < 7){ %> <i class="fa fa-2x  fa-check-square-o" style="color: blue;"><%=custVisitStatus%></i> 
                                         					<% }else if(custVisitStatus == 7){ %>  <i class="fa fa-2x  fa-check-square-o" style="color: green;"><%=custVisitStatus%></i> <%}else{}%>
                                         					<% if(custVisitPlannerStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: purple;float:right;padding-right:9px;"><%=custVisitPlannerStatus%></i><%} %>
	                                            		</div>
                                              		<% }else{  %>
                                                    	<div id="<%=(newdivid)%>" class="cen_icon" onclick="showDailyTaskMsg(event, <%=daystring%>);"><img src="resources/images/rejected.gif"/></div>
                                                	<% }
                                               }else{ %>
                                            		<div id="<%=(newdivid)%>" class="cen_icon"><img src="resources/images/rejected.gif"/>
                                            			<% if(custVisitStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: green;"><%=custVisitStatus%></i><%}%>
                                            			<% if(custVisitPlannerStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: purple;float:right;padding-right:9px;"><%=custVisitPlannerStatus%></i><%} %>
                                            		</div>
                                               <%}
                                              break;                                                                             
                                          case 13: // Businesstrip leave Request Sent
                                        		%>
                                       			<div class="cen_icon" ><%=chkin%>&nbsp;-&nbsp;<%=chkout%><img src="resources/images/bunesstrplvreq.gif"/>                                       				
                                       			</div>                                          
                                       		<%
                                        	 break;
                                         case 14: // Businesstrip leave application approved
                                      		%>
                                     			<div class="cen_icon" ><%=chkin%>&nbsp;-&nbsp;<%=chkout%><img src="resources/images/btapproved.gif"/>                                     				 
                                     			</div>                                          
                                     		<%
                                      	 break;  
                                        case 15: // Businesstrip leave application rejected
                                       		%>
                                      			<div class="cen_icon" ><%=chkin%>&nbsp;-&nbsp;<%=chkout%><img src="resources/images/businesstrpreject.gif"/>                                      				
                                      			</div>                                          
                                      		<%
                                       	 break; 
                                        case 16: // Customer Visit Planner
                                      		 if((theCompParam.getCurrentProcMonthStartDate().getTime() < sd.getTime()) && (dateDiffInDaysForCustVisitPr( sd.getTime()) < 15 ) && current_user.getOutvisit().equalsIgnoreCase("y") ){    
                                      			AllowVisitPlanner = 1;                                      			
                                      		 }else{}%>
                                           		<div id="<%=(newdivid)%>" class="cen_icon" style="height:60%;" onclick="showReminderRequest(event, <%=daystring%> , <%=(thisdate)%> ,'', <%=custVisitPlannerStatus%>,<%=AllowVisitPlanner%> );"><%=chkin%>&nbsp;
                                            		    <%--Absent & cust visit updated for SEG, but still seg can update upto 7 --%>
                                           			<% if(custVisitPlannerStatus > 0){ %> <i class="fa fa-2x  fa-check-square-o" style="color: purple;padding-top:10px;"><%=custVisitPlannerStatus%></i> 
                                       					<% }else{}%>                                         					
                                           		</div>
                                           		<div id="innerday_<%=(thisdate)%>" class="cen_icon" onclick="showRemindersForToday(event, <%=daystring%> , <%=(thisdate)%>);">                                            		  
                                           			<%if(reminderStatus > 0){ %><i class="fa fa-2x fa-clock-o"></i><%}
                                       					else{}%>                                         					
                                           		</div>
                                               <%
                                      			 break;  
                                        default:
                                               break;
                                       }
                                      %>
                                      
                                    </div>
                                      <% 
                            }
                            cnt++;
                          }
                        }
                        %>
            
                        </div>
                </div>
            <div class="status_box" style="padding-left:1em;width:537px">
            	   
                	<div class="mmyy2" style="text-align:center;width:98%">Attendance Status</div>
                    <div class="st_list" style="float-left;width: 35%;">
                    	<ul>
                        	<li><img src="resources/images/Leave.gif"/><span> Leave</span></li>
                                <li><img src="resources/images/present.gif"/><span> Present</span></li>
                                <li><img src="resources/images/ss1.gif"/><span> Single swipe</span></li>                               
                                <li><img src="resources/images/late.gif"/><span> Early/Late</span></li>
                                <li><img src="resources/images/holiday.gif"/><span> Holiday</span></li>
                                <li><img src="resources/images/absent.gif"/><span>Absent</span></li>
                                <li><img src="resources/images/regularised.gif"/><span>Regularised</span></li>                               
                                
                        </ul>
                    </div> 
                    <div class="st_list" style="float-right; width: 65%;">
                    <ul>
                         <li><img src="resources/images/outduty.gif"/><span>Regularisation req sent</span></li>
                         <li><img src="resources/images/rejected.gif"/><span>Regularisation req rejected</span></li>
                        <!--  <li><img src="resources/images/custvistplanner.gif"/><span>Customer Visit Planner</span></li> -->
                         <li><i class="fa fa-1x  fa-check-square-o" style="float: left;width: 27px; color: purple;"></i><span>Customer-Visit Planned</span></li>
                    	 <li><i class="fa fa-1x  fa-check-square-o" style="float: left;width: 27px; color: blue;"></i><span>Customer-Visit Progressing</span></li> 
                         <li><i class="fa fa-1x  fa-check-square-o" style="float: left;width: 27px; color: green;"></i><span>Customer-Visit Finished</span></li>                         
                         <li><img src="resources/images/bunesstrplvreq.gif"/><span>Business Trip req sent</span></li>
                         <li><img src="resources/images/btapproved.gif"/><span>Business Trip req approved</span></li>
                         <li><img src="resources/images/businesstrpreject.gif"/><span>Business Trip req rejected</span></li>
                    </ul>
                  </div>
                                       
            </div>
            </div>
            </div>
            
        <%-- END. The DailyTAsk Reg Validation Msg  --%>
		<div class="modal fade" id="regValidationModal" data-backdrop="static" data-keyboard="false">
		  <div class="modal-dialog"  style="width:280px !important;">
		    <div class="modal-content">
		      <!-- Modal Header -->
		      <div class="modal-header">
		        <h5 class="modal-title"></h5>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>		
		      <!-- Modal body -->
		      <div class="modal-body" style="font-size: 13px;font-family: sans-serif;"></div>
		      <!-- Modal footer -->
		      <div class="modal-footer"> <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button></div>		
		    </div>
		  </div>
		</div>
      <%-- START. The DailyTAsk Reg Validation Msg  --%>
      <%-- --%>
      	  <!-- modal -->
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
				             <textarea class="form-control" rows="1" placeholder="Enter Description..."  name="actionDesc" id="actionDesc" style="width:100%"  maxlength="200" wrap="hard" onkeypress="clearErrorMessage()" required></textarea>
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
							             <textarea class="form-control" rows="1" placeholder="Enter Project Details..."  name="genProject" id="genProject" style="width:100%"  maxlength="200" wrap="hard" onkeypress="clearErrorMessage()" required></textarea>
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
        <!-- /.modal -->
        <%-- --%>
        <div class="modal fade" id="modal-new-visitpl"  data-backdrop="static" data-keyboard="false">
          <div class="modal-dialog modal-lg"  >
            <div class="modal-content">
              <div class="modal-header">
		        <h5 class="modal-title">Customer Visit Form</h5>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
              <div class="modal-body"> 	  		 
			        <!--  Process - 1 -->
			        <div class="row" id="vst-entry-block">
			         		<div class=" col-md-12 col-xs-12" id="ferrMsg"></div>
					        <div class="col-md-12 col-xs-12 form-inline">	
					         <div class="form-group col-md-4 col-xs-12">
					         	 <label class="label-control entry-vst-flds small"><i class="fa fa-angle-down mr-1 text-info" aria-hidden="true"></i>Visit Type</label>
					              <select class="form-control select2 input-sm" style="width: 100%;" id="fvstTyp" name="vstTyp" onChange="checkVisitPlType()" required>
					                <option value="">Select</option>					                
				                    <option value="1" class="">General</option>
				                    <option value="2" class="">Follow-Up</option>
					              </select>
					         </div>
					         <div class="form-group  col-md-4 col-xs-12">
					         	 <label class="label-control entry-vst-flds small"><i class="fa fa-angle-down mr-1 text-info" aria-hidden="true"></i>Action type</label>
					              <select class="form-control select2 input-sm" style="width: 100%;" id="fvisitActn" name="visitActn"  onChange="clearErrorMessage()" required>
					                <option value="">Select</option>					                
				                    <c:forEach var="item" items="${actionTypes}">
				                    	 <option value="${item.actionType}">${item.actionType}</option>	
				                    </c:forEach>
					              </select>
					         </div>
					         <div class="form-group  col-md-4 col-xs-12" id="timeBlock" >
								 <div class="input-group  pull-center"  id="fromDiv"  >	 
								 	    <label class="label-control entry-vst-flds small"><i class="fa fa-clock-o mr-1 text-info" aria-hidden="true"></i>From</label>							  
									   <input type="text" class="form-control"  id="ffromTime" name="fromTime" value="08:00" readonly required onChange="clearErrorTimingMessage()" />									  
								</div>
								<div class="input-group  pull-center"  id="toDiv"  >
									 <label class="label-control entry-vst-flds small"><i class="fa fa-clock-o mr-1 text-info" aria-hidden="true"></i>To</label>								 
									 <input type="text" class="form-control"    id="ftoTime"  name="toTime" value="18:00"  readonly required onChange="clearErrorTimingMessage()" /> 									  
								</div>
							</div>
							<div class="form-group  col-sm-6 col-md-6 col-xs-12" style="padding-top:5px;"> 
							 <div class="input-group  pull-center"  >	 
							 <label><i class="fa fa-comments mr-1 text-info" aria-hidden="true"></i>Contact Person Name</label> 
				             <input type="text" class="form-control"    id="fcustName"  name="custNam" value=""  onkeypress="clearErrorMessage()" required/> 
				             </div>
               			    </div>     
               			   <div class="form-group  col-sm-6 col-md-6 col-xs-12" style="padding-top:5px;"> 
							<div class="input-group  pull-center"  >	 
							 <label><i class="fa fa-comments mr-1 text-info" aria-hidden="true"></i>Contact Person No.</label> 
				             <input type="text" class="form-control"    id="fcustContctNo"  name="custContctNo" value=""  onkeypress="clearErrorMessage()" required/> 
				             </div>
               			    </div> 
               			    <div class="form-group  col-sm-12 col-md-12 col-xs-12" style="padding-bottom:5px;"> 
							 <label><i class="fa fa-comments mr-1 text-info" aria-hidden="true"></i>Action Description</label> 
				             <textarea class="form-control" rows="1" placeholder="Enter Description..."  name="actionDesc" id="factionDesc" style="width:100%"  maxlength="200" wrap="hard" onkeypress="clearErrorMessage()" required></textarea>
               			    </div> 
					       </div>  		        					       
					        <div class=" col-md-12 col-xs-12">
					            <div id="fflwUpBlck">    
					            <h5> <b>Select Project From Below List (Last 12 months projects only!) </b> </h5>
					                 <div id="flUpMessage"></div>
				                	 <div id="fflUpContent"></div>				                	 
			                	</div>
			                	 <div id="fgnrlBlck"> 
				                	 <div class="form-inline" id="gnrlVstContent">  
			               			    <div class="form-group col-xs-12"> 
			               			     <label><i class="fa fa-comments mr-1 text-info" aria-hidden="true"></i>Project / Party Details</label> 
							             <textarea class="form-control" rows="1" placeholder="Enter Project Details..."  name="genProject" id="fgenProject" style="width:100%"  maxlength="200" wrap="hard" onkeypress="clearErrorMessage()" required></textarea>
			               			   </div> 
				                	 </div>
				                	 
			                	</div>
			                </div>
					    	</div>  			                
			         </div>                
              <div class="modal-footer">              
	              <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Close</button>	
	              <button type="button" id ="savepl" class="btn btn-primary pull-right">Save</button>
              </div>
            </div>
            <!-- /.modal-content -->
          </div>        
          <!-- /.modal-dialog -->         
        </div>
       
      <div class="modal fade" id="cvDetails" role="dialog" >					
		 <div class="modal-dialog" style="width:30%;">
		     <!-- Modal content-->
				<div class="modal-content"> 
					    <div class="modal-body small"> <div id="table_div"></div></div> 
						<div class="modal-footer">
						         <button type="button" class="btn btn-default pull-right" data-dismiss="modal">Close</button>
						 </div>
				</div>								     								     
		   </div>   	 		   	 
	</div>			                	 
        
    </div>
</div>    
 </body>
</html>
</c:when>
<c:otherwise>
    <html>
        <body onload="window.top.location.href='logout.jsp'">
        </body> 
    </html>
</c:otherwise>
</c:choose>