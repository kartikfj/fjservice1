<%-- 
    Document   : SIP SALES PERFORM DASHBAORD FOR DM  
--%>
<%@include file="sipHead.jsp" %>
 <c:set var="syrtemp" value="${selected_Year}" scope="page" />
<!DOCTYPE html>
<html>
<head>  
<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/themes/smoothness/jquery-ui.css">
<style>
table.dataTable thead th,table.dataTable thead td {
    padding: 5px 5px;
    border-bottom: 1px solid #111
}
.modal-subtitle2 {  
    font-weight: bold !important;
}
@media print {
  /* Ensure right alignment for table cells when printing */
  table tr td:not(:first-child) {
    text-align: right !important;
  }
  table tr:last-child td {
    font-weight: bold !important;
}

  @page { height: 842px;   width: 595px;  margin-top:30px; margin-left: auto;   margin-right: auto; margin-bottom:-50px;} 
}

.stage-details-graph {z-index: 50; background: rgba(255, 255, 255, 0.7); border: 2px solid #3c8dbc;font-size: 15px; color: #3c8dbc; position: absolute; padding: 2px 0px 2px 6px;cursor: pointer; top: 5px; right: 150px; border-radius: 5px;}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js"></script>
 <script type="text/javascript">
 var currYear = parseInt('${CURR_YR}');
 var slctdYear = parseInt('${syrtemp}');
 var durationFltr = (slctdYear < currYear)? 'FY' : 'YTD'; 
 var Million = 1000000; 
 var selectdSalesId = "${selected_salesman_code}";
 var totLosts = 0, targeteportsList = <%=new Gson().toJson(request.getAttribute("JIHLA"))%>; 
 var totJIHLostVal = 0,noResponseValue = 0;

 $(document).ready(function() {  $('.select2').select2();  });  

 function s3Details(val){ $('#laoding').show();
 var ttl="<b>Stage 3 Details of <strong style='color:blue;'><i>${selected_salesman_code} </i></strong></b>"; 
 var excelTtl="Stage 3 Details of ${selected_salesman_code}";
 $("#s3-modal-graph .modal-title").html(ttl);
 $.ajax({ type: 'POST', url: 'sip', data: {fjtco: "s3_dt", sd1:"${selected_salesman_code}"}, dataType: "json", success: function(data) { $('#laoding').hide();
 var output="<table id='s3-excl' class='table table-bordered small'><thead><tr>"+"<th>#</th><th>Week</th><th>Zone</th><th>Product Category</th><th>Product Sub Category</th>"+
 "<th>Project Name</th><th>Consultant</th><th>Customer</th><th>Quotation Date</th><th>Quotation Code</th><th>Quotation No.</th>"+
 " <th>Amount</th><th>Average GP</th><th>LOI Received Date</th>  <th>Exp Po Date</th><th>Invoicing Year</th></tr></thead><tbody>";
 var j=0; for (var i in data) {j=j+1; output+="<tr><td>"+j+"</td><td>" + $.trim( data[i].d1) + "</td>"+ "<td>" + $.trim( data[i].d2 ) + "</td>"+
 "<td>" + $.trim( data[i].d4 ) + "</td><td>" + $.trim(data[i].d5) + "</td>"+ "<td>" + $.trim(data[i].d6 )+ "</td><td>" + $.trim(data[i].d7) + "</td>"+
 "<td>" + $.trim(data[i].d8) + "</td><td>" + $.trim(data[i].d9.substring(0, 10)).split("-").reverse().join("/") + "</td>"+ "<td>" + $.trim(data[i].d10) + "</td><td>" + $.trim(data[i].d11) + "</td>"+
 "<td align='right'>" + formatNumber($.trim(data[i].d12))+ "</td><td>" + data[i].d13 + "</td>"+ "<td>" + $.trim(data[i].d14.substring(0, 10)).split("-").reverse().join("/") + "</td><td>" + $.trim(data[i].d15.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+
 "<td>" + $.trim(data[i].d16.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+ "</tr>"; }
// output+="<tr><td colspan='15'><b>Total</b></td><td><b>"+val+"</b></td></tr>"; output+="</tbody></table>";  
 $("#s3-modal-graph .modal-body").html(output);$("#s3-modal-graph").modal("show");
 $('#s3-excl').DataTable( {
     dom: 'Bfrtip',  
     "columnDefs" : [{"targets":[8, 13, 14], "type":"date-eu"}],
     buttons: [
         {
             extend: 'excelHtml5',
             text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
             filename: excelTtl,
             title: excelTtl,
             messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'
             
             
         }
       
        
     ]
 } );
 
 },error:function(data,status,er) { $('#laoding').hide(); alert("please click again"); }});}
 
 function s4Details(val){ $('#laoding').show(); 
 var ttl="<b>Stage 4 Details of <strong style='color:blue;'><i>${selected_salesman_code} </i></strong></b>";
 var excelTtl="Stage 4 Details of ${selected_salesman_code}"
 $("#s4-modal-graph .modal-title").html(ttl);$.ajax({ type: 'POST',url: 'sip', data: {fjtco: "s4_dt", sd1:"${selected_salesman_code}"}, dataType: "json",success: function(data) {
 $('#laoding').hide();var output="<table id='s4-excl' class='table table-bordered small'><thead><tr>"+"<th>#</th><th>So Date</th><th>So Txn Code</th><th>Order No.</th>"+
 "<th>Sales Egnr.</th><th>Zone</th><th>Product Category</th><th>Product Sub Category</th><th>Project Name</th>"+ " <th>Consultant</th><th>Payment Term</th><th>Customer</th>  <th>Profit %</th><th>Balance Value</th>"+ "<th>Projected Invoice Date</th><th>Soh Location Code</th></tr></thead><tbody>";
 var j=0;for (var i in data) { j=j+1; output+="<tr><td>"+j+"</td><td><span>" + $.trim(data[i].d1.substring(0, 10)).split("-").reverse().join("/")+ "</span></td>"+
 "<td>" + $.trim(data[i].d2)+ "</td><td>" + $.trim(data[i].d3) + "</td>"+ "<td>" +$.trim(data[i].d4)+ " - " + $.trim(data[i].d5 )+ "</td>"+
 "<td>" + $.trim(data[i].d8 )+ "</td><td>" +$.trim( data[i].d9 )+ "</td>"+ "<td>" + $.trim(data[i].d10 )+ "</td><td>" + $.trim(data[i].d11 )+ "</td>"+ "<td>" + $.trim(data[i].d12 )+ "</td><td>" + $.trim(data[i].d13 )+ "</td>"+
 "<td>" + $.trim(data[i].d14 )+ "</td><td>" + $.trim(data[i].d15)+ "</td>"+ "<td align='right'>" + formatNumber($.trim(data[i].d16))+ "</td>"+ "<td>" + $.trim(data[i].d17.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+
 "<td>" +$.trim( data[i].d18)+ "</td>"+ "</tr>"; } 
 //output+="<tr><td colspan='16'><b>Total</b></td><td><b>"+val+"</b></td></tr>"; 
 output+="</tbody></table>";  $("#s4-modal-graph .modal-body").html(output);$("#s4-modal-graph").modal("show");
 $('#s4-excl').DataTable( {
     dom: 'Bfrtip',  
     "columnDefs" : [{"targets":[1, 14], "type":"date-eu"}],
     buttons: [
         {
             extend: 'excelHtml5',
             text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
             filename: excelTtl,
             title: excelTtl,
             messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'
             
             
         }
       
        
     ]
 } );
 
 },error:function(data,status,er) { $('#laoding').hide(); alert("please click again");} });} 
 
 function s5Details(val){ $('#laoding').show(); 
 var ttl="<b>Stage 5 Details of <strong style='color:blue;'><i>${selected_salesman_code} </i></strong></b>";
 var excelTtl="Stage 5 Details of ${selected_salesman_code}"
 $("#s5-modal-graph .modal-title").html(ttl);$.ajax({ type: 'POST',url: 'sip', data: {fjtco: "s5_dt", sd1:"${selected_salesman_code}"}, dataType: "json",success: function(data) {
 $('#laoding').hide();var output="<table id='s5-excl' class='table table-bordered small'><thead><tr>"+"<th>#</th><th>Comp Code</th><th>Week</th><th>Doc ID</th><th>Doc Date</th><th>Sm Code</th>"+
 "<th>Sm Name</th><th>Party Name</th><th>Contact</th><th>Contact No</th><th>Project Name</th>"+ " <th>Zone</th><th>Currency</th><th>Amount</th> </tr></thead><tbody>";
 var j=0;for (var i in data) { j=j+1; output+="<tr><td>"+j+"</td><td><span>" + $.trim(data[i].d1)+ "</span></td>"+
 "<td>" + $.trim(data[i].d2)+ "</td><td>" + $.trim(data[i].d3) + "</td>"+ "<td>" +$.trim(data[i].d4.substring(0, 10)).split("-").reverse().join("/")+ "</td><td>"  + $.trim(data[i].d5 )+ "</td>"+
 "<td>" + $.trim(data[i].d6 )+ "</td><td>" +$.trim( data[i].d7 )+ "</td>"+ "<td>" + $.trim(data[i].d8 )+ "</td><td>" + $.trim(data[i].d9 )+ "</td>"+ "<td>" + $.trim(data[i].d10 )+ "</td><td>" + $.trim(data[i].d12 )+ "</td>"+
 "<td>" + $.trim(data[i].d13 )+ "</td><td>" + $.trim(data[i].d14 )+ "</td></tr>"; } 
 //output+="<tr><td colspan='16'><b>Total</b></td><td><b>"+val+"</b></td></tr>"; 
 output+="</tbody></table>";  $("#s5-modal-graph .modal-body").html(output);$("#s5-modal-graph").modal("show");
 $('#s5-excl').DataTable( {
     dom: 'Bfrtip',  
     "columnDefs" : [{"targets":[1, 10], "type":"date-eu"}],
     buttons: [
         {
             extend: 'excelHtml5',
             text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
             filename: excelTtl,
             title: excelTtl,
             messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'
             
             
         }
       
        
     ]
 } );
 
 },error:function(data,status,er) { $('#laoding').hide(); alert("please click again");} });} 
  </script> 



 <c:set var="sales_egr_code" value="0" scope="page" /> 
 <c:set var="aging30" value="0" scope="page" /> 
 <c:set var="aging3060" value="0" scope="page" /> 
 <c:set var="aging6090" value="0" scope="page" /> 
 <c:set var="aging90120" value="0" scope="page" /> 
 <c:set var="aging120180" value="0" scope="page" /> 
 <c:set var="aging181" value="0" scope="page" /> 
 
  <c:forEach var="rcvbl_list"  items="${ORAR}" > 
  <c:set var="aging30" value="${rcvbl_list.aging_1}" scope="page" /> 
  <c:set var="aging3060" value="${rcvbl_list.aging_2}" scope="page" /> 
  <c:set var="aging6090" value="${rcvbl_list.aging_3}" scope="page" /> 
  <c:set var="aging90120" value="${rcvbl_list.aging_4}" scope="page" /> 
  <c:set var="aging120180" value="${rcvbl_list.aging_5}" scope="page" /> 
  <c:set var="aging181" value="${rcvbl_list.aging_6}" scope="page" /> 
  </c:forEach> 
 
 <c:set var="year_target" value="0" scope="page" /> 
 <c:set var="actual" value="0" scope="page" /> 
 <c:set var="guage_bkng_ytd_target" value="0" scope="page" /> 
  <c:set var="guage_blng_ytd_target" value="0" scope="page" /> 
 <c:forEach var="ytm_tmp1" items="${YTM_BOOK}">  
 <c:set var="year_target" value="${ytm_tmp1.yr_total_target}" scope="page" />
 <c:set var="actual" value="${ytm_tmp1.ytm_actual}" scope="page" />
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
 <c:set var="year_targetbl" value="${ytm_tmp2.yr_total_target}" scope="page" /> <c:set var="actualbl" value="${ytm_tmp2.ytm_actual}" scope="page" />
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

 google.charts.setOnLoadCallback(drawJobInHandVolume);
 google.charts.setOnLoadCallback(drawPerfomanceSummaryBookingYtd);
 google.charts.setOnLoadCallback(drawPerfomanceSummaryBillingYtd);
 google.charts.setOnLoadCallback(drawCustomerVisitPerfomanceSummary);
 google.charts.setOnLoadCallback(function() { drawGuageGraph(${actual},   ${guage_bkng_ytd_target}, 'guage_test_booking', 'Booking');});
 google.charts.setOnLoadCallback(function() { drawGuageGraph(${actualbl}, ${guage_blng_ytd_target}, 'guage_test_billing', 'Billing');});
 google.charts.setOnLoadCallback(drawPerfomanceSummaryS4BillingYtd);
 google.charts.setOnLoadCallback(drawBlngLast3YrsVisualization);
 google.charts.setOnLoadCallback(function (){
	 drawJihLostPieChart('jihLostCountAnlysys', 'lostCount');
	});
 //google.charts.setOnLoadCallback(drawWeekylySalesSummaryS2S3S4);
 
 function drawWeekylySalesSummaryS2S3S4() {	
	 var data = google.visualization.arrayToDataTable([  ['Week', 'S2', 'S3','S4','S5'],
 
		 <c:if test="${S2S3S4S5_SUMM ne null or !empty S2S3S4S5_SUMM}">
		 <c:forEach var="i" items="${S2S3S4S5_SUMM}"> 
		  		['${i.weekNo}', ${i.s2Count}, ${i.s3Count}, ${i.s4Count}, ${i.s5Count}], 
		 </c:forEach>		  		
		</c:if>
		<c:if test="${S2S3S4S5_SUMM eq null or empty S2S3S4S5_SUMM}">
			<c:forEach var="i" begin="1" end="${currWeek}" step="1" >
			  		['${i}', 0,0, 0, 0], 
			 </c:forEach> 
		</c:if>
		 ]);  
	    var options = {	         
	          hAxis: {title: 'Week (<%=iYear%>)',  titleTextStyle: {color: '#333'}},	          
	          vAxis: {minValue: 0,title: 'Amount (In Millions)',  titleTextStyle: {color: '#333'},format: 'short'},
	          legend: { position: 'top' },
	          colors: ['blue', 'grey', 'red','green'],
	          focusTarget: 'category',
	          chartArea : { left: 60,top : 60},
	          'width':1250,
	          
	        };
        var chart = new google.visualization.LineChart(document.getElementById('s2s3s4summary'));
        chart.draw(data, options);
	    }
 function drawJihLostPieChart(id, graphContType) {
	 var moreinfoOut = "<table id='mrInfJihLstGrpTbl'><thead><tr><th>Lost Type</th><th>Count</th><th>Value</th><th> </th></tr></thead><tbody>";
	 totLosts = targeteportsList.length; 
	 var arr = []; 
	 arr[0] =  ['Service Type', 'Total Visits'
		// ,  {type: 'string', role: 'tooltip'}
	 ];
	 var j = 0;   
	 var toolTipDesc = '';
  targeteportsList.map( item => {
   j++;
  // toolTipDesc = "Lost Type : "+item.lostType+"\r\n Count :"+item[graphContType]+"\r\n Value: "+extractValue(item.lostValue)+"";
   arr[j]=[item.lostType, item[graphContType]
   //,  toolTipDesc
   ]; 
   if(parseInt(item[graphContType]) > 0){
	   totJIHLostVal += item.lostValue;
	   if(item.lostType == 'No Response'){
	   		noResponseValue = formatNumber(item.lostValue);
	   }
	   moreinfoOut += '<tr><td>'+item.lostType+'</td><td align="right">'+item[graphContType]+'</td><td align="right">'+ formatNumber(item.lostValue)+'</td><td><button class="btn btn-xs btn-danger" onClick="getJihLostAnalysisDtls(\''+item.lostType+'\');"><i class="fa fa-external-link"></i> Details</button</td></tr>';
   }else{moreinfoOut += '<tr><td>'+item.lostType+'</td><td align="right">'+item[graphContType]+'</td><td align="right">'+ formatNumber(item.lostValue)+'</td><td></td></tr>';}
 
 });
  moreinfoOut += "</tbody></table>"; 
  $("#jihLostModalGraph .modal-body").html(moreinfoOut); 

if (totLosts == 0) {
	   $("#"+id+"").html("<span class='noData' >No Data Available!</span>"); 
	   $('#'+id+'').css('background-color','#e1ecf5');		   
	} else {
		var data = google.visualization.arrayToDataTable(arr);
		var options = { 
			is3D: true,
		 	pieSliceTextStyle: {  color: 'white',},  slices: {  7: {offset: 0.4},}, 
			legend:{ /* position: 'labeled', */  
				textStyle: {color: 'blue', fontSize: 10, textStyle: {bold:true, fontName: 'monospace'}}
		 		},
				chartArea:{left:5,top:20,width:'100%',height:'100%'},
				backgroundColor:{fill: '#f9fbfc'},
				sliceVisibilityThreshold:0, 
		 };
		  var chart = new google.visualization.PieChart(document.getElementById(id));
	/* 	  chart.setAction({
	          id: 'sample',
	          text: 'Click Details',
	          action: function() {
	            selection = chart.getSelection();  
	            getJihLostAnalysisDtls(data.getValue(chart.getSelection()[0].row, 0));
	          }
	        });
 */
		  chart.draw(data, options); 
	}
$('#mrInfJihLstGrpTbl').DataTable( {
    dom: 'Bfrtip',  
    "paging":   false,
    "ordering": false,
    "info":     false,
    "searching": false,
    buttons: [
        {
            extend: 'excelHtml5',
            text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
            filename: 'JIH Qtn. Lost Analysis of Sales Egr:  ${selected_salesman_code}',
            title: 'JIH Qtn. Lost Analysis of Sales Egr:  ${selected_salesman_code}',
            messageTop: 'The information in this file is copyright to Faisal Jassim Group.',
            exportOptions: {
                columns: [ 0, 1, 2  ]
            }                        
        }          
    ]
} );
}
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
 	google.visualization.events.addListener(chart, 'select', function () { selectHandlerBarGraph('jih', chart, data, 'Job In Hand Volume', '#jihv-modal-graph', 'aging_dt', '${selected_salesman_code}', 'jihvexport', '${syrtemp}', 'sip');}); 
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

	       
	 var data = google.visualization.arrayToDataTable(getSalesGraphRemoveYTD(bookings, '${MTH}')); 
          // Set chart options
        // Monthly Target - <c:forEach var="ytm_tmp" items="${YTM_BOOK}"> <fmt:formatNumber type="number"   value="${ytm_tmp.monthly_target}"/> :
          var options = {
						  'title':'Yearly Target - <fmt:formatNumber type="number"   value="${ytm_tmp.yr_total_target}"/> \r\n   YTD Target - <fmt:formatNumber type="number"   value="${ytm_tmp.ytm_target}"/>\r\n YTD Actual -    <fmt:formatNumber type="number"   value="${ytm_tmp.ytm_actual}"/></c:forEach>.',				 
						 
						  'vAxis': {title: 'Amount (In Millions)',titleTextStyle: {italic: false},viewWindow:{ min:0},format: 'short'},
		                  'is3D':true,
		                 
		                  titleTextStyle: {
		        		      color: '#000',
		        		      fontSize: 13,
		        		      fontName: 'Arial',
		        		      bold: true
		        		   },
		        		   series: {
		       	            0: {targetAxisIndex: 0},	 
		       	            1: {targetAxisIndex: 0,type: 'line'},
		       	            //2: {targetAxisIndex: 0,type: 'line'}
		       	          },
		                   'chartArea': {
						        top: 70,
						        right: 12,
						        bottom: 48,
						        left: 60,
						        height: '100%',
						        width: '100%'
						      },
						      pointSize:4,
						      bar: { groupWidth: "25%" },
						      'height': 240,
						      'legend': {
						        position: 'top'
						      },
						      colors: ['#607d8b', '#a26540'],
						      hAxis: { slantedText:true, slantedTextAngle:90 },						     
                         };
          

          // Instantiate and draw our chart, passing in some options.
          var chart = new google.visualization.ColumnChart(document.getElementById('prf_summ_booking_ytd'));
          chart.draw(data, options);
          google.visualization.events.addListener(chart, 'onmouseover', function () { uselessHandlerMhvr('#chart_div');} );
          google.visualization.events.addListener(chart, 'onmouseout',  function () { uselessHandlerMout('#chart_div');} );
          google.visualization.events.addListener(chart, 'select', function () { selectHandlerBarGraph('booking', chart, data, 'Booking', '#booking-modal-graph', 'bkm_dt', '${selected_salesman_code}', 'booking-xcl', '${syrtemp}', 'sip','${CURR_YR}');});

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
	 var data = google.visualization.arrayToDataTable(getSalesGraphRemoveYTD(billing, '${MTH}'));	
     // Set chart options
     var options = {    'title': 'Yearly Target - <c:forEach var="ytm_tmp" items="${YTM_BILL}"> <fmt:formatNumber type="number" value="${ytm_tmp.yr_total_target}" /> \r\n YTD Target - <fmt:formatNumber type="number" value="${ytm_tmp.ytm_target}" />\r\n YTD Actual - <fmt:formatNumber type="number" value="${ytm_tmp.ytm_actual}" /></c:forEach>',
   		  'vAxis': {title: 'Amount (In Millions)',titleTextStyle: {italic: false},viewWindow:{ min:0},format: 'short'}, 
   		
   		         'is3D':true,
   		         titleTextStyle: {
   				      color: '#000',
   				      fontSize: 13,
   				      fontName: 'Arial',
   				      bold: true
   				   },
   				series: {
       	            0: {targetAxisIndex: 0},	 
       	            1: {targetAxisIndex: 0,type: 'line'},
       	            2: {targetAxisIndex: 0,type: 'line'}
       	          },
   		         'chartArea': {
					        top: 70,
					        right: 12,
					        bottom: 48,
					        left: 60,
					        height: '100%',
					        width: '100%'
					      },
					      pointSize:4,
					      bar: { groupWidth: "25%" },
					      'height': 220,
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
     google.visualization.events.addListener(chart, 'select', function () { selectHandlerBarGraph('billing', chart, data, 'Billing', '#billing-modal-graph', 'blm_dt', '${selected_salesman_code}', 'blng_main', '${syrtemp}', 'sip','${CURR_YR}');});

   }
    
      function drawPerfomanceSummaryS4BillingYtd() {
        	
          // Create the data table.
        var data = google.visualization.arrayToDataTable([
          ['Month', 'Stage-4 Amount','Target'],
         
          <c:if test="${BILLS4_SUMM ne null or !empty BILLS4_SUMM}">
          <c:forEach var="ytm_tmp" items="${BILLS4_SUMM}"> 
          <c:choose>
          
			<c:when test="${syrtemp ne CURR_YR}">
			 ['Jan', ${ytm_tmp.jan}, ${ytm_tmp.monthly_target}],  
	         ['Feb', ${ytm_tmp.feb}, ${ytm_tmp.monthly_target}],  
	         ['Mar', ${ytm_tmp.mar}, ${ytm_tmp.monthly_target}], 
	         ['Apr', ${ytm_tmp.apr}, ${ytm_tmp.monthly_target}], 
	         ['May', ${ytm_tmp.may}, ${ytm_tmp.monthly_target}], 
	         ['Jun', ${ytm_tmp.jun}, ${ytm_tmp.monthly_target}], 
	         ['Jul', ${ytm_tmp.jul}, ${ytm_tmp.monthly_target}],  
	         ['Aug', ${ytm_tmp.aug}, ${ytm_tmp.monthly_target}],
	         ['Sep', ${ytm_tmp.sep}, ${ytm_tmp.monthly_target}], 
	         ['Oct', ${ytm_tmp.oct}, ${ytm_tmp.monthly_target}], 
	         ['Nov', ${ytm_tmp.nov}, ${ytm_tmp.monthly_target}], 
	         ['Dec', ${ytm_tmp.dec}, ${ytm_tmp.monthly_target}], 
	        // ['YTD', ${ytm_tmp.ytm_actual},${ytm_tmp.yr_total_target}], 
			</c:when>
			
			 <c:when test="${syrtemp ne CURR_YR}">
			 ['Jan', ${ytm_tmp.jan}, ${ytm_tmp.monthly_target}],  
	         ['Feb', ${ytm_tmp.feb}, ${ytm_tmp.monthly_target}],  
	         ['Mar', ${ytm_tmp.mar}, ${ytm_tmp.monthly_target}], 
	         ['Apr', ${ytm_tmp.apr}, ${ytm_tmp.monthly_target}], 
	         ['May', ${ytm_tmp.may}, ${ytm_tmp.monthly_target}], 
	         ['Jun', ${ytm_tmp.jun}, ${ytm_tmp.monthly_target}], 
	         ['Jul', ${ytm_tmp.jul}, ${ytm_tmp.monthly_target}],  
	         ['Aug', ${ytm_tmp.aug}, ${ytm_tmp.monthly_target}],
	         ['Sep', ${ytm_tmp.sep}, ${ytm_tmp.monthly_target}], 
	         ['Oct', ${ytm_tmp.oct}, ${ytm_tmp.monthly_target}], 
	         ['Nov', ${ytm_tmp.nov}, ${ytm_tmp.monthly_target}], 
	         ['Dec', ${ytm_tmp.dec}, ${ytm_tmp.monthly_target}], 
	        // ['YTD', ${ytm_tmp.ytm_actual},${ytm_tmp.yr_total_target}], 
			</c:when>
			<c:otherwise> 
			<c:if test="${1 le MTH}"> ['Jan', ${ytm_tmp.jan}, ${ytm_tmp.monthly_target}],  </c:if>
	          <c:if test="${2 le MTH}">['Feb', ${ytm_tmp.feb}, ${ytm_tmp.monthly_target}],  </c:if>
	          <c:if test="${3 le MTH}">['Mar', ${ytm_tmp.mar}, ${ytm_tmp.monthly_target}], </c:if>
	          <c:if test="${4 le MTH}"> ['Apr', ${ytm_tmp.apr}, ${ytm_tmp.monthly_target}], </c:if>
	          <c:if test="${5 le MTH}"> ['May', ${ytm_tmp.may}, ${ytm_tmp.monthly_target}], </c:if>
	          <c:if test="${6 le MTH}"> ['Jun', ${ytm_tmp.jun}, ${ytm_tmp.monthly_target}], </c:if>
	          <c:if test="${7 le MTH}">['Jul', ${ytm_tmp.jul}, ${ytm_tmp.monthly_target}],  </c:if>
	          <c:if test="${8 le MTH}">['Aug', ${ytm_tmp.aug}, ${ytm_tmp.monthly_target}], </c:if>
	          <c:if test="${9 le MTH}"> ['Sep', ${ytm_tmp.sep}, ${ytm_tmp.monthly_target}], </c:if>
	          <c:if test="${10 le MTH}">['Oct', ${ytm_tmp.oct}, ${ytm_tmp.monthly_target}], </c:if>
	          <c:if test="${11 le MTH}"> ['Nov', ${ytm_tmp.nov}, ${ytm_tmp.monthly_target}], </c:if>
	          <c:if test="${12 le MTH}"> ['Dec', ${ytm_tmp.dec}, ${ytm_tmp.monthly_target}], </c:if>
	         // ['YTD', ${ytm_tmp.ytm_actual},${ytm_tmp.ytm_target}], 
			 </c:otherwise>
			 </c:choose>
		     </c:forEach>
			 </c:if>
				<c:if test="${BILLS4_SUMM eq null or empty BILLS4_SUMM}">
				      <c:if test="${1 le MTH}"> ['Jan', 0,0],  </c:if>
			         <c:if test="${2 le MTH}">['Feb', 0,0],  </c:if>
			         <c:if test="${3 le MTH}">['Mar',0,0], </c:if>
			         <c:if test="${4 le MTH}"> ['Apr', 0,0], </c:if>
			         <c:if test="${5 le MTH}"> ['May', 0,0], </c:if>
			         <c:if test="${6 le MTH}"> ['Jun', 0,0], </c:if>
			         <c:if test="${7 le MTH}">['Jul', 0,0],  </c:if>
			         <c:if test="${8 le MTH}">['Aug', 0,0], </c:if>
			         <c:if test="${9 le MTH}"> ['Sep', 0,0], </c:if>
			         <c:if test="${10 le MTH}">['Oct',0,0], </c:if>
			         <c:if test="${11 le MTH}"> ['Nov', 0,0], </c:if>
			         <c:if test="${12 le MTH}"> ['Dec',0,0], </c:if>
			       //  ['YTD', 0,0],
				</c:if>
       
      ]);

          // Set chart options
          var options = {'title':'Total Yearly  Billing Target : <c:forEach var="ytm_tmp" items="${BILLS4_SUMM}"> <fmt:formatNumber type="number"   value="${ytm_tmp.yr_total_target}" />\r\n  YTD Target:<fmt:formatNumber type="number"   value="${ytm_tmp.ytm_target}"/>\r\nYTD Actual:<fmt:formatNumber type="number"   value="${ytm_tmp.ytm_actual}"/></c:forEach>  ',	
        	   			  'vAxis': {title: 'Amount (In Millions)',titleTextStyle: {italic: false},viewWindow:{ min:0},format: 'short'}, 
        		
        		   'is3D':true,
  		         titleTextStyle: {
  				      color: '#000',
  				      fontSize: 13,
  				      fontName: 'Arial',
  				      bold: true
  				   },
  				 series: {
        	            0: {targetAxisIndex: 0},	 
        	            1: {targetAxisIndex: 0,type: 'line'},
        	            2: {targetAxisIndex: 0,type: 'line'}
        	          },
  		         'chartArea': {
					        top: 70,
					        right: 12,
					        bottom: 48,
					        left: 60,
					        height: '100%',
					        width: '100%'
					      },
					   //   bar: { groupWidth: "25%" },
					      pointSize:4,
					     bar: { groupWidth: "25%" },
					      'height': 240,
					      'legend': {
					        position: 'top'
					      },
					      colors: ['#007bff', 'green'],
					      hAxis: { slantedText:true, slantedTextAngle:90 }
		  };
          

          // Instantiate and draw our chart, passing in some options.
          var chart = new google.visualization.ColumnChart(document.getElementById('prf_billings4_ytd'));
          chart.draw(data, options);
          
          
          google.visualization.events.addListener(chart, 'onmouseover', uselessHandlerbl2);
          google.visualization.events.addListener(chart, 'onmouseout', uselessHandlerbl3);
          google.visualization.events.addListener(chart, 'select', selectHandlerbl);
          function uselessHandlerbl2() {$('#prf_billings4_ytd').css('cursor','pointer')}
          function uselessHandlerbl3() {$('#prf_billings4_ytd').css('cursor','default')}
         function selectHandlerbl() {
      	 
          var selection = chart.getSelection();
          var message = '';
          for (var i = 0; i < selection.length; i++) {
          var item = selection[i];
          if (item.row != null && item.column != null) {
          var str = data.getFormattedValue(item.row, 1); // var str = data.getFormattedValue(item.row, item.column);
          var aging = data.getValue(chart.getSelection()[0].row, 0)
         
          
         
          
         
          }
          }
        
         //alert('You selected ' + aging+" "+str);
         
          var ttl="<b>Billing Target vs  Stage-4 Amount Details of  </b><strong style='color:blue;'>${selected_salesman_code}</strong> for  <strong style='color:blue;'>"+aging+" - ${syrtemp}</strong>";
          var bexclttl="Billing Target vs  Stage-4 Amount Details of  ${selected_salesman_code} for "+aging+" - ${syrtemp}";
          $("#billings4-modal-graph .modal-title").html(ttl);

        $.ajax({
 	    		 type: 'POST',
 	        	 url: 'sip', 
 	        	 data: {fjtco: "blngs4_dt", scmbl:"${selected_salesman_code}" , bl1:aging, bl2:"${syrtemp}"},
 	        	 dataType: "json",
 		  		 success: function(data) {
 		  		
 		  		
 		  			var output="<table id='blngs4_main' class='table table-bordered small'><thead><tr>"+
 		  			"<th>#</th><th>Company</th><th>Week</th><th>Document Id</th><th>Document Date</th>"+
		  			 "<th>Party Name</th><th>Contact</th><th>Telephone</th>"+
				      "<th>Project Name</th><th>Product</th>  <th>Zone</th><th>Currency</th><th>Amount (AED)</th></tr></thead><tbody>";
					  var j=0;
 				      for (var i in data)
 					 {
 				    	  j=j+1;

 					 output+="<tr><td>"+j+"</td><td>" +  $.trim(data[i].d1) + "</td>"+
 					 "<td>" +  $.trim(data[i].d2) + "</td><td>" +  $.trim(data[i].d3)+ "</td>"+
 					 "<td>" +  $.trim(data[i].d4.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+
 					 "<td>" +  $.trim(data[i].d7) + "</td>"+
 					"<td>" +  $.trim(data[i].d8) + "</td><td>" +  $.trim(data[i].d9) + "</td>"+
 					 "<td>" +  $.trim(data[i].d10) + "</td><td>" +  $.trim(data[i].d11) + "</td>"+
 					 "<td>" +  $.trim(data[i].d12) + "</td><td>" +  $.trim(data[i].d13) + "</td>"+
 					 "<td>" +  $.trim(data[i].d14) + "</td>"+
 					 "</tr>";
 					 }
 				     //output+="<tr><td colspan='12'><b>Total</b></td><td><b>"+str+"</b></td></tr>";
 					 output+="</tbody></table>";
 					
 		  			  $("#billings4-modal-graph .modal-body").html(output);
 		  			$("#billings4-modal-graph").modal("show");
 		  		 $('#blngs4_main').DataTable( {
 			        dom: 'Bfrtip',  
 			       "columnDefs" : [{"targets":[4], "type":"date-eu"}],
 			        buttons: [
 			            {
 			                extend: 'excelHtml5',
 			                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
 			                filename: bexclttl,
 			                title: bexclttl,
 			                messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'
 			                
 			                
 			            }
 			          
 			           
 			        ]
 			    } );
 		  			
 		  },
 		  error:function(data,status,er) {
 			 
 		    alert("please click again");
 		   }
 		 });
         
        //start  script for deselect column - on modal close
        chart.setSelection([{'row': null, 'column': null}]); 
      //end  script for deselect column - on modal close
         }
        }

      
      //////
      //CUSTOME VISIT PERFORMANCE START
  function drawCustomerVisitPerfomanceSummary() {
	  var totalVisitCounts = 0;
	  var weeklyvisittarget = '${WKLYTRGT}';
	  var avergeYearlyVisitCounts = Math.round((weeklyvisittarget*52)/12);	 
	  var visits = <%=new Gson().toJson(request.getAttribute("SEYRLYCVS"))%>; 
	  var moreInfoDtls = "<table id='cvMoreInfo' ><thead><th>Month</th><th>Visit Count</th><th>Average Monthly Target</th></thead><tboady>"
	  var arr = [];
	  arr[0] =  ['Month', 'Total Visits','Average Monthly Target'];
	  var currentMonth= parseInt('${MTH}'); 
	  var strMth = 0; 
	 /*  if(slctdYear < currYear){ 
		  for(strMth = 1; strMth <= 12; strMth++){
			     var monthName = getCustomeMonth(strMth);
		    	 var totVisits = visits.find( item =>  item.month === strMth); 
		    	 if(typeof totVisits === 'undefined'){
		    		 arr[strMth]=[monthName,0,avergeYearlyVisitCounts];
		    		 moreInfoDtls += "<tr><td>"+monthName+"</td><td>0</td><td>0</td></tr>";
		    	 }else{
		    		 totalVisitCounts += parseInt(totVisits['totalVisits']);
		    		 arr[strMth]=[monthName, totVisits['totalVisits'],avergeYearlyVisitCounts];
		    		 moreInfoDtls += "<tr><td>"+monthName+"</td><td>"+totVisits['totalVisits']+"</td><td>"+avergeYearlyVisitCounts+"</td></tr>";
		    	 }
		    	 
		     }
	  }else{ */
		  for(strMth = 1; strMth <= currentMonth; strMth++){
			     var monthName = getCustomeMonth(strMth);
		    	 var totVisits = visits.find( item =>  item.month === strMth); 
		    	 if(typeof totVisits === 'undefined'){
		    		 arr[strMth]=[monthName,0,avergeYearlyVisitCounts];
		    		 moreInfoDtls += "<tr><td>"+monthName+"</td><td>0</td><td>0</td></tr>";
		    	 }else{
		    		 totalVisitCounts += parseInt(totVisits['totalVisits']);
		    		 arr[strMth]=[monthName, totVisits['totalVisits'],avergeYearlyVisitCounts];
		    		 moreInfoDtls += "<tr><td>"+monthName+"</td><td>"+totVisits['totalVisits']+"</td><td>"+avergeYearlyVisitCounts+"</td></tr>";
		    	 }
		    	 
		     }
	 // }
	  
	  moreInfoDtls += "</tboady></table>"
		  $("#cvMoreInfoModal .modal-body").html(moreInfoDtls); 
     // Create the data table.
    cVdata = google.visualization.arrayToDataTable(arr);    
     // Set chart options
     var options = {'title':'Total Visit Counts - '+totalVisitCounts+''+' \r\n   Weekly Visit Target : ${WKLYTRGT}',	
    		   'vAxis': {title: 'Visit Counts',titleTextStyle: {italic: false},viewWindow:{ min:0},format: 'short'}, 
   		
   		   'is3D':true,
		         titleTextStyle: {
				      color: '#000',
				      fontSize: 13,
				      fontName: 'Arial',
				      bold: true
				   },
			    series: {
       	            0: {targetAxisIndex: 0},	 
       	            1: {targetAxisIndex: 0,type: 'line'},
       	            2: {targetAxisIndex: 0,type: 'line'}
       	          },
		         'chartArea': {
				        top: 70,
				        right: 12,
				        bottom: 48,
				        left: 60,
				        height: '100%',
				        width: '100%'
				      },
				     // bar: { groupWidth: "25%" },
				      pointSize:4,
				      bar: { groupWidth: "25%" },	
				      'height': 240,
				      'legend': {
				        position: 'top'
				      },
				      colors: ['#ffeb3b','#008000'],
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
   
   var ttl="<b>Customer Visit Details of   </b><strong style='color:blue;'>${selected_salesman_code}</strong> for  <strong style='color:blue;'>"+aging+" - ${syrtemp}</strong>";
   var exclTtl="Customer Visit Details of   ${selected_salesman_code}  for   "+aging+" - ${syrtemp} ";
   var month = moment().month(aging).format("M");
   $("#cv-modal-graph .modal-title").html(ttl);

 $.ajax({
  		 type: 'POST',
      	 url: 'sip', 
      	 data: {fjtco: "cvDoSegfcYrmth", cvSeg:"${selected_salesman_code}" , cvMth:month, cvYr:"${syrtemp}"},
      	 dataType: "json",
	  		 success: function(data) {
	  		
	  		
	  			var output="<table id='cvDtlsTable' class='table table-bordered small'><thead><tr>"+
	  			"<th>#</th><th>Doc. ID</th><th>Visit Date</th><th>Visit Type</th><th>Visit Desc.</th><th>Projct/Party</th><th>Customer Name</th><th>Customer Contact No.</th>"+
	  			 "<th>Visit Time</th><th>Total Time Spent (Hrs)</th>"+
			      "</tr></thead><tbody>";
				  var j=0;
			      for (var i in data)
				 {
			    	  j=j+1;

				 output+="<tr><td>"+j+"</td><td>" +  $.trim(data[i].documentId) + "</td>"+
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
		        "columnDefs" : [{"targets":2, "type":"date-eu"}],
		        order: [[2, 'desc']],
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
      function drawBlngLast3YrsVisualization() {
	   // billing summary for previous years 
						   var data = google.visualization.arrayToDataTable([
							   ['Year', 'Actual' ,{type: 'string', role: 'tooltip'}, 'Target' ,{type: 'string', role: 'tooltip'}],    
						    <c:choose>
						     <c:when test='${!empty BSFLTY}'>
						    <c:forEach var="blngl3analysis" items="${BSFLTY}">    
						    
						    ['${blngl3analysis.year}',<fmt:formatNumber pattern='#,###' value='${blngl3analysis.ytm_actual/1000000}' />,
						    	'Actual Details - ${blngl3analysis.year} \r\n  Actual (ytd) : <fmt:formatNumber pattern='#,###' value='${blngl3analysis.ytm_actual}' />',
						    	<fmt:formatNumber pattern='#,###' value='${blngl3analysis.ytm_target/1000000}' />,
                                 'Target Details - ${blngl3analysis.year} \r\n  Total Yearly Target: <fmt:formatNumber pattern='#,###' value='${blngl3analysis.yr_total_target}' /> \r\n  Target (Ytd): <fmt:formatNumber pattern='#,###' value='${blngl3analysis.ytm_target}' /> '],
						    </c:forEach>
						    </c:when>
						     <c:otherwise>
						    
						     ['2016', 0, '', 0, ''],
						     ['2017', 0, '', 0, ''],
						     ['2018', 0, '', 0, ''],
						     </c:otherwise>
						     </c:choose>
						 ]);
						var view = new google.visualization.DataView(data);
						 view.setColumns([0, 1,
						                  { calc: "stringify",
						                    sourceColumn: 1,
						                    type: "string",
						                    role: "annotation" },
						                  2,3,{
						   calc: "stringify",
						   sourceColumn: 3, 
						   type: "string",
						   role: "annotation"
						},4]);
						var options = {
				       // title : ' BILLING LAST 2 YEARS ANALYSYS - YTD',
						 titleTextStyle: {
						     color: '#000',
						     fontSize: 13,
						     fontName: 'Arial',
						     bold: true,
						    
						  },
						  'chartArea': {
						        top: 30,
						        right: 12,
						        bottom: 48,
						        left: 50,
						        height: '100%',
						        width: '100%'
						      },
						 vAxis: {title: 'Value in Millions'},
						
					          vAxes: {
					            // Adds titles to each axis.
					            0: {title: 'Value in Millions',viewWindow:{ min:0}, format: 'short'},
					            
					          },
					    
					      
						 colors: ['#0c3d6d', '#cd3f15'],
						 'is3D':true,
						  
						      'height': 230,
						      'legend': {
						        position: 'top'
						      }
					, tooltip: { textStyle: { fontName: 'verdana', fontSize: 12 } }
	};

	var chart = new google.visualization.ColumnChart(document.getElementById('blng_sum_3_yr'));

	chart.draw(view, options);
	 chart.setSelection([{'row': null, 'column': null}]); 
 }
 
 
 // implemented graph in stage details
 
   document.addEventListener('DOMContentLoaded', function() {
  	    // Attach click event listener to open modal button
  	    document.getElementById('openModalBtn').addEventListener('click', function() {
  	        // Display the modal
  	        document.getElementById('myModal').style.display = 'block';    
  	    
  	        var s2Data = $("#s2sum_temp").val() !== 0 ? parseFloat($("#s2sum_temp").val()) : 0;
  	        var s3Data =$("#s3sum_temp").val() !== 0 ? parseFloat($("#s3sumnoformat").val()) : 0;
  	        var s4Data = $("#s4sum_temp").val() !== 0 ? parseFloat($("#s4sumnoformat").val()) : 0;
  	        var s5Data = $("#s5sum_temp").val() !== 0 ? parseFloat($("#s5sumnoformat").val()) : 0;
			
  	        // Check if the data for s2, s3, s4, and s5 is available
  	        if (!isNaN(s2Data) && !isNaN(s3Data) && !isNaN(s4Data) && !isNaN(s5Data)) {
  	            // Data is available, draw the chart
  	            drawChart(s2Data,s3Data,s4Data,s5Data);
  	        } else {
  	            // Data is not available, handle the situation (e.g., display a message)
  	            console.log('Data for s2, s3, s4, and s5 is not available');
  	        }
  	    });

  	    // Attach click event listener to close modal button
  	    document.getElementsByClassName('close')[0].addEventListener('click', function() {
  	        // Hide the modal
  	        document.getElementById('myModal').style.display = 'none';
  	    });

  	    // Function to draw the Google Chart
  	    function drawChart(s2Data,s3Data,s4Data,s5Data) {
  	    	
  	        var data = google.visualization.arrayToDataTable([
  	            ['Sales Engineer', 'Stages', { role: 'style' },{ role: 'annotation' }],
  	            ['S2', s2Data, '#dd4b39',new Intl.NumberFormat('en-US', { style: 'decimal', maximumFractionDigits: 2 }).format(s2Data / 1000000)],
  	            ['S3', s3Data, '#f39c12',new Intl.NumberFormat('en-US', { style: 'decimal', maximumFractionDigits: 2 }).format(s3Data / 1000000)],
  	            ['S4', s4Data, '#0073b7',new Intl.NumberFormat('en-US', { style: 'decimal', maximumFractionDigits: 2 }).format(s4Data / 1000000)],
  	            ['S5', s5Data, '#00a65a',new Intl.NumberFormat('en-US', { style: 'decimal', maximumFractionDigits: 2 }).format(s5Data / 1000000)]
  	        ]);

  	        var options = {
  	           // title: 'My Daily Activities'
  	        		vAxis: {minValue: 0,title: 'Amount',  titleTextStyle: {color: '#333'},format: 'short'},
  	        		 legend: { position: 'top' },
  	        		colors: ['#FF5733', '#3498DB', '#F1C40F', '#27AE60'] 
  	        };

  	        var chart = new google.visualization.ColumnChart(document.getElementById('stagedetailsgraph'));
  	        chart.draw(data, options);
  	    }
  	}); 
                                
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
      		 <li><a href="SipBranchPerformance"><i class="fa fa-building-o"></i><span>Branch Performance</span></a></li>
      		 <li><a href="SalesManagerInfo.jsp"><i class="fa fa-building-o"></i><span>Sales Manager Performance</span></a></li>
      		</c:if>
             <li   class="active"><a href="DmInfo.jsp"><i class="fa fa-dashboard"></i><span>Sales Engineers Performance</span></a></li>
              <c:if test="${isAllowed eq 'Yes' || fjtuser.salesDMYn ge 1}">
      		 		<li><a href="SalesManagerInfo.jsp"><i class="fa fa-building-o"></i><span>Sales Manager Performance</span></a></li>
      			</c:if>
             <li><a href="DisionInfo.jsp"><i class="fa fa-line-chart"></i><span>Sub Division Performance </span></a></li>
             <li ><a href="CompanyInfo.jsp"><i class="fa fa-pie-chart"></i><span>Division Performance</span></a></li>
             <li><a href="SipUserActivity"><i class="fa fa-table"></i><span>SE Activity History</span></a></li>
<!--              <li><a href="SipJihDues"><i class="fa fa-table"></i><span>JIH Dues</span></a></li>    -->
<!--              <li><a href="SipLOIDues"><i class="fa fa-table"></i><span>LOI Dues</span></a></li> -->
             <li><a href="SipStageFollowUpController"><i class="fa fa-database"></i><span>Stage Follow-Up</span></a></li>
             <li><a href="sipWeeklyReport"><i class="fa fa-bar-chart"></i><span>Weekly-Sales Report</span></a></li>
              <li><a href="ProjectStatus"><i class="fa fa fa-bars"></i><span>Project Status</span></a></li>
             <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>
         
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper" style="margin-top: -8px;">
    <!-- Content Header (Page header) -->
   <!--  <section class="content-header">
      <h1>
      ${selected_salesman_code}- 
        <small>Sales Egr. Performance Dashboard</small>
      </h1>
     
    </section>--> 

    <!-- Main content -->
    <div class="row">
    <div class="col-md-9 form-group" style="width:74%">
  <form class="form-inline" method="post" action="sip" id="sf"> 
  <br/>
  <c:set var="sales_egr_code" value="${selected_salesman_code}" scope="page" /> 
  <select class="form-control form-control-sm select2" name="scode" id="scode" required  onchange="sm_view_details();" >  
<%-- Commented not to display management user details in the list --%>
<%--     <c:if test="${fjtuser.role eq 'mg'}">   --%>
<%-- 	 <option ${fjtuser.sales_code  == selected_salesman_code ? 'selected':''} value="${fjtuser.sales_code}" role="${fjtuser.uname}">${fjtuser.uname} -(${fjtuser.sales_code})</option> --%>
<%-- 	</c:if> --%>
    <c:if test="${fjtuser.role eq 'mg'}">  
	 	<option>Select Sales Engineer</option>
	</c:if>
   	<c:forEach var="s_engList"  items="${SEngLst}" >
	  	<c:choose>
	  			<c:when test="${fjtuser.role eq 'mg'}">	  					  				
					<option value="${s_engList.salesman_code}" ${s_engList.salesman_code  == selected_salesman_code ? 'selected':''} role="${s_engList.salesman_name}">${s_engList.salesman_name} (${s_engList.salesman_code})</option>
	  			</c:when>
	  			<c:when test="${fjtuser.salesDMYn ge 1 and fjtuser.role ne 'mg'}">
	  				<option value="${s_engList.salesman_code}" ${s_engList.salesman_code  == selected_salesman_code ? 'selected':''} role="${s_engList.salesman_name}">${s_engList.salesman_name} (${s_engList.salesman_code})</option>
	  			</c:when>
	  			<c:otherwise>
	  				<option selected value="${fjtuser.sales_code}" role="${fjtuser.uname}">${fjtuser.sales_code} - ${fjtuser.uname}</option>
	  			</c:otherwise>
	 		 </c:choose>
  		</c:forEach> 						
	</select>
						
						  <select class="form-control form-control-sm  select2" name="syear" id="syear" onchange="sm_view_details();" >
  						<option selected value="<%=iYear%>">Select Year</option>
  						
   						 <%
                        // start year and end year in combo box to change year in calendar
                         for(int iy=iYear;iy>=2006;iy--)
                            {
                            
                             %>
                             <c:set var="syrtemp1" value="<%=iy%>" scope="page" />
                             <option value="<%=iy%>" ${syrtemp1  == selected_Year ? 'selected':''}> <%=iy%></option>
                            <%
                             
                        }
                        %>
						</select>
						
					 <input type="hidden" name="fjtco" value="salesChart" />
					 <input type="hidden" name="salesEngName" id="salesEngName"/>
<!--    					<button type="submit" id="sf" class="btn btn-sm btn-primary" onclick="sm_view_details();">View</button> -->
					<button type="button"  id="seperfdiv" class="btn btn-sm btn-primary"   onclick="sm_performance_details();"><i class="fa fa-share" aria-hidden="true"></i> PERFORMANCE</button>
				</form> 
				 </div>
				<div class="col-md-4 col-xs-12" style="width:26%;float:right;">
  <ul class="nav nav-tabs pull-right" id="stage14-box">
         <li  class="active pull-right" style="    margin-bottom: 0px !important;"><a data-toggle="tab" href="#bb1-meter"  style="border-right:transparent;" >Target %</a></li>
          <li class="pull-right"><a data-toggle="tab" href="#stages-dt" onclick="s34Summary();">Stage Details</a></li>
         
          
          </ul>
         </div> 
   </div>
   <div class="row">
   
   <div  class="col-lg-9 col-md-9 col-sm-12 fjtco-table"  style="padding:7px;">
   <c:forEach var="rcvbl_list_date"  items="${ORAR}" > <c:set var="rcvble_date" value="${rcvbl_list_date.pr_date}" scope="page" /> </c:forEach>
   
    <c:set var ="recievable_date" value = "${fn:substring(rcvble_date, 0, 10)}" />
   
 <b style="font-size:15px !important;font-weight:bold !important;"> Outstanding Receivable Aging  (Value in base local currency) > 100AED&nbsp;</b> <i>As on 

<fmt:parseDate value="${rcvble_date}" var="theDate"    pattern="yyyy-MM-dd HH:mm" />
<fmt:formatDate value="${theDate}" pattern="dd-MM-yyyy, HH:mm"/>
   AM</i>
 
 




          
            
					  
      
        <div class="row">
     
					<div class="col-lg-2 col-md-3 col-sm-3 col-xs-12 paddingr-0" style="width:112px;" id="agwdth110">
						<div class="panel panel-default card-view pa-0">
							<div class="panel-wrapper collapse in">
								<div class="panel-body pa-0">
									<div class="sm-data-box">
										<div class="container-fluid">
											<div class="row">
													<span class="weight-500 font-13"><30 Days</span><br/>
													<span class="counter-anim" onclick="show2ndLayerOutRcvbles('${sales_egr_code}','30','<30 Days');"><fmt:formatNumber pattern="#,###" value="${aging30}" /></span>		
											</div>	
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
						<div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 padding-0" style="width:112px;" id="agwdth112">
						<div class="panel panel-default card-view pa-0">
							<div class="panel-wrapper collapse in">
								<div class="panel-body pa-0">
									<div class="sm-data-box">
										<div class="container-fluid">
											<div class="row">	
													<span class="weight-500">31-60 Days</span><br/>
													<span class="counter-anim"  onclick="show2ndLayerOutRcvbles('${sales_egr_code}','3060','31 - 60 Days');"><fmt:formatNumber pattern="#,###" value="${aging3060}" /></span>
												</div>
											</div>	
										</div>
									</div>
								</div>
							</div>
						</div>
					
				
					<div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 padding-0" style="width:112px;" id="agwdth112">
						<div class="panel panel-default card-view pa-0">
							<div class="panel-wrapper collapse in">
								<div class="panel-body pa-0">
									<div class="sm-data-box">
										<div class="container-fluid">
											<div class="row">
													<span class="weight-500 font-13">61-90  Days</span>	<br/>
													<span class="counter-anim" onclick="show2ndLayerOutRcvbles('${sales_egr_code}','6090','61 - 90 Days');"><fmt:formatNumber pattern="#,###" value="${aging6090}" /></span>
											</div>	
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 padding-0" style="width:112px;" id="agwdth110">
						<div class="panel panel-default card-view pa-0">
							<div class="panel-wrapper collapse in">
								<div class="panel-body pa-0">
									<div class="sm-data-box">
										<div class="container-fluid">
											<div class="row">
													<span class="weight-500">91-120 Days</span><br/>
													<span class="counter-anim"  onclick="show2ndLayerOutRcvbles('${sales_egr_code}','90120','91 - 120 Days');"><fmt:formatNumber pattern="#,###" value="${aging90120}" /></span>
											</div>	
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
						<div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 padding-0" style="width:120px;" id="agwdth112">
						<div class="panel panel-default card-view pa-0">
							<div class="panel-wrapper collapse in">
								<div class="panel-body pa-0">
									<div class="sm-data-box">
										<div class="container-fluid">
											<div class="row">	
													<span class="weight-500">121-180  Days</span><br/>
														<span class="counter-anim"  onclick="show2ndLayerOutRcvbles('${sales_egr_code}','120180','121 - 180 Days');"><fmt:formatNumber pattern="#,###" value="${aging120180}" /></span>
											</div>	
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
			
					<div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 paddingl-0" style="width:120px;" id="agwdth112">
						<div class="panel panel-default card-view pa-0">
							<div class="panel-wrapper collapse in">
								<div class="panel-body pa-0">
									<div class="sm-data-box">
										<div class="container-fluid">
											<div class="row">
													<span class="weight-500">>180  Days</span><br/>
													<span class="counter-anim"  onclick="show2ndLayerOutRcvbles('${sales_egr_code}','181','>180 Days');"><fmt:formatNumber pattern="#,###" value="${aging181}" /></span>
											</div>	
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
			
				</div>

	   
	</div>
	
	
	<div  class="col-lg-3 col-md-3 col-sm-12 fjtco-table"  style="padding:7px;" id="s23"><b>Job Moved to Stage 3</b>
	<div class="row"  id="jobmv23">
	 <span class="info-box-icon bg-green" onclick="showstage3Jobs();"><i class="fa fa-cloud-download"></i></span>

            <div class="info-box-content">
              <span class="info-box-text">Week <b>${currWeek - 1}</b> to <b>${currWeek}</b> </span>
              <span class="info-box-text" style="font-size:70%;">(Details across all divisions)</span>
            </div>
            <!-- /.info-box-content -->
          </div>
	
	</div>
	
	
	
	</div>

	   
	   <div class="row">
        <div class="col-md-6">
          <!-- JIH BOX -->
          <div class="box box-primary" style="margin-bottom: 8px;border-color:#607d8b;">
                      <div class="box-header with-border">
						 
						 <h3 class="box-title" id="jihlost-title">Job In Hand Volume Details  </h3>                                        
          <ul class="nav nav-tabs pull-right" id="jihlostdiv" style=" margin-top: -10px;font-weight: bold;">
           <li  class="active pull-right" onclick="changeTitle('Job In Hand Volume Details');"><a data-toggle="tab" href="#jih-dt"  style="border-right:transparent;" ><i class="fa fa-square text-green"> JIHV</i></a></li>
           <li class="pull-right" onclick="changeTitle('JIH (All) Vs LOST DETAILS');"><a data-toggle="tab" href="#lost-dt" ><i class="fa fa-square text-red" > LOST</i></a></li>         
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
																		type="number" pattern="#,###.##"
																		value="${JOBVL.aging1_amt_actual/1000000}" />M</span></td>
															<td><span class="description-percentage text-green"><i
																	class="fa fa-caret-up"></i> <fmt:formatNumber
																		type="number" pattern="#,###.##"
																		value="${JOBVL.aging2_amt_actual/1000000}" />M</span></td>
															<td><span class="description-percentage text-green"><i
																	class="fa fa-caret-up"></i> 
																	<fmt:formatNumber
																		type="number" pattern="#,###.##"
																		value="${JOBVL.aging3_amt_actual/1000000}" />M</span></td>
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
            </div>
            
            
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->

          <!-- Booking CHART -->
     
      <div class="box box-danger" style="margin-bottom: 10px;border-color:#607d8b;">
           <div class="box-header with-border">			
			<c:choose>
 				<c:when test="${syrtemp < CURR_YR}">
 				 	 <h4 class="box-title" >Booking Analysis ${syrtemp},(FY)</h4> 
 				</c:when>
 				<c:otherwise>
 				  <h4 class="box-title" >Booking Analysis ${syrtemp},(YTD)</h4>  
 				</c:otherwise>
 			</c:choose>
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
            <!-- /.box-body -->
          </div>
         
          <!-- /.box -->
         
               <!-- box -->    
                <div class="box box-danger" style="margin-bottom: 8px;border-color:#607d8b;">
                         <div class="box-header with-border">
           <c:choose>
 				<c:when test="${syrtemp < CURR_YR}">
 				 	 <h4 class="box-title">Customer Visit Analysys - ${syrtemp},(FY)</h4> 
 				</c:when>
 				<c:otherwise>
 				  <h4 class="box-title" >Customer Visit Analysys - ${syrtemp},(YTD)</h4>  
 				</c:otherwise>
 			</c:choose>
 			</div>  
            <div class="box-body">
                <div class="chart">
                    <div id="cv_pfm_ytd" style="height:230px;margin-top:-10px;"></div>  <br/>
               <div class="overlay">
				<a href="#" data-toggle="modal" data-target="#cvMoreInfoModal">More info
				 <i class="fa fa-arrow-circle-right"></i></a> </div> 
              </div> 
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box --> 
				
	   
   
             <!-- Billing Last 3 years chart CHART -->
  
      <div class="box box-danger" style="margin-bottom: 8px;border-color:#607d8b;right:10px;">
           <div class="box-header with-border">
			<h3 class="box-title" >Billing  3 Years Analysis of ${selected_salesman_code} -(YTD)</h3>
			</div>
            <div class="box-body">
              <div id="blng_sum_3_yr" style="height:230px;margin-top:-10px;"></div>  <br/>
               <div class="overlay">
				<a href="#" data-toggle="modal" data-target="#blng3yr_moreinfo_modal">More info
				 <i class="fa fa-arrow-circle-right"></i></a> </div>
            </div>
            <!-- /.box-body -->
          </div>
         
          <!-- /.box -->
        </div>
        
        <!-- /.col (LEFT) -->
        <div class="col-md-6">
        
         
        
          <!-- Stage 3 4 CHART -->
         
          <!-- Custom tabs (Charts with tabs)-->
        <section style="margin-bottom: -12px;border-top: 3px solid #607d8b; border-radius: 3px;margin-right: 10px;">
         <div class="nav-tabs-custom" >
         
        
           <div class="tab-content" style="height: 280px;">
           <div id="stages-dt" class="tab-pane fade">
             <div class="row">
			  <div class="box-header with-border" style="margin-top: -10px;"> 
			      <h3 class="box-title">STAGE DETAILS </h3>
			      <div class="help-right-stage" id="help-stages">
						<i class="fa fa-info-circle pull-left"></i>
					</div>
			  </div>
			  <!--  commented to show stage2,3,4, and 5 as part of RK comments -->
	          <!--     <div class="col-lg-6 col-xs-6"><c:set var="jihv_total" value="0" scope="page" /> <c:forEach var="JOBV" items="${JIHV}">
	              <c:set var="jihv_total" value="${jihv_total + JOBV.amount}" scope="page" /> </c:forEach> 
			 	  <div class="small-box bg-red">
	              <div class="inner"> 
	                <h3>Stage 1</h3><p id="s1sum"></p>
	                <input type="hidden" id="s1sum_temp" value="0" />
				  </div>
	              <div class="icon"><i class="fa fa-pie-chart"></i></div>
	              <a href="#" onclick="s1Details();" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a></div>
				  </div> -->
  
	              <div class="col-lg-6 col-xs-6">
	              <div class="small-box bg-red">
	              <div class="inner"><h3>Stage 2</h3><p> <strong><fmt:formatNumber type="number"  pattern="#,###.##" value="${jihv_total/1000000}" />M</strong></p>
	              	<input type="hidden" id="s2sum_temp" value="${jihv_total}" />
	              </div> <div class="icon"><i class="fa fa-pie-chart"></i> </div>
					<a href="#" onclick="s2Details();"  class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
	              </div></div>
	              <div class="col-lg-6 col-xs-6" >
					  <div class="small-box bg-yellow">
			          <div class="inner">
	                  <h3>Stage 3</h3><p id="s3sum"></p>
	                  <input type="hidden" id="s3sum_temp" value="0" />
	                  <input type="hidden" id="s3sumnoformat" value="0" />
	                  </div> <div class="icon"><i class="fa fa-pie-chart"></i></div>
	                  <a href="#" onclick="s3Details(document.getElementById('s3sum_temp').value);"  class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
	                  </div>
			      </div>

             </div>
		
	   		  <div class="row" > 
       	          <div class="col-lg-6 col-xs-6" style="margin-top:-17px;">
				  <div class="small-box bg-blue">
	              <div class="inner">
	              <h3>Stage 4</h3> <p id="s4sum"></p>
	              <input type="hidden" id="s4sum_temp" value="0" />
	              <input type="hidden" id="s4sumnoformat" value="0" />
	              </div>
	              <div class="icon"><i class="fa fa-pie-chart"></i></div>
	              <a href="#" onclick="s4Details(document.getElementById('s4sum_temp').value);"  class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
	              </div>
				  </div>
				  <div class="col-lg-6 col-xs-6" style="margin-top:-17px;">
					  <div class="small-box bg-green">
		              <div class="inner">
		              <h3>Stage 5</h3> <p id="s5sum"></p>
		              <input type="hidden" id="s5sum_temp" value="0" />
		              <input type="hidden" id="s5sumnoformat" value="0" />
		              </div>
		              <div class="icon"><i class="fa fa-pie-chart"></i></div>
		              <a href="#" onclick="s5Details(document.getElementById('s5sum_temp').value);"  class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
		              </div>
				  </div>
	   	     </div>
			 <div class="stage-details-graph" id="openModalBtn">
						<i class="fa fa-bar-chart fa-1x"></i>
			 </div>
<!-- 	   	      <div id="stagedetailsgraph" style="width: 900px; height: 500px;"></div> -->
         </div>
    <div id="bb1-meter" class="tab-pane fade  in active" >
    <div class="row" > 	
     <div class="box-header with-border" style="margin-top: -10px;"> 
      <h3 class="box-title">Target Vs Actual  Achieved  %  for  ${syrtemp} -
	     <c:choose>
			 	<c:when test="${syrtemp lt CURR_YR}">
			 		  (FY)
			 	</c:when>
			 	<c:otherwise>		
			  		  (YTD)
			 	</c:otherwise>
	 		</c:choose>
     </h3>
     <style>
  .bg-color-1 {
    background-color: #ff9999; /* Change to your desired color */

 
  }
  
  .bg-color-3 {
    background-color: #99ff99; /* Change to your desired color */
   
 
  }
 .align-right {
    display: inline-block;
    text-align: right;
    width: 60px; /* Adjust width as needed */
}
 
</style>
 <h6>
  &nbsp;  &nbsp; &nbsp;  &nbsp;   &nbsp;  &nbsp;<span class="bg-color-1"> Booking Target: <span class="align-right"><fmt:formatNumber type="number" value="${guage_bkng_ytd_target}"/></span></span>
  &nbsp;  &nbsp; ||
  &nbsp; &nbsp;
  &nbsp;  <span class="bg-color-3"> Billing Target: <span class="align-right"><fmt:formatNumber type="number" value="${guage_blng_ytd_target}"/></span></span>
</h6>

<h6>
  &nbsp;  &nbsp; &nbsp;  &nbsp; &nbsp;  &nbsp; <span class="bg-color-1"> Booking Actual: <span class="align-right"><fmt:formatNumber type="number" value="${actual}"/></span></span>
  &nbsp;  &nbsp; ||
  &nbsp;  &nbsp;
  &nbsp;   <span class="bg-color-3"> Billing Actual: <span class="align-right"><fmt:formatNumber type="number" value="${actualbl}"/></span></span>
</h6>
 
      </div>		
	   <div class="row">
	   			 <div class="col-lg-1 col-xs-0" ></div>
	   			 
	   			<div class="col-lg-5 col-xs-6 sep">
    <div id="guage_test_booking" style="background-color: #ff9999;"></div>
</div>
	   			
	   		
       	          <div class="col-lg-5 col-xs-6"> <div id="guage_test_billing" style="background-color: #99ff99;"></div>
		          </div><div class="col-lg-1 col-xs-0" ></div>
		          </div>
     </div>
       </div>
          
     </div>
     
      </div>
        </section>

        
         <!-- BILLING CHART -->
          <div class="box box-success" style="margin-bottom: 8px;border-color:#607d8b;right:2px;">
               <div class="box-header with-border">						 
						 <c:choose>
							<c:when test="${syrtemp < CURR_YR}">
								<h7 class="box-title" id="blng-graph-title">Billing Analysis - ${syrtemp},(FY)</h7> 
							</c:when>
							<c:otherwise>
							 	<h7 class="box-title" id="blng-graph-title">Billing Analysis - ${syrtemp},(YTD)</h7>  
							</c:otherwise>
						</c:choose>
              </div>
            <div class="box-body" id="blng_box_body">
	           <div id="blngs-dt" class="tab-pane fade  in active" >
	              <div class="chart">
	                <div id="prf_summ_billing_ytd" style="height:220px;margin-top:-5px;"></div> 
	                 <br/>
	               <div class="overlay">
					<a href="#" data-toggle="modal" data-target="#billing_moreinfo_modal">More info
					 <i class="fa fa-arrow-circle-right"></i></a> </div> 
	              </div>
	            </div>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.billing box -->
          
          
          <!-- /.box -->
          
                  <!-- box -->  
             <div class="box box-danger" style="margin-bottom: 8px;border-color:#607d8b;">
           <div class="box-header with-border">
			<h3 class="box-title" >JIH Qtn. Lost Analysis - ${syrtemp} </h3>
			</div>
            <div class="box-body">
                <div class="chart">
                    <div id="jihLostCountAnlysys" style="height:220px;margin-top:18px;"></div>  <br/>
               <div class="overlay">
				<a href="#" data-toggle="modal" data-target="#jihLostModalGraph">More info
				 <i class="fa fa-arrow-circle-right"></i></a> </div> 
              </div> 
            </div>
            <!-- /.box-body -->
          </div>
         
          <!-- /.box -->
            <!-- box -->  
             <div class="box box-danger" style="margin-bottom: 8px;border-color:#607d8b;">
           <div class="box-header with-border">
			 <c:choose>
					<c:when test="${syrtemp < CURR_YR}">
						<h3 class="box-title" id="blng-graph-title">Billing Target Vs Stage-4(SO) Amount - ${syrtemp},(FY)</h3>
					</c:when>
					<c:otherwise>
						<h3 class="box-title" id="blng-graph-title">Billing Target Vs Stage-4(SO) Amount - ${syrtemp},(YTD)</h3>
					</c:otherwise>
				</c:choose>
			</div>
            <div class="box-body">
                <div class="chart">
                    <div id="prf_billings4_ytd" style="height:230px;margin-top:-5px;"></div>  <br/>
               <div class="overlay">
				<a href="#" data-toggle="modal" data-target="#bngs4_moreinfo_modal">More info
				 <i class="fa fa-arrow-circle-right"></i></a> </div> 
              </div> 
            </div>
            <!-- /.box-body -->
          </div>
         
          <!-- /.box -->

        </div>
        <!-- /.col (RIGHT) -->
       <!--  <div class="col-md-12">
               <div class="box box-danger" style="margin-bottom: 0px;border-color:#607d8b;">
           <div class="box-header with-border">
			<h3 class="box-title" >S2,S3,S4,S5 Weekly Summary  </h3>
			</div>
            <div class="box-body">
                <div class="chart">
                    <div id="s2s3s4summary" style="height:600px;width:955px"></div>  <br/>
               <div class="overlay">
				<a href="#" data-toggle="modal" data-target="#s2s3s4s5summery_moreinfo_modal">More info
				 <i class="fa fa-arrow-circle-right"></i></a> </div> 
              </div> 
            </div>
         
          </div> -->
				          
          </div> 
        
      </div>
      <!-- /.row -->
	   
	  
	<div id="myModal" class="modal">
		  <div class="modal-content" style="width: 25%; height: 40%; margin-left: auto; margin-right: 25%;margin-top: 10%;">	
		  	<div class="modal-header">		  
         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
          		<h4 class="modal-title">Stage details of Sales Engineer - ${selected_salesman_code} </h4>
        	</div>	   
		    <div class="modal-body"> <div id="stagedetailsgraph"></div></div>
		  </div>
		</div>	
        <div class="row">
					<div class="modal fade" id="rcvbles_aging_modal-main" role="dialog" >
					
					        <div class="modal-dialog" style="width:97%;">
					     		<!-- Modal content-->
							      	<div class="modal-content">
								        	<div class="modal-header">
								         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
								          		<h4 class="modal-title"> </h4>
								        	</div>
								        	<div class="modal-body small"> <div id="table_div"></div></div>
									        <div class="modal-footer">
									        <div id="laoding-rcvbl" class="loader" ><img src="resources/images/wait.gif"></div>
									          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									        </div>
								     </div>
								     
								     
						   	 </div>   	 		   	 
		 			</div>
	  
	</div>
	<div class="modal fade" id="blng3yr_moreinfo_modal" role="dialog">
							<div class="modal-dialog modal-lg">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="modal-title">Billing 3 years Analysis of Sales Egr: ${selected_salesman_code} </h4>
									</div>

									<div class="modal-body">
										<div class="row">
											<table id="blng3yr_modal_table">
												<thead> <tr> <th>Year</th> <th>Actual</th> <th>Target</th></tr> </thead>
												<tbody>  
												 <c:forEach var="blngl3yr" items="${BSFLTY}"> 
												 <tr>  <td>${blngl3yr.year}</td>  
												 <td><fmt:formatNumber pattern="#,###" value="${blngl3yr.ytm_actual}" /></td> 
												 <td>Target (YTD) :<fmt:formatNumber pattern="#,###" value="${blngl3yr.ytm_target}" /> <br/>
												      Total Yearly Target :<fmt:formatNumber pattern="#,###" value="${blngl3yr.yr_total_target}" /> 
												 </td>  
												 </tr>
												
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
	
		<div class="modal fade" id="jihv_moreinfo_modal" role="dialog">
							<div class="modal-dialog modal-lg">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="modal-title">Job In Hand Volume Details of ${selected_salesman_code} </h4>
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
										<h4 class="modal-title">JIH (All) Vs LOST Details of ${selected_salesman_code} </h4>
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
										<h4 class="modal-title">Booking Details of ${selected_salesman_code} </h4>
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
										<h4 class="modal-title">Billing Target Vs Actual Billing Details of ${selected_salesman_code} </h4>
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
						<div class="modal fade" id="bngs4_moreinfo_modal" role="dialog">
							<div class="modal-dialog modal-lg">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="modal-title">Billing Target Vs Stage-4 Amount Details of ${selected_salesman_code} </h4>
									</div>

									<div class="modal-body">
										<div class="row">
											<table id="billings4_modal_table">
												<thead> <tr> <th></th> <th>Actual</th><th>Target</th></tr> </thead>
												<tbody>  
												<c:forEach var="ytm_tmp" items="${BILLS4_SUMM}"> <c:choose> <c:when test="${syrtemp ne CURR_YR}">
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
	<%-- SLAESMAN PERFORMANCE MODAL START --%>
	  <div class="modal fade" id="salesman_performance_modal" role="dialog"> 			  
			<div class="modal-dialog modal-lg">							
				<div class="modal-content"  style="height: max-content !important;width:100%;"> 
					<div class="modal-header">
								         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
								          		<h4 class="modal-title"  id="sm_h1"> </h4>
								          		<h5 class="modal-subtitle"  id="sm_h1"> </h5>
								          		<h5 class="modal-subtitle2"  id="sm_h1"> </h5>
<!-- 								          		<a href="#" data-toggle="modal" data-target="#help-modal"> <i class="fa fa-info-circle pull-right" style="color: #2196f3;font-size: 20px;margin-top: 4px;"></i></a>   -->
					 </div>  
					<div class="modal-body">										
					</div>
					<div class="modal-footer" style="text-align:left;">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					</div>
				</div>
		 </div>
	</div>
		  	<div class="modal fade" id="help-modal"  role="dialog" >
		 <div class="modal-dialog  modal-sm"  >
			<div class="modal-content" style="height:min-content;width: max-content !important;">
				 <div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					 <h4 class="modal-title">Conversion Ratio Help</h4>
					 </div>
					<div class="modal-body">
							<font  color="#0c3d6d" style="padding-left:20px"> (<b>4.</b> STG2_STG4_AMT)</font>
							    / 
							<font  color="#cd3f15">  (<b>1.</b>  STG2_6MTH_AMT+ 
							   <b>2.</b> STG2_LOST_AMT+
							   <b>3.</b> STG2_HOLD_AMT+
							   <b>4.</b> STG2_STG4_AMT</font>
							   ) * 100
							<br/><br/>
							
					    <ol>					    	
							 <li><font color="#0000ff"><b> STG2_6MTH_AMT </b></font>  Quotations where <b>AGING >6Mths</b> and <b>Quotation     
							                   date >= '01-JAN-2022'</b>, in job in hand stage,  
							                   not marked as lost
							</li>
							 <li><font color="#ff9900"><b>STG2_LOST_AMT</b></font>   quotation marked as Lost from job in hand, 
							                   without duplicate as reason, <b>Quotation date 
							                   >= '01-JAN-2022'</b>
							</li>
							 <li><font color="#3b80a9"><b>STG2_HOLD_AMT</b></font>   Quotation marked as Hold and <b>Quotation date 
							                   >= '01-JAN-2022'</b>
							</li>
							 <li><font color="#008000"><b>STG2_STG4_AMT</b></font>   <b>SO_date >= '01-JAN-2022'</b> and so referred from 
				                   quotation and referred <b>Quotation date >= '01-
				                   JAN-2022'</b>
							</li>
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
	<div class="modal fade" id="help-modalfor120days"  role="dialog" >
		 <div class="modal-dialog  modal-sm"  >
			<div class="modal-content" style="height:min-content;width: max-content !important;">
				 <div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					 <h4 class="modal-title">Help</h4>
					 </div>
					<div class="modal-body">							
							<font  color="#cd3f15"> </font>
							   Outstanding <b>>120 days </b> should be <b>5%</b> or less than of <b>YTD Billing</b>
							<br/><br/>
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
		<div class="modal fade" id="help-modaljihnoresp"  role="dialog" >
		 <div class="modal-dialog  modal-sm"  >
			<div class="modal-content" style="height:min-content;width: max-content !important;">
				 <div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					 <h4 class="modal-title">Help</h4>
					 </div>
					<div class="modal-body">							
							<font  color="#cd3f15"> </font>
							   <b> JIH lost with No Response  </b> should be <b>10% </b>or  less than of <b>Total JIH lost.</b>
							<br/><br/>
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
	 <%-- SLAESMAN PERFORMANCE MODAL END --%>
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
								          		<h4 class="modal-title">${selected_salesman_code} - Customer Visit Details ${syrtemp} </h4>
								        	</div>
								        	<div class="modal-body small"></div>
									        <div class="modal-footer">
									          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									        </div>
								     </div>
								     
								     
						   	 </div>   	 		   	 
		 			</div>
		 	</div> 
		 				<div class="modal fade" id="jihLostModalGraph" role="dialog" >
					
					        <div class="modal-dialog" style="width:25%;">
					     		<!-- Modal content-->
							      	<div class="modal-content">
								        	<div class="modal-header">
								         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
								          		<h4 class="modal-title">${selected_salesman_code} - JIH Qtn. Lost Analysis </h4>
								        	</div>
								        	<div class="modal-body small"></div>
									        <div class="modal-footer">
									          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									        </div>
								     </div>
								     
								     
						   	 </div>   	 		   	 
		 			</div>
		 			 <div class="row"> 
							<div class="modal fade" id="job_moved_dtls_main" role="dialog">

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
	<div class="row">
					<div class="modal fade" id="billings4-modal-graph" role="dialog" >
					
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
	<div class="row">
					<div class="modal fade" id="s3-modal-graph" role="dialog" >
					
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
	<div class="row">
					<div class="modal fade" id="s4-modal-graph" role="dialog" >
					
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
		<div class="row">
					<div class="modal fade" id="s5-modal-graph" role="dialog" >
					
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
	<div class="modal fade" id="jih_lost_dtls_modal" role="dialog" >
					
					        <div class="modal-dialog" style="width:85%;">
					     		<!-- Modal content-->
							      	<div class="modal-content">
								        	<div class="modal-header">
								         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
								          		<h4 class="modal-title"> </h4>
								        	</div>
								        	<div class="modal-body small"> <div id="table_div"></div></div>
									        <div class="modal-footer">
									        <div id="laoding-jihqlst" class="loader" ><img src="resources/images/wait.gif"></div>
									          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									        </div>
								     </div>
								     
								     
						   	 </div>   	 		   	 
		</div>
		<div class="modal fade" id="onaccnt-third-layer">
							<div class="modal-dialog" style="width: 80%;">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title"></h4>
									</div>
									<div class="modal-body" id="third-layer-table">
									<div class="row">
									<div id="netBlOnAc" class="col-md-6"></div>
									<div class="col-md-4 pdc_btn" >
									<input type="hidden" id="ccrpdc" value="co" />
									<button type="button"  class="btn btn-info btn-xs" onclick="showPdcHand($('#ccrpdc').val());"><i class="fa fa-download"></i> PDC's On Hand</button>
									<button  type="button"  class="btn btn-info btn-xs"  onclick="showPdReEntry($('#ccrpdc').val());"><i class="fa fa-download"></i> PDC's Re-Entry</button>
									</div>
									</div>
									<div id="dtlsOnAcDtls"></div>
									</div>
									<div class="modal-footer">
									<div id="laoding-pdc" class="loader" ><img src="resources/images/wait.gif"></div>
										<button type="button" class="btn btn-default pull-left"
											data-dismiss="modal">Close</button>

									</div>
								</div>
								<!-- /.modal-content -->
							</div>
							<!-- /.modal-dialog -->
		</div>
			<div class="modal fade" id="pdc_hand_4_main">
							<div class="modal-dialog" style="width: 80%;">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title"></h4>
									</div>
									<div class="modal-body" >
									
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
					 <div class="modal fade" id="pdc_re_4_main">
							<div class="modal-dialog" style="width: 80%;">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title"></h4>
									</div>
									<div class="modal-body" >
									
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
			<div class="modal fade" id="modal-help-bkngvsblng">
							<div class="modal-dialog" style="width: 80%;">
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
        <div class="row">
					<div class="modal fade" id="editSGoal" role="dialog" >
					
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
		<div class="modal fade" id="help-stages-modal">
							<div class="modal-dialog" style="width: 80%;">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title">Stage Details Help</h4>
									</div>
									<div class="modal-body">
										<ul>
											<li>
											<p class="font-weight-bold">Stage Details - Last two years data</p>
											</li>
											<li>
											<h4 class="font-weight-bold text-primary">Stage-1</h4>
												<p class="font-weight-bold">These are the quotations which are in tender stage processed against an enquiry.</p>
											</li>
											<li>
											 <h4 class="font-weight-bold text-primary">Stage-2</h4>
												<p class="font-weight-bold">These are the quotations which are job-in-hand but does not have LOI Date.</p>											
											</li>
											<li>
											<h4 class="font-weight-bold text-primary">Stage-3</h4>
											 <p class="font-weight-bold">These are the quotations against which LOI is received with date.</p>
											</li>
											<li>
											<h4 class="font-weight-bold text-primary">Stage-4</h4>
											 <p class="font-weight-bold">It is Order confirmation entry in ERP , ( Customer po )</p>
											</li>												
										</ul>
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
						
						<div class="modal fade" id="s2s3s4s5summery_moreinfo_modal" role="dialog">
							<div class="modal-dialog modal-lg">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="modal-title">Weekly Stages(S2,S3,S4,S5) Summary for ${selected_salesman_name} (${selected_salesman_code}) </h4>
									</div>
									<div class="modal-body">
										<div class="row">
											<table id="s2s3s4s5_modal_table">
												<thead><tr><th style="width:20px;"></th>
												<c:forEach var="ytm_tmp" items="${S2S3S4S5_SUMM}"> 														
												         <th>Wk-${ytm_tmp.weekNo}</th>
												 </c:forEach>
												 </tr></thead>
												<tbody> 
												  <tr> <td>Stage&nbsp;2</td>
													<c:forEach var="ytm_tmp1" items="${S2S3S4S5_SUMM}"> 
												         <td style="text-align:right"> <fmt:formatNumber pattern="#,###" value="${ytm_tmp1.s2Count}" /></td>												           
												   </c:forEach>
   												 </tr> 
   												 <tr> <td>Stage&nbsp;3</td>
													<c:forEach var="ytm_tmp1" items="${S2S3S4S5_SUMM}"> 
												         <td style="text-align:right"> <fmt:formatNumber pattern="#,###" value="${ytm_tmp1.s3Count}" /></td>												           
												   </c:forEach>
   												 </tr> 
   												 <tr> <td>Stage&nbsp;4</td>
													<c:forEach var="ytm_tmp1" items="${S2S3S4S5_SUMM}"> 
												         <td style="text-align:right"> <fmt:formatNumber pattern="#,###" value="${ytm_tmp1.s4Count}" /></td>												           
												   </c:forEach>
   												 </tr> 
   												 <tr> <td>Stage&nbsp;5</td>
													<c:forEach var="ytm_tmp1" items="${S2S3S4S5_SUMM}"> 
												         <td style="text-align:right"> <fmt:formatNumber pattern="#,###" value="${ytm_tmp1.s5Count}" /></td>												           
												   </c:forEach>
   												 </tr> 
   												 </tbody>
                                         </table>


										</div>
									</div>

								<%-- <div class="modal-body">
										<div class="row">
											<table id="s2s3s4s5_modal_table">
												<thead> <tr> <th>Week</th> <th>Stage-2</th><th>Stage-3</th><th>Stage-4</th><th>Stage-5</th></tr> </thead>
												<tbody>  
													<c:forEach var="ytm_tmp" items="${S2S3S4S5_SUMM}"> 
												          <tr><td>${ytm_tmp.weekNo}</td><td style="text-align:right"> <fmt:formatNumber pattern="#,###" value="${ytm_tmp.s2Count}" /></td><td style="text-align:right"> <fmt:formatNumber pattern="#,###" value="${ytm_tmp.s3Count}" /></td><td style="text-align:right"> <fmt:formatNumber pattern="#,###" value="${ytm_tmp.s4Count}" /></td><td style="text-align:right"> <fmt:formatNumber pattern="#,###" value="${ytm_tmp.s5Count}" /></td></tr> 
												        
												   </c:forEach>
   												 </tbody>												
                                          </tbody>
                                         </table>


										</div>
									</div>--%>	

									<div class="modal-footer">
										<button type="button" class="btn btn-default"
											data-dismiss="modal">Close</button>

								</div>
							</div>
						</div>
	<!-- End of s2,s3,s4,s5 summery more info -->
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
<style>
.no-select {
    -webkit-user-select: none; /* Safari */
    -moz-user-select: none;    /* Firefox */
    -ms-user-select: none;     /* Internet Explorer/Edge */
    user-select: none;         /* Non-prefixed version, currently supported by Chrome, Edge, Opera and Firefox */
}
</style>
<!-- FastClick -->
<script src="resources/bower_components/fastclick/lib/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="resources/dist/js/adminlte.min.js"></script>
<script src="resources/bower_components/select2/dist/js/select2.full.min.js"></script>
<script src="resources/js/date-eu.js"></script>
<script>
/*Start*/
function showPdcHand(value) { 
	 // alert(value);
	 var custVal=$.trim(value);
	$('#laoding-pdc').show();

	var ttl="<b>PDC On Hand Details Of Customer  :"+custVal+" </b>";
	var exclTtl="PDC On Hand Details Of Customer  :"+custVal+" ";
	 $("#pdc_hand_4_main .modal-title").html(ttl); 
		 $.ajax({ type: 'POST', url: 'sip',data: {fjtco: "wccsltdhop", cchop:custVal},dataType: "json",success: function(data) {
			 $('#laoding-pdc').hide();
			 var output="<table id='pdc_oh_table_main' class='table table-bordered small'><thead><tr><th>#</th><th>PDC Due Date</th><th>Cheque Number</th><th>Bank Name</th><th>Currency</th><th>Amount</th><th>Amount(AED)</th>"+
         "</tr></thead><tbody>";
        var j=0; for (var i in data) { j=j+1;
        output+="<tr><td>"+j+"</td><td>" + $.trim(data[i].d1.substring(0, 10)).split("-").reverse().join("/") + "</td>"+
        "<td>" + data[i].d2 + "</a></td><td>" + data[i].d3 + "</a></td>"+
        "<td>" + data[i].d4 + "</td><td align='right'>" + formatNumber(data[i].d5) + "</td><td align='right'>" + formatNumber(data[i].d6) + "</td></tr>"; 
         } 
        output+="<tfoot align='right'>"+
        "<tr><th colspan='5' style='text-align:right;color:blue;'>Total:</th><th></th><th></th></tr>"+
        "</tfoot>"+
        "</tbody></table>";
         output+="</tbody></table>";
         $("#pdc_hand_4_main .modal-body").html(output);
         $("#pdc_hand_4_main").modal("show");
	
		 
		    $('#pdc_oh_table_main').DataTable( {
		        dom: 'Bfrtip',   
		        "columnDefs" : [{"targets":1, "type":"date-eu"}],
		        "order": [[ 5, "desc" ]],
		        buttons: [
		            {
		                extend: 'excelHtml5',
		                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
		                filename: exclTtl,
		                title: exclTtl,
		                messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'
		                
		                
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
			            var total1 = api
			                .column( 5 )
			                .data()
			                .reduce( function (a, b) {
			                    return intVal(a) + intVal(b);
			                }, 0 );
			            
			            var total2 = api
		               .column( 6 )
		               .data()
		               .reduce( function (a, b) {
		                   return intVal(a) + intVal(b);
		               }, 0 );
			            
			          
		        
			        
			            // Update footer
			                     $( api.column(5).footer()).html(formatNumber(total1));
			                     $( api.column(6).footer()).html(formatNumber(total2));
			                     
			            
			            
			        }
		    } );
		},error:function(data,status,er) {$('#laoding-pdc').hide();  alert("please click again");}});

}
/*End*/
 /*Start*/
function showPdReEntry(value) { 
	 // alert(value);
	 var custVal=$.trim(value);
	$('#laoding-pdc').show();

	var ttl="<b>PDC Re-Entry Details Of Customer  :"+custVal+" </b>";
	var exclTtl="PDC Re-Entry Details Of Customer  :"+custVal+" ";
	 $("#pdc_re_4_main .modal-title").html(ttl); 
		 $.ajax({ type: 'POST', url: 'sip',data: {fjtco: "wccsltdrep", ccerp:custVal},dataType: "json",success: function(data) {
			 $('#laoding-pdc').hide();
			 var output="<table id='pdc_re_table_main' class='table table-bordered small'><thead><tr><th>#</th><th>PDC Due Date</th><th>Cheque Number</th><th>Bank Name</th><th>Currency</th><th>Amount</th><th>Amount(AED)</th>"+
         "</tr></thead><tbody>";
        var j=0; for (var i in data) { j=j+1;
        output+="<tr><td>"+j+"</td><td>" + $.trim(data[i].d1.substring(0, 10)).split("-").reverse().join("/") + "</td>"+
        "<td>" + data[i].d2 + "</a></td><td>" + data[i].d3 + "</a></td>"+
        "<td>" + data[i].d4 + "</td><td align='right'>" + formatNumber(data[i].d5) + "</td><td align='right'>" + formatNumber(data[i].d6) + "</td></tr>"; 
         } 
        output+="<tfoot align='right'>"+
        "<tr><th colspan='5' style='text-align:right;color:blue;'>Total:</th><th></th><th></th></tr>"+
        "</tfoot>";
         output+="</tbody></table>";
         $("#pdc_re_4_main .modal-body").html(output);
         $("#pdc_re_4_main").modal("show");
	
		 
		    $('#pdc_re_table_main').DataTable( {
		        dom: 'Bfrtip', 
		        "columnDefs" : [{"targets":1, "type":"date-eu"}],
		        "order": [[ 5, "desc" ]],
		        buttons: [
		            {
		                extend: 'excelHtml5',
		                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
		                filename: exclTtl,
		                title: exclTtl,
		                messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'
		                
		                
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
			            var total1 = api
			                .column( 5 )
			                .data()
			                .reduce( function (a, b) {
			                    return intVal(a) + intVal(b);
			                }, 0 );
			            
			            var total2 = api
		               .column( 6 )
		               .data()
		               .reduce( function (a, b) {
		                   return intVal(a) + intVal(b);
		               }, 0 );
			            
			          
		        
			        
			            // Update footer
			                     $( api.column(5).footer()).html(formatNumber(total1));
			                     $( api.column(6).footer()).html(formatNumber(total2));
			                     
			            
			            
			        }
		    } );
		},error:function(data,status,er) {$('#laoding-pdc').hide();  alert("please click again");}});

}
/*End*/
 /*START 3rd lyr jih lost details */
 function getJihLostAnalysisDtls(lostType){
	$('#laoding-jihqlst').show(); 
	var type = $.trim(lostType); 
var ttl="<b>JIH Qtn. Lost detail of  : "+lostType+" / ${selected_salesman_code}</b>";
var exclTtl="JIH Qtn. Lost detail of  : "+lostType+" / ${selected_salesman_code}";
var ttlSummary="";
var j=0;
$("#jih_lost_dtls_modal .modal-title").html(ttl);
	$.ajax({ type: 'POST',url: 'sip',  data: {fjtco: "jihlstGrphDtls", lstyp:type, seg: '${selected_salesman_code}',selyear:'${syrtemp}'},  dataType: "json",
		 success: function(data) {
			 $('#laoding-jihqlst').hide();  		 
			 var output="<table id='jihLostDtls' class='table table-bordered small'><thead><tr>"+
			 "<th>Sl. No.</th><th>S.Eng.</th><th>Qtn. Date</th><th>Qtn. Code</th> <th>Qtn. No.</th> <th>Updated on </th><th>Customer Code</th><th>Customer Name</th> <th>Project Name</th><th>Consultant</th> <th>Qtn. Amount</th><th>Qtn.Status</th><th>Remarks</th>"+
		 "</tr></thead><tbody>";
		
		 for (var i in data) { 
		 j=j+1;
		 output+="<tr><td>"+j+"</td><td>" + data[i].slesCode + "</td>"+"<td>" + $.trim(data[i].qtnDate.substring(0, 10)).split("-").reverse().join("/")+
		 "<td>" + data[i].qtnCode + "</td>"+"</td><td>" + data[i].qtnNo + "</td><td>" +  data[i].updatedDate + "</td><td>" +data[i].custCode+ "</td>"+
		 "<td width='300px'>" +  data[i].custName + "</td><td width='300px'>" +  data[i].projectName + "</td><td width='200px'>" +  data[i].consultant + "</td><td align='right'>" +  formatNumber(Math.round(data[i].qtnAmt)) + "</td>"+
		 "<td>" +  data[i].qtnStatus + "</td>"+"<td width='300px'>" +  data[i].remarks + "</td>"+"</tr>"; 
		 } 
		 output+="</tbody></table>";
		 
		  
		 $("#jih_lost_dtls_modal .modal-body").html(output);
		 $("#jih_lost_dtls_modal").modal("show");	
		 
			    $('#jihLostDtls').DataTable( {
			        dom: 'Bfrtip',  
			        "columnDefs" : [{"targets": 2, "type":"date-eu"}],
			       
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
			},error:function(data,status,er) {$('#laoding-jihqlst').hide();  alert("please click again");}});
	
	
}

 /*END 3rd layr jih lost details */
/* On account outstandng rcvbls script start */
function showOustRcvblThirdLyrOwnAccnt(data){
	$('#laoding-rcvbl').show();
	//alert(data);
	var cust_code = $.trim(data);
	$("#onaccnt-third-layer .modal-body #ccrpdc").val(cust_code);
	
var ttl="<b>Outstanding Details for Customer :"+cust_code+"</b>";
var exclTtl="Outstanding Details for Customer :"+cust_code+"";
var ttlSummary="";
$("#onaccnt-third-layer .modal-title").html(ttl);
	$.ajax({ type: 'POST',url: 'sip',  data: {fjtco: "3lyrtnccano", oacc:cust_code,seg: '${selected_salesman_code}'},  dataType: "json",
		 success: function(dataMain) {
			 $('#laoding-rcvbl').hide();
			 var data=dataMain['onAcccntLst'];
			 var dataNet=dataMain['onNetAmtLst'];
			 for (var i in dataNet){
				 ttlSummary+="<table border='1' bordercolor='#fff' class='onAcSummary'> <tr><th align='right'>Balance : "+dataNet[i].d13+" Dr</th>"+
				 "<th align='right'>On A/C : "+dataNet[i].d14+" Cr</th>"+
				 "<th align='right'>Net Balance : "+dataNet[i].d15+"</th></tr>"+
				 "</table>";
			 }
			 
			 var output="<table id='onAccntCustDtls' class='table table-bordered small'><thead><tr>"+
			 "<th>Sl. No.</th><th>Company Code</th><th>Customer code</th><th>DOC Date</th>"+
			 "<th>DOC Number</th><th>Division</th><th>Sales Egr:</th><th>LPO No.</th><th>Project</th>"+
			 "<th>Payment Term</th><th>Currency</th><th>Balance Amount<th>ON A/C</th>"+
		 "</tr></thead><tbody>";
		
		 var j=0; for (var i in data) { j=j+1;
		 
		 output+="<tr><td>"+j+"</td><td>" + data[i].d1 + "</td>"+
		 "<td>" + data[i].d2 + "</td>"+
		 "<td>" + $.trim(data[i].d3.substring(0, 10)).split("-").reverse().join("/")+ "</td><td>" + data[i].d4 + "</td><td>" +data[i].d5+ "</td>"+
		 "<td>" +  data[i].d6 + "</td><td>" +  data[i].d7 + "</td><td>" +  data[i].d8 + "</td><td>" +  data[i].d9 + "</td>"+
		 "<td>" +  data[i].d10 + "</td><td align='right'>" + formatNumber(data[i].d11) + "</td><td>" +  data[i].d12 + "</td>"+
		 "</tr>"; } 
		 output+="</tbody></table>";
		 
		 
		 $("#onaccnt-third-layer .modal-body #netBlOnAc").html(ttlSummary);
		 $("#onaccnt-third-layer .modal-body #dtlsOnAcDtls").html(output);
		 $("#onaccnt-third-layer").modal("show");	
		 
			    $('#onAccntCustDtls').DataTable( {
			        dom: 'Bfrtip',  
			        "columnDefs" : [{"targets": 3, "type":"date-eu"}],
			        "order": [[ 11, "desc" ]],
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


/* On account outstandng rcvbls END */
function changeTitle(title){
	$('#jihlost-title').html(title);
}
function showstage3Jobs(){
    $('#laoding').show();

    var ttl = "<b>Details of Job Moved from Stage 2 to Stage 3</b>";
    var exclTtl = "Details of Job Moved from Stage 2 to Stage 3";
    $("#job_moved_dtls_main .modal-title").html(ttl);

    $.ajax({
        type: 'POST',
        url: 'sip',
        data: { fjtco: "3sdvmboj" },
        dataType: "json",
        success: function(data) {
            $('#laoding').hide();

            var output = "<table id='job_moved_dtls_excl' class='table table-bordered small no-select'><thead><tr>" + 
                "<th>#</th><th>Week<br/>(Based on LOI Date)</th><th>Sales Egr: Code</th><th>Sales Egr: Name</th><th>Project Code</th><th>Qtn-Code</th><th>Qtn Number</th><th>Qtn-Date</th>" +
                "<th>LOI Date</th><th>Product</th><th>Region</th><th>Cusomer Name</th><th>Contact Person</th><th>Contact Number</th><th>Consultant</th></tr></thead><tbody>";

            var j = 0;
            for (var i in data) {
                j = j + 1;
                output += "<tr><td>" + j + "</td><td>" + data[i].d1 + "</td><td>" + data[i].d2 + "</td><td>" + data[i].d3 + "</td>" +
                    "<td>" + data[i].d4 + "</td><td>" + data[i].d5 + "</td>" +
                    "<td>" + data[i].d6 + "</td><td>" + $.trim(data[i].d7.substring(0, 10)).split("-").reverse().join("/") + "</td>" +
                    "<td>" + $.trim(data[i].d8.substring(0, 10)).split("-").reverse().join("/") + "</td><td>" + data[i].d9 + "</td>" +
                    "<td>" + data[i].d10 + "</td><td>" + data[i].d11 + "</td>" +
                    "<td>" + data[i].d12 + "</td><td>" + data[i].d13 + "</td>" +
                    "<td>" + data[i].d14 + "</td></tr>";
            }
            output += "</tbody></table>";

            $("#job_moved_dtls_main .modal-body").html(output);
            $("#job_moved_dtls_main").modal("show");

            $('#job_moved_dtls_excl').DataTable({
                dom: 'frtip', // Exclude 'B' to remove buttons
                "columnDefs": [{ "targets": [7, 8], "type": "date-eu" }],
                /*buttons: [
                    {
                        extend: 'excelHtml5',
                        text: '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
                        filename: exclTtl,
                        title: exclTtl,
                        messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'
                    }
                ]*/
            });
        },
        error: function(data, status, er) {
            $('#laoding').hide();
            alert("please click again");
        }
    });
}
function show2ndLayerQtnLost(agingHeader,agingVal) { 
	 $('#laoding').show();

	  
	 var ttl="<b>JIH Quotation Lost Details of  ${selected_salesman_code} for "+agingHeader+" </b> ";
	 var exclTtl="JIH Quotation Lost Details of ${selected_salesman_code}  for "+agingHeader+"";
	 $("#qtn_lost_modal-main .modal-title").html(ttl); $.ajax({ type: 'POST',url: 'sip',  data: {fjtco: "tsolhij", avfad:agingVal , edocms:'${selected_salesman_code}'}, dataType: "json",
	 success: function(data) {
		
		 $('#laoding').hide();
		
		 var output="<table id='qtnlost' class='table table-bordered small'><thead><tr>"+ "<th>#</th><th>Week</th><th>Company</th><th>Qtn-Date</th><th>Qtn-Code</th><th>Qtn Number</th>"+
	 "<th>Customer Code</th><th>Customer Name</th><th>Sales Egr: Code</th><th>Sales Egr: Name</th>"+ " <th>Project Name</th><th>Consultant</th><th>Invoicing Year</th><th>Product Type</th>  <th>Product Classfctn</th><th>Zone</th><th>Profit (%)</th><th>Qtn Amount</th><th>Qtn Status</th><th>Lost Type</th><th>Lost Remark</th></tr></thead><tbody>";
	 
	 var j=0; for (var i in data) { j=j+1;
	 
	 output+="<tr><td>"+j+"</td><td>" + data[i].d2 + "</td>"+"<td>" + data[i].d1 + "</td><td>" + $.trim(data[i].d3.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+ "<td>" + data[i].d4 + "</td><td>" + data[i].d5 + "</td>"+
	 "<td>" + data[i].d6 + "</td><td>" + data[i].d7 + "</td>"+ "<td>" + data[i].d8 + "</td><td>" + data[i].d9 + "</td>"+ "<td>" + data[i].d10 + "</td><td>" + data[i].d11 + "</td>"+
	 "<td>" +$.trim(data[i].d12.substring(0, 10)).split("-").reverse().join("/") + "</td><td>" + data[i].d13 + "</td>"+ "<td>" + data[i].d14 + "</td><td>" + data[i].d15 + "</td><td>"
	 + data[i].d16 + "</td><td>" + data[i].d17 + "</td><td><small class='label label-danger'><i class='fa fa-clock-o'></i> Lost</small></td><td>" + data[i].d19 + "</td><td>" + data[i].d20 + "</td></tr>";
	 } //output+="<tr><td colspan='17'><b>Total</b></td><td><b style='color:blue;'>"+str+"</b></td></tr>"; 
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
function show2ndLayerOutRcvbles(salesegr,agingVal,aging_header) { 
	 $('#laoding-pdc').hide();$('#laoding-rcvbl').hide();
	$('#laoding').show();
    
	var ttl="<b>Outstanding Recievables > 100AED  Details of Sales Engineer :"+salesegr+"</b><strong style='color:blue;'> </strong> for "+aging_header+" <strong style='color:blue;'>  </strong> ";
	var exclTtl="Outstanding Recievables > 100AED  Details of Sales Engineer : "+salesegr+" for "+aging_header+"";
	 $("#rcvbles_aging_modal-main .modal-title").html(ttl); 
		 $.ajax({ type: 'POST', url: 'sip',data: {fjtco: "slbvcr", aging:agingVal,edoces:salesegr},dataType: "json",success: function(data) {
			 $('#laoding').hide();
			 var output="<table id='rcvbles_main' class='table table-bordered small'><thead><tr><th>#</th><th>Invoice Number</th><th>Invoice Date</th><th>Customer Code</th><th>Customer Name</th><th>Project Name</th><th>Consultant</th><th>Value</th>"+
             "</tr></thead><tbody>";
            var j=0; for (var i in data) { j=j+1;
            output+="<tr><td>"+j+"</td><td>" + data[i].d1 + "</td>"+"<td>" + $.trim(data[i].d2.substring(0, 10)).split("-").reverse().join("/") + "</td>"+
            "<td><a href='#' id='"+data[i].d3+"'  onclick='showOustRcvblThirdLyrOwnAccnt(this.id);'  data-backdrop='static' data-keyboard='false' class='btn btn-primary btn-xs' data-toggle='modal' data-target='#modal-default1'><span class='fa fa-external-link' ></span> " + data[i].d3 + "</a></td>"+
            "<td>" + data[i].d4 + "</td><td>" + data[i].d5 + "</td><td>" + data[i].d6 + "</td><td align='right'>" + formatNumber(data[i].d7)+ "</td></tr>"; 
             } 
             output+="</tbody></table>";
             $("#rcvbles_aging_modal-main .modal-body").html(output);
             $("#rcvbles_aging_modal-main").modal("show");
	
		 
		    $('#rcvbles_main').DataTable( {
		        dom: 'Bfrtip', 
		        "columnDefs" : [{"targets":[2], "type":"date-eu"}],
		        "order": [[ 7, "desc" ]],
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
 
$(document).ready(function() {
	/*Help Script Start */
	 $('#help-bkngvsblng').on('click', function(e) {  
		   $("#modal-help-bkngvsblng").modal("show");	
	    });
	
	 /*Help Script Start */
	 $('#help-qtnlost').on('click', function(e) {  
		   $("#modal-help-qtnlost").modal("show");	
	    });

	  
	 $("#help-modal").draggable({ handle: ".modal-header" });
	 $("#myModal").draggable({ handle: ".modal-header" });
	 
	  var jihvTtl="Job In Hand Volume Details  of Sales Egr : ${selected_salesman_code} ";
	  var lostTtl="JIH (All) Vs Lost Details  of Sales Egr : ${selected_salesman_code} ";
	  var bookingTtl="Booking Details  of Sales Egr : ${selected_salesman_code}";
	  var billingTtl="Billing Details  of Sales Egr : ${selected_salesman_code}";
	  var billings4Ttl="Billing Target Vs Stage-4 Amount Details  of Sales Egr : ${selected_salesman_code}";
	  var billing3yrTtl="Billing 3 Years Analysis of Sales Egr:  ${selected_salesman_code}";
	  var jihLostAnalysisTtl = "JIH Qtn. Lost Analysis of Sales Egr:  ${selected_salesman_code}";
	  var billings4Ttl="S2,S3,S4,S5 Stage Summary Details : ${selected_salesman_code}";
	  var st2345Details="Stages S2,S3,S4,S5 Summary Details  of Sales Egr : ${selected_salesman_code}";
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
	    $('#billings4_modal_table').DataTable( {
	        dom: 'Bfrtip',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
	                filename: billings4Ttl,
	                title: billings4Ttl,
	                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	          
	           
	        ]
	    } );
	    
	    $('#s2s3s4s5_modal_table').DataTable( {
	        dom: 'Bfrtip',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
	                filename: st2345Details,
	                title: st2345Details,
	                messageBottom: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }]
	    } );
	    
	    $('#blng3yr_modal_table').DataTable( {
	        dom: 'Bfrtip',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
	                filename: billing3yrTtl,
	                title: billing3yrTtl,
	                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	          
	           
	        ]
	    } );
	   
	    
} );

//stage 2 detail dm se page
function s2Details() { 
	$('#laoding').show();
var excelTtl='Stage 2 Details of Sales Engineer : ${selected_salesman_code}';
var ttl="<b>Stage 2 Details of Sales Engineer : ${selected_salesman_code} </b> ";
$("#jihv-modal-graph .modal-title").html(ttl);
$.ajax({ type: 'POST',
	url: 'sip',  
	data: {fjtco: "s2_dt", d1:"${selected_salesman_code}"},
	dataType: "json",
success: function(data) { $('#laoding').hide();var output="<table id='jihvexport' style='height:500px;overflow-y: scroll;overflow-x: scroll;' class='table table-bordered small'><thead><tr>"+ "<th>#</th><th>Comp-Code</th><th>Week</th><th>Qtn-Date</th><th>Qtn-Code</th><th>Qtn-No</th>"+
"<th>Customer Code</th><th>Customer Name</th><th>Project Name</th><th>Consultant</th>"+ " <th>Invoicing Year</th><th>Product Type</th>  <th>Product Classfctn</th><th>Zone</th><th>Profit (%)</th><th>Qtn Amount</th></tr></thead><tbody>";
var j=0; for (var i in data) { j=j+1; output+="<tr><td>"+j+"</td><td>" + data[i].d3 + "</td>"+"<td>" + data[i].d4 + "</td><td>" + data[i].d5.substring(0, 10).split("-").reverse().join("/")+ "</td>"+ "<td>" + data[i].d6 + "</td><td>" + data[i].d7 + "</td>"+
"<td>" + data[i].d8 + "</td><td>" + data[i].d9 + "</td>"+ "<td>" + data[i].d10 + "</td><td>" + data[i].d11 + "</td>"+ "<td>" + data[i].d12.substring(0, 10).split("-").reverse().join("/") + "</td><td>" + data[i].d13 + "</td>"+
"<td>" + data[i].d14 + "</td><td>" + data[i].d15 + "</td>"+ "<td>" + data[i].d16 + "</td><td  align='right'>" + formatNumber(data[i].d17) + "</td>"+ "</tr>"; }// output+="<tr><td colspan='15'><b>Total</b></td><td><b>"+str+"</b></td></tr>"; 
output+="</tbody></table>";

$("#jihv-modal-graph .modal-body").html(output);$("#jihv-modal-graph").modal("show"); 
$('#jihvexport').DataTable( {
    dom: 'Bfrtip',   
    "columnDefs" : [{"targets":3, "type":"date-eu"}],
    buttons: [
        {
            extend: 'excelHtml5',
            text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
            filename: excelTtl,
            title: excelTtl,
            messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'
            
            
        }
      
       
    ]
} );

},error:function(data,status,er) {$('#laoding').hide();  alert("please click again");}});
}
//sales performance summary
function sm_performance_details(){
	$('#laoding').show(); 
	var ytdCustTarget = ${WKLYTRGT*currWeek};
	var smCodeName = $("#scode option:selected").text(); 
	var smCode = $("#scode option:selected").val(); 
	var sYear = $("#syear option:selected").val();
	 $("#salesman_performance_modal .modal-title").html(smCodeName);  	  
	var exTtl = 'Salesman Performance - '+smCodeName;
	var exTtl1 = ''+smCodeName;
	var subTtl =  'Year - '+${CURR_YR}+',  Week - '+${currWeek};
	var fileName = 'Salesman Performance '+smCodeName; 
	var printttl = 'Salesman Performance '+smCodeName +'<br/>  Week - '+${currWeek} + ' and Year - '+${CURR_YR} +'<br/>';
	var ttl = 'Salesman Performance '+smCodeName +' and Current week - '+${currWeek} + ' and Year - '+${CURR_YR}; 
	$("#salesman_performance_modal .modal-title").html(exTtl);
	$("#salesman_performance_modal .modal-subtitle").html(subTtl);
	$.ajax({ 
	type: 'POST',
	url: 'sip',  
 	data :{
 			fjtco:"sm_perf" ,
 			c1 : smCode,c2:${CURR_YR}
 			},
	dataType: "json",
	 
	success : function(data){
		$('#laoding').hide();
		var outrecv = 0, bookingTarget = 0, bookingActual = 0, gpTarget = 0, gpActual = 0,  billingTarget = 0, billingActual = 0, prcntgeBilling = 0, stage2JIH = 0, stage3LOI = 0, stage4LPO = 0, stage5LOI = 0, weekBkTarget = 0, prcntgeBooking = 0,  prcntgeBilling = 0 , prcntgeGp = 0;
		var ytdTargetBkng = 0, ytdTargetBlng = 0 , ytdTargetGp = 0 , ytdPrcntgeBkng = 0, ytdPrcntgeBlng = 0, ytdPrcntgeGp = 0, weekBlngTarget,  stage1TENDER = 0, stage3LOI = 0, actualweeklyBilling = 0 , actualweeklyBooking = 0, totalstage3and4 = 0 , stage3and4vsyearlybillingtarget = 0,converratio=0;
		var ytdVistactuals = 0,ytdCustVistit = 0, totJIHLostVal = 0 ,JIHLostNoRepse = 0,avgweeklyorders=0;
		for(var i in data){
		 
		
		switch ($.trim(data[i].srNo)) {
		  case "1.0": // total billing target
			  billingTarget = data[i].yrTot;
		    break; 
		  case "1.1": // billing gp target
			  gpTarget = data[i].yrTot;
		  case "1.2": // weekly billing target
			  weekBlngTarget = data[i].yrTot;
		    break; 
		  case "1.3": // actual weekly Billing
			  actualweeklyBilling = data[i].yrTot;
		    break; 
		  case "1.4": // YTD Billing target
			  ytdTargetBlng = data[i].yrTot;
		    break; 
		  case "1.5": // YTD Billing GP target
			  ytdTargetGp = data[i].yrTot;
		    break; 
		  case "2.0":// Total Booking Target
			  bookingTarget = data[i].yrTot;
		    break; 
		  case "2.1": // Weekly Booking Target
			  weekBkTarget = data[i].yrTot;
		    break; 
		  case "2.2": // actual weekly booking
			  actualweeklyBooking = data[i].yrTot;
		    break; 
		  case "2.3": // YTD Booking Target
			  ytdTargetBkng = data[i].yrTot;
		    break; 
		  case "3": // STAGE 1(Tender)
			  stage1TENDER = data[i].yrTot;
		    break;
		  case "3.1": // STAGE 2(JIH)
			  stage2JIH = data[i].yrTot;
		    break;
		  case "4": // STAGE3 (LOI)
			  stage3LOI = data[i].yrTot;
			  bookingActual = data[i].yrTot;
		    break;
		  case "4.1": // YTD Booking Perc
			  ytdPrcntgeBkng = data[i].yrTot; 
		    break;
		  case "5": // STAGE3 (LOI)
			  stage3LOI = data[i].yrTot;
		    break;
		  case "5.1": // Stage 4 (LPO)
			  stage4LPO = data[i].yrTot;
		    break;
		  case "5.2": // total stage 3 & 4
			  totalstage3and4 = data[i].yrTot;
		    break;
		  case "5.3": // Stage 3 & 4 vs yearly billing target
			  stage3and4vsyearlybillingtarget = data[i].yrTot;
		    break;
		  case "5.4": //average weekly orders(s4)
			  avgweeklyorders = data[i].yrTot;
		    break;
		  case "6": // stage 5 ytd
			  stage5LOI = data[i].yrTot;
			  billingActual = data[i].yrTot;
		    break;
		  case "6.1": 
			  gpActual = data[i].yrTot;
		    break; 
		  case "6.2":
			  ytdPrcntgeBlng = data[i].yrTot;
		    break; 
		  case "7": 
			  outrecv = data[i].yrTot;
	       break; 
		  case "8": // Conversion Ratio
			  converratio = data[i].yrTot;
		  break;
		  case "9": // Cust visit targets
			  ytdVistactuals = data[i].yrTot;
	    	break; 
		  case "10": // total JIH LOST VALUE
			  totJIHLostVal = data[i].yrTot;
		  break;
		  case "10.1": // total JIH LOST VALUE with no reason
			  JIHLostNoRepse = data[i].yrTot;
		  break;
		  default:
			     break;
		}
	} 
		
		prcntgeBooking = percentageCal(bookingActual, bookingTarget);
		prcntgeBilling = percentageCal(billingActual, billingTarget);
		prcntgeGp = percentageCal(gpActual, gpTarget);
		ytdPrcntgeGp = percentageCal(gpActual, ytdTargetGp);
		ytdCustVistit = percentageCal(ytdVistactuals,ytdCustTarget);
		if(ytdPrcntgeBkng >= 100){
			percentageachievedbooking = 100;
		}else{
			percentageachievedbooking = Math.round(percentageCal(ytdPrcntgeBkng,100));
		}
		if(ytdPrcntgeBlng >= 100){
			percentageachievedbilling = 100;
		}else{
			percentageachievedbilling = Math.round(percentageCal(ytdPrcntgeBlng,100));
		}
		if(ytdCustVistit >= 100){
			percentageachievedcustvisit = 100;
		}else{
			percentageachievedcustvisit = Math.round(percentageCal(ytdCustVistit,100));
		}		
		if(ytdPrcntgeGp >= 100){
			percentageachievedgeGp = 100;
		}else{
			percentageachievedgeGp =  Math.round(percentageCal(ytdPrcntgeGp,100));
		}
		
		var jihpercentage = totJIHLostVal !== 0 ? (JIHLostNoRepse / totJIHLostVal) * 100 : 0;
		if (totJIHLostVal == 0 && JIHLostNoRepse == 0) {
		    jihpercentage = 0; 
		}
		if(jihpercentage <= 10){
			jihpercentageval= 10;
		}else{
			jihpercentageval=0;
		}
		var billing120actual = ${aging90120 + aging120180 + aging181};
		var billingactual = (billing120actual/billingActual)*100;
		if(billingactual <= 5){
			billingactualtotalper= 20;
		}else{
			billingactualtotalper=0;
		}
		
		var output= "<table id='salesman_performance_table' style='text-align:center; margin-left: auto; margin-right: auto;width: auto;'><thead ><tr>"
    		   +"<th class='se-brr'>Performance Title</th><th>Yearly Target</th><th>YTD Target</th><th>Actual</th><th>Yearly %</th><th>YTD %</th><th>% Achieved </th><th>Weightage</th><th>Total %</th></tr></thead><tbody>";
    	output+= "<tr><td style='text-align:left;'class='se-brr'>TENDER</td><td>-</td><td>-</td><td style='text-align:right;'>"+formatNumber(Math.round(stage1TENDER))+ "</td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td></tr>"
				 +	"<tr><td style='text-align:left;' class='se-brr'>JIH </td><td>-</td><td>-</td><td style='text-align:right;'>"+formatNumber(Math.round(stage2JIH))+ "</td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td></tr>"
				// +	"<tr><td style='text-align:left;'class='se-brr'>Stage-3(LOI)</td><td>-</td><td>-</td><td style='text-align:right;'>"+formatNumber(Math.round(stage3LOI))+ "</td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td></tr>"				
				//+	"<tr><td style='text-align:left;' class='se-brr'>STAGE-5-(BILLING) </td><td class='se-blr'></td><td style='text-align:right;'></td><td style='text-align:right;'>"+formatNumber(stage5LOI)+ "</td><td></td></tr>"
				 +  "<tr><td style='text-align:left;' class='se-brr'>Booking </td><td style='text-align:right;'>"+formatNumber(Math.round(bookingTarget))+"</td><td style='text-align:right;'>"+formatNumber(Math.round(ytdTargetBkng))+"</td><td style='text-align:right;'>"+ formatNumber(Math.round(bookingActual)) + "</td><td>"+formatNumber(prcntgeBooking)+ "</td><td style='text-align:right;'>"+ytdPrcntgeBkng+ "</td><td style='text-align:right;'>"+percentageachievedbooking+ "</td><td style='text-align:right;'>"+10+ "</td><td style='text-align:right;'>"+(percentageachievedbooking*10)/100+"</td></tr>"
				 +	"<tr><td style='text-align:left;' class='se-brr'>Avg Weekly Booking</td><td>-</td><td>-</td><td style='text-align:right;'>"+formatNumber(Math.round(actualweeklyBooking))+ "</td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td></tr>"
				 +	"<tr><td style='text-align:left;' class='se-brr'>Orders</td><td>-</td><td>-</td><td style='text-align:right;'>"+formatNumber(Math.round(stage4LPO))+ "</td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td></tr>"
				 +	"<tr><td style='text-align:left;' class='se-brr'>Avg Weekly Orders</td><td>-</td><td>-</td><td style='text-align:right;'>"+formatNumber(Math.round(avgweeklyorders))+ "</td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td></tr>"
				 +	"<tr><td style='text-align:left;' class='se-brr'>Billing </td><td style='text-align:right;'>"+formatNumber(Math.round(billingTarget))+"</td><td style='text-align:right;'>"+formatNumber(Math.round(ytdTargetBlng))+"</td><td style='text-align:right;background-color:#F08080;font-weight: bold'>"+ formatNumber(Math.round(billingActual)) + "</td><td>"+formatNumber(prcntgeBilling)+ "</td><td style='text-align:right;'>"+ytdPrcntgeBlng+ "</td><td style='text-align:right;'>"+percentageachievedbilling+ "</td><td style='text-align:right;'>"+5+ "</td><td style='text-align:right;'>"+(percentageachievedbilling*5)/100+"</td></tr>"
				 +	"<tr><td style='text-align:left;' class='se-brr'>Avg Weekly Billing</td><td>-</td><td>-</td><td style='text-align:right;'>"+formatNumber(Math.round(actualweeklyBilling))+ "</td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td></tr>"
				 +	"<tr><td style='text-align:left;' class='se-brr'>Customer Visit</td><td>-</td><td style='text-align:right;'>"+${WKLYTRGT*currWeek}+ "</td><td style='text-align:right;'>"+formatNumber(ytdVistactuals)+ "</td><td>-</td><td>"+formatNumber(ytdCustVistit)+"</td><td style='text-align:right;'>"+percentageachievedcustvisit+ "</td><td style='text-align:right;'>"+5+"</td><td style='text-align:right;'>"+(percentageachievedcustvisit*5)/100+"</td></tr>"
				 +	"<tr><td style='text-align:left;' class='se-brr'>Total JIH Lost</td><td>-</td><td>-</td><td style='text-align:right;'>"+formatNumber(Math.round(totJIHLostVal))+ "</td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td></tr>"
				 +	"<tr><td style='text-align:left;width:35%;' class='se-brr'>JIH Lost with NR</td><td>-</td><td>-</td><td style='text-align:right;'>"+formatNumber(Math.round(JIHLostNoRepse))+ "</td><td>-</td><td>-</td><td>-</td><td style='text-align:right;'>"+10+"</td><td style='text-align:right;'><a href='#' data-toggle='modal' data-target='#help-modaljihnoresp'> <i class='fa fa-info-circle pull-right' style='color: #2196f3;font-size: 15px;margin-top: 4px;'></i></a>"+jihpercentageval+"</td></tr>"
				 +  "<tr><td style='text-align:left;'class='se-brr'>Gross Profit </td><td style='text-align:right;'>"+formatNumber(Math.round(gpTarget))+"</td><td style='text-align:right;'>"+formatNumber(Math.round(ytdTargetGp))+"</td><td style='text-align:right;'>"+formatNumber(Math.round(gpActual))+ "</td><td>"+formatNumber(prcntgeGp)+ "</td><td style='text-align:right;'>"+ytdPrcntgeGp+ "</td><td style='text-align:right;'>"+percentageachievedgeGp+ "</td><td style='text-align:right;'>"+50+ "</td><td style='text-align:right;'>"+(percentageachievedgeGp*50)/100+"</td></tr>"
				 //+	"<tr><td style='text-align:left;font-weight: bold;' class='se-brr'>CONVERSION RATIO<a href='#' data-toggle='modal' data-target='#help-modal'> <i class='fa fa-info-circle pull-right' style='color: #2196f3;font-size: 15px;margin-top: 4px;'></i></a></td><td class='se-blr'></td><td>-</td><td>-</td><td style='text-align:right;font-weight: bold'>"+formatNumber(converratio)+ "</td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td></tr>"
				// +	"<tr><td style='text-align:left;' class='se-bbr'></td><td style='text-align:left;' > <90 Days </td><td>-</td><td>-</td><td style='text-align:right;'><fmt:formatNumber pattern='#,###' value='${aging30 + aging3060 + aging6090}' /></td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td></tr>"
				// +	"<tr><td style='text-align:left;' class='se-bbtr'>OUTSTANDING-RECV </td><td style='text-align:left;' > >90 Days </td><td>-</td><td>-</td><td style='text-align:right;'><fmt:formatNumber pattern='#,###' value='${aging90120}' /></td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td></tr>"
				 +	"<tr><td style='text-align:left;background-color:#F08080;font-weight: bold;' >Outstanding-Recv >120 Days </td><td style='background-color:#F08080'>-</td><td style='background-color:#F08080'>-</td><td style='text-align:right;background-color:#F08080;font-weight: bold;'><fmt:formatNumber pattern='#,###' value='${aging120180 + aging181}' /></td><td style='background-color:#F08080'>-</td><td style='background-color:#F08080'>-</td><td style='background-color:#F08080'>-</td><td style='text-align:right;background-color:#F08080'>"+20+"</td><td style='text-align:right;background-color:#F08080'><a href='#' data-toggle='modal' data-target='#help-modalfor120days'> <i class='fa fa-info-circle pull-right' style='color: #2196f3;font-size: 15px;margin-top: 4px;'></i></a>"+billingactualtotalper+"</td></tr>"
				 +	"<tr><td style='text-align:left;font-weight: bold;'> Total %</td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td><td>-</td><td style='text-align:right;font-weight: bold;'>"+Math.round((((percentageachievedbooking*10)/100)+((percentageachievedbilling*5)/100)+((percentageachievedcustvisit*5)/100)+((percentageachievedgeGp*50)/100)+billingactualtotalper+jihpercentageval))+"</td></tr>";
				 
    			output+="</tbody></table>"; 
    			var subTtl1 =  'Conversion Ratio - '+formatNumber(converratio) +"<a href='#' data-toggle='modal' data-target='#help-modal'> <i class='fa fa-info-circle pull-right' style='color: #2196f3;font-size: 15px;padding-right: 75%;'></i></a>";
    			$("#salesman_performance_modal .modal-body").html(output);
    			$("#salesman_performance_modal .modal-subtitle2").html(subTtl1);
    			$("#salesman_performance_modal").modal("show");
    		
    			 $('.modal-dialog').draggable({
				      handle: ".modal-header"
				  });
    			 
    			$("#salesman_performance_table").DataTable( {
    				dom: 'Bfrtip',
    				searching: false,
    			    ordering:  false,
    			    paging: false,
    			    info: false,    			   
    			     buttons: [
    			         {
    			            extend: 'excelHtml5',
    			             text:      '<i class="fa fa-file-excel-o" style="color: #1979a9; font-size: 1em;">Export</i>',
    			             filename: fileName,
    			             title: ttl,
    			             messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'
    			            
    			            
    			         },
    			         {
 			        	    extend: 'print', 
 			        	    exportOptions: {
			        	        stripHtml: false
			        	    },
 			        	    text:      '<i class="fa fa-print" style="color: #1979a9; font-size: 1em;">Print</i>',    			        	  
	 			        	   title: function () {
	 			                  return  printttl +" Conversion Ratio: " + formatNumber(converratio);
	 			              },
			        	    customize: (win) => {	
			        	    	$(win.document.head).append('<style>h1 { font-size: 14px; }</style>'); // Adjust the font size of the title
			        	    	// $(win.document.head).append('<style>h1 { \column-count: 7;\ column-width: 150px;\ text-align: left; \ } \ </style>');
			        	    	//$(win.document.body).find('h1').css('column-count', '2');
			        	        //$(win.document.body).find('h1').css('column-gap', '30px');
			        	       // $(win.document.body).find('h1').css('text-align', 'left');
			        	        $(win.document.body)    			        	        
	                            .css("height", "auto")
		        	            .css("min-height", "0");
			        	        $(win.document.body).find( 'table' )
			                    .addClass( 'compact' )
			                    .css( 'font-size', 'inherit' );
			        	        $(win.document.body).find('table').css('border-collapse', 'collapse');
			        	        $(win.document.body).find('th, td').css('border', '1px solid black');
			        	        $(win.document.body).find('title').css('font-size', '1px');
			        	    }
			         }
    			       
    			    ]
    			 } );
		
	},error:function(data,status,er) {$('#laoding').hide();  alert("please click again");}});
}

//stage 1 detail normal se page
function s1Details() { 
	$('#laoding').show();
var excelTtl='Stage 1 (TENDER) Details of Sales Engineer : ${selected_salesman_code}';
var ttl="<b>Stage 1 (TENDER) Details of Sales Engineer : ${selected_salesman_code} </b> ";
$("#jihv-modal-graph .modal-title").html(ttl);
$.ajax({ 
	type: 'POST',
	url: 'sip',  
	data: {fjtco: "s1_dt", d1:"${selected_salesman_code}"},
	dataType: "json",
    success: function(data) { $('#laoding').hide();var output="<table id='s1dexport' style='height:500px;overflow-y: scroll;overflow-x: scroll;' class='table table-bordered small'><thead><tr>"+ "<th>#</th><th>Comp-Code</th><th>Week</th><th>Qtn-Date</th><th>Qtn-Code</th><th>Qtn-No</th>"+
"<th>Customer Code</th><th>Customer Name</th><th>Project Name</th><th>Consultant</th>"+ " <th>Job Stage</th><th>Product Type</th>  <th>Product Classfctn</th><th>Zone</th><th>Profit (%)</th><th>Qtn Amount</th></tr></thead><tbody>";
var j=0; for (var i in data) { j=j+1; output+="<tr><td>"+j+"</td><td>" + data[i].d1 + "</td>"+"<td>" + data[i].d2 + "</td><td>" + $.trim(data[i].d3.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+ "<td>" + data[i].d4 + "</td><td>" + data[i].d5 + "</td>"+
"<td>" + data[i].d6 + "</td><td>" + data[i].d7 + "</td>"+ "<td>" + data[i].d8 + "</td><td>" + data[i].d9 + "</td>"+ "<td>" + data[i].d10 + "</td><td>" + data[i].d11 + "</td>"+
"<td>" + data[i].d12 + "</td><td>" + data[i].d13 + "</td>"+ "<td>" + data[i].d14 + "</td><td>" + data[i].d15 + "</td>"+ "</tr>"; } 
output+="</tbody></table>";

$("#jihv-modal-graph .modal-body").html(output);$("#jihv-modal-graph").modal("show"); 
$('#s1dexport').DataTable( {
    dom: 'Bfrtip', 
    "columnDefs" : [{"targets":3, "type":"date-eu"}],
    buttons: [
        {
            extend: 'excelHtml5',
            text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
            filename: excelTtl,
            title: excelTtl,
            messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'
            
            
        }
      
       
    ]
} );

},error:function(data,status,er) {$('#laoding').hide();  alert("please click again");}});
}      

function sm_view_details() {
	try {
		selectElement = document.querySelector('#scode');		
	    output = selectElement.options[selectElement.selectedIndex].value;
	    salesEngName = selectElement.options[selectElement.selectedIndex].role;
	    document.getElementById("salesEngName").value =  salesEngName;
		document.getElementById("sf").submit();
		
	}catch(e){
		console.log("Error in sipChartDm.jsp : "+e);
	}
	
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