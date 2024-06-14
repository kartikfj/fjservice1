<%-- 
    Document   : SIP MAIN DIVISION  
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="mainview.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.google.gson.Gson"%>
<%
  DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
  Calendar cal = Calendar.getInstance();
  int month = cal.get(Calendar.MONTH)+1;  
  int iYear = cal.get(Calendar.YEAR);  
  String currCalDtTime = dateFormat.format(cal.getTime());
  request.setAttribute("CURR_YR",iYear);
  request.setAttribute("MTH",month);
  request.setAttribute("currCal", currCalDtTime);

  
 %>
 <c:set var="syrtemp" value="${CURR_YR}" scope="page" />
<!DOCTYPE html>
<html><head>
 <style>
#guage_test_booking,#guage_test_billing { height: 210px; width: 100%;}#guage_test_billing svg, #guage_test_booking svg{ border: 1px solid #9E9E9E;margin-top: 20px; border-radius: 5px;} 
.nav-tabs-custom>.nav-tabs>li.active { border-top: 2px solid #065685 !important;}svg:first-child > g > text[text-anchor~=middle]{ font-size: 18px;font-weight: bold; fill: #337ab7;}.modal-dialog, .modal-content { /* 80% of window height */ /* height: 80%;*/height: calc(100% - 20%);}
.modal-body {  /* 100% = dialog height, 120px = header + footer */ max-height: calc(100% - 120px); overflow-y: scroll; overflow-x: scroll;}
.modal-body th{ font-weight:bold;}.modal-footer {padding: 2px 15px 15px 15px !important;}.loader {position: fixed; z-index: 999; height: 2em;width: 2em;overflow: show; margin: auto; top: 0;left: 0;bottom: 0; right: 0;}
.loader:before { content: '';display: block;position: fixed;top: 0; left: 0;width: 100%; height: 100%; background-color: rgba(0,0,0,0.3);}.stage{ background-color: #065685;color: white; border: 1px solid #065685;}
.navbar { margin-bottom: 8px !important;} .table{display: block !important; overflow-x:auto !important;}#db-title-boxx{background: white; height: auto;; margin-top: -9px; margin-left: -10px; margin-right: -10px; box-shadow: 0 0 4px rgba(0,0,0,.14), 0 4px 8px rgba(0,0,0,.28);}
.lastTd{border-right: none !important;border-left: none !important;}.fjtco-table {background-color: #ffff;padding: 0.01em 16px; margin: 7px 7px 7px 15px; box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important;border-top: 3px solid #065685;}
.small-box>.inner { padding: 5px;height: 75px;}.small-box h3 {font-size: 25px !important;}.container {padding-right: 0px !important; padding-left: 0px !important;}
.wrapper{margin-top:-8px;}.counter-anim{color:#FFEB3B;font-weight: normal !important;font-size: 80%;}.counter-anim:hover{cursor: pointer;color:red;}
.collapse.in { background: #3b80a9;color: white;text-align: center; font-weight: bold;font-size: larger;display: block;}.weight-500{color:#FFF;font-weight: bold;font-size: 80%;}.padding-0{padding-right:0; padding-left:0;width: 150px;margin-bottom: -18px;}
.paddingr-0{padding-right:0; padding-left:0;width: 150px; margin-bottom: -18px;}.paddingl-0{padding-left:0;padding-right:0; width: 150px;margin-bottom: -18px;}
.fjtco-table .panel-body {padding: 3px;}.box-tools{cursor: pointer;}.row{margin-left:0px !important;margin-right:0px !important;}#stages-dt .col-lg-6 {margin-top: -5px;}
 #stages-dt .small-box .icon { -webkit-transition: all .3s linear; -o-transition: all .3s linear;transition: all .3s linear; position: absolute; top: -5px; right: 10px; z-index: 0; font-size: 60px; color: rgba(0,0,0,0.15);}
.main-header {z-index: 851 !important;}.box-header .box-title{font-size:15px !important;font-weight:bold !important;}.nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li.active>a:hover{color: #000 !important; background-color: #fff !important; }
.nav-tabs>li>a{color: #3c8dbc !important; background-color: #ecf0f5 !important;}.modal-title {color: #009688 !important;font-weight: bold !important;}.overlay {position: absolute;}
.box .overlay {margin-top: -19px !important;right: 15px !important;}#jihLostModalGraph th, #jihLostModalGraph td,#billing_modal_table td,#billing_modal_table th,#booking_modal_table td,#booking_modal_table th,#jihv_modal_table td,#jihv_modal_table th{padding: 5px !important;border: 1px solid #2196F3;}
#chart_div{height:230px;margin-top:-37px;}@media ( max-width : 375px) {#chart_div{margin-top: -19px;}.modal-title{font-size: 95%;}#billing_modal_table_wrapper,#jihv_modal_table_wrapper, #booking_modal_table_wrapper{margin-right: 5px;}.box-header 
.box-title {font-size: 13px !important;}#guage_test_billing svg{ margin-left: -15px !important}}
@media ( max-width : 450px) {}@media ( max-width : 400px) {}@media ( max-width : 700px) {}@media (min-width: 1200px){}
.fjtco-rcvbles{background-color: #ffff;  padding: 0.01em 16px; margin: 7px 7px 7px 15px;  box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important;border-top: 3px solid #9e9e9e;}
.fjtco-rcvbles .panel-body{padding:5px !important;} #subdivnBkng_table,#subdivnBlng_table {border: 1px solid #9C27B0; table-layout: fixed;  width: max-content; } #subdivnBkng_table  tfoot th, #subdivnBkng_table tfoot td.#subdivnBlng_table  tfoot th, #subdivnBlng_table tfoot td {padding: 5px 5px 5px 5px;}
#subdivnBkng_table tfoot th,#subdivnBkng_table tbody td,#subdivnBlng_table tbody td,#subdivnBlng_table tfoot th {padding: 5px 5px;  font-size: 90%;font-weight: bold;}
#fcast_table,#weeklybkngrprt_table { border: 1px solid red; table-layout: fixed;  width: max-content; }
#fcast_table th, #weeklybkngrprt_table th, #lowestOrder_table td {padding: 7px 3px !important;}
#fcast_table th,#fcast_table th,#weeklybkngrprt_table th { border-bottom: 1px solid red; border-bottom-width: 1px;border-bottom-style: solid;border-bottom-color: red;}
#weeklybkngrprt_table_wrapper div.dt-buttons,#subdivnBkng_table_wrapper div.dt-buttons,#subdivnBlng_table_wrapper div.dt-buttons{position: relative;float: right;margin-top: -50px;right: 40px;}
#fcast_table_wrapper div.dt-buttons{margin-top:-25px;}
.fj_mngmnt_dm_div{ margin-top: 8px;  margin-right: 3%;}
.fj_mngmnt_dm_slctbx{ outline: none; color: white;background: #3c8dbc; margin-bottom: 1em; padding: .25em; border: 0; border-bottom: 2px solid currentcolor; font-weight: bold;letter-spacing: .15em; border-radius: 0;}
#jih_lost_dtls_modal .modal-dialog,#onaccnt-third-layer .modal-dialog{height: calc(100% - 20%);}#jih_lost_dtls_modal .modal-body,#onaccnt-third-layer .modal-body{max-height: calc(100% - 120px);overflow-y: scroll;overflow-x: scroll;}
#onaccnt-third-layer th,#onaccnt-third-layer td{font-size: 80%;} table.onAcSummary tbody th, table.onAcSummary tbody td { padding: 3px 5px; }#netBlOnAc{background: #F44336;  width: max-content;  border-radius: 5px;  margin-left: 10%;  padding: 2px;color:#fff;}
.help-right { z-index: 50; background: rgba(255, 255, 255, 0.7); border: 2px solid #3c8dbc; font-size: 15px; color: #3c8dbc;position: absolute; padding: 2px 0px 2px 6px; cursor: pointer; top: 5px; right: 15px; border-radius: 5px;}
#jihv_box_body{height:224px;}
#subdivnBkng_table thead th,#subdivnBlng_table thead th{    padding: 10px 10px !important;}
#jihv table, #jihv table th, #jihv table td{border: 1px solid green;}
#jihv table th{ padding: 6px 3px 6px 3px;} #jihv table td { padding: 6px 6px 6px 6px;}
#lost_modal_table th,#lost_modal_table td{padding: 5px !important; border: 1px solid #2196F3;}
.stage-details-graph {z-index: 50; background: rgba(255, 255, 255, 0.7); border: 2px solid #3c8dbc;font-size: 15px; color: #3c8dbc; position: absolute; padding: 2px 0px 2px 6px;cursor: pointer; top: 5px; right: 150px; border-radius: 5px;}
</style>
<link rel="stylesheet" href="resources/bower_components/font-awesome/css/font-awesome.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="resources/bower_components/font-awesome/css/font-awesome.min.css">
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

 <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
 
 <!-- jquery library for dragging the model -->
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js"></script>

 <script type="text/javascript">
 var Million = 1000000;
 var totLosts = 0, targeteportsList = <%=new Gson().toJson(request.getAttribute("JIHLA"))%>;
 function preLoader(){ $('#laoding').show();}
 $(document).ready(function() { $('#laoding').hide();$('#laoding-rcvbl').hide();$('#laoding-pdc').hide();$('#laoding-jihqlst').hide();
 $("#myModal").draggable({ handle: ".modal-header" });
 });  
 function formatNumber(num) {return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");}
 function convertToMillion(num) {
	 if(num <= 0){return 0; }else{
		 num = num / Million;
		 return Math.ceil(num * 100)/100;}	 
	 }
 function s34Summary(){ $('#laoding').show();
 $.ajax({ type: 'POST', url: 'sipMainDivision',data: {fjtco: "s34_sum",d2:'${DFLTDMCODE}'}, success: function(data) { $('#laoding').hide();var str = data;var res = str.split(","); 
//$("#s3sum").html('<strong>'+res[0]+'</strong>'); //$("#s4sum").html(''<strong>'+res[1]+'</strong>');

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
else{$("#s4sum").html('<strong>0</strong>'); $("#s4sum_temp").val('0');
	 $("#s4sumnoformat").val('0');}
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
 
 function s3Details(val){ $('#laoding').show(); 
 var ttl="<b>Stage 3 Details of <i> ${DIVDEFTITL} </i></b>";
 var excelTtl="Stage 3 Details of ${DIVDEFTITL}";
 
 $(".modal-title").html(ttl);
 $.ajax({ type: 'POST', url: 'sipMainDivision', data: {fjtco: "s3_dt",d2:'${DFLTDMCODE}'}, dataType: "json", success: function(data) { $('#laoding').hide();
 var output="<table  id='s3-excl' class='table table-bordered small'><thead><tr>"+"<th>#</th><th>Week</th><th>Zone</th><th>Product Category</th><th>Product Sub Category</th>"+
 "<th>Project Name</th><th>Consultant</th><th>Customer</th><th>Quotation Date</th><th>Quotation Code</th><th>Quotation No.</th>"+
 " <th>Amount</th><th>Average GP</th><th>LOI Received Date</th>  <th>Exp Po Date</th><th>Invoicing Year</th></tr></thead><tbody>";
 var j=0; for (var i in data) {j=j+1; output+="<tr><td>"+j+"</td><td>" + $.trim( data[i].d1) + "</td>"+ "<td>" + $.trim( data[i].d2 ) + "</td>"+
 "<td>" + $.trim( data[i].d4 ) + "</td><td>" + $.trim(data[i].d5) + "</td>"+ "<td>" + $.trim(data[i].d6 )+ "</td><td>" + $.trim(data[i].d7) + "</td>"+
 "<td>" + $.trim(data[i].d8) + "</td><td>" + $.trim(data[i].d9.substring(0, 10)).split("-").reverse().join("/") + "</td>"+ "<td>" + $.trim(data[i].d10) + "</td><td>" + $.trim(data[i].d11) + "</td>"+
 "<td>" + $.trim(data[i].d12)+ "</td><td>" + data[i].d13 + "</td>"+ "<td>" + $.trim(data[i].d14.substring(0, 10)).split("-").reverse().join("/") + "</td><td>" + $.trim(data[i].d15.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+
 "<td>" + $.trim(data[i].d16.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+ "</tr>"; }
// output+="<tr><td colspan='15'><b>Total</b></td><td><b>"+val+"</b></td></tr>"; output+="</tbody></table>"; 
 $("#stageDetails34 .modal-body").html(output);$("#stageDetails34").modal("show");
 $('#stageDetails34 #s3-excl').DataTable( {
     dom: 'Bfrtip',   
     "columnDefs" : [{"targets": [ 8, 13, 14, 15], "type":"date-eu"}],
     buttons: [
         {
             extend: 'excelHtml5',
             text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 1em;">Export</i>',
             filename: excelTtl,
             title: excelTtl,
             messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'
             
             
         }
       
        
     ]
 } );
 },error:function(data,status,er) { $('#laoding').hide(); alert("please click again"); }});}
 function s4Details(val){ $('#laoding').show(); 
 var ttl="<b>Stage 4 Details of <i> ${DIVDEFTITL}</i></b>";var exclTtl="Stage 4 Details of  ${DIVDEFTITL}";
 $(".modal-title").html(ttl);$.ajax({ type: 'POST',url: 'sipMainDivision', data: {fjtco: "s4_dt",d2:'${DFLTDMCODE}'}, dataType: "json",success: function(data) {
 $('#laoding').hide();var output="<table id='s4-excl' class='table table-bordered small'><thead><tr>"+"<th>#</th><th>So Date</th><th>So Txn Code</th><th>Order No.</th>"+
 "<th>Sales Egr.</th><th>Zone</th><th>Product Category</th><th>Product Sub Category</th><th>Project Name</th>"+ " <th>Consultant</th><th>Payment Term</th><th>Customer</th>  <th>Profit %</th><th>Balance Value</th>"+ "<th>Projected Invoice Date</th><th>Soh Location Code</th></tr></thead><tbody>";
 var j=0;for (var i in data) { j=j+1; output+="<tr><td>"+j+"</td><td><span>" + $.trim(data[i].d1.substring(0, 10)).split("-").reverse().join("/")+ "</span></td>"+
 "<td>" + $.trim(data[i].d2)+ "</td><td>" + $.trim(data[i].d3) + "</td>"+ "<td>" +$.trim(data[i].d4)+" - "+$.trim(data[i].d5)+"</td>"+
 "<td>" + $.trim(data[i].d8 )+ "</td><td>" +$.trim( data[i].d9 )+ "</td>"+ "<td>" + $.trim(data[i].d10 )+ "</td><td>" + $.trim(data[i].d11 )+ "</td>"+ "<td>" + $.trim(data[i].d12 )+ "</td><td>" + $.trim(data[i].d13 )+ "</td>"+
 "<td>" + $.trim(data[i].d14 )+ "</td><td>" + $.trim(data[i].d15)+ "</td>"+ "<td>" + $.trim(data[i].d16)+ "</td>"+ "<td>" + $.trim(data[i].d17.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+
 "<td>" +$.trim( data[i].d18)+ "</td>"+ "</tr>"; }  
 //output+="<tr><td colspan='16'><b>Total</b></td><td><b>"+val+"</b></td></tr>"; 
 output+="</tbody></table>";  $("#stageDetails34 .modal-body").html(output);$("#stageDetails34").modal("show");
 $('#stageDetails34 #s4-excl').DataTable( {
     dom: 'Bfrtip',  
     "columnDefs" : [{"targets": [1, 14], "type":"date-eu"}],
     buttons: [
         {
             extend: 'excelHtml5',
             text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 1em;">Export</i>',
             filename: exclTtl,
             title: exclTtl,
             messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'
             
             
         }
       
      
     ]
 } );
 },error:function(data,status,er) { $('#laoding').hide(); alert("please click again");} });} 
 
 function s5Details(val){ $('#laoding').show(); 
 var ttl="<b>Stage 5 Details of <i> ${DIVDEFTITL}</i></b>";var exclTtl="Stage 5 Details of  ${DIVDEFTITL}";
 $(".modal-title").html(ttl);$.ajax({ type: 'POST',url: 'sipMainDivision', data: {fjtco: "s5_dt",d2:'${DFLTDMCODE}'}, dataType: "json",success: function(data) {
	 
 $('#laoding').hide();
 var output="<table id='s5-excl'  class='table table-bordered small'><thead><tr>"+
	"<th>#</th><th>Company</th><th>Week</th><th>Document Id</th><th>Document Date</th>"+
	 "<th>Sales Egr: Code</th><th>Sales Egr: Name</th><th>Party Name</th><th>Contact</th><th>Telephone</th>"+
    " <th>Project Name</th><th>Product</th>  <th>Zone</th><th>Currency</th><th>Amount (AED)</th><th>Division</th></tr></thead><tbody>";
	  var j=0;
    for (var i in data)
	 {
  	  j=j+1;

	 output+="<tr><td>"+j+"</td><td>" +  $.trim(data[i].d1) + "</td>"+
	 "<td>" +  $.trim(data[i].d2) + "</td><td>" +  $.trim(data[i].d3)+ "</td>"+
	 "<td>" +  $.trim(data[i].d4.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+
	 "<td>" +  $.trim(data[i].d5) + "</td><td>" +  $.trim(data[i].d6) + "</td><td>" +  $.trim(data[i].d7) + "</td>"+
	"<td>" +  $.trim(data[i].d8) + "</td><td>" +  $.trim(data[i].d9) + "</td>"+
	 "<td>" +  $.trim(data[i].d10) + "</td><td>" +  $.trim(data[i].d11) + "</td>"+
	 "<td>" +  $.trim(data[i].d12) + "</td><td>" +  $.trim(data[i].d13) + "</td><td>" +  $.trim(data[i].d14) + "</td>"+
	 "<td>" +  $.trim(data[i].d15) + "</td>"+
	 "</tr>";
	 }
 //  output+="<tr><td colspan='15'><b>Total</b></td><td><b>"+str+"</b></td></tr>";
	 output+="</tbody></table>";
 $("#stageDetails34 .modal-body").html(output);$("#stageDetails34").modal("show");
 $('#stageDetails34 #s5-excl').DataTable( {
     dom: 'Bfrtip',  
     "columnDefs" : [{"targets": [1, 14], "type":"date-eu"}],
     buttons: [
         {
             extend: 'excelHtml5',
             text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 1em;">Export</i>',
             filename: exclTtl,
             title: exclTtl,
             messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'
             
             
         }
       
      
     ]
 } );
 },error:function(data,status,er) { $('#laoding').hide(); alert("please click again");} });} 
 
 function show2ndLayerQtnLost(aging_header,agingVal) {  
 $('#laoding').show(); 
     var division_header='${DIVDEFTITL}';
 var ttl="<b>JIH Quotation Lost Details of  ${DIVDEFTITL} </b><strong style='color:blue;'> </strong> Division for "+aging_header+" <strong style='color:blue;'>  </strong> ";
 var exclTtl="JIH Quotation Lost Details of  ${DIVDEFTITL}  Division";
 $("#qtn_lost_modal-main .modal-title").html(ttl); $.ajax({ type: 'POST',url: 'sipMainDivision',  data: {fjtco: "tdvhij",d2:'${DFLTDMCODE}', avfad:agingVal }, dataType: "json",
 success: function(data) {	
	 $('#laoding').hide();	
	 var output="<table id='qtnlost' class='table table-bordered small'><thead><tr>"+ "<th>#</th><th>Week</th><th>Company</th><th>Qtn-Date</th><th>Qtn-Code</th><th>Qtn Number</th><th>Qtn Status</th>"+
 				"<th>Customer Code</th><th>Customer Name</th><th>Sales Egr: Code</th><th>Sales Egr: Name</th>"+ " <th>Project Name</th><th>Consultant</th><th>Invoicing Year</th><th>Product Type</th>  <th>Product Classfctn</th><th>Zone</th><th>Profit (%)</th><th>Qtn Amount</th></tr></thead><tbody>";
	 var j=0; var qtnStatus; for (var i in data) { j=j+1 ;qtnStatus=$.trim(data[i].d18);	 
	 if(qtnStatus == "P"){qtnStatus='<small class="label label-warning" style="font-weight: bold;font-size: 100%;"><i class="fa fa-clock-o"></i>&nbsp;&nbsp;PENDING</small>';}
	 else if(qtnStatus == "W"){qtnStatus='<small class="label label-success"  style="font-weight: bold;font-size: 100%;"><i class="fa fa-clock-o"></i>&nbsp;&nbsp;WON</small>';}
	 else if(qtnStatus == "L"){qtnStatus='<small class="label label-danger"  style="font-weight: bold;font-size: 100%;"><i class="fa fa-clock-o"></i>&nbsp;&nbsp;LOST</small>';}
	 else{qtnStatus="<b>-</b>"}
 
 output+="<tr><td>"+j+"</td><td>" + data[i].d2 + "</td>"+"<td>" + data[i].d1 + "</td><td>" + $.trim(data[i].d3.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+ "<td>" + data[i].d4 + "</td><td>" + data[i].d5 + "</td>"+
 "<td>"+qtnStatus+"</td><td>" + data[i].d6 + "</td><td>" + data[i].d7 + "</td>"+ "<td>" + data[i].d8 + "</td><td>" + data[i].d9 + "</td>"+ "<td>" + data[i].d10 + "</td><td>" + data[i].d11 + "</td>"+
 "<td>" +$.trim(data[i].d12.substring(0, 10)).split("-").reverse().join("/") + "</td><td>" + data[i].d13 + "</td>"+ "<td>" + data[i].d14 + "</td><td>" + data[i].d15 + "</td><td>" + data[i].d16 + "</td><td align='right'>" + formatNumber(data[i].d17) + "</td></tr>"; } 
 output+="</tbody></table>";
 

 $("#qtn_lost_modal-main .modal-body").html(output);$("#qtn_lost_modal-main").modal("show");	
 
	    $('#qtnlost').DataTable( {
	        dom: 'Bfrtip',  
	        "columnDefs" : [{"targets": [3, 13], "type":"date-eu"}],
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
 function changeTitle(title){ $('#jihlost-title').html(title); }
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip(); 
    $('#help-stages').on('click', function(e) {  
		   $("#help-stages-modal").modal("show");	
	    });
});

//stage 1 detail normal se page
function s1Details() { 
	$('#laoding').show();
var excelTtl='Stage 1 (TENDER) Details of <i> ${DIVDEFTITL} </i>';
var ttl="<b>Stage 1 (TENDER) Details of  ${DIVDEFTITL}  </b> ";
$("#stageDetails34 .modal-title").html(ttl);
$.ajax({ 
	type: 'POST',
	url: 'sipMainDivision',  
	data: {fjtco: "s1_dt", d1:'${DFLTDMCODE}'},
	dataType: "json",
    success: function(data) { $('#laoding').hide();var output="<table id='s1dexport' style='height:500px;overflow-y: scroll;overflow-x: scroll;' class='table table-bordered small'><thead><tr>"+ "<th>#</th><th>Comp-Code</th><th>Week</th><th>Qtn-Date</th><th>Qtn-Code</th><th>Qtn-No</th>"+
    "<th>Customer Code</th><th>Customer Name</th><th>Project Name</th><th>Consultant</th>"+ " <th>Job Stage</th><th>Product Type</th>  <th>Product Classfctn</th><th>Zone</th><th>Profit (%)</th><th>Qtn Amount</th></tr></thead><tbody>";
    var j=0; for (var i in data) { j=j+1; output+="<tr><td>"+j+"</td><td>" + data[i].d1 + "</td>"+"<td>" + data[i].d2 + "</td><td>" + $.trim(data[i].d3.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+ "<td>" + data[i].d4 + "</td><td>" + data[i].d5 + "</td>"+
    "<td>" + data[i].d6 + "</td><td>" + data[i].d7 + "</td>"+ "<td>" + data[i].d8 + "</td><td>" + data[i].d9 + "</td>"+ "<td>" + data[i].d10 + "</td><td>" + data[i].d11 + "</td>"+
    "<td>" + data[i].d12 + "</td><td>" + data[i].d13 + "</td>"+ "<td>" + data[i].d14 + "</td><td>" + data[i].d15 + "</td>"+ "</tr>"; } 
output+="</tbody></table>";

$("#stageDetails34 .modal-body").html(output);$("#stageDetails34").modal("show"); 
$('#s1dexport').DataTable( {
    dom: 'Bfrtip', 
    "columnDefs" : [{"targets": 3, "type":"date-eu"}],
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
</script>
 
 
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
  
 <c:set var="sales_egr_code" value="0" scope="page" /> 
 <c:set var="year_target" value="0" scope="page" /> 
 <c:set var="actual" value="0" scope="page" /> 
 <c:set var="guage_bkng_ytd_target" value="0" scope="page" /> 
  <c:set var="guage_blng_ytd_target" value="0" scope="page" /> 
 <c:forEach var="ytm_tmp1" items="${YTM_BOOK}">  
 <c:set var="year_target" value="${ytm_tmp1.yr_total_target}" scope="page" />
 <c:set var="actual" value="${ytm_tmp1.ytm_actual}" scope="page" />
  <c:set var="guage_bkng_ytd_target" value="${ytm_tmp1.ytm_target}" scope="page" />
 </c:forEach>

 
 <c:set var="year_targetbl" value="0" scope="page" />
 <c:set var="actualbl" value="0" scope="page" />
 <c:forEach var="ytm_tmp2" items="${YTM_BILL}">  
 <c:set var="year_targetbl" value="${ytm_tmp2.yr_total_target}" scope="page" /> <c:set var="actualbl" value="${ytm_tmp2.ytm_actual}" scope="page" />
  <c:set var="guage_blng_ytd_target" value="${ytm_tmp2.ytm_target}" scope="page" /> 
 </c:forEach>
 <script type="text/javascript">
 function percentageCal(a,t){ var p = (a/t) * 100;   if(isNaN(p) || t==0){ return 0;} else{p=Math.round(p * 100) / 100; return p;}}
 google.charts.load('current', {'packages':['corechart', 'gauge','table']});
 google.charts.setOnLoadCallback(drawJobInHandVolume);
 google.charts.setOnLoadCallback(drawPerfomanceSummaryBookingYtd);
 google.charts.setOnLoadCallback(drawPerfomanceSummaryBillingYtd);
 google.charts.setOnLoadCallback(drawChart11);
 google.charts.setOnLoadCallback(drawChart11bl);
 google.charts.setOnLoadCallback(function (){
	 drawJihLostPieChart('jihLostCountAnlysys', 'lostCount');
	});
 
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
		 	//tooltip: { trigger: 'selection' },
		 	pieSliceTextStyle: {  color: 'white',},  slices: {  7: {offset: 0.4},}, 
			legend:{ /* position: 'labeled', */  
				textStyle: {color: 'blue', fontSize: 10, textStyle: {bold:true, fontName: 'monospace'}}
		 		},
				chartArea:{left:5,top:20,width:'100%',height:'100%'},
				backgroundColor:{fill: '#f9fbfc'},
				sliceVisibilityThreshold:0, 
		 };

		  var chart = new google.visualization.PieChart(document.getElementById(id));
		  chart.setAction({
	          id: 'sample',
	          text: 'Click Details',
	          action: function() {
	            selection = chart.getSelection();  
	            getJihLostAnalysisDtls(data.getValue(chart.getSelection()[0].row, 0));
	          }
	        });

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
            filename: 'JIH Qtn. Lost Analysis of Sales Egr:  ${DIVDEFTITL}',
            title: 'JIH Qtn. Lost Analysis of Sales Egr:  ${DIVDEFTITL}',
            messageTop: 'The information in this file is copyright to Faisal Jassim Group.',
            exportOptions: {
                columns: [ 0, 1, 2  ]
            }                        
        }          
    ]
} );
}
 
 function drawChart11() {var data = google.visualization.arrayToDataTable([ ['Label', 'Value'], ['Booking', percentageCal(${actual},${guage_bkng_ytd_target})], ]);
 var options = {height: '210',redFrom: 0,redTo: 50,yellowFrom:50,yellowTo: 80, greenFrom: 80, greenTo: 100,};
 var chart = new google.visualization.Gauge(document.getElementById('guage_test_booking'));
 chart.draw(data, options); function resizeHandler () { chart.draw(data, options);}
 if (window.addEventListener) { window.addEventListener('resize', resizeHandler, false); }
 else if (window.attachEvent) { window.attachEvent('onresize', resizeHandler);}}
 
 function drawChart11bl() { var data = google.visualization.arrayToDataTable([ ['Label', 'Value'], ['Billing', percentageCal(${actualbl},${guage_blng_ytd_target})],]);
 var options = {  height: '210', redFrom: 0, redTo: 50, yellowFrom:50,  yellowTo: 80, greenFrom: 80, greenTo: 100, };
 var chart = new google.visualization.Gauge(document.getElementById('guage_test_billing'));
 chart.draw(data, options);  function resizeHandler () { chart.draw(data, options); } if (window.addEventListener) {  window.addEventListener('resize', resizeHandler, false);}
 else if (window.attachEvent) {window.attachEvent('onresize', resizeHandler);}}

 function drawJobInHandVolume() { var data = new google.visualization.DataTable();
 data.addColumn('string', 'Topping'); data.addColumn('number', 'Amount'); data.addColumn({type:'number', role:'annotation'});data.addColumn({type:'string', role: 'style' });
 data.addRows([ 
	 <c:choose>
	 <c:when test="${JIHV ne null or !empty JIHV}">
	 <c:forEach var="JOBV" items="${JIHV}"> 
	 ['${JOBV.duration}', ${JOBV.amount},<fmt:formatNumber type='number' pattern='###.##' value='${JOBV.amount/1000000}' />,'#01b8aa'],  
	 </c:forEach> 
	   </c:when>
	   <c:otherwise>
	   ['0-3 Month',0,0,'#01b8aa'], 
	   ['3-6 Month',0,0,'#01b8aa'], 
	   ['>6 Month',0,0,'#01b8aa'], 
	   </c:otherwise>
	   </c:choose>
	 ]);
 var options = {'title':'Job in hand volume for Last 2 Years from <%=iYear%> - (AED)', 
		 titleTextStyle: {
		      color: '#000',
		      fontSize: 13,
		      fontName: 'Arial',
		      bold: true
		   },'vAxis': {title: 'Amount (In Millions)',titleTextStyle: {italic: false},format: 'short'}, 'legend':'none', 'chartArea': { top: 70, right: 12,  bottom: 48, left: 60,  height: '100%', width: '100%'  }, 'height':240 };
 var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
 chart.draw(data, options);
 google.visualization.events.addListener(chart, 'onmouseover', uselessHandler2); google.visualization.events.addListener(chart, 'onmouseout', uselessHandler3); google.visualization.events.addListener(chart, 'select', selectHandler);
 function uselessHandler2() {$('#chart_div').css('cursor','pointer')} function uselessHandler3() {$('#chart_div').css('cursor','default')}
 function selectHandler() { var dmCode= '${DFLTDMCODE}';$('#laoding').show();
 var selection = chart.getSelection(); var message = '';
 for (var i = 0; i < selection.length; i++) {  var item = selection[i];
 if (item.row != null && item.column != null) { var str = data.getFormattedValue(item.row, item.column); var aging = data.getValue(chart.getSelection()[0].row, 0)
 message += '{row:' + item.row + ',column:' + item.column + '} = ' + str + '  The Aging is:' + aging + '\n';
 } else if (item.row != null) { var str = data.getFormattedValue(item.row, 0); message += '{row:' + item.row
 + ', column:none}; value (col 0) = ' + str  + '  The Aging..is:' + aging + '\n'; } else if (item.column != null) { var str = data.getFormattedValue(0, item.column);
 message += '{row:none, column:' + item.column + '}; value (row 0) = ' + str + '  The Aging is:' + aging + '\n'; } } //alert('You selected ' + message+"");
 var ttl="<b>Job In Hand Volume Details of ${DIVDEFTITL} for "+aging+"</b> (JIH-HOLD will be auto marked as lost in 372 days) ";
 var exclTtl="Job In Hand Volume Details of ${DIVDEFTITL} for "+aging+"";
 $("#jihv-excl-modal .modal-title").html(ttl); $.ajax({ type: 'POST',url: 'sipMainDivision',  data: {fjtco: "aging_dt",  d1:aging,d2:dmCode}, dataType: "json",
 success: function(data) { $('#laoding').hide();var output="<table id='jihv_xcl'  class='table table-bordered small' ><thead><tr>"+ "<th>#</th><th>Comp-Code</th><th>Week</th><th>Qtn-Date</th><th>Qtn-No</th><th>Qtn-Code</th>"+
 "<th>Customer Code</th><th>Customer Name</th><th>Project Name</th><th>Consultant</th><th>Invoicing Year</th><th>Product Type</th>  <th>Product Classfctn</th><th>Zone</th><th>Profit (%)</th><th>Qtn Amount</th><th>Qtn Status</th><th width='100px'>Reason</th></tr></thead><tbody>";
 var j=0; for (var i in data) { j=j+1; qtnStatus=$.trim(data[i].d18);
 if(qtnStatus == "P"){qtnStatus='<small class="label label-warning" style="font-weight: bold;font-size: 100%;"><i class="fa fa-clock-o"></i>&nbsp;&nbsp;PENDING</small>';}
 else if(qtnStatus == "W"){qtnStatus='<small class="label label-success"  style="font-weight: bold;font-size: 100%;"><i class="fa fa-clock-o"></i>&nbsp;&nbsp;WON</small>';}
 else if(qtnStatus == "L"){qtnStatus='<small class="label label-danger"  style="font-weight: bold;font-size: 100%;"><i class="fa fa-clock-o"></i>&nbsp;&nbsp;LOST</small>';}
 else if(qtnStatus == "H"){qtnStatus='<small class="label label-primary"  style="font-weight: bold;font-size: 100%;"><i class="fa fa-clock-o"></i>&nbsp;&nbsp;HOLD</small>';}
 else{qtnStatus="<b>-</b>"}
 
 output+="<tr><td>"+j+"</td><td>" + data[i].d3 + "</td>"+"<td>" + data[i].d4 + "</td><td>" + data[i].d5.substring(0, 10).split("-").reverse().join("/") + "</td>"+ "<td>" + data[i].d6 + "</td><td>" + data[i].d7 + "</td>"+
 "<td>" + data[i].d8 + "</td><td>" + data[i].d9 + "</td>"+ "<td>" + data[i].d10 + "</td><td>" + data[i].d11 + "</td>"+ "<td>" + data[i].d12.substring(0, 10).split("-").reverse().join("/")  + "</td><td>" + data[i].d13 + "</td>"+
 "<td>" + data[i].d14 + "</td><td>" + data[i].d15 + "</td>"+ "<td>" + data[i].d16 + "</td><td>" + data[i].d17 + "</td><td> " + qtnStatus + "</td><td> " + data[i].d19 + "</td></tr>"; } //output+="<tr><td colspan='15'><b>Total</b></td><td><b>"+str+"</b></td></tr>"; 
 output+="</tbody></table>";
 $("#jihv-excl-modal .modal-body").html(output);$("#jihv-excl-modal").modal("show"); 
 $('#jihv_xcl').DataTable( {
     dom: 'Bfrtip',
     "columnDefs" : [{"targets": [3, 10], "type":"date-eu"}],
     buttons: [
         {
             extend: 'excelHtml5',
             text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 1em;">Export</i>',
             filename: exclTtl,
             title: exclTtl,
             messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'
             
             
         }
       
        
     ]
 } );
 },error:function(data,status,er) {$('#laoding').hide();  alert("please click again");}});
 //start  script for deselect column - on modal close
 chart.setSelection([{'row': null, 'column': null}]); 
 //end  script for deselect column - on modal close
 }}
 
 
 function drawPerfomanceSummaryBookingYtd(){ 
	 var data = google.visualization.arrayToDataTable([ ['Month', 'Actual', 'Target'],
	 <c:choose>
	 <c:when test="${YTM_BOOK ne null and not empty YTM_BOOK}">
	 <c:forEach var="ytm_tmp" items="${YTM_BOOK}"> 
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
	         //['YTD', ${ytm_tmp.ytm_actual},${ytm_tmp.ytm_target}],
		   
	   </c:forEach>
	   </c:when>
	   <c:otherwise>
	   ['Month', 0,0],  
	  // ['YTD', 0,0],
	   </c:otherwise>
	   </c:choose>
        ]);
          // Set chart options
          var options = {
						  'title':'Booking - Target Vs Actual - ${syrtemp}, (YTD). \r\n Monthly Target - <c:forEach var="ytm_tmp" items="${YTM_BOOK}"> <fmt:formatNumber type="number"   value="${ytm_tmp.monthly_target}"/> : Yealry Target - <fmt:formatNumber type="number"   value="${ytm_tmp.yr_total_target}"/>\r\n YTD Actual - <fmt:formatNumber type="number"   value="${ytm_tmp.ytm_actual}"/> : YTD Target - <fmt:formatNumber type="number"   value="${ytm_tmp.ytm_target}"/></c:forEach> ',
						  'vAxis': {title: 'Amount (In Millions)',titleTextStyle: {italic: false},format: 'short'},
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
						      bar: { groupWidth: "10%" },
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
          google.visualization.events.addListener(chart, 'onmouseover', uselessHandlerbk2);
          google.visualization.events.addListener(chart, 'onmouseout', uselessHandlerbk3);
          google.visualization.events.addListener(chart, 'select', selectHandlerbk);
          function uselessHandlerbk2() {$('#chart_div').css('cursor','pointer')}
          function uselessHandlerbk3() {$('#chart_div').css('cursor','default')}
         function selectHandlerbk() {
        	 $('#laoding').show();
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
         
          var ttl="<b>Booking Details of  ${DIVDEFTITL}  for  "+aging+" - ${syrtemp} </b>";
          var exclTtl="Booking Details of ${DIVDEFTITL} for "+aging+"";
          $("#booking-excl-modal .modal-title").html(ttl);

        $.ajax({
 	    		 type: 'POST',
 	        	 url: 'sipMainDivision', 
 	        	 data: {fjtco: "bkm_dt", bk1:aging, bk2:"${syrtemp}",d2:'${DFLTDMCODE}'},
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

 					 output+="<tr><td>"+j+"</td><td>" +  $.trim(data[i].d1) + "</td>"+
 					 "<td>" +  $.trim(data[i].d2) + "</td><td>" +  $.trim(data[i].d3)+ "</td>"+
 					 "<td>" +  $.trim(data[i].d4.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+
 					 "<td>" +  $.trim(data[i].d5) + "</td><td>" +  $.trim(data[i].d6) + "</td><td>" +  $.trim(data[i].d7) + "</td>"+
 					"<td>" +  $.trim(data[i].d8) + "</td><td>" +  $.trim(data[i].d9) + "</td>"+
 					 "<td>" +  $.trim(data[i].d10) + "</td><td>" +  $.trim(data[i].d11) + "</td>"+
 					 "<td>" +  $.trim(data[i].d12) + "</td><td>" +  $.trim(data[i].d13) + "</td><td>" +  $.trim(data[i].d14) + "</td>"+
 					 "<td>" +  $.trim(data[i].d15) + "</td>"+
 					 "</tr>";
 					 }
 				   //  output+="<tr><td colspan='15'><b>Total</b></td><td><b>"+str+"</b></td></tr>";
 					 output+="</tbody></table>";
 					
 		  			  $("#booking-excl-modal .modal-body").html(output);
 		  			$("#booking-excl-modal").modal("show");
 		  			
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
 		  error:function(data,status,er) {
 			 
 		    alert("please click again");
 		   }
 		 });
         
         
          //start  script for deselect column - on modal close
          chart.setSelection([{'row': null, 'column': null}]); 
        //end  script for deselect column - on modal close
          }
        }
      
      function drawPerfomanceSummaryBillingYtd() {
      	
          // Create the data table.
        var data = google.visualization.arrayToDataTable([
          ['Month', 'Actual','Target'],         
         <c:choose>
     	 <c:when test="${YTM_BILL ne null and not empty YTM_BILL}">
             <c:forEach var="ytm_tmp" items="${YTM_BILL}">          
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
	          //['YTD', ${ytm_tmp.ytm_actual},${ytm_tmp.ytm_target}], 
	          </c:forEach>
	   </c:when>
	   <c:otherwise>
	          ['Month',0,0],  
	          //['YTD', 0,0],
	    </c:otherwise>
	    </c:choose>
      ]);

          // Set chart options
          var options = {'title':'Billing - Target Vs Actual - ${syrtemp}, (YTD). \r\n Mothly Target - <c:forEach var="ytm_tmp" items="${YTM_BILL}"> <fmt:formatNumber type="number"   value="${ytm_tmp.monthly_target}" /> : Yearly Target - <fmt:formatNumber type="number"   value="${ytm_tmp.yr_total_target}" />\r\n YTD Actual - <fmt:formatNumber type="number"   value="${ytm_tmp.ytm_actual}"/> : YTD Target - <fmt:formatNumber type="number"   value="${ytm_tmp.ytm_target}"/></c:forEach>  ',	
        		  'vAxis': {title: 'Amount (In Millions)',titleTextStyle: {italic: false},format: 'short'}, 
        		
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
						      bar: { groupWidth: "10%" },
						      'height': 240,
						      'legend': {
						        position: 'top'
						      },
						      colors: ['#fcb441', 'blue'],
						      hAxis: { slantedText:true, slantedTextAngle:90 }
		  };
          

          // Instantiate and draw our chart, passing in some options.
          var chart = new google.visualization.ColumnChart(document.getElementById('prf_summ_billing_ytd'));
          chart.draw(data, options);
          
          google.visualization.events.addListener(chart, 'onmouseover', uselessHandlerbl2);
          google.visualization.events.addListener(chart, 'onmouseout', uselessHandlerbl3);
          google.visualization.events.addListener(chart, 'select', selectHandlerbl);
          function uselessHandlerbl2() {$('#chart_div').css('cursor','pointer')}
          function uselessHandlerbl3() {$('#chart_div').css('cursor','default')}
         function selectHandlerbl() {
        	 $('#laoding').show();
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
         
          var ttl="<b>Billing Details of   ${DIVDEFTITL}  for  "+aging+" - ${syrtemp}</b>";
          var exclTtl="Billing Details of   ${DIVDEFTITL}  for  "+aging+" - ${syrtemp}";
         $("#billing-excl-modal .modal-title").html(ttl);

        $.ajax({
 	    		 type: 'POST',
 	        	 url: 'sipMainDivision', 
 	        	 data: {fjtco: "blm_dt", bl1:aging, bl2:"${syrtemp}",d2:'${DFLTDMCODE}'},
 	        	 dataType: "json",
 		  		 success: function(data) {
 		  		
 		  			$('#laoding').hide();
 		  			var output="<table id='blng_main' class='table table-bordered small'><thead><tr>"+
 		  			"<th>#</th><th>Company</th><th>Week</th><th>Document Id</th><th>Document Date</th>"+
		  			 "<th>Sales Egr: Code</th><th>Sales Egr: Name</th><th>Party Name</th><th>Contact</th><th>Telephone</th>"+
				      " <th>Project Name</th><th>Product</th>  <th>Zone</th><th>Currency</th><th>Amount (AED)</th><th>Division</th></tr></thead><tbody>";
					  var j=0;
 				      for (var i in data)
 					 {
 				    	  j=j+1;

 				    	 output+="<tr><td>"+j+"</td><td>" +  $.trim(data[i].d1) + "</td>"+
 	 					 "<td>" +  $.trim(data[i].d2) + "</td><td>" +  $.trim(data[i].d3)+ "</td>"+
 	 					 "<td>" +  $.trim(data[i].d4.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+
 	 					 "<td>" +  $.trim(data[i].d5) + "</td><td>" +  $.trim(data[i].d6) + "</td><td>" +  $.trim(data[i].d7) + "</td>"+
 	 					"<td>" +  $.trim(data[i].d8) + "</td><td>" +  $.trim(data[i].d9) + "</td>"+
 	 					 "<td>" +  $.trim(data[i].d10) + "</td><td>" +  $.trim(data[i].d11) + "</td>"+
 	 					 "<td>" +  $.trim(data[i].d12) + "</td><td>" +  $.trim(data[i].d13) + "</td><td>" +  $.trim(data[i].d14) + "</td>"+
 	 					 "<td>" +  $.trim(data[i].d15) + "</td>"+
 	 					 "</tr>";
 					 }
 				      
 					 output+="</tbody></table>";
 					
 		  			  $("#billing-excl-modal .modal-body").html(output);
 		  			$("#billing-excl-modal ").modal("show");
 		  		 $('#blng_main').DataTable( {
 			        dom: 'Bfrtip',  
 			       "columnDefs" : [{"targets": 4, "type":"date-eu"}],
 			        buttons: [
 			            {
 			                extend: 'excelHtml5',
 			                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 1em;">Export</i>',
 			                filename: exclTtl,
 			                title: exclTtl,
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
      
  //Stage 2 details division
function s2Details() { var dmCode= '${DFLTDMCODE}';$('#laoding').show();

 var ttl="<b>Stage 2 Details of Division ${DIVDEFTITL}</b> ";
 var exclTtl="Stage 2 Details of Division ${DIVDEFTITL}";
 $("#jihv-excl-modal .modal-title").html(ttl); $.ajax({ type: 'POST',url: 'sipMainDivision',  data: {fjtco: "stage2_dt", d1:dmCode}, dataType: "json",
 success: function(data) { $('#laoding').hide();var output="<table id='jihv_xcl'  class='table table-bordered small' ><thead><tr>"+ "<th>#</th><th>Comp-Code</th><th>Week</th><th>Qtn-Date</th><th>Qtn-No</th><th>Qtn-Code</th>"+
 "<th>Customer Code</th><th>Customer Name</th><th>Project Name</th><th>Consultant</th><th>Invoicing Year</th><th>Product Type</th>  <th>Product Classfctn</th><th>Zone</th><th>Profit (%)</th><th>Qtn Amount</th></tr></thead><tbody>";
 var j=0; for (var i in data) { j=j+1; output+="<tr><td>"+j+"</td><td>" + data[i].d3 + "</td>"+"<td>" + data[i].d4 + "</td><td>" + $.trim(data[i].d5.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+ "<td>" + data[i].d6 + "</td><td>" + data[i].d7 + "</td>"+
 "<td>" + data[i].d8 + "</td><td>" + data[i].d9 + "</td>"+ "<td>" + data[i].d10 + "</td><td>" + data[i].d11 + "</td>"+ "<td>" + $.trim(data[i].d12.substring(0, 10)).split("-").reverse().join("/") + "</td><td>" + data[i].d13 + "</td>"+
 "<td>" + data[i].d14 + "</td><td>" + data[i].d15 + "</td>"+ "<td>" + data[i].d16 + "</td><td>" + data[i].d17 + "</td></tr>"; } //output+="<tr><td colspan='15'><b>Total</b></td><td><b>"+str+"</b></td></tr>"; 
 output+="</tbody></table>";
 $("#jihv-excl-modal .modal-body").html(output);$("#jihv-excl-modal").modal("show"); 
 $('#jihv_xcl').DataTable( {
     dom: 'Bfrtip',    
     "columnDefs" : [{"targets": [3, 10], "type":"date-eu"}],
     buttons: [
         {
             extend: 'excelHtml5',
             text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 1em;">Export</i>',
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
       <c:if test="${fjtuser.sales_code eq 'MG001' || fjtuser.sales_code eq 'MG002' || fjtuser.sales_code eq 'AC003' || fjtuser.sales_code eq 'AC002'}">
       <form method="post" action="sipMainDivision">
      <div class="fj_mngmnt_dm_div pull-right">
   <select class="fj_mngmnt_dm_slctbx" name="dmCodemgmnt" id="dmCode_mg" onchange="preLoader();this.form.submit()" required>
   <option>Select Division Managers </option>
   
  <c:forEach var="dm_List"  items="${DmsLstFMgmnt}" >
					
					  	<option value="${dm_List.dmEmp_Code}" ${dm_List.dmEmp_Code  == DFLTDMCODE ? 'selected':''}> ${dm_List.dmEmp_name}</option>
  </c:forEach>
   </select>
   </div>
   <input type="hidden" name="fjtco" value="dmfsltdmd">
   </form>
   </c:if>
    </nav>

  </header>
  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
 

      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu" data-widget="tree">
           <c:choose>
             <c:when test="${fjtuser.role eq 'mg'  and fjtuser.sales_code ne null}"> 
      		  <li><a href="SipBranchPerformance"><i class="fa fa-building-o"></i><span>Branch Performance</span></a></li> 
              <li><a href="DmInfo.jsp"><i class="fa fa-dashboard"></i><span>Sales Engineers Performance</span></a></li>
              <li><a href="DisionInfo.jsp?empcode=${DFLTDMCODE}""><i class="fa fa-line-chart"></i><span>Sub Division Performance</span></a></li>
              <li class="active"><a href="CompanyInfo.jsp"><i class="fa fa-pie-chart"></i><span>Division Performance</span></a></li>
              <li><a href="consolidatedData.jsp"><i class="fa fa-balance-scale"></i><span>Financial Position</span></a></li>
             <li><a href="SipUserActivity"><i class="fa fa-table"></i><span>SE Activity History</span></a></li>
<!--               <li><a href="SipJihDues"><i class="fa fa-table"></i><span>JIH Dues</span></a></li>   -->
<!--               <li><a href="SipLOIDues"><i class="fa fa-table"></i><span>LOI Dues</span></a></li>  -->
              <li><a href="SipStageFollowUpController"><i class="fa fa-database"></i><span>Stage Follow-Up</span></a></li>
              <li><a href="sipWeeklyReport"><i class="fa fa-bar-chart"></i><span>Weekly-Sales Report</span></a></li>
              <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>
              </c:when>
             <c:when test="${fjtuser.salesDMYn ge 1  and fjtuser.sales_code ne null}">
             <c:if test="${fjtuser.role eq 'gm'}">
      		 	<li><a href="SipBranchPerformance"><i class="fa fa-building-o"></i><span>Branch Performance</span></a></li>
      		  </c:if>
              <li><a href="DmInfo.jsp"><i class="fa fa-dashboard"></i><span>Sales Engineers Performance</span></a></li>
              <li><a href="DisionInfo.jsp"><i class="fa fa-line-chart"></i><span>Sub Division Performance</span></a></li>
              <li class="active"><a href="CompanyInfo.jsp"><i class="fa fa-pie-chart"></i><span>Division Performance</span></a></li>
              <li><a href="ConsolidatedReport"><i class="fa fa-balance-scale"></i><span>Financial Position</span></a></li>
              <li><a href="SipUserActivity"><i class="fa fa-table"></i><span>SE Activity History</span></a></li>
<!--               <li><a href="SipJihDues"><i class="fa fa-table"></i><span>JIH Dues</span></a></li> -->
<!--               <li><a href="SipLOIDues"><i class="fa fa-table"></i><span>LOI Dues</span></a></li>   -->
              <li><a href="SipStageFollowUpController"><i class="fa fa-database"></i><span>Stage Follow-Up</span></a></li>
              <li><a href="sipWeeklyReport"><i class="fa fa-bar-chart"></i><span>Weekly-Sales Report</span></a></li> 
              <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>
              </c:when>
             <c:otherwise>
              <li><a href="DmInfo.jsp"><i class="fa fa-dashboard"></i><span>Sales Engineers Performance</span></a></li> 
              <c:if test="${fjtuser.emp_code eq 'E001977'}">
              	<li><a href="consolidatedData.jsp"><i class="fa fa-balance-scale"></i><span>Financial Position</span></a></li>
              </c:if>
<!--               <li><a href="SipJihDues"><i class="fa fa-table"></i><span>JIH Dues</span></a></li>  -->
<!--               <li><a href="SipLOIDues"><i class="fa fa-table"></i><span>LOI Dues</span></a></li>   -->
              <li><a href="SipStageFollowUpController"><i class="fa fa-database"></i><span>Stage Follow-Up</span></a></li>
              <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>
             </c:otherwise>               
           </c:choose>
            
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper" style="margin-top: -8px;">
  	<div id="myModal" class="modal">
		  <div class="modal-content" style="width: 25%; height: 40%; margin-left: auto; margin-right: 25%;margin-top: 10%;">	
		  	<div class="modal-header">		  
         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
          		<h4 class="modal-title">Stage details of Division - ${DIVDEFTITL} </h4>
        	</div>	   
		    <div class="modal-body"> <div id="stagedetailsgraph"></div></div>
		  </div>
		</div>
       
    <!-- Main content -->
    <div class="row">
    <div class="col-md-8">
    <div class="fjtco-table" style="border:none;font-size:20px;margin-top:10px;padding:10px;font-style:bold;margin-left: 0px;color:#065685;">${DIVDEFTITL}</div>
   </div> <div class="col-md-4 col-xs-12">
  <ul class="nav nav-tabs pull-left" style=" margin-top: 12px; border: 1px solid #3c8dbc;font-weight: bold;width: max-content !important;">
         <li  class="active pull-right" style="    margin-bottom: 0px !important;"><a data-toggle="tab" href="#bb1-meter"  style="border-right:transparent;" >Target Achieved  %</a></li>
          <li class="pull-right"><a data-toggle="tab" href="#stages-dt" onclick="s34Summary();">Stage Details</a></li>
         
          
          </ul>
         </div>
         

   </div>
   
            <div class="row"  style="">
       <div  class="col-lg-12 col-md-12 col-sm-12 fjtco-rcvbles"  style="padding:7px;">
   <c:forEach var="rcvbl_list_date"  items="${ORAR}" > <c:set var="rcvble_date" value="${rcvbl_list_date.pr_date}" scope="page" /> </c:forEach>
   
    <c:set var ="recievable_date" value = "${fn:substring(rcvble_date, 0, 10)}" />
   
 <b style="font-size:14px !important;font-weight:bold !important;"> Outstanding Receivable Aging  (Value in base local currency) > 100AED&nbsp;</b> <i>As on 

<fmt:parseDate value="${rcvble_date}" var="theDate"    pattern="yyyy-MM-dd HH:mm" />
<fmt:formatDate value="${theDate}" pattern="dd-MM-yyyy, HH:mm"/>
   AM</i>
 				  
           <div class="row">
     
					<div class="col-lg-2 col-md-3 col-sm-3 col-xs-12 paddingr-0" id="agwdth110">
						<div class="panel panel-default card-view pa-0">
							<div class="panel-wrapper collapse in">
								<div class="panel-body pa-0">
									<div class="sm-data-box">
										<div class="container-fluid">
											<div class="row">
													<span class="weight-500 font-13"><30 Days</span><br/>
													<span class="counter-anim" onclick="show2ndLayerOutRcvbles('${DFLTDMCODE}','30','<30 Days');"><fmt:formatNumber pattern="#,###" value="${aging30}" /></span>		
											</div>	
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
						<div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 padding-0"  id="agwdth112">
						<div class="panel panel-default card-view pa-0">
							<div class="panel-wrapper collapse in">
								<div class="panel-body pa-0">
									<div class="sm-data-box">
										<div class="container-fluid">
											<div class="row">	
													<span class="weight-500">31-60 Days</span><br/>
													<span class="counter-anim"  onclick="show2ndLayerOutRcvbles('${DFLTDMCODE}','3060','31 - 60 Days');"><fmt:formatNumber pattern="#,###" value="${aging3060}" /></span>
												</div>
											</div>	
										</div>
									</div>
								</div>
							</div>
						</div>
					
				
					<div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 padding-0"  id="agwdth112">
						<div class="panel panel-default card-view pa-0">
							<div class="panel-wrapper collapse in">
								<div class="panel-body pa-0">
									<div class="sm-data-box">
										<div class="container-fluid">
											<div class="row">
													<span class="weight-500 font-13">61-90  Days</span>	<br/>
													<span class="counter-anim" onclick="show2ndLayerOutRcvbles('${DFLTDMCODE}','6090','61 - 90 Days');"><fmt:formatNumber pattern="#,###" value="${aging6090}" /></span>
											</div>	
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 padding-0" id="agwdth110">
						<div class="panel panel-default card-view pa-0">
							<div class="panel-wrapper collapse in">
								<div class="panel-body pa-0">
									<div class="sm-data-box">
										<div class="container-fluid">
											<div class="row">
													<span class="weight-500">91-120 Days</span><br/>
													<span class="counter-anim"  onclick="show2ndLayerOutRcvbles('${DFLTDMCODE}','90120','91 - 120 Days');"><fmt:formatNumber pattern="#,###" value="${aging90120}" /></span>
											</div>	
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
						<div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 padding-0"  id="agwdth112">
						<div class="panel panel-default card-view pa-0">
							<div class="panel-wrapper collapse in">
								<div class="panel-body pa-0">
									<div class="sm-data-box">
										<div class="container-fluid">
											<div class="row">	
													<span class="weight-500">121-180  Days</span><br/>
														<span class="counter-anim"  onclick="show2ndLayerOutRcvbles('${DFLTDMCODE}','120180','121 - 180 Days');"><fmt:formatNumber pattern="#,###" value="${aging120180}" /></span>
											</div>	
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
			
					<div class="col-lg-2 col-md-4 col-sm-4 col-xs-12 paddingl-0" id="agwdth112">
						<div class="panel panel-default card-view pa-0">
							<div class="panel-wrapper collapse in">
								<div class="panel-body pa-0">
									<div class="sm-data-box">
										<div class="container-fluid">
											<div class="row">
													<span class="weight-500">>180  Days</span><br/>
													<span class="counter-anim"  onclick="show2ndLayerOutRcvbles('${DFLTDMCODE}','181','>180 Days');"><fmt:formatNumber pattern="#,###" value="${aging181}" /></span>
											</div>	
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
			
				</div>

	   
	</div>
	
			
				</div>
 
   
	   
	   
	   <div class="row"> <br/>
        <div class="col-md-6">
          <!-- AREA CHART -->
          <div class="box box-primary" style="margin-bottom: 8px;">                   
             <div class="box-header with-border">						 
				<h3 class="box-title" id="jihlost-title">Job In Hand Volume Details</h3>  
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
												<c:choose>
												<c:when test="${!empty JIHVLOST}">
													<c:forEach var="JOBV" items="${JIHVLOST}">
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
															<td style="color: #00a65a;">${JOBV.aging1_count_actual}</td>
															<td style="color: #00a65a;">${JOBV.aging2_count_actual}</td>
															<td style="color: #00a65a;">${JOBV.aging3_count_actual}
															</td>
														</tr>
														<tr>
															<td style="color: #00a65a;">VALUE</td>
															<td><span class="description-percentage text-green"><i
																	class="fa fa-caret-up"></i> <fmt:formatNumber
																		type="number" pattern="###.##"
																		value="${JOBV.aging1_amt_actual/1000000}" />M</span></td>
															<td><span class="description-percentage text-green"><i
																	class="fa fa-caret-up"></i> <fmt:formatNumber
																		type="number" pattern="###.##"
																		value="${JOBV.aging2_amt_actual/1000000}" />M</span></td>
															<td><span class="description-percentage text-green"><i
																	class="fa fa-caret-up"></i> <fmt:formatNumber
																		type="number" pattern="###.##"
																		value="${JOBV.aging3_amt_actual/1000000}" />M</span></td>
														</tr>
														<tr>
															<th rowspan="2" style="color: #dd4b39;">LOST</th>
															<td style="color: #dd4b39;">COUNT</td>
															<td style="color: #dd4b39;">
																${JOBV.aging1_count_lost}</td>
															<td style="color: #dd4b39;">${JOBV.aging2_count_lost}</td>
															<td style="color: #dd4b39;">${JOBV.aging3_count_lost}</td>
														</tr>
														<tr>
															<td style="color: #dd4b39;">VALUE</td>
												 			<td><span class="description-percentage text-red"><i
																	class="fa fa-caret-down"></i> <fmt:formatNumber
																		type="number" pattern="#,###.##"
																		value="${JOBV.aging1_amt_lost/1000000}" />M</span></td>
															<td><span class="description-percentage text-red"><i
																	class="fa fa-caret-down"></i> <fmt:formatNumber
																		type="number" pattern="#,###.##"
																		value="${JOBV.aging2_amt_lost/1000000}" />M</span></td>
															<td><span class="description-percentage text-red"><i
																	class="fa fa-caret-down"></i> <fmt:formatNumber
																		type="number" pattern="#,###.##"
																		value="${JOBV.aging3_amt_lost/1000000}" />M</span></td>
														</tr>
													</c:forEach>
													               </c:when>
                                                  <c:otherwise>
                                                  
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
															<td style="color: #00a65a;"> 0</td>
															<td style="color: #00a65a;"> 0</td>
															<td style="color: #00a65a;"> 0</td>
														</tr>
														<tr>
															<td style="color: #00a65a;">VALUE</td>
															<td><span class="description-percentage text-green"><i
																	class="fa fa-caret-up"></i>  0</span></td>
															<td><span class="description-percentage text-green"><i
																	class="fa fa-caret-up"></i> 0</span></td>
															<td><span class="description-percentage text-green"><i
																	class="fa fa-caret-up"></i> 0</span></td>
														</tr>
														<tr>
															<th rowspan="2" style="color: #dd4b39;">LOST</th>
															<td style="color: #dd4b39;">COUNT</td>
															<td style="color: #dd4b39;"> 0</td>
															<td style="color: #dd4b39;"> 0</td>
															<td style="color: #dd4b39;"> 0</td>
														</tr>
														<tr>
															<td style="color: #dd4b39;">VALUE</td>
												 			<td><span class="description-percentage text-red"><i
																	class="fa fa-caret-down"></i> 0</span></td>
															<td><span class="description-percentage text-red"><i
																	class="fa fa-caret-down"></i> 0</span></td>
															<td><span class="description-percentage text-red"><i
																	class="fa fa-caret-down"></i> 0</span></td>
														</tr>
                                                  
                                   
                                                  
                                                  </c:otherwise>
                                                  </c:choose>
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
          <div class="box box-danger" style="margin-bottom: 8px;">
           
            <div class="box-body">
              <div id="prf_summ_booking_ytd" style="height:230px;margin-top:-10px;"></div>  
              <br/>
             <div class="overlay">
				<a href="#" data-toggle="modal" data-target="#booking_moreinfo_modal">More info
				 <i class="fa fa-arrow-circle-right"></i></a> </div>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->

			    <div class="box box-danger" style="margin-bottom: 8px;border-color:#607d8b;">
           <div class="box-header with-border">
			<h3 class="box-title" >JIH Qtn. Lost Analysis </h3>
			</div>
            <div class="box-body">
                <div class="chart">
                    <div id="jihLostCountAnlysys" style="height:230px;margin-top:-10px;"></div>  <br/>
               <div class="overlay">
				<a href="#" data-toggle="modal" data-target="#jihLostModalGraph">More info
				 <i class="fa fa-arrow-circle-right"></i></a> </div> 
              </div> 
            </div>
            <!-- /.box-body -->
          </div>
        </div>
        <!-- /.col (LEFT) -->
        <div class="col-md-6">
        
         
        
          <!-- Stage 3 4 CHART -->
         
          <!-- Custom tabs (Charts with tabs)-->
        <section style="margin-bottom: -11px;border-top: 3px solid #3366cc; border-radius: 3px;">
         <div class="nav-tabs-custom" >
         
        
           <div class="tab-content" style="height: 277px;">
           <div id="stages-dt" class="tab-pane fade">
           <div class="box-header with-border" style="margin-top: -10px;"> 
			      <h3 class="box-title">STAGE DETAILS </h3>
			        <div class="help-right" id="help-stages">
						<i class="fa fa-info-circle pull-left"></i>
					</div>
			  </div>
             <div class="row">
					<!--  commenting stage 1 as part of RK comments implementation changes. -->
	            <!--   <div class="col-lg-6 col-xs-6"><c:set var="jihv_total" value="0" scope="page" /> <c:forEach var="JOBV" items="${JIHV}">
	              <c:set var="jihv_total" value="${jihv_total + JOBV.amount}" scope="page" /> </c:forEach> 
			 	  <div class="small-box bg-red">
	              <div class="inner"> 
	                 <h3>Stage 1</h3><p id="s1sum"></p>
	                <input type="hidden" id="s1sum_temp" value="0" />
	               </div>
	              <div class="icon"><i class="fa fa-pie-chart"></i></div>
	              <a href="#" onclick="s1Details(document.getElementById('s1sum_temp').value);" class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a></div>
				  </div> -->
  
	              <div class="col-lg-6 col-xs-6">
	              <div class="small-box bg-red">
	              <div class="inner"><h3>Stage 2</h3><p> <strong><fmt:formatNumber type="number"  pattern="#,###.##" value="${jihv_total/1000000}" />M</strong></p>
	              <input type="hidden" id="s2sum_temp" value="${jihv_total}" />
	              </div> <div class="icon"><i class="fa fa-pie-chart"></i> </div>
	               <a href="#" onclick="s2Details();"  class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
	              </div></div>
	              
	              <div class="col-lg-6 col-xs-6">
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
                  <h3>Stage 5</h3><p id="s5sum"></p>
                  <input type="hidden" id="s5sum_temp" value="0" />
                  <input type="hidden" id="s5sumnoformat" value="0" />
                  </div> <div class="icon"><i class="fa fa-pie-chart"></i></div>
                  <a href="#" onclick="s5Details(document.getElementById('s5sum_temp').value);"  class="small-box-footer">More info <i class="fa fa-arrow-circle-right"></i></a>
                  </div>
			      </div>
				    
	   	     </div>
	   	     	 <div class="stage-details-graph" id="openModalBtn">
						<i class="fa fa-bar-chart fa-1x"></i>
				</div>
         </div>
    <div id="bb1-meter" class="tab-pane fade  in active" >
    <div class="box-header with-border" style="margin-top: -10px;"> 
    <h3 class="box-title" style="color:#0065b3;" ><b><u>Target Vs Actual  Achieved  %  for <strong style="color:#dc3912;">${syrtemp}</strong> - (YTD)</u></b></h3>
      </div>
    <div class="row" > 			
	   	
	   			<div class="row">
	   			 <div class="col-lg-1 col-xs-0" ></div>
	   			 
	   			 <div class="col-lg-5 col-xs-6  sep" ><div id="guage_test_booking"></div> </div>
	   		
       	          <div class="col-lg-5 col-xs-6"> <div id="guage_test_billing"></div>
		          </div><div class="col-lg-1 col-xs-0" ></div>
		          </div>
     </div>
       </div>
     </div>
     
      </div>
        </section>

        
         <!-- BILLING CHART -->
          <div class="box box-success" style="margin-bottom: 8px;">
        
            <div class="box-body">
                <div id="prf_summ_billing_ytd" style="height:230px;margin-top:-10px;"></div>  
                <br/>
               <div class="overlay">
				<a href="#" data-toggle="modal" data-target="#billing_moreinfo_modal">More info
				 <i class="fa fa-arrow-circle-right"></i></a> </div> 
             
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.billing box -->
        	<!-- Forecast  -->
        <div class="box box-success" style="margin-bottom: 8px;">       
          <div class="box-body">
            <div class="box-header with-border">
              <h3 class="box-title" style="text-align:center">Monthly Billing Forecast</br> (Stg3 Invoice Date,Stg4 Delivery Date dfgdfg)</h3>

             <!--  <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
              </div> -->
            </div>
            <!-- /.box-header -->
            <div class="box-body">
            
            <div class="pull-right" style="padding-left:10px"><button class="btn btn-xs btn-primary" onClick="viewForecaststg4Detailsreport();"><i class="fa fa fa-external-link"> </i> Stage4 Detail</button></div>
            <div class="pull-right"><button class="btn btn-xs btn-primary" onClick="viewForecaststg3Detailsreport();"><i class="fa fa fa-external-link"> </i> Stage3 Detail</button></div>           
             <div>
                <table id="fcast_table" class="table table-bordered table-striped small">
                  <thead>
                  <tr>
                    <th width="10%">Month</th>  <th width="20%">Forecast Stage-3</th> <th width="20%">Forecast Stage-4</th> 
                  </tr>
                  </thead>
                  <tbody>
                <c:if test="${!empty FSSDDWV or FSSDDWV ne null}">
               <c:forEach var="forecastSummary" items="${FSSDDWV}">
				<tr>
				<td>${forecastSummary.monthYear}</td>
				<td align="right">
				<fmt:formatNumber type='number'  pattern="#,###" value='${forecastSummary.fcStg3}'/>
				</td>
				<td align="right">
				<fmt:formatNumber type='number'  pattern="#,###" value='${forecastSummary.value}'/>
				</td>
				</tr>
               </c:forEach>
               </c:if>
                  </tbody>
                  <tfoot align="right">
		          <tr><th style="text-align:right;color:blue;">Total:</th><th style="text-align:right;"></th><th style="text-align:right;"></th></tr>
	              </tfoot>
                </table>
               </div>
            </div>
          </div>       
        </div> 
        <!-- /Forecast -->
        
        

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
                  <tr>
                    
                    <th>Division</th>
                    <th>Jan</th> <th>Feb</th> <th>Mar</th> <th>Apr</th> <th>May</th>  <th>Jun</th> <th>Jul</th>
					<th>Aug</th> <th>Sep</th> <th>Oct</th> <th>Nov</th> <th>Dec</th>  <th>Total</th>
                  </tr>
                  </thead>
                  <tbody>
              <c:if test="${!empty YTM_BLNG_AD or YTM_BLNG_AD ne null}">
               <c:forEach var="subdivnBlng" items="${YTM_BLNG_AD}">
                <c:set var="bkng_count" value="${bkng_count + 1}" scope="page" />
				<tr>
				<td>${subdivnBlng.division}</td>
				<td align="right">
					<c:choose>
				<c:when test="${!empty subdivnBlng.jan or subdivnBlng.jan ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBlng.jan}'/>
				</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				
				</td>
				<td align="right">
				<c:choose>
				<c:when test="${!empty subdivnBlng.feb or subdivnBlng.feb ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBlng.feb}'/>
				</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				 </td>
				<td align="right"> 
				<c:choose>
				<c:when test="${!empty subdivnBlng.mar or subdivnBlng.mar ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBlng.mar}'/>
				</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>
				<td align="right">
				<c:choose>
				<c:when test="${!empty subdivnBlng.apr or subdivnBlng.apr ne null}"> 
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBlng.apr}'/>
				</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>
				<td align="right"> 
				<c:choose>
				<c:when test="${!empty subdivnBlng.may or subdivnBlng.may ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBlng.may}'/>
					</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>
				<td align="right"> 
				<c:choose>
				<c:when test="${!empty subdivnBlng.jun or subdivnBlng.jun  ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBlng.jun}'/>
					</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>
				<td align="right"> 
				<c:choose>
				<c:when test="${!empty subdivnBlng.jul or subdivnBlng.jul ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBlng.jul}'/>
					</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>	<td align="right"> 
				<c:choose>
				<c:when test="${!empty subdivnBlng.aug or subdivnBlng.aug ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBlng.aug}'/>
					</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>
					<td align="right"> 
				<c:choose>
				<c:when test="${!empty subdivnBlng.sep or subdivnBlng.sep ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBlng.sep}'/>
					</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>
					<td align="right"> 
				<c:choose>
				<c:when test="${!empty subdivnBlng.oct or subdivnBlng.oct ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBlng.oct}'/>
					</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>
					<td align="right"> 
				<c:choose>
				<c:when test="${!empty subdivnBlng.nov or subdivnBlng.nov ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBlng.nov}'/>
					</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>
				<td align="right"> 
				<c:choose>
				<c:when test="${!empty subdivnBlng.dec or subdivnBlng.dec ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBlng.dec}'/>
					</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>
				<td align="right"> 
				<c:choose>
				<c:when test="${!empty subdivnBlng.ytm_total or subdivnBlng.ytm_total ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBlng.ytm_total}'/>
					</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>
				</tr>
				</c:forEach>
               	</c:if>
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
             
                  </tbody>            
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
                  <tbody>
              <c:if test="${!empty YTM_BKNG_AD or YTM_BKNG_AD ne null}">
               <c:forEach var="subdivnBKng" items="${YTM_BKNG_AD}">
                <c:set var="bkng_count" value="${bkng_count + 1}" scope="page" />
				<tr>
				<td>${subdivnBKng.division}</td>
				<td align="right">
					<c:choose>
				<c:when test="${!empty subdivnBKng.jan or subdivnBKng.jan ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBKng.jan}'/>
				</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				
				</td>
				<td align="right">
				<c:choose>
				<c:when test="${!empty subdivnBKng.feb or subdivnBKng.feb ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBKng.feb}'/>
				</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				 </td>
				<td align="right"> 
				<c:choose>
				<c:when test="${!empty subdivnBKng.mar or subdivnBKng.mar ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBKng.mar}'/>
				</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>
				<td align="right">
				<c:choose>
				<c:when test="${!empty subdivnBKng.apr or subdivnBKng.apr ne null}"> 
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBKng.apr}'/>
				</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>
				<td align="right"> 
				<c:choose>
				<c:when test="${!empty subdivnBKng.may or subdivnBKng.may ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBKng.may}'/>
					</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>
				<td align="right"> 
				<c:choose>
				<c:when test="${!empty subdivnBKng.jun or subdivnBKng.jun  ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBKng.jun}'/>
					</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>
				<td align="right"> 
				<c:choose>
				<c:when test="${!empty subdivnBKng.jul or subdivnBKng.jul ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBKng.jul}'/>
					</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>	<td align="right"> 
				<c:choose>
				<c:when test="${!empty subdivnBKng.aug or subdivnBKng.aug ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBKng.aug}'/>
					</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>
					<td align="right"> 
				<c:choose>
				<c:when test="${!empty subdivnBKng.sep or subdivnBKng.sep ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBKng.sep}'/>
					</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>
					<td align="right"> 
				<c:choose>
				<c:when test="${!empty subdivnBKng.oct or subdivnBKng.oct ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBKng.oct}'/>
					</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>
					<td align="right"> 
				<c:choose>
				<c:when test="${!empty subdivnBKng.nov or subdivnBKng.nov ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBKng.nov}'/>
					</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>
				<td align="right"> 
				<c:choose>
				<c:when test="${!empty subdivnBKng.dec or subdivnBKng.dec ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBKng.dec}'/>
					</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>
				<td align="right"> 
				<c:choose>
				<c:when test="${!empty subdivnBKng.ytm_total or subdivnBKng.ytm_total ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${subdivnBKng.ytm_total}'/>
					</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>
				</tr>
				</c:forEach>
               	</c:if>
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
             
                  </tbody>            
                </table>
              
            </div>
            <!-- /.box-body -->
           
           
          </div>
          <!-- /.box -->
        </div>
        <div class="col-md-12 col-sm-12">
        <!-- TABLE: LATEST ORDERS -->
          <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">Week Wise Booking Of Sales Engineers For Year : <span id="bkmgDtlstime">${MNTH_TXT}/${CURR_YR}</span> </h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
              </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
           <%--  <div class="form-inline" style="padding-bottom:7px;"> 
             <select class="form-control form-control-sm" name="syear" id="syear" required>
             <option selected value="<%=iYear%>">Select Year</option>
              <%
                        // start year and end year in combo box to change year in calendar
                         for(int iy=iYear;iy>=2017;iy--)
                            {
                            
                             %>
                             <c:set var="syrtemp1" value="<%=iy%>" scope="page" />
                             <option value="<%=iy%>" ${syrtemp1  == selected_Year ? 'selected':''}> <%=iy%></option>
                            <%
                             
                        }
                        %>
             </select>
              <select class="form-control form-control-sm" name="smonth" id="smonth"  required>
                        <option selected value="Jan">Select Month</option>
  						<option  value="Jan">Jan</option>
  						<option  value="Feb">Feb</option>
  						<option  value="Mar">Mar</option>
  						<option  value="Apr">Apr</option>
  						<option  value="May">May</option>
  						<option  value="Jun">Jun</option>
  						<option  value="Jul">Jul</option>
  						<option  value="Aug">Aug</option>
  						<option  value="Sep">Sep</option>
  						<option  value="Oct">Oct</option>
  						<option  value="Nov">Nov</option>
  						<option value="Dec">Dec</option>
  			</select>
  			<input type="hidden" name="fjtco" value="frbwym" />
   			<button type="button" id="sf" class="btn btn-primary" onclick="showWeekWiseSEngBkngRprt();">View</button>
             </div> --%>
             <div id="preLoadtablehead">
                <table id="weeklybkngrprt_table" class="table table-bordered table-striped small">
                  <thead>
                  <tr>
                    <th>Sl.No.</th>  <th>Division</th> <th>SM Code</th>  <th>SM Name</th>  <th>Yrly Booking <br/>Target</th>
                    <th>YTD Actual <br/>Booking Amt</th>  <th>YTD Target <br/>Booking Amt</th> <th>Target % <br/>Achieved</th><th>Wkly Avg Target<br/> (52 Wks)</th>
                  </tr>
                  </thead>
                  <tbody>
                 <c:set var="bkng_count" value="0" scope="page" />
                 <c:if test="${!empty WWBFSE or WWBFSE ne null}">
               <c:forEach var="weekWiseBkngRprt" items="${WWBFSE}">
                <c:set var="bkng_count" value="${bkng_count + 1}" scope="page" />
				<tr>
				<td>${bkng_count}</td>
				<td>${weekWiseBkngRprt.division}</td>
				<td> ${weekWiseBkngRprt.sales_code} </td>
				<td>${weekWiseBkngRprt.sales_eng_name}</td>
				<td align="right">
					<c:choose>
				<c:when test="${!empty weekWiseBkngRprt.yrly_bkng_tgt or weekWiseBkngRprt.yrly_bkng_tgt ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${weekWiseBkngRprt.yrly_bkng_tgt}'/>
				</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				
				</td>
				<td align="right">
				<c:choose>
				<c:when test="${!empty weekWiseBkngRprt.ytd_actual_bkng or weekWiseBkngRprt.ytd_actual_bkng ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${weekWiseBkngRprt.ytd_actual_bkng}'/>
				</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				 </td>
				<td align="right"> 
				<c:choose>
				<c:when test="${!empty weekWiseBkngRprt.ytd_target_bkng or weekWiseBkngRprt.ytd_target_bkng ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${weekWiseBkngRprt.ytd_target_bkng}'/>
				</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>
				<td align="right">
				<c:choose>
				<c:when test="${!empty weekWiseBkngRprt.target_perc_achvd or weekWiseBkngRprt.target_perc_achvd ne null}"> 
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${weekWiseBkngRprt.target_perc_achvd}'/>
				</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>
				<td align="right"> 
				<c:choose>
				<c:when test="${!empty weekWiseBkngRprt.weekly_avg_target or weekWiseBkngRprt.weekly_avg_target ne null}">
				<fmt:formatNumber type='number'  pattern = '#,###.#' value='${weekWiseBkngRprt.weekly_avg_target}'/>
					</c:when><c:otherwise>0</c:otherwise>
				</c:choose>
				</td>
				</tr>
				</c:forEach>
               	</c:if>
               
             
                  </tbody>
                  <tfoot align="right">
		          <tr><th colspan="4" style="text-align:right;color:blue;">Total:</th><th></th><th></th><th></th><th></th><th></th></tr>
	              </tfoot>
                </table>
               </div>
            </div>
            <!-- /.box-body -->
           
           
          </div>
          <!-- /.box -->
        </div>
       	  <!-- top ten customers info  --> 
     <!--   <div class="col-md-12 col-sm-12">          
          <div class="box box-success" style="margin-bottom: 8px;">       
          <div class="box-body">
            <div class="box-header with-border">
              <h3 class="box-title" style="text-align:center">Top 10 Customers Info</h3>
            </div>          
            <div class="box-body">    
             <div>
                <table id="fcast_table" class="table table-bordered table-striped small">
                  <thead>
                  <tr>
                    <th width="20%">Customer ID</th>  <th width="20%">Customer Name</th> <th  width="10%" align="center">Value</th> <th align="center" width="5%">More Info</th> 
                  </tr>
                  </thead>
                  <tbody>
                <c:if test="${!empty TTCD or TTCD ne null}">
               <c:forEach var="topTenCustDetails" items="${TTCD}">
				<tr>
				<td>${topTenCustDetails.fcStg3}</td>
				<td>${topTenCustDetails.fcStg3}</td>
				<td align="right">
				<fmt:formatNumber type='number'  pattern="#,###" value='${topTenCustDetails.value}'/>
				</td>
				<td>
					 <div class="pull-right"><button class="btn btn-xs btn-primary" onClick="viewCustomerDetailsreport('${topTenCustDetails.fcStg3}');"><i class="fa fa fa-external-link"> </i> Custumer Detail</button></div>
				</td>
				</tr>
               </c:forEach>
               </c:if>
                  </tbody>
                </table>
               </div>
            </div>
          </div>       
        </div>           
        </div> -->
      <!-- End top ten customers info  --> 
        <!-- Forecast  -->
      <!--  <div class="col-md-3 col-sm-12">       
          <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">Expected Monthly Billing Forecast (Stg4 Delivery Date)</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
              </div>
            </div>          
            <div class="box-body">
            <div class="pull-right"><button class="btn btn-xs btn-primary" onClick="viewForecastDetailsreport();"><i class="fa fa fa-external-link"> </i> Detail Report</button></div>
             <div>
                <table id="fcast_table" class="table table-bordered table-striped small">
                  <thead>
                  <tr>
                    <th>Month</th>  <th>FC Stg-3</th> <th>FC Stg-4</th> 
                  </tr>
                  </thead>
                  <tbody>
                <c:if test="${!empty FSSDDWV or FSSDDWV ne null}">
               <c:forEach var="forecastSummary" items="${FSSDDWV}">
				<tr>
				<td>${forecastSummary.monthYear}</td>
				<td align="right">
				<fmt:formatNumber type='number'  pattern="#,###" value='${forecastSummary.fcStg3}'/>
				</td>
				<td align="right">
				<fmt:formatNumber type='number'  pattern="#,###" value='${forecastSummary.value}'/>
				</td>
				</tr>
               </c:forEach>
               </c:if>
                  </tbody>
                  <tfoot align="right">
		          <tr><th style="text-align:right;color:blue;">Total:</th><th style="text-align:right;"></th></tr>
	              </tfoot>
                </table>
               </div>
            </div>
          </div>
        </div> -->
        <!-- /Forecast -->
        
        
      </div>
      <!-- /.row -->
	   
	   
	   
	  
	
        <div class="modal fade" id="jihv_moreinfo_modal" role="dialog">
							<div class="modal-dialog modal-lg">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="modal-title">Job In Hand Volume Details   </h4>
									</div>

									<div class="modal-body">
										<div class="row">
											<table id="jihv_modal_table">
												<thead> <tr> <th>Aging</th> <th>Value</th></tr> </thead>
												<tbody>  
												<c:forEach var="JOBV1" items="${JIHV}"> 
												 <tr>  <td>${JOBV1.duration}</td>  <td>${JOBV1.amount}</td>  </tr>
												
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
										<h4 class="modal-title">JIH (All) Vs LOST Details </h4>
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
										<h4 class="modal-title">Booking Details of ${DIVDEFTITL}</h4>
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
										<h4 class="modal-title">Billing Details of ${DIVDEFTITL} </h4>
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
        <div class="modal fade" id="jihv-excl-modal" role="dialog" >
					
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
        <div class="modal fade" id="billing-excl-modal" role="dialog" >
					
					        <div class="modal-dialog" style="width:97%;">
					     		<!-- Modal content-->
							      	<div class="modal-content">
								        	<div class="modal-header">
								         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
								          		<h4 class="modal-title"> </h4>
								        	</div>
								        	<div class="modal-body small"> <div id="table_div"></div></div>
									        <div class="modal-footer">
									          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									        </div>
								     </div>
								     
								     
						   	 </div>   	 		   	 
		 			</div>
		   <div class="modal fade" id="custdetails-excl-modal" role="dialog" >
					
					        <div class="modal-dialog" style="width:97%;">
					     		<!-- Modal content-->
							      	<div class="modal-content">
								        	<div class="modal-header">
								        	<span id="ctitle"></span>
								         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
								          		<h4 class="modal-title"> </h4>
								        	</div>
								        	<div class="modal-body small"> <div id="table_div"></div></div>
									        <div class="modal-footer">
									          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									        </div>
								     </div>
								     
								     
						   	 </div>   	 		   	 
		 			</div>
        <div class="modal fade" id="booking-excl-modal" role="dialog" >
					
					        <div class="modal-dialog" style="width:97%;">
					     		<!-- Modal content-->
							      	<div class="modal-content">
								        	<div class="modal-header">
								         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
								          		<h4 class="modal-title"> </h4>
								        	</div>
								        	<div class="modal-body small"> <div id="table_div"></div></div>
									        <div class="modal-footer">
									          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									        </div>
								     </div>
								     
								     
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

                 		<div class="modal fade" id="fcastDetails-scnd-layer">
							<div class="modal-dialog" style="width: 80%;">
								<div class="modal-content">
									<div class="modal-header">
									<span id="fctitle"></span>
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title"></h4>
									</div>
									<div class="modal-body small">
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
					<div class="modal fade" id="jihLostModalGraph" role="dialog" >				
					        <div class="modal-dialog" style="width:max-content !important;">
					     		<!-- Modal content-->
							      	<div class="modal-content">
								        	<div class="modal-header">
								         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
								          		<h4 class="modal-title">${DIVDEFTITL} - JIH Qtn. Lost Analysis </h4>
								        	</div>
								        	<div class="modal-body small"></div>
									        <div class="modal-footer">
									          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
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
	  <div class="modal fade" id="stageDetails34" role="dialog" >
					
					        <div class="modal-dialog" style="width:97%;">
					     		<!-- Modal content-->
							      	<div class="modal-content">
								        	<div class="modal-header">
								         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
								          		<h4 class="modal-title">Stage Details Details </h4>
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
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
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

							 
	<div id="laoding" class="loader" ><img src="resources/images/wait.gif"></div>
       
       
       
          
     
      <!-- /.row -->

    
    <!-- /.content -->
  </div>
	
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <div class="pull-right hidden-xs">
      <b>Version</b> 3.0.0
    </div>
    <strong>Copyright &copy; 1988-${CURR_YR} <a href="http://www.faisaljassim.ae/">Faisal Jassim Group</a>.</strong> All rights
    reserved.
  </footer>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Create the tabs -->
    <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
      <li><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
      <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
    </ul>
    <!-- Tab panes -->
    
  </aside>
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
/*Start*/
function viewForecaststg4Detailsreport(){
	 $('#laoding').show();
	 var ttl="<b>Monthly Billing Forecast (Stg4 Delivery Date) Detail Report of  Division ${DIVDEFTITL}</b>";
	 var exclTtl="Monthly Billing Forecast (Stg4 Delivery Date) Detail Report of  Division ${DIVDEFTITL}";
	var count = 0;
	$.ajax({ 
		type: 'POST',
		url: 'sipMainDivision',  
		data: {fjtco: "fcastDetls",d1:'${DFLTDMCODE}'}, 
		dataType: "json",
	   	success: function(data) {  	
	   	 $('#laoding').hide();
	   		 var output="<table id='fcast_details_table' class='table table-bordered table-striped small'> "+
	   		            "<thead><tr><th>Sl.No.</th>  <th>Txn. Code</th> <th>Number</th> <th>Date</th><th>S.Eng.</th>"+
                      "<th>Division</th><th>Project</th><th>Consultant</th>"+
                      "<th>Payment Term</th><th>Customer</th><th>Balance Value</th><th>Delivery Date</th>"+
	   	                "</tr></thead><tbody>";  	          
	          for (var i in data) {
	        	  count=count+1;
	   	 output+="<tr><td>"+count+"</td><td>" + $.trim(data[i].d1 )+ "</td>"+"<td>" + $.trim(data[i].d2 )+ "</td><td>" + $.trim(data[i].d3.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+ "<td>" + $.trim(data[i].d4 )+ " - "+$.trim(data[i].d5)+"</td>"+
	   	"<td>" + $.trim(data[i].d6 )+ "</td>"+"<td>" + $.trim(data[i].d7 )+ "</td><td>" + $.trim(data[i].d8 )+ "</td>"+ "<td>" + $.trim(data[i].d9 )+ "</td>"+
	   	"<td>" + $.trim(data[i].d10 )+ "</td><td>" + $.trim(data[i].d11 )+ "</td>"+ "<td>" + $.trim(data[i].d12.substring(0, 10)).split("-").reverse().join("/") + "</td></tr>"; 
	   	 } 
	          output+="</tbody></table>";
	             $("#fcastDetails-scnd-layer .modal-header #fctitle").html(ttl);
	    		 $("#fcastDetails-scnd-layer .modal-body").html(output);
	    		 $("#fcastDetails-scnd-layer").modal("show");	
	   	 
	   	 $('#fcast_details_table').DataTable( {
		        dom: 'Bfrtip',
		        "columnDefs" : [{"targets":3, "type":"date-eu"}],
		        "paging":   true,  "ordering": false,  "info":     false,  "searching": false,
		        buttons: [
		            {
		                extend: 'excelHtml5',
		                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 1em;">Export</i>',
		                filename: exclTtl,
		                title: exclTtl,
		                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
		              }]

		      } );  
	   	 
	   	
	   	 
	   		},error:function(data,status,er) {   $('#laoding').hide();alert("please click again");}
	   		
	});
	
	
}
function viewForecaststg3Detailsreport(){
	 $('#laoding').show();
	 var ttl="<b>Monthly Billing Forecast (Stg3 Invoice Date) Detail Report of  Division ${DIVDEFTITL}</b>";
	 var exclTtl="Monthly Billing Forecast (Stg3 Invoice Date) Detail Report of  Division ${DIVDEFTITL}";
	var count = 0;
	$.ajax({ 
		type: 'POST',
		url: 'sipMainDivision',  
		data: {fjtco: "fcastStg3Detls",d1:'${DFLTDMCODE}'}, 
		dataType: "json",
	   	success: function(data) {  	
	   	 $('#laoding').hide();
	   		 var output="<table id='fcaststg3_details_table' class='table table-bordered table-striped small'> "+
	   		            "<thead><tr><th>Sl.No.</th>  <th>Txn. Code</th> <th>Number</th> <th>Date</th><th>S.Eng.</th>"+
                     "<th>Division</th><th>Project</th><th>Consultant</th>"+
                     "<th>Payment Term</th><th>Customer</th><th>Value</th><th>Invoice Date</th>"+
	   	                "</tr></thead><tbody>";  	          
	          for (var i in data) {
	        	  count=count+1;
	   	 output+="<tr><td>"+count+"</td><td>" + $.trim(data[i].d1 )+ "</td>"+"<td>" + $.trim(data[i].d2 )+ "</td><td>" + $.trim(data[i].d3.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+ "<td>" + $.trim(data[i].d4 )+ " - "+$.trim(data[i].d5)+"</td>"+
	   	"<td>" + $.trim(data[i].d6 )+ "</td>"+"<td>" + $.trim(data[i].d7 )+ "</td><td>" + $.trim(data[i].d8 )+ "</td>"+ "<td>" + $.trim(data[i].d9 )+ "</td>"+
	   	"<td>" + $.trim(data[i].d10 )+ "</td><td>" + $.trim(data[i].d11 )+ "</td>"+ "<td>" + $.trim(data[i].d12.substring(0, 10)).split("-").reverse().join("/") + "</td></tr>"; 
	   	 } 
	          output+="</tbody></table>";
	             $("#fcastDetails-scnd-layer .modal-header #fctitle").html(ttl);
	    		 $("#fcastDetails-scnd-layer .modal-body").html(output);
	    		 $("#fcastDetails-scnd-layer").modal("show");	
	   	 
	   	 $('#fcaststg3_details_table').DataTable( {
		        dom: 'Bfrtip',
		        "columnDefs" : [{"targets":3, "type":"date-eu"}],
		        "paging":   true,  "ordering": false,  "info":     false,  "searching": false,
		        buttons: [
		            {
		                extend: 'excelHtml5',
		                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 1em;">Export</i>',
		                filename: exclTtl,
		                title: exclTtl,
		                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
		              }]

		      } );  
	   	 
	   	
	   	 
	   		},error:function(data,status,er) {   $('#laoding').hide();alert("please click again");}
	   		
	});
	
	
}


function showPdcHand(value) { 
	 // alert(value);
	 var custVal=$.trim(value);
	$('#laoding-pdc').show();

	var ttl="<b>PDC On Hand Details Of Customer  :"+custVal+" </b>";
	var exclTtl="PDC On Hand Details Of Customer  :"+custVal+" ";
	 $("#pdc_hand_4_main .modal-title").html(ttl); 
		 $.ajax({ type: 'POST', url: 'sipMainDivision',data: {fjtco: "wccsltdhop", cchop:custVal},dataType: "json",success: function(data) {
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
		                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 1em;">Export</i>',
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
		 $.ajax({ type: 'POST', url: 'sipMainDivision',data: {fjtco: "wccsltdrep", ccerp:custVal},dataType: "json",success: function(data) {
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
		                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 1em;">Export</i>',
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
function showWeekWiseSEngBkngRprt(){
	//preLoader();
     var countBkng=0;
     var undefndValue_1="-";var undefndValue_2="-";var undefndValue_3="-";var undefndValue_4="-";var undefndValue_5="-";
	
	var iSlctMonth = $('#smonth').find(":selected").val();
	var iSlctYear = $('#syear').find(":selected").val();
	var refreshing="<span class='text-danger' style='font-size:15px;font-weight:bold;'>Loading Week Wise Booking Report  Details Of Sales Engineers For Year : "+iSlctMonth+"/"+iSlctYear+". Please wait... <i class='fa fa-refresh fa-spin'></i></span>"; 
	 $("#bkmgDtlstime").html(iSlctMonth+"/"+iSlctYear);
	 $("#preLoadtablehead").html(refreshing);
		
	//alert(iSlctMonth);
	//alert(iSlctYear);
	
	    $.ajax({ type: 'POST',url: 'sipMainDivision',  data: {fjtco: "frbwym",smonth:iSlctMonth,syear:iSlctYear,d2:'${DFLTDMCODE}'}, dataType: "json",
	   	 success: function(data) {
	   		
	   		
	   		
	   		 var output="<table id='weeklybkngrprt_table' class='table table-bordered table-striped small'> "+
	   		            "<thead><tr> <th>Sl.No.</th> <th>Division</th> <th>SM Code</th><th>SM Name</th>"+
                        "<th>Yrly Booking <br/>Target</th><th>YTD Actual <br/>Booking Amt</th><th>YTD Target <br/>Booking Amt</th>"+
                        "<th>Target % <br/>Achieved</th><th>Wkly Avg Target <br/>(52 wks)</th>"+
	   	                "</tr></thead><tbody>";  
	          
	          for (var i in data) {
	        	  countBkng=countBkng+1;
	        	  if (typeof data[i].yrly_bkng_tgt !== 'undefined'){undefndValue_1=data[i].yrly_bkng_tgt.replace(/\B(?=(\d{3})+(?!\d))/g, ",");}else{undefndValue_1="0";}
	        	  if (typeof data[i].ytd_actual_bkng !== 'undefined'){undefndValue_2=data[i].ytd_actual_bkng.replace(/\B(?=(\d{3})+(?!\d))/g, ",");}else{undefndValue_2="0";}
	        	  if (typeof data[i].ytd_target_bkng !== 'undefined'){undefndValue_3=data[i].ytd_target_bkng.replace(/\B(?=(\d{3})+(?!\d))/g, ",");}else{undefndValue_3="0";}
	        	  if (typeof data[i].target_perc_achvd !== 'undefined'){undefndValue_4=data[i].target_perc_achvd.replace(/\B(?=(\d{3})+(?!\d))/g, ",");}else{undefndValue_4="0";}
	        	  if (typeof data[i].weekly_avg_target !== 'undefined'){undefndValue_5=data[i].weekly_avg_target.replace(/\B(?=(\d{3})+(?!\d))/g, ",");}else{undefndValue_5="0";}
	   	 output+="<tr><td>"+countBkng+"</td><td>" + data[i].division + "</td>"+"<td>" + data[i].sales_code + "</td><td>" + data[i].sales_eng_name+ "</td>"+ "<td>" + undefndValue_1 + "</td>"+
	   	"<td>" + undefndValue_2 + "</td>"+"<td>" + undefndValue_3 + "</td><td>" + undefndValue_4 + "</td>"+ "<td>" + undefndValue_5 + "</td>"+
	   	 "</tr>"; 
	   	 } 
	          output+="<tfoot align='right'>"+
	          "<tr><th colspan='4' style='text-align:right;color:blue;'>Total:</th><th></th><th></th><th></th><th></th><th></th></tr>"+
              "</tfoot>"+
              "</tbody></table>";

	   	 $("#preLoadtablehead").html(output);	
	   	 
	   	 $('#weeklybkngrprt_table').DataTable( {
		        dom: 'Bfrtip', "paging":   false,  "ordering": false,  "info":     false,  "searching": false,
		        buttons: [
		            {
		                extend: 'excelHtml5',
		                text:      '<i class="fa fa-file-excel-o" style="color: red; font-size: 1em;">Export</i>',
		                filename: 'Week Wise Booking Report Of Sales Engineers For Year ('+iSlctMonth+'/'+iSlctYear+')  ',
		                title: 'Week Wise Booking Report Of Sales Engineers For Year ('+iSlctMonth+'/'+iSlctYear+')  ',
		                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
		              }],
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
	                .column( 4 )
	                .data()
	                .reduce( function (a, b) {
	                    return intVal(a) + intVal(b);
	                }, 0 );
	            
	            var total2 = api
               .column( 5 )
               .data()
               .reduce( function (a, b) {
                   return intVal(a) + intVal(b);
               }, 0 );
	            
	            var total3 = api
               .column( 6 )
               .data()
               .reduce( function (a, b) {
                   return intVal(a) + intVal(b);
               }, 0 );
	            
	            var total4 = api
               .column( 7 )
               .data()
               .reduce( function (a, b) {
                   return intVal(a) + intVal(b);
               }, 0 );
           
           var total5 = api
           .column( 8 )
           .data()
           .reduce( function (a, b) {
               return intVal(a) + intVal(b);
           }, 0 );
           
        
	        
	            // Update footer
	                     $( api.column(4).footer()).html(formatNumber(total1));
	                     $( api.column(5).footer()).html(formatNumber(total2));
	                     $( api.column(6).footer()).html(formatNumber(total3));
	                     $( api.column(7).footer()).html(formatNumber((total4/ (countBkng * 100) * 100).toFixed(2)));
	            		 $( api.column(8).footer()).html(formatNumber(total5));
	            
	            
	        }
  
		      } );  
	   	
	   		},error:function(data,status,er) {  alert("please click again");}});
	
}

/*Start*/
function show2ndLayerOutRcvbles(dmCode,agingVal,aging_header) { 
	//alert(dmCode);
	 $('#laoding-pdc').hide();$('#laoding-rcvbl').hide();
 $('#laoding').show();

var ttl="<b>Outstanding Recievables > 100AED Details of Main Division : ${DIVDEFTITL} </b><strong style='color:blue;'> </strong> for "+aging_header+" <strong style='color:blue;'>  </strong> ";
var exclTtl="Outstanding Recievables > 100AED  Details of Main Division : ${DIVDEFTITL} for "+aging_header+"";
$("#rcvbles_aging_modal-main .modal-title").html(ttl); 
	 $.ajax({ type: 'POST', url: 'sipMainDivision',data: {fjtco: "slbvcr", aging:agingVal,edoCmd:dmCode},dataType: "json",success: function(data) {
		 $('#laoding').hide();
		 var output="<table id='rcvbles_main' class='table table-bordered small'><thead><tr><th>#</th><th>Invoice Number</th><th>Invoice Date</th><th>Customer Code</th><th>Customer Name</th><th>Project Name</th><th>Consultant</th><th>Sales Eng: Name</th><th>Value</th>"+
        "</tr></thead><tbody>";
       var j=0; for (var i in data) { j=j+1;
       output+="<tr><td>"+j+"</td><td>" + data[i].d1 + "</td>"+"<td>" + $.trim(data[i].d2.substring(0, 10)).split("-").reverse().join("/") + "</td>"+
       "<td><a href='#' id='"+data[i].d3+"'  onclick='showOustRcvblThirdLyrOwnAccnt(this.id);'  data-backdrop='static' data-keyboard='false' class='btn btn-primary btn-xs' data-toggle='modal' data-target='#modal-default1'><span class='fa fa-external-link' ></span> " + data[i].d3 + "</a></td>"+
       "<td>" + data[i].d4 + "</td><td>" + data[i].d5 + "</td><td>" + data[i].d6 + "</td><td>" + data[i].d8+ "</td><td align='right'>" + formatNumber(data[i].d7)+ "</td></tr>"; 
        } 
        output+="</tbody></table>";
        $("#rcvbles_aging_modal-main .modal-body").html(output);
        $("#rcvbles_aging_modal-main").modal("show");

	 
	    $('#rcvbles_main').DataTable( {
	        dom: 'Bfrtip', 
	        "columnDefs" : [{"targets": 2, "type":"date-eu"}],
	        "order": [[ 8, "desc" ]],
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 1em;">Export</i>',
	                filename: exclTtl,
	                title: exclTtl,
	                messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	          
	           
	        ]
	    } );
	},error:function(data,status,er) {$('#laoding').hide();  alert("please click again");}});

}
/*End*/
 /*START 3rd lyr jih lost details */
 function getJihLostAnalysisDtls(lostType){
		$('#laoding-jihqlst').show(); 
		var type = $.trim(lostType); 
	var ttl="<b>JIH Qtn. Lost detail of  : "+lostType+" / ${DIVDEFTITL}</b>";
	var exclTtl="JIH Qtn. Lost detail of  :"+lostType+" / ${DIVDEFTITL}"; 
	$("#jih_lost_dtls_modal .modal-title").html(ttl);
		$.ajax({ type: 'POST',url: 'sipMainDivision',  data: {fjtco: "jihlstGrphDtls", lstyp:type, dmCode: '${DFLTDMCODE}'},  dataType: "json",
			 success: function(data) {
				 $('#laoding-jihqlst').hide();  		 
				 var output="<table id='jihLostDtls' class='table table-bordered small'><thead><tr>"+
				 "<th>Sl. No.</th><th>S.Eng.</th><th>Qtn. Date</th><th>Qtn. Code</th> <th>Qtn. No.</th> <th>Customer Code</th><th>Customer Name</th> <th>Project Name</th><th>Consultant</th> <th>Qtn. Amount</th><th>Qtn.Status</th><th>Remarks</th>"+
			 "</tr></thead><tbody>";
			
			 var j=0; for (var i in data) { j=j+1;
			 
			 output+="<tr><td>"+j+"</td><td>" + data[i].slesCode + "</td>"+"<td>" + $.trim(data[i].qtnDate.substring(0, 10)).split("-").reverse().join("/")+
			 "<td>" + data[i].qtnCode + "</td>"+"</td><td>" + data[i].qtnNo + "</td><td>" +data[i].custCode+ "</td>"+
			 "<td>" +  data[i].custName + "</td><td>" +  data[i].projectName + "</td><td>" +  data[i].consultant + "</td><td align='right'>" +  formatNumber(data[i].qtnAMount) + "</td>"+
			 "<td>" +  data[i].qtnStatus + "</td>"+"<td>" +  data[i].remarks + "</td>"+"</tr>"; 
			 } 
			 output+="</tbody></table>";
			 
			  
			 $("#jih_lost_dtls_modal .modal-body").html(output);
			 $("#jih_lost_dtls_modal").modal("show");	
			 
				    $('#jihLostDtls').DataTable( {
				        dom: 'Bfrtip',  
				        "columnDefs" : [{"targets": 2, "type":"date-eu"}],
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
				},error:function(data,status,er) {$('#laoding-jihqlst').hide();  alert("please click again");}});
		
		
	}

	 /*END 3rd layr jih lost details */
 /* On account outstandng rcvbls script start */
     function showOustRcvblThirdLyrOwnAccnt(data){
    	 $('#laoding-rcvbl').show();
    	//alert(data);
    	var cust_code = $.trim(data);
    	$("#onaccnt-third-layer .modal-body #ccrpdc").val(cust_code)
         
	 var ttl="<b>Outstanding Details for Customer :"+cust_code+"</b>";
	 var exclTtl="Outstanding Details for Customer :"+cust_code+"";
	 var ttlSummary="";
	 $("#onaccnt-third-layer .modal-title").html(ttl);
    	$.ajax({ type: 'POST',url: 'sipMainDivision',  data: {fjtco: "3lyrtnccano", oacc:cust_code,divName: '${DIVDEFTITL}'},  dataType: "json",
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
    			        "columnDefs" : [{"targets":3, "type":"date-eu"}],
    			        "order": [[ 11, "desc" ]],
    			        buttons: [
    			            {
    			                extend: 'excelHtml5',
    			                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 1em;">Export</i>',
    			                filename: exclTtl,
    			                title: exclTtl,
    			                messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'
    			                
    			                
    			            }
    			          
    			           
    			        ]
    			    } );
    			},error:function(data,status,er) {$('#laoding').hide();  alert("please click again");}});
    	
    	
    }
   
     function viewCustomerDetailsreport(custmerID){
    	 $('#laoding').show();
    	 var ttl="<b>Customer Detail Report of  Division ${DIVDEFTITL}</b>";
    	 var exclTtl="Customer Detail Report of  Division ${DIVDEFTITL}";
    	var count = 0;
    	$.ajax({ 
    		type: 'POST',
    		url: 'sipMainDivision',  
    		data: {fjtco: "custmerDetails",d1:'${DFLTDMCODE}',d2:custmerID}, 
    		dataType: "json",
    	   	success: function(data) {  	
		  			$('#laoding').hide();
 		  			var output="<table id='blng_main' class='table table-bordered small'><thead><tr>"+
 		  			"<th>#</th><th>Company</th><th>Week</th><th>Document Id</th><th>Document Date</th>"+
		  			 "<th>Sales Egr: Code</th><th>Sales Egr: Name</th><th>Party Name</th><th>Contact</th><th>Telephone</th>"+
				      " <th>Project Name</th><th>Product</th>  <th>Zone</th><th>Currency</th><th>Amount (AED)</th><th>Division</th></tr></thead><tbody>";
					  var j=0;
 				      for (var i in data)
 					 {
 				    	  j=j+1;

 				    	 output+="<tr><td>"+j+"</td><td>" +  $.trim(data[i].d1) + "</td>"+
 	 					 "<td>" +  $.trim(data[i].d2) + "</td><td>" +  $.trim(data[i].d3)+ "</td>"+
 	 					 "<td>" +  $.trim(data[i].d4.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+
 	 					 "<td>" +  $.trim(data[i].d5) + "</td><td>" +  $.trim(data[i].d6) + "</td><td>" +  $.trim(data[i].d7) + "</td>"+
 	 					"<td>" +  $.trim(data[i].d8) + "</td><td>" +  $.trim(data[i].d9) + "</td>"+
 	 					 "<td>" +  $.trim(data[i].d10) + "</td><td>" +  $.trim(data[i].d11) + "</td>"+
 	 					 "<td>" +  $.trim(data[i].d12) + "</td><td>" +  $.trim(data[i].d13) + "</td><td>" +  $.trim(data[i].d14) + "</td>"+
 	 					 "<td>" +  $.trim(data[i].d15) + "</td>"+
 	 					 "</tr>";
 					 }
 				      
 					 output+="</tbody></table>";
 					$("#custdetails-excl-modal .modal-header #ctitle").html(ttl);
 		  			$("#custdetails-excl-modal .modal-body").html(output);
 		  			$("#custdetails-excl-modal ").modal("show");
 		  		
 		  		 $('#blng_main').DataTable( {
 			        dom: 'Bfrtip',  
 			       "columnDefs" : [{"targets": 4, "type":"date-eu"}],
 			        buttons: [
 			            {
 			                extend: 'excelHtml5',
 			                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 1em;">Exportgh</i>',
 			                filename: exclTtl,
 			                title: exclTtl,
 			                messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'
 			                
 			                
 			            }
 			          
 			           
 			        ]
 			    } );
 		  			
 		  },
 		  error:function(data,status,er) {
 			 
 		    alert("please click again");
 		   }
 		 });
         
      
         }
       
    
   /* On account outstandng rcvbls END */
$(document).ready(function() {
	  var jihvTtl="Job In Hand Volume Details  of Division  ${DIVDEFTITL} ";
	  var bookingTtl="Booking Details  of Division  ${DIVDEFTITL}";
	  var billingTtl="Billing Details  of  Division ${DIVDEFTITL}";
	  var fcastTtl="Summary for Forecast from sales order delivery date of  Division ${DIVDEFTITL}";
	  var lostTtl="JIH (All) Vs Lost Details  of Division  ${DIVDEFTITL} ";
	  
	  $('#fcast_table').DataTable( {
	        dom: 'Bfrtip',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 1em;">Export</i>',
	                filename: fcastTtl,
	                title: fcastTtl,
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
            var total1 = api
                .column( 2 )
                .data()
                .reduce( function (a, b) {
                    return intVal(a) + intVal(b);
                }, 0 );
            
            // Update footer
              $( api.column(2).footer()).html(formatNumber(total1));
            
              // Total over all pages
              var total2 = api
                  .column( 1 )
                  .data()
                  .reduce( function (a, b) {
                      return intVal(a) + intVal(b);
                  }, 0 );
              
              // Update footer
               $( api.column(1).footer()).html(formatNumber(total2));                      
                               
                }
        } );  
 	   
	   $('#jihv_modal_table').DataTable( {
	        dom: 'Bfrtip',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 1em;">Export</i>',
	                filename: jihvTtl,
	                title: jihvTtl,
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
	                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 1em;">Export</i>',
	                filename: bookingTtl,
	                title: bookingTtl,
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
	   $('#billing_modal_table').DataTable( {
	        dom: 'Bfrtip',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 1em;">Export</i>',
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
	   var bkngCount='${bkng_count}';
	   $('#weeklybkngrprt_table').DataTable( {
	        dom: 'Bfrtip', "paging":   false,  "ordering": false,  "info":     false,  "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: red; font-size: 1em;">Export</i>',
	                filename: 'Week Wise Booking Report Of Sales Engineers For Year (${MNTH_TXT}/${CURR_YR})  ',
	                title: 'Week Wise Booking Report Of Sales Engineers For Year (${MNTH_TXT}/${CURR_YR})  ',
	                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
	              }],
	              
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
	  	                .column( 4 )
	  	                .data()
	  	                .reduce( function (a, b) {
	  	                    return intVal(a) + intVal(b);
	  	                }, 0 );
	  	            
	  	            var total2 = api
	                  .column( 5 )
	                  .data()
	                  .reduce( function (a, b) {
	                      return intVal(a) + intVal(b);
	                  }, 0 );
	  	            
	  	            var total3 = api
	                  .column( 6 )
	                  .data()
	                  .reduce( function (a, b) {
	                      return intVal(a) + intVal(b);
	                  }, 0 );
	  	            
	  	            var total4 = api
	                  .column( 7 )
	                  .data()
	                  .reduce( function (a, b) {
	                      return intVal(a) + intVal(b);
	                  }, 0 );
	              
	              var total5 = api
	              .column( 8 )
	              .data()
	              .reduce( function (a, b) {
	                  return intVal(a) + intVal(b);
	              }, 0 );
	              
	           
	  	        
	  	            // Update footer
	  	                     $( api.column(4).footer()).html(formatNumber(total1));
	  	                     $( api.column(5).footer()).html(formatNumber(total2));
	  	                     $( api.column(6).footer()).html(formatNumber(total3));
	  	                     $( api.column(7).footer()).html(formatNumber((total4/ (bkngCount * 100) * 100).toFixed(2)));
	  	            		 $( api.column(8).footer()).html(formatNumber(total5));
	  	            
	  	            
	  	        }
	      } );  
	   
} );
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

//implemented graph in stage details

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
	        	['Sales Engineer','Stages', { role: 'style' },{ role: 'annotation' }],
 	            ['S2', s2Data, '#dd4b39',new Intl.NumberFormat('en-US', { style: 'decimal', maximumFractionDigits: 2 }).format(s2Data / 1000000)],
 	            ['S3', s3Data, '#f39c12',new Intl.NumberFormat('en-US', { style: 'decimal', maximumFractionDigits: 2 }).format(s3Data / 1000000)],
 	            ['S4', s4Data, '#0073b7',new Intl.NumberFormat('en-US', { style: 'decimal', maximumFractionDigits: 2 }).format(s4Data / 1000000)],
 	            ['S5', s5Data, '#00a65a',new Intl.NumberFormat('en-US', { style: 'decimal', maximumFractionDigits: 2 }).format(s5Data / 1000000)]
	        ]);

	        var options = {
	           // title: 'My Daily Activities'
	        		vAxis: {minValue: 0,title: 'Amount',  titleTextStyle: {color: '#333'},format: 'short'},
	        		 legend: { position: 'top' },
	        		 annotations: {
	    				    textStyle: { color: '#000',opacity: 0.8}
	    				  },
	        };

	        var chart = new google.visualization.ColumnChart(document.getElementById('stagedetailsgraph'));
	        chart.draw(data, options);
	    }
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