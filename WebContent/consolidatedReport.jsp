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
 <!--<c:set var="syrtemp" value="${CURR_YR}" scope="page" />-->
 <c:set var="syrtemp" value="${selected_Year}" scope="page" />
 <c:set var="sdvsntemp" value="${selected_Division}" scope="page" />
<!DOCTYPE html>
<html><head>
 <style>
#guage_test_booking,#guage_test_billing { height: 210px; width: 100%;}#guage_test_billing svg, #guage_test_booking svg{ border: 1px solid #9E9E9E;margin-top: 20px; border-radius: 5px;} 
.nav-tabs-custom>.nav-tabs>li.active { border-top: 2px solid #065685 !important;}svg:first-child > g > text[text-anchor~=middle]{ font-size: 18px;font-weight: bold; fill: #337ab7;}.modal-dialog, .modal-content { /* 80% of window height */ /* height: 80%;*/height: calc(100% - 20%);}
.modal-body {max-height: calc(100% - 120px); overflow-y: scroll; overflow-x: scroll;}
.modal-body th{ font-weight:bold;}.modal-footer {padding: 2px 15px 15px 15px !important;}.loader {position: fixed; z-index: 999; height: 2em;width: 2em;overflow: show; margin: auto; top: 0;left: 0;bottom: 0; right: 0;}
.loader:before { content: '';display: block;position: fixed;top: 0; left: 0;width: 100%; height: 100%; background-color: rgba(0,0,0,0.3);}.stage{ background-color: #065685;color: white; border: 1px solid #065685;}
.navbar { margin-bottom: 8px !important;} .table{display: block !important; overflow-x:auto !important;}#db-title-boxx{background: white; height: auto;; margin-top: -9px; margin-left: -10px; margin-right: -10px; box-shadow: 0 0 4px rgba(0,0,0,.14), 0 4px 8px rgba(0,0,0,.28);}
.lastTd{border-right: none !important;border-left: none !important;}.fjtco-table {background-color: #ffff;padding: 0.01em 16px; margin: 7px 7px 7px 15px; box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important;border-top: 3px solid #065685;}
.small-box>.inner { padding: 5px;height: 75px;}.small-box h3 {font-size: 30px !important;}.container {padding-right: 0px !important; padding-left: 0px !important;}
.wrapper{margin-top:-8px;}.counter-anim{color:#FFEB3B;font-weight: normal !important;font-size: 80%;}.counter-anim:hover{cursor: pointer;color:red;}
.collapse.in { background: #3b80a9;color: white;text-align: center; font-weight: bold;font-size: larger;display: block;}.weight-500{color:#FFF;font-weight: bold;font-size: 80%;}.padding-0{padding-right:0; padding-left:0;width: 150px;margin-bottom: -18px;}
.paddingr-0{padding-right:0; padding-left:0;width: 150px; margin-bottom: -18px;}.paddingl-0{padding-left:0;padding-right:0; width: 150px;margin-bottom: -18px;}
.fjtco-table .panel-body {padding: 3px;}.box-tools{cursor: pointer;}.row{margin-left:0px !important;margin-right:0px !important;}#stages-dt .col-lg-6 {margin-top: -5px;}
 #stages-dt .small-box .icon { -webkit-transition: all .3s linear; -o-transition: all .3s linear;transition: all .3s linear; position: absolute; top: -5px; right: 10px; z-index: 0; font-size: 60px; color: rgba(0,0,0,0.15);}
.main-header {z-index: 851 !important;}.box-header .box-title{font-size:15px !important;font-weight:bold !important;}.nav-tabs>li.active>a, .nav-tabs>li.active>a:focus, .nav-tabs>li.active>a:hover{color: #000 !important; background-color: #fff !important; }
.nav-tabs>li>a{color: #3c8dbc !important; background-color: #ecf0f5 !important;}.modal-title {color: #009688 !important;font-weight: bold !important;}.overlay {position: absolute;}
.box .overlay {margin-top: -19px !important;right: 15px !important;}#jihLostModalGraph th, #jihLostModalGraph td,#billing_modal_table td,#billing_modal_table th,#booking_modal_table td,#booking_modal_table th,#jihv_modal_table td,#jihv_modal_table th{padding: 5px !important;border: 1px solid #2196F3;}
#chart_div{height:230px;margin-top:-37px;}@media ( max-width : 375px) {#chart_div{margin-top: -19px;}.modal-title{font-size: 95%;}#billing_modal_table_wrapper,#fundsblocked_modal_table_wrapper,#jihv_modal_table_wrapper, #booking_modal_table_wrapper{margin-right: 5px;}.box-header 

.box-title {font-size: 13px !important;}#guage_test_billing svg{ margin-left: -15px !important}}
@media ( max-width : 450px) {}@media ( max-width : 400px) {}@media ( max-width : 700px) {}@media (min-width: 1200px){}
.fjtco-rcvbles{background-color: #ffff;  padding: 0.01em 16px; margin: 7px 7px 7px 15px;  box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important;border-top: 3px solid #9e9e9e;}
.fjtco-rcvbles .panel-body{padding:5px !important;} #subdivnBkng_table,#subdivnBlng_table {border: 1px solid #9C27B0; table-layout: fixed;   } #subdivnBkng_table  tfoot th, #subdivnBkng_table tfoot td.#subdivnBlng_table  tfoot th, #subdivnBlng_table tfoot td {padding: 5px 5px 5px 5px;}
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
/*.select-items {position: absolute;top: 5%;left: 399px;right: 375px;z-index: 99;}
/* .fade { */
/*      opacity: 0; */
/*      transition: opacity .15s linear; */
/*      display: none; */
/* } */

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



<script src="https://code.highcharts.com/highcharts.js"></script> 
<script src="https://code.highcharts.com/highcharts-more.js"></script> 
<script src="https://code.highcharts.com/modules/exporting.js"></script> 

 <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
 <script type="text/javascript">
 var Million = 1000000;
 var totLosts = 0, targeteportsList = <%=new Gson().toJson(request.getAttribute("JIHLA"))%>;
 function preLoader(){ $('#laoding').show();}
 $(document).ready(function() { $('#laoding').hide();$('#laoding-rcvbl').hide();$('#laoding-pdc').hide();$('#laoding-jihqlst').hide();});  
 function formatNumber(num) {return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");}
 function convertToMillion(num) {
	 if(num <= 0){return 0; }else{
		 num = num / Million;
		 return Math.ceil(num * 100)/100;}	 
	 }
 


//stage 1 detail normal se page

</script>

<c:set var="total_wc" value="0" scope="page" />
<c:set var="total_fb" value="0" scope="page" />
<c:set var="total_fp" value="0" scope="page" />
<c:set var="wc_mnth_count" value="0" scope="page" />
<c:set var="fb_mnth_count" value="0" scope="page" />
<c:set var="fp_mnth_count" value="0" scope="page" />

<c:forEach var="wc" items="${WCCAPSUM}">

	<c:if test="${wc.wctotal[0] ne null and !empty wc.wctotal[0] and 1<= MTH}">		
		<c:set var="wc_mnth_count" value="${wc_mnth_count + 1 }" scope="page" />
		<c:set var="total_wc" value="${total_wc + wc.wctotal[0]}" scope="page" />
		<c:set var="totalwcjan_avg" value="${total_wc/wc_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${wc.wctotal[1] ne null and !empty wc.wctotal[1] and 2<= MTH}">		
		<c:set var="wc_mnth_count" value="${wc_mnth_count + 1 }" scope="page" />		
		<c:set var="total_wc" value="${total_wc + wc.wctotal[1]}" scope="page" />
		<c:set var="totalwcfeb_avg" value="${(total_wc)/wc_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${wc.wctotal[2] ne null and !empty wc.wctotal[2] and 3<= MTH}">		
		<c:set var="wc_mnth_count" value="${wc_mnth_count + 1 }" scope="page" />	
		<c:set var="total_wc" value="${total_wc + wc.wctotal[2]}" scope="page" />
		<c:set var="totalwcmar_avg" value="${(total_wc)/wc_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${wc.wctotal[3] ne null and !empty wc.wctotal[3] and 4<= MTH}">
		<c:set var="wc_mnth_count" value="${wc_mnth_count + 1 }" scope="page" />	
		<c:set var="total_wc" value="${total_wc + wc.wctotal[3]}" scope="page" />
		<c:set var="totalwcapr_avg" value="${(total_wc)/wc_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${wc.wctotal[4] ne null and !empty wc.wctotal[4] and 5<= MTH}">
		<c:set var="wc_mnth_count" value="${wc_mnth_count + 1 }" scope="page" />		
		<c:set var="total_wc" value="${total_wc + wc.wctotal[4]}" scope="page" />
		<c:set var="totalwcmay_avg" value="${(total_wc)/wc_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${wc.wctotal[5] ne null and !empty wc.wctotal[5] and 6<= MTH}">
		<c:set var="wc_mnth_count" value="${wc_mnth_count + 1 }" scope="page" />		
		<c:set var="total_wc" value="${total_wc + wc.wctotal[5]}" scope="page" />
		<c:set var="totalwcjun_avg" value="${(total_wc)/wc_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${wc.wctotal[6] ne null and !empty wc.wctotal[6] and 7<= MTH}">
		<c:set var="wc_mnth_count" value="${wc_mnth_count + 1 }" scope="page" />		
		<c:set var="total_wc" value="${total_wc + wc.wctotal[6]}" scope="page" />
		<c:set var="totalwcjul_avg" value="${(total_wc)/wc_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${wc.wctotal[7] ne null and !empty wc.wctotal[7] and 8<= MTH}">
		<c:set var="wc_mnth_count" value="${wc_mnth_count + 1 }" scope="page" />		
		<c:set var="total_wc" value="${total_wc + wc.wctotal[7]}" scope="page" />
		<c:set var="totalwcaug_avg" value="${(total_wc)/wc_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${wc.wctotal[8] ne null and !empty wc.wctotal[8] and 9<= MTH}">
		<c:set var="wc_mnth_count" value="${wc_mnth_count + 1 }" scope="page" />		
		<c:set var="total_wc" value="${total_wc + wc.wctotal[8]}" scope="page" />
		<c:set var="totalwcsep_avg" value="${(total_wc)/wc_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${wc.wctotal[9] ne null and !empty wc.wctotal[9] and 10<= MTH}">
		<c:set var="wc_mnth_count" value="${wc_mnth_count + 1 }" scope="page" />		
		<c:set var="total_wc" value="${total_wc + wc.wctotal[9]}" scope="page" />
		<c:set var="totalwcoct_avg" value="${(total_wc)/wc_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${wc.wctotal[10] ne null and !empty wc.wctotal[10] and 11<= MTH}">
		<c:set var="wc_mnth_count" value="${wc_mnth_count + 1 }" scope="page" />		
		<c:set var="total_wc" value="${total_wc + wc.wctotal[10]}" scope="page" />
		<c:set var="totalnov_avg" value="${(total_wc)/wc_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${wc.wctotal[11] ne null and !empty wc.wctotal[11] and 12<= MTH}">
		<c:set var="wc_mnth_count" value="${wc_mnth_count + 1 }" scope="page" />		
		<c:set var="total_wc" value="${total_wc + wc.wctotal[11]}" scope="page" />
		<c:set var="totalwcdec_avg" value="${(total_wc)/wc_mnth_count}" scope="page" />
	</c:if>

</c:forEach>
  
  <c:forEach var="fb" items="${FUNDSBLOCKEDSUM}">
	<c:if test="${fb.totalbcfunds[0] ne null and !empty fb.totalbcfunds[0] and 1<= MTH}">		
		<c:set var="fb_mnth_count" value="${fb_mnth_count + 1 }" scope="page" />
		<c:set var="total_fb" value="${total_fb + fb.totalbcfunds[0]}" scope="page" />
		<c:set var="totalfbjan_avg" value="${total_fb/fb_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${fb.totalbcfunds[1] ne null and !empty fb.totalbcfunds[1] and 2<= MTH}">		
		<c:set var="fb_mnth_count" value="${fb_mnth_count + 1 }" scope="page" />		
		<c:set var="total_fb" value="${total_fb + fb.totalbcfunds[1]}" scope="page" />
		<c:set var="totalfbfeb_avg" value="${(total_fb)/fb_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${fb.totalbcfunds[2] ne null and !empty fb.totalbcfunds[2] and 3<= MTH}">		
		<c:set var="fb_mnth_count" value="${fb_mnth_count + 1 }" scope="page" />	
		<c:set var="total_fb" value="${total_fb + fb.totalbcfunds[2]}" scope="page" />
		<c:set var="totalfbmar_avg" value="${(total_fb)/fb_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${fb.totalbcfunds[3] ne null and !empty fb.totalbcfunds[3] and 4<= MTH}">
		<c:set var="fb_mnth_count" value="${fb_mnth_count + 1 }" scope="page" />	
		<c:set var="total_fb" value="${total_fb + fb.totalbcfunds[3]}" scope="page" />
		<c:set var="totalfbapr_avg" value="${(total_fb)/fb_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${fb.totalbcfunds[4] ne null and !empty fb.totalbcfunds[4] and 5<= MTH}">
		<c:set var="fb_mnth_count" value="${fb_mnth_count + 1 }" scope="page" />		
		<c:set var="total_fb" value="${total_fb + fb.totalbcfunds[4]}" scope="page" />
		<c:set var="totalfbmay_avg" value="${(total_fb)/fb_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${fb.totalbcfunds[5] ne null and !empty fb.totalbcfunds[5] and 6<= MTH}">
		<c:set var="fb_mnth_count" value="${fb_mnth_count + 1 }" scope="page" />		
		<c:set var="total_fb" value="${total_fb + fb.totalbcfunds[5]}" scope="page" />
		<c:set var="totalfbjun_avg" value="${(total_fb)/fb_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${fb.totalbcfunds[6] ne null and !empty fb.totalbcfunds[6] and 7<= MTH}">
		<c:set var="fb_mnth_count" value="${fb_mnth_count + 1 }" scope="page" />		
		<c:set var="total_fb" value="${total_fb + fb.totalbcfunds[6]}" scope="page" />
		<c:set var="totalfbjul_avg" value="${(total_fb)/fb_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${fb.totalbcfunds[7] ne null and !empty fb.totalbcfunds[7] and 8<= MTH}">
		<c:set var="fb_mnth_count" value="${fb_mnth_count + 1 }" scope="page" />		
		<c:set var="total_fb" value="${total_fb + fb.totalbcfunds[7]}" scope="page" />
		<c:set var="totalfbaug_avg" value="${(total_fb)/fb_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${fb.totalbcfunds[8] ne null and !empty fb.totalbcfunds[8] and 9<= MTH}">
		<c:set var="fb_mnth_count" value="${fb_mnth_count + 1 }" scope="page" />		
		<c:set var="total_fb" value="${total_fb + fb.totalbcfunds[8]}" scope="page" />
		<c:set var="totalfbsep_avg" value="${(total_fb)/fb_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${fb.totalbcfunds[9] ne null and !empty fb.totalbcfunds[9] and 10<= MTH}">
		<c:set var="fb_mnth_count" value="${fb_mnth_count + 1 }" scope="page" />		
		<c:set var="total_fb" value="${total_fb + fb.totalbcfunds[9]}" scope="page" />
		<c:set var="totalfboct_avg" value="${(total_fb)/fb_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${fb.totalbcfunds[10] ne null and !empty fb.totalbcfunds[10] and 11<= MTH}">
		<c:set var="fb_mnth_count" value="${fb_mnth_count + 1 }" scope="page" />		
		<c:set var="total_fb" value="${total_fb + fb.totalbcfunds[10]}" scope="page" />
		<c:set var="totalfbnov_avg" value="${(total_fb)/fb_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${fb.totalbcfunds[11] ne null and !empty fb.totalbcfunds[11] and 12<= MTH}">
		<c:set var="fb_mnth_count" value="${fb_mnth_count + 1 }" scope="page" />		
		<c:set var="total_fb" value="${total_fb + fb.wctotal[11]}" scope="page" />
		<c:set var="totalfbdec_avg" value="${(total_fb)/fb_mnth_count}" scope="page" />
	</c:if>	
</c:forEach>
 
 <c:forEach var="fp" items="${FINPOSSUM}">
	<c:if test="${fp.fp_total[0] ne null and !empty fp.fp_total[0] and 1<= MTH}">		
		<c:set var="fp_mnth_count" value="${fp_mnth_count + 1 }" scope="page" />
		<c:set var="total_fp" value="${total_fp + fp.fp_total[0]}" scope="page" />
		<c:set var="totalfpjan_avg" value="${total_fp/fp_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${fp.fp_total[1] ne null and !empty fp.fp_total[1] and 2<= MTH}">		
		<c:set var="fp_mnth_count" value="${fp_mnth_count + 1 }" scope="page" />		
		<c:set var="total_fp" value="${total_fp + fp.fp_total[1]}" scope="page" />
		<c:set var="totalfpfeb_avg" value="${(total_fp)/fp_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${fp.fp_total[2] ne null and !empty fp.fp_total[2] and 3<= MTH}">		
		<c:set var="fp_mnth_count" value="${fp_mnth_count + 1 }" scope="page" />	
		<c:set var="total_fp" value="${total_fp + fp.fp_total[2]}" scope="page" />
		<c:set var="totalfpmar_avg" value="${(total_fp)/fp_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${fp.fp_total[3] ne null and !empty fp.fp_total[3] and 4<= MTH}">
		<c:set var="fp_mnth_count" value="${fp_mnth_count + 1 }" scope="page" />	
		<c:set var="total_fp" value="${total_fp + fp.fp_total[3]}" scope="page" />
		<c:set var="totalfpapr_avg" value="${(total_fp)/fp_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${fp.fp_total[4] ne null and !empty fp.fp_total[4] and 5<= MTH}">
		<c:set var="fp_mnth_count" value="${fp_mnth_count + 1 }" scope="page" />		
		<c:set var="total_fp" value="${total_fp + fp.fp_total[4]}" scope="page" />
		<c:set var="totalfpmay_avg" value="${(total_fp)/fp_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${fp.fp_total[5] ne null and !empty fp.fp_total[5] and 6<= MTH}">
		<c:set var="fp_mnth_count" value="${fp_mnth_count + 1 }" scope="page" />		
		<c:set var="total_fp" value="${total_fp + fp.fp_total[5]}" scope="page" />
		<c:set var="totalfpjun_avg" value="${(total_fp)/fp_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${fp.fp_total[6] ne null and !empty fp.fp_total[6] and 7<= MTH}">
		<c:set var="fp_mnth_count" value="${fp_mnth_count + 1 }" scope="page" />		
		<c:set var="total_fp" value="${total_fp + fp.fp_total[6]}" scope="page" />
		<c:set var="totalfpjul_avg" value="${(total_fp)/fp_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${fp.fp_total[7] ne null and !empty fp.fp_total[7] and 8<= MTH}">
		<c:set var="fp_mnth_count" value="${fp_mnth_count + 1 }" scope="page" />		
		<c:set var="total_fp" value="${total_fp + fp.fp_total[7]}" scope="page" />
		<c:set var="totalfpaug_avg" value="${(total_fp)/fp_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${fp.fp_total[8] ne null and !empty fp.fp_total[8] and 9<= MTH}">
		<c:set var="fp_mnth_count" value="${fp_mnth_count + 1 }" scope="page" />		
		<c:set var="total_fp" value="${total_fp + fp.fp_total[8]}" scope="page" />
		<c:set var="totalfpsep_avg" value="${(total_fp)/fp_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${fp.fp_total[9] ne null and !empty fp.fp_total[9] and 10<= MTH}">
		<c:set var="fp_mnth_count" value="${fp_mnth_count + 1 }" scope="page" />		
		<c:set var="total_fp" value="${total_fp + fp.fp_total[9]}" scope="page" />
		<c:set var="totalfpoct_avg" value="${(total_fp)/fp_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${fp.fp_total[10] ne null and !empty fp.fp_total[10] and 11<= MTH}">
		<c:set var="fp_mnth_count" value="${fp_mnth_count + 1 }" scope="page" />		
		<c:set var="total_fp" value="${total_fp + fp.fp_total[10]}" scope="page" />
		<c:set var="totalfpnov_avg" value="${(total_fp)/fp_mnth_count}" scope="page" />
	</c:if>
	<c:if
		test="${fp.fp_total[11] ne null and !empty fp.fp_total[11] and 12<= MTH}">
		<c:set var="fp_mnth_count" value="${fp_mnth_count + 1 }" scope="page" />		
		<c:set var="total_fp" value="${total_fp + fp.fp_total[11]}" scope="page" />
		<c:set var="totalfpdec_avg" value="${(total_fp)/fp_mnth_count}" scope="page" />
	</c:if>

	
</c:forEach>
  
  
  

 <script type="text/javascript">
 function percentageCal(a,t){ var p = (a/t) * 100;   if(isNaN(p) || t==0){ return 0;} else{p=Math.round(p * 100) / 100; return p;}}
 $(document).ready(function(){
	 google.charts.load('current', {'packages':['corechart', 'gauge','table']});
	 google.charts.setOnLoadCallback(workingCapitalSummary);
	 google.charts.setOnLoadCallback(fundsBlockedSummary);
	 google.charts.setOnLoadCallback(financialPositionSummary);
 
 });
 
 function workingCapitalSummary() { 
	 var data = google.visualization.arrayToDataTable([ ['Month', 'Actual',{ role: 'annotation' },'Moving Average','Target'],
			
		 <c:if test="${WCCAPSUM ne null and not empty WCCAPSUM}">
		 <c:forEach var="ytm_tmp" items="${WCCAPSUM}">			
		    <c:choose>
		    <c:when test="${syrtemp ne CURR_YR}">				 
		            ['Jan', ${ytm_tmp.wctotal[0]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.wctotal[0]/1000000}'/>,${totalwcjan_avg},${ytm_tmp.wctotal[12]}],  
			        ['Feb', ${ytm_tmp.wctotal[1]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.wctotal[1]/1000000}'/>,${totalwcjan_avg},${ytm_tmp.wctotal[12]}],  
			        ['Mar', ${ytm_tmp.wctotal[2]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.wctotal[2]/1000000}'/>,${totalwcjan_avg},${ytm_tmp.wctotal[12]}], 
			        ['Apr', ${ytm_tmp.wctotal[3]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.wctotal[3]/1000000}'/>,${totalwcjan_avg},${ytm_tmp.wctotal[12]}], 
			        ['May', ${ytm_tmp.wctotal[4]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.wctotal[4]/1000000}'/>,${totalwcjan_avg},${ytm_tmp.wctotal[12]}], 
			        ['Jun', ${ytm_tmp.wctotal[5]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.wctotal[5]/1000000}'/>,${totalwcjan_avg},${ytm_tmp.wctotal[12]}], 
			        ['Jul', ${ytm_tmp.wctotal[6]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.wctotal[6]/1000000}'/>,${totalwcjan_avg},${ytm_tmp.wctotal[12]}],  
			        ['Aug', ${ytm_tmp.wctotal[7]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.wctotal[7]/1000000}'/>,${totalwcjan_avg},${ytm_tmp.wctotal[12]}],
			        ['Sep', ${ytm_tmp.wctotal[8]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.wctotal[8]/1000000}'/>,${totalwcjan_avg},${ytm_tmp.wctotal[12]}], 
			        ['Oct', ${ytm_tmp.wctotal[9]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.wctotal[9]/1000000}'/>,${totalwcjan_avg},${ytm_tmp.wctotal[12]}], 
			        ['Nov', ${ytm_tmp.wctotal[10]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.wctotal[10]/1000000}'/>,${totalwcjan_avg},${ytm_tmp.wctotal[12]}], 
			        ['Dec', ${ytm_tmp.wctotal[11]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.wctotal[11]/1000000}'/>,${totalwcjan_avg},${ytm_tmp.wctotal[12]}], 			       
					</c:when>
					 <c:otherwise> 
					  <c:if test="${1 le MTH}"> ['Jan', ${ytm_tmp.wctotal[0]}, <fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.wctotal[0]/1000000}'/>,${totalwcjan_avg},${ytm_tmp.wctotal[12]}],  </c:if>
			          <c:if test="${2 le MTH}">['Feb', ${ytm_tmp.wctotal[1]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.wctotal[1]/1000000}'/>,${totalwcfeb_avg},${ytm_tmp.wctotal[12]}],  </c:if>
			          <c:if test="${3 le MTH}">['Mar', ${ytm_tmp.wctotal[2]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.wctotal[2]/1000000}'/>,${totalwcmar_avg},${ytm_tmp.wctotal[12]}], </c:if>
			          <c:if test="${4 le MTH}"> ['Apr', ${ytm_tmp.wctotal[3]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.wctotal[3]/1000000}'/>,${totalwcapr_avg},${ytm_tmp.wctotal[12]}], </c:if>
			          <c:if test="${5 le MTH}"> ['May', ${ytm_tmp.wctotal[4]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.wctotal[4]/1000000}'/>,${totalwcmay_avg},${ytm_tmp.wctotal[12]}], </c:if>
			          <c:if test="${6 le MTH}"> ['Jun', ${ytm_tmp.wctotal[5]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.wctotal[5]/1000000}'/>,${totalwcjun_avg},${ytm_tmp.wctotal[12]}], </c:if>
			          <c:if test="${7 le MTH}">['Jul', ${ytm_tmp.wctotal[6]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.wctotal[6]/1000000}'/>,${totalwcjul_avg},${ytm_tmp.wctotal[12]}],  </c:if>
			          <c:if test="${8 le MTH}">['Aug', ${ytm_tmp.wctotal[7]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.wctotal[7]/1000000}'/>,${totalwcaug_avg},${ytm_tmp.wctotal[12]}], </c:if>
			          <c:if test="${9 le MTH}"> ['Sep', ${ytm_tmp.wctotal[8]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.wctotal[8]/1000000}'/>,${totalwcsep_avg},${ytm_tmp.wctotal[12]}], </c:if>
			          <c:if test="${10 le MTH}">['Oct', ${ytm_tmp.wctotal[9]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.wctotal[9]/1000000}'/>,${totalwcoct_avg},${ytm_tmp.wctotal[12]}], </c:if>
			          <c:if test="${11 le MTH}"> ['Nov', ${ytm_tmp.wctotal[10]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.wctotal[10]/1000000}'/>,${totalwcnov_avg},${ytm_tmp.wctotal[12]}], </c:if>
			          <c:if test="${12 le MTH}"> ['Dec', ${ytm_tmp.wctotal[11]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.wctotal[11]/1000000}'/>,${totalwcdec_avg},${ytm_tmp.wctotal[12]}], </c:if>
			         </c:otherwise>
			         </c:choose>
		  	 </c:forEach>
		   </c:if>
		   <c:if test="${WCCAPSUM eq null or empty WCCAPSUM}">
		     <c:if test="${1 le MTH}"> ['Jan',0,0, 0,0],  </c:if>
	         <c:if test="${2 le MTH}">['Feb', 0,0,0,0],  </c:if>
	         <c:if test="${3 le MTH}">['Mar',0,0,0,0], </c:if>
	         <c:if test="${4 le MTH}"> ['Apr', 0,0,0,0], </c:if>
	         <c:if test="${5 le MTH}"> ['May', 0,0,0,0], </c:if>
	         <c:if test="${6 le MTH}"> ['Jun', 0,0,0,0], </c:if>
	         <c:if test="${7 le MTH}">['Jul', 0,0,0,0],  </c:if>
	         <c:if test="${8 le MTH}">['Aug', 0,0,0,0], </c:if>
	         <c:if test="${9 le MTH}"> ['Sep', 0,0,0,0], </c:if>
	         <c:if test="${10 le MTH}">['Oct',0,0,0,0], </c:if>
	         <c:if test="${11 le MTH}"> ['Nov', 0,0,0,0], </c:if>
	         <c:if test="${12 le MTH}"> ['Dec',0,0,0,0], </c:if>		        
		 </c:if>
		   
	        ]);
		 

		
			var view = new google.visualization.DataView(data);
			 view.setColumns([0,1,2,3]);
	      // Set chart options
	    var options = {
				
		 titleTextStyle: {
		     color: '#000',
		     fontSize: 13,
		     fontName: 'Arial',
		     bold: true,
		    
		  },
		  annotations: {
				    textStyle: {color: '#000',opacity: 0.8}
				  },
		 vAxis: {title: 'Value'},
		 series: {
	            0: {targetAxisIndex: 0},	 
	            1: {targetAxisIndex: 0,type: 'line'},
	            2: {targetAxisIndex: 0,type: 'line'}
	          },
	      'title':'Working Capital Target for ${syrtemp} : <c:forEach var="ytm_tmp" items="${WCCAPSUM}"> <fmt:formatNumber type="number"   value="${ytm_tmp.wctotal[12]}"/></c:forEach> ', 
	      'vAxis': {title: 'Amount (In Millions)',titleTextStyle: {italic: false},format: 'short'},
	      seriesType: 'bars',
	      pointSize:2,
	      colors: ['#00a65a', '#0000FF','#0b1d39'],
		 'is3D':true,		  
		      'height': 230,
		      'legend': {
		        position: 'top'
		      },
		      hAxis: { slantedText:true, slantedTextAngle:90 }
	          , tooltip: { textStyle: { fontName: 'verdana', fontSize: 12 } }
			};


	      // Instantiate and draw our chart, passing in some options.
	      var chart = new google.visualization.ComboChart(document.getElementById('workingcapitalchart_div'));
	    
	      chart.draw(data, options);
	      google.visualization.events.addListener(chart, 'onmouseover', uselessHandlerbkfb5);
	      google.visualization.events.addListener(chart, 'onmouseout', uselessHandlerbkfb6);
	      google.visualization.events.addListener(chart, 'select', selectHandlerbk);
	      function uselessHandlerbkfb5() {$('#workingcapitalchart_div').css('cursor','pointer')}
	      function uselessHandlerbkfb6() {$('#workingcapitalchart_div').css('cursor','default')}
 	     function selectHandlerbk() {
 	    	$('#fundsblocked_moreinfo_modal').modal("show");   
	      }
	    }
 
 function fundsBlockedSummary() {
		 var data = google.visualization.arrayToDataTable([ ['Month', 'Actual',{ role: 'annotation' },'Moving Average','Target'],
		
		 <c:if test="${FUNDSBLOCKEDSUM ne null and not empty FUNDSBLOCKEDSUM}">
		 <c:forEach var="ytm_tmp" items="${FUNDSBLOCKEDSUM}">			
		    <c:choose>
		    <c:when test="${syrtemp ne CURR_YR}">				 
		            ['Jan', ${ytm_tmp.totalbcfunds[0]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.totalbcfunds[0]/1000000}'/>,${totalfbjan_avg},${ytm_tmp.totalbcfunds[12]}],  
			        ['Feb', ${ytm_tmp.totalbcfunds[1]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.totalbcfunds[1]/1000000}'/>,${totalfbfeb_avg},${ytm_tmp.totalbcfunds[12]}],  
			        ['Mar', ${ytm_tmp.totalbcfunds[2]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.totalbcfunds[2]/1000000}'/>,${totalfbmar_avg},${ytm_tmp.totalbcfunds[12]}], 
			        ['Apr', ${ytm_tmp.totalbcfunds[3]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.totalbcfunds[3]/1000000}'/>,${totalfbapr_avg},${ytm_tmp.totalbcfunds[12]}], 
			        ['May', ${ytm_tmp.totalbcfunds[4]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.totalbcfunds[4]/1000000}'/>,${totalfbmay_avg},${ytm_tmp.totalbcfunds[12]}], 
			        ['Jun', ${ytm_tmp.totalbcfunds[5]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.totalbcfunds[5]/1000000}'/>,${totalfbjun_avg},${ytm_tmp.totalbcfunds[12]}], 
			        ['Jul', ${ytm_tmp.totalbcfunds[6]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.totalbcfunds[6]/1000000}'/>,${totalfbjul_avg},${ytm_tmp.totalbcfunds[12]}],  
			        ['Aug', ${ytm_tmp.totalbcfunds[7]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.totalbcfunds[7]/1000000}'/>,${totalfbaug_avg},${ytm_tmp.totalbcfunds[12]}],
			        ['Sep', ${ytm_tmp.totalbcfunds[8]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.totalbcfunds[8]/1000000}'/>,${totalfbsep_avg},${ytm_tmp.totalbcfunds[12]}], 
			        ['Oct', ${ytm_tmp.totalbcfunds[9]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.totalbcfunds[9]/1000000}'/>,${totalfboct_avg},${ytm_tmp.totalbcfunds[12]}], 
			        ['Nov', ${ytm_tmp.totalbcfunds[10]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.totalbcfunds[10]/1000000}'/>,${totalfbnov_avg},${ytm_tmp.totalbcfunds[12]}], 
			        ['Dec', ${ytm_tmp.totalbcfunds[11]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.totalbcfunds[11]/1000000}'/>,${totalfbdec_avg},${ytm_tmp.totalbcfunds[12]}], 			       
			 </c:when>
			 <c:otherwise> 
					  <c:if test="${1 le MTH}"> ['Jan', ${ytm_tmp.totalbcfunds[0]}, <fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.totalbcfunds[0]/1000000}'/>,${totalfbjan_avg},${ytm_tmp.totalbcfunds[12]}],  </c:if>
			          <c:if test="${2 le MTH}">['Feb', ${ytm_tmp.totalbcfunds[1]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.totalbcfunds[1]/1000000}'/>,${totalfbfeb_avg},${ytm_tmp.totalbcfunds[12]}],  </c:if>
			          <c:if test="${3 le MTH}">['Mar', ${ytm_tmp.totalbcfunds[2]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.totalbcfunds[2]/1000000}'/>,${totalfbmar_avg},${ytm_tmp.totalbcfunds[12]}], </c:if>
			          <c:if test="${4 le MTH}"> ['Apr', ${ytm_tmp.totalbcfunds[3]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.totalbcfunds[3]/1000000}'/>,${totalfbapr_avg},${ytm_tmp.totalbcfunds[12]}], </c:if>
			          <c:if test="${5 le MTH}"> ['May', ${ytm_tmp.totalbcfunds[4]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.totalbcfunds[4]/1000000}'/>,${totalfbmay_avg},${ytm_tmp.totalbcfunds[12]}], </c:if>
			          <c:if test="${6 le MTH}"> ['Jun', ${ytm_tmp.totalbcfunds[5]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.totalbcfunds[5]/1000000}'/>,${totalfbjun_avg},${ytm_tmp.totalbcfunds[12]}], </c:if>
			          <c:if test="${7 le MTH}">['Jul', ${ytm_tmp.totalbcfunds[6]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.totalbcfunds[6]/1000000}'/>,${totalfbjul_avg},${ytm_tmp.totalbcfunds[12]}],  </c:if>
			          <c:if test="${8 le MTH}">['Aug', ${ytm_tmp.totalbcfunds[7]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.totalbcfunds[7]/1000000}'/>,${totalfbaug_avg},${ytm_tmp.totalbcfunds[12]}], </c:if>
			          <c:if test="${9 le MTH}"> ['Sep', ${ytm_tmp.totalbcfunds[8]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.totalbcfunds[8]/1000000}'/>,${totalfbsep_avg},${ytm_tmp.totalbcfunds[12]}], </c:if>
			          <c:if test="${10 le MTH}">['Oct', ${ytm_tmp.totalbcfunds[9]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.totalbcfunds[9]/1000000}'/>,${totalfboct_avg},${ytm_tmp.totalbcfunds[12]}], </c:if>
			          <c:if test="${11 le MTH}"> ['Nov', ${ytm_tmp.totalbcfunds[10]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.totalbcfunds[10]/1000000}'/>,${totalfbnov_avg},${ytm_tmp.totalbcfunds[12]}], </c:if>
			          <c:if test="${12 le MTH}"> ['Dec', ${ytm_tmp.totalbcfunds[11]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.totalbcfunds[11]/1000000}'/>,${totalfbdec_avg},${ytm_tmp.totalbcfunds[12]}], </c:if>
			         </c:otherwise>
			         </c:choose>
		  	 </c:forEach>
		   </c:if>
		   <c:if test="${FUNDSBLOCKEDSUM eq null or empty FUNDSBLOCKEDSUM}">
		     <c:if test="${1 le MTH}"> ['Jan',0,0, 0,0],  </c:if>
	         <c:if test="${2 le MTH}">['Feb', 0,0,0,0],  </c:if>
	         <c:if test="${3 le MTH}">['Mar',0,0,0,0], </c:if>
	         <c:if test="${4 le MTH}"> ['Apr', 0,0,0,0], </c:if>
	         <c:if test="${5 le MTH}"> ['May', 0,0,0,0], </c:if>
	         <c:if test="${6 le MTH}"> ['Jun', 0,0,0,0], </c:if>
	         <c:if test="${7 le MTH}">['Jul', 0,0,0,0],  </c:if>
	         <c:if test="${8 le MTH}">['Aug', 0,0,0,0], </c:if>
	         <c:if test="${9 le MTH}"> ['Sep', 0,0,0,0], </c:if>
	         <c:if test="${10 le MTH}">['Oct',0,0,0,0], </c:if>
	         <c:if test="${11 le MTH}"> ['Nov', 0,0,0,0], </c:if>
	         <c:if test="${12 le MTH}"> ['Dec',0,0,0,0], </c:if>		        
		 </c:if>
		   
	        ]);
		 

		
			var view = new google.visualization.DataView(data);
			 view.setColumns([0,1,2,3]);
	      // Set chart options
	    var options = {
				
		 titleTextStyle: {
		     color: '#000',
		     fontSize: 13,
		     fontName: 'Arial',
		     bold: true,
		    
		  },
		  annotations: {
				    textStyle: {color: '#000',opacity: 0.8}
				  },
		 vAxis: {title: 'Value'},
		 series: {
	            0: {targetAxisIndex: 0},	
	            1: {targetAxisIndex: 0,type: 'line'},
	            2: {targetAxisIndex: 0,type: 'line'}
	          },
	      'title':'Funds Blocked - Target for ${syrtemp} : <c:forEach var="ytm_tmp" items="${FUNDSBLOCKEDSUM}"> <fmt:formatNumber type="number"   value="${ytm_tmp.totalbcfunds[12]}"/></c:forEach> ', 
	      'vAxis': {title: 'Amount (In Millions)',titleTextStyle: {italic: false},format: 'short'},
	      seriesType: 'bars',
	      pointSize:2,
	      colors: ['#dd4b39','#0000FF','#0b1d39'],
		 'is3D':true,		  
		      'height': 230,
		      'legend': {
		        position: 'top'
		      },
		      hAxis: { slantedText:true, slantedTextAngle:90 }
	          , tooltip: { textStyle: { fontName: 'verdana', fontSize: 12 } }
			};


	      // Instantiate and draw our chart, passing in some options.
	      var chart = new google.visualization.ComboChart(document.getElementById('fundsblockedchart_div'));
	    
	      chart.draw(data, options);
	      google.visualization.events.addListener(chart, 'onmouseover', uselessHandlerbkfb5);
	      google.visualization.events.addListener(chart, 'onmouseout', uselessHandlerbkfb6);
	      google.visualization.events.addListener(chart, 'select', selectHandlerbk);
	      function uselessHandlerbkfb5() {$('#fundsblockedchart_div').css('cursor','pointer')}
	      function uselessHandlerbkfb6() {$('#fundsblockedchart_div').css('cursor','default')}
 	     function selectHandlerbk() {
 	    	$('#fundsblocked_moreinfo_modal').modal("show");   
	      }
	    }
 
 function financialPositionSummary() {
	 var data = google.visualization.arrayToDataTable([ ['Month', 'Actual',{ role: 'annotation' },'Moving Average','Target'],
	
	 <c:if test="${FINPOSSUM ne null and not empty FINPOSSUM}">
	 
	 <c:forEach var="ytm_tmp" items="${FINPOSSUM}">		
		 <c:choose>
	    	<c:when test="${syrtemp ne CURR_YR}">				 
	            ['Jan', ${ytm_tmp.fp_total[0]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.fp_total[0]/1000000}'/>,${totalfpjan_avg},${ytm_tmp.fp_total[12]}],  
		        ['Feb', ${ytm_tmp.fp_total[1]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.fp_total[1]/1000000}'/>,${totalfpfeb_avg},${ytm_tmp.fp_total[12]}],  
		        ['Mar', ${ytm_tmp.fp_total[2]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.fp_total[2]/1000000}'/>,${totalfpmar_avg},${ytm_tmp.fp_total[12]}], 
		        ['Apr', ${ytm_tmp.fp_total[3]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.fp_total[3]/1000000}'/>,${totalfpapr_avg},${ytm_tmp.fp_total[12]}], 
		        ['May', ${ytm_tmp.fp_total[4]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.fp_total[4]/1000000}'/>,${totalfpmay_avg},${ytm_tmp.fp_total[12]}], 
		        ['Jun', ${ytm_tmp.fp_total[5]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.fp_total[5]/1000000}'/>,${totalfpjun_avg},${ytm_tmp.fp_total[12]}], 
		        ['Jul', ${ytm_tmp.fp_total[6]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.fp_total[6]/1000000}'/>,${totalfpjul_avg},${ytm_tmp.fp_total[12]}],  
		        ['Aug', ${ytm_tmp.fp_total[7]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.fp_total[7]/1000000}'/>,${totalfpaug_avg},${ytm_tmp.fp_total[12]}],
		        ['Sep', ${ytm_tmp.fp_total[8]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.fp_total[8]/1000000}'/>,${totalfpsep_avg},${ytm_tmp.fp_total[12]}], 
		        ['Oct', ${ytm_tmp.fp_total[9]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.fp_total[9]/1000000}'/>,${totalfpoct_avg},${ytm_tmp.fp_total[12]}], 
		        ['Nov', ${ytm_tmp.fp_total[10]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.fp_total[10]/1000000}'/>,${totalfpnov_avg},${ytm_tmp.fp_total[12]}], 
		        ['Dec', ${ytm_tmp.fp_total[11]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.fp_total[11]/1000000}'/>,${totalfpdec_avg},${ytm_tmp.fp_total[12]}], 			       
			</c:when>
			<c:otherwise> 
			  <c:if test="${1 le MTH}"> ['Jan', ${ytm_tmp.fp_total[0]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.fp_total[0]/1000000}'/>,${totalfpjan_avg},${ytm_tmp.fp_total[12]}],  </c:if>
	          <c:if test="${2 le MTH}">['Feb', ${ytm_tmp.fp_total[1]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.fp_total[1]/1000000}'/>,${totalfpfeb_avg},${ytm_tmp.fp_total[12]}],  </c:if>
	          <c:if test="${3 le MTH}">['Mar', ${ytm_tmp.fp_total[2]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.fp_total[2]/1000000}'/>,${totalfpmar_avg},${ytm_tmp.fp_total[12]}], </c:if>
	          <c:if test="${4 le MTH}"> ['Apr', ${ytm_tmp.fp_total[3]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.fp_total[3]/1000000}'/>,${totalfpapr_avg},${ytm_tmp.fp_total[12]}], </c:if>
	          <c:if test="${5 le MTH}"> ['May', ${ytm_tmp.fp_total[4]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.fp_total[4]/1000000}'/>,${totalfpmay_avg},${ytm_tmp.fp_total[12]}], </c:if>
	          <c:if test="${6 le MTH}"> ['Jun', ${ytm_tmp.fp_total[5]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.fp_total[5]/1000000}'/>,${totalfpjun_avg},${ytm_tmp.fp_total[12]}], </c:if>
	          <c:if test="${7 le MTH}">['Jul', ${ytm_tmp.fp_total[6]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.fp_total[6]/1000000}'/>,${totalfpjul_avg},${ytm_tmp.fp_total[12]}],  </c:if>
	          <c:if test="${8 le MTH}">['Aug', ${ytm_tmp.fp_total[7]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.fp_total[7]/1000000}'/>,${totalfpaug_avg},${ytm_tmp.fp_total[12]}], </c:if>
	          <c:if test="${9 le MTH}"> ['Sep', ${ytm_tmp.fp_total[8]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.fp_total[8]/1000000}'/>,${totalfpsep_avg},${ytm_tmp.fp_total[12]}], </c:if>
	          <c:if test="${10 le MTH}">['Oct', ${ytm_tmp.fp_total[9]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.fp_total[9]/1000000}'/>,${totalfpoct_avg},${ytm_tmp.fp_total[12]}], </c:if>
	          <c:if test="${11 le MTH}"> ['Nov', ${ytm_tmp.fp_total[10]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.fp_total[10]/1000000}'/>,${totalfpnov_avg},${ytm_tmp.fp_total[12]}], </c:if>
	          <c:if test="${12 le MTH}"> ['Dec', ${ytm_tmp.fp_total[11]},<fmt:formatNumber type='number'  pattern = '###.##' value='${ytm_tmp.fp_total[11]/1000000}'/>,${totalfpdec_avg},${ytm_tmp.fp_total[12]}], </c:if>	         
		   </c:otherwise>
		   </c:choose>
	   </c:forEach>
	   </c:if>
	   <c:if test="${FINPOSSUM eq null or empty FINPOSSUM}">
		   <c:if test="${1 le MTH}"> ['Jan',0,0, 0,0],  </c:if>
	       <c:if test="${2 le MTH}">['Feb', 0,0,0,0],  </c:if>
	       <c:if test="${3 le MTH}">['Mar',0,0,0,0], </c:if>
	       <c:if test="${4 le MTH}"> ['Apr', 0,0,0,0], </c:if>
	       <c:if test="${5 le MTH}"> ['May', 0,0,0,0], </c:if>
	       <c:if test="${6 le MTH}"> ['Jun', 0,0,0,0], </c:if>
	       <c:if test="${7 le MTH}">['Jul', 0,0,0,0],  </c:if>
	       <c:if test="${8 le MTH}">['Aug', 0,0,0,0], </c:if>
	       <c:if test="${9 le MTH}"> ['Sep', 0,0,0,0], </c:if>
	       <c:if test="${10 le MTH}">['Oct',0,0,0,0], </c:if>
	       <c:if test="${11 le MTH}"> ['Nov', 0,0,0,0], </c:if>
	       <c:if test="${12 le MTH}"> ['Dec',0,0,0,0], </c:if>		        
	 </c:if>
	  
        ]);
	
	var view = new google.visualization.DataView(data);
	 view.setColumns([0, 1,2,3]);
		 
      // Set chart options
 var options = {
				
		 titleTextStyle: {
		     color: '#000',
		     fontSize: 13,
		     fontName: 'Arial',
		     bold: true,
		    
		  },
		 vAxis: {title: 'Value'},
		 series: {
	            0: {targetAxisIndex: 0},	
	            1: {targetAxisIndex: 0,type: 'line'},
	            2: {targetAxisIndex: 0,type: 'line'}
	          },
	      'title':'Bank Loan Target for ${syrtemp} : <c:forEach var="ytm_tmp" items="${FINPOSSUM}"> <fmt:formatNumber type="number"   value="${ytm_tmp.fp_total[12]}"/></c:forEach> ', 
	      'vAxis': {title: 'Amount (In Millions)',titleTextStyle: {italic: false},format: 'short'},
	      seriesType: 'bars',
	      pointSize:2,
	      colors: ['#f69037','#0000FF','#0b1d39'],
		 'is3D':true,		  
		      'height': 230,
		      'legend': {
		        position: 'top'
		      },
		      hAxis: { slantedText:true, slantedTextAngle:90 },
	          tooltip: { textStyle: { fontName: 'verdana', fontSize: 12 } }
};

      

      // Instantiate and draw our chart, passing in some options.
      var chart = new google.visualization.ComboChart(document.getElementById('financialpositionchart_div'));
    
      chart.draw(data, options);
      google.visualization.events.addListener(chart, 'onmouseover', uselessHandlerbkfp2);
      google.visualization.events.addListener(chart, 'onmouseout', uselessHandlerbkfp3);
      google.visualization.events.addListener(chart, 'select', selectHandlerbk);
      function uselessHandlerbkfp2() {$('#financialpositionchart_div').css('cursor','pointer')}
      function uselessHandlerbkfp3() {$('#financialpositionchart_div').css('cursor','default')}
     function selectHandlerbk() {    	
    	 $('#fundingposition_moreinfo_modal').modal("show");    
      }
    }


 
    </script>


 </head>
 <c:choose>
 <c:when test="${!empty fjtuser.emp_code and !empty fjtuser.sales_code and (fjtuser.role eq 'mg' or fjtuser.salesDMYn ge 1 or fjtuser.sales_code eq 'AC005') and fjtuser.checkValidSession eq 1}">
 <c:set var="sales_egr_code" value="${fjtuser.sales_code}" scope="page" /> 
 <body class="hold-transition skin-blue sidebar-mini">
 <div class="container">
<div class="wrapper">

  <header class="main-header" style="background-color: #367fa9;">
    <!-- Logo -->   
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top" style="margin-left:0px;">
      <!-- Sidebar toggle button-->     
      
   <c:if test="${fjtuser.sales_code eq 'MG001' || fjtuser.sales_code eq 'MG002' || fjtuser.sales_code eq 'AC005'}">
     <form method="post" action="ConsolidatedReport">
     <div class="fj_mngmnt_dm_div pull-right">
   <select class="fj_mngmnt_dm_slctbx" name="dmCode" id="dmCode_mg" onchange="preLoader();this.form.submit()" required>
   <option>Select Division Managers </option>
   
  <c:forEach var="dm_List"  items="${DmsLstFMgmnt}" >					
		<option value="${dm_List.dmEmp_Code}" ${dm_List.dmEmp_Code  == DFLTDMCODE ? 'selected':''}> ${dm_List.dmEmp_name}</option>
  </c:forEach>
   </select>
   </div>
   <input type="hidden" name="fjtco" value="dmfsltdmd">
    <input type="hidden" name="dmCode" value="${DFLTDMCODE}">
   </form>
   </c:if>    
  
    </nav>
  </header>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper" style="margin-top: -8px;margin-left:0px;">

       
    <!-- Main content -->
    <div class="row">
    <form method="post" action="ConsolidatedReport">
    <div class="col-md-6" style="border:none;font-size:20px;margin-top:0px;padding:5px;padding-left:200px;">	
		<!--<c:choose>
			<c:when test="${DIVLISTS.size() > 0}">   -->
			<label for="religon" class="col-sm-4 control-label" style="padding-bottom:7px;padding-top:18px;font-size:17px"><h5>Select Division:</h5></label>
			 
			  <div class="select-items" style="padding-bottom:7px;padding-top:14px;">			  	
				   <select class="form-control form-control-sm" style="width:200px;height:40px;" name="divisionCode" id="dmCode_mg" onchange="preLoader();this.form.submit()" required>				     
					  <c:forEach var="dm_List"  items="${DIVLISTS}" >					
							<option value="${dm_List.division}" ${dm_List.division  == DFLTDVCODE ? 'selected':''}> ${dm_List.division}</option>
					  </c:forEach>
				   </select>
			   </div>
			<!--</c:when>
			<c:otherwise>
				<div class="fjtco-table" style="border:none;font-size:20px;margin-top:10px;padding:10px;font-style:bold;margin-left: 0px;color:#065685;">${DIVDEFTITL}</div>
			</c:otherwise>
		</c:choose>-->
 <!--   <input type="hidden" name="fjtco" value="divisiondtls">
    <input type="hidden" name="dmCode" value="${DFLTDMCODE}">
    <input type="hidden" name="divisionCode"> -->
    
 <!--   </form>
      <div class="fjtco-table" style="border:none;font-size:20px;margin-top:10px;padding:10px;font-style:bold;margin-left: 0px;color:#065685;">${DIVDEFTITL}</div>-->
   </div> 
    <div class="col-md-5" style="border:none;font-size:20px;margin-top:12px;padding:5px;padding-right:150px;">
    <label for="religon" class="col-sm-4 control-label" style="padding-bottom:7px;font-size:17px;padding-top:4px;"><h5>Select Year:</h5></label>
   	<!--  <form method="POST" id="requestform"   action="ConsolidatedReport"  class="seg-reg-form">  -->	   
		   <div class="select-items" style="padding-bottom:7px;"> 
					            <select class="form-control form-control-sm" style="width:129px;height:39px;" name="syear" id="syear" required onChange="preLoader();this.form.submit();">
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
						  			<input type="hidden" name="syear" />
						  			<input type="hidden" name="dmCode" value="${DFLTDMCODE}">
						  			<input type="hidden" name="divisionCode">
						  			<input type="hidden" name="fjtco" value="divisiondtls">
					        </div>  
					          					      
					 </div>
					 <div class="col-md-1" style="padding-top:25px;">
					 		 <a href="homepage.jsp" > <i class="fa fa-home pull-right" title="Home"></i></a> 
							 <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a>  
					 </div>
   		<!-- <div class="col-md-4 col-xs-12">
  		  <ul class="nav nav-tabs pull-left" style=" margin-top: 12px; border: 1px solid #3c8dbc;font-weight: bold;width: max-content !important;">      
          	<li class="active pull-right"><a data-toggle="tab" style="border-right:transparent;" href="#finance-dt">Financial Position</a></li>          
          </ul>
         </div> -->
         </form> 	    
   </div>
	   <div class="row"> <br/>   
     
        <div class="col-md-6">    
          <!-- Custom tabs (Charts with tabs)-->
				 <div class="box box-danger" style="margin-bottom: 8px;">
				            <div class="box-header with-border">
								<h3 class="box-title" >Working Capital - ${sdvsntemp}</h3>
							</div>
				            <div class="box-body">
				              <div id="workingcapitalchart_div" style="height:230px;margin-top:-10px;"></div>  
				              <br/>
				             <div class="overlay">
								<a href="#" data-toggle="modal" data-target="#workingcapital_moreinfo_modal">More info
								 <i class="fa fa-arrow-circle-right"></i></a> </div>
				            </div>
				            <!-- /.box-body -->
				          </div>
				          <!-- /.box -->
				
						<div class="box box-danger" style="margin-bottom: 8px;border-color:#607d8b;">
				           <div class="box-header with-border">
							<h3 class="box-title" >Financial Position - ${sdvsntemp}</h3>
							</div>
				            <div class="box-body">
				                <div class="chart">
				                    <div id="financialpositionchart_div" style="height:230px;margin-top:0px;"></div>  <br/>
				               <div class="overlay">
								<a href="#" data-toggle="modal" data-target="#fundingposition_moreinfo_modal">More info
								 <i class="fa fa-arrow-circle-right"></i></a> </div> 
				              </div> 
				            </div>
				            <!-- /.box-body -->
				          </div>
				        </div>
				     <div class="col-md-6">  
        
			         <!-- BILLING CHART -->
			          <div class="box box-success" style="margin-bottom: 8px;">
			        	 <div class="box-header with-border">
							<h3 class="box-title" >Funds Blocked - ${sdvsntemp}</h3>
							</div>
			            <div class="box-body">
			                <div id="fundsblockedchart_div" style="height:230px;margin-top:-10px;"></div>  
			                <br/>
			               <div class="overlay">
							<a href="#" data-toggle="modal" data-target="#fundsblocked_moreinfo_modal">More info
							 <i class="fa fa-arrow-circle-right"></i></a> </div> 
			             
			            </div>
			            <!-- /.box-body -->
			          </div>
			          <!-- /.billing box -->
			        	<!-- Forecast  -->
			       
			        <!-- /Forecast -->
			
			        </div>
			        
			        
<c:if test="${fjtuser.role eq 'mg' or fjtuser.emp_code eq 'E001977'}"> 	        
	 <div class="col-md-12 col-sm-12">
        <!-- TABLE: LATEST ORDERS -->
          <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">Consolidate Report For Year : <span id="bkmgDtlstime">${CURR_YR}</span> </h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
              </div>
            </div>
            <!-- /.box-header -->
            <div class="box-body">
             <div class="form-inline" style="padding-bottom:7px;"> 
             <select class="form-control form-control-sm" name="selyear" id="selyear" required>
             <option selected value="<%=iYear%>">Select Year</option>
              <%
                        // start year and end year in combo box to change year in calendar
                         for(int iy=iYear;iy>=2017;iy--)
                            {
                            
                             %>
                             <c:set var="syrtemp2" value="<%=iy%>" scope="page" />
                             <option value="<%=iy%>" ${syrtemp2  == selected_Year ? 'selected':''}> <%=iy%></option>
                            <%
                             
                        }
                        %>
             </select>
           <select class="form-control form-control-sm" name="scat" id="scat"  required>
                        <option selected value="Rec">Select Category</option>
  						<option  value="Rec">Receivables</option>
  						<option  value="Inv">Inventory</option>
  						<option  value="Pay">Payables</option>
  						<option  value="NetWC">Net. Working Capital</option>
  						<option  value="Rec1">Receivables 120-180 days</option>
  						<option  value="Rec2">Receivables 180-365 days</option>
  						<option  value="Rec3">Receivables > 365 days</option>
  						<option  value="Inv1">Inventory 120-180 days</option>
  						<option  value="Inv2">Inventory 180-365 days</option>
  						<option  value="Inv3">Inventory > 365 days</option>
  						<option  value="FB">Funds Blocked</option>
  						<option value="EC">Equity Capital</option>
  						<option value="ADVFC">Adv.from Customers</option>
  						<option value="BNKL">Bank Loan</option>
  			</select>
  			<input type="hidden" name="fjtco" value="frbwym" />
   			 <input type="button" value="Fetch" class="btn btn-primary form-control form-control-sm"  onclick="getRequestedDetails();"/> 
             </div>
             <div id="preLoadtablehead">
                <table id="weeklybkngrprt_table" class="table table-bordered table-striped small">
                  <thead>
                  <tr>
                    <th>Category</th>  <th>January</th> <th>February</th>  <th>March</th>  <th>April</th><th>May</th>  <th>June</th> <th>July</th><th>August</th><th>September</th><th>October</th><th>November</th><th>December</th>
                  </tr>
                  </thead>
                  <tbody>
                 <c:set var="bkng_count" value="0" scope="page" />
			
               
               
             
                  </tbody>
                  <tfoot align="right">
		          <tr><th style="text-align:left;color:blue;">Total:</th><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th></tr>
	              </tfoot>
                </table>
               </div>
            </div>
            <!-- /.box-body -->
           
           
          </div>
          <!-- /.box -->
        </div>

    </c:if>
        </div>
      </div>
      <!-- /.row -->
       <%--start  more info for Working capital --%>
        <div class="modal fade" id="workingcapital_moreinfo_modal" role="dialog">
							<div class="modal-dialog modal-lg">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="modal-title">Working Capital Details of ${sdvsntemp} for ${syrtemp}</h4>
									</div>

									<div class="modal-body">
										<div class="row">
											<table id="billing_modal_table">
												<thead> <tr> <th></th> 
												
														<c:choose> 
															<c:when test="${syrtemp ne CURR_YR}">	
															<th>Jan</th><th>Feb</th><th>Mar</th><th>Apr</th><th>May</th><th>Jun</th><th>Jul</th><th>Aug</th><th>Sep</th><th>Oct</th><th>Nov</th><th>Dec</th><th>Average</th> <th> Target</th>																										
															</c:when>
															<c:otherwise> 
																<c:if test="${1 le MTH}"> <th>Jan</th>  </c:if>
																<c:if test="${2 le MTH}"><th> Feb</th>   </c:if> 
																 <c:if test="${3 le MTH}"><th>Mar </th>  </c:if> 
																 <c:if test="${4 le MTH}"><th> Apr</th>   </c:if> 
																 <c:if test="${5 le MTH}"><th> May</th>   </c:if> 
																 <c:if test="${6 le MTH}"> <th>Jun</th>   </c:if> 
																 <c:if test="${7 le MTH}"><th> Jul </th>  </c:if> 
																 <c:if test="${8 le MTH}"><th> Aug </th>  </c:if> 
																 <c:if test="${9 le MTH}"><th> Sep</th>   </c:if> 
																 <c:if test="${10 le MTH}"><th> Oct</th>   </c:if> 
																 <c:if test="${11 le MTH}"><th> Nov</th>   </c:if> 
																 <c:if test="${12 le MTH}"><th> Dec</th>   </c:if> 
																 <th> Average</th>																 
																 <th> Target</th>
															</c:otherwise>
														 </c:choose>
	   												
	   												</tr> </thead>
												<tbody>  
													<c:forEach var="ytm_tmp" items="${WCCAPSUM}"> 	
														<c:choose> 
														<c:when test="${syrtemp ne CURR_YR}">												
														 <tr> <td>Receivables (A)</td> <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[0]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[1]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[2]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[3]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[4]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[5]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[6]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[7]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[8]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[9]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[10]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[11]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.averrec}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[12]}" /></td></tr>
														 <tr><td>Inventory (B)</td><td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[0]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[1]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[2]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[3]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[4]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[5]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[6]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[7]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[8]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[9]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[10]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[11]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.aveinv}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[12]}" /></td></tr>
														 <tr><td>Payables (C)</td> <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[0]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[1]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[2]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[3]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[4]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[5]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[6]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[7]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[8]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[9]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[10]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[11]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.avepay}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[12]}" /></td></tr>
														 <tr  style="font-weight:bold;font-family:Arial;background-color:yellow"><td>Net W.C (A+B-C)</td> <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctotal[0]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctotal[1]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctotal[2]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctotal[3]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctotal[4]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctotal[5]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctotal[6]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctotal[7]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctotal[8]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctotal[9]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctotal[10]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctotal[11]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wcavgtot}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctartot}" /></td></tr>
														 </c:when>
														 <c:otherwise>	
														     <tr> <td>Receivables (A)</td><c:if test="${1 le MTH}"> <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[0]}" /></td></c:if><c:if test="${2 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[1]}" /></td></c:if><c:if test="${3 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[2]}" /></td></c:if><c:if test="${4 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[3]}" /></td></c:if><c:if test="${5 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[4]}" /></td></c:if><c:if test="${6 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[5]}" /></td></c:if><c:if test="${7 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[6]}" /></td></c:if><c:if test="${8 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[7]}" /></td></c:if><c:if test="${9 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[8]}" /></td></c:if><c:if test="${10 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[9]}" /></td></c:if><c:if test="${11 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[10]}" /></td></c:if><c:if test="${12 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[11]}" /></td></c:if><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.averrec}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[12]}" /></td></tr>
															 <tr><td>Inventory (B)</td><c:if test="${1 le MTH}"> <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[0]}" /></td></c:if><c:if test="${2 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[1]}" /></td></c:if><c:if test="${3 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[2]}" /></td></c:if><c:if test="${4 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[3]}" /></td></c:if><c:if test="${5 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[4]}" /></td></c:if><c:if test="${6 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[5]}" /></td></c:if><c:if test="${7 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[6]}" /></td></c:if><c:if test="${8 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[7]}" /></td></c:if><c:if test="${9 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[8]}" /></td></c:if><c:if test="${10 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[9]}" /></td></c:if><c:if test="${11 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[10]}" /></td></c:if><c:if test="${12 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[11]}" /></td></c:if><td style="text-align:right"><fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.aveinv}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[12]}" /></td></tr>
															 <tr><td>Payables (C)</td><c:if test="${1 le MTH}"> <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[0]}" /></td></c:if><c:if test="${2 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[1]}" /></td></c:if><c:if test="${3 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[2]}" /></td></c:if><c:if test="${4 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[3]}" /></td></c:if><c:if test="${5 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[4]}" /></td></c:if><c:if test="${6 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[5]}" /></td></c:if><c:if test="${7 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[6]}" /></td></c:if><c:if test="${8 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[7]}" /></td></c:if><c:if test="${9 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[8]}" /></td></c:if><c:if test="${10 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[9]}" /></td></c:if><c:if test="${11 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[10]}" /></td></c:if><c:if test="${12 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[11]}" /></td></c:if><td style="text-align:right"><fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.avepay}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[12]}" /></td></tr>
															 <tr  style="font-weight:bold;font-family:Arial;background-color:yellow"><td>Net W.C (A+B-C)</td><c:if test="${1 le MTH}"> <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctotal[0]}" /></td></c:if><c:if test="${2 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctotal[1]}" /></td></c:if><c:if test="${3 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctotal[2]}" /></td></c:if><c:if test="${4 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctotal[3]}" /></td></c:if><c:if test="${5 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctotal[4]}" /></td></c:if><c:if test="${6 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctotal[5]}" /></td></c:if><c:if test="${7 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctotal[6]}" /></td></c:if><c:if test="${8 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctotal[7]}" /></td></c:if><c:if test="${9 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctotal[8]}" /></td></c:if><c:if test="${10 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctotal[9]}" /></td></c:if><c:if test="${11 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctotal[10]}" /></td></c:if><c:if test="${12 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctotal[11]}" /></td></c:if><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wcavgtot}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.wctartot}" /></td></tr>
														 </c:otherwise>
														 </c:choose>
													</c:forEach>
   												 </tbody>
												<!-- <thead> <tr> <th></th> <th>Receivables</th><th>Inventory</th><th>Payables</th><th>Net W.C</th></tr> </thead>
												<tbody>  
												<c:forEach var="ytm_tmp" items="${WCCAPSUM}"> <c:choose> <c:when test="${syrtemp ne CURR_YR}">
											          <tr><td style="text-align:right">January</td><td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.rec[0]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[0]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.pay[0]}" /></td></tr> 
											          <tr><td style="text-align:right">February</td><td style="text-align:right"><fmt:formatNumber pattern="#,###"  type = "number"  value="${ytm_tmp.rec[1]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.inv[1]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###"  type = "number"  value="${ytm_tmp.pay[1]}" /></td></tr> 
											          <tr><td style="text-align:right">March</td><td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.rec[2]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.inv[2]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.pay[2]}" /></td></tr>
											          <tr><td style="text-align:right">April</td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.rec[3]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.inv[3]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.pay[3]}" /></td></tr>
											          <tr><td style="text-align:right">May</td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.rec[4]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.inv[4]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.pay[4]}" /></td></tr>
											          <tr><td style="text-align:right">June</td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.rec[5]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.inv[5]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.pay[5]}" /></td></tr> 
											          <tr><td style="text-align:right">July</td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.rec[6]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.inv[6]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.pay[6]}" /></td></tr>  
											          <tr><td style="text-align:right">August</td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.rec[7]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.inv[7]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.pay[7]}" /></td></tr> 
											          <tr><td style="text-align:right">September</td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.rec[8]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.inv[8]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.pay[8]}" /></td></tr>
											          <tr><td style="text-align:right">October</td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.rec[9]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.inv[9]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.pay[9]}" /></td></tr>
											          <tr><td style="text-align:right">November</td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.rec[10]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.inv[10]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.pay[10]}" /></td></tr>
											         <tr><td style="text-align:right">December</td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.rec[11]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.inv[11]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number" value="${ytm_tmp.pay[11]}" /></td></tr>
											        
											          </c:when>
													  <c:otherwise> 
													  <c:if test="${1 le MTH}"> <tr><td style="text-align:right">January</td><td style="text-align:right"> <fmt:formatNumber pattern="#,###" value="${ytm_tmp.rec[0]}" /></td><td style="text-align:right"> <fmt:formatNumber pattern="#,###" value="${ytm_tmp.inv[0]}" /> </td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.pay[0]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.wctotal[0]}" /></td></tr>   </c:if>
											          <c:if test="${2 le MTH}"><tr><td style="text-align:right">February</td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.rec[1]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.inv[1]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.pay[1]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.wctotal[1]}" /></td></tr>  </c:if>
											          <c:if test="${3 le MTH}"><tr><td style="text-align:right">March</td><td style="text-align:right"> <fmt:formatNumber pattern="#,###" value="${ytm_tmp.rec[2]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.inv[2]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.pay[2]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.wctotal[2]}" /></td></tr> </c:if>
											          <c:if test="${4 le MTH}">  <tr><td style="text-align:right">April</td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.rec[3]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.inv[3]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.pay[3]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.wctotal[3]}" /></td></tr> </c:if>
											          <c:if test="${5 le MTH}"> <tr><td style="text-align:right">May</td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.rec[4]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.inv[4]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.pay[4]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.wctotal[4]}" /></td></tr> </c:if>
											          <c:if test="${6 le MTH}">  <tr><td style="text-align:right">June</td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.rec[5]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.inv[5]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.pay[5]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.wctotal[5]}" /></td></tr> </c:if>
											          <c:if test="${7 le MTH}"> <tr><td style="text-align:right">July</td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.rec[6]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.inv[6]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.pay[6]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.wctotal[6]}" /></td></tr>   </c:if>
											          <c:if test="${8 le MTH}"> <tr><td style="text-align:right">August</td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.rec[7]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.inv[7]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.pay[7]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.wctotal[7]}" /></td></tr> </c:if>
											          <c:if test="${9 le MTH}">  <tr><td style="text-align:right">September</td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.rec[8]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.inv[8]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.pay[8]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.wctotal[8]}" /></td></tr> </c:if>
											          <c:if test="${10 le MTH}"><tr><td style="text-align:right">October</td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.rec[9]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.inv[9]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.pay[9]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.wctotal[9]}" /></td></tr></c:if>
											          <c:if test="${11 le MTH}">  <tr><td style="text-align:right">November</td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.rec[10]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.inv[10]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.pay[10]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.wctotal[10]}" /></td></tr> </c:if>
											          <c:if test="${12 le MTH}"> <tr><td style="text-align:right">December</td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.rec[11]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.inv[11]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.pay[11]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" value="${ytm_tmp.wctotal[11]}" /></td></tr></c:if>
											          
													  </c:otherwise>
													  </c:choose>
   												</c:forEach>
						                     </tbody> -->
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
						<!-- End of working capital more info -->
						
						<!-- Start of funds blocked more info -->
						
						<div class="modal fade" id="fundsblocked_moreinfo_modal" role="dialog">
							<div class="modal-dialog modal-lg">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="modal-title">Blocked Funds Details of ${sdvsntemp} for ${syrtemp}</h4>
									</div>

									<div class="modal-body">
										<div class="row">
											<table id="booking_modal_table">
												<thead> <tr>
												<th></th>
														<c:choose> 
															<c:when test="${syrtemp ne CURR_YR}">	
															<th>Jan</th><th>Feb</th><th>Mar</th><th>Apr</th><th>May</th><th>Jun</th><th>Jul</th><th>Aug</th><th>Sep</th><th>Oct</th><th>Nov</th><th>Dec</th><th> Average</th>																 
																 <th> Target</th>																										
															</c:when>
															<c:otherwise> 
															
																<c:if test="${1 le MTH}"> <th>Jan</th>  </c:if>
																<c:if test="${2 le MTH}"><th> Feb</th>   </c:if> 
																 <c:if test="${3 le MTH}"><th>Mar </th>  </c:if> 
																 <c:if test="${4 le MTH}"><th> Apr</th>   </c:if> 
																 <c:if test="${5 le MTH}"><th> May</th>   </c:if> 
																 <c:if test="${6 le MTH}"> <th>Jun</th>   </c:if> 
																 <c:if test="${7 le MTH}"><th> Jul </th>  </c:if> 
																 <c:if test="${8 le MTH}"><th> Aug </th>  </c:if> 
																 <c:if test="${9 le MTH}"><th> Sep</th>   </c:if> 
																 <c:if test="${10 le MTH}"><th> Oct</th>   </c:if> 
																 <c:if test="${11 le MTH}"><th> Nov</th>   </c:if> 
																 <c:if test="${12 le MTH}"><th> Dec</th>   </c:if> 
																 <th> Average</th>																 
																 <th> Target</th>
															</c:otherwise>
														 </c:choose>	   												
	   												</tr> </thead>
												<tbody>  
													<c:forEach var="ytm_tmp" items="${FUNDSBLOCKEDSUM}"> 	
													<c:choose> 
													 <c:when test="${syrtemp ne CURR_YR}">		
													 	     <tr><td style="font-weight:bold;font-family:Arial">Receivables</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>							
													     	 <tr> <td>120-180 days</td>   <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[0]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[1]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[2]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[3]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[4]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[5]}" /></td> <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[6]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[7]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[8]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[9]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[10]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[11]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.avgrec1}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[12]}" /></td></tr>
															 <tr><td>180-365 days</td>   <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[0]}" /></td>    <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[1]}" /></td>    <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[2]}" /></td>    <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[3]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[4]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[5]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[6]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[7]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[8]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[9]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[10]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[11]}" /></td> <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.avgrec2}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[12]}" /></td></tr>
															 <tr><td> > 365days)/td>   <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[0]}" /></td>    <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[1]}" /></td>    <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[2]}" /></td>    <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[3]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[4]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[5]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[6]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[7]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[8]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[9]}" /></td> <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[10]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[11]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.avgrec3}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[12]}" /></td></tr>
															 <tr style="font-weight:bold;font-family:Arial;background-color:pink"><td>Total Receivables(A)</td>   <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotrec[0]}" /></td>    <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotrec[1]}" /></td>    <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotrec[2]}" /></td>    <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotrec[3]}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotrec[4]}" /></td> <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotrec[5]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotrec[6]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotrec[7]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotrec[8]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotrec[9]}" /></td> <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotrec[10]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotrec[11]}" /></td> <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.avgtotrec}" /></td><td style="text-align:right"><fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fbrectartot}" /></td> </tr>
															 <tr><td style="font-weight:bold;font-family:Arial">Inventory</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>	
															 <tr> <td>120-180 days</td>   <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[0]}" /></td>    <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[1]}" /></td>    <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[2]}" /></td>    <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[3]}" /></td>     <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[4]}" /></td>     <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[5]}" /></td>     <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[6]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[7]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[8]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[9]}" /></td> <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[10]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[11]}" /></td> <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.avginv1}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[12]}" /></td></tr>
															 <tr><td>180-365 days</td>   <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[0]}" /></td>    <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[1]}" /></td>    <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[2]}" /></td>    <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[3]}" /></td>     <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[4]}" /></td>     <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[5]}" /></td>     <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[6]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[7]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[8]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[9]}" /></td> <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[10]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[11]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.avginv2}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[12]}" /></td></tr>
															 <tr><td> > 365days</td>   <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[0]}" /></td>    <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[1]}" /></td>    <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[2]}" /></td>    <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[3]}" /></td>     <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[4]}" /></td>     <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[5]}" /></td>     <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[6]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[7]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[8]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[9]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[10]}" /></td> <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[11]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.avginv3}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[12]}" /></td></tr>
															 <tr style="font-weight:bold;font-family:Arial;background-color:pink"><td>Total Inventory(B)</td>   <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotinv[0]}" /></td>    <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotinv[1]}" /></td>    <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotinv[2]}" /></td>    <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotinv[3]}" /></td>     <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotinv[4]}" /></td>     <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotinv[5]}" /></td>     <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotinv[6]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotinv[7]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotinv[8]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotinv[9]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotinv[10]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotinv[11]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.avgtotinv}" /></td><td style="text-align:right"><fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fbinvtartot}" /></td></tr>
																										 
															 
															 <tr style="font-weight:bold;font-family:Arial;background-color:yellow"><td style="text-align:right">Total Funds Blocked (A+B)</td>   <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.totalbcfunds[0]}" /></td>    <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.totalbcfunds[1]}" /></td>    <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.totalbcfunds[2]}" /></td>    <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.totalbcfunds[3]}" /></td>     <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.totalbcfunds[4]}" /></td>     <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.totalbcfunds[5]}" /></td>     <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.totalbcfunds[6]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.totalbcfunds[7]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.totalbcfunds[8]}" /></td>   <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.totalbcfunds[9]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.totalbcfunds[10]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.totalbcfunds[11]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fbavgtot}" /></td>  <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fbtartot}" /> </td></tr>
													  </c:when>
													  <c:otherwise> 
													   <tr><td style="font-weight:bold;font-family:Arial">Receivables</td><c:if test="${1 le MTH}"> <td></td></c:if><c:if test="${2 le MTH}"> <td></td></c:if><c:if test="${3 le MTH}"> <td></td></c:if><c:if test="${4 le MTH}"> <td></td></c:if><c:if test="${5 le MTH}"> <td></td></c:if><c:if test="${6 le MTH}"> <td></td></c:if><c:if test="${7 le MTH}"> <td></td></c:if><c:if test="${8 le MTH}"> <td></td></c:if><c:if test="${9 le MTH}"> <td></td></c:if><c:if test="${110 le MTH}"> <td></td></c:if><c:if test="${11 le MTH}"> <td></td></c:if><c:if test="${12 le MTH}"> <td></td></c:if><td></td><td></td></tr>
													  	<tr><td>120-180 days</td><c:if test="${1 le MTH}"> <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[0]}" /></td></c:if><c:if test="${2 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[1]}" /></td></c:if><c:if test="${3 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[2]}" /></td></c:if><c:if test="${4 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[3]}" /></td></c:if><c:if test="${5 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[4]}" /></td></c:if><c:if test="${6 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[5]}" /></td></c:if><c:if test="${7 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[6]}" /></td></c:if><c:if test="${8 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[7]}" /></td></c:if><c:if test="${9 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[8]}" /></td></c:if><c:if test="${10 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[9]}" /></td></c:if><c:if test="${11 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[10]}" /></td></c:if><c:if test="${12 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[11]}" /></td></c:if><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.avgrec1}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec120180[12]}" /></td></tr>
														 <tr><td>180-365 days</td><c:if test="${1 le MTH}"> <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[0]}" /></td></c:if><c:if test="${2 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[1]}" /></td></c:if><c:if test="${3 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[2]}" /></td></c:if><c:if test="${4 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[3]}" /></td></c:if><c:if test="${5 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[4]}" /></td></c:if><c:if test="${6 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[5]}" /></td></c:if><c:if test="${7 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[6]}" /></td></c:if><c:if test="${8 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[7]}" /></td></c:if><c:if test="${9 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[8]}" /></td></c:if><c:if test="${10 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[9]}" /></td></c:if><c:if test="${11 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[10]}" /></td></c:if><c:if test="${12 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[11]}" /></td></c:if><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.avgrec2}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec180365[12]}" /></td></tr>
														 <tr><td> > 365days</td><c:if test="${1 le MTH}"> <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[0]}" /></td></c:if><c:if test="${2 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[1]}" /></td></c:if><c:if test="${3 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[2]}" /></td></c:if><c:if test="${4 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[3]}" /></td></c:if><c:if test="${5 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[4]}" /></td></c:if><c:if test="${6 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[5]}" /></td></c:if><c:if test="${7 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[6]}" /></td></c:if><c:if test="${8 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[7]}" /></td></c:if><c:if test="${9 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[8]}" /></td></c:if><c:if test="${10 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[9]}" /></td></c:if><c:if test="${11 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[10]}" /></td></c:if><c:if test="${12 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[11]}" /></td></c:if><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.avgrec3}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfrec366[12]}" /></td></tr>
														 <tr style="font-weight:bold;font-family:Arial;background-color:pink"><td>Total Receivables(A)</td><c:if test="${1 le MTH}"> <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotrec[0]}" /></td></c:if><c:if test="${2 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotrec[1]}" /></td></c:if><c:if test="${3 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotrec[2]}" /></td></c:if><c:if test="${4 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotrec[3]}" /></td></c:if><c:if test="${5 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotrec[4]}" /></td></c:if><c:if test="${6 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotrec[5]}" /></td></c:if><c:if test="${7 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotrec[6]}" /></td></c:if><c:if test="${8 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotrec[7]}" /></td></c:if><c:if test="${9 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotrec[8]}" /></td></c:if><c:if test="${10 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotrec[9]}" /></td></c:if><c:if test="${11 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotrec[10]}" /></td></c:if><c:if test="${12 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotrec[11]}" /></td></c:if><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.avgtotrec}" /></td><td style="text-align:right"><fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fbrectartot}" /></td></tr>
														<tr><td style="font-weight:bold;font-family:Arial">Inventory</td><c:if test="${1 le MTH}"> <td></td></c:if><c:if test="${2 le MTH}"> <td></td></c:if><c:if test="${3 le MTH}"> <td></td></c:if><c:if test="${4 le MTH}"> <td></td></c:if><c:if test="${5 le MTH}"> <td></td></c:if><c:if test="${6 le MTH}"> <td></td></c:if><c:if test="${7 le MTH}"> <td></td></c:if><c:if test="${8 le MTH}"> <td></td></c:if><c:if test="${9 le MTH}"> <td></td></c:if><c:if test="${110 le MTH}"> <td></td></c:if><c:if test="${11 le MTH}"> <td></td></c:if><c:if test="${12 le MTH}"> <td></td></c:if><td></td><td></td></tr>
														 <tr><td>120-180 days</td><c:if test="${1 le MTH}"> <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[0]}" /></td></c:if><c:if test="${2 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[1]}" /></td></c:if><c:if test="${3 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[2]}" /></td></c:if><c:if test="${4 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[3]}" /></td></c:if><c:if test="${5 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[4]}" /></td></c:if><c:if test="${6 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[5]}" /></td></c:if><c:if test="${7 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[6]}" /></td></c:if><c:if test="${8 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[7]}" /></td></c:if><c:if test="${9 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[8]}" /></td></c:if><c:if test="${10 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[9]}" /></td></c:if><c:if test="${11 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[10]}" /></td></c:if><c:if test="${12 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[11]}" /></td></c:if><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.avginv1}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv120180[12]}" /></td></tr>
														 <tr><td>180-365 days</td><c:if test="${1 le MTH}"> <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[0]}" /></td></c:if><c:if test="${2 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[1]}" /></td></c:if><c:if test="${3 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[2]}" /></td></c:if><c:if test="${4 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[3]}" /></td></c:if><c:if test="${5 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[4]}" /></td></c:if><c:if test="${6 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[5]}" /></td></c:if><c:if test="${7 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[6]}" /></td></c:if><c:if test="${8 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[7]}" /></td></c:if><c:if test="${9 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[8]}" /></td></c:if><c:if test="${10 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[9]}" /></td></c:if><c:if test="${11 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[10]}" /></td></c:if><c:if test="${12 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[11]}" /></td></c:if><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.avginv2}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv180365[12]}" /></td></tr>
														 <tr><td> > 365days</td><c:if test="${1 le MTH}"> <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[0]}" /></td></c:if><c:if test="${2 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[1]}" /></td></c:if><c:if test="${3 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[2]}" /></td></c:if><c:if test="${4 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[3]}" /></td></c:if><c:if test="${5 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[4]}" /></td></c:if><c:if test="${6 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[5]}" /></td></c:if><c:if test="${7 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[6]}" /></td></c:if><c:if test="${8 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[7]}" /></td></c:if><c:if test="${9 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[8]}" /></td></c:if><c:if test="${10 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[9]}" /></td></c:if><c:if test="${11 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[10]}" /></td></c:if><c:if test="${12 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[11]}" /></td></c:if><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.avginv3}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bfinv366[12]}" /></td></tr>
														 <tr style="font-weight:bold;font-family:Arial;background-color:pink"><td>Total Inventory(B)</td><c:if test="${1 le MTH}"> <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotinv[0]}" /></td></c:if><c:if test="${2 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotinv[1]}" /></td></c:if><c:if test="${3 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotinv[2]}" /></td></c:if><c:if test="${4 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotinv[3]}" /></td></c:if><c:if test="${5 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotinv[4]}" /></td></c:if><c:if test="${6 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotinv[5]}" /></td></c:if><c:if test="${7 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotinv[6]}" /></td></c:if><c:if test="${8 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotinv[7]}" /></td></c:if><c:if test="${9 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotinv[8]}" /></td></c:if><c:if test="${10 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotinv[9]}" /></td></c:if><c:if test="${11 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotinv[10]}" /></td></c:if><c:if test="${12 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.bftotinv[11]}" /></td></c:if><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.avgtotinv}" /></td><td style="text-align:right"><fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fbinvtartot}" /></td></tr>
														 											 
														 
														 <tr style="font-weight:bold;font-family:Arial;background-color:yellow"><td>Total Funds Blocked (A+B)</td><c:if test="${1 le MTH}"> <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.totalbcfunds[0]}" /></td></c:if><c:if test="${2 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.totalbcfunds[1]}" /></td></c:if><c:if test="${3 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.totalbcfunds[2]}" /></td></c:if><c:if test="${4 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.totalbcfunds[3]}" /></td></c:if><c:if test="${5 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.totalbcfunds[4]}" /></td></c:if><c:if test="${6 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.totalbcfunds[5]}" /></td></c:if><c:if test="${7 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.totalbcfunds[6]}" /></td></c:if><c:if test="${8 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.totalbcfunds[7]}" /></td></c:if><c:if test="${9 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.totalbcfunds[8]}" /></td></c:if><c:if test="${10 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.totalbcfunds[9]}" /></td></c:if><c:if test="${11 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.totalbcfunds[10]}" /></td></c:if><c:if test="${12 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.totalbcfunds[11]}" /></td></c:if><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fbavgtot}" /></td><td style="text-align:right"><fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fbtartot}" /></td></tr>
													  
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
					 	<!-- End of funds blocked more info -->
					 	
					 	
					 	<!-- Start of funds blocked more info -->
						
						<div class="modal fade" id="fundingposition_moreinfo_modal" role="dialog">
							<div class="modal-dialog modal-lg">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="modal-title">Financial Position of ${sdvsntemp} for ${syrtemp}</h4>
									</div>

									<div class="modal-body">
										<div class="row">
											<table id="lost_modal_table">
														<thead> <tr> <th></th> 
												
														<c:choose> 
															<c:when test="${syrtemp ne CURR_YR}">	
															<th>Jan</th><th>Feb</th><th>Mar</th><th>Apr</th><th>May</th><th>Jun</th><th>Jul</th><th>Aug</th><th>Sep</th><th>Oct</th><th>Nov</th><th>Dec</th> <th> Average</th>																 
																 <th> Target</th>																										
															</c:when>
															<c:otherwise> 
																<c:if test="${1 le MTH}"> <th>Jan</th>  </c:if>
																<c:if test="${2 le MTH}"><th> Feb</th>   </c:if> 
																 <c:if test="${3 le MTH}"><th>Mar </th>  </c:if> 
																 <c:if test="${4 le MTH}"><th> Apr</th>   </c:if> 
																 <c:if test="${5 le MTH}"><th> May</th>   </c:if> 
																 <c:if test="${6 le MTH}"> <th>Jun</th>   </c:if> 
																 <c:if test="${7 le MTH}"><th> Jul </th>  </c:if> 
																 <c:if test="${8 le MTH}"><th> Aug </th>  </c:if> 
																 <c:if test="${9 le MTH}"><th> Sep</th>   </c:if> 
																 <c:if test="${10 le MTH}"><th> Oct</th>   </c:if> 
																 <c:if test="${11 le MTH}"><th> Nov</th>   </c:if> 
																 <c:if test="${12 le MTH}"><th> Dec</th>   </c:if> 
																  <th> Average</th>																 
																 <th> Target</th>
															</c:otherwise>
														 </c:choose>
	   												
	   												</tr> </thead>
												<tbody>  
													<c:forEach var="ytm_tmp" items="${FINPOSSUM}"> 	
													<c:choose> <c:when test="${syrtemp ne CURR_YR}">												
														 <tr> <td>Working Capital (A)</td>  <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[0]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[1]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[2]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[3]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[4]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[5]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[6]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[7]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[8]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[9]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[10]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[11]}" /></td> <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.avgfpwc}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[12]}" /></td></tr>
														 <tr><td>Equity Capital (B)</td>  <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[0]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[1]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[2]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[3]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[4]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[5]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[6]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[7]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[8]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[9]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[10]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[11]}" /></td> <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.avgfpec}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[12]}" /></td></tr>
														 <tr><td>Advance from Customers (C)</td>  <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[0]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[1]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[2]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[3]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[4]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[5]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[6]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[7]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[8]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[9]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[10]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[11]}" /></td> <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.avgfpadv}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[12]}" /></td></tr>
														 <tr  style="font-weight:bold;font-family:Arial;background-color:#dd4b39"><td>Bank Loan Total (A-B-C)</td>  <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_total[0]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_total[1]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_total[2]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_total[3]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_total[4]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_total[5]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_total[6]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_total[7]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_total[8]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_total[9]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_total[10]}" /></td>  <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_total[11]}" /></td> <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fpavgtot}" /></td><td style="text-align:right"><fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fptartot}" /></td></tr>
														   </c:when>
													  <c:otherwise>
													  	 <tr> <td>Working Capital (A)</td><c:if test="${1 le MTH}"> <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[0]}" /></td></c:if><c:if test="${2 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[1]}" /></td></c:if><c:if test="${3 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[2]}" /></td></c:if><c:if test="${4 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[3]}" /></td></c:if><c:if test="${5 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[4]}" /></td></c:if><c:if test="${6 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[5]}" /></td></c:if><c:if test="${7 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[6]}" /></td></c:if><c:if test="${8 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[7]}" /></td></c:if><c:if test="${9 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[8]}" /></td></c:if><c:if test="${10 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[9]}" /></td></c:if><c:if test="${11 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[10]}" /></td></c:if><c:if test="${12 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[11]}" /></td></c:if><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.avgfpwc}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_wc[12]}" /></td></tr>
														 <tr><td>Equity Capital (B)</td><c:if test="${1 le MTH}"> <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[0]}" /></td></c:if><c:if test="${2 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[1]}" /></td></c:if><c:if test="${3 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[2]}" /></td></c:if><c:if test="${4 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[3]}" /></td></c:if><c:if test="${5 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[4]}" /></td></c:if><c:if test="${6 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[5]}" /></td></c:if><c:if test="${7 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[6]}" /></td></c:if><c:if test="${8 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[7]}" /></td></c:if><c:if test="${9 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[8]}" /></td></c:if><c:if test="${10 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[9]}" /></td></c:if><c:if test="${11 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[10]}" /></td></c:if><c:if test="${12 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[11]}" /></td></c:if><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.avgfpec}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_ec[12]}" /></td></tr>
														 <tr><td>Advance from Customers (C)</td><c:if test="${1 le MTH}"> <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[0]}" /></td></c:if><c:if test="${2 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[1]}" /></td></c:if><c:if test="${3 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[2]}" /></td></c:if><c:if test="${4 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[3]}" /></td></c:if><c:if test="${5 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[4]}" /></td></c:if><c:if test="${6 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[5]}" /></td></c:if><c:if test="${7 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[6]}" /></td></c:if><c:if test="${8 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[7]}" /></td></c:if><c:if test="${9 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[8]}" /></td></c:if><c:if test="${10 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[9]}" /></td></c:if><c:if test="${11 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[10]}" /></td></c:if><c:if test="${12 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[11]}" /></td></c:if><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.avgfpadv}" /></td><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_adv[12]}" /></td></tr>
														 <tr  style="font-weight:bold;font-family:Arial;background-color:#dd4b39"><td>Bank Loan Total (A-B-C)</td><c:if test="${1 le MTH}"> <td style="text-align:right"> <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_total[0]}" /></td></c:if><c:if test="${2 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_total[1]}" /></td></c:if><c:if test="${3 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_total[2]}" /></td></c:if><c:if test="${4 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_total[3]}" /></td></c:if><c:if test="${5 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_total[4]}" /></td></c:if><c:if test="${6 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_total[5]}" /></td></c:if><c:if test="${7 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_total[6]}" /></td></c:if><c:if test="${8 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_total[7]}" /></td></c:if><c:if test="${9 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_total[8]}" /></td></c:if><c:if test="${10 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_total[9]}" /></td></c:if><c:if test="${11 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_total[10]}" /></td></c:if><c:if test="${12 le MTH}"><td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fp_total[11]}" /></td></c:if> <td style="text-align:right">  <fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fpavgtot}" /></td><td style="text-align:right"><fmt:formatNumber pattern="#,###" type = "number"  value="${ytm_tmp.fptartot}" /></td></tr>
													  </c:otherwise>
													  </c:choose> 
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
						
					 	<!-- End of funds blocked more info -->
			<div id="laoding" class="loader" ><img src="resources/images/wait.gif"></div>
     
      <!-- /.row -->

    
    <!-- /.content -->

  <!-- /.content-wrapper -->
  <footer class="main-footer" style="margin-left:0px;">
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


    
   /* On account outstandng rcvbls END */
$(document).ready(function() {
	
	  
	  var billingTtl="Working Capital Details  of  Division ${DIVDEFTITL}";	
	  var bookingTtl="Blocked Funds Details  of Division  ${DIVDEFTITL}";
	  var lostTtl="Financial Position Details  of Division  ${DIVDEFTITL} ";

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
	                messageBottom: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
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
	                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 1em;">Export</i>',
	                filename: lostTtl,
	                title: lostTtl,
	                messageBottom: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
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
	                messageBottom: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	          
	           
	        ]
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
function getRequestedDetails(){
	var iSlctCate = $('#scat').find(":selected").val();
	var iSlctYear = $('#selyear').find(":selected").val();	
	
	 var undefndValue_1="-", undefndValue_2="-", undefndValue_3="-", undefndValue_4="-",undefndValue_5="-",undefndValue_6="-", undefndValue_7="-", undefndValue_8="-", undefndValue_9="-", 
	 undefndValue_10="-", undefndValue_11="-", undefndValue_12="-",undefndValue_13="-";
	 const d = new Date();
	 let month = d.getMonth();
	 let year = d.getFullYear();	
		if(year != iSlctYear){
			month =  12;
		}
	alert(month);
	//if(iSlctCate == 'Rec' || iSlctCate == 'Inv' || iSlctCate == 'Pay' || ){    
		$.ajax({ type: 'POST', url: 'ConsolidatedReport', 
			 data: {fjtco: "getReqDet",scat:iSlctCate,syear:iSlctYear,dmcode:'${DFLTDMCODE}'}, 
			 dataType: "json", 
			 success: function(data) {
				 var output="<table id='weeklybkngrprt_table' class='table table-bordered table-striped small'> "+
		             "<thead><tr> <th>Category</th> <th>Jan</th> <th>Feb</th><th>Mar</th>"+
	                 "<th>Apr</th><th>May</th><th>Jun</th>"+
	                 "<th>Jul</th><th>Aug</th>"+ "<th>Sep</th>"+ "<th>Oct</th><th>Nov</th>"+ "<th>Dec</th>"+ "<th>Avg</th>"+"<th>Target</th>"+
	                 "</tr></thead><tbody>";  
	                
	  	          for (var i in data) {	 
	  	        	 
	  	        	  var undefndAvgValue_14=0;
	  	        	  if (typeof data[i].jan !== 'undefined'){undefndValue_1 = formatNumber(Math.round(data[i].jan));undefndAvgValue_14 = undefndAvgValue_14+(Math.round(data[i].jan))} else {undefndValue_1="0";}
	  	        	  if (typeof data[i].feb !== 'undefined'){undefndValue_2= formatNumber(Math.round(data[i].feb));undefndAvgValue_14 = undefndAvgValue_14+(Math.round(data[i].feb))} else {undefndValue_2="0";}
	  	        	  if (typeof data[i].mar !== 'undefined'){undefndValue_3=formatNumber(Math.round(data[i].mar));undefndAvgValue_14 = undefndAvgValue_14+(Math.round(data[i].mar))} else {undefndValue_3="0";}
	  	        	  if (typeof data[i].apr !== 'undefined'){undefndValue_4=formatNumber(Math.round(data[i].apr));undefndAvgValue_14 = undefndAvgValue_14+(Math.round(data[i].apr))} else {undefndValue_4="0";}
	  	        	  if (typeof data[i].may !== 'undefined'){undefndValue_5=formatNumber(Math.round(data[i].may));undefndAvgValue_14 = undefndAvgValue_14+(Math.round(data[i].may))} else {undefndValue_5="0";}
	  	        	  if (typeof data[i].jun !== 'undefined'){undefndValue_6=formatNumber(Math.round(data[i].jun));undefndAvgValue_14 = undefndAvgValue_14+(Math.round(data[i].jun))} else {undefndValue_6="0";}
	  	        	  if (typeof data[i].jul !== 'undefined'){undefndValue_7=formatNumber(Math.round(data[i].jul));undefndAvgValue_14 = undefndAvgValue_14+(Math.round(data[i].jul))} else {undefndValue_7="0";}
	  	        	  if (typeof data[i].aug !== 'undefined'){undefndValue_8=formatNumber(Math.round(data[i].aug));undefndAvgValue_14 = undefndAvgValue_14+(Math.round(data[i].aug))} else {undefndValue_8="0";}
	  	        	  if (typeof data[i].sep !== 'undefined'){undefndValue_9=formatNumber(Math.round(data[i].sep));undefndAvgValue_14 = undefndAvgValue_14+(Math.round(data[i].sep))} else {undefndValue_9="0";}
	  	        	  if (typeof data[i].oct !== 'undefined'){undefndValue_10=formatNumber(Math.round(data[i].oct));undefndAvgValue_14 = undefndAvgValue_14+(Math.round(data[i].oct))} else {undefndValue_10="0";}
	  	        	  if (typeof data[i].nov !== 'undefined'){undefndValue_11=formatNumber(Math.round(data[i].nov));undefndAvgValue_14 = undefndAvgValue_14+(Math.round(data[i].nov))} else {undefndValue_11="0";}
	  	        	  if (typeof data[i].dec !== 'undefined'){undefndValue_12=formatNumber(Math.round(data[i].dec));undefndAvgValue_14 = undefndAvgValue_14+(Math.round(data[i].dec))} else {undefndValue_12="0";}	
	  	        	  if (typeof data[i].ytm_target !== 'undefined'){undefndValue_13=formatNumber(Math.round(data[i].ytm_target))} else {undefndValue_13="0";}	
	  	        	
			  	      output+="<tr><td>" + data[i].division + "</td>"+"<td style='text-align:right'>" + undefndValue_1 + "</td><td style='text-align:right'>" + undefndValue_2 +"</td>"+ "<td style='text-align:right'>" + undefndValue_3 + "</td>"+
			  		   	"<td style='text-align:right'>" + undefndValue_4 + "</td>"+"<td style='text-align:right'>" + undefndValue_5 + "</td><td style='text-align:right'>" + undefndValue_6 + "</td>"+ "<td style='text-align:right'>" + undefndValue_7 + "</td>"+ "<td style='text-align:right'>" + undefndValue_8 + "</td>"+
			  		    "<td style='text-align:right'>" + undefndValue_9 + "</td>"+"<td style='text-align:right'>" + undefndValue_10 + "</td>"+"<td style='text-align:right'>" + undefndValue_11 + "</td>"+"<td style='text-align:right'>" + undefndValue_12 + "</td>"+"<td style='text-align:right'>" + formatNumber(Math.round(undefndAvgValue_14/month)) + "</td>"+"<td style='text-align:right'>" + undefndValue_13 + "</td>"+
			  		   	"</tr>"; 
				  	  } 
				  	          output+="<tfoot align='right'>"+
				  	          "<tr><th style='text-align:left;color:blue;'>Total:</th><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th><th></th></tr>"+
				              "</tfoot>"+
				              "</tbody></table>";

	  	   	// $("#preLoadtablehead").html(output);	
				  $("#preLoadtablehead").html(output); 
				  
				  $('#weeklybkngrprt_table').DataTable( {
				        dom: 'Bfrtip', "paging":   false,  "ordering": false,  "info":     false,  "searching": false,
				     
				        buttons: [
				            {
				                extend: 'excelHtml5',
				                text:      '<i class="fa fa-file-excel-o" style="color: red; font-size: 1em;">Export</i>',
				                filename: 'Consolidate Report Of '+data[i].category+' For Year ('+iSlctYear+')  ',
				                title: 'Consolidate Report Of '+data[i].category+' For Year ('+iSlctYear+')  ',
				                messageBottom: 'The information in this file is copyright to Faisal Jassim Group.'
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
			                .column( 1 )
			                .data()
			                .reduce( function (a, b) {
			                    return intVal(a) + intVal(b);
			                }, 0 );
			            
			            var total2 = api
		               .column( 2 )
		               .data()
		               .reduce( function (a, b) {
		                   return intVal(a) + intVal(b);
		               }, 0 );
			            
			            var total3 = api
		               .column( 3 )
		               .data()
		               .reduce( function (a, b) {
		                   return intVal(a) + intVal(b);
		               }, 0 );
			            
			            var total4 = api
		               .column( 4 )
		               .data()
		               .reduce( function (a, b) {
		                   return intVal(a) + intVal(b);
		               }, 0 );
		           
		           var total5 = api
		           .column( 5 )
		           .data()
		           .reduce( function (a, b) {
		               return intVal(a) + intVal(b);
		           }, 0 );
		           var total6 = api
		           .column( 6 )
		           .data()
		           .reduce( function (a, b) {
		               return intVal(a) + intVal(b);
		           }, 0 );
		           var total7 = api
		           .column( 7 )
		           .data()
		           .reduce( function (a, b) {
		               return intVal(a) + intVal(b);
		           }, 0 );
		           var total8 = api
		           .column( 8 )
		           .data()
		           .reduce( function (a, b) {
		               return intVal(a) + intVal(b);
		           }, 0 );
		           var total9 = api
		           .column( 9 )
		           .data()
		           .reduce( function (a, b) {
		               return intVal(a) + intVal(b);
		           }, 0 );
		           var total10 = api
		           .column( 10 )
		           .data()
		           .reduce( function (a, b) {
		               return intVal(a) + intVal(b);
		           }, 0 );
		           var total11 = api
		           .column( 11 )
		           .data()
		           .reduce( function (a, b) {
		               return intVal(a) + intVal(b);
		           }, 0 );
		           var total12 = api
		           .column( 12 )
		           .data()
		           .reduce( function (a, b) {
		               return intVal(a) + intVal(b);
		           }, 0 );
		           var total13 = api
		           .column( 13 )
		           .data()
		           .reduce( function (a, b) {
		               return intVal(a) + intVal(b);
		           }, 0 );
		           var total14 = api
		           .column( 14 )
		           .data()
		           .reduce( function (a, b) {
		               return intVal(a) + intVal(b);
		           }, 0 );
		           
		        
			        
			            // Update footer
			                     $( api.column(1).footer()).html(formatNumber(Math.round(total1)));
			                     $( api.column(2).footer()).html(formatNumber(Math.round(total2)));
			                     $( api.column(3).footer()).html(formatNumber(Math.round(total3)));
			                     $( api.column(4).footer()).html(formatNumber(Math.round(total4)));
			            		 $( api.column(5).footer()).html(formatNumber(Math.round(total5)));
			            		 $( api.column(6).footer()).html(formatNumber(Math.round(total6)));
			                     $( api.column(7).footer()).html(formatNumber(Math.round(total7)));
			                     $( api.column(8).footer()).html(formatNumber(Math.round(total8)));
			                     $( api.column(9).footer()).html(formatNumber(Math.round(total9)));
			            		 $( api.column(10).footer()).html(formatNumber(Math.round(total10)));
			            		 $( api.column(11).footer()).html(formatNumber(Math.round(total11)));
			                     $( api.column(12).footer()).html(formatNumber(Math.round(total12)));
			            		 $( api.column(13).footer()).html(formatNumber(Math.round(total13)));
			            		 $( api.column(14).footer()).html(formatNumber(Math.round(total14)));
			            
			        }
		  
				      } );  
			 },error:function(data,status,er) { 
				  table +="</tboady></table>";
				  alert("please logout and login, then try again");  
				 }
		}); 
	//}
		  
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