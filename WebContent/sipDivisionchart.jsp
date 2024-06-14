<%-- 
    Document   : SIP DIVISION DASHBAORD  
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="mainview.jsp"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%
	DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
	Calendar cal = Calendar.getInstance();
	int month = cal.get(Calendar.MONTH) + 1;
	int iYear = cal.get(Calendar.YEAR);
	String curr_month_name = "JANUARY";
	String currCalDtTime = dateFormat.format(cal.getTime());
	switch (month) {
		case 1 :
			curr_month_name = "Jan";
			break;
		case 2 :
			curr_month_name = "Feb";
			break;
		case 3 :
			curr_month_name = "Mar";
			break;
		case 4 :
			curr_month_name = "Apr";
			break;
		case 5 :
			curr_month_name = "May";
			break;
		case 6 :
			curr_month_name = "Jun";
			break;
		case 7 :
			curr_month_name = "Jul";
			break;
		case 8 :
			curr_month_name = "Aug";
			break;
		case 9 :
			curr_month_name = "Sep";
			break;
		case 10 :
			curr_month_name = "Oct";
			break;
		case 11 :
			curr_month_name = "Nov";
			break;
		case 12 :
			curr_month_name = "Dec";
			break;

	}
	request.setAttribute("currCal", currCalDtTime);
	request.setAttribute("MTH", month);
	request.setAttribute("CURR_YR", iYear);
	request.setAttribute("CURR_MTH", curr_month_name);
%>
<!DOCTYPE html>
<html>
<head>
<style>
#onaccnt-third-layer .modal-dialog, #modal-third-layer-invc .modal-dialog, #modal-third-layer-so .modal-dialog,
	#modal-third-layer-qtn .modal-dialog, #modal-third-layer .modal-dialog,
	#modal-graph .modal-dialog, .modal-content { /* 80% of window height */
	/* height: 80%;*/
	height: calc(100% - 20%);
}

#onaccnt-third-layer .modal-body, #modal-third-layer-invc .modal-body, #modal-third-layer-so .modal-body,
	#modal-third-layer-qtn .modal-body, #modal-third-layer .modal-body,
	#modal-graph .modal-body {
	/* 100% = dialog height, 120px = header + footer */
	max-height: calc(100% - 120px);
	overflow-y: scroll;
	overflow-x: scroll;
}

.modal-body th {
	font-weight: bold;
}

#modal-graph .modal-footer {
	padding: 2px 15px 15px 15px !important;
}

.loader {
	position: fixed;
	z-index: 999;
	height: 2em;
	width: 2em;
	overflow: show;
	margin: auto;
	top: 0;
	left: 0;
	bottom: 0;
	right: 0;
}

.loader:before {
	content: '';
	display: block;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.3);
}

.small-box {
	border-radius: 2px;
	position: relative;
	display: block;
	margin-top: 10px;
	box-shadow: 0 1px 1px rgba(0, 0, 0, 0.1);
}

.bg-red {
	background-color: #3b80a9 !important;
	color: #fff !important;
}

.small-box>.small-box-footer {
	position: relative;
	text-align: center;
	padding: 3px 0;
	color: #fff;
	color: rgba(255, 255, 255, 0.8);
	display: block;
	z-index: 10;
	background: rgba(0, 0, 0, 0.1);
	text-decoration: none;
}

.small-box .icon {
	-webkit-transition: all .3s linear;
	-o-transition: all .3s linear;
	transition: all .3s linear;
	position: absolute;
	top: 5px;
	right: 10px;
	z-index: 0;
	font-size: 75px;
	color: rgba(0, 0, 0, 0.15);
}

.small-box p {
	z-index: 5;
}

.small-box p {
	font-size: 15px;
}

.small-box>.inner {
	padding: 10px;
}

.small-box h3, .small-box p {
	z-index: 5;
}

.small-box h3 {
	font-size: 2em;
	
	margin: 0 0 10px 0;
	white-space: nowrap;
	padding: 0;
}

#chart_div, #prf_summ_billing_ytd, #prf_summ_booking_ytd, #stages {
	position: relative;
	border-radius: 3px;
	border-top: 3px solid #065685;
	margin-bottom: 20px;
	box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.16), 0 2px 10px 0
		rgba(0, 0, 0, 0.12);
}

.stage {
	background-color: #065685;
	color: white;
	border: 1px solid #065685;
}

.navbar {
	margin-bottom: 8px !important;
}

.table {
	display: block !important;
	overflow-x: auto !important;
}

#db-title-boxx {
	background: white;
	height: auto;;
	margin-top: -9px;
	margin-left: -10px;
	margin-right: -10px;
	box-shadow: 0 0 4px rgba(0, 0, 0, .14), 0 4px 8px rgba(0, 0, 0, .28);
}

.google-visualization-table-table {
	font-family: serif !important;
	font-size: 12pt !important;
	border-spacing: 5px !important;
}

.tab-content>.active {
	margin-top: 10px !important;
}

#jihv_table-dt {
	height: 310px !important;
}

.table>caption+thead>tr:first-child>td, .table>caption+thead>tr:first-child>th,
	.table>colgroup+thead>tr:first-child>td, .table>colgroup+thead>tr:first-child>th,
	.table>thead:first-child>tr:first-child>td, .table>thead:first-child>tr:first-child>th
	{
	color: #0000ff !important;
}

table.dataTable tfoot td {
	color: blue !important;
	font-weight: bold;
}

.pagination>li>a, .pagination>li>span {
	border: 1px solid red !important;
}

.fjtco-table {
	/* background-color: #ffff; */
	background-color: #e5f0f7;
	padding: 0.01em 16px;
	margin: 20px 0;
	box-shadow: 0 2px 4px 0 rgba(0, 0, 0, 0.16), 0 2px 10px 0
		rgba(0, 0, 0, 0.12) !important;
}

.main-header {
	z-index: 851 !important;
}

#stages-dt .col-lg-6 {margin-top: -5px;}
#stages-dt .small-box .icon { -webkit-transition: all .3s linear; -o-transition: all .3s linear;transition: all .3s linear; position: absolute; top: -5px; right: 10px; z-index: 0; font-size: 60px; color: rgba(0,0,0,0.15);}
.container {
	padding-right: 0px !important;
	padding-left: 0px !important;
}

.wrapper {
	margin-top: -8px;
}

.row {
	margin-left: 0px !important;
	margin-right: 0px;
}

#example tbody td {
	padding: 4px 5px;
	font-size: 83%;
}

#example thead th {
	padding: 3px 10px;
	border-bottom: 1px solid #795548;
	font-size: 80%;
}

.box-footer {
	padding: 1px;
}

.dataTables_wrapper .dataTables_info {
	color: #2196F3 !important;
	font-size: 10px !important;
	font-weight: bold !important;
}

.dataTables_wrapper .dataTables_paginate .paginate_button.disabled {
	color: #2196F3 !important;
	font-size: 10px !important;
	font-weight: bold !important;
}

.dataTables_wrapper .dataTables_paginate .paginate_button {
	font-size: 10px !important;
	font-weight: bold !important;
	padding: 0 !important;
}

.dataTables_wrapper .dataTables_length, .dataTables_wrapper .dataTables_filter,
	.dataTables_wrapper .dataTables_info, .dataTables_wrapper .dataTables_paginate
	{
	font-weight: bold !important;
	font-size: 11px !important;
}

.description-block>.description-header {
	margin: 0;
	padding: 0;
	font-weight: bold !important;
	color: #F44336;
	font-size: 80% !important;
}

.description-block>description-text {
	font-weight: bold;
}

table.dataTable.no-footer {
	border-bottom: 1px solid #795548 !important;
}

.box-header .box-title {
	font-size: 15px !important;
	font-weight: bold !important;
}

.description-block {
	margin: 6px 0 !important;
}

.dataTables_wrapper .dataTables_info {
	padding-top: 0.555em;
	margin-bottom: -2px;
}

svg>g:last-child>g:last-child {
	pointer-events: none
}

div.google-visualization-tooltip {
	pointer-events: none
}

div.google-visualization-tooltip {
	padding: 0 !important;
	margin: 0 !important;
	border: none !important;
	height: auto !important;
	overflow: hidden !important;
}

#qtnlost tbody td {
	padding: 2px 4px !important;
	font-size: 90% !important;
}

#example  tfoot th {
	text-align: right !important;
	padding: 2px 2px !important;
	color: #f44336;
	border-right: 1px solid #c7c3c3;
	border-bottom: 1px solid #111111;
}

#example_wrapper {
	overflow-x: auto !important;
}

#so_to_invc_modal th, #so_to_invc_modal td, #loi_to_so_modal th,
	#loi_to_so_modal td, #enq_to_qtn_modal th, #enq_to_qtn_modal td,
	#qtn_to_loi_modal th, #qtn_to_loi_modal td, #jihvlostDtls th,
	#jihvlostDtls td, #billingDtls th, #billingDtls td, #bookingDtls th,
	#bookingDtls td, #modal-default th, #modal-default td, #forecast-table th,
	#forecast-table td {
	padding: 5px !important;
	border: 1px solid #2196F3;
}

#onaccnt-third-layer th,#onaccnt-third-layer td,#modal-third-layer-invc th, #modal-third-layer-invc td,
	#modal-third-layer-so th, #modal-third-layer-so td,
	#modal-third-layer-qtn th, #modal-third-layer-qtn td,
	#modal-third-layer th, #modal-third-layer td {
	font-size: 80%;
}

button.dt-button {
	border: 1px solid #008000 !important;
	padding: 0.3em 0.3em !important;
	line-height: 1 !important;
}

.modal-title {
	color: #009688 !important;
	font-weight: bold !important;
}

#forecast-graph circle, #enq_to_qtn circle, #qtn_to_loi circle {
	r: 5 !important;
}

#jihv circle {
	r: 7 !important;
}

circle {
	r: 13 !important;
}

.help-left {
	z-index: 50;
	background: rgba(255, 255, 255, 0.7);
	border: 2px solid #3c8dbc;
	font-size: 15px;
	color: #3c8dbc;
	position: absolute;
	padding: 2px 0px 2px 6px;
	cursor: pointer;
	top: 0px;
	left: 0px;
	border-radius: 5px;
}

.help-right {
	z-index: 50;
	background: rgba(255, 255, 255, 0.7);
	border: 2px solid #3c8dbc;
	font-size: 15px;
	color: #3c8dbc;
	position: absolute;
	padding: 2px 0px 2px 6px;
	cursor: pointer;
	top: 0px;
	right: 0px;
	border-radius: 5px;
}

.help-right-lost {
	z-index: 50;
	background: rgba(255, 255, 255, 0.7);
	border: 2px solid #3c8dbc;
	font-size: 15px;
	color: #3c8dbc;
	position: absolute;
	padding: 2px 0px 2px 6px;
	cursor: pointer;
	top: 10px;
	right: 10px;
	border-radius: 5px;
}

#jihv table, #jihv table th, #jihv table td {
	border: 1px solid #607D8B;font-size: 97% !important;
}

#jihv table th, #jihv table td {
	padding: 6px 6px 6px 6px;
}

#forecast-mth-dt{height: 183px; float: left; width: 27%; margin-left: 5px; border: 1px solid gray; padding: 5px;}
#billing,#booking{margin-top: -19px; margin-left: -10px; height: 230px;}


@media ( max-width : 375px) {
	.divheader {
		padding-top: 0px !important;
	}
	.fj-bk-per {
		padding-left: 10% !important;
		padding-right: 10% !important;
	}
	#forecast-mth-dt{height: 183px; width: 25%;font-size: 85% !important; }
	#jihv table, #jihv table th, #jihv table td {font-size: 95%;}
	#booking{margin-top: 5px  !important;}
	#billing{margin-top: 5px  !important;}
	#so_to_invc_modal th, #so_to_invc_modal td, #loi_to_so_modal th, #loi_to_so_modal td, #enq_to_qtn_modal th, 
	#enq_to_qtn_modal td, #qtn_to_loi_modal th, #qtn_to_loi_modal td, #jihvlostDtls th, #jihvlostDtls td,
	 #billingDtls th, #billingDtls td,
	 #bookingDtls th, #bookingDtls td, #modal-default th, #modal-default td{ font-size: 85%;}
	 #billing_modal_table_2 th,#billing_modal_table_2 td{font-size: 52%;}
	 #forecast-table th,#forecast-tabletd{font-size: 74%;}
	 .modal-title{font-size: 95%;}
}

@media ( max-width : 450px) {
	.divheader {
		padding-top: 0px !important;
	}
	.fj-bk-per {
		padding-left: 10% !important;
		padding-right: 10% !important;
	}
}

@media ( max-width : 400px) {
	.divheader {
		padding-top: 0px !important;
	}
	.fj-bk-per {
		padding-left: 10% !important;
		padding-right: 10% !important;
	}
}

.overlay {
	position: absolute;
}

.box .overlay {
	margin-top: -19px !important;
	right: 15px !important;
}

.counter-anim{color:#FFEB3B;font-weight: normal !important;font-size: 80%;}
  .counter-anim:hover{cursor: pointer;color:red;}
    .collapse.in {
    background: #3b80a9;
    color: white;
    text-align: center;
    font-weight: bold;
    font-size: larger;
    display: block;
}
.weight-500{color:#FFF;    font-weight: bold;font-size: 80%;}
.padding-0{
    padding-right:0;
    padding-left:0;
    margin-bottom: -18px;
}
.paddingr-0{
    padding-right:0;
     padding-left:0;
    margin-bottom: -18px;
}
.paddingl-0{ 
    padding-left:0;
    padding-right:0;
    margin-bottom: -18px;
}
.fjtco-rcvbles{
background-color: #ffff;
    padding: 0.01em 16px;
    margin: 7px 7px 7px 15px;
    box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important;
    border-top: 3px solid #9e9e9e;
}
.fjtco-rcvbles .panel-body{padding:5px !important;}
.fj_mngmnt_dm_div{ margin-top: 8px;  margin-right: 3%;}
.fj_mngmnt_dm_slctbx{
    outline: none;
    color: white;
    background: #3c8dbc;
    margin-bottom: 1em;
    padding: .25em;
    border: 0;
    border-bottom: 2px solid currentcolor;
    font-weight: bold;
    letter-spacing: .15em;
    border-radius: 0;}
    table.onAcSummary tbody th, table.onAcSummary tbody td { padding: 3px 5px; }
#netBlOnAc{background: #F44336;  width: max-content;  border-radius: 5px;  margin-left: 5%;  padding: 2px;color:#fff;}

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
.box .overlay {margin-top: -19px !important;right: 15px !important;}
#chart_div{height:230px;margin-top:-37px;}@media ( max-width : 375px) {#chart_div{margin-top: -19px;}.modal-title{font-size: 95%;}.box-header 
.box-title {font-size: 13px !important;}#guage_test_billing svg{ margin-left: -15px !important}}
@media ( max-width : 450px) {}@media ( max-width : 400px) {}@media ( max-width : 700px) {}@media (min-width: 1200px){}

.stage-details-graph {z-index: 50; background: rgba(255, 255, 255, 0.7); border: 2px solid #3c8dbc;font-size: 15px; color: #3c8dbc; position: absolute; padding: 2px 0px 2px 6px;cursor: pointer; top: 15px; right: 150px; border-radius: 5px;}

</style>
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
<c:set var="nufail" value="red" scope="page" />
<c:set var="color_jan" value="#01b8aa" scope="page" />
<c:set var="color_feb" value="#01b8aa" scope="page" />
<c:set var="color_mar" value="#01b8aa" scope="page" />
<c:set var="color_apr" value="#01b8aa" scope="page" />
<c:set var="color_may" value="#01b8aa" scope="page" />
<c:set var="color_jun" value="#01b8aa" scope="page" />
<c:set var="color_jul" value="#01b8aa" scope="page" />
<c:set var="color_aug" value="#01b8aa" scope="page" />
<c:set var="color_sep" value="#01b8aa" scope="page" />
<c:set var="color_oct" value="#01b8aa" scope="page" />
<c:set var="color_nov" value="#01b8aa" scope="page" />
<c:set var="color_dec" value="#01b8aa" scope="page" />


<c:set var="enq-details" value="0" scope="page" />

<c:set var="fcast_total_perc" value="0" scope="page" />
<c:set var="fcast_jan" value="0" scope="page" />
<c:set var="fcast_feb" value="0" scope="page" />
<c:set var="fcast_mar" value="0" scope="page" />
<c:set var="fcast_apr" value="0" scope="page" />
<c:set var="fcast_may" value="0" scope="page" />
<c:set var="fcast_jun" value="0" scope="page" />
<c:set var="fcast_jul" value="0" scope="page" />
<c:set var="fcast_aug" value="0" scope="page" />
<c:set var="fcast_sep" value="0" scope="page" />
<c:set var="fcast_oct" value="0" scope="page" />
<c:set var="fcast_nov" value="0" scope="page" />
<c:set var="fcast_dec" value="0" scope="page" />

<c:set var="fcast_mnth_count" value="0" scope="page" /><!-- fcast mnth count for calucting accuracy percentage without or avoiding zero forecast or not forcat value set month  -->

<c:forEach var="forecastPerAnalsys" items="${FRCSPERCACCRCYDTLS}">

	<c:if
		test="${forecastPerAnalsys.mth1 ne null and !empty forecastPerAnalsys.mth1 and 1<= MTH}">
		
		<c:set var="fcast_mnth_count" value="${fcast_mnth_count + 1 }" scope="page" />
		
		<c:set var="fcast_jan" value="${forecastPerAnalsys.mth1}" scope="page" />
		<c:set var="fcast_total_perc" value="${fcast_total_perc + forecastPerAnalsys.mth1}" scope="page" />
	</c:if>
	<c:if
		test="${forecastPerAnalsys.mth2 ne null and !empty forecastPerAnalsys.mth2 and 2<= MTH}">
		
		<c:set var="fcast_mnth_count" value="${fcast_mnth_count + 1 }" scope="page" />
		<c:set var="fcast_feb" value="${forecastPerAnalsys.mth2}" scope="page" />
		<c:set var="fcast_total_perc"
			value="${fcast_total_perc + forecastPerAnalsys.mth2}" scope="page" />
	</c:if>
	<c:if
		test="${forecastPerAnalsys.mth3 ne null and !empty forecastPerAnalsys.mth3 and 3<= MTH}">
		
		<c:set var="fcast_mnth_count" value="${fcast_mnth_count + 1 }" scope="page" />
		<c:set var="fcast_mar" value="${forecastPerAnalsys.mth3}" scope="page" />
		<c:set var="fcast_total_perc"
			value="${fcast_total_perc + forecastPerAnalsys.mth3}" scope="page" />
	</c:if>
	<c:if
		test="${forecastPerAnalsys.mth4 ne null and !empty forecastPerAnalsys.mth4 and 4<= MTH}">
		<c:set var="fcast_mnth_count" value="${fcast_mnth_count + 1 }" scope="page" />
		<c:set var="fcast_apr" value="${forecastPerAnalsys.mth4}" scope="page" />
		<c:set var="fcast_total_perc"
			value="${fcast_total_perc + forecastPerAnalsys.mth4}" scope="page" />
	</c:if>
	<c:if
		test="${forecastPerAnalsys.mth5 ne null and !empty forecastPerAnalsys.mth5 and 5<= MTH}">
		<c:set var="fcast_mnth_count" value="${fcast_mnth_count + 1 }" scope="page" />
		<c:set var="fcast_may" value="${forecastPerAnalsys.mth5}" scope="page" />
		<c:set var="fcast_total_perc"
			value="${fcast_total_perc + forecastPerAnalsys.mth5}" scope="page" />
	</c:if>
	<c:if
		test="${forecastPerAnalsys.mth6 ne null and !empty forecastPerAnalsys.mth6 and 6<= MTH}">
		<c:set var="fcast_mnth_count" value="${fcast_mnth_count + 1 }" scope="page" />
		<c:set var="fcast_jun" value="${forecastPerAnalsys.mth6}" scope="page" />
		<c:set var="fcast_total_perc"
			value="${fcast_total_perc + forecastPerAnalsys.mth6}" scope="page" />
	</c:if>
	<c:if
		test="${forecastPerAnalsys.mth7 ne null and !empty forecastPerAnalsys.mth7 and 7<= MTH}">
		<c:set var="fcast_mnth_count" value="${fcast_mnth_count + 1 }" scope="page" />
		<c:set var="fcast_jul" value="${forecastPerAnalsys.mth7}" scope="page" />
		<c:set var="fcast_total_perc"
			value="${fcast_total_perc + forecastPerAnalsys.mth7}" scope="page" />
	</c:if>
	<c:if
		test="${forecastPerAnalsys.mth8 ne null and !empty forecastPerAnalsys.mth8 and 8<= MTH}">
		<c:set var="fcast_mnth_count" value="${fcast_mnth_count + 1 }" scope="page" />
		<c:set var="fcast_aug" value="${forecastPerAnalsys.mth8}" scope="page" />
		<c:set var="fcast_total_perc"
			value="${fcast_total_perc + forecastPerAnalsys.mth8}" scope="page" />
	</c:if>
	<c:if
		test="${forecastPerAnalsys.mth9 ne null and !empty forecastPerAnalsys.mth9 and 9<= MTH}">
		<c:set var="fcast_mnth_count" value="${fcast_mnth_count + 1 }" scope="page" />
		<c:set var="fcast_sep" value="${forecastPerAnalsys.mth9}" scope="page" />
		<c:set var="fcast_total_perc"
			value="${fcast_total_perc + forecastPerAnalsys.mth9}" scope="page" />
	</c:if>
	<c:if
		test="${forecastPerAnalsys.mth10 ne null and !empty forecastPerAnalsys.mth10 and 10<= MTH}">
		<c:set var="fcast_mnth_count" value="${fcast_mnth_count + 1 }" scope="page" />
		<c:set var="fcast_oct" value="${forecastPerAnalsys.mth10}"
			scope="page" />
		<c:set var="fcast_total_perc"
			value="${fcast_total_perc + forecastPerAnalsys.mth10}" scope="page" />
	</c:if>
	<c:if
		test="${forecastPerAnalsys.mth11 ne null and !empty forecastPerAnalsys.mth11 and 11<= MTH}">
		<c:set var="fcast_mnth_count" value="${fcast_mnth_count + 1 }" scope="page" />
		<c:set var="fcast_nov" value="${forecastPerAnalsys.mth11}"
			scope="page" />
		<c:set var="fcast_total_perc"
			value="${fcast_total_perc + forecastPerAnalsys.mth11}" scope="page" />
	</c:if>
	<c:if
		test="${forecastPerAnalsys.mth12 ne null and !empty forecastPerAnalsys.mth12 and 12<= MTH}">
		<c:set var="fcast_mnth_count" value="${fcast_mnth_count + 1 }" scope="page" />
		<c:set var="fcast_dec" value="${forecastPerAnalsys.mth12}"
			scope="page" />
		<c:set var="fcast_total_perc"
			value="${fcast_total_perc + forecastPerAnalsys.mth12}" scope="page" />
	</c:if>

<%-- <c:set var="fcast_total_perc" value="${fcast_total_perc / MTH}" scope="page" /> Old one , divsn by total month , replaced for only forecast set value accuracy %--%>
	<c:set var="fcast_total_perc" value="${fcast_total_perc / fcast_mnth_count}" scope="page" />
	
</c:forEach>

<c:if test="${fcast_jan lt fcast_total_perc}"><c:set var="color_jan" value="red" scope="page" /></c:if>
<c:if test="${fcast_feb lt fcast_total_perc}"><c:set var="color_feb" value="red" scope="page" /></c:if>
<c:if test="${fcast_mar lt fcast_total_perc}"><c:set var="color_mar" value="red" scope="page" /></c:if>
<c:if test="${fcast_apr lt fcast_total_perc}"><c:set var="color_apr" value="red" scope="page" /></c:if>
<c:if test="${fcast_may lt fcast_total_perc}"><c:set var="color_may" value="red" scope="page" /></c:if>
<c:if test="${fcast_jun lt fcast_total_perc}"><c:set var="color_jun" value="red" scope="page" /></c:if>
<c:if test="${fcast_jul lt fcast_total_perc}"><c:set var="color_jul" value="red" scope="page" /></c:if>
<c:if test="${fcast_aug lt fcast_total_perc}"><c:set var="color_aug" value="red" scope="page" /></c:if>
<c:if test="${fcast_sep lt fcast_total_perc}"><c:set var="color_sep" value="red" scope="page" /></c:if>
<c:if test="${fcast_oct lt fcast_total_perc}"><c:set var="color_oct" value="red" scope="page" /></c:if>
<c:if test="${fcast_nov lt fcast_total_perc}"><c:set var="color_nov" value="red" scope="page" /></c:if>
<c:if test="${fcast_dec lt fcast_total_perc}"><c:set var="color_dec" value="red" scope="page" /></c:if>


<c:set var="edocntq" value="0" scope="page" />
<c:set var="count" value="0" scope="page" />

<c:set var="fcast_div" value="${DIVDEFTITL}" scope="page" />
<c:set var="fcast_main" value="0" scope="page" />
<c:set var="fcast_invoice" value="0" scope="page" />
<c:set var="fcast_rev" value="0" scope="page" />
<c:set var="fcast_variance" value="0" scope="page" />
<c:set var="fcast_perc" value="0" scope="page" />
<c:set var="fcast_dt" value="NA" scope="page" />

<c:if test="${FRCSTDTLS ne null}">

	<c:forEach var="forecastlstt" items="${FRCSTDTLS}">
		<c:choose>
			<c:when
				test="${!empty forecastlstt.divname or forecastlstt.divname ne null}">
				<c:set var="fcast_div" value="${forecastlstt.divname}" scope="page" />
			</c:when>
			<c:otherwise>
				<c:set var="fcast_div" value="0" scope="page" />
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when
				test="${!empty forecastlstt.forecast or forecastlstt.forecast ne null}">
				<c:set var="fcast_main" value="${forecastlstt.forecast}"
					scope="page" />
			</c:when>
			<c:otherwise>
				<c:set var="fcast_main" value="0" scope="page" />
			</c:otherwise>
		</c:choose>

		<c:choose>
			<c:when
				test="${!empty forecastlstt.invoiced or forecastlstt.invoiced ne null}">
				<c:set var="fcast_invoice" value="${forecastlstt.invoiced}"
					scope="page" />
			</c:when>
			<c:otherwise>
				<c:set var="fcast_invoice" value="0" scope="page" />
			</c:otherwise>
		</c:choose>

		<c:choose>
			<c:when
				test="${!empty forecastlstt.targ_perc or forecastlstt.targ_perc ne null}">
				<c:set var="fcast_perc" value="${forecastlstt.targ_perc}"
					scope="page" />
			</c:when>
			<c:otherwise>
				<c:set var="fcast_perc" value="0" scope="page" />
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when
				test="${!empty forecastlstt.variance or forecastlstt.variance ne null}">
				<c:set var="fcast_variance" value="${forecastlstt.variance}"
					scope="page" />
			</c:when>
			<c:otherwise>
				<c:set var="fcast_variance" value="0" scope="page" />
			</c:otherwise>
		</c:choose>
	</c:forEach>
</c:if>


<c:set var="bknglst2yrs_yr0t" value="0" scope="page" />
<c:set var="bknglst2yrs_yr0a" value="0" scope="page" />
<c:set var="bknglst2yrs_yr1t" value="0" scope="page" />
<c:set var="bknglst2yrs_yr1a" value="0" scope="page" />
<c:set var="bknglst2yrs_yr2t" value="0" scope="page" />
<c:set var="bknglst2yrs_yr2a" value="0" scope="page" />
<c:if test="${BKNGS_LTWOYRS ne null}">
	<c:forEach var="bknglsttwoyr" items="${BKNGS_LTWOYRS}">	
		<c:choose>
			<c:when
				test="${!empty bknglsttwoyr.curr_yrt or bknglsttwoyr.curr_yrt ne null}">
				<c:set var="bknglst2yrs_yr0t" value="${bknglsttwoyr.curr_yrt}"
					scope="page" />
			</c:when>
			<c:otherwise>
				<c:set var="bknglst2yrs_yr0t" value="0" scope="page" />
			</c:otherwise>
		</c:choose>

		<c:choose>
			<c:when
				test="${!empty bknglsttwoyr.curr_yra or bknglsttwoyr.curr_yra ne null}">
				<c:set var="bknglst2yrs_yr0a" value="${bknglsttwoyr.curr_yra}"
					scope="page" />
			</c:when>
			<c:otherwise>
				<c:set var="bknglst2yrs_yr0a" value="0" scope="page" />
			</c:otherwise>
		</c:choose>

		<c:choose>
			<c:when
				test="${!empty bknglsttwoyr.prev_yrt or bknglsttwoyr.prev_yrt ne null}">
				<c:set var="bknglst2yrs_yr1t" value="${bknglsttwoyr.prev_yrt}"
					scope="page" />
			</c:when>
			<c:otherwise>
				<c:set var="bknglst2yrs_yr1t" value="0" scope="page" />
			</c:otherwise>
		</c:choose>

		<c:choose>
			<c:when
				test="${!empty bknglsttwoyr.prev_yra or bknglsttwoyr.prev_yra ne null}">
				<c:set var="bknglst2yrs_yr1a" value="${bknglsttwoyr.prev_yra}"
					scope="page" />
			</c:when>
			<c:otherwise>
				<c:set var="bknglst2yrs_yr1a" value="0" scope="page" />
			</c:otherwise>
		</c:choose>

		<c:choose>
			<c:when
				test="${!empty bknglsttwoyr.scnd_prev_yrt or bknglsttwoyr.scnd_prev_yrt ne null}">
				<c:set var="bknglst2yrs_yr2t" value="${bknglsttwoyr.scnd_prev_yrt}"
					scope="page" />
			</c:when>
			<c:otherwise>
				<c:set var="bknglst2yrs_yr2t" value="0" scope="page" />
			</c:otherwise>
		</c:choose>

		<c:choose>
			<c:when
				test="${!empty bknglsttwoyr.scnd_prev_yra or bknglsttwoyr.scnd_prev_yra ne null}">
				<c:set var="bknglst2yrs_yr2a" value="${bknglsttwoyr.scnd_prev_yra}"
					scope="page" />
			</c:when>
			<c:otherwise>
				<c:set var="bknglst2yrs_yr2a" value="0" scope="page" />
			</c:otherwise>
		</c:choose>
	</c:forEach>
</c:if>



<c:set var="billinglst2yrs_yr0t" value="0" scope="page" />
<c:set var="billinglst2yrs_yr0a" value="0" scope="page" />
<c:set var="billinglst2yrs_yr1t" value="0" scope="page" />
<c:set var="billinglst2yrs_yr1a" value="0" scope="page" />
<c:set var="billinglst2yrs_yr2t" value="0" scope="page" />
<c:set var="billinglst2yrs_yr2a" value="0" scope="page" />
<c:if test="${BILLNG_LTWOYRS ne null}">
	<c:forEach var="billinglsttwoyr" items="${BILLNG_LTWOYRS}">
		<c:choose>
			<c:when
				test="${!empty billinglsttwoyr.curr_yrt or billinglsttwoyr.curr_yrt ne null}">
				<c:set var="billinglst2yrs_yr0t" value="${billinglsttwoyr.curr_yrt}"
					scope="page" />
			</c:when>
			<c:otherwise>
				<c:set var="billinglst2yrs_yr0t" value="${billinglsttwoyr.curr_yrt}"
					scope="page" />
			</c:otherwise>
		</c:choose>


		<c:choose>
			<c:when
				test="${!empty billinglsttwoyr.curr_yra or billinglsttwoyr.curr_yra ne null}">
				<c:set var="billinglst2yrs_yr0a" value="${billinglsttwoyr.curr_yra}"
					scope="page" />
			</c:when>
			<c:otherwise>
				<c:set var="billinglst2yrs_yr0a" value="0" scope="page" />
			</c:otherwise>
		</c:choose>

		<c:choose>
			<c:when
				test="${!empty billinglsttwoyr.prev_yrt or billinglsttwoyr.prev_yrt ne null}">
				<c:set var="billinglst2yrs_yr1t" value="${billinglsttwoyr.prev_yrt}"
					scope="page" />
			</c:when>
			<c:otherwise>
				<c:set var="billinglst2yrs_yr1t" value="0" scope="page" />
			</c:otherwise>
		</c:choose>

		<c:choose>
			<c:when
				test="${!empty billinglsttwoyr.prev_yra or billinglsttwoyr.prev_yra ne null}">
				<c:set var="billinglst2yrs_yr1a" value="${billinglsttwoyr.prev_yra}"
					scope="page" />
			</c:when>
			<c:otherwise>
				<c:set var="billinglst2yrs_yr1a" value="0" scope="page" />
			</c:otherwise>
		</c:choose>

		<c:choose>
			<c:when
				test="${!empty billinglsttwoyr.scnd_prev_yrt or billinglsttwoyr.scnd_prev_yrt ne null}">
				<c:set var="billinglst2yrs_yr2t"
					value="${billinglsttwoyr.scnd_prev_yrt}" scope="page" />
			</c:when>
			<c:otherwise>
				<c:set var="billinglst2yrs_yr2t" value="0" scope="page" />
			</c:otherwise>
		</c:choose>

		<c:choose>
			<c:when
				test="${!empty billinglsttwoyr.scnd_prev_yra or billinglsttwoyr.scnd_prev_yra ne null}">
				<c:set var="billinglst2yrs_yr2a"
					value="${billinglsttwoyr.scnd_prev_yra}" scope="page" />
			</c:when>
			<c:otherwise>
				<c:set var="billinglst2yrs_yr2a" value="0" scope="page" />
			</c:otherwise>
		</c:choose>

	</c:forEach>
</c:if>
<!-- Font Awesome -->
<link rel="stylesheet"
	href="resources/bower_components/font-awesome/css/font-awesome.min.css">

<!-- Theme style -->
<link rel="stylesheet" href="resources/dist/css/AdminLTE.min.css">
<link rel="stylesheet" href="resources/dist/css/skins/_all-skins.min.css">
<link rel="stylesheet" type="text/css" href="resources/datatables/datatables-fjtco/css/jquery.dataTables.min.css" />
<link rel="stylesheet" type="text/css" href="resources/datatables/buttons-fjtco/css/buttons.dataTables.min.css" />
<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/dataTables.buttons.min.js"></script>
<script type="text/javascript" 	src="resources/datatables/buttons-fjtco/js/buttons.flash.min.js"></script>
<script type="text/javascript" src="resources/datatables/ajax/excelmake/jszip.min.js"></script>
<!--  <script type="text/javascript" src="resources/datatables/ajax/pdfmake/vfs_fonts.js"></script>-->
<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.html5.min.js"></script>
<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.print.min.js"></script>

<link href="resources/css/regularisation_report.css" rel="stylesheet" type="text/css" />
<script src="resources/js/regularisation_report.js"></script>

<!-- jquery library for dragging the model -->
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.13.2/jquery-ui.min.js"></script>
<script type="text/javascript">
var Million = 1000000;
 function formatNumber(num) {return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");}

    $(function () {
    	
        $('#division_list').multiselect({
        	nonSelectedText: 'Select Division',
            includeSelectAllOption: true
        });
    });
    

   
   
	 function selectAll(box) {
	        for(var i=0; i<box.length; i++) {
	            box.options[i].selected = true;
	        }
	    }
	 function getSeletedval(){
			
		    var selectedValues = [];    
		    $("#division_list :selected").each(function(){
		        selectedValues.push($(this).val()); 
		    });
		    return true;
		    alert(selectedValues);
		   
		
	}
</script>

<script type="text/javascript">
 function preLoader(){$('#laoding').show();
  var subDivnSel = document.getElementById("division_list").value;
  if(subDivnSel !== "")
 	 $('#laoding').show();
 }
 $(document).ready(function() { $('#laoding').hide();$('#laoding-rcvbl').hide(); $('#laoding-pdc').hide();
 	$("#myModal").draggable({ handle: ".modal-header" });
 });
</script>
<!-- .. graph activities start..  -->
<script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
 //function preLoader(){ alert("testtt");$('#laoding').show();}
 $(document).ready(function() { $('#laoding').hide();
 });
 google.charts.load('current', {'packages':['corechart','gauge','bar','table']});
 

 
  google.charts.setOnLoadCallback(drawBillingtestSummary_graph);
  google.charts.setOnLoadCallback(drawBookingtestSummary_graph);
 
  google.charts.setOnLoadCallback(drawForecast_graph);
  google.charts.setOnLoadCallback(drawEnqtoQtnVisualization);
  google.charts.setOnLoadCallback(drawQtnToLoiVisualization);
  google.charts.setOnLoadCallback(drawLoiToSoVisualization);
  google.charts.setOnLoadCallback(drawOrderToInvcVisualization);
  
  function drawOrderToInvcVisualization() {
	 
	   // so to invc graph 
						   var data = google.visualization.arrayToDataTable([
						    ['Year', 'Order',{type: 'string', role: 'tooltip'}, 'Invoice',{type: 'string', role: 'tooltip'}],
						   
						    <c:choose>
						     <c:when test='${!empty SOTOINVANALSUM}'>
						    <c:forEach var="orderInvcAnalsys" items="${SOTOINVANALSUM}">
						    ['${orderInvcAnalsys.year}',${orderInvcAnalsys.s_order_val},'ORDER - ${orderInvcAnalsys.year} \r\n  Value:${orderInvcAnalsys.s_order_val}M \r\n Count : ${orderInvcAnalsys.s_order}',${orderInvcAnalsys.invoice_val},'BILLING - ${orderInvcAnalsys.year} \r\n Value:${orderInvcAnalsys.invoice_val}M \r\n Count : ${orderInvcAnalsys.invoice}'],
						    </c:forEach>
						    </c:when>
						     <c:otherwise>
						     ['2016', 0,'', 0,''],
						     ['2017', 0,'', 0,''],
						     ['2018', 0,'', 0,''],
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
										
						// title : ' ORDER - INVOICE ANALYSIS (YTD)',
						title : ' ORDER to BILLING ANALYSIS (YTD)',
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
					    
					      
						 colors: ['#add8e6', '#86a53e'],
						 'is3D':true,
						  
						      'height': 230,
						      'legend': {
						        position: 'top'
						      }
					          , tooltip: { textStyle: { fontName: 'verdana', fontSize: 12 } }
	};

	var chart = new google.visualization.ColumnChart(document.getElementById('order_to_invc'));

	chart.draw(view, options);

	google.visualization.events.addListener(chart, 'onmouseout', agingMousehandler2); 
	google.visualization.events.addListener(chart, 'select', selectHandler);
	function agingMousehandler1() {$('#jihv').css('cursor','pointer');} 
	function agingMousehandler2() {$('#jihv').css('cursor','default');}
	function selectHandler() { 
		 <!--alert('${DFLTDMCODE}');-->
		 $('#laoding').show();
		 var year_data;
		 var selection = chart.getSelection(); var message = '';
		 for (var i = 0; i < selection.length; i++) { 
			 
			 var item = selection[i];
		 
		 if (item.row != null && item.column != null) {
			 var str = data.getFormattedValue(item.row, 1); // var str = data.getFormattedValue(item.row, item.column);
			 year_data = data.getValue(chart.getSelection()[0].row, 0);
		    
		     } 
		 } //alert(year_data);
	    
	         
		 
		
		     var division_header='${DIVDEFTITL}';
		 var ttl="<b>Order to Billing  Month wise Analysis Details of "+division_header+"</b><strong style='color:blue;'> </strong> Division for "+year_data+" <strong style='color:blue;'>  </strong> ";
		 var exclTtl="Order to Billing    Month wise Analysis Details of  ${DIVDEFTITL}  Division";
		 $("#order-invoice-modal-graph .modal-title").html(ttl); $.ajax({ type: 'POST',url: 'sipDivision',  data: {octjf: "soToInvoiceyrwsedtls", divenqqtn:"${DIVDEFTITL}", yearTemp:year_data,d2:'${DFLTDMCODE}'},  dataType: "json",
		 success: function(data) {
			
			 $('#laoding').hide();
			
			 var output="<table id='SotoInvoiceMthAnl' class='table table-bordered small'><thead><tr><th>#</th><th>Division</th><th>Month</th><th>Order</th><th>Order Value <br/>(Value in Millions)</th><th>Invoice </th><th>Invoice Value <br/>(Value in Millions)</th>"+
		 "</tr></thead><tbody>";
		 
		 var j=0; for (var i in data) { j=j+1;
		 
		 output+="<tr><td>"+j+"</td><td>" + data[i].d1 + "</td>"+
		 "<td><a href='#' id='"+data[i].d2+""+year_data+"'  onclick='showThirdLayerInvc(this.id);'  data-backdrop='static' data-keyboard='false' class='btn btn-primary btn-xs' data-toggle='modal' data-target='#modal-default1'><span class='fa fa-external-link' ></span>" + data[i].d2 + "</a></td>"+
		 "<td>" + data[i].d3 + "</td><td>" + data[i].d4+ "</td>"+ "<td>" + data[i].d5 + "</td><td>" + data[i].d6 + "</td></td>"+
		 "</tr>"; } 
		 output+="</tbody></table>";
		 

		 $("#order-invoice-modal-graph .modal-body").html(output);
		 $("#order-invoice-modal-graph").modal("show");	
		 
			    $('#SotoInvoiceMthAnl').DataTable( {
			    	  dom: 'Bfrtip',       
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
		 //start  script for deselect column - on modal close
		 chart.setSelection([{'row': null, 'column': null}]); 
		 //end  script for deselect column - on modal close
		 }}
  function drawLoiToSoVisualization() {
	   // loi to so graph
						   var data = google.visualization.arrayToDataTable([
							   ['Year', 'LOI' ,{type: 'string', role: 'tooltip'}, 'Order Recieved' ,{type: 'string', role: 'tooltip'}],    
						    <c:choose>
						     <c:when test='${!empty LOITOSOANALSUM}'>
						    <c:forEach var="LoiSoAnalsys" items="${LOITOSOANALSUM}">    
						    
						    ['${LoiSoAnalsys.year}',${LoiSoAnalsys.loi_val},'LOI- ${LoiSoAnalsys.year} \r\n  Value:${LoiSoAnalsys.loi_val}M \r\n Count : ${LoiSoAnalsys.loi}',${LoiSoAnalsys.sales_order_val},'ORDER RECIEVED - ${LoiSoAnalsys.year} \r\n  Value:${LoiSoAnalsys.sales_order_val}M \r\n Count : ${LoiSoAnalsys.sales_order}'],
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
							
						 title : ' LOI to ORDER ANALYSIS (YTD)',
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

	var chart = new google.visualization.ColumnChart(document.getElementById('loi_to_so'));

	chart.draw(view, options);
	
	google.visualization.events.addListener(chart, 'onmouseout', agingMousehandler2); 
	google.visualization.events.addListener(chart, 'select', selectHandler);
	function agingMousehandler1() {$('#jihv').css('cursor','pointer');} 
	function agingMousehandler2() {$('#jihv').css('cursor','default');}
	function selectHandler() { 
		 <!--alert('${DFLTDMCODE}');-->
		 $('#laoding').show();
		 var year_data;
		 var selection = chart.getSelection(); var message = '';
		 for (var i = 0; i < selection.length; i++) { 
			 
			 var item = selection[i];
		 
		 if (item.row != null && item.column != null) {
			 var str = data.getFormattedValue(item.row, 1); // var str = data.getFormattedValue(item.row, item.column);
			 year_data = data.getValue(chart.getSelection()[0].row, 0);
		    
		     } 
		 } //alert(year_data);
		
		     var division_header='${DIVDEFTITL}';
		 var ttl="<b>LOI to Order  Month wise Analysis Details of "+division_header+"</b><strong style='color:blue;'> </strong> Division for "+year_data+" <strong style='color:blue;'>  </strong> ";
		 var exclTtl="LOI to Order  Month wise Analysis Details of  ${DIVDEFTITL}  Division";
		 $("#loi-order-modal-graph .modal-title").html(ttl); $.ajax({ type: 'POST',url: 'sipDivision',  data: {octjf: "loiToSoiyrwsedtls", divenqqtn:"${DIVDEFTITL}", yearTemp:year_data,d2:'${DFLTDMCODE}'},  dataType: "json",
		 success: function(data) {
			
			 $('#laoding').hide();
			
			 var output="<table id='LoitoSoMthAnl' class='table table-bordered small'><thead><tr><th>#</th><th>Division</th><th>Month</th><th>LOI</th><th>LOI Value <br/>(Value in Millions)</th><th>Order</th><th>Order Value <br/>(Value in Millions)</th>"+
		 "</tr></thead><tbody>";
		 
		 var j=0; for (var i in data) { j=j+1;
		 
		 output+="<tr><td>"+j+"</td><td>" + data[i].d1 + "</td>"+
		 "<td><a href='#' id='"+data[i].d2+""+year_data+"'  onclick='showThirdLayerSo(this.id);'  data-backdrop='static' data-keyboard='false' class='btn btn-primary btn-xs' data-toggle='modal' data-target='#modal-default1'><span class='fa fa-external-link' ></span>" + data[i].d2 + "</a></td>"+
		 "<td>" + data[i].d3 + "</td><td>" + data[i].d4+ "</td>"+ "<td>" + data[i].d5 + "</td><td>" + data[i].d6 + "</td></td>"+
		 "</tr>"; } 
		 output+="</tbody></table>";
		 

		 $("#loi-order-modal-graph .modal-body").html(output);
		 $("#loi-order-modal-graph").modal("show");	
		 
			    $('#LoitoSoMthAnl').DataTable( {
			        dom: 'Bfrtip',       
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
		 //start  script for deselect column - on modal close
		 chart.setSelection([{'row': null, 'column': null}]); 
		 //end  script for deselect column - on modal close
		 }}
 function drawQtnToLoiVisualization() {
	   // qtn to loi
						   var data = google.visualization.arrayToDataTable([
						    ['Year', 'JIH',{type: 'string', role: 'tooltip'}, 'LOI Recieved',{type: 'string', role: 'tooltip'}],
						    
						    <c:choose>
						     <c:when test='${!empty QTNTOLOISUM}'>
						    <c:forEach var="QtnLoiAnalsys" items="${QTNTOLOISUM}">
						    ['${QtnLoiAnalsys.year}',${QtnLoiAnalsys.quotation_val},'QUOTATION- ${QtnLoiAnalsys.year} \r\n  Value:${QtnLoiAnalsys.quotation_val}M \r\n Count : ${QtnLoiAnalsys.quotation}',${QtnLoiAnalsys.loi_val},'LOI RECIEVED- ${QtnLoiAnalsys.year} \r\n  Value:${QtnLoiAnalsys.loi_val}M \r\n Count : ${QtnLoiAnalsys.loi}'],
						    </c:forEach>
						    </c:when>
						     <c:otherwise>
						     ['2016',0,'',0,''],
						     ['2017', 0,'', 0,''],
						     ['2018', 0,'',0,''],
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
								
						 title : ' JIH to LOI ANALYSIS (YTD)',
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
						
					          vAxes: {
					            // Adds titles to each axis.
					            0: {title: 'Value in Millions',titleTextStyle: {italic: true},viewWindow:{ min:0}, format: '#',color: '#3c8dbc', bold: true}
					            
					          },
					    
					      
						 colors: ['#4f81bd', '#c0504d'],
						 'is3D':true,
						  
						      'height': 230,
						      'legend': {
						        position: 'top'
						      }
					          , tooltip: { textStyle: { fontName: 'verdana', fontSize: 12 } }
	};

	var chart = new google.visualization.ColumnChart(document.getElementById('qtn_to_loi'));

	chart.draw(view, options);
	
	google.visualization.events.addListener(chart, 'onmouseover', agingMousehandler1); 
	google.visualization.events.addListener(chart, 'onmouseout', agingMousehandler2); 
	google.visualization.events.addListener(chart, 'select', selectHandler);
	function agingMousehandler1() {$('#jihv').css('cursor','pointer');} 
	function agingMousehandler2() {$('#jihv').css('cursor','default');}
	function selectHandler() { 
		 <!--alert('${DFLTDMCODE}');-->
		 $('#laoding').show();
		 var year_data;
		 var selection = chart.getSelection(); var message = '';
		 for (var i = 0; i < selection.length; i++) {  var item = selection[i];
		 if (item.row != null && item.column != null) {
			 var str = data.getFormattedValue(item.row, item.column); 
			 year_data = data.getValue(chart.getSelection()[0].row, 0)
		    
		     } 
		 else if (item.row != null) {
			 var str = data.getFormattedValue(item.row, 0); 
		 } else if (item.column != null) { 
			 var str = data.getFormattedValue(0, item.column);
		   
		     } } //alert(year_data);
		
		     var division_header='${DIVDEFTITL}';
		 var ttl="<b>JIH to LOI  Month wise Analysis Details of "+division_header+"</b><strong style='color:blue;'> </strong> Division for "+year_data+" <strong style='color:blue;'>  </strong> ";
		 var exclTtl="JIH to LOI  Month wise Analysis Details of  ${DIVDEFTITL}  Division";
		 $("#qtn-loi-modal-graph .modal-title").html(ttl); $.ajax({ type: 'POST',url: 'sipDivision',  data: {octjf: "qtnToLoiyrwsedtls", divenqqtn:"${DIVDEFTITL}", yearTemp:year_data,d2:'${DFLTDMCODE}'},  dataType: "json",
		 success: function(data) {
			
			 $('#laoding').hide();
			
			 var output="<table id='QtntoLOIMthAnl' class='table table-bordered small'><thead><tr><th>#</th><th>Division</th><th>Month</th><th>JIH</th><th>JIH Value <br/>(Value in Millions)</th><th>LOI</th><th>LOI Value<br/>(Value in Millions)</th>"+
		 "</tr></thead><tbody>";
		 
		 var j=0; for (var i in data) { j=j+1;
		 
		 output+="<tr><td>"+j+"</td><td>" + data[i].d1 + "</td>"+
		 "<td><a href='#' id='"+data[i].d2+""+year_data+"'  onclick='showThirdLayerQuotation(this.id);'  data-backdrop='static' data-keyboard='false' class='btn btn-primary btn-xs' data-toggle='modal' data-target='#modal-default1'><span class='fa fa-external-link' ></span>" + data[i].d2 + "</a></td>"+
		 "<td>" + data[i].d3 + "</td><td>" + data[i].d4+ "</td>"+ "<td>" + data[i].d5 + "</td><td>" + data[i].d6 + "</td></td>"+
		 "</tr>"; } 
		 output+="</tbody></table>";
		 

		 $("#qtn-loi-modal-graph .modal-body").html(output);
		 $("#qtn-loi-modal-graph").modal("show");	
		 
			    $('#QtntoLOIMthAnl').DataTable( {
			        dom: 'Bfrtip',
			        "columnDefs" : [{"targets": [3, 14, 15, 16], "type":"date-eu"}],
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
		 //start  script for deselect column - on modal close
		 chart.setSelection([{'row': null, 'column': null}]); 
		 //end  script for deselect column - on modal close
		 }}
		
 function drawEnqtoQtnVisualization() {
   // Some raw data (not necessarily accurate)
					   var data = google.visualization.arrayToDataTable([
					    ['Year', 'Enquiry', 'Quotation',  'Avg. Days to Quote'],
					    
					    <c:choose>
					     <c:when test='${!empty ENQTOQTNSUM}'>
					    <c:forEach var="EnqQtnAnalsys" items="${ENQTOQTNSUM}">
					    ['${EnqQtnAnalsys.year}',${EnqQtnAnalsys.enquiry},${EnqQtnAnalsys.quotation},${EnqQtnAnalsys.days}],
					    </c:forEach>
					    </c:when>
					     <c:otherwise>
					     ['2016',0,0,0],
					     ['2017', 0, 0,0],
					     ['2018', 0,0,0],
					     </c:otherwise>
					     </c:choose>
					 ]);
					var view = new google.visualization.DataView(data);
					 view.setColumns([0, 1,
					                 
					                  2,3]);
					 
					 
					 
					var options = {
							
					 title : ' ENQUIRY to QUOTATION ANALYSIS (YTD) ',
					 titleTextStyle: {
					     color: '#000',
					     fontSize: 13,
					     fontName: 'Arial',
					     bold: true,
					    
					  },
					 vAxis: {title: 'Value'},
					 series: {
				            0: {targetAxisIndex: 0},
				            1: {targetAxisIndex: 0},
				            2: {targetAxisIndex: 1,type: 'line'}
				          },
				         
				          vAxes: {
				            // Adds titles to each axis.
				            0: {title: 'Enquiry & Qtn. Count',viewWindow:{ min:0}, format: 'short'},
				            1: {title: 'Avg. Days to Quote',viewWindow:{ min:0}, format: '#'}
				          },
				      seriesType: 'bars',
				      pointSize:2,
					 colors: ['#f69037', '#0b1d39','#f80a1c'],
					 'is3D':true,
					  
					      'height': 230,
					      'legend': {
					        position: 'top'
					      }
				          , tooltip: { textStyle: { fontName: 'verdana', fontSize: 12 } }
};

var chart = new google.visualization.ComboChart(document.getElementById('enq_to_qtn'));

chart.draw(view, options);

google.visualization.events.addListener(chart, 'onmouseover', agingMousehandler1); 
google.visualization.events.addListener(chart, 'onmouseout', agingMousehandler2); 
google.visualization.events.addListener(chart, 'select', selectHandler);
function agingMousehandler1() {$('#jihv').css('cursor','pointer');} 
function agingMousehandler2() {$('#jihv').css('cursor','default');}
function selectHandler() { 
	 <!--alert('${DFLTDMCODE}');-->
	 $('#laoding').show();
	 var year_data;
	 var selection = chart.getSelection(); var message = '';
	 for (var i = 0; i < selection.length; i++) {  var item = selection[i];
	 if (item.row != null && item.column != null) {
		 var str = data.getFormattedValue(item.row, item.column); 
		 year_data = data.getValue(chart.getSelection()[0].row, 0)
	    
	     } 
	 else if (item.row != null) {
		 var str = data.getFormattedValue(item.row, 0); 
	 } else if (item.column != null) { 
		 var str = data.getFormattedValue(0, item.column);
	   
	     } } //alert(year_data);
	 
	
	     var division_header='${DIVDEFTITL}';
	 var ttl="<b>Enquiry to Qtn.  Month wise Analysis Details of "+division_header+"</b><strong style='color:blue;'> </strong> Division for "+year_data+" <strong style='color:blue;'>  </strong> ";
	 var exclTtl="Enquiry to Qtn.  Month wise Analysis Details of  ${DIVDEFTITL}  Division";
	 $("#qtn-lost-month-modal-graph .modal-title").html(ttl); $.ajax({ type: 'POST',url: 'sipDivision',  data: {octjf: "etqyrwsedtls",d2:'${DFLTDMCODE}', divenqqtn:"${DIVDEFTITL}", yearTemp:year_data},  dataType: "json",
	 success: function(data) {
		
		 $('#laoding').hide();
		
		 var output="<table id='ingtoQtnMthAnl' class='table table-bordered small'><thead><tr><th>#</th><th>Division</th><th>Month</th><th>Total Enquiry Recieved</th><th>Total Quotation Quoted</th><th>No Quoted</th><th>Avg. Days to Quote</th>"+
	 "</tr></thead><tbody>";
	 
	 var j=0; for (var i in data) { j=j+1;
	 
	 output+="<tr><td>"+j+"</td><td>" + data[i].d1 + "</td>"+
	 "<td><a href='#' id='"+data[i].d2+""+year_data+"'  onclick='showThirdLayerEnquiry(this.id);'  data-backdrop='static' data-keyboard='false' class='btn btn-primary btn-xs' data-toggle='modal' data-target='#modal-default1'><span class='fa fa-external-link' ></span>" + data[i].d2 + "</a></td>"+
	 "<td>" + data[i].d3 + "</td><td>" + data[i].d4+ "</td>"+ "<td>" + data[i].d5 + "</td><td>" + data[i].d6 + "</td></td>"+
	 "</tr>"; } 
	 output+="</tbody></table>";
	 

	 $("#qtn-lost-month-modal-graph .modal-body").html(output);
	 $("#qtn-lost-month-modal-graph").modal("show");	
	 
		    $('#ingtoQtnMthAnl').DataTable( {
		        dom: 'Bfrtip',  
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
	 //start  script for deselect column - on modal close
	 chart.setSelection([{'row': null, 'column': null}]); 
	 //end  script for deselect column - on modal close
	 }}

 
 function drawForecast_graph() {
	 var data = google.visualization.arrayToDataTable([ 
		 ['Month', 'Accuraccy % ', { role: 'style' },'Average % ',{type: 'string', role: 'tooltip'}],
	    
		 <c:choose>
	     <c:when test='${!empty FRCSPERCACCRCYDTLS}'>
	     <c:if test="${1 lt MTH}"> ['JAN', ${fcast_jan},'${color_jan}',  ${fcast_total_perc}, 'Average % : <fmt:formatNumber type='number'  pattern = '###.##' value=' ${fcast_total_perc}'/>'],  </c:if>
         <c:if test="${2 lt MTH}"> ['FEB', ${fcast_feb},'${color_feb}', ${fcast_total_perc}, 'Average % : <fmt:formatNumber type='number'  pattern = '###.##' value=' ${fcast_total_perc}'/>'], </c:if>
         <c:if test="${3 lt MTH}"> ['MAR', ${fcast_mar},'${color_mar}', ${fcast_total_perc}, 'Average % : <fmt:formatNumber type='number'  pattern = '###.##' value=' ${fcast_total_perc}'/>'], </c:if>
         <c:if test="${4 lt MTH}"> ['APR', ${fcast_apr},'${color_apr}', ${fcast_total_perc}, 'Average % : <fmt:formatNumber type='number'  pattern = '###.##' value=' ${fcast_total_perc}'/>'], </c:if>
         <c:if test="${5 lt MTH}">  ['MAY', ${fcast_may},'${color_may}', ${fcast_total_perc}, 'Average % : <fmt:formatNumber type='number'  pattern = '###.##' value=' ${fcast_total_perc}'/>'], </c:if>
         <c:if test="${6 lt MTH}">  ['JUN', ${fcast_jun},'${color_jun}', ${fcast_total_perc}, 'Average % : <fmt:formatNumber type='number'  pattern = '###.##' value=' ${fcast_total_perc}'/>'], </c:if>
         <c:if test="${7 lt MTH}"> ['JUL', ${fcast_jul},'${color_jul}', ${fcast_total_perc}, 'Average % : <fmt:formatNumber type='number'  pattern = '###.##' value=' ${fcast_total_perc}'/>'], </c:if>
         <c:if test="${8 lt MTH}"> ['AUG', ${fcast_aug},'${color_aug}', ${fcast_total_perc}, 'Average % : <fmt:formatNumber type='number'  pattern = '###.##' value=' ${fcast_total_perc}'/>'], </c:if>
         <c:if test="${9 lt MTH}">  ['SEP', ${fcast_sep},'${color_sep}', ${fcast_total_perc}, 'Average % : <fmt:formatNumber type='number'  pattern = '###.##' value=' ${fcast_total_perc}'/>'],</c:if>
         <c:if test="${10 lt MTH}">['OCT', ${fcast_oct},'${color_oct}', ${fcast_total_perc}, 'Average % : <fmt:formatNumber type='number'  pattern = '###.##' value=' ${fcast_total_perc}'/>'], </c:if>
         <c:if test="${11 lt MTH}"> ['NOV', ${fcast_nov},'${color_nov}', ${fcast_total_perc}, 'Average % : <fmt:formatNumber type='number'  pattern = '###.##' value=' ${fcast_total_perc}'/>'], </c:if>
         <c:if test="${12 lt MTH}">  ['DEC', ${fcast_dec},'${color_dec}', ${fcast_total_perc}, 'Average % : <fmt:formatNumber type='number'  pattern = '###.##' value=' ${fcast_total_perc}'/>'], </c:if>

	     </c:when>
        <c:otherwise>
	     
	     <c:if test="${1 lt MTH}">  ['JAN',0,'red',0, 'Average % : 0'],  </c:if>
         <c:if test="${2 lt MTH}"> ['FEB', 0,'red',0, 'Average % : 0'], </c:if>
         <c:if test="${3 lt MTH}"> ['MAR', 0,'red',0, 'Average % : 0'], </c:if>
         <c:if test="${4 lt MTH}"> ['APR', 0,'red',0, 'Average % : 0'], </c:if>
         <c:if test="${5 lt MTH}">  ['MAY',0,'red',0, 'Average % : 0'], </c:if>
         <c:if test="${6 lt MTH}">  ['JUN', 0,'red',0, 'Average % : 0'], </c:if>
         <c:if test="${7 lt MTH}"> ['JUL', 0,'red',0, 'Average % : 0'], </c:if>
         <c:if test="${8 lt MTH}"> ['AUG', 0,'red',0, 'Average % : 0'], </c:if>
         <c:if test="${9 lt MTH}">  ['SEP', 0,'red',0, 'Average % : 0'],</c:if>
         <c:if test="${10 lt MTH}">['OCT', 0,'red',0, 'Average % : 0'], </c:if>
         <c:if test="${11 lt MTH}"> ['NOV', 0,'red',0, 'Average % : 0'], </c:if>
         <c:if test="${12 lt MTH}">  ['DEC', 0,'red',0, 'Average % : 0'], </c:if>

	     </c:otherwise>
	     </c:choose>
		// ['${fcast_div}', ${fcast_main},${fcast_invoice}],
		 
		 ]);
	 
	 
		 var options = {
				  'title':'Curr. Year Analysis',
				  'vAxis': {title: 'Accuracy % ',titleTextStyle: {italic: false},format: 'short',viewWindow:{min:0},ticks:[0,20,40,60,80,100]},
				  hAxis: { slantedText:true, slantedTextAngle:90 },
                 'is3D':true,
                 titleTextStyle: {
       		      color: '#000',
       		      fontSize: 10,
       		      fontName: 'Arial',
       		      bold: true
       		   },
                  'chartArea': {
				        top: 30,
				        right: 12,
				        bottom: 48,
				        left: 50,
				        height: '100%',
				        width: '100%'
				      },
				     
				      'height': 180,
				      'legend': {
				        position: 'top'
				      }
               ,colors: ['#01b8aa', '#EF851C'],
               
               pointSize:2,
               series: {
                   0: { pointShape: 'circle' },
                   1: { pointShape: 'triangle', pointSize:0 }
                   
               }
                };
 

 // Instantiate and draw our chart, passing in some options.
 var chart = new google.visualization.LineChart(document.getElementById('forecast-graph'));
 chart.draw(data, options);
 }
 function drawBillingtestSummary_graph() {
	 
	 var data = google.visualization.arrayToDataTable([
         ['Year', 'Target',{ role: 'annotation' },'Actual',{role:'annotation'}],
         ['${CURR_YR - 2}',  ${billinglst2yrs_yr2t},  <fmt:formatNumber type='number'  pattern = '###.##' value='${billinglst2yrs_yr2t/1000000}'/>, ${billinglst2yrs_yr2a} , <fmt:formatNumber type='number'  pattern = '###.##' value='${billinglst2yrs_yr2a/1000000}'/> ],
         ['${CURR_YR - 1}',   ${billinglst2yrs_yr1t},  <fmt:formatNumber type='number'  pattern = '###.##' value='${billinglst2yrs_yr1t/1000000}'/>, ${billinglst2yrs_yr1a}, <fmt:formatNumber type='number'  pattern = '###.##' value='${billinglst2yrs_yr1a/1000000}'/>],
         ['${CURR_YR}',   ${billinglst2yrs_yr0t},  <fmt:formatNumber type='number'  pattern = '###.##' value='${billinglst2yrs_yr0t/1000000}'/>,${billinglst2yrs_yr0a},<fmt:formatNumber type='number'  pattern = '###.##' value='${billinglst2yrs_yr0a/1000000}'/>],
 
         
       ]);

       var options = {
    		   'title':'BILLING LAST 2 YEARS (YTD)',
    			 'colors': ['#607d8b','#9e9e9e'],
    			  titleTextStyle: {
    			      color: '#000',
    			      fontSize: 13,
    			      fontName: 'Arial',
    			      bold: true
    			   },
    			   annotations: {
   				    textStyle: {color: '#000',opacity: 0.8}
   				  },
    			 'vAxis': {title: 'Value->',
    		        titleTextStyle: {italic: false},viewWindow:{ min:0},
    				 format: 'short'}, 
    				 'legend':'top', 
    				 'chartArea': { top: 70, right: 12,  bottom: 28, left: 60,  height: '100%', width: '100%'  }, 
    				 'height':230
    			      
    				 };
       var chart = new google.visualization.ColumnChart(document.getElementById('billing'));

       chart.draw(data, options);
       
       google.visualization.events.addListener(chart, 'onmouseover', agingMousehandler1); 
   	google.visualization.events.addListener(chart, 'onmouseout', agingMousehandler2); 
   	google.visualization.events.addListener(chart, 'select', selectHandler);
   	function agingMousehandler1() {$('#jihv').css('cursor','pointer');} 
   	function agingMousehandler2() {$('#jihv').css('cursor','default');}
   	function selectHandler() { 
   		 <!--alert('${DFLTDMCODE}');-->
   		 $('#laoding').show();
   		 var year_data;
   		 var selection = chart.getSelection(); var message = '';
   		 for (var i = 0; i < selection.length; i++) {  var item = selection[i];
   		 if (item.row != null && item.column != null) {
   			 var str = data.getFormattedValue(item.row, item.column); 
   			 year_data = data.getValue(chart.getSelection()[0].row, 0)
   		    
   		     } 
   		 else if (item.row != null) {
   			 var str = data.getFormattedValue(item.row, 0); 
   		 } else if (item.column != null) { 
   			 var str = data.getFormattedValue(0, item.column);
   		   
   		     } } //alert(year_data);
   		
   		     var division_header='${DIVDEFTITL}';
   		 var ttl="<b>Billing Details of  "+division_header+"</b><strong style='color:blue;'> </strong> Division for "+year_data+" <strong style='color:blue;'>  </strong> ";
   		 var exclTtl="Billing Details of  ${DIVDEFTITL}  Division for year "+year_data;
   		 $("#qtn-loi-modal-graph .modal-title").html(ttl); $.ajax({ type: 'POST',url: 'sipDivision',  data: {octjf: "lyer2BlngDtls", subDivn:"${DIVDEFTITL}", yrVal:year_data,dmCode:'${DFLTDMCODE}'},  dataType: "json",
   		 success: function(data) {
   			
   			 $('#laoding').hide();
   			
   			 var output="<table id='blngSubDivnTable' class='table table-bordered small'><thead><tr><th>#</th><th>Company</th>"+
   			 "<th>Week</th><th>Document ID</th><th>Document Date</th><th>Sales Eng.</th>"+
   			 "<th>Division</th>"+ "<th>Party Name</th>"+ "<th>Contact</th>"+ "<th>Telephone</th>"+
   			 "<th>Project</th>"+ "<th>Product</th>"+ "<th>Zone</th>"+ "<th>Currency</th>"+"<th>Amount</th>"+
   		 "</tr></thead><tbody>";
   		 
   		 var j=0; for (var i in data) { j=j+1;
   		 
   		 output+="<tr><td>"+j+"</td><td>" + $.trim(data[i].d1) + "</td><td>" + $.trim(data[i].d2) + "</td><td>" + $.trim(data[i].d3) + "</td>"+
   		"<td>" + $.trim(data[i].d4.substring(0, 10)).split("-").reverse().join("/") + "</td><td>" + $.trim(data[i].d5)+"-" +$.trim(data[i].d6)+ "</td>"+"<td>" + $.trim(data[i].d8) + "</td><td>" + $.trim(data[i].d9) + "</td>"+
   		"<td>" + $.trim(data[i].d10) + "</td><td>" + $.trim(data[i].d11) + "</td>"+"<td>" + $.trim(data[i].d12) + "</td><td>" + $.trim(data[i].d13) + "</td>"+
   		"<td>" + $.trim(data[i].d14) + "</td><td>" + $.trim(data[i].d15) + "</td>"+"<td>" + $.trim(data[i].d16) + 
   		 "</tr>"; } 
   		 output+="</tbody></table>";
   		 

   		 $("#qtn-loi-modal-graph .modal-body").html(output);
   		 $("#qtn-loi-modal-graph").modal("show");	
   		 
   			    $('#blngSubDivnTable').DataTable( {
   			        dom: 'Bfrtip',
   			     "columnDefs" : [{"targets": [4], "type":"date-eu"}],
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
   		 //start  script for deselect column - on modal close
   		 chart.setSelection([{'row': null, 'column': null}]); 
   		 //end  script for deselect column - on modal close
   		 }
       
     }
 function drawBookingtestSummary_graph() {
	 
	 var data = google.visualization.arrayToDataTable([
         ['Year', 'Target',{ role: 'annotation' },'Actual', { role: 'annotation' }],
        
         ['${CURR_YR - 2}', ${bknglst2yrs_yr2t}, <fmt:formatNumber type='number'  pattern = '###.##' value='${bknglst2yrs_yr2t/1000000}'/>, ${bknglst2yrs_yr2a}, <fmt:formatNumber type='number'  pattern = '###.##' value='${bknglst2yrs_yr2a/1000000}'/>],
         ['${CURR_YR - 1}', ${bknglst2yrs_yr1t},<fmt:formatNumber type='number'  pattern = '###.##' value='${bknglst2yrs_yr1t/1000000}'/>, ${bknglst2yrs_yr1a},<fmt:formatNumber type='number'  pattern = '###.##' value='${bknglst2yrs_yr1a/1000000}'/>],
         ['${CURR_YR}',    ${bknglst2yrs_yr0t}, <fmt:formatNumber type='number'  pattern = '###.##' value='${bknglst2yrs_yr0t/1000000}'/>,${bknglst2yrs_yr0a},<fmt:formatNumber type='number'  pattern = '###.##' value='${bknglst2yrs_yr0a/1000000}'/>],
         
   
         
       ]);
	
       var options = {
    		   'title':'BOOKING LAST 2 YEARS (YTD) ',
    			 'colors': ['#795548','#9e9e9e'],
    			  titleTextStyle: {
    			      color: '#000',
    			      fontSize: 13,
    			      fontName: 'Arial',
    			      bold: true,
    			     
    			   },
    			   annotations: {
    				    textStyle: { color: '#000',opacity: 0.8}
    				  },
    			 'vAxis': {title: 'Value->',viewWindow:{min:0},
    		        titleTextStyle: {italic: false},
    				 format: 'short'}, 
    				 'legend':'top', 
    				 'chartArea': { top: 70, right: 12,  bottom: 28, left: 60,  height: '100%', width: '100%'  }, 
    				 'height':230
    			      
    				 };
       var chart = new google.visualization.ColumnChart(document.getElementById('booking'));

       chart.draw(data, options);
       
        google.visualization.events.addListener(chart, 'onmouseover', agingMousehandler1); 
      	google.visualization.events.addListener(chart, 'onmouseout', agingMousehandler2); 
      	google.visualization.events.addListener(chart, 'select', selectHandler);
      	function agingMousehandler1() {$('#jihv').css('cursor','pointer');} 
      	function agingMousehandler2() {$('#jihv').css('cursor','default');}
      	function selectHandler() { 
      		 <!--alert('${DFLTDMCODE}');-->
      		 $('#laoding').show();
      		 var year_data;
      		 var selection = chart.getSelection(); var message = '';
      		 for (var i = 0; i < selection.length; i++) {  var item = selection[i];
      		 if (item.row != null && item.column != null) {
      			 var str = data.getFormattedValue(item.row, item.column); 
      			 year_data = data.getValue(chart.getSelection()[0].row, 0)
      		    
      		     } 
      		 else if (item.row != null) {
      			 var str = data.getFormattedValue(item.row, 0); 
      		 } else if (item.column != null) { 
      			 var str = data.getFormattedValue(0, item.column);
      		   
      		     } } //alert(year_data);
      		
      		     var division_header='${DIVDEFTITL}';
      		 var ttl="<b>Booking Details of  "+division_header+"</b><strong style='color:blue;'> </strong> Division for "+year_data+" <strong style='color:blue;'>  </strong> ";
      		 var exclTtl="Booking Details of  ${DIVDEFTITL}  Division for year "+year_data;
      		 $("#qtn-loi-modal-graph .modal-title").html(ttl); $.ajax({ type: 'POST',url: 'sipDivision',  data: {octjf: "lyer2BookingDtls", subDivn:"${DIVDEFTITL}", yrVal:year_data,dmCode:'${DFLTDMCODE}'},  dataType: "json",
      		 success: function(data) {
      			
      			 $('#laoding').hide();
      			
      			 var output="<table id='blngSubDivnTable' class='table table-bordered small'><thead><tr><th>#</th><th>Company</th>"+
      			 "<th>Week</th><th>Document ID</th><th>Document Date</th><th>Sales Eng.</th>"+
      			 "<th>Division</th>"+ "<th>Party Name</th>"+ "<th>Contact</th>"+ "<th>Telephone</th>"+
      			 "<th>Project</th>"+ "<th>Product</th>"+ "<th>Zone</th>"+ "<th>Currency</th>"+"<th>Amount</th>"+
      		 "</tr></thead><tbody>";
      		 
      		 var j=0; for (var i in data) { j=j+1;
      		 
      		 output+="<tr><td>"+j+"</td><td>" + $.trim(data[i].d1) + "</td><td>" + $.trim(data[i].d2) + "</td><td>" + $.trim(data[i].d3) + "</td>"+
      		"<td>" + $.trim(data[i].d4.substring(0, 10)).split("-").reverse().join("/") + "</td><td>" + $.trim(data[i].d5)+"-" +$.trim(data[i].d6)+ "</td>"+"<td>" + $.trim(data[i].d8) + "</td><td>" + $.trim(data[i].d9) + "</td>"+
      		"<td>" + $.trim(data[i].d10) + "</td><td>" + $.trim(data[i].d11) + "</td>"+"<td>" + $.trim(data[i].d12) + "</td><td>" + $.trim(data[i].d13) + "</td>"+
      		"<td>" + $.trim(data[i].d14) + "</td><td>" + $.trim(data[i].d15) + "</td>"+"<td>" + $.trim(data[i].d16) + 
      		 "</tr>"; } 
      		 output+="</tbody></table>";
      		 

      		 $("#qtn-loi-modal-graph .modal-body").html(output);
      		 $("#qtn-loi-modal-graph").modal("show");	
      		 
      			    $('#blngSubDivnTable').DataTable( {
      			        dom: 'Bfrtip',
      			     "columnDefs" : [{"targets": [4], "type":"date-eu"}],
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
      		 //start  script for deselect column - on modal close
      		 chart.setSelection([{'row': null, 'column': null}]); 
      		 //end  script for deselect column - on modal close
      		 }
       
     }
 
 

 

 function show2ndLayerQtnLost(aging_header,agingVal) { 
	 <!--alert('${DFLTDMCODE}');-->
 $('#laoding').show();
 
     var division_header='${DIVDEFTITL}';
 var ttl="<b>JIH Quotation Lost Details of "+division_header+"</b><strong style='color:blue;'> </strong> Division for "+aging_header+" <strong style='color:blue;'>  </strong> ";
 var exclTtl="JIH Quotation Lost Details of  ${DIVDEFTITL}  Division";
 $("#qtn_lost_modal-main .modal-title").html(ttl); $.ajax({ type: 'POST',url: 'sipDivision',  data: {octjf: "tdvhij",d2:'${DFLTDMCODE}',avfad:agingVal , dcvfad:'${DIVDEFTITL}'}, dataType: "json",
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
 "<td>" +$.trim(data[i].d12.substring(0, 10)).split("-").reverse().join("/") + "</td><td>" + data[i].d13 + "</td>"+ "<td>" + data[i].d14 + "</td><td>" + data[i].d15 + "</td><td>" + data[i].d16 + "</td><td align='right'>" + formatNumber(data[i].d17) + "</td></tr>"; } //output+="<tr><td colspan='17'><b>Total</b></td><td><b style='color:blue;'>"+str+"</b></td></tr>"; 
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

 </script>

<!--  .graph activities end..  -->
</head>
<c:choose>
	<c:when
		test="${!empty fjtuser.emp_code and !empty fjtuser.sales_code and (fjtuser.role eq 'mg' or fjtuser.salesDMYn ge 1 )  and fjtuser.checkValidSession eq 1}">

		<c:set var="booking_Curr_Mnth_Perc" value="0" scope="page" />
		<c:set var="booking_Ytd_Perc" value="0" scope="page" />
		<c:set var="booking_Curr_Mnth_Actual" value="0" scope="page" />
		<c:set var="booking_Curr_Mnth_Target" value="0" scope="page" />

		<c:if test="${BKNGS ne null}">
			<c:forEach var="bksum" items="${BKNGS}">
				<c:choose>
					<c:when test="${bksum.month_perc eq 99}">
						<c:set var="booking_Curr_Mnth_Perc" value="100" scope="page" />
					</c:when>
					<c:otherwise>
						<c:set var="booking_Curr_Mnth_Perc" value="${bksum.month_perc}" scope="page" />
					</c:otherwise>
				</c:choose>
				<c:set var="booking_Ytd_Perc" value="${bksum.ytd_perc}" scope="page" />
				<c:set var="booking_Curr_Mnth_Actual" value="${bksum.month_actual}" scope="page" />
				<c:set var="booking_Curr_Mnth_Target" value="${bksum.month_target}" scope="page" />
			</c:forEach>
		</c:if>

		<c:set var="billing_Curr_Mnth_Perc" value="0" scope="page" />
		<c:set var="billing_Ytd_Perc" value="0" scope="page" />
		<c:set var="billing_Curr_Mnth_Actual" value="0" scope="page" />
		<c:set var="billing_Curr_Mnth_Target" value="0" scope="page" />
		<c:set var="billing_ytm_Actual" value="0" scope="page" />
		<c:set var="billing_ytm_Target" value="0" scope="page" />
		<c:if test="${BILLNG ne null}">
			<c:forEach var="billngsum" items="${BILLNG}">
				<c:choose>
					<c:when test="${billngsum.month_perc eq 99}">
						<c:set var="billing_Curr_Mnth_Perc" value="100" scope="page" />
					</c:when>
					<c:otherwise>
						<c:set var="billing_Curr_Mnth_Perc" 	value="${billngsum.month_perc}" scope="page" />
					</c:otherwise>
				</c:choose>

				<c:set var="billing_Ytd_Perc" value="${billngsum.ytd_perc}" 	scope="page" />
				<c:set var="billing_Curr_Mnth_Actual" value="${billngsum.month_actual}" scope="page" />
				<c:set var="billing_Curr_Mnth_Target" 	value="${billngsum.month_target}" scope="page" />
				<c:set var="billing_ytm_Actual" value="${billngsum.ytm_actual}" scope="page" />
				<c:set var="billing_ytm_Target" value="${billngsum.ytm_target}" scope="page" />
			</c:forEach>
		</c:if>

		<body class="hold-transition skin-blue sidebar-mini">
			<div class="container">
				<div class="wrapper">

					<header class="main-header" style="background-color: #367fa9;">
						<!-- Logo -->
						<a href="#" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels -->
							<span class="logo-mini"><b>FJ</b>D</span> <!-- logo for regular state and mobile devices -->
							<span class="logo-lg"><b>Dashboard</b></span>
						</a>
						<!-- Header Navbar: style can be found in header.less -->
						<nav class="navbar navbar-static-top">
							<!-- Sidebar toggle button-->
							<a href="#" class="sidebar-toggle" data-toggle="push-menu"
								role="button"> <span class="sr-only">Toggle
									navigation</span> <span class="icon-bar"></span> <span
								class="icon-bar"></span> <span class="icon-bar"></span>
							</a>

					           <c:if test="${fjtuser.role eq 'mg'}">
						       <form method="post" action="sipDivision">
						      	<div class="fj_mngmnt_dm_div pull-right">
								   <select class="fj_mngmnt_dm_slctbx" name="dmCodemgmnt" id="dmCode_mg" onchange="preLoader();this.form.submit()" required>
								   <option>Select Division Managers</option>
						  			<c:forEach var="dm_List"  items="${DmsLstFMgmnt}" >
									<option value="${dm_List.dmEmp_Code}" ${dm_List.dmEmp_Code  == DFLTDMCODE ? 'selected':''}> ${dm_List.dmEmp_name}</option>
						  			</c:forEach>
						   			</select>
						   		</div>
						   		<input type="hidden" name="octjf" value="dmfsltdmd">
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
             <c:when test="${fjtuser.role eq 'mg' and fjtuser.sales_code ne null}"> 
      		 	 <li><a href="SipBranchPerformance"><i class="fa fa-building-o"></i><span>Branch Performance</span></a></li> 
                 <li><a href="DmInfo.jsp"><i class="fa fa-dashboard"></i><span>Sales Engineers Performance</span></a></li>
                 <li><a href="SalesManagerInfo.jsp"><i class="fa fa-dashboard"></i><span>Sales Manager Performance</span></a></li>
				 <li class="active"><a href="DisionInfo.jsp"><i class="fa fa-line-chart"></i><span>Sub Division Performance</span></a></li>
				 <li><a href="CompanyInfo.jsp?empcode=${DFLTDMCODE}"><i class="fa fa-pie-chart"></i><span>Division 	Performance</span></a></li>
				 <li><a href="SipUserActivity"><i class="fa fa-table"></i><span>SE Activity History</span></a></li>
<!-- 				 <li><a href="SipJihDues"><i class="fa fa-table"></i><span>JIH Dues</span></a></li> -->
<!-- 				 <li><a href="SipLOIDues"><i class="fa fa-table"></i><span>LOI Dues</span></a></li> -->
				 <li><a href="SipStageFollowUpController"><i class="fa fa-database"></i><span>Stage Follow-Up</span></a></li>  
				 <li><a href="sipWeeklyReport"><i class="fa fa-bar-chart"></i><span>Weekly-Sales Report</span></a></li> 
				 <li><a href="ProjectStatus"><i class="fa fa fa-bars"></i><span>Project Status</span></a></li> 
				 <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>
               </c:when>
               <c:when test="${fjtuser.salesDMYn ge 1 and fjtuser.sales_code ne null}">
                <c:if test="${fjtuser.role eq 'gm'}">
      		 	<li><a href="SipBranchPerformance"><i class="fa fa-building-o"></i><span>Branch Performance</span></a></li>
      			</c:if>
                 <li><a href="DmInfo.jsp"><i class="fa fa-dashboard"></i><span>Sales Engineers Performance</span></a></li>
                 <c:if test="${isAllowed eq 'Yes' || fjtuser.salesDMYn ge 1}">
      		 		<li><a href="SalesManagerInfo.jsp"><i class="fa fa-building-o"></i><span>Sales Manager Performance</span></a></li>
      			</c:if>
				 <li class="active"><a href="DisionInfo.jsp"><i class="fa fa-line-chart"></i><span>Sub Division Performance</span></a></li>
				 <li><a href="CompanyInfo.jsp?empcode=${DFLTDMCODE}"><i class="fa fa-pie-chart"></i><span>Division 	Performance</span></a></li>
				 <li><a href="SipUserActivity"><i class="fa fa-table"></i><span>SE Activity History</span></a></li>
<!-- 				 <li><a href="SipJihDues"><i class="fa fa-table"></i><span>JIH Dues</span></a></li> -->
<!-- 				 <li><a href="SipLOIDues"><i class="fa fa-table"></i><span>LOI Duesgh</span></a></li> -->
				 <li><a href="SipStageFollowUpController"><i class="fa fa-database"></i><span>Stage Follow-Up</span></a></li> 
				 <li><a href="sipWeeklyReport"><i class="fa fa-bar-chart"></i><span>Weekly-Sales Report</span></a></li>
				 <li><a href="ProjectStatus"><i class="fa fa fa-bars"></i><span>Project Status</span></a></li> 
				 <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>  
               </c:when>
               <c:otherwise>
				  <li><a href="DmInfo.jsp"><i class="fa fa-dashboard"></i><span>Sales Engineers Performance</span></a></li> 
<!-- 				  <li><a href="SipJihDues"><i class="fa fa-table"></i><span>JIH Dues</span></a></li> -->
<!-- 				  <li><a href="SipLOIDues"><i class="fa fa-table"></i><span>LOI Duesgh</span></a></li> -->
				  <li><a href="SipStageFollowUpController"><i class="fa fa-database"></i><span>Stage Follow-Up</span></a></li>
				  <li><a href="ProjectStatus"><i class="fa fa fa-bars"></i><span>Project Status</span></a></li>  
				  <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>
               </c:otherwise>               
              </c:choose>
								
								
								<!--  <li><a href="Receivables"><i class="fa fa-th"></i><span>Receivables</span></a></li>
            <li><a href="#"><i class="fa fa-edit"></i><span>Inventory Aging</span></a></li>
            <li><a href="#"><i class="fa fa-book"></i><span>P&L and Operating Expenses</span></a></li>
       -->

							</ul>
						</section>
						<!-- /.sidebar -->
					</aside>





					<!-- Main content -->
					<div class="content-wrapper" style="margin-top: -20px;">



						<div class="row" style="margin-right: 30px;">
							<div class="col-md-12"
								style="background: white; margin-left: 15px; box-shadow: 0 1px 1px rgba(0, 0, 0, 0.1); margin-top: 20px;">
								<div class="row" style="padding-top: 7px;">
									<div class="col-md-4 col-xs-12">
										<h5 class="divheader"
											style="font-family: sans-serif; width: fit-content; font-weight: bold; color: #0065b3;">Sub Division
											Performance - ${DIVDEFTITL}</h5>
									</div>
									<div class="col-md-4">
										<form class="form-inline" method="post" action="sipDivision">

											<input type="hidden" id="octjf" name="octjf" value="rtlfvid" />
											<input type="hidden" id="dmmain" name="d2" value="${DFLTDMCODE}" />
                                            

											<div class="form-group">

												<select class="form-control form-control-sm"
													id="division_list" name="tslvid" required>
													<option value="">Select Sub Division</option>
													<c:forEach var="divisions" items="${DIVLST}">
														<option value="${divisions.div_code}"
															${divisions.div_code  == selected_division ? 'selected':''}>${divisions.div_desc}</option>

													</c:forEach>



												</select>

											</div>
											<div class="form-group">
												<button type="submit" class="btn btn-primary"
													onclick="preLoader();">Refresh</button>
											</div>
										</form>
									</div>
									 <div class="col-md-4">
							  			<ul class="nav nav-tabs pull-left" style="border: 1px solid #3c8dbc;font-weight: bold;width: max-content !important;">
							        		 <li  class="active pull-right" style="margin-bottom: 0px !important;"><a data-toggle="tab" href="#forecastgph"  style="border-right:transparent;" >Forecast Details</a></li>
							         		 <li class="pull-right"><a data-toggle="tab" href="#stages-dt" onclick="s34Summary();">Stage Details</a></li>
							            </ul>
							         </div>
								</div>
							</div>

						</div>
            
					  
           <div class="row"  style="margin-right: 30px;">
       <div  class="col-lg-12 col-md-12 col-sm-12 fjtco-rcvbles"  style="padding:7px;    margin-right: 30px;">
   <c:forEach var="rcvbl_list_date"  items="${ORAR}" > <c:set var="rcvble_date" value="${rcvbl_list_date.pr_date}" scope="page" /> </c:forEach>
   
    <c:set var ="recievable_date" value = "${fn:substring(rcvble_date, 0, 10)}" />
   
 <b style="font-size:14px !important;font-weight:bold !important;"> Outstanding Receivable Aging  (Value in base local currency)  > 100AED&nbsp;</b> <i>As on 

<fmt:parseDate value="${rcvble_date}" var="theDate"    pattern="yyyy-MM-dd HH:mm" />
<fmt:formatDate value="${theDate}" pattern="dd-MM-yyyy, HH:mm"/>
   AM</i>
 	<div style="z-index: 50;background: rgba(255, 255, 255, 0.7); border: 2px solid #3c8dbc; font-size: 15px; color: #3c8dbc;position: absolute; padding: 2px 4px 2px 2px;cursor: pointer;top: 2px;right: 19px; border-radius: 5px;"id="help-outsanding"><i class="fa fa-info-circle pull-right"></i></div>			  
           <div class="row">
     
					<div class="col-lg-2 col-md-3 col-sm-3 col-xs-12 paddingr-0" id="agwdth110">
						<div class="panel panel-default card-view pa-0">
							<div class="panel-wrapper collapse in">
								<div class="panel-body pa-0">
									<div class="sm-data-box">
										<div class="container-fluid">
											<div class="row">
													<span class="weight-500 font-13"><30 Days</span><br/>
													<span class="counter-anim" onclick="show2ndLayerOutRcvbles('${DIVDEFTITL}','30','<30 Days');"><fmt:formatNumber pattern="#,###" value="${aging30}" /></span>		
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
													<span class="weight-500">30-60 Days</span><br/>
													<span class="counter-anim"  onclick="show2ndLayerOutRcvbles('${DIVDEFTITL}','3060','30 - 60 Days');"><fmt:formatNumber pattern="#,###" value="${aging3060}" /></span>
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
													<span class="counter-anim" onclick="show2ndLayerOutRcvbles('${DIVDEFTITL}','6090','61 - 90 Days');"><fmt:formatNumber pattern="#,###" value="${aging6090}" /></span>
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
													<span class="counter-anim"  onclick="show2ndLayerOutRcvbles('${DIVDEFTITL}','90120','91 - 120 Days');"><fmt:formatNumber pattern="#,###" value="${aging90120}" /></span>
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
														<span class="counter-anim"  onclick="show2ndLayerOutRcvbles('${DIVDEFTITL}','120180','121 - 180 Days');"><fmt:formatNumber pattern="#,###" value="${aging120180}" /></span>
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
													<span class="counter-anim"  onclick="show2ndLayerOutRcvbles('${DIVDEFTITL}','181','>180 Days');"><fmt:formatNumber pattern="#,###" value="${aging181}" /></span>
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

	 
						<div class="row">
							<div class="col-md-6">
								<!--JIHV CHART -->
								<div class="box box-primary"
									style="margin-top: 10px; border-top-color: #9e9e9e;">
									<div class="box-header with-border">
										<h3 class="box-title">JIH to LOST Analysis</h3>
										<div class="help-right-lost" id="help-qtnlost">
											<i class="fa fa-info-circle pull-left"></i>
										</div>
									</div>
									<div class="box-body">
										<div class="chart">
											<div id="jihv" style="margin-top: 0px; height: 211px;">
												<table>
												<c:choose>
												<c:when test="${!empty JIHV}">
													<c:forEach var="JOBV" items="${JIHV}">
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
												<a href="#" data-toggle="modal" data-target="#jihvlostDtls">More
													info <i class="fa fa-arrow-circle-right"></i>
												</a>
											</div>
										</div>
									</div>
									<!-- /.box-body -->
								</div>
								<!-- /.box -->

								<!-- Booking CHART -->
								<div class="box box-primary"
									style="margin-top: 10px; border-top-color: #9e9e9e;">

									<div class="box-body">
										<div class="chart">
											<div class="col-xs-8 col-md-8 text-center"
												style="padding-right: 5px; padding-left: 0;">



												<div id="booking"></div>
												<div class="row"
													style="border: 1px solid #795548; text-align: center;">
													<div class="fj-box"
														style="font-size: 85%; background: #795548; font-weight: bold; color: white; text-align: center;">Avg.
														Booking of Last 2 Years</div>
													<c:set var="avgbknglsttwoyr" value="${bknglst2yrs_yr1a + bknglst2yrs_yr2a}" />
													<fmt:formatNumber type="number"
														value="${avgbknglsttwoyr / 2 }" />
												</div>
												<div class="help-left" id="help-booking">
													<i class="fa fa-info-circle pull-left"></i>
												</div>
												<a href="#" class="small-box-footer" data-toggle="modal"
													data-target="#bookingDtls">More info <i class="fa fa-arrow-circle-right"></i></a>
											</div>
											<div class="col-xs-4 col-md-4 text-center"
												style="padding-right: 0; padding-left: 0;">
												<div class="row"
													style="border: 1px solid #795548; text-align: center;">
													<div class="fj-box"
														style="font-size: 85%; background: #795548; font-weight: bold; color: white; text-align: center;">

														Booking Curr. Month</div>
													<span>Target : <fmt:formatNumber type="number"
															value="${booking_Curr_Mnth_Target}" /></span><br />
													<span> Actual : <fmt:formatNumber type="number"
															value="${booking_Curr_Mnth_Actual}" />
													</span>

												</div>

												<div class="row fj-bk-per"
													style="border: 1px solid #795548; padding: 5px; padding-left: 22%; padding-right: 22%; margin-top: 4px;">
													<c:choose>
														<c:when test="${booking_Curr_Mnth_Perc > 100}">
															<input type="text" class="knob"
																value="${booking_Curr_Mnth_Perc}"
																data-max="${booking_Curr_Mnth_Perc}" data-width="85"
																data-height="85" data-fgColor="#795548"
																data-readonly="true" data-angleArc="250"
																data-angleOffset="-125">
														</c:when>
														<c:otherwise>
															<input type="text" class="knob"
																value="${booking_Curr_Mnth_Perc}" data-width="85"
																data-height="85" data-fgColor="#795548"
																data-readonly="true" data-angleArc="250"
																data-angleOffset="-125">
														</c:otherwise>
													</c:choose>
													<div class="knob-label"
														style="margin-top: -20px; font-size: 11px;">Curr.
														Month %</div>
												</div>
												<div class="row fj-bk-per"
													style="border: 1px solid #795548; padding: 5px; padding-left: 22%; padding-right: 22%; margin-top: 4px;">
													<c:choose>
														<c:when test="${booking_Ytd_Perc > 100}">
															<input type="text" class="knob"
																value="${booking_Ytd_Perc}"
																data-max="${booking_Ytd_Perc}" data-width="85"
																data-height="85" data-fgColor="#795548"
																data-readonly="true" data-angleArc="250"
																data-angleOffset="-125">
														</c:when>
														<c:otherwise>
															<input type="text" class="knob"
																value="${booking_Ytd_Perc}" data-width="85"
																data-height="85" data-fgColor="#795548"
																data-readonly="true" data-angleArc="250"
																data-angleOffset="-125">
														</c:otherwise>
													</c:choose>
													<div class="knob-label"
														style="margin-top: -20px; font-size: 9px;">BOOKING
														VS TARGET YTD %</div>
												</div>
											</div>

										</div>
									</div>
									<!-- /.box-body -->
								</div>
								<!-- /.box -->


								<!-- Enquiry to Qtn CHART -->
								<div class="box box-primary"
									style="margin-top: 10px; border-top-color: #9e9e9e;">

									<div class="box-body">
										<div class="chart">




											<div id="enq_to_qtn"
												style="margin-top: 0px; margin-left: 0px; height: 230px;"></div>
											<div class="help-right" id="help-enqToqtn">
												<i class="fa fa-info-circle pull-left"></i>
											</div>
											<div class="overlay">
												<a href="#" data-toggle="modal"
													data-target="#enq_to_qtn_modal">More info <i
													class="fa fa-arrow-circle-right"></i></a>
											</div>
										</div>

									</div>
									<!-- /.Enquiry  box-body -->
								</div>
								<!-- /.Enquiry  box end -->
								<!-- Loi to So CHART -->
								<div class="box box-primary"
									style="margin-top: 10px; border-top-color: #9e9e9e;">

									<div class="box-body">
										<div class="chart">




											<div id="loi_to_so"
												style="margin-top: 0px; margin-left: 0px; height: 230px;"></div>
											<div class="help-right" id="help-loiToso">
												<i class="fa fa-info-circle pull-left"></i>
											</div>
											<div class="overlay">
												<a href="#" data-toggle="modal"
													data-target="#loi_to_so_modal">More info <i
													class="fa fa-arrow-circle-right"></i></a>
											</div>
										</div>

									</div>
									<!-- /.Loi to So box-body -->
								</div>
								<!-- /.Loi to So box end -->

							</div>
							<!-- /.col (LEFT) -->
							<div class="col-md-6">
								
										 <!-- Stage 3 4 CHART -->
								         
								          <!-- Custom tabs (Charts with tabs)-->
								        <section style="margin-top: 8px;border-top: 3px solid #9e9e9e; border-radius: 3px;margin-bottom: 5px;">
								         <div class="nav-tabs-custom" >								        
								           <div class="tab-content" style="height: 274px;">
									           <div id="stages-dt" class="tab-pane fade">
											   	   <div class="box-header with-border" style="margin-top: -18px;"> 
												      <h3 class="box-title">STAGE DETAILS </h3>
												        <div class="help-right" id="help-stages">
															<i class="fa fa-info-circle pull-left"></i>
														</div>
												  </div>
									             <div class="row">
									             	<!-- commented as part of RK comments implementation -->	
										             <!-- <div class="col-lg-6 col-xs-6">
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
										              <div class="inner"><h3>Stage 2</h3><p> <strong><fmt:formatNumber type="number"  pattern="#,###.##" value="${JIHVD/1000000}" />M</strong></p>
										              <input type="hidden" id="s2sum_temp" value="${JIHVD}" />
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
									                  <h3>Stage 4</h3><p id="s4sum"></p>
									                  <input type="hidden" id="s4sum_temp" value="0" />
									                  <input type="hidden" id="s4sumnoformat" value="0" />
									                  </div> <div class="icon"><i class="fa fa-pie-chart"></i></div>
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
									           </div>

									
										<div class="tab-pane fade  in active" id="forecastgph">
											<div class="box-header with-border">
												<h3 class="box-title">Forecasted vs Billing Analysis
													-${CURR_YR}</h3>
												<div class="help-right" id="help-frcst" style="">
													<i class="fa fa-info-circle pull-left"></i>
												</div>
											</div>


											<div id="forecast-graph"class="tab-pane fade  in active" 
												style="margin-top: 1px; height: 183px; float: left; width: 70%; margin-right: 5px; border: 1px solid gray; padding-right: 5px;"></div>

											<div id="forecast-mth-dt">
												<div class="row"
													style="margin-bottom: 5px; font-size: 80%; font-weight: bold;">
													<strong>${CURR_MTH}-${CURR_YR} Analysis</strong>
												</div>
												<div class="row"
													style="border: 1px solid #0065b3; text-align: center; font-weight: bold;">
													<div class="jj"
														style="background: #0065b3; font-weight: bold; color: white; text-align: center;">Forecast
													</div>
													<c:choose>
														<c:when test="${fcast_main eq  0}"> Not set</c:when>
														<c:when test="${fcast_main eq null }"> Not set</c:when>
														<c:otherwise>
															<fmt:formatNumber type="number" value="${fcast_main}" />
														</c:otherwise>
													</c:choose>

												</div>
												<div class="row"
													style="border: 1px solid #0065b3; text-align: center; font-weight: bold; margin-top: 4px;">
													<div class="jj"
														style="background: #0065b3; color: white; font-weight: bold; text-align: center;">Billing</div>

													<c:choose>
														<c:when test="${fcast_invoice eq  0}"> 0</c:when>
														<c:when test="${fcast_main eq null }"> 0</c:when>
														<c:otherwise>
															<fmt:formatNumber type="number" value="${fcast_invoice}" />
														</c:otherwise>
													</c:choose>
												</div>
												<div class="row"
													style="border: 1px solid #0065b3; text-align: center; font-weight: bold; margin-top: 4px;">
													<div class="jj"
														style="background: #0065b3; color: white; font-weight: bold; text-align: center;">Actual
														%</div>
													<div class="row fj-bk-per"
														style="padding: 5px; margin-top: 4px; height: 30px;">
														<div class="progress"
															style="border: 1px solid #fff; background: #01b8aa;">
															<c:choose>
																<c:when test="${fcast_perc > 0 }">
																	<div class="progress-bar progress-bar-striped active"
																		role="progressbar" aria-valuenow="${fcast_perc}"
																		aria-valuemin="0" aria-valuemax="${fcast_perc}"
																		style="width:${fcast_perc}%;background:black;">
																		${fcast_perc}%</div>
																</c:when>
																<c:when test="${fcast_perc eq null}">
																	<div class="progress-bar progress-bar-striped active"
																		role="progressbar" aria-valuenow="0" aria-valuemin="0"
																		aria-valuemax="100"
																		style="width: 0%; color: white !important; background: black;">
																		0%</div>
																</c:when>
																<c:when test="${fcast_perc eq 0}">
																	<div class="progress-bar progress-bar-striped active"
																		role="progressbar" aria-valuenow="0" aria-valuemin="0"
																		aria-valuemax="100"
																		style="width: 0%; color: white !important; background: black;">
																		0%</div>
																</c:when>
																<c:otherwise>
																	<div class="progress-bar progress-bar-striped active"
																		role="progressbar" aria-valuenow="${fcast_perc}"
																		aria-valuemin="0" aria-valuemax="100"
																		style="width:${fcast_perc}%;background:black;">
																		${fcast_perc}%</div>
																</c:otherwise>
															</c:choose>
														</div>
													</div>
												</div>

											</div>											
											<div class="row">
												<a href="#" class="small-box-footer" data-toggle="modal"
													data-target="#modal-default">More info <i
													class="fa fa-arrow-circle-right"></i></a>
											</div>
											<!-- /.box-body -->
										</div>
										
								
							 </div>
								     
						  </div>
				   </section>
            
								
								


								<!-- BILLING CHART -->
								<div class="box box-primary"
									style="margin-top: 10px; border-top-color: #9e9e9e;">

									<div class="box-body">
										<div class="chart">
											<div class="col-xs-8 col-md-8 text-center"
												style="padding-right: 5px; padding-left: 0;">


												<div id="billing"></div>
												<div class="row"
													style="border: 1px solid #607d8b; text-align: center;">
													<div class="fj-box"
														style="font-size: 85%; background: #607d8b; font-weight: bold; color: white; text-align: center;">Avg.
														Billing of Last 2 Years</div>
													<c:set var="avgbillinglsttwoyr"
														value="${billinglst2yrs_yr1a + billinglst2yrs_yr2a}" />
													<fmt:formatNumber type="number"
														value="${avgbillinglsttwoyr / 2 }" />
												</div>
												<div class="help-left" id="help-billing">
													<i class="fa fa-info-circle pull-left"></i>
												</div>
												<a href="#" class="small-box-footer" data-toggle="modal"
													data-target="#billingDtls">More info <i
													class="fa fa-arrow-circle-right"></i></a>
											</div>
											<div class="col-xs-4 col-md-4 text-center"
												style="padding-right: 0; padding-left: 0;">
												<div class="row"
													style="border: 1px solid #607d8b; text-align: center;">
													<div class="fj-box"
														style="font-size: 85%; background: #607d8b; font-weight: bold; color: white; text-align: center;">

														Billing Curr. Month</div>
													<span>Target : <fmt:formatNumber type="number"
															value="${billing_Curr_Mnth_Target}" /></span><br />
													<span> Actual : <fmt:formatNumber type="number"
															value="${billing_Curr_Mnth_Actual}" /></span>

												</div>

												<div class="row fj-bk-per"
													style="border: 1px solid #607d8b; padding: 5px; padding-left: 22%; padding-right: 22%; margin-top: 4px;">
													<c:choose>

														<c:when test="${billing_Curr_Mnth_Perc > 100 }">
															<input type="text" class="knob"
																value="${billing_Curr_Mnth_Perc}"
																data-max="${billing_Curr_Mnth_Perc}" data-width="85"
																data-height="85" data-fgColor="#607d8b"
																data-readonly="true" data-angleArc="250"
																data-angleOffset="-125">
														</c:when>
														<c:when test="${billing_Curr_Mnth_Perc < 0 }">
															<input type="text" class="knob"
																value="0"
																data-max="${billing_Curr_Mnth_Perc}" data-width="85"
																data-height="85" data-fgColor="#607d8b"
																data-readonly="true" data-angleArc="250"
																data-angleOffset="-125">
														</c:when>
														<c:otherwise>
															<input type="text" class="knob"
																value="${billing_Curr_Mnth_Perc}" data-width="85"
																data-height="85" data-fgColor="#607d8b"
																data-readonly="true" data-angleArc="250"
																data-angleOffset="-125">
														</c:otherwise>
													</c:choose>

													<div class="knob-label"
														style="margin-top: -20px; font-size: 11px;">Curr.
														Month %</div>
												</div>
												<div class="row fj-bk-per"
													style="border: 1px solid #607d8b; padding: 5px; padding-left: 22%; padding-right: 22%; margin-top: 4px;">
													<c:choose>
														<c:when test="${billing_Ytd_Perc > 100 }">
															<input type="text" class="knob"
																value="${billing_Ytd_Perc}" data-width="85"
																data-max="${billing_Ytd_Perc}" data-height="85"
																data-fgColor="#607d8b" data-readonly="true"
																data-angleArc="250" data-angleOffset="-125">
														</c:when>
														
														<c:when test="${billing_Ytd_Perc < 0 }">
															<input type="text" class="knob"
																value="${billing_Ytd_Perc}" data-width="85"
																data-max="${billing_Ytd_Perc}" data-height="85"
																data-fgColor="#607d8b" data-readonly="true"
																data-angleArc="250" data-angleOffset="-125">
														</c:when>
														<c:otherwise>
															<input type="text" class="knob"
																value="${billing_Ytd_Perc}" data-width="85"
																data-height="85" data-fgColor="#607d8b"
																data-readonly="true" data-angleArc="250"
																data-angleOffset="-125">
														</c:otherwise>
													</c:choose>
													<div class="knob-label"
														style="margin-top: -20px; font-size: 9px;">BILLING
														VS TARGET YTD %</div>
												</div>
											</div>

										</div>
									</div>
									<!-- /.box-body -->
								</div>
								<!-- /.billing box -->
								<!-- Qtn to LOI CHART -->
								<div class="box box-primary"
									style="margin-top: 10px; border-top-color: #9e9e9e;">
									<div class="box-body">
										<div class="chart">
											<div id="qtn_to_loi"
												style="margin-top: 0px; margin-left: 0px; height: 230px;"></div>
											<div class="help-right" id="help-jihToloi">
												<i class="fa fa-info-circle pull-left"></i>
											</div>
											<div class="overlay">
												<a href="#" data-toggle="modal"
													data-target="#qtn_to_loi_modal">More info <i
													class="fa fa-arrow-circle-right"></i></a>
											</div>
										</div>
									</div>
									<!-- /.QTN TO LOI  box-body -->
								</div>
								<!-- /.QTN TO LOI  box end -->
								<!-- ORDER to INVC CHART -->
								<div class="box box-primary"
									style="margin-top: 10px; border-top-color: #9e9e9e;">
									<div class="box-body">
										<div class="chart">
											<div id="order_to_invc"
												style="margin-top: 0px; margin-left: 0px; height: 230px;"></div>
											<div class="help-right" id="help-soToinvc">
												<i class="fa fa-info-circle pull-left"></i>
											</div>
											<div class="overlay">
												<a href="#" data-toggle="modal"
													data-target="#so_to_invc_modal">More info <i
													class="fa fa-arrow-circle-right"></i></a>
											</div>
										</div>
									</div>
									<!-- /.ORDER to INVC   box-body -->
								</div>
								<!-- /.ORDER to INVC  box end -->
							</div>
							<!-- /.col (RIGHT) -->
						</div>
						<!-- /.row -->
						
						<!-- stage details graph -->
						<div id="myModal" class="modal">
						  <div class="modal-content" style="width: 25%; height: 40%; margin-left: auto; margin-right: 25%;margin-top: 10%;">	
						  	<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">&times;</button>
				          		<h4 class="modal-title">Stage details of Sub Division - ${DIVDEFTITL} </h4>
				        	</div>	   
						    <div class="modal-body"> <div id="stagedetailsgraph"></div></div>
						  </div>
						</div>	   
						
						
						
						<!--  Modal start -->
						<div class="row" id="modal-graph">
							<div class="modal fade" id="editSGoal" role="dialog">
								<div class="modal-dialog" style="width: 97%;">
									<!-- Modal content-->
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal">&times;</button>
											<h4 class="modal-title">Job In Hand Volume Details</h4>
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
						<div class="row" id="modal-graph">
							<div class="modal fade" id="qtn-loi-modal-graph" role="dialog">

								<div class="modal-dialog" style="width: 97%;">
									<!-- Modal content-->
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal">&times;</button>
											<h4 class="modal-title">Job In Hand Volume Details</h4>
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
						<div class="row" id="modal-graph">
							<div class="modal fade" id="loi-order-modal-graph" role="dialog">
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
						<div class="row" id="modal-graph">
							<div class="modal fade" id="order-invoice-modal-graph"
								role="dialog">
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
						<div class="row" id="modal-graph">
							<div class="modal fade" id="qtn-lost-month-modal-graph"
								role="dialog">
								<div class="modal-dialog" style="width: 97%;">
									<!-- Modal content-->
									<div class="modal-content"
										style="height: calc(100% - 40%) !important;">
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
                  <div class="row">
					<div class="modal fade" id="stageDetails34" role="dialog" >
					
					        <div class="modal-dialog" style="width:97%;">
					     		<!-- Modal content-->
							      	<div class="modal-content">
								        	<div class="modal-header">
								         	 <button type="button" class="close" data-dismiss="modal">&times;</button>
								          		<h4 class="modal-title">Stage Details </h4>
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
                 	</div>               	
					<div class="modal fade" id="pdc_hand-main">
					<div class="modal-dialog" style="width: 80%;">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title"></h4>
									</div>
									<div class="modal-body" id="third-layer-table"></div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default pull-left"
											data-dismiss="modal">Close</button>

									</div>
								</div>
								<!-- /.modal-content -->
							</div>
							<!-- /.modal-dialog -->  	 
		 			</div>						<div class="row">
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
						<!-- Modal -->
						<div class="modal fade" id="so_to_invc_modal" role="dialog">
							<div class="modal-dialog modal-lg">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="modal-title">Order to Invoice Analysis Details
											of ${DIVDEFTITL} Division</h4>
									</div>

									<div class="modal-body">
										<div class="row">
											<table id="so_to_invc_modal_table">
												<thead>
													<tr>
														<th>Year</th>
														<th>Order</th>
														<th>Order Value <br /> ( Value in Millions)
														</th>
														<th>Invoice</th>
														<th>Invoice Value<br /> ( Value in Millions)
														</th>

													</tr>
												</thead>
												<tbody>

													<c:choose>
														<c:when test='${!empty SOTOINVANALSUM}'>
															<c:forEach var="orderInvcAnalsys"
																items="${SOTOINVANALSUM}">
																<tr>
																	<td>${orderInvcAnalsys.year}</td>
																	<td><fmt:formatNumber type="number"
																			value="${orderInvcAnalsys.s_order}" /></td>
																	<td><fmt:formatNumber type="number"
																			value="${orderInvcAnalsys.s_order_val}" /></td>
																	<td><fmt:formatNumber type="number"
																			value="${orderInvcAnalsys.invoice}" /></td>
																	<td><fmt:formatNumber type="number"
																			value="${orderInvcAnalsys.invoice_val}" /></td>

																</tr>
															</c:forEach>
														</c:when>
														<c:otherwise>
															<tr>
																<td>0</td>
																<td>0</td>
																<td>0</td>
																<td>0</td>
																<td>0</td>
															</tr>
														</c:otherwise>
													</c:choose>
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
						<div class="modal fade" id="loi_to_so_modal" role="dialog">
							<div class="modal-dialog modal-lg">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="modal-title">LOI to Order Analysis Details of
											${DIVDEFTITL} Division</h4>
									</div>

									<div class="modal-body">
										<div class="row">
											<table id="loi_to_so_modal_table">
												<thead>
													<tr>
														<th>Year</th>
														<th>LOI</th>
														<th>LOI Value<br /> ( Value in Millions)
														</th>
														<th>Sales Order</th>
														<th>Sales Order Value<br /> ( Value in Millions)
														</th>

													</tr>
												</thead>
												<tbody>

													<c:choose>
														<c:when test='${!empty LOITOSOANALSUM}'>
															<c:forEach var="LoiSoAnalsys" items="${LOITOSOANALSUM}">
																<tr>
																	<td>${LoiSoAnalsys.year}</td>
																	<td><fmt:formatNumber type="number"
																			value="${LoiSoAnalsys.loi}" /></td>
																	<td><fmt:formatNumber type="number"
																			value="${LoiSoAnalsys.loi_val}" /></td>
																	<td><fmt:formatNumber type="number"
																			value="${LoiSoAnalsys.sales_order}" /></td>
																	<td><fmt:formatNumber type="number"
																			value="${LoiSoAnalsys.sales_order_val}" /></td>

																</tr>
															</c:forEach>
														</c:when>
														<c:otherwise>
															<tr>
																<td>0</td>
																<td>0</td>
																<td>0</td>
																<td>0</td>
																<td>0</td>
															</tr>
														</c:otherwise>
													</c:choose>



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


						<div class="modal fade" id="qtn_to_loi_modal" role="dialog">
							<div class="modal-dialog modal-lg">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="modal-title">JIH to LOI Analysis Details of
											${DIVDEFTITL} Division</h4>
									</div>

									<div class="modal-body">
										<div class="row">
											<table id="qtn_to_loi_modal_table">
												<thead>
													<tr>
														<th>Year</th>
														<th>JIH</th>
														<th>JIH Value <br /> ( Value in Millions)
														</th>
														<th>LOI Received</th>
														<th>LOI Received Value <br /> ( Value in Millions)
														</th>
													</tr>
												</thead>
												<tbody>

													<c:choose>
														<c:when test='${!empty QTNTOLOISUM}'>
															<c:forEach var="QtnLoiAnalsys" items="${QTNTOLOISUM}">
																<tr>
																	<td>${QtnLoiAnalsys.year}</td>
																	<td><fmt:formatNumber type="number"
																			value="${QtnLoiAnalsys.quotation}" /></td>
																	<td><fmt:formatNumber type="number"
																			value="${QtnLoiAnalsys.quotation_val}" /></td>
																	<td><fmt:formatNumber type="number"
																			value="${QtnLoiAnalsys.loi}" /></td>
																	<td><fmt:formatNumber type="number"
																			value="${QtnLoiAnalsys.loi_val}" /></td>
																</tr>
															</c:forEach>
														</c:when>
														<c:otherwise>
															<tr>
																<td>0</td>
																<td>0</td>
																<td>0</td>
																<td>0</td>
																<td>0</td>
															</tr>




														</c:otherwise>
													</c:choose>



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


						<div class="modal fade" id="enq_to_qtn_modal" role="dialog">
							<div class="modal-dialog modal-lg">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="modal-title">Enquiry to Quotation Analysis
											Details of ${DIVDEFTITL} Division</h4>
									</div>

									<div class="modal-body">
										<div class="row">
											<table id="enq_to_qtn_modal_table">
												<thead>
													<tr>
														<th>Year</th>
														<th>Enquiry</th>
														<th>Quotation</th>
														<th>Avg. Days to Quote</th>

													</tr>
												</thead>
												<tbody>

													<c:choose>
														<c:when test='${!empty ENQTOQTNSUM}'>
															<c:forEach var="EnqQtnAnalsys" items="${ENQTOQTNSUM}">
																<tr>
																	<td>${EnqQtnAnalsys.year}</td>
																	<td>${EnqQtnAnalsys.enquiry}</td>
																	<td>${EnqQtnAnalsys.quotation}</td>
																	<td>${EnqQtnAnalsys.days}</td>
																</tr>
															</c:forEach>
														</c:when>
														<c:otherwise>
															<tr>
																<td>0</td>
																<td>0</td>
																<td>0</td>
																<td>0</td>
															</tr>




														</c:otherwise>
													</c:choose>



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
						<div class="modal fade" id="jihvlostDtls" role="dialog">
							<div class="modal-dialog modal-lg">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="modal-title">JIH - LOST Details of
											${DIVDEFTITL} Division</h4>
									</div>

									<div class="modal-body">
										<div class="row">
											<table id="qtn_table_modal">
												<thead>
													<tr>

														<th></th>
														<th>0-3 Months</th>
														<th>3-6 Months</th>
														<th>>6 Months</th>
													</tr>
												</thead>
												<tbody>

													<c:forEach var="JOBV" items="${JIHV}">

														<tr>
															<td>JIH COUNT</td>
															<td>${JOBV.aging1_count_actual}</td>
															<td>${JOBV.aging2_count_actual}</td>
															<td>${JOBV.aging3_count_actual}</td>
														</tr>
														<tr>
															<td>JIH VALUE <br/>(Value in Millions)</td>
															<td><fmt:formatNumber type="number" 
																	value="${JOBV.aging1_amt_actual}" pattern="#,###.##" /></td>
															<td><fmt:formatNumber type="number"
																	value="${JOBV.aging2_amt_actual}" pattern="#,###.##" /></td>
															<td><fmt:formatNumber type="number"
																	value="${JOBV.aging3_amt_actual}" pattern="#,###.##" /></td>
														</tr>
														<tr>
															<td>LOST COUNT</td>
															<td>${JOBV.aging1_count_lost}</td>
															<td>${JOBV.aging2_count_lost}</td>
															<td>${JOBV.aging3_count_lost}</td>
														</tr>
														<tr>
															<td>LOST VALUE <br/>(Value in Millions)</td>
															<td><fmt:formatNumber type="number" 
																	value="${JOBV.aging1_amt_lost}" pattern="#,###.##" /></td>
															<td><fmt:formatNumber type="number" 
																	value="${JOBV.aging2_amt_lost}" pattern="#,###.##" /></td>
															<td><fmt:formatNumber type="number" 
																	value="${JOBV.aging3_amt_lost}" pattern="#,###.##" /></td>
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

						<div class="modal fade" id="bookingDtls" role="dialog">
							<div class="modal-dialog modal-lg">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="modal-title">Booking Details of ${DIVDEFTITL}
											Division</h4>
									</div>

									<div class="modal-body">
										<div class="row">
											<div class="col-md-4">
												<table id="booking_modal_table_1">
													<thead>
														<tr>

															<th>Year</th>
															<th>Target</th>
															<th>Actual</th>
															<th>%</th>
														</tr>
													</thead>
													<tbody>
														<tr>

															<td>${CURR_YR}</td>
															<td><fmt:formatNumber type="number"
																	value="${bknglst2yrs_yr0t}" /></td>
															<td><fmt:formatNumber type="number"
																	value="${bknglst2yrs_yr0a}" /></td>

															<td><c:choose>
																	<c:when test="${bknglst2yrs_yr0t ne 0}">
																		<fmt:formatNumber type="number" pattern="###.##"
																			value="${bknglst2yrs_yr0a*100/bknglst2yrs_yr0t}" />
																	</c:when>
																	<c:otherwise>
           N/A
            </c:otherwise>

																</c:choose></td>
														</tr>
														<tr>

															<td>${CURR_YR - 1}</td>
															<td><fmt:formatNumber type="number"
																	value="${bknglst2yrs_yr1t}" /></td>
															<td><fmt:formatNumber type="number"
																	value="${bknglst2yrs_yr1a}" /></td>
															<td><c:choose>
																	<c:when test="${bknglst2yrs_yr1t ne 0}">
																		<fmt:formatNumber type="number" pattern="###.##"
																			value="${bknglst2yrs_yr1a*100/bknglst2yrs_yr1t}" />
																	</c:when>
																	<c:otherwise>
           N/A
            </c:otherwise>
																</c:choose></td>
														</tr>
														<tr>

															<td>${CURR_YR - 2}</td>
															<td><fmt:formatNumber type="number"
																	value="${bknglst2yrs_yr2t}" /></td>
															<td><fmt:formatNumber type="number"
																	value="${bknglst2yrs_yr2a}" /></td>

															<td><c:choose>
																	<c:when test="${bknglst2yrs_yr2t ne 0}">
																		<fmt:formatNumber type="number" pattern="###.##"
																			value="${bknglst2yrs_yr2a*100/bknglst2yrs_yr2t}" />
																	</c:when>
																	<c:otherwise>
           N/A
            </c:otherwise>
																</c:choose></td>
														</tr>
													</tbody>
												</table>
											</div>
											<div class="col-md-8">
												<table id="booking_modal_table_2">
													<thead>
														<tr>

															<th>Month</th>
															<th>Actual</th>
															<th>Target</th>
															<th>Curr. Mth %</th>
															<th>YTD %</th>
															<th>Avg. Booking last 2 yrs</th>

														</tr>
													</thead>
													<tbody>
														<tr>

															<td>${CURR_MTH}</td>
															<td><fmt:formatNumber type="number"
																	value="${booking_Curr_Mnth_Actual}" /></td>
															<td><fmt:formatNumber type="number"
																	value="${booking_Curr_Mnth_Target}" /></td>
															<td>${booking_Curr_Mnth_Perc}</td>
															<td>${booking_Ytd_Perc}</td>
															<td><fmt:formatNumber type="number"
																	value="${avgbknglsttwoyr / 2 }" /></td>
														</tr>


													</tbody>
												</table>


											</div>
										</div>
									</div>

									<div class="modal-footer">
										<button type="button" class="btn btn-default"
											data-dismiss="modal">Close</button>
									</div>

								</div>
							</div>
						</div>

						<div class="modal fade" id="billingDtls" role="dialog">
							<div class="modal-dialog modal-lg">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">&times;</button>
										<h4 class="modal-title">Billing Details of ${DIVDEFTITL}
											Division</h4>
									</div>

									<div class="modal-body">
										<div class="row">
											<div class="col-md-4">
												<table id="billing_modal_table_1"
													class="billing_modal_table">
													<thead>
														<tr>

															<th>Year</th>
															<th>Target</th>
															<th>Actual</th>
															<th>%</th>

														</tr>
													</thead>
													<tbody>
														<tr>

															<td>${CURR_YR}</td>
															<td><fmt:formatNumber type="number"
																	value="${billinglst2yrs_yr0t}" /></td>
															<td><fmt:formatNumber type="number"
																	value="${billinglst2yrs_yr0a}" /></td>
															<td><c:choose>
																	<c:when test="${billinglst2yrs_yr0t ne 0}">
																		<fmt:formatNumber type="number" pattern="###.##"
																			value="${billinglst2yrs_yr0a*100/billinglst2yrs_yr0t}" />
																	</c:when>
																	<c:otherwise>
           N/A
            </c:otherwise>

																</c:choose></td>
														</tr>
														<tr>

															<td>${CURR_YR - 1}</td>
															<td><fmt:formatNumber type="number"
																	value="${billinglst2yrs_yr1t}" /></td>
															<td><fmt:formatNumber type="number"
																	value="${billinglst2yrs_yr1a}" /></td>
															<td><c:choose>
																	<c:when test="${billinglst2yrs_yr1t ne 0}">
																		<fmt:formatNumber type="number" pattern="###.##"
																			value="${billinglst2yrs_yr1a*100/billinglst2yrs_yr1t}" />
																	</c:when>
																	<c:otherwise>  N/A</c:otherwise>

																</c:choose></td>
														</tr>

														<tr>

															<td>${CURR_YR - 2}</td>
															<td><fmt:formatNumber type="number"
																	value="${billinglst2yrs_yr2t}" /></td>
															<td><fmt:formatNumber type="number"
																	value="${billinglst2yrs_yr2a}" /></td>
															<td><c:choose>
																	<c:when test="${billinglst2yrs_yr2t ne 0}">
																		<fmt:formatNumber type="number" pattern="###.##"
																			value="${billinglst2yrs_yr2a*100/billinglst2yrs_yr2t}" />
																	</c:when>
																	<c:otherwise>  N/A</c:otherwise>

																</c:choose></td>
														</tr>
													</tbody>
												</table>
											</div>
											<div class="col-md-8">
												<table id="billing_modal_table_2"
													class="billing_modal_table1">
													<thead>
														<tr>

															<th>Month</th>
															<th>Actual</th>
															<th>Target</th>
															<th>Curr. Mth %</th>
															<th>YTD %</th>
															<th>Avg. Booking last 2 Yrs</th>
															<th>YTM Actual</th>
															<th>YTM Target</th>

														</tr>
													</thead>
													<tbody>
														<tr>

															<td>${CURR_MTH}</td>
															<td><fmt:formatNumber type="number"
																	value="${billing_Curr_Mnth_Actual}" /></td>
															<td><fmt:formatNumber type="number"
																	value="${billing_Curr_Mnth_Target}" /></td>
															<td>${billing_Curr_Mnth_Perc}</td>
															<td>${billing_Ytd_Perc}</td>
															<td><fmt:formatNumber type="number"
																	value="${avgbillinglsttwoyr / 2 }" /></td>
															<td><fmt:formatNumber type="number"
																	value="${billing_ytm_Actual}" /></td>
															<td><fmt:formatNumber type="number"
																	value="${billing_ytm_Target}" /></td>
														</tr>


													</tbody>
												</table>


											</div>
										</div>
									</div>

									<div class="modal-footer">
										<button type="button" class="btn btn-default"
											data-dismiss="modal">Close</button>
									</div>

								</div>
							</div>
						</div>
						<div class="modal fade" id="modal-default">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title">Forecasted figures of
											${DIVDEFTITL} division for the month of
											${CURR_MTH}.-${CURR_YR}</h4>
									</div>
									<div class="modal-body" id="forecast-table">
										<table id="forecast_modal_table">
											<thead>
												<tr>
													<th>Div. Name</th>
													<th>Forecast</th>
													<th>Invoiced</th>
													<th>Variance</th>
													<th>Revised Forecast</th>
													<th>Target Achieved %</th>

												</tr>
											</thead>
											<tbody>
												<tr>
													<td>${fcast_div}</td>
													<td><fmt:formatNumber type="number"
															value="${fcast_main }" /></td>
													<td><fmt:formatNumber type="number"
															value="${fcast_invoice}" /></td>
													<td><fmt:formatNumber type="number"
															value="${fcast_variance}" /></td>
													<td><fmt:formatNumber type="number"
															value="${fcast_rev }" /></td>
													<td>${fcast_perc}</td>

												</tr>
											</tbody>
										</table>
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
						<div class="modal fade" id="modal-third-layer-invc">
							<div class="modal-dialog" style="width: 80%;">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title"></h4>
									</div>
									<div class="modal-body" id="third-layer-table"></div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default pull-left"
											data-dismiss="modal">Close</button>

									</div>
								</div>
								<!-- /.modal-content -->
							</div>
							<!-- /.modal-dialog -->
						</div>
						<div class="modal fade" id="modal-third-layer-so">
							<div class="modal-dialog" style="width: 80%;">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title"></h4>
									</div>
									<div class="modal-body" id="third-layer-table"></div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default pull-left"
											data-dismiss="modal">Close</button>

									</div>
								</div>
								<!-- /.modal-content -->
							</div>
							<!-- /.modal-dialog -->
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
						<div class="modal fade" id="modal-third-layer-qtn">
							<div class="modal-dialog" style="width: 80%;">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title"></h4>
									</div>
									<div class="modal-body" id="third-layer-table"></div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default pull-left"
											data-dismiss="modal">Close</button>

									</div>
								</div>
								<!-- /.modal-content -->
							</div>
							<!-- /.modal-dialog -->
						</div>
						<div class="modal fade" id="modal-third-layer">
							<div class="modal-dialog" style="width: 80%;">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title"></h4>
									</div>
									<div class="modal-body" id="third-layer-table"></div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default pull-left"
											data-dismiss="modal">Close</button>

									</div>
								</div>
								<!-- /.modal-content -->
							</div>
							<!-- /.modal-dialog -->
						</div>
						<div class="modal fade" id="modal-help-qtnlost">
							<div class="modal-dialog" style="width: 80%;">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title">JIH Quotation Lost Graph Details</h4>
									</div>
									<div class="modal-body">
										<ul>
											<li>Stage 2 Quotation (JIH) details where no LOI
												recieved and Quotation marked as lost
												<ol>
												<li>LOI Date is not entered (Quotation flexi field 12)</li>
												<li>Project Status – not marked as LOST (Quotation flexi field 17)</li>
												<li>Stage/Flex field 3 marked as JIH ( 2 )</li>
												<li>Please click on this "<b><i class="fa fa-cloud-download" style="color:blue;"> </i></b>" icon to get JIH Quotation Lost  details</li>
												</ol>
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
						<div class="modal fade" id="modal-help-frcst">
							<div class="modal-dialog" style="width: 80%;">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title">Forecast Vs Billing Graph Details</h4>
									</div>
									<div class="modal-body">
										<ul>
											<li>Forecast vs billing (invoice) month wise accuracy
												percentage details</li>
										<li> Zero Forecast (Forecast Not set or Forcast value is zero) months are not included for accuracy percentage calculation.</li>

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
						<div class="modal fade" id="modal-help-booking">
							<div class="modal-dialog" style="width: 80%;">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title">Booking Graph Details</h4>
									</div>
									<div class="modal-body">
										<ul>
											<li>Booking Target is 1.2 times of billing target</li>
											<c:if test="${DFLTDMCODE eq 'E000258'}" >
											<li>For DCServe both Booking Target and billing target are same</li>
											</c:if>
											<li>Please click on this "<b><i class="fa fa-bar-chart" style="color:blue;"> </i></b>" icon /graph bar to get booking details</li>>
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
						<div class="modal fade" id="modal-help-billing">
							<div class="modal-dialog" style="width: 80%;">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title">Billing Graph Details</h4>
									</div>
									<div class="modal-body">
										<ul>
											<li>Billing Target value is provided by division manager
												to account</li>
											<c:if test="${DFLTDMCODE eq 'E000258'}" >
											<li>For DCServe both Booking Target and billing target are same</li>
											</c:if>
											<li>Please click on this "<b><i class="fa fa-bar-chart" style="color:blue;"> </i></b>" icon /graph bar to get  billing details</li>
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
						<div class="modal fade" id="modal-help-enqToqtn">
							<div class="modal-dialog" style="width: 80%;">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title">Enquiry to Qtn Graph Details</h4>
									</div>
									<div class="modal-body">
										<ul>
											<li>Enquiry to Quotation details and average days to quote</li>
											<li>Avg. Days : Date Difference b/w Enquiry Date to First Qtn. (or Created) Date</li>
											<li>Please click on this "<b><i class="fa fa-bar-chart" style="color:blue;"> </i></b>" icon /graph bar to get Enquiry to Qtn  details</li>
												

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
						
						<div class="modal fade" id="modal-help-jihToloi">
							<div class="modal-dialog" style="width: 80%;">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title">JIH - LOI Details</h4>
									</div>
									<div class="modal-body">
										<ul>
											<li>JIH Quotation & LOI recieved analysis during year to
												current date</li>
											<li>Details of Quotation in stage 2 or JIH</li>
											<li>Details of LOI with LOI date and value</li>
											<li>Please click on this "<b><i class="fa fa-bar-chart" style="color:blue;"> </i></b>" icon /graph bar to get JIH - LOI  details</li>
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
						<div class="modal fade" id="modal-help-loiToso">
							<div class="modal-dialog" style="width: 80%;">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title">LOI - Order Graph Details</h4>
									</div>
									<div class="modal-body">
										<ul>
											<li>LOI details contain all quotation with LOI,
												irrespective of whether its pull into Sales Order or not</li>
											<li>Till 2017 3rd quarter direct sales order was allowed
												.Hence in the year upto 2017 3rd quarter there will be a
												variation in Sales order value.</li>
												<li>Please click on this "<b><i class="fa fa-bar-chart" style="color:blue;"> </i></b>" icon /graph bar to get LOI - Order details</li>
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
						<div class="modal fade" id="modal-help-soToinvc">
							<div class="modal-dialog" style="width: 80%;">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title">Order to Billing Graph Details</h4>
									</div>
									<div class="modal-body">
										<ul>
											<li>Details of approved invoices only and excluded
												invoices for internal companies</li>
												<li>Please click on this "<b><i class="fa fa-bar-chart" style="color:blue;"> </i></b>" icon /graph bar to get Order to Billing details</li>

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
							<div class="modal fade" id="modal-help-outsanding">
							<div class="modal-dialog" style="width: 80%;">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal"
											aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
										<h4 class="modal-title">Outstanding Receivable Aging Wise Details</h4>
									</div>
									<div class="modal-body">
										<ul>
											<li>Please click on the "<b>againg value</b>"  to get outstanding receivable aging wise details</li>
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
					</div>
					<!--  modal end -->
					<div id="laoding" class="loader">
						<img src="resources/images/wait.gif">
					</div>

				</div>
				<!-- /.content-wrapper -->
				<footer class="main-footer">
					<div class="pull-right hidden-xs">
						<b>Version</b> 2.0.0
					</div>
					<strong>Copyright &copy; 1988- ${CURR_YR} <a
						href="http://www.faisaljassim.ae/">Faisal Jassim Group</a>.
					</strong> All rights reserved.
				</footer>

				<%-- <!-- Control Sidebar -->
				<!-- <aside class="control-sidebar control-sidebar-dark">
					<!-- Create the tabs -->
					<!-- <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
						<li><a href="#control-sidebar-home-tab" data-toggle="tab"><i
								class="fa fa-home"></i></a></li>
						<li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i
								class="fa fa-gears"></i></a></li>
					</ul>
					<!-- Tab panes -->

				<!--</aside>-->
				<!-- /.control-sidebar -->
				<!-- Add the sidebar's background. This div must be placed
       immediately after the control sidebar -->  --%>
				<div class="control-sidebar-bg"></div>
			</div>
			</div>
			<!-- ./wrapper -->

			<!-- FastClick -->
			<script src="resources/bower_components/fastclick/lib/fastclick.js"></script>
			<!-- AdminLTE App -->
			<script src="resources/dist/js/adminlte.min.js"></script>
			<script src="resources/js/date-eu.js"></script>

			<script
				src="resources/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
			<script
				src="resources/bower_components/jquery-knob/js/jquery.knob.js"></script>

			<!-- page script -->
			<script>
  $(function () {
    /* jQueryKnob */
  
    $(".knob").knob({
    	
    
    	    
    	
    		
    	
    	
      /*change : function (value) {
       //console.log("change : " + value);
       },
       release : function (value) {
       console.log("release : " + value);
       },
       cancel : function () {
       console.log("cancel : " + this.value);
       },*/
      draw: function () {

    
      
      }
    });
  });
  
 
  
  /*Start*/
 function showPdcHand(value) { 
	 // alert(value);
	 var custVal=$.trim(value);
	$('#laoding-pdc').show();
 
	var ttl="<b>PDC On Hand Details >100 AED Of Customer  :"+custVal+" </b>";
	var exclTtl="PDC On Hand Details >100 AED Of Customer  :"+custVal+" ";
	 $("#pdc_hand_4_main .modal-title").html(ttl); 
		 $.ajax({ type: 'POST', url: 'sipDivision',data: {octjf: "wccsltdhop", cchop:custVal},dataType: "json",success: function(data) {
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
		        "columnDefs" : [{"targets": 1, "type":"date-eu"}],
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
		 $.ajax({ type: 'POST', url: 'sipDivision',data: {octjf: "wccsltdrep", ccerp:custVal},dataType: "json",success: function(data) {
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
		        "columnDefs" : [{"targets": 1, "type":"date-eu"}],
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
    /* END JQUERY KNOB */
    
     /*Start*/
    function show2ndLayerOutRcvbles(divnCode,agingVal,aging_header) { 
    	
    	 $('#laoding-pdc').hide();$('#laoding-rcvbl').hide();
	$('#laoding').show();
    
	var ttl="<b>Outstanding Recievables > 100 AED Details of Division :"+divnCode+"</b><strong style='color:blue;'> </strong> for "+aging_header+" <strong style='color:blue;'>  </strong> ";
	var exclTtl="Outstanding Recievables > 100 AED Details of Division : "+divnCode+" for "+aging_header+"";
	 $("#rcvbles_aging_modal-main .modal-title").html(ttl); 
		 $.ajax({ type: 'POST', url: 'sipDivision',data: {octjf: "slbvcr", aging:agingVal,edocnvd:divnCode,d2:'${DFLTDMCODE}'},dataType: "json",success: function(data) {
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
		                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
		                filename: exclTtl,
		                title: exclTtl,
		                messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'
		                
		                
		            }
		          
		           
		        ]
		    } );
		},error:function(data,status,er) {$('#laoding').hide();  alert("please click again");}});
 
 }
 /*End*/
    
    
      /* SO script start */
     function showThirdLayerInvc(data){
    	//alert(data);
    	var year_data = data.substring(3, 7);
        var month_data = data.substring(0, 3);
       // alert(year_data+"  "+month_data);
         
	 var ttl="<b>ORDER to BILLING  Details of Division ${DIVDEFTITL}  for  "+month_data+" / "+year_data+"</b>";
	 var exclTtl="ORDER to BILLING    Details of Division ${DIVDEFTITL}  for  "+month_data+" / "+year_data+"";
	 $("#modal-third-layer-invc .modal-title").html(ttl);
    	$.ajax({ type: 'POST',url: 'sipDivision',  data: {octjf: "invcmonthwsedtls", monthTemp:month_data, divenqqtn:"${DIVDEFTITL}", yearTemp:year_data,d2:'${DFLTDMCODE}'},  dataType: "json",
    		 success: function(data) {
    			
    			 $('#laoding').hide();
    			
    			 var output="<table id='soToInvcMthDtls' class='table table-bordered small'><thead><tr>"+
    			 "<th>Sl. No</th><th>Company Code</th><th>Invoice</th><th>Invoice Date</th>"+
    			 "<th>Sales Egr. Code </th>"+
    			 "<th>Sales Egr. Name</th><th>Customer Code</th><th>Customer Name</th><th>Invoice Value</th><th>Return Value</th>"+
    		 "</tr></thead><tbody>";
    		
    		 var j=0; for (var i in data) { j=j+1;
    		 
    		 output+="<tr><td>"+j+"</td><td>" + data[i].d1+ "</td>"+
    		 "<td>" + data[i].d2 + "</td>"+
    		 "<td>" +  $.trim(data[i].d3.substring(0, 10)).split("-").reverse().join("/") + "</td><td>" + data[i].d4+ "</td><td>" + data[i].d5+ "</td><td>" + data[i].d6+ "</td>"+
    		 "<td>" + data[i].d7 + "</td><td>" + data[i].d8+ "</td><td>" + data[i].d9+ "</td>"+
    		 "</tr>"; } 
    		 output+="</tbody></table>";
    		 

    		 $("#modal-third-layer-invc .modal-body").html(output);
    		 $("#modal-third-layer-invc").modal("show");	
    		 
    			    $('#soToInvcMthDtls').DataTable( {
    			        dom: 'Bfrtip',   
    			        "columnDefs" : [{"targets": 3, "type":"date-eu"}],
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
     /* On account outstandng rcvbls script start */
     function showOustRcvblThirdLyrOwnAccnt(data){
    	 $('#laoding-pdc').hide();$('#laoding-rcvbl').hide();
    	 $('#laoding-rcvbl').show();
    	//alert(data);
    	var cust_code = $.trim(data);
    	$("#onaccnt-third-layer .modal-body #ccrpdc").val(cust_code)
         
	 var ttl="<b>Outstanding Details >100 AED for Customer :"+cust_code+"</b>";
	 var exclTtl="Outstanding Details >100 AED  for Customer :"+cust_code+"";
	 var ttlSummary="";
	 $("#onaccnt-third-layer .modal-title").html(ttl);
    	$.ajax({ type: 'POST',url: 'sipDivision',  data: {octjf: "3lyrtnccano", oacc:cust_code,divName:"${DIVDEFTITL}"},  dataType: "json",
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
    
     function s34Summary(){ $('#laoding').show();
     var seleDivn = document.getElementById("division_list").value;
     
     $.ajax({ type: 'POST', url: 'sipDivision',data: {octjf: "s34_sum",d2:'${DFLTDMCODE}',seleDivn:seleDivn}, success: function(data) { $('#laoding').hide();var str = data;var res = str.split(","); 
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
    else{alert("else")
    	    $("#s3sum").html('<strong>0</strong>');
    	    $("#s3sum_temp").val('0');
    	    $("#s3sumnoformat").val('0');
    	} 
    if(res[2]){
    	 $("#s4sum").html('<strong>'+extractValue(res[2])+'</strong>');
    	 $("#s4sum_temp").val(''+formatNumber(res[2])+'');
    	 $("#s4sumnoformat").val(res[2]);
    	 }
    else{
    	$("#s4sum").html('<strong>0</strong>'); 
	    $("#s4sum_temp").val('0');
	    $("#s4sumnoformat").val('0');
	    } 
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
     
   /* On account outstandng rcvbls END */
       /* SO script start */
     function showThirdLayerSo(data){
    	//alert(data);
    	var year_data = data.substring(3, 7);
        var month_data = data.substring(0, 3);
       // alert(year_data+"  "+month_data);
         
	 var ttl="<b>LOI to ORDER  Details of Division ${DIVDEFTITL}  for  "+month_data+" / "+year_data+"</b>";
	 var exclTtl="LOI to ORDER   Details of Division ${DIVDEFTITL}  for  "+month_data+" / "+year_data+"";
	 $("#modal-third-layer-so .modal-title").html(ttl);
    	$.ajax({ type: 'POST',url: 'sipDivision',  data: {octjf: "ordermonthwsedtls", monthTemp:month_data, divenqqtn:"${DIVDEFTITL}", yearTemp:year_data,d2:'${DFLTDMCODE}'},  dataType: "json",
    		 success: function(data) {
    			
    			 $('#laoding').hide();
    			
    			 var output="<table id='loiToSoMthDtls' class='table table-bordered small'><thead><tr>"+
    			 "<th>Sl. No</th><th>Company Code</th><th>SO TXN Code</th><th>SO Number</th>"+
    			 "<th>SO Date</th><th>Sales Egr. Code</th><th>Sales Egr. Name</th>"+
    			 "<th>Customer</th><th>Division</th>"+
    			 "<th>SO Value</th>"+
    		 "</tr></thead><tbody>";
    		
    		 var j=0; for (var i in data) { j=j+1;
    		 
    		 output+="<tr><td>"+j+"</td><td>" + data[i].d1 + "</td>"+
    		 "<td>" + data[i].d2 + "</td>"+
    		 "<td>" +  data[i].d3 + "</td><td>" + $.trim(data[i].d4.substring(0, 10)).split("-").reverse().join("/")+ "</td><td>" + data[i].d5 + "</td><td>" +data[i].d6+ "</td>"+
    		 "<td>" + data[i].d7 + "</td><td>" + data[i].d8+ "</td><td>" + data[i].d9 + "</td>" +
    		 "</tr>"; } 
    		 output+="</tbody></table>";
    		 

    		 $("#modal-third-layer-so .modal-body").html(output);
    		 $("#modal-third-layer-so").modal("show");	
    		 
    			    $('#loiToSoMthDtls').DataTable( {
    			        dom: 'Bfrtip',  
    			        "columnDefs" : [{"targets": 4, "type":"date-eu"}],
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
    
    
   /* LOI script start */
     function showThirdLayerQuotation(data){
    	 <!--alert('${DFLTDMCODE}');-->
    	//alert(data);
    	var year_data = data.substring(3, 7);
        var month_data = data.substring(0, 3);
       // alert(year_data+"  "+month_data);
         
	 var ttl="<b>JIH to LOI   Details of Division ${DIVDEFTITL}  for  "+month_data+" / "+year_data+"</b>";
	 var exclTtl="JIH to LOI   Details of Division ${DIVDEFTITL}  for  "+month_data+" / "+year_data+"";
	 $("#modal-third-layer-qtn .modal-title").html(ttl);
    	$.ajax({ type: 'POST',url: 'sipDivision',  data: {octjf: "qtnmonthwsedtls", monthTemp:month_data, divenqqtn:"${DIVDEFTITL}", yearTemp:year_data,d2:'${DFLTDMCODE}'},  dataType: "json",
    		 success: function(data) {
    			
    			 $('#laoding').hide();
    			
    			 var output="<table id='qtnToLOIMthDtls' class='table table-bordered small'><thead><tr>"+
    			 "<th>Sl. No</th><th>Qtn. Code</th><th>Qtn. No</th><th>Qtn. Date</th>"+
    			 "<th>Zone</th><th>Sales Egr. Code</th><th>Sales Egr. Name</th>"+
    			 "<th>Product Category</th><th>Product Sub Category</th><th>Project Name</th><th>Consultant</th><th>Customer</th><th>Amount</th><th>Avg. Gross Profit %</th>"+
    			 "<th>LOI Recieved Date</th><th>Expected PO Datet</th><th>Invoicing Year</th>"+
    		 "</tr></thead><tbody>";
    		
    		 var j=0; for (var i in data) { j=j+1;
    		 
    		 output+="<tr><td>"+j+"</td><td>" + data[i].d2 + "</td>"+
    		 "<td>" + data[i].d3 + "</td>"+
    		 "<td>" +  $.trim(data[i].d1.substring(0, 10)).split("-").reverse().join("/") + "</td><td>" + data[i].d4+ "</td><td>" + data[i].d5 + "</td><td>" + $.trim(data[i].d6.substring(0, 10)).split("-").reverse().join("/") + "</td>"+
    		 "<td>" + data[i].d7 + "</td><td>" + data[i].d8+ "</td><td>" + data[i].d9 + "</td><td>" + data[i].d10 + "</td>"+
    		 "<td>" + data[i].d11 + "</td><td>" + data[i].d12+ "</td><td>" +  checkData(data[i].d13) + "</td><td>" + $.trim(data[i].d14.substring(0, 10)).split("-").reverse().join("/") + "</td><td>" + $.trim(data[i].d15.substring(0, 10)).split("-").reverse().join("/")+ "</td><td>" + $.trim(data[i].d16.substring(0, 10)).split("-").reverse().join("/")+ "</td>"+
    		 "</tr>"; } 
    		 output+="</tbody></table>";
    		 

    		 $("#modal-third-layer-qtn .modal-body").html(output);
    		 $("#modal-third-layer-qtn").modal("show");	
    		 
    			    $('#qtnToLOIMthDtls').DataTable( {
    			        dom: 'Bfrtip',
    			        "columnDefs" : [{"targets": [3, 14, 15, 16], "type":"date-eu"}],
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
    function checkData(data){
    	if(typeof data === 'undefined'){
    		return "-";
    	}else{
    		return data;
    	}
    }
    function showThirdLayerEnquiry(data){
    	 <!--alert('${DFLTDMCODE}');-->
    	//alert(data);
    	var year_data = data.substring(3, 7);
        var month_data = data.substring(0, 3);
       // alert(year+" ! "+month);
         
	 var ttl="<b>Enquiry to Qtn.   Details of Division ${DIVDEFTITL}  for  "+month_data+" / "+year_data+"</b>";
	 var exclTtl="Enquiry to Qtn.   Details of Division ${DIVDEFTITL}  for  "+month_data+" / "+year_data+"";
	 $("#modal-third-layer .modal-title").html(ttl);
    	$.ajax({ type: 'POST',url: 'sipDivision',  data: {octjf: "etqmonthwsedtls", monthTemp:month_data, divenqqtn:"${DIVDEFTITL}", yearTemp:year_data,d2:'${DFLTDMCODE}'},  dataType: "json",
    		 success: function(data) {
    			
    			 $('#laoding').hide();
    			
    			 var output="<table id='enqToQuotationMthDtls' class='table table-bordered small'><thead><tr>"+
    			 "<th>Sl. No</th><th>Qtn. Code</th><th>Qtn. No</th><th>Qtn. Date</th><th>Qtn. First Date</th>"+
    			 "<th>Enquiry Details</th>"+
    			 "<th>Zone</th><th>Sales Egr. Code</th><th>Sales Egr. Name</th><th>Product Category</th><th>Product Sub Category</th>"+
    			 "<th>Project Name</th><th>Consultant</th><th>Customer</th><th>Amount</th>"+
    		 "</tr></thead><tbody>";
    		var enqDetails;
    		 var j=0; for (var i in data) { j=j+1;
    		 enqDetails=""+data[i].d4+"";
    		 if (enqDetails === undefined || enqDetails === null || enqDetails == "undefined") {
    			 enqDetails="DIRECT QUOTATION";
    		}
    		
    		  output+="<tr><td>"+j+"</td><td>" + data[i].d1 + "</td>"+
    		 "<td>" + data[i].d2 + "</td>"+
    		 "<td>" +  $.trim(data[i].d3.substring(0, 10)).split("-").reverse().join("/") + "</td><td>" +  $.trim(data[i].d14.substring(0, 10)).split("-").reverse().join("/") + "</td><td><b>" + enqDetails + "</b> </td><td>" + data[i].d5 + "</td><td>" + $.trim(data[i].d6.substring(0, 10)).split("-").reverse().join("/") + "</td>"+
    		 "<td>" + data[i].d7 + "</td><td>" + data[i].d8+ "</td><td>" + data[i].d9 + "</td><td>" + data[i].d10 + "</td>"+
    		 "<td>" + data[i].d11 + "</td><td>" + data[i].d12+ "</td><td>" + data[i].d13 + "</td>"+
    		 "</tr>"; } 
    		 output+="</tbody></table>";
    		 

    		 $("#modal-third-layer .modal-body").html(output);
    		 $("#modal-third-layer").modal("show");	
    		 
    			    $('#enqToQuotationMthDtls').DataTable( {
    			        dom: 'Bfrtip',    
    			        "columnDefs" : [{"targets": [3, 4], "type":"date-eu"}],
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
    
    /* third layer script end */
   $(document).ready(function() {
	   
	   var forecastTtl="Forecasted vs Actual Invoicing Analysis  for Division: ${DIVDEFTITL} - ${CURR_MTH}. - ${CURR_YR}";
	   var billingTtl="Billing Details of ${DIVDEFTITL} Division, ${CURR_YR}";
		   var bookingTtl="Billing Details of ${DIVDEFTITL} Division, ${CURR_YR}";
		   var qtnLostTtl="Quotation Lost Details of ${DIVDEFTITL} Division, ${CURR_YR}";
			   var enqQtnTtl="Enquiry to Quotation Analysis Details of ${DIVDEFTITL} Division";
			   var qtnLoiTtl="JIH to LOI Analysis Details of ${DIVDEFTITL} Division";
			   var loiToSoTtl="LOI to Order Analysis Details of ${DIVDEFTITL} Division";
			   var soToInvcTtl="Order to Invoice Analysis Details of ${DIVDEFTITL} Division";
		   
	   $('#forecast_modal_table ').DataTable( {
	        dom: 'Bfrtip',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
	                filename: forecastTtl,
	                title: forecastTtl,
	                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	          
	           
	        ]
	    } );
	   
	   $('#qtn_table_modal').DataTable({
		   dom: 'Bfrtip',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
	                filename: qtnLostTtl,
	                title: qtnLostTtl,
	                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	          
	           
	        ]
	    } );
	   
	   $('#billing_modal_table_1,#billing_modal_table_2').DataTable({
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
	   $('#booking_modal_table_1,#booking_modal_table_2').DataTable({
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
	   
	   
	   
	   $('#enq_to_qtn_modal_table').DataTable({
		   dom: 'Bfrtip',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
	                filename: enqQtnTtl,
	                title: enqQtnTtl,
	                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	          
	           
	        ]
	    } );
	   
	   $('#qtn_to_loi_modal_table').DataTable({
		   dom: 'Bfrtip',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
	                filename: qtnLoiTtl,
	                title: qtnLoiTtl,
	                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	          
	           
	        ]
	    } );
	   
	   
	   $('#loi_to_so_modal_table').DataTable({
		   dom: 'Bfrtip',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
	                filename: loiToSoTtl,
	                title: loiToSoTtl,
	                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	          
	           
	        ]
	    } );
	   
	   $('#so_to_invc_modal_table').DataTable({
		   dom: 'Bfrtip',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 2em;"></i>',
	                filename: soToInvcTtl,
	                title: soToInvcTtl,
	                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	          
	           
	        ]
	    } );
	   $('[data-toggle="popover"]').popover();  
	  
	   $('#help-qtnlost').on('click', function(e) {  
		   $("#modal-help-qtnlost").modal("show");	
	    });
	   $('#help-frcst').on('click', function(e) {  
		   $("#modal-help-frcst").modal("show");	
	    });
	   $('#help-enqToqtn').on('click', function(e) {  
		   $("#modal-help-enqToqtn").modal("show");	
	    });
	   $('#help-jihToloi').on('click', function(e) {  
		   $("#modal-help-jihToloi").modal("show");	
		
	    });
	   $('#help-loiToso').on('click', function(e) {  
		   $("#modal-help-loiToso").modal("show");	
	    });
	   $('#help-soToinvc').on('click', function(e) {  
		   $("#modal-help-soToinvc").modal("show");	
	    });
	   $('#help-booking').on('click', function(e) {  
		   $("#modal-help-booking").modal("show");	
	    });
	   $('#help-billing').on('click', function(e) {  
		   $("#modal-help-billing").modal("show");	
	    });
	   $('#help-outsanding').on('click', function(e) {  
		   $("#modal-help-outsanding").modal("show");	
	    });
	   $('#help-stages').on('click', function(e) {  
		   $("#help-stages-modal").modal("show");	
	    });
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
   
 //stage 1 detail normal se page
   function s1Details() { 
   	$('#laoding').show();
   var seleDivn = document.getElementById("division_list").value;
   var excelTtl='Stage 1 (TENDER) Details of <i> ${DIVDEFTITL} </i>';
   var ttl="<b>Stage 1 (TENDER) Details of  ${DIVDEFTITL}  </b> ";
   $("#stageDetails34 .modal-title").html(ttl);
   $.ajax({ 
   	type: 'POST',
   	url: 'sipDivision',  
   	data: {octjf: "s1_dt", d1:'${DFLTDMCODE}',seleDivn:seleDivn},
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
 	
   //Stage 2 details division
   function s2Details() { var dmCode= '${DFLTDMCODE}';$('#laoding').show();
   var seleDivn = document.getElementById("division_list").value;
    var ttl="<b>Stage 2 Details of Division ${DIVDEFTITL}</b> ";
    var exclTtl="Stage 2 Details of Division ${DIVDEFTITL}";
    $("#jihv-excl-modal .modal-title").html(ttl); $.ajax({ type: 'POST',url: 'sipDivision',  data: {octjf: "s2_dt", d1:dmCode,seleDivn:seleDivn}, dataType: "json",
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
   function s3Details(val){ $('#laoding').show(); 
   var ttl="<b>Stage 3 Details of <i> ${DIVDEFTITL} </i></b>";
   var excelTtl="Stage 3 Details of ${DIVDEFTITL}";
   var seleDivn = document.getElementById("division_list").value;
   $(".modal-title").html(ttl);
   $.ajax({ type: 'POST', url: 'sipDivision', data: {octjf: "s3_dt",d2:'${DFLTDMCODE}',seleDivn:seleDivn}, dataType: "json", success: function(data) { $('#laoding').hide();
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
   
   function s4Details(val){ 
	   $('#laoding').show(); 
   var seleDivn = document.getElementById("division_list").value;
   var ttl="<b>Stage 4 Details of <i> ${DIVDEFTITL}</i></b>";var exclTtl="Stage 4 Details of  ${DIVDEFTITL}";
   $(".modal-title").html(ttl);$.ajax({ type: 'POST',url: 'sipDivision', data: {octjf: "s4_dt",d2:'${DFLTDMCODE}',seleDivn:seleDivn}, dataType: "json",success: function(data) {
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
   
 function s5Details(val){ 
	 $('#laoding').show(); 
   var seleDivn = document.getElementById("division_list").value;
   var ttl="<b>Stage 5 Details of <i> ${DIVDEFTITL}</i></b>";var exclTtl="Stage 5 Details of  ${DIVDEFTITL}";
   $(".modal-title").html(ttl);$.ajax({ type: 'POST',url: 'sipDivision', data: {octjf: "s5_dt",d2:'${DFLTDMCODE}',seleDivn:seleDivn}, dataType: "json",success: function(data) {
   $('#laoding').hide();
   var output="<table id='s5-excl' class='table table-bordered small'><thead><tr><th>#</th><th>Company</th>"+
		 "<th>Week</th><th>Document ID</th><th>Document Date</th><th>Sales Eng.</th>"+
		 "<th>Division</th>"+ "<th>Party Name</th>"+ "<th>Contact</th>"+ "<th>Telephone</th>"+
		 "<th>Project</th>"+ "<th>Product</th>"+ "<th>Zone</th>"+ "<th>Currency</th>"+"<th>Amount</th>"+
	 "</tr></thead><tbody>";
	 
	 var j=0; for (var i in data) { j=j+1;
	 
	 output+="<tr><td>"+j+"</td><td>" + $.trim(data[i].d1) + "</td><td>" + $.trim(data[i].d2) + "</td><td>" + $.trim(data[i].d3) + "</td>"+
	"<td>" + $.trim(data[i].d4.substring(0, 10)).split("-").reverse().join("/") + "</td><td>" + $.trim(data[i].d5)+"-" +$.trim(data[i].d6)+ "</td>"+"<td>" + $.trim(data[i].d8) + "</td><td>" + $.trim(data[i].d9) + "</td>"+
	"<td>" + $.trim(data[i].d10) + "</td><td>" + $.trim(data[i].d11) + "</td>"+"<td>" + $.trim(data[i].d12) + "</td><td>" + $.trim(data[i].d13) + "</td>"+
	"<td>" + $.trim(data[i].d14) + "</td><td>" + $.trim(data[i].d15) + "</td>"+"<td>" + $.trim(data[i].d16) + 
	 "</tr>"; } 
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
 
//implemented graph in stage details
 
 document.addEventListener('DOMContentLoaded', function() {
	    // Attach click event listener to open modal button
	    document.getElementById('openModalBtn').addEventListener('click', function() {
	        // Display the modal
	        document.getElementById('myModal').style.display = 'block';      
	       
	        var chks2isempty =$("#s2sum_temp").val();
	        var s2Data = 0;
	        if(chks2isempty !== ''){	       
	        	  s2Data = $("#s2sum_temp").val() !== 0 ? parseFloat($("#s2sum_temp").val()) : 0;
	        	 }
	       
	        var s3Data = $("#s3sum_temp").val() !== 0 ? parseFloat($("#s3sumnoformat").val()) : 0;
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
		<html>
<body onload="window.top.location.href='logout.jsp'">
</body>

</body>
	</c:otherwise>

</c:choose>
</html>