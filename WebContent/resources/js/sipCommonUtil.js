$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip();   
    $('#laoding').hide();  $('#laoding-rcvbl').hide(); $('#laoding-pdc').hide();$('#laoding-jihqlst').hide();
    $('#help-stages').on('click', function(e) {  
		   $("#help-stages-modal").modal("show");	
	    });
});
function formatNumber(num) {
	 if(typeof num !== 'undefined' && num !== '' && num != null){
		 return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
	 }else{ return 0;}
	
	 }
 function convertToMillion(num) {
	 if(num <= 0){return 0;
	 }else{
		 num = num / Million;
		 return Math.ceil(num * 100)/100;}	 
	 }
 function percentageCal(a,t){var p = (a/t) * 100;   if(isNaN(p) || t==0){ return 0;} else{p=Math.round(p * 100) / 100; return Math.round(p);}}
 function preLoader(){ $('#laoding').show();}
 function drawGuageGraph(actual, target, guagePosition, guageTitle) {
	 var data = google.visualization.arrayToDataTable([ ['Label', 'Value'], [guageTitle, percentageCal(actual, target)], ]);
	 var options = {height: '210',redFrom: 0,redTo: 50,yellowFrom:50,yellowTo: 80, greenFrom: 80, greenTo: 100,};
	 var chart = new google.visualization.Gauge(document.getElementById(guagePosition));
	 	chart.draw(data, options); function resizeHandler () { chart.draw(data, options);}
	 	if (window.addEventListener) { window.addEventListener('resize', resizeHandler, false); }
	 	else if (window.attachEvent) { window.attachEvent('onresize', resizeHandler);}
 }
 
 function getSalesGraphBB(salesValues, currMth){
	 //SALES GRAPH BOOKING BILLING
	 var arr = [];
	 var target=0, ytmActual = 0, monthName='';
	 arr[0] =  ['Month', 'Actual', 'Target'];
	 if(slctdYear < currYear){ 
		 salesValues.map( item => {
			  target = (typeof item.ytm_target === 'undefined'  || item.ytm_target === '')? 0 : item.monthly_target;
			  ytmActual = (typeof item.ytm_actual === 'undefined'  || item.ytm_actual === '')? 0 : item.ytm_actual; 
			  ytmTarget = (typeof item.ytm_target === 'undefined'  || item.ytm_target === '')? 0 : item.ytm_target; 
			  for(var strMth = 1; strMth <= 12; strMth++){
				  monthName = getCustomeMonth(strMth);
				  if(ytmActual == 0){
					  arr[strMth]=[monthName, 0, parseInt(target)];
				  }else{
					  arr[strMth]=[monthName, parseInt(item[monthName.toLowerCase()]), parseInt(target)]; 
				  }
				  
			  }
			  arr[strMth]=['YTD', parseInt(ytmActual), parseInt(ytmTarget)];
		 });
	 }else{ 
		  var currentMonth= parseInt(currMth); 
		  var strMth = 0; 
		  salesValues.map( item => { 
		  for(strMth = 1; strMth <= currentMonth; strMth++){
			     monthName = getCustomeMonth(strMth); 
		    	 if(typeof item.monthly_target === 'undefined'){
		    		 arr[strMth]=[monthName,0,0]; 
		    	 }else{ 
		    		 arr[strMth]=[monthName, parseInt(item[monthName.toLowerCase()]), parseInt(item.monthly_target)];  
		    	 }
		    	 
		     }
		   arr[strMth]=['YTD', parseInt(item.ytm_actual), parseInt(item.ytm_target)];
	 });
		  
		  
	 }
	 return arr;
 }
 function getSalesGraphRemoveYTD(salesValues, currMth){
	 //SALES GRAPH BOOKING BILLING
	 var arr = [];
	 var target=0, ytmActual = 0, monthName='';
	 arr[0] =  ['Month', 'Actual', 'Target'];
	 if(slctdYear < currYear){ 
		 salesValues.map( item => {
			  target = (typeof item.ytm_target === 'undefined'  || item.ytm_target === '')? 0 : item.monthly_target;
			  ytmActual = (typeof item.ytm_actual === 'undefined'  || item.ytm_actual === '')? 0 : item.ytm_actual; 
			  ytmTarget = (typeof item.ytm_target === 'undefined'  || item.ytm_target === '')? 0 : item.ytm_target; 
			  for(var strMth = 1; strMth <= 12; strMth++){
				  monthName = getCustomeMonth(strMth);
				  if(ytmActual == 0){
					  arr[strMth]=[monthName, 0, parseInt(target)];
				  }else{
					  arr[strMth]=[monthName, parseInt(item[monthName.toLowerCase()]), parseInt(target)]; 
				  }
				  
			  }
			 // arr[strMth]=['YTD', parseInt(ytmActual), parseInt(ytmTarget)];
		 });
	 }else{ 
		  var currentMonth= parseInt(currMth); 
		  var strMth = 0; 
		  salesValues.map( item => { 
		  for(strMth = 1; strMth <= currentMonth; strMth++){
			     monthName = getCustomeMonth(strMth); 
		    	 if(typeof item.monthly_target === 'undefined'){
		    		 arr[strMth]=[monthName,0,0]; 
		    	 }else{ 
		    		 arr[strMth]=[monthName, parseInt(item[monthName.toLowerCase()]), parseInt(item.monthly_target)];  
		    	 }
		    	 
		     }
		   //arr[strMth]=['YTD', parseInt(item.ytm_actual), parseInt(item.ytm_target)];
	 });
		  
		  
	 }
	 return arr;
 }
 function getBookingYtdTableForBranch(exportTable, result){
		var output="<table id='"+exportTable+"'  class='table table-bordered small'><thead><tr>"+
			"<th>#</th><th>Company</th><th>Week</th><th>Document Id</th><th>Document Date</th><th>SEg. Code</th><th>SEg. Name</th>"+
			 "<th>Party Name</th><th>Contact</th><th>Telephone</th>"+
	      " <th>Project Name</th><th>Product</th>  <th>Zone</th><th>LOI Received Dt</th><th>Currency</th><th>Amount (AED)</th></tr></thead><tbody>";
		  var j=0;
	      for (var i in result)
		 {
	    	  j=j+1;

		 output+="<tr><td>"+j+"</td><td>" +  $.trim(result[i].d1) + "</td>"+
		 "<td>" +  $.trim(result[i].d2) + "</td><td>" +  $.trim(result[i].d3)+ "</td>"+
		 "<td>" +  $.trim(result[i].d4.substring(0, 10)).split("-").reverse().join("/")+ "</td><td>" +  $.trim(result[i].d5)+ "</td><td>" +  $.trim(result[i].d6)+ "</td>"+
		 "<td>" +  $.trim(result[i].d7) + "</td>"+
		"<td>" +  $.trim(result[i].d8) + "</td><td>" +  $.trim(result[i].d9) + "</td>"+
		 "<td>" +  $.trim(result[i].d10) + "</td><td>" +  $.trim(result[i].d11) + "</td>"+
		 "<td>" +  $.trim(result[i].d12) + "</td><td>" +  $.trim(result[i].d15.substring(0, 10)).split("-").reverse().join("/") + "</td><td>" +  $.trim(result[i].d13) + "</td>"+
		 "<td>" +  $.trim(result[i].d14) + "</td>"+
		 "</tr>";
		 }
	   //  output+="<tr><td colspan='13'><b>Total</b></td><td><b>"+str+"</b></td></tr>";
		 output+="</tbody></table>";
		 return output;
	}
 
function getBookingYtdTable(exportTable, result){
	var output="<table id='"+exportTable+"'  class='table table-bordered small'><thead><tr>"+
		"<th>#</th><th>Company</th><th>Week</th><th>Document Id</th><th>Document Date</th>"+
		 "<th>Party Name</th><th>Contact</th><th>Telephone</th>"+
      " <th>Project Name</th><th>Product</th>  <th>Zone</th><th>LOI Received Dt</th><th>Currency</th><th>Amount (AED)</th></tr></thead><tbody>";
	  var j=0;
      for (var i in result)
	 {
    	  j=j+1;

	 output+="<tr><td>"+j+"</td><td>" +  $.trim(result[i].d1) + "</td>"+
	 "<td>" +  $.trim(result[i].d2) + "</td><td>" +  $.trim(result[i].d3)+ "</td>"+
	 "<td>" +  $.trim(result[i].d4.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+
	 "<td>" +  $.trim(result[i].d7) + "</td>"+
	"<td>" +  $.trim(result[i].d8) + "</td><td>" +  $.trim(result[i].d9) + "</td>"+
	 "<td>" +  $.trim(result[i].d10) + "</td><td>" +  $.trim(result[i].d11) + "</td>"+
	 "<td>" +  $.trim(result[i].d12) + "</td><td>" +  $.trim(result[i].d15.substring(0, 10)).split("-").reverse().join("/") + "</td><td>" +  $.trim(result[i].d13) + "</td>"+
	 "<td>" +  $.trim(result[i].d14) + "</td>"+
	 "</tr>";
	 }
   //  output+="<tr><td colspan='13'><b>Total</b></td><td><b>"+str+"</b></td></tr>";
	 output+="</tbody></table>";
	 return output;
}
function getBillingYtdTableForBranch(exportTable, result){
	var output="<table id='"+exportTable+"' class='table table-bordered small'><thead><tr>"+
		"<th>#</th><th>Company</th><th>Week</th><th>Document Id</th><th>Document Date</th><th>SEg. Code</th><th>SEg. Name</th>"+
		 "<th>Party Name</th><th>Contact</th><th>Telephone</th>"+
      "<th>Project Name</th><th>Product</th>  <th>Zone</th><th>Currency</th><th>Amount (AED)</th></tr></thead><tbody>";
	  var j=0;
      for (var i in result)
	 {
    	  j=j+1;

	 output+="<tr><td>"+j+"</td><td>" +  $.trim(result[i].d1) + "</td>"+
	 "<td>" +  $.trim(result[i].d2) + "</td><td>" +  $.trim(result[i].d3)+ "</td>"+
	 "<td>" +  $.trim(result[i].d4.substring(0, 10)).split("-").reverse().join("/")+ "</td><td>" +  $.trim(result[i].d5)+ "</td><td>" +  $.trim(result[i].d6)+ "</td>"+
	 "<td>" +  $.trim(result[i].d7) + "</td>"+
	"<td>" +  $.trim(result[i].d8) + "</td><td>" +  $.trim(result[i].d9) + "</td>"+
	 "<td>" +  $.trim(result[i].d10) + "</td><td>" +  $.trim(result[i].d11) + "</td>"+
	 "<td>" +  $.trim(result[i].d12) + "</td><td>" +  $.trim(result[i].d13) + "</td>"+
	 "<td>" +  $.trim(result[i].d14) + "</td>"+
	 "</tr>";
	 }
     //output+="<tr><td colspan='12'><b>Total</b></td><td><b>"+str+"</b></td></tr>";
	 output+="</tbody></table>";
	 return output;
}
function getBillingYtdTable(exportTable, result){
	var output="<table id='"+exportTable+"' class='table table-bordered small'><thead><tr>"+
		"<th>#</th><th>Company</th><th>Week</th><th>Document Id</th><th>Document Date</th>"+
		 "<th>Party Name</th><th>Contact</th><th>Telephone</th>"+
      "<th>Project Name</th><th>Product</th>  <th>Zone</th><th>Currency</th><th>Amount (AED)</th></tr></thead><tbody>";
	  var j=0;
      for (var i in result)
	 {
    	  j=j+1;

	 output+="<tr><td>"+j+"</td><td>" +  $.trim(result[i].d1) + "</td>"+
	 "<td>" +  $.trim(result[i].d2) + "</td><td>" +  $.trim(result[i].d3)+ "</td>"+
	 "<td>" +  $.trim(result[i].d4.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+
	 "<td>" +  $.trim(result[i].d7) + "</td>"+
	"<td>" +  $.trim(result[i].d8) + "</td><td>" +  $.trim(result[i].d9) + "</td>"+
	 "<td>" +  $.trim(result[i].d10) + "</td><td>" +  $.trim(result[i].d11) + "</td>"+
	 "<td>" +  $.trim(result[i].d12) + "</td><td>" +  $.trim(result[i].d13) + "</td>"+
	 "<td>" +  $.trim(result[i].d14) + "</td>"+
	 "</tr>";
	 }
     //output+="<tr><td colspan='12'><b>Total</b></td><td><b>"+str+"</b></td></tr>";
	 output+="</tbody></table>";
	 return output;
}
function getJihTable(exportTable, result){
	 var output  = "<table id='"+exportTable+"' style='height:500px;overflow-y: scroll;overflow-x: scroll;' class='table table-bordered small'><thead><tr>";
	     output += "<th>#</th><th>Comp-Code</th><th>Week</th><th>Qtn-Date</th><th>Qtn-Code</th><th>Qtn-No</th>"+
	     			"<th>Customer Code</th><th>Customer Name</th><th>Project Name</th><th>Consultant</th>"+ 
	     			" <th>Invoicing Year</th><th>Product Type</th>  <th>Product Classfctn</th><th>Zone</th><th>Profit (%)</th><th>Qtn Amount</th></th><th>Qtn.Status</th></th><th width='100px'>Reason</th></tr></thead><tbody>";
	 var j=0; 
	 for (var i in result) { 
		 j=j+1; 
		 output += "<tr><td>"+j+"</td><td>" + result[i].d3 + "</td>"+"<td>" + result[i].d4 + "</td><td>" +$.trim(result[i].d5.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+ "<td>" + result[i].d6 + "</td><td>" + result[i].d7 + "</td>"+
	 "<td>" + result[i].d8 + "</td><td>" + result[i].d9 + "</td>"+ "<td>" + result[i].d10 + "</td><td>" + result[i].d11 + "</td>"+ "<td>" + $.trim(result[i].d12.substring(0, 10)).split("-").reverse().join("/") + "</td><td>" + result[i].d13 + "</td>"+
	 "<td>" + result[i].d14 + "</td><td>" + result[i].d15 + "</td>"+ "<td>" + result[i].d16 + "</td><td>" + result[i].d17 + "</td>"+ "<td>" + result[i].d18 + "</td>  <td>" + result[i].d19 + "</td></tr>";
		 }// output+="<tr><td colspan='15'><b>Total</b></td><td><b>"+str+"</b></td></tr>"; 
	 output+="</tbody></table>";
	 return output;
}
function getJihTableForBranch(exportTable, result){
	 var output  = "<table id='"+exportTable+"' style='height:500px;overflow-y: scroll;overflow-x: scroll;' class='table table-bordered small'><thead><tr>";
	     output += "<th>#</th><th>Comp-Code</th><th>Week</th><th>Qtn-Date</th><th>Qtn-Code</th><th>Qtn-No</th>"+
	     			"<th>SEg. Code</th><th>SEg. Name</th><th>Customer Code</th><th>Customer Name</th><th>Project Name</th><th>Consultant</th>"+ 
	     			" <th>Invoicing Year</th><th>Product Type</th>  <th>Product Classfctn</th><th>Zone</th><th>Profit (%)</th><th>Qtn Amount</th></tr></thead><tbody>";
	 var j=0; 
	 for (var i in result) { 
		 j=j+1; 
		 output += "<tr><td>"+j+"</td><td>" + result[i].d3 + "</td>"+"<td>" + result[i].d4 + "</td><td>" +$.trim(result[i].d5.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+ "<td>" + result[i].d6 + "</td><td>" + result[i].d7 + "</td>"+
	 "<td>" + result[i].segCode + "</td><td>" + result[i].segName + "</td><td>" + result[i].d8 + "</td><td>" + result[i].d9 + "</td>"+ "<td>" + result[i].d10 + "</td><td>" + result[i].d11 + "</td>"+ "<td>" + $.trim(result[i].d12.substring(0, 10)).split("-").reverse().join("/") + "</td><td>" + result[i].d13 + "</td>"+
	 "<td>" + result[i].d14 + "</td><td>" + result[i].d15 + "</td>"+ "<td>" + result[i].d16 + "</td><td>" + result[i].d17 + "</td>"+ "</tr>";
		 }// output+="<tr><td colspan='15'><b>Total</b></td><td><b>"+str+"</b></td></tr>"; 
	 output+="</tbody></table>";
	 return output;
}
function uselessHandlerMhvr(id) {$(id).css('cursor','pointer')}
function uselessHandlerMout(id) {$(id).css('cursor','default')}

function selectHandlerBarGraph(type, chart, data, title, modalId, mainTxn, slctdSalesId, exportTable, selectedYear, sipUrl, currYear) { 
	
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
	var ttl="";
	if(type === 'jih'){
		ttl="<b>"+title+" Details of  </b><strong style='color:blue;'>"+slctdSalesId+"</strong> for  <strong style='color:blue;'>"+aging+"</strong> (JIH-HOLD will be auto marked as lost in 372 days) ";
	}else{
		ttl="<b>"+title+" Details of  </b><strong style='color:blue;'>"+slctdSalesId+"</strong> for  <strong style='color:blue;'>"+aging+" -"+selectedYear+" </strong>";
		}
	
	var exclTtl=""+title+" Details of "+slctdSalesId+" for "+aging+"";
	$(""+modalId+" .modal-title").html(ttl);
    var apiProps = {}; 
   $.ajax({
		 type: 'POST',
   	 url: sipUrl, 
   	 data: {fjtco: mainTxn, seCode:slctdSalesId , agng:aging, slctdYr: selectedYear,curYear:currYear},
   	 dataType: "json",
 		 success: function(result) {
 		
 		
 			var output ="";
 			if(type === 'booking'){
 				output += getBookingYtdTable(exportTable, result);
 			}else if(type === 'billing'){
 				output += getBillingYtdTable(exportTable, result);
 			}else if(type === 'jih'){
 				output += getJihTable(exportTable, result);
 			}else{
 				
 			}
			
 			  $(""+modalId+" .modal-body").html(output);
 			$(modalId).modal("show");
 			$("#"+exportTable+"").DataTable( {
 		     dom: 'Bfrtip',       
 		     buttons: [
 		         {
 		             extend: 'excelHtml5',
 		             text:'<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
 		             filename: exclTtl,
 		             title: exclTtl,
 		             messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'
 		             
 		             
 		         }
 		       
 		        
 		     ]
 		 } );	
 			
 },
 error:function(result,status,er) {	  alert("please click again");  }
});


//start  script for deselect column - on modal close
chart.setSelection([{'row': null, 'column': null}]); 
//end  script for deselect column - on modal close
}  
function selectBranchHandlerBarGraph(type, chart, data, title, modalId, mainTxn, slctdSalesId, exportTable, selectedYear, sipUrl, companyCode) {  
	 var selection = chart.getSelection();
	 var message = '';
	 for (var i = 0; i < selection.length; i++) {
	 		var item = selection[i];
			 if (item.row != null && item.column != null) {
				 var str = data.getFormattedValue(item.row, 1); // var str = data.getFormattedValue(item.row, item.column);
				 var aging = data.getValue(chart.getSelection()[0].row, 0)
		 	}
		} 
	var ttl="";
	if(type === 'jih'){
		ttl="<b>"+title+" Details of  </b><strong style='color:blue;'>"+companyCode+"</strong> for  <strong style='color:blue;'>"+aging+"</strong>";
	}else{
		ttl="<b>"+title+" Details of  </b><strong style='color:blue;'>"+companyCode+"</strong> for  <strong style='color:blue;'>"+aging+" -"+selectedYear+" </strong>";
		}
	
	var exclTtl=""+title+" Details of "+companyCode+" for "+aging+"";
	$(""+modalId+" .modal-title").html(ttl);
   var apiProps = {}; 
  $.ajax({
		 type: 'POST',
  	 url: sipUrl, 
  	 data: {fjtco: mainTxn, secodes:slctdSalesId , compCode:companyCode, agng:aging, slctdYr: selectedYear},
  	 dataType: "json",
		 success: function(result) { 
			var output ="";
			if(type === 'booking'){
				output += getBookingYtdTableForBranch(exportTable, result);
			}else if(type === 'billing'){
				output += getBillingYtdTableForBranch(exportTable, result);
			}else if(type === 'jih'){
				output += getJihTableForBranch(exportTable, result);
			}else{
				
			}
			
			  $(""+modalId+" .modal-body").html(output);
			$(modalId).modal("show");
			$("#"+exportTable+"").DataTable( {
		     dom: 'Bfrtip',       
		     buttons: [
		         {
		             extend: 'excelHtml5',
		             text:'<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
		             filename: exclTtl,
		             title: exclTtl,
		             messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'
		             
		             
		         }
		       
		        
		     ]
		 } );	
			
},
error:function(result,status,er) {	  alert("please click again");  }
});


//start  script for deselect column - on modal close
chart.setSelection([{'row': null, 'column': null}]); 
//end  script for deselect column - on modal close
}  
function s34Summary(){ 
	$('#laoding').show();
$.ajax({ type: 'POST', url: 'sip',data: {fjtco: "s34_sum", sm1:selectdSalesId}, success: function(data) { 
	 $('#laoding').hide();
	 var str = data;
	 var res = str.split(","); 
	 if(res[0]){ 
	     $("#s1sum").html('<strong>'+extractValue(res[0])+'</strong>');
		    $("#s1sum_temp").val(''+formatNumber(res[0])+'');}
	else{
		    $("#s1sum").html('<strong>0</strong>');
		 	$("#s1sum_temp").val('0')
		 	} 
	if(res[1]){ 
		    $("#s3sum").html('<strong>'+extractValue(res[1])+'</strong>');
	     $("#s3sum_temp").val(''+formatNumber(res[1])+'');
	     $("#s3sumnoformat").val(res[1]);}
	else{
		    $("#s3sum").html('<strong>0</strong>');
		    $("#s3sum_temp").val('0');
		    $("#s3sumnoformat").val('0');
		} 
	if(res[2]){ 
		 $("#s4sum").html('<strong>'+extractValue(res[2])+'</strong>');
		 $("#s4sum_temp").val(''+formatNumber(res[2])+'');
		 $("#s4sumnoformat").val(res[2]);
		 }
	else{$("#s4sum").html('<strong>0</strong>'); $("#s4sum_temp").val('0');$("#s4sumnoformat").val('0');} 
	if(res[3]){ 
		 $("#s5sum").html('<strong>'+extractValue(res[3])+'</strong>');
		 $("#s5sum_temp").val(''+formatNumber(res[3])+'');
		 $("#s5sumnoformat").val(res[3]);
		 }
	else{
		$("#s5sum").html('<strong>0</strong>'); 
		$("#s5sum_temp").val('0');
		$("#s5sumnoformat").val('0');
		} 
}, error:function(data,status,er) {  $('#laoding').hide();alert("please click again");}});}
function extractValue(value) { 
    // Nine Zeroes for Billions
    return Math.abs(Number(value)) >= 1.0e+9

    ? (Math.abs(Number(value)) / 1.0e+9).toFixed(2) + "B"
    // Six Zeroes for Millions 
    : Math.abs(Number(value)) >= 1.0e+6

    ? (Math.abs(Number(value)) / 1.0e+6).toFixed(2) + "M"
    // Three Zeroes for Thousands
    : Math.abs(Number(value)) >= 1.0e+3

    ? (Math.abs(Number(value)) / 1.0e+3).toFixed(2) + "K"

    : (Math.abs(Number(value))).toFixed(2);
    
}   