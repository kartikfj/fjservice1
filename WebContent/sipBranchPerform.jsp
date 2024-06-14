<%-- 
    Document   : SIP BRANCH PERFORMANCE     
--%>
<%@include file="sipHead.jsp" %>
 <c:set var="syrtemp" value="${selected_Year}" scope="page" />
<!DOCTYPE html>
<html>
<head> 
<style>
#subdivnBkng_table,#subdivnBlng_table {border: 1px solid #9C27B0; table-layout: fixed;  width: max-content; } #subdivnBkng_table  tfoot th, #subdivnBkng_table tfoot td.#subdivnBlng_table  tfoot th, #subdivnBlng_table tfoot td {padding: 5px 5px 5px 5px;}
#subdivnBkng_table tfoot th,#subdivnBkng_table tbody td,#subdivnBlng_table tbody td,#subdivnBlng_table tfoot th {padding: 5px 5px;  font-size: 90%;font-weight: bold;}
.monthly-bkngblng{color:#df1405;font-weight: normal !important;font-size: 80%;}
.monthly-bkngblng:hover{cursor: pointer;color:#131aaf;} 
</style> 
 <script type="text/javascript">
 var _url = 'SipBranchPerformance';
 var _method = "POST"; 
 var currYear = parseInt('${CURR_YR}');
 var  br = <%=new Gson().toJson(request.getAttribute("BRANCHES"))%>; 
 var blng = <%=new Gson().toJson(request.getAttribute("YTM_BLNG_AD"))%>;
 var bkng = <%=new Gson().toJson(request.getAttribute("YTM_BKNG_AD"))%>;
 var slctdYear = parseInt('${syrtemp}');
 var durationFltr = (slctdYear < currYear)? 'FY' : 'YTD';
 var Million = 1000000;  ;
 var totLosts = 0, targeteportsList = <%=new Gson().toJson(request.getAttribute("JIHLA"))%>; 
 $(document).ready(function() {  $('.select2').select2();  });  
</script> 
 
 <c:set var="year_target" value="0" scope="page" /> 
 <c:set var="actualbkng" value="0" scope="page" /> 
 <c:set var="guage_bkng_ytd_target" value="0" scope="page" /> 
  <c:set var="guage_blng_ytd_target" value="0" scope="page" /> 
 <c:forEach var="ytm_tmp1" items="${YTM_BOOK}">  
 <c:set var="year_target" value="${ytm_tmp1.yr_total_target}" scope="page" />
 <c:set var="actualbkng" value="${ytm_tmp1.ytm_actual}" scope="page" />
 <c:choose>
 	<c:when test="${syrtemp lt CURR_YR}">
 			<c:set var="guage_bkng_ytd_target" value="${ytm_tmp1.yr_total_target}" scope="page" />
 	</c:when>
 	<c:otherwise>		
  		<c:set var="guage_bkng_ytd_target" value="${ytm_tmp1.ytm_target}" scope="page" />
 	</c:otherwise>
 </c:choose>
 </c:forEach>

 
 <c:set var="year_targetbl" value="0" scope="page" />
 <c:set var="actualbl" value="0" scope="page" />
 <c:forEach var="ytm_tmp2" items="${YTM_BILL}">  
 <c:set var="year_targetbl" value="${ytm_tmp2.yr_total_target}" scope="page" /> 
 <c:set var="actualbl" value="${ytm_tmp2.ytm_actual}" scope="page" />

   <c:choose>
 	<c:when test="${syrtemp lt CURR_YR}">
 		  <c:set var="guage_blng_ytd_target" value="${ytm_tmp2.yr_total_target}" scope="page" /> 
 	</c:when>
 	<c:otherwise>		
  		  <c:set var="guage_blng_ytd_target" value="${ytm_tmp2.ytm_target}" scope="page" /> 
 	</c:otherwise>
 </c:choose>
 </c:forEach>
 <script type="text/javascript"> 
 google.charts.load('current', {'packages':['corechart', 'gauge','table']});
 <c:if test="${JIHV ne null}">google.charts.setOnLoadCallback(drawJobInHandVolume); </c:if>
 //google.charts.setOnLoadCallback(drawPerfomanceSummaryBookingYtd);
 //google.charts.setOnLoadCallback(drawPerfomanceSummaryBillingYtd); 
 google.charts.setOnLoadCallback(function() { drawGuageGraph(${actualbkng},${guage_bkng_ytd_target}, 'guage_booking', 'Booking');});
 google.charts.setOnLoadCallback(function() { drawGuageGraph(${actualbl}, ${guage_blng_ytd_target}, 'guage_billing', 'Billing');});
 //google.charts.setOnLoadCallback(drawCustomerVisitPerfomanceSummary);
 function drawJobInHandVolume() { 
		var data = new google.visualization.DataTable();
	 	data.addColumn('string', 'Topping'); data.addColumn('number', 'Amount'); 
	 	data.addColumn({type:'number', role:'annotation'});
	 	data.addColumn({type:'string', role: 'style' });
	 	data.addRows([ <c:forEach var="JOBV" items="${JIHV}"> ['${JOBV.duration}', ${JOBV.amount},<fmt:formatNumber type='number' pattern='###.##' value='${JOBV.amount/1000000}' />,'#01b8aa'],  </c:forEach> ]);
	 	var options = {	
					'title':'Job in hand volume for Last 2 Years from <%=iYear%> - (AED)', 
					 titleTextStyle: {color: '#000',fontSize: 13, fontName: 'Arial',   bold: true},
			   		'vAxis': {title: 'Amount (In Millions)',titleTextStyle: {italic: false},format: 'short'}, 
				    'legend':'none', 'chartArea': { top: 70, right: 12,  bottom: 48, left: 60,  height: '100%', width: '100%'  },
				    'height':240 
				   };
	 	var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
	 	chart.draw(data, options);
	 	google.visualization.events.addListener(chart, 'onmouseover', function () { uselessHandlerMhvr('#chart_div');} );
	 	google.visualization.events.addListener(chart, 'onmouseout',  function () { uselessHandlerMout('#chart_div');} );
	 	google.visualization.events.addListener(chart, 'select', function () { selectBranchHandlerBarGraph('jih', chart, data, 'Job In Hand Volume', '#jihv-modal-graph', 'aging_dt', `${selected_segs}`, 'jihvexport', '${syrtemp}','SipBranchPerformance',`${selected_company_code}`);}); 
	 }
 
 
 
 function drawPerfomanceSummaryBookingYtd() {  
	 var bookings = <%=new Gson().toJson(request.getAttribute("YTM_BOOK"))%>;  
	 if(typeof bookings === 'undefined' || bookings.length == 0){
		 bookings = [
		 {   yr_total_target: "0", ytm_actual: "0", ytm_target: "0", monthly_target: "0", 
		   jan: "0", feb: "0", mar: "0", apr: "0", may: "0", jun: "0", jul: "0", aug: "0",  sep: "0", oct: "0", nov: "0",
		    dec: "0" 
		    } ];
	    } 
	 
  var data = google.visualization.arrayToDataTable(getSalesGraphBB(bookings, '${MTH}'));
          // Set chart options
          var options = {
						  'title':'Booking - Target Vs Actual - ${syrtemp}, ('+durationFltr+'). \r\n Total Yearly Target : <c:forEach var="ytm_tmp" items="${YTM_BOOK}"> <fmt:formatNumber type="number"   value="${ytm_tmp.yr_total_target}"/></c:forEach> ',
						  'vAxis': {title: 'Amount (In Millions)',titleTextStyle: {italic: false},format: 'short'},
		                  'is3D':true,
		                   titleTextStyle: {
		        		      color: '#000',
		        		      fontSize: 13,
		        		      fontName: 'Arial',
		        		      bold: true
		        		   },
		                   'chartArea': {
						        top: 70,
						        right: 12,
						        bottom: 48,
						        left: 60,
						        height: '100%',
						        width: '100%'
						      },
						     
						      'height': 240,
						      'legend': {
						        position: 'top'
						      },
						      colors: ['#607d8b', '#a26540'],
						      hAxis: { slantedText:true, slantedTextAngle:90 }
                        
                         };
          

          // Instantiate and draw our chart, passing in some options.
          var chart = new google.visualization.ColumnChart(document.getElementById('prf_summ_booking_ytd'));
          chart.draw(data, options);
          google.visualization.events.addListener(chart, 'onmouseover', function () { uselessHandlerMhvr('#chart_div');} );
          google.visualization.events.addListener(chart, 'onmouseout',  function () { uselessHandlerMout('#chart_div');} );
          google.visualization.events.addListener(chart, 'select', function () { selectBranchHandlerBarGraph('booking', chart, data, 'Booking', '#booking-modal-graph', 'bkm_dt', `${selected_segs}`, 'booking-xcl', '${syrtemp}','SipBranchPerformance',`${selected_company_code}`);});

        }
 

 function drawPerfomanceSummaryBillingYtd() {
	 var billing = <%=new Gson().toJson(request.getAttribute("YTM_BILL"))%>;  
	 if(typeof billing === 'undefined' || billing.length == 0){
		 billing = [
		 {   yr_total_target: "0", ytm_actual: "0", ytm_target: "0", monthly_target: "0", 
		   jan: "0", feb: "0", mar: "0", apr: "0", may: "0", jun: "0", jul: "0", aug: "0",  sep: "0", oct: "0", nov: "0",
		    dec: "0" 
		    } ];
	    } 
	 var data = google.visualization.arrayToDataTable(getSalesGraphBB(billing, '${MTH}'));
     // Set chart options
     var options = {'title':'Billing - Target Vs Actual - ${syrtemp}, ('+durationFltr+'). \r\n Total Yearly  Billing Target : <c:forEach var="ytm_tmp" items="${YTM_BILL}"> <fmt:formatNumber type="number"   value="${ytm_tmp.yr_total_target}" /></c:forEach>  ',	
   		  'vAxis': {title: 'Amount (In Millions)',titleTextStyle: {italic: false},format: 'short'}, 
   		
   		         'is3D':true,
   		         titleTextStyle: {
   				      color: '#000',
   				      fontSize: 13,
   				      fontName: 'Arial',
   				      bold: true
   				   },
   		         'chartArea': {
					        top: 70,
					        right: 12,
					        bottom: 48,
					        left: 60,
					        height: '100%',
					        width: '100%'
					      },
					
					      'height': 240,
					      'legend': {
					        position: 'top'
					      },
					      colors: ['#f39c12', 'green'],
					      hAxis: { slantedText:true, slantedTextAngle:90 }
	  };
     

     // Instantiate and draw our chart, passing in some options.
     var chart = new google.visualization.ColumnChart(document.getElementById('prf_summ_billing_ytd'));
     chart.draw(data, options);
     google.visualization.events.addListener(chart, 'onmouseover', function () { uselessHandlerMhvr('#chart_div');} );
     google.visualization.events.addListener(chart, 'onmouseout',  function () { uselessHandlerMout('#chart_div');} );
     google.visualization.events.addListener(chart, 'select', function () { selectBranchHandlerBarGraph('billing', chart, data, 'Billing', '#billing-modal-graph', 'blm_dt', `${selected_segs}`, 'blng_main', '${syrtemp}','SipBranchPerformance',`${selected_company_code}`);});

   }
    

      
      //////
      //CUSTOME VISIT PERFORMANCE START
  function drawCustomerVisitPerfomanceSummary() {
	  var totalVisitCounts = 0;
	  var visits = <%=new Gson().toJson(request.getAttribute("SEYRLYCVS"))%>;  
	  var moreInfoDtls = "<table id='cvMoreInfo' ><thead><th>Month</th><th>Visit Count</th></thead><tboady>"
	  var arr = [];
	  arr[0] =  ['Month', 'Total Visits'];
	  var currentMonth= parseInt('${MTH}'); 
	  var strMth = 0; 
	  for(strMth = 1; strMth <= currentMonth; strMth++){
		     var monthName = getCustomeMonth(strMth);
	    	 var totVisits = visits.find( item =>  item.day === strMth);  
	    	 if(typeof totVisits === 'undefined'){
	    		 arr[strMth]=[monthName,0];
	    		 moreInfoDtls += "<tr><td>"+monthName+"</td><td>0</td></tr>";
	    	 }else{
	    		 totalVisitCounts += parseInt(totVisits['visitCount']);
	    		 arr[strMth]=[monthName, totVisits['visitCount']];
	    		 moreInfoDtls += "<tr><td>"+monthName+"</td><td>"+totVisits['visitCount']+"</td></tr>";
	    	 }
	    	 
	     } 
	  moreInfoDtls += "</tboady></table>"
		  $("#cvMoreInfoModal .modal-body").html(moreInfoDtls); 
     // Create the data table.
    cVdata = google.visualization.arrayToDataTable(arr);

     // Set chart options
     var options = {'title':'Customer Visit Analysys - ${syrtemp}, ('+durationFltr+') \r\n Total Visit Counts -'+totalVisitCounts+'',	
   		  'vAxis': {title: 'Visit Counts',titleTextStyle: {italic: false},format: 'short'}, 
   		
   		   'is3D':true,
		         titleTextStyle: {
				      color: '#000',
				      fontSize: 13,
				      fontName: 'Arial',
				      bold: true
				   },
		         'chartArea': {
				        top: 70,
				        right: 12,
				        bottom: 48,
				        left: 60,
				        height: '100%',
				        width: '100%'
				      },
				
				      'height': 240,
				      'legend': {
				        position: 'top'
				      },
				      colors: ['#ffeb3b'],
				      hAxis: { slantedText:true, slantedTextAngle:90 }
	  };
     

     // Instantiate and draw our chart, passing in some options.
     cvChart = new google.visualization.ColumnChart(document.getElementById('cv_pfm_ytd'));
     cvChart.draw(cVdata, options);
     google.visualization.events.addListener(cvChart, 'onmouseover', uselessHandlerCv1);
     google.visualization.events.addListener(cvChart, 'onmouseout', uselessHandlerCv2);
     google.visualization.events.addListener(cvChart, 'select', selectHandlerCv);
     
     $('#cvMoreInfo').DataTable( {
	        dom: 'Bfrtip', 
	        "bSort" : false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
	                filename: "${selected_salesman_code} - Customer Visit Details ${syrtemp}",
	                title:"${selected_salesman_code} - Customer Visit Details ${syrtemp}",
	                messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	          
	           
	        ]
	    } );
     
   }
  function uselessHandlerCv1() {$('#cv_pfm_ytd').css('cursor','pointer')}
  function uselessHandlerCv2() {$('#cv_pfm_ytd').css('cursor','default')}
  function selectHandlerCv() { 
   var selection = cvChart.getSelection();
   var message = '';
   for (var i = 0; i < selection.length; i++) {
   var item = selection[i];
   if (item.row != null && item.column != null) {
   var str = cVdata.getFormattedValue(item.row, 1); // var str = data.getFormattedValue(item.row, item.column);
   var aging = cVdata.getValue(cvChart.getSelection()[0].row, 0)      
     }
   }
   
   //alert('You selected ' + aging+" "+str);
   
   var ttl="<b>Customer Visit Details of   </b><strong style='color:blue;'>${selected_company_code}</strong> for  <strong style='color:blue;'>"+aging+" - ${syrtemp}</strong>";
   var exclTtl="Customer Visit Details of   ${selected_company_code}  for   "+aging+" - ${syrtemp} ";
   var month = moment().month(aging).format("M");
   $("#cv-modal-graph .modal-title").html(ttl);

 $.ajax({
  		 type: 'POST',
      	 url: 'SipBranchPerformance', 
      	 data: {fjtco: "cvDoSegfcYrmth", secodes:`${selected_segs}` , cvMth:month, cvYr:"${syrtemp}"},
      	 dataType: "json",
	  		 success: function(data) {
	  		
	  		
	  			var output="<table id='cvDtlsTable' class='table table-bordered small'><thead><tr>"+
	  			"<th>#</th><th>SEg. Code</th><th>SEg. Name</th><th>Doc. ID</th><th>Visit Date</th><th>Visit Type</th><th>Visit Desc.</th><th>Projct/Party</th><th>Customer Name</th><th>Customer Contact No.</th>"+
	  			 "<th>Visit Time</th><th>Total Time Spent (Hrs)</th>"+
			      "</tr></thead><tbody>";
				  var j=0;
			      for (var i in data)
				 {
			    	  j=j+1;

				 output+="<tr><td>"+j+"</td><td>" +  $.trim(data[i].segCode) + "</td><td>" +  $.trim(data[i].smName) + "</td><td>" +  $.trim(data[i].documentId) + "</td>"+
				 "<td>" +  $.trim(data[i].visitDate.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+
				 "<td>" +  $.trim(data[i].actionType) + "</td><td>" +  $.trim(data[i].actnDesc) + "</td>"+
				"<td>" +  $.trim(data[i].project) + "</td><td>" +  $.trim(data[i].customerName) + "</td><td>" +  $.trim(data[i].customerContactNo) + "</td><td>"+ $.trim(data[i].fromTime)+"-"+$.trim(data[i].toTime)+"</td>"+
				 "<td>" +  calTotVisitTimeFAsst($.trim(data[i].fromTime), $.trim(data[i].toTime)) + "</td>"+
				 "</tr>";
				 } 
				 output+="</tbody></table>";
				
	  			  $("#cv-modal-graph .modal-body").html(output);
	  			$("#cv-modal-graph").modal("show");
	  		 $('#cvDtlsTable').DataTable( {
		        dom: 'Bfrtip', 
		        "columnDefs" : [{"targets": 2, "type":"date-eu"}],
		        buttons: [
		            {
		                extend: 'excelHtml5',
		                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
		                filename: exclTtl,
		                title:exclTtl,
		                messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'
		                
		                
		            }
		          
		           
		        ]
		    } );
	  			
	  },
	  error:function(data,status,er) {
		 
	    alert("please click again.");
	   }
	 });
  
 //start  script for deselect column - on modal close
 cvChart.setSelection([{'row': null, 'column': null}]); 
//end  script for deselect column - on modal close
  }
 
 function getCurrentMonth(){
	 return moment(new Date()).format("MMM");
 }
 function getCustomeMonth(value){
	 return moment().month(parseInt(value)-1).format("MMM");
 }
 function getVisitCounts(projects, currentMonth){
	 var result;
	  for(strMth = 1; strMth <= currentMonth; strMth++){
	    	 var totVisits = projects.find(obj => {
	    		   return (obj.month == strMth)?  obj.totalVisits : 0;
	    		});
	    	 result +=[getCustomeMonth(strMth),totVisits]+",";
	     }
	  return result;
 }
 function calTotVisitTimeFAsst(startTime, endTime){ 
	   var chckIn = moment(startTime, "H:mm:ss");
	   var chckOut = moment(endTime, "H:mm:ss");
	   var totalVisitTime = parseInt(moment.duration(chckOut.diff(chckIn)).asMinutes());
       var hourMnt = Math.floor(totalVisitTime / 60) +"."+(totalVisitTime % 60); 
	   return hourMnt;
}
 //CVIST PERORMANCE END 
 function show2ndLayerQtnLost(agingHeader,agingVal) {  
	 $('#laoding').show();
	 var ttl="<b>JIH Quotation Lost Details of  ${selected_company_code} for "+agingHeader+" </b> ";
	 var exclTtl="JIH Quotation Lost Details of ${selected_company_code}  for "+agingHeader+"";
	 $("#qtn_lost_modal-main .modal-title").html(ttl); $.ajax({ type: 'POST',url: 'SipBranchPerformance',  data: {fjtco: "tsolhij", agng:agingVal , secodes:`${selected_segs}`, compCode:`${selected_company_code}`}, dataType: "json",
	 success: function(data) {
		
		 $('#laoding').hide();
		
		 var output="<table id='qtnlost' class='table table-bordered small'><thead><tr>"+ "<th>#</th><th>Week</th><th>Company</th><th>Qtn-Date</th><th>Qtn-Code</th><th>Qtn Number</th>"+
	 "<th>Customer Code</th><th>Customer Name</th><th>Sales Egr: Code</th><th>Sales Egr: Name</th>"+ " <th>Project Name</th><th>Consultant</th><th>Invoicing Year</th><th>Product Type</th>  <th>Product Classfctn</th><th>Zone</th><th>Profit (%)</th><th>Qtn Amount</th><th>Qtn Status</th><th>Lost Type</th><th>Lost Remark</th></tr></thead><tbody>";
	 
	 var j=0; for (var i in data) { j=j+1;
	 
	 output+="<tr><td>"+j+"</td><td>" + data[i].d2 + "</td>"+"<td>" + data[i].d1 + "</td><td>" + $.trim(data[i].d3.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+ "<td>" + data[i].d4 + "</td><td>" + data[i].d5 + "</td>"+
	 "<td>" + data[i].d6 + "</td><td>" + data[i].d7 + "</td>"+ "<td>" + data[i].d8 + "</td><td>" + data[i].d9 + "</td>"+ "<td>" + data[i].d10 + "</td><td>" + data[i].d11 + "</td>"+
	 "<td>" +$.trim(data[i].d12.substring(0, 10)).split("-").reverse().join("/") + "</td><td>" + data[i].d13 + "</td>"+ "<td>" + data[i].d14 + "</td><td>" + data[i].d15 + "</td><td>"
	 + data[i].d16 + "</td><td>" + data[i].d17 + "</td><td><small class='label label-danger'><i class='fa fa-clock-o'></i> Lost</small></td><td>" + data[i].d19 + "</td><td>" + data[i].d20 + "</td></tr>";
	 } 
	 output+="</tbody></table>";
	 

	 $("#qtn_lost_modal-main .modal-body").html(output);$("#qtn_lost_modal-main").modal("show");	
	 
		    $('#qtnlost').DataTable( {
		        dom: 'Bfrtip',   
		        "columnDefs" : [{"targets":[3, 12], "type":"date-eu"}],
		        buttons: [
		            {
		                extend: 'excelHtml5',
		                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
		                filename: exclTtl,
		                title: exclTtl,
		                messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'
		                
		                
		            }
		          
		           
		        ]
		    } );
		},error:function(data,status,er) {$('#laoding').hide();  alert("please click again");}});
	 
	 }    
    </script>


 </head>
 <c:choose>
 <c:when test="${!empty fjtuser.emp_code and !empty fjtuser.sales_code and (fjtuser.role eq 'mg' or fjtuser.salesDMYn ge 1 ) and fjtuser.checkValidSession eq 1}">
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
      <span class="logo-lg"><b>Dashboard</b></span>
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
  <aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
 

      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu" data-widget="tree">
      <c:if test="${fjtuser.role eq 'mg' or fjtuser.role eq 'gm'}">
      		 <li   class="active"><a href="SipBranchPerformance"><i class="fa fa-building-o"></i><span>Branch Performance</span></a></li>
      </c:if>
             <li><a href="DmInfo.jsp"><i class="fa fa-dashboard"></i><span>Sales Engineers Performance</span></a></li>
             <c:if test="${isAllowed eq 'Yes' || fjtuser.salesDMYn ge 1}">
      		 		<li><a href="SalesManagerInfo.jsp"><i class="fa fa-building-o"></i><span>Sales Manager Performance</span></a></li>
      		</c:if>
             <li><a href="DisionInfo.jsp"><i class="fa fa-line-chart"></i><span>Sub Division Performance</span></a></li>
             <li ><a href="CompanyInfo.jsp"><i class="fa fa-pie-chart"></i><span>Division Performance</span></a></li>
             <li><a href="SipUserActivity"><i class="fa fa-table"></i><span>SE Activity History</span></a></li>
<!--              <li><a href="SipJihDues"><i class="fa fa-table"></i><span>JIH Dues</span></a></li>   -->
<!--              <li><a href="SipLOIDues"><i class="fa fa-table"></i><span>LOI Dues</span></a></li>  -->
             <li><a href="SipStageFollowUpController"><i class="fa fa-database"></i><span>Stage Follow-Up</span></a></li>
             <li><a href="sipWeeklyReport"><i class="fa fa-bar-chart"></i><span>Weekly-Sales Report</span></a></li>
         
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper" style="margin-top: -8px;">
    <!-- Content Header (Page header) --> 

    <!-- Main content -->
    <div class="row">
    <div class="col-md-12 form-group">
  <form class="form-inline" method="post" action="SipBranchPerformance"> 
  <br/>
  <c:set var="company" value="${selected_company_code}" scope="page" /> 
  <select class="form-control form-control-sm select2" name="scompany" id="scompany" required>    
  <option value="" >Select Branch</option> 
   	<c:forEach var="branch"  items="${BRANCHES}" >	     					  				
			<option value="${branch.companyCode}" ${branch.companyCode  == selected_company_code ? 'selected':''}>${branch.companyCode}</option>	  		 
  	</c:forEach> 						
	</select>
						
						  <select class="form-control form-control-sm  select2" name="syear" id="syear">
  						<option selected value="<%=iYear%>">Select Year</option>
  						
   						 <%
                        // start year and end year in combo box to change year in calendar
                         for(int iy=iYear;iy>=2018;iy--)
                            {
                            
                             %>
                             <c:set var="syrtemp1" value="<%=iy%>" scope="page" />
                             <option value="<%=iy%>" ${syrtemp1  == selected_Year ? 'selected':''}> <%=iy%></option>
                            <%
                             
                        }
                        %>
						</select>
						
					 <input type="hidden" name="fjtco" value="salesChart" />
   					<button type="submit" id="sf" class="btn btn-sm btn-primary" onclick="preLoader();">View</button>			
				</form> 
				 </div> 
   </div>
    

	   
	   <div class="row">
        <div class="col-md-6">
       
       <!-- JIH CHART START --> 
         <div class="box box-primary" style="margin-bottom: 8px;border-color:#607d8b;">
                      <div class="box-header with-border">						 
						 <h3 class="box-title" id="jihlost-title">Job In Hand Volume Details  </h3>                                          
                  <ul class="nav nav-tabs pull-right" id="jihlostdiv" style=" margin-top: -10px;font-weight: bold;">
         <li  class="active pull-right" onclick="changeTitle('Job In Hand Volume Details');"><a data-toggle="tab" href="#jih-dt"  style="border-right:transparent;" ><i class="fa fa-square text-green"> JIHV</i></a></li>
          <li class="pull-right"  onclick="changeTitle('JIH (All) Vs LOST DETAILS');"><a data-toggle="tab" href="#lost-dt" ><i class="fa fa-square text-red"> LOST</i></a></li>                   
          </ul>
          </div>
              <div class="box-body" id="jihv_box_body">              
         <div class="nav-tabs-custom" style="    box-shadow: none;">              
           <div class="tab-content" style="margin-top: -15px;">
           <div id="jih-dt" class="tab-pane fade  in active" >
              <div class="chart">              
                 <div id="chart_div"></div> 
                 <div class="overlay">
				 <a href="#" data-toggle="modal" data-target="#jihv_moreinfo_modal">More info<i class="fa fa-arrow-circle-right"></i></a> 
				 </div>				
              </div>
                  </div>
    <div id="lost-dt" class="tab-pane fade" >
    		<div class="chart">
											<div id="jihv" style="margin-top: 0px; height: 200px;">
												<table>
													<c:forEach var="JOBVL" items="${JIHVLOST}">
														<tr>
															<th></th>
															<th></th>
															<th><i class=" fa fa-cloud-download"
																aria-hidden="true"
																onclick="show2ndLayerQtnLost('0-3 Months','0')"
																style="color: #3c8dbc; cursor: pointer;">&nbsp;0-3
																	Months</i></th>
															<th><i class=" fa fa-cloud-download"
																aria-hidden="true"
																onclick="show2ndLayerQtnLost('3-6 Months','1')"
																style="color: #3c8dbc; cursor: pointer;">&nbsp;3-6
																	Months</i></th>
															<th><i class=" fa fa-cloud-download"
																aria-hidden="true"
																onclick="show2ndLayerQtnLost('>6 Months','2')"
																style="color: #3c8dbc; cursor: pointer;">&nbsp;>6
																	Months</i></th>
														</tr>
														<tr>
															<th rowspan="2" style="color: #00a65a;">JIH</th>
															<td style="color: #00a65a;">COUNT</td>
															<td style="color: #00a65a;">${JOBVL.aging1_count_actual}</td>
															<td style="color: #00a65a;">${JOBVL.aging2_count_actual}</td>
															<td style="color: #00a65a;">${JOBVL.aging3_count_actual}
															</td>
														</tr>
														<tr>
															<td style="color: #00a65a;">VALUE</td>
															<td><span class="description-percentage text-green"><i
																	class="fa fa-caret-up"></i> <fmt:formatNumber
																		type="number" pattern="###.##"
																		value="${JOBVL.aging1_amt_actual/1000000}" />M</span></td>
															<td><span class="description-percentage text-green"><i
																	class="fa fa-caret-up"></i> <fmt:formatNumber
																		type="number" pattern="###.##"
																		value="${JOBVL.aging2_amt_actual/1000000}" />M</span></td>
															<td><span class="description-percentage text-green"><i
																	class="fa fa-caret-up"></i> <fmt:formatNumber
																		type="number" pattern="###.##"
																		value="${JOBVL.aging3_amt_actual/1000000}" />M</span>
																		
																		</td>
														</tr>
														<tr>
															<th rowspan="2" style="color: #dd4b39;">LOST</th>
															<td style="color: #dd4b39;">COUNT</td>
															<td style="color: #dd4b39;">
																${JOBVL.aging1_count_lost}</td>
															<td style="color: #dd4b39;">${JOBVL.aging2_count_lost}</td>
															<td style="color: #dd4b39;">${JOBVL.aging3_count_lost}</td>
														</tr>
														<tr>
															<td style="color: #dd4b39;">VALUE</td>
															<td><span class="description-percentage text-red"><i
																	class="fa fa-caret-down"></i> <fmt:formatNumber
																		type="number" pattern="#,###.##"
																		value="${JOBVL.aging1_amt_lost/1000000}" />M</span></td>
															<td><span class="description-percentage text-red"><i
																	class="fa fa-caret-down"></i> <fmt:formatNumber
																		type="number" pattern="#,###.##"
																		value="${JOBVL.aging2_amt_lost/1000000}" />M</span></td>
															<td><span class="description-percentage text-red"><i
																	class="fa fa-caret-down"></i> <fmt:formatNumber
																		type="number" pattern="#,###.##"
																		value="${JOBVL.aging3_amt_lost/1000000}" />M</span></td>
														</tr>
													</c:forEach>
												</table>

											</div>

											<div class="overlay">
												<a href="#" data-toggle="modal" data-target="#lost_moreinfo_modal">More
													info <i class="fa fa-arrow-circle-right"></i>
												</a>
											</div>
										</div>
    </div>
            </div>
            </div></div>
          
         </div>  
       <!-- JIH CHART END -->

      <!--     Booking CHART START   
        <div class="box box-danger" style="margin-bottom: 8px;border-color:#607d8b;">
           <div class="box-header with-border">
			<h3 class="box-title" >Booking Target Vs Actual Booking </h3>
			<div class="help-right-lost" id="help-bkngvsblng">
			<i class="fa fa-info-circle pull-left"></i>
			</div>
			</div>
            <div class="box-body">
              <div id="prf_summ_booking_ytd" style="height:230px;margin-top:-10px;"></div>  <br/>
               <div class="overlay">
				<a href="#" data-toggle="modal" data-target="#booking_moreinfo_modal">More info
				 <i class="fa fa-arrow-circle-right"></i></a> </div>
            </div>
            /.box-body
          </div>
          Booking CHART START    -->
          <!-- CUST VIST SUM START -->
  <!--          <div class="box box-danger" style="margin-bottom: 8px;border-color:#607d8b;">  
            <div class="box-body">
                <div class="chart">
                    <div id="cv_pfm_ytd" style="height:230px;margin-top:-10px;"></div>  <br/>
               <div class="overlay">
				<a href="#" data-toggle="modal" data-target="#cvMoreInfoModal">More info
				 <i class="fa fa-arrow-circle-right"></i></a> </div> 
              </div> 
            </div>
            /.box-body
          </div> -->
          <!-- CUST VIST SUM END -->
          
        </div>
        
        <!-- /.col (LEFT) -->
        
        <div class="col-md-6"> 
        
         <!-- BOOKING BILLING GUAGE START --> 
            
        <div class="box box-primary" style="    margin-left: -10px;margin-bottom: 8px;min-height:280px !important;border-color:#607d8b;">
           <div class="box-header with-border">
			<h3 class="box-title" >Target Vs Actual  Achieved  %  for  ${syrtemp} - <c:choose>
		 	<c:when test="${syrtemp lt CURR_YR}">
		 		  (FY)
		 	</c:when>
		 	<c:otherwise>		
		  		  (YTD)
		 	</c:otherwise>
 		</c:choose></h3> 
 		<h6>YTD Booking Target : <fmt:formatNumber type="number"   value="${guage_bkng_ytd_target}"/>   || YTD Billing Target : <fmt:formatNumber type="number"   value="${guage_blng_ytd_target}"/> </h6>
 		<h6>YTD Booking Actual : <fmt:formatNumber type="number"   value="${actualbkng}"/>   || YTD Billing Actual : <fmt:formatNumber type="number"   value="${actualbl}"/>  </h6> 
			</div>
            <div class="box-body"> 
               <div class="row">
	   			 <div class="col-lg-1 col-xs-0" ></div>
	   			 
	   			 <div class="col-lg-5 col-xs-6  sep" ><div id="guage_booking" style="border: 1px solid #607d8b; border-radius:5px;"></div> </div>
	   		
       	          <div class="col-lg-5 col-xs-6"> <div id="guage_billing" style="border: 1px solid #607d8b; border-radius:5px;"></div>
		          </div><div class="col-lg-1 col-xs-0" ></div>
		          </div>
            </div>
            <!-- /.box-body -->
          </div> 
         <!-- BOOKING BILLING GUAGE END -->
    <!--      BILLING CHART START
          <div class="box box-success" style="margin-bottom: 8px;border-color:#607d8b;right:10px;">
               <div class="box-header with-border">  
               <h3 class="box-title" id="blng-graph-title">Billing Target  Vs Actual Billing</h3>
              
               </div>
           <div class="box-body" id="blng_box_body">
           <div id="blngs-dt" class="tab-pane fade  in active" >
              <div class="chart">
                <div id="prf_summ_billing_ytd" style="height:230px;margin-top:-10px;"></div> 
                 <br/>
               <div class="overlay">
				<a href="#" data-toggle="modal" data-target="#billing_moreinfo_modal">More info
				 <i class="fa fa-arrow-circle-right"></i></a> </div> 
              </div>
            </div>
            </div>
            /.box-body
          </div>
         BILLING CHART START  -->

        </div>
        <!-- /.col (RIGHT) -->
        
        
                    <div class="col-md-12 col-sm-12">
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">Sub-Division Level Billing Summary  Whole year</span> </h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
              </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body">   
                <table id="subdivnBlng_table" class="table table-bordered table-striped small">
                  <thead>
                  <tr> <th>Division</th>
                    <th>Jan</th> <th>Feb</th> <th>Mar</th> <th>Apr</th> <th>May</th>  <th>Jun</th> <th>Jul</th>
					<th>Aug</th> <th>Sep</th> <th>Oct</th> <th>Nov</th> <th>Dec</th>  <th>Total</th>
                  </tr>
                  </thead>
                  <tbody>
                  </tbody>          
                <tfoot align="right">
		          <tr>
		          <th style="text-align:right;color:blue;">Total:</th><th style="text-align:right;font-size:90%;"></th>
		          <th style="text-align:right;font-size:90%;"></th><th style="text-align:right;font-size:90%;"></th>
		          <th style="text-align:right;font-size:90%;"></th><th style="text-align:right;font-size:90%;"></th>
		          <th style="text-align:right;font-size:90%;"></th><th style="text-align:right;font-size:90%;"></th>
		          <th style="text-align:right;font-size:90%;"></th><th style="text-align:right;font-size:90%;"></th>
		          <th style="text-align:right;font-size:90%;"></th><th style="text-align:right;font-size:90%;"></th>
		          <th style="text-align:right;font-size:90%;"></th><th style="text-align:right;font-size:90%;"></th>
		          </tr>
	            </tfoot>              
                </table>
              
            </div>
            <!-- /.box-body -->
           
           
          </div>
          <!-- /.box -->
        </div>
        
        
         <div class="col-md-12 col-sm-12">
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">Sub-Division Level Booking Summary  Whole year</span> </h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
              </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
            
            
                <table id="subdivnBkng_table" class="table table-bordered table-striped small">
                  <thead>
                  <tr>
                    
                    <th>Division</th>
                    <th>Jan</th> <th>Feb</th> <th>Mar</th> <th>Apr</th> <th>May</th>  <th>Jun</th> <th>Jul</th>
					<th>Aug</th> <th>Sep</th> <th>Oct</th> <th>Nov</th> <th>Dec</th>  <th>Total</th>
                  </tr>
                  </thead>
                  <tbody></tbody> 
               
                <tfoot align="right">
		          <tr>
		          <th style="text-align:right;color:blue;">Total:</th><th style="text-align:right;font-size:80%;"></th>
		          <th style="text-align:right;font-size:80%;"></th><th style="text-align:right;font-size:80%;"></th>
		          <th style="text-align:right;font-size:80%;"></th><th style="text-align:right;font-size:80%;"></th>
		          <th style="text-align:right;font-size:80%;"></th><th style="text-align:right;font-size:80%;"></th>
		          <th style="text-align:right;font-size:80%;"></th><th style="text-align:right;font-size:80%;"></th>
		          <th style="text-align:right;font-size:80%;"></th><th style="text-align:right;font-size:80%;"></th>
		          <th style="text-align:right;font-size:80%;"></th><th style="text-align:right;font-size:80%;"></th>
		          </tr>
	            </tfoot>
             
                             
                </table>
              
            </div>
            <!-- /.box-body -->
           
           
          </div>
          <!-- /.box -->
        </div>
        
      </div>
      <!-- /.row -->
	   
	  
					
  <div class="modal fade" id="jihv_moreinfo_modal" role="dialog">
							<div class="modal-dialog modal-lg">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="modal-title">Job In Hand Volume Details of ${selected_company_code} </h4>
									</div>

									<div class="modal-body">
										<div class="row">
											<table id="jihv_modal_table">
												<thead> <tr> <th>Aging</th> <th>Value</th></tr> </thead>
												<tbody>  
												<c:forEach var="JOBV1" items="${JIHV}"> 
												 <tr>  <td>${JOBV1.duration}</td>  <td><fmt:formatNumber pattern="#,###" value="${JOBV1.amount}" /></td>  </tr>
												
												 </c:forEach>
						                     </tbody>
                                         </table>


										</div>
									</div>

									<div class="modal-footer">
										<button type="button" class="btn btn-default"
											data-dismiss="modal">Close</button>
									</div>

								</div>
							</div>
						</div>
			<div class="modal fade" id="lost_moreinfo_modal" role="dialog">
							<div class="modal-dialog modal-lg">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="modal-title">JIH (All) Vs LOST Details of ${selected_company_code} </h4>
									</div>

									<div class="modal-body">
										<div class="row">
											<table id="lost_modal_table">
										
													<c:forEach var="JOBVL" items="${JIHVLOST}">
													<thead>
														<tr>
															<th></th>
															<th></th>
															<th>0-3
																	Months</th>
															<th>3-6
																	Months</th>
															<th>>6 Months</th>
														</tr>
														</thead><tboady>
														<tr>
															<td>JIH</td>
															<td >COUNT</td>
															<td >${JOBVL.aging1_count_actual}</td>
															<td >${JOBVL.aging2_count_actual}</td>
															<td >${JOBVL.aging3_count_actual}
															</td>
														</tr>
														<tr>
															<td ></td><td >VALUE</td>
															<td><fmt:formatNumber
																		type="number" pattern="###.##"
																		value="${JOBVL.aging1_amt_actual}" /></td>
															<td><fmt:formatNumber type="number" pattern="###.##"
																		value="${JOBVL.aging2_amt_actual}" /></td>
															<td><fmt:formatNumber
																		type="number" pattern="###.##"
																		value="${JOBVL.aging3_amt_actual}" /></td>
														</tr>
														<tr>
															<td>LOST</td>
															<td>COUNT</td>
															<td>
																${JOBVL.aging1_count_lost}</td>
															<td >${JOBVL.aging2_count_lost}</td>
															<td >${JOBVL.aging3_count_lost}</td>
														</tr>
														<tr>
															<td></td><td>VALUE</td>
															<td><fmt:formatNumber
																		type="number" pattern="#,###.##"
																		value="${JOBVL.aging1_amt_lost}" /></td>
															<td> <fmt:formatNumber
																		type="number" pattern="#,###.##"
																		value="${JOBVL.aging2_amt_lost}" /></td>
															<td><fmt:formatNumber
																		type="number" pattern="#,###.##"
																		value="${JOBVL.aging3_amt_lost}" /></td>
														</tr></tboady>
													</c:forEach>
												</table>
										</div>
									</div>

									<div class="modal-footer">
										<button type="button" class="btn btn-default"
											data-dismiss="modal">Close</button>
									</div>

								</div>
							</div>
						</div>
 
			 
		<div class="modal fade" id="booking_moreinfo_modal" role="dialog">
							<div class="modal-dialog modal-lg">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="modal-title">Booking Details of ${selected_company_code} </h4>
									</div>

									<div class="modal-body">
										<div class="row">
											<table id="booking_modal_table">
												<thead> <tr> <th></th> <th>Actual</th><th>Target</th></tr> </thead>
												<tbody>  
												<c:forEach var="ytm_tmp" items="${YTM_BOOK}"> <c:choose> <c:when test="${syrtemp ne CURR_YR}">
          <tr><td>January</td><td> <fmt:formatNumber pattern="#,###" value="${ytm_tmp.jan}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr> 
          <tr><td>February</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.feb}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr> 
         <tr><td>March</td><td> <fmt:formatNumber pattern="#,###" value="${ytm_tmp.mar}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr>
          <tr><td>April</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.apr}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr>
          <tr><td>May</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.may}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr>
          <tr><td>June</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.jun}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr> 
          <tr><td>July</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.jul}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr>  
          <tr><td>August</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.aug}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr> 
          <tr><td>September</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.sep}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr>
          <tr><td>October</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.oct}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr>
          <tr><td>November</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.nov}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr>
         <tr><td>December</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.dec}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr>
          <tr><td>YTD</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.ytm_actual}" /></td><td> <fmt:formatNumber pattern="#,###" value="${ytm_tmp.yr_total_target}" /></td></tr>
          </c:when>
		  <c:otherwise> 
		  <c:if test="${1 le MTH}"> <tr><td>January</td><td> <fmt:formatNumber pattern="#,###" value="${ytm_tmp.jan}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr>   </c:if>
          <c:if test="${2 le MTH}"><tr><td>February</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.feb}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr>  </c:if>
          <c:if test="${3 le MTH}"><tr><td>March</td><td> <fmt:formatNumber pattern="#,###" value="${ytm_tmp.mar}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr> </c:if>
          <c:if test="${4 le MTH}">  <tr><td>April</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.apr}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr> </c:if>
          <c:if test="${5 le MTH}"> <tr><td>May</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.may}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr> </c:if>
          <c:if test="${6 le MTH}">  <tr><td>June</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.jun}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr> </c:if>
          <c:if test="${7 le MTH}"> <tr><td>July</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.jul}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr>   </c:if>
          <c:if test="${8 le MTH}"> <tr><td>August</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.aug}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr> </c:if>
          <c:if test="${9 le MTH}">  <tr><td>September</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.sep}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr> </c:if>
          <c:if test="${10 le MTH}"><tr><td>October</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.oct}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr></c:if>
          <c:if test="${11 le MTH}">  <tr><td>November</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.nov}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr> </c:if>
          <c:if test="${12 le MTH}"> <tr><td>December</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.dec}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr></c:if>
          <tr><td>YTD</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.ytm_actual}" /></td><td> <fmt:formatNumber pattern="#,###" value="${ytm_tmp.yr_total_target}" /></td></tr>
		  </c:otherwise>
		  </c:choose>
         
		  
           
            
	   
   </c:forEach>
						                     </tbody>
                                         </table>


										</div>
									</div>

									<div class="modal-footer">
										<button type="button" class="btn btn-default"
											data-dismiss="modal">Close</button>
									</div>

								</div>
							</div>
						</div>
	
       <div class="modal fade" id="billing_moreinfo_modal" role="dialog">
							<div class="modal-dialog modal-lg">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="modal-title">Billing Target Vs Actual Billing Details of ${selected_company_code} </h4>
									</div>

									<div class="modal-body">
										<div class="row">
											<table id="billing_modal_table">
												<thead> <tr> <th></th> <th>Actual</th><th>Target</th></tr> </thead>
												<tbody>  
												<c:forEach var="ytm_tmp" items="${YTM_BILL}"> <c:choose> <c:when test="${syrtemp ne CURR_YR}">
          <tr><td>January</td><td> <fmt:formatNumber pattern="#,###" value="${ytm_tmp.jan}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr> 
          <tr><td>February</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.feb}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr> 
         <tr><td>March</td><td> <fmt:formatNumber pattern="#,###" value="${ytm_tmp.mar}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr>
          <tr><td>April</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.apr}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr>
          <tr><td>May</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.may}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr>
          <tr><td>June</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.jun}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr> 
          <tr><td>July</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.jul}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr>  
          <tr><td>August</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.aug}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr> 
          <tr><td>September</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.sep}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr>
          <tr><td>October</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.oct}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr>
          <tr><td>November</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.nov}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr>
         <tr><td>December</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.dec}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr>
          <tr><td>YTD</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.ytm_actual}" /></td><td> <fmt:formatNumber pattern="#,###" value="${ytm_tmp.yr_total_target}" /></td></tr>
          </c:when>
		  <c:otherwise> 
		  <c:if test="${1 le MTH}"> <tr><td>January</td><td> <fmt:formatNumber pattern="#,###" value="${ytm_tmp.jan}" /></td><td> <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /> </td></tr>   </c:if>
          <c:if test="${2 le MTH}"><tr><td>February</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.feb}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr>  </c:if>
          <c:if test="${3 le MTH}"><tr><td>March</td><td> <fmt:formatNumber pattern="#,###" value="${ytm_tmp.mar}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr> </c:if>
          <c:if test="${4 le MTH}">  <tr><td>April</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.apr}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr> </c:if>
          <c:if test="${5 le MTH}"> <tr><td>May</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.may}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr> </c:if>
          <c:if test="${6 le MTH}">  <tr><td>June</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.jun}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr> </c:if>
          <c:if test="${7 le MTH}"> <tr><td>July</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.jul}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr>   </c:if>
          <c:if test="${8 le MTH}"> <tr><td>August</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.aug}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr> </c:if>
          <c:if test="${9 le MTH}">  <tr><td>September</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.sep}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr> </c:if>
          <c:if test="${10 le MTH}"><tr><td>October</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.oct}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr></c:if>
          <c:if test="${11 le MTH}">  <tr><td>November</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.nov}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr> </c:if>
          <c:if test="${12 le MTH}"> <tr><td>December</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.dec}" /></td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.monthly_target}" /></td></tr></c:if>
          <tr><td>YTD</td><td>  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.ytm_actual}" /></td><td> <fmt:formatNumber pattern="#,###" value="${ytm_tmp.yr_total_target}" /></td></tr>
		  </c:otherwise>
		  </c:choose>
         
		  
           
            
	   
   </c:forEach>
						                     </tbody>
                                         </table>


										</div>
									</div>

									<div class="modal-footer">
										<button type="button" class="btn btn-default"
											data-dismiss="modal">Close</button>
									</div>

								</div>
							</div>
						</div>
					 
	 <div class="row">
					<div class="modal fade" id="booking-modal-graph" role="dialog" >
					
					        <div class="modal-dialog" style="width:97%;">
					     		<!-- Modal content-->
							      	<div class="modal-content">
								        	<div class="modal-header">
								         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
								          		<h4 class="modal-title">Booking Details </h4>
								        	</div>
								        	<div class="modal-body small"> </div>
									        <div class="modal-footer">
									          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									        </div>
								     </div>
								     
								     
						   	 </div>   	 		   	 
		 			</div>
	  
	</div>
	
	<div class="row">
					<div class="modal fade" id="billing-modal-graph" role="dialog" >
					
					        <div class="modal-dialog" style="width:97%;">
					     		<!-- Modal content-->
							      	<div class="modal-content">
								        	<div class="modal-header">
								         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
								          		<h4 class="modal-title">Billing Details </h4>
								        	</div>
								        	<div class="modal-body small"> </div>
									        <div class="modal-footer">
									          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									        </div>
								     </div>
								     
								     
						   	 </div>   	 		   	 
		 			</div>
	  
	</div> 
			<div class="modal fade" id="modal-help-bkngvsblng">
							<div class="modal-dialog small" style="width: max-content">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title">Booking Target Vs Actual Booking Help</h4>
									</div>
									<div class="modal-body">
									
												<ol>
												<li>LOI Date is entered  (Quotation flexi field 12 )</li>
												<li>Project Status – not marked as LOST (Quotation flexi field 17 )</li>
												<li>Quotation not pulled into sales order</li>
												<li>STAGE 3 also called as BOOKING</li>
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
				      <div class="row" id="qtn_lost_modal-graph">
							<div class="modal fade" id="qtn_lost_modal-main" role="dialog">

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

						</div>
							 <div class="row">
					<div class="modal fade" id="jihv-modal-graph" role="dialog" >
					
					        <div class="modal-dialog" style="width:97%;">
					     		<!-- Modal content-->
							      	<div class="modal-content">
								        	<div class="modal-header">
								         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
								          		<h4 class="modal-title">Job In Hand Volume Details </h4>
								        	</div>
								        	<div class="modal-body small"> <div id="table_div"></div></div>
									        <div class="modal-footer">
									          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									        </div>
								     </div>
								     
								     
						   	 </div>   	 		   	 
		 			</div>
	  
	</div>	
	<div class="row">
					<div class="modal fade" id="cvMoreInfoModal" role="dialog" >
					
					        <div class="modal-dialog" style="width:97%;">
					     		<!-- Modal content-->
							      	<div class="modal-content">
								        	<div class="modal-header">
								         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
								          		<h4 class="modal-title">${selected_company_code} - Customer Visit Details ${syrtemp} </h4>
								        	</div>
								        	<div class="modal-body small"></div>
									        <div class="modal-footer">
									          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									        </div>
								     </div>
								     
								     
						   	 </div>   	 		   	 
		 			</div>
		 	</div> 	
		 	<div class="row">
					<div class="modal fade" id="cv-modal-graph" role="dialog" >
					
					        <div class="modal-dialog" style="width:97%;">
					     		<!-- Modal content-->
							      	<div class="modal-content">
								        	<div class="modal-header">
								         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
								          		<h4 class="modal-title">Customer Visit Details </h4>
								        	</div>
								        	<div class="modal-body small"> </div>
									        <div class="modal-footer">
									          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									        </div>
								     </div>
								     
								     
						   	 </div>   	 		   	 
		 			</div>
	  
	</div>	 
	<div id="laoding" class="loader" ><img src="resources/images/wait.gif"></div>
       
       
       
          
     
      <!-- /.row -->

    
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
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
<script src="resources/bower_components/select2/dist/js/select2.full.min.js"></script>
<script src="resources/js/date-eu.js"></script>
<script>
 
function getColumnValue(obj){ 
	if(obj.value > 0){ 
		return "<td class='monthly-bkngblng' onclick='getsubDivisionAgingDetails(" +JSON.stringify(obj)+")' align='right'>"+formatNumber($.trim(obj.value))+"</td>";
	}else if(obj.value < 0){ 
		return "<td class='monthly-bkngblng' onclick='getsubDivisionAgingDetails(" +JSON.stringify(obj)+")' align='right'>"+formatNumber($.trim(obj.value))+"</td>";
	}else{
		return "<td align='right'>0</td>";
	}
}
function setUpRows(data, obj){ 
	 var rows = "";  
	 data.map((item)=> {  
		  rows +=   "<tr>"+
		                "<td>"+$.trim(item.division)+"</td>"+
		                ""+getColumnValue({"division":$.trim(item.division), "value":$.trim(item.jan), "aging":1,  ...obj})+
				 	    ""+getColumnValue({"division":$.trim(item.division), "value":$.trim(item.feb), "aging":2,  ...obj})+
				 	    ""+getColumnValue({"division":$.trim(item.division), "value":$.trim(item.mar), "aging":3,  ...obj})+
				 	    ""+getColumnValue({"division":$.trim(item.division), "value":$.trim(item.apr), "aging":4,  ...obj})+
				 	    ""+getColumnValue({"division":$.trim(item.division), "value":$.trim(item.may), "aging":5,  ...obj})+
				 	    ""+getColumnValue({"division":$.trim(item.division), "value":$.trim(item.jun), "aging":6,  ...obj})+
				 	    ""+getColumnValue({"division":$.trim(item.division), "value":$.trim(item.jul), "aging":7,  ...obj})+
				 	    ""+getColumnValue({"division":$.trim(item.division), "value":$.trim(item.aug), "aging":8,  ...obj})+
				 	    ""+getColumnValue({"division":$.trim(item.division), "value":$.trim(item.sep), "aging":9,  ...obj})+
				 	    ""+getColumnValue({"division":$.trim(item.division), "value":$.trim(item.oct), "aging":10, ...obj})+
				 	    ""+getColumnValue({"division":$.trim(item.division), "value":$.trim(item.nov), "aging":11, ...obj})+
				 	    ""+getColumnValue({"division":$.trim(item.division), "value":$.trim(item.dec), "aging":12, ...obj})+
				 	    ""+getColumnValue({"division":$.trim(item.division), "value":$.trim(item.ytm_total), "aging":13, ...obj})+
				 		"</tr>";
				 	}); 
	  $(""+obj.placeHolder+"").html(rows); 
} 
function getAgingString(aging){
	if(aging <= 12){
		return (aging > 9 ? aging+"/" : "0" + aging+"/");
	}else{
		return ""
	}
}
function getsubDivisionAgingDetails(obj){ 
	 $('#laoding').show(); 
 
   var ttl="<b>"+obj.title+" Details of "+obj.division+" for  "+getAgingString(obj.aging)+""+slctdYear+"</b>";
    var exclTtl=""+obj.title+" Details of "+obj.division+" for "+getAgingString(obj.aging)+""+slctdYear+"";
    $("#modal-help-bkngvsblng .modal-title").html(ttl); 
  $.ajax({
   		 type: _method,
       	 url: _url, 
       	 data: {fjtco: obj.apiKey, division:obj.division, agng:obj.aging,slctdYr:slctdYear},
       	 dataType: "json",
	  		 success: function(data) {
	  			$('#laoding').hide();
	  		
	  			var output="<table id='booking_xcl'  class='table table-bordered small'><thead><tr>"+
	  			"<th>#</th><th>Company</th><th>Week</th><th>Document Id</th><th>Document Date</th>"+
	  			 "<th>Sales Egr: Code</th><th>Sales Egr: Name</th><th>Party Name</th><th>Contact</th><th>Telephone</th>"+
			      " <th>Project Name</th><th>Product</th>  <th>Zone</th><th>Currency</th><th>Amount (AED)</th><th>Division</th></tr></thead><tbody>";
				  var j=0;
			      for (var i in data)
				 {
			    	  j=j+1; 
				 output+="<tr><td>"+j+"</td><td>" +  $.trim(data[i].company) + "</td>"+
				 "<td>" +  $.trim(data[i].week) + "</td><td>" +  $.trim(data[i].documentId)+ "</td>"+
				 "<td>" +  $.trim(data[i].documentDate.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+
				 "<td>" +  $.trim(data[i].smCode) + "</td><td>" +  $.trim(data[i].smName) + "</td>"+
				 "</td><td>" +  $.trim(data[i].partyName) + "</td>"+
				 "<td>" +  $.trim(data[i].contact) + "</td><td>" +  $.trim(data[i].telephone) + "</td>"+
				 "<td>" +  $.trim(data[i].projectName) + "</td><td>" +  $.trim(data[i].product) + "</td><td>" +  $.trim(data[i].zone) + "</td>"+
				 "<td>" +  $.trim(data[i].currency) + "</td>"+"<td>" +  $.trim(data[i].amount) + "</td>"+"<td>" +  $.trim(data[i].divisionCode) + 
				 "</tr>";
				 } 
				 output+="</tbody></table>";
				
	  			$("#modal-help-bkngvsblng  .modal-body").html(output);
	  			$("#modal-help-bkngvsblng").modal("show");
	  			
	  			$('#booking_xcl').DataTable( {
	  		     dom: 'Bfrtip',       
	  		     buttons: [
	  		         {
	  		             extend: 'excelHtml5',
	  		             text:'<i class="fa fa-file-excel-o" style="color: green; font-size: 1em;">Export</i>',
	  		             filename: exclTtl,
	  		             title: exclTtl,
	  		             messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'  
	  		         } 
	  		     ]
	  		 } );	
	  			
	  },
	  error:function(data,status,er) {$('#laoding').hide();  alert("please click again");  }
	 }); 
    
}
$(document).ready(function() {
	/*Help Script Start */
	 $('#help-bkngvsblng').on('click', function(e) {  
		   $("#modal-help-bkngvsblng").modal("show");	
	    });
	
	 /*Help Script Start */
	 $('#help-qtnlost').on('click', function(e) {  
		   $("#modal-help-qtnlost").modal("show");	
	    }); 
	var blngObj = {
			"placeHolder":"#subdivnBlng_table tbody",  
			"apiKey": "blngAging",
			"title":"Billing"
	 };
	var bkngObj = {
			"placeHolder":"#subdivnBkng_table tbody",  
			"apiKey": "bkngAging",
			"title":"Booking"
	 };
	 setUpRows(blng, blngObj);//billing
	 setUpRows(bkng, bkngObj);//booking
	 
	  
	  var jihvTtl="Job In Hand Volume Details  of Branch : ${selected_company_code} ";
	  var lostTtl="JIH (All) Vs Lost Details  of Branch : ${selected_company_code} ";
	  var bookingTtl="Booking Details  of Branch : ${selected_company_code}";
	  var billingTtl="Billing Details  of Branch : ${selected_company_code}";  
	   $('#jihv_modal_table').DataTable( {
	        dom: 'Bfrtip', 
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
	                filename: jihvTtl,
	                title: jihvTtl,
	                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	          
	           
	        ]
	    } );
	   $('#lost_modal_table').DataTable( {
	        dom: 'Bfrtip',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
	                filename: lostTtl,
	                title: lostTtl,
	                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	          
	           
	        ]
	    } );
	   
	   $('#booking_modal_table').DataTable( {
	        dom: 'Bfrtip',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
	                filename: bookingTtl,
	                title: bookingTtl,
	                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	          
	           
	        ]
	    } );
	   
	   $('#billing_modal_table').DataTable( {
	        dom: 'Bfrtip',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
	                filename: billingTtl,
	                title: billingTtl,
	                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	          
	           
	        ]
	    } );
	 
	   $('#subdivnBlng_table').DataTable( {
	        dom: 'Bfrtip',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: #9C27B0; font-size: 1em;">Export</i>',
	                filename: 'Sub-Division level Billing summary Whole year',
	                title: 'Sub-Division level Billing summary Whole year',
	                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	          
	           
	        ],
           "footerCallback": function ( row, data, start, end, display ) {
	            var api = this.api(), data;
	 
	            // Remove the formatting to get integer data for summation
	            var intVal = function ( i ) {
	                return typeof i === 'string' ?
	                    i.replace(/[\$,]/g, '')*1 :
	                    typeof i === 'number' ?
	                        i : 0;
	            };
	 
	        // Total over all pages
	        var total1 = api.column( 1).data().reduce( function (a, b) {return intVal(a) + intVal(b);}, 0 ); 
	        var total2 = api.column( 2 ).data().reduce( function (a, b) {return intVal(a) + intVal(b);}, 0 );     
	        var total3 = api.column( 3 ).data().reduce( function (a, b) { return intVal(a) + intVal(b);},0 );     
	        var total4 = api .column(4 ).data().reduce( function (a, b) {return intVal(a) + intVal(b);}, 0 );
		    var total5 = api.column( 5 ).data().reduce( function (a, b) {return intVal(a) + intVal(b);}, 0 );
           var total6 = api.column( 6 ).data().reduce( function (a, b) {return intVal(a) + intVal(b);}, 0 );
           var total7 = api.column( 7 ).data().reduce( function (a, b) {return intVal(a) + intVal(b);}, 0 );
           var total8 = api.column( 8 ).data().reduce( function (a, b) {return intVal(a) + intVal(b);}, 0 );
           var total9 = api.column( 9 ).data().reduce( function (a, b) {return intVal(a) + intVal(b);}, 0 );
           var total10 = api.column(10 ).data().reduce( function (a, b) {return intVal(a) + intVal(b);}, 0 );
           var total11 = api.column( 11 ).data().reduce( function (a, b){return intVal(a) + intVal(b);}, 0 );
           var total12 = api.column( 12 ).data().reduce( function (a, b){return intVal(a) + intVal(b);}, 0 );
           var total13 = api.column( 13 ).data().reduce( function (a, b){return intVal(a) + intVal(b);}, 0 );
	        // Update footer
	                     $( api.column(1).footer()).html(formatNumber(total1));
	                     $( api.column(2).footer()).html(formatNumber(total2));
	                     $( api.column(3).footer()).html(formatNumber(total3));
	                     $( api.column(4).footer()).html(formatNumber(total4));
	            		 $( api.column(5).footer()).html(formatNumber(total5));
	            		 $( api.column(6).footer()).html(formatNumber(total6));
	                     $( api.column(7).footer()).html(formatNumber(total7));
	                     $( api.column(8).footer()).html(formatNumber(total8));
	                     $( api.column(9).footer()).html(formatNumber(total9));
	            		 $( api.column(10).footer()).html(formatNumber(total10));
	            		 $( api.column(11).footer()).html(formatNumber(total11));
	                     $( api.column(12).footer()).html(formatNumber(total12));
	                     $( api.column(13).footer()).html(formatNumber(total13));
	            
	            
	        }
	    } );
	   $('#subdivnBkng_table').DataTable( {
	        dom: 'Bfrtip',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: #9C27B0; font-size: 1em;">Export</i>',
	                filename: 'Sub-Division level Booking summary Whole year',
	                title: 'Sub-Division level Booking summary Whole year',
	                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	          
	           
	        ],
          "footerCallback": function ( row, data, start, end, display ) {
	            var api = this.api(), data;
	 
	            // Remove the formatting to get integer data for summation
	            var intVal = function ( i ) {
	                return typeof i === 'string' ?
	                    i.replace(/[\$,]/g, '')*1 :
	                    typeof i === 'number' ?
	                        i : 0;
	            };
	 
	        // Total over all pages
	        var total1 = api.column( 1).data().reduce( function (a, b) {return intVal(a) + intVal(b);}, 0 );     
	        var total2 = api.column( 2 ).data().reduce( function (a, b) {return intVal(a) + intVal(b);}, 0 );     
	        var total3 = api.column( 3 ).data().reduce( function (a, b) { return intVal(a) + intVal(b);},0 );     
	        var total4 = api .column(4 ).data().reduce( function (a, b) {return intVal(a) + intVal(b);}, 0 );
		    var total5 = api.column( 5 ).data().reduce( function (a, b) {return intVal(a) + intVal(b);}, 0 );
          var total6 = api.column( 6 ).data().reduce( function (a, b) {return intVal(a) + intVal(b);}, 0 );
          var total7 = api.column( 7 ).data().reduce( function (a, b) {return intVal(a) + intVal(b);}, 0 );
          var total8 = api.column( 8 ).data().reduce( function (a, b) {return intVal(a) + intVal(b);}, 0 );
          var total9 = api.column( 9 ).data().reduce( function (a, b) {return intVal(a) + intVal(b);}, 0 );
          var total10 = api.column(10 ).data().reduce( function (a, b) {return intVal(a) + intVal(b);}, 0 );
          var total11 = api.column( 11 ).data().reduce( function (a, b){return intVal(a) + intVal(b);}, 0 );
          var total12 = api.column( 12 ).data().reduce( function (a, b){return intVal(a) + intVal(b);}, 0 );
          var total13 = api.column( 13 ).data().reduce( function (a, b){return intVal(a) + intVal(b);}, 0 );
	        // Update footer
	                     $( api.column(1).footer()).html(formatNumber(total1));
	                     $( api.column(2).footer()).html(formatNumber(total2));
	                     $( api.column(3).footer()).html(formatNumber(total3));
	                     $( api.column(4).footer()).html(formatNumber(total4));
	            		 $( api.column(5).footer()).html(formatNumber(total5));
	            		 $( api.column(6).footer()).html(formatNumber(total6));
	                     $( api.column(7).footer()).html(formatNumber(total7));
	                     $( api.column(8).footer()).html(formatNumber(total8));
	                     $( api.column(9).footer()).html(formatNumber(total9));
	            		 $( api.column(10).footer()).html(formatNumber(total10));
	            		 $( api.column(11).footer()).html(formatNumber(total11));
	                     $( api.column(12).footer()).html(formatNumber(total12));
	                     $( api.column(13).footer()).html(formatNumber(total13));
	            
	            
	        }
	    } ); 
} );
 
function changeTitle(title){
	$('#jihlost-title').html(title);
}     


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