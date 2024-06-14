<%-- 
    Document   : SIP SALES PERFORMANCE DASHBAORD  
--%>
<%@include file="sipHead.jsp" %>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>

<c:set var="syrtemp" value="${selected_Year}" scope="page" />
<%
  DateFormat dateFormat1 = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
  Calendar cal1 = Calendar.getInstance();
  int curweek = cal1.get(Calendar.WEEK_OF_YEAR);
  int curriYear = cal1.get(Calendar.YEAR);  
  String currCalDtTime1= dateFormat1.format(cal.getTime());
  request.setAttribute("CURR_YR",curriYear);
  request.setAttribute("currCal", currCalDtTime);
  request.setAttribute("currWeek", curweek);
  
 %>
<!DOCTYPE html>
<html>
<head>   
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/themes/smoothness/jquery-ui.css">
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js"></script>
 <script type="text/javascript"> 
 var currYear = parseInt('${CURR_YR}');
 var slctdYear = parseInt('${syrtemp}');
 var durationFltr = (slctdYear < currYear)? 'FY' : 'YTD';
 var Million = 1000000; 
 var selectdSalesId = "${selected_salesman_code}";
 var division = "${sm_division}";
 var totLosts = 0, targeteportsList = <%=new Gson().toJson(request.getAttribute("JIHLA"))%>;
 var totJIHLostVal = 0,noResponseValue = 0;
 
  </script> 
   <style>

  
.l_left1{width:15%; float:left;padding-right:1%;} 
.l_left2{width:26%; float:left;padding-right:1%;} 
.l_right1{width:25%; float:right;padding-right:1%;padding-top:20px}
 hr{margin-top:15px;margin-bottom:10px;border:0;border-top:1px solid #eeeeee;}
   
</style>

 </head>
 <c:choose>

 <c:when test="${!empty fjtuser.emp_code and !empty fjtuser.sales_code  and fjtuser.checkValidSession eq 1}">
 <c:set var="sales_egr_code" value="${fjtuser.sales_code}" scope="page" /> 
 		        
 <body class="hold-transition skin-blue sidebar-mini">
 <div class="container">
<div class="wrapper">

  <header class="main-header" style="background-color: #367fa9;">
    <!-- Logo -->
    <a href="#" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>FJ</b>D</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>FORECAST</b></span>      
    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
        <span class="sr-only">Toggle navigation</span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </a> 
       
    </nav> 
  </header>
  <!-- Left side column. contains the logo and sidebar -->
	

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper" style="margin-left:0px;padding-top:10px; min-height: 200px;max-height: 250px;">
<!--   	<section class="content"> -->
			
  		<div class="row">
  				
  		<c:set var="rqstscount" value="0" scope="page" />  	     
  		  <c:forEach var="s_engList"  items="${SEngLst}" >	
  		   <c:set var="rqstscount" value="${rqstscount + 1}" scope="page" />	
  		 <div class="col-xs-12">
<!--   		          <form method="POST" action="SalesManForecast"> -->
                       <div class="l_one">	
                       
                       			 <div class="l_left1" style="width:25%">   
<!--                        				 <select class="form-control" name="scode" id="scode" required">											  	 -->
<%-- 												 <option value="${s_engList.salesman_code}" ${s_engList.salesman_code  == selected_salesman_code ? 'selected':''} role="${s_engList.salesman_name}"> ${s_engList.salesman_code} - ${s_engList.salesman_name}</option>											  --%>
<!-- 									 </select> -->
										<div class="n_text_narrow" id="frdt_label">S.Eng Name</div>	
										 <input type="text" class="text_area"   id="${s_engList.salesman_code}" name="s3Forecast"  value="${s_engList.salesman_name}"  disabled required="required">
								     	</div>     
	                                <div class="l_left1">
	                                	  <div class="n_text_narrow" id="frdt_label">Week No</div>	
<%-- 	                                      <input type="text" class="select_box"  id="reqDate" name="reqDate"  autocomplete="off" value="${param.dateofReq}" required="required">week --%>
	                                      <input type="text" class="text_area" id="weekNo${rqstscount}"  value="${week+1}" name="weekNo" autocomplete="off" required></input>	                
	                                </div>  
	                                 <div class="l_left1">
	                                	  <div class="n_text_narrow" id="frdt_label">LOI(S3) </div>
	                                       <input type="text" class="text_area"  onkeypress="return (event.charCode !=8 && event.charCode ==0 || (event.charCode >= 48 && event.charCode <= 57))"  id="s3forecast${rqstscount}" name="s3Forecast"  value="${s_engList.s3Forecast}"  autocomplete="off">
	                                       <input type="hidden" name="s3hidden${rqstscount}" />
	                                 </div> 
	                                 <div class="l_left1">
	                                	  <div class="n_text_narrow" id="frdt_label">Order(S4) </div>
	                                       <input type="text" class="text_area"  onkeypress="return (event.charCode !=8 && event.charCode ==0 || (event.charCode >= 48 && event.charCode <= 57))"  id="s4forecast${rqstscount}" name="s4Forecast" value="${s_engList.s4Forecast}" autocomplete="off">
	                                 </div>    
	                                 <div class="l_left1">
	                                	  <div class="n_text_narrow" id="frdt_label">Billing(S5) </div>
	                                       <input type="text" class="text_area"  onkeypress="return (event.charCode !=8 && event.charCode ==0 || (event.charCode >= 48 && event.charCode <= 57))"  id="s5forecast${rqstscount}" name="s5Forecast" value="${s_engList.s5Forecast}" autocomplete="off">
	                                </div> 
	                               <div class="l_left1" style="width:5%;padding-top:25px;">	                               
	                              	 <span id="segdiv${rqstscount}"  class=""></span>
	                              	</div>
	                                <div class="l_right1" style="width:10%">	                                	 
	                                      <input name="applybutton" type="submit" id="btnSubmit${rqstscount}" value="Update" class="sbt_btn" onClick="updateLogsticAction('${s_engList.salesman_code}','weekNo${rqstscount}','${rqstscount}');"/>
	                                </div>
	                            
	 				       </div>
	 				     
	 				        <input type="hidden" name="fjtco" value="saveSalesForecastDetails" />
<!-- 	 				    </form>  -->
	 				     
	 			</div>
	 			 
	 			</c:forEach>
	 			
                    		
                  
	 			<div class="panel panel-default  small" id="fj-page-head-box">
                     <div class="panel-heading" id="fj-page-head">
                        	<input name="applybutton" type="button" value="Back" class="sbt_btn" style="margin-top:20px" onClick="javascript:history.back();"/>  
                        	<input name="applybutton" type="button" value="Home" class="sbt_btn" style="margin-top:20px" onclick="window.location='homepage.jsp'" >
                        
                     </div>
                    
            	</div>
            	<span id="datedisplay" style="padding-left:200px"> 						             
			    </span>
	 		</div>
<!-- 	 </section> -->

		
	  <hr style="border-bottom: dotted 0.5px" />  

</div>
  <!-- /.content-wrapper -->
  <footer class="main-footer" style="margin-left:0px;">
    <div class="pull-right hidden-xs">
      <b>Version</b> 2.0.0
    </div>
    <strong>Copyright &copy;  1988 - ${CURR_YR} <a href="http://www.faisaljassim.ae/">Faisal Jassim Group</a>.</strong> All rights
    reserved.
  </footer>

  <!-- Control Sidebar -->
  <!--  <aside class="control-sidebar control-sidebar-dark">
    <!-- Create the tabs -->
  <!-- <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
      <li><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
      <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li> 
    </ul>--> 
    <!-- Tab panes 
    
  </aside>-->
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
       immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>

</div>
<!-- ./wrapper -->
</div>
<!-- jQuery 3 -->

<!-- Bootstrap 3.3.7 -->

<!-- ChartJS -->

<!-- FastClick -->
<script src="resources/bower_components/fastclick/lib/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="resources/dist/js/adminlte.min.js"></script>
<script src="resources/js/date-eu.js"></script>
<script>
var weekNumber=00;
/* On account outstandng rcvbls END */
function drawBillingStage4Graph(){
	setTimeout(  function() 
			  {google.charts.setOnLoadCallback(drawPerfomanceSummaryS4BillingYtd); }, 200); 	
}
function changeTitle(title){
	$('#jihlost-title').html(title);
}
function sm_view_details() {
	try {		
		selectElement = document.querySelector('#scode');		
	    output = selectElement.options[selectElement.selectedIndex].value;
	    salesEngName = selectElement.options[selectElement.selectedIndex].role;
	    document.getElementById("salesEngName").value =  salesEngName;
		document.getElementById("sf").submit();
		
	}catch(e){
		console.log("Error in sipChart.jsp : "+e);
	}
	
}
Date.prototype.getFirstDayOfWeek = function () {
	  var day = this.getDay() || 7;
	  return new Date(this.getFullYear(), this.getMonth(), this.getDate() + 1 - day);
	};
function getStartAndEndDate(week, year) {
    var startDate = new Date(year, 0, 1 + (week - 1) * 7);
    var endDate = new Date(year, 0, 1 + (week - 1) * 7 + 6);
  
    startDate.setDate(startDate.getDate() + (1 - startDate.getDay() + 7) % 7);
    endDate.setDate(endDate.getDate() + (7 - endDate.getDay()));
   
    // Format dates if needed
    var formattedStartDate = startDate.toISOString().split('T')[0];
    var formattedEndDate = endDate.toISOString().split('T')[0];

    return { startDate: formattedStartDate, endDate: formattedEndDate };
}
function getNextWeekDates() {
    var currentDate = new Date();
    var currentDay = currentDate.getDay();
    var daysUntilNextMonday = 1 + (7 - currentDay) % 7;

    var nextMonday = new Date(currentDate);
    nextMonday.setDate(currentDate.getDate() + daysUntilNextMonday);

    var nextSunday = new Date(nextMonday);
    nextSunday.setDate(nextMonday.getDate() + 6);

    // Calculate the week number
    var weekNumber = getWeekNumber(nextMonday);

    return {
        startDate: formatDate(nextMonday),
        endDate: formatDate(nextSunday),
        weekNumber: weekNumber
    };
}

function formatDate(date) {
    var year = date.getFullYear();
    var month = (date.getMonth() + 1).toString().padStart(2, '0');
    var day = date.getDate().toString().padStart(2, '0');
    return year + '-' + month + '-' + day;
}

function getWeekNumber(date) {
    var d = new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate()));
    d.setUTCDate(d.getUTCDate() + 4 - (d.getUTCDay() || 7));
    var startOfYear = new Date(Date.UTC(d.getUTCFullYear(), 0, 1));
    var weekNumber = Math.ceil((((d - startOfYear) / 86400000) + 1) / 7);
    return weekNumber.toString().padStart(2, '0');
}


$(document).ready(function() { 	
	var myObject = <%=new Gson().toJson(request.getAttribute("SEngLst"))%>;  
	
	var count = Object.keys(myObject).length;
	
	var nextWeekDates = getNextWeekDates();


	if (weekNumber < 10) weekNumber = "0" + weekNumber;
	
	var iyear = new Date().toLocaleDateString('en', {year: '2-digit'});
	var currweek = iyear+"-"+nextWeekDates.weekNumber;

	for(var i=1;i <= count; i++){
	document.getElementById("weekNo"+i).value = currweek;
	document.getElementById("weekNo"+i).disabled=true;
	var s3forecast = document.getElementById("s3forecast"+i);
	var s4forecast = document.getElementById("s4forecast"+i);
	var s5forecast = document.getElementById("s5forecast"+i);
	var s3forecastValue = parseFloat(s3forecast.value);
	var s4forecastValue = parseFloat(s4forecast.value);
	var s5forecastValue = parseFloat(s5forecast.value);
	
// 	if (!isNaN(s3forecastValue)) {	 
// 		s3forecast.value = s3forecastValue.toLocaleString();
// 	}if (!isNaN(s4forecastValue)) {	 
// 		s4forecast.value = s4forecastValue.toLocaleString();
// 	}if (!isNaN(s5forecastValue)) {	 
// 		s5forecast.value = s5forecastValue.toLocaleString();
// 	}
	
	}
	
   // var result = getStartAndEndDate(weekNumber, currentDate.getFullYear());
    var updateBox = document.getElementById('datedisplay');
    updateBox.innerHTML= "Week ("+moment(nextWeekDates.startDate).format("DD/MM/YYYY") +" - "+moment(nextWeekDates.endDate).format("DD/MM/YYYY")+")";
	
 });
function updateLogsticAction(segcode,weekno,rqstscount){  
	
	var yearweekNumber = $.trim(document.getElementById('weekNo'+rqstscount).value);
	var s3forecast = $.trim(document.getElementById('s3forecast'+rqstscount+'').value);
	var s4forecast = $.trim(document.getElementById('s4forecast'+rqstscount+'').value); 
	var s5forecast = $.trim(document.getElementById('s5forecast'+rqstscount+'').value);
	var divEle = document.getElementById('segdiv'+rqstscount);
	var  weekNumber = yearweekNumber.split("-")[1];
		 $.ajax({ type: 'POST', url: 'SalesManForecast', data: {fjtco: "saveSalesForecastDetails", podd0:segcode,podd1:weekNumber,podd2:s3forecast,podd3:s4forecast,podd4:s5forecast},  success: function(data) {  
			    	 $('.loader').hide();
			    	 if (parseInt(data) == 1) {				    		 
			    		  alert("Details updated successfully!.");			    		
			    		 $("#btnSubmit"+rqstscount).attr("disabled", true);
			    		 divEle.innerHTML='Updated!';
			    		  return true;
			            }else if(parseInt(data) == 0){
			            	alert("Something went wrong. Please refresh the page to see updated details");
			            	 return false;
			            }else{
			            	 alert("Details not updated,Please refresh the page!.");
			            	 return false;
			            }
			     },error:function(data,status,er) {
			    	 $('.loader').hide();
			    	 alert("Your field visit is not deleted,Please refresh the page!.");
			    	 return false;	 
			     }
			   }); 
}

$(".text_area").on('keyup', function(){
    var value = parseInt($(this).val().replace(/\D/g,''),10); 
    if (isNaN(value)) {
        alert("Please enter only numbers")
       return false;
      }   
    $(this).val(value.toLocaleString());
});
</script>
<!-- page script -->

</body>
</c:when>
<c:otherwise>

        <body onload="window.top.location.href='logout.jsp'">
   
            
        </body>
  
</c:otherwise>
</c:choose>
</html>