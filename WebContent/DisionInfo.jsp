<%-- 
    Document   : SIP START PAGE FOR DIVISION SALES DASHBAORD
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="mainview.jsp" %>
<%-- <c:set var="empCodee" value='<%= request.getParameter("empcode") %>' scope="page" /> --%>
<c:if test="${empCodee eq null or empty empCodee}"> <c:set var="empCodee" value="${fjtuser.emp_code}" scope="page" /></c:if>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%
  DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
  Calendar cal = Calendar.getInstance();
  int month = cal.get(Calendar.MONTH)+1;  
  int iYear = cal.get(Calendar.YEAR); 
  String curr_month_name="JANUARY";
  String currCalDtTime = dateFormat.format(cal.getTime());
  switch(month){
  case 1: curr_month_name="Jan";
	  break;
  case 2: curr_month_name="Feb";
  break;
  case 3: curr_month_name="Mar";
  break;
  case 4: curr_month_name="Apr";
  break;
  case 5: curr_month_name="May";
  break;
  case 6: curr_month_name="Jun";
  break;
  case 7: curr_month_name="Jul";
  break;
  case 8: curr_month_name="Aug";
  break;
  case 9: curr_month_name="Sept";
  break;
  case 10: curr_month_name="Oct";
  break;
  case 11: curr_month_name="Nov";
  break;
  case 12: curr_month_name="Dec";
  break;
	  
  
  }
  request.setAttribute("currCal",currCalDtTime);
  request.setAttribute("MTH",month);
  request.setAttribute("CURR_YR",iYear);
  request.setAttribute("CURR_MTH",curr_month_name);
 %>
<!DOCTYPE html>
<html><head>
<style>

#modal-third-layer-invc .modal-dialog,#modal-third-layer-so .modal-dialog, #modal-third-layer-qtn .modal-dialog,#modal-third-layer .modal-dialog, #modal-graph .modal-dialog,.modal-content { /* 80% of window height */ /* height: 80%;*/height: calc(100% - 20%);}
#modal-third-layer-invc .modal-body,#modal-third-layer-so .modal-body,#modal-third-layer-qtn .modal-body,#modal-third-layer .modal-body, #modal-graph .modal-body {  /* 100% = dialog height, 120px = header + footer */ max-height: calc(100% - 120px); overflow-y: scroll; overflow-x: scroll;}
.modal-body th{ font-weight:bold;}
#modal-graph .modal-footer {padding: 2px 15px 15px 15px !important;}
.loader {position: fixed; z-index: 999; height: 2em;width: 2em;overflow: show; margin: auto; top: 0;left: 0;bottom: 0; right: 0;}
.loader:before { content: '';display: block;position: fixed;top: 0; left: 0;width: 100%; height: 100%; background-color: rgba(0,0,0,0.3);}
.small-box { border-radius: 2px;position: relative; display: block; margin-top: 10px; box-shadow: 0 1px 1px rgba(0,0,0,0.1);}
.bg-red {background-color: #3b80a9 !important; color: #fff !important;}
.small-box>.small-box-footer { position: relative; text-align: center; padding: 3px 0;  color: #fff;color: rgba(255,255,255,0.8);display: block; z-index: 10; background: rgba(0,0,0,0.1);text-decoration: none;}
.small-box .icon { -webkit-transition: all .3s linear; -o-transition: all .3s linear; transition: all .3s linear; position: absolute; top: 5px; right: 10px; z-index: 0; font-size: 75px; color: rgba(0,0,0,0.15);}
.small-box p { z-index: 5;} .small-box p { font-size: 15px;} .small-box>.inner { padding: 10px;} .small-box h3, .small-box p {z-index: 5;}
.small-box h3 { font-size: 2em; font-weight: bold; margin: 0 0 10px 0; white-space: nowrap; padding: 0;}
#chart_div, #prf_summ_billing_ytd, #prf_summ_booking_ytd, #stages{position: relative;border-radius: 3px; border-top: 3px solid #065685; margin-bottom: 20px; box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12);}
.stage{ background-color: #065685;color: white; border: 1px solid #065685;}
.navbar { margin-bottom: 8px !important;} 
.table{display: block !important; overflow-x:auto !important;}
#db-title-boxx{background: white; height: auto;; margin-top: -9px; margin-left: -10px; margin-right: -10px; box-shadow: 0 0 4px rgba(0,0,0,.14), 0 4px 8px rgba(0,0,0,.28);}

.google-visualization-table-table {
    font-family: serif !important;
    font-size: 12pt !important;
    border-spacing: 5px !important;
    }
    .tab-content>.active {
    
    margin-top: 10px !important;}
    #jihv_table-dt{
    height:310px !important;
    }
    .table>caption+thead>tr:first-child>td, .table>caption+thead>tr:first-child>th, .table>colgroup+thead>tr:first-child>td, .table>colgroup+thead>tr:first-child>th, .table>thead:first-child>tr:first-child>td, .table>thead:first-child>tr:first-child>th {
    color: #0000ff !important;
     }
   table.dataTable tfoot td {color: blue !important;font-weight: bold;}
   .pagination>li>a, .pagination>li>span{
  border:1px solid red !important;
}
 .fjtco-table {
    /* background-color: #ffff; */
    background-color: #e5f0f7;
    padding: 0.01em 16px;
    margin: 20px 0;
    box-shadow: 0 2px 4px 0 rgba(0,0,0,0.16),0 2px 10px 0 rgba(0,0,0,0.12)!important;
    }
    
    .main-header {z-index: 851 !important;}
  
 
 #stages-dt .col-lg-6 {
 margin-top: -5px;
}
.container {
    padding-right: 0px !important;
    padding-left: 0px !important;
}

.wrapper{margin-top:-8px;}
.row{margin-left:0px !important;margin-right:0px;}

#example tbody td {
    padding: 4px 5px;
    font-size: 83%;
}

#example thead th{
    padding: 3px 10px;
    border-bottom: 1px solid #795548;
    font-size:80%;
}
.box-footer{padding:1px;}

.dataTables_wrapper .dataTables_info{    color: #2196F3 !important;
    font-size: 10px !important;
    font-weight: bold !important;}
	
	.dataTables_wrapper .dataTables_paginate .paginate_button.disabled {color: #2196F3 !important;
   
    font-size: 10px !important;
    font-weight: bold !important;}
	
	.dataTables_wrapper .dataTables_paginate .paginate_button{    font-size: 10px !important;
    font-weight: bold !important;padding:0 !important;}
    .dataTables_wrapper .dataTables_length, .dataTables_wrapper .dataTables_filter, .dataTables_wrapper .dataTables_info,  .dataTables_wrapper .dataTables_paginate{
   
    font-weight: bold !important;
    font-size: 11px !important;
}
.description-block>.description-header{
    margin: 0;
    padding: 0;
    font-weight: bold !important;
    color: #F44336;
    font-size: 80% !important;
}
.description-block>description-text {font-weight:bold;}
table.dataTable.no-footer {
    border-bottom: 1px solid #795548 !important;
}
.box-header .box-title{font-size:15px !important;font-weight:bold !important;}
.description-block {    margin: 6px 0 !important;}
.dataTables_wrapper .dataTables_info {padding-top: 0.555em; margin-bottom: -2px;
}

svg > g:last-child > g:last-child { pointer-events: none }
div.google-visualization-tooltip { pointer-events: none }
div.google-visualization-tooltip {

    padding: 0 !important;
    margin: 0 !important;
    border:none !important;

 
    height:auto !important;
    overflow:hidden !important;

}
#qtnlost tbody td {
    padding: 2px 4px !important;
    font-size: 90% !important;}
    
    #example  tfoot th{text-align:right !important;padding: 2px 2px !important; color:#f44336;border-right: 1px solid #c7c3c3;
    border-bottom: 1px solid #111111;}
    #example_wrapper{overflow-x:auto !important;}
    
    
    
#so_to_invc_modal th,#so_to_invc_modal td,#loi_to_so_modal th,#loi_to_so_modal td,#enq_to_qtn_modal th,#enq_to_qtn_modal td, #qtn_to_loi_modal th,#qtn_to_loi_modal td,#jihvlostDtls th, #jihvlostDtls td,#billingDtls th,#billingDtls td,#bookingDtls th,#bookingDtls td, #modal-default th,#modal-default td,#forecast-table th,#forecast-table td{padding:5px !important;border: 1px solid #2196F3;}
#modal-third-layer-invc th,#modal-third-layer-invc td,#modal-third-layer-so th,#modal-third-layer-so td,#modal-third-layer-qtn th,#modal-third-layer-qtn td,#modal-third-layer th,#modal-third-layer td{font-size:80%;}
button.dt-button{
border: 1px solid #008000 !important;
    padding: 0.3em 0.3em !important;
    line-height: 1 !important;}
.modal-title{    color: #009688 !important; font-weight: bold !important;}

#forecast-graph circle, #enq_to_qtn circle,#qtn_to_loi circle{r: 5 !important;}

#jihv circle{r: 7 !important;}
circle{r: 13 !important;}
.help-left{ z-index: 50;
    background: rgba(255,255,255,0.7);
    border: 2px solid #3c8dbc;
    font-size: 15px;
    color: #3c8dbc;
    position: absolute;
    padding: 2px 0px 2px 6px;
    cursor: pointer;top:0px;left:0px;border-radius: 5px;}
    .help-right{ z-index: 50;
    background: rgba(255,255,255,0.7);
    border: 2px solid #3c8dbc;
    font-size: 15px;
    color: #3c8dbc;
    position: absolute;
    padding: 2px 0px 2px 6px;
    cursor: pointer;top:0px;right:0px;border-radius: 5px;}
    
    .help-right-lost{ z-index: 50;
    background: rgba(255,255,255,0.7);
    border: 2px solid #3c8dbc;
    font-size: 15px;
    color: #3c8dbc;
    position: absolute;
    padding: 2px 0px 2px 6px;
    cursor: pointer;top:10px;right:10px;border-radius: 5px;}
    
#jihv table, #jihv table th, #jihv table td{border: 1px solid green}
   #jihv table th, #jihv table td { padding: 6px 6px 6px 6px;}
    

@media (max-width : 375px) {
    .divheader{padding-top:0px !important;}
    .fj-bk-per{padding-left: 10% !important; padding-right: 10% !important;}
}
@media (max-width : 450px) {
    .divheader{padding-top:0px !important;}
    .fj-bk-per{padding-left: 10% !important; padding-right: 10% !important;}
}
@media (max-width : 400px) {
    .divheader{padding-top:0px !important;}
    .fj-bk-per{padding-left: 10% !important; padding-right: 10% !important;}
}




    .overlay {
         
           position: absolute;
           
    }
 .box .overlay{margin-top:-19px !important;right: 15px !important;}




</style>
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
		
		
 		<c:forEach var="forecastPerAnalsys" items="${FRCSPERCACCRCYDTLS}">
	    <c:if test="${!empty forecastPerAnalsys.mth1 or forecastPerAnalsys.mth1 ne null}" >
	    <c:set var="fcast_jan" value="${forecastPerAnalsys.mth1}" scope="page" /> 
	     <c:set var="fcast_total_perc" value="${fcast_total_perc + forecastPerAnalsys.mth1}" scope="page" /> 
	     </c:if>
		<c:if test="${!empty forecastPerAnalsys.mth2 or forecastPerAnalsys.mth2 ne null}" >
		 <c:set var="fcast_feb" value="${forecastPerAnalsys.mth2}" scope="page" /> 
		 <c:set var="fcast_total_perc" value="${fcast_total_perc + forecastPerAnalsys.mth2}" scope="page" /> 
		  </c:if>
		<c:if test="${!empty forecastPerAnalsys.mth3 or forecastPerAnalsys.mth3 ne null}" >
		<c:set var="fcast_mar" value="${forecastPerAnalsys.mth3}" scope="page" /> 
		<c:set var="fcast_total_perc" value="${fcast_total_perc + forecastPerAnalsys.mth3}" scope="page" /> 
		 </c:if>
		<c:if test="${!empty forecastPerAnalsys.mth4 or forecastPerAnalsys.mth4 ne null}" > 
		<c:set var="fcast_apr" value="${forecastPerAnalsys.mth4}" scope="page" />
		<c:set var="fcast_total_perc" value="${fcast_total_perc + forecastPerAnalsys.mth4}" scope="page" />  </c:if>
		<c:if test="${!empty forecastPerAnalsys.mth5 or forecastPerAnalsys.mth5 ne null}" >
		<c:set var="fcast_may" value="${forecastPerAnalsys.mth5}" scope="page" /> 
		<c:set var="fcast_total_perc" value="${fcast_total_perc + forecastPerAnalsys.mth5}" scope="page" />  </c:if>
		<c:if test="${!empty forecastPerAnalsys.mth6 or forecastPerAnalsys.mth6 ne null}" > 
		<c:set var="fcast_jun" value="${forecastPerAnalsys.mth6}" scope="page" /> 
		<c:set var="fcast_total_perc" value="${fcast_total_perc + forecastPerAnalsys.mth6}" scope="page" /></c:if>
		<c:if test="${!empty forecastPerAnalsys.mth7 or forecastPerAnalsys.mth7 ne null}" >
		<c:set var="fcast_jul" value="${forecastPerAnalsys.mth7}" scope="page" /> 
		<c:set var="fcast_total_perc" value="${fcast_total_perc + forecastPerAnalsys.mth7}" scope="page" /> </c:if>
		<c:if test="${!empty forecastPerAnalsys.mth8 or forecastPerAnalsys.mth8 ne null}" > 
		<c:set var="fcast_aug" value="${forecastPerAnalsys.mth8}" scope="page" />
		<c:set var="fcast_total_perc" value="${fcast_total_perc + forecastPerAnalsys.mth8}" scope="page" /> </c:if>
		<c:if test="${!empty forecastPerAnalsys.mth9 or forecastPerAnalsys.mth9 ne null}" > 
		<c:set var="fcast_sep" value="${forecastPerAnalsys.mth9}" scope="page" />
		<c:set var="fcast_total_perc" value="${fcast_total_perc + forecastPerAnalsys.mth9}" scope="page" /> </c:if>
		<c:if test="${!empty forecastPerAnalsys.mth10 or forecastPerAnalsys.mth10 ne null}" >
		<c:set var="fcast_oct" value="${forecastPerAnalsys.mth10}" scope="page" /> 
		<c:set var="fcast_total_perc" value="${fcast_total_perc + forecastPerAnalsys.mth10}" scope="page" /> </c:if>
		<c:if test="${!empty forecastPerAnalsys.mth11 or forecastPerAnalsys.mth11 ne null}" > 
		 <c:set var="fcast_nov" value="${forecastPerAnalsys.mth11}" scope="page" />
		 <c:set var="fcast_total_perc" value="${fcast_total_perc + forecastPerAnalsys.mth11}" scope="page" /></c:if>
		<c:if test="${!empty forecastPerAnalsys.mth12 or forecastPerAnalsys.mth12 ne null}" >
		<c:set var="fcast_dec" value="${forecastPerAnalsys.mth12}" scope="page" />
		<c:set var="fcast_total_perc" value="${fcast_total_perc + forecastPerAnalsys.mth12}" scope="page" /> 
		 </c:if>
		<c:set var="fcast_total_perc" value="${fcast_total_perc / MTH}" scope="page" />
		</c:forEach>
 		

 
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
 
  <c:forEach var="forecastlstt"  items="${FRCSTDTLS}" >
  <c:choose>
  <c:when test="${!empty forecastlstt.divname or forecastlstt.divname ne null}"> 
  <c:set var="fcast_div" value="${forecastlstt.divname}" scope="page" /> 
  </c:when>
  <c:otherwise> <c:set var="fcast_div" value="0" scope="page" /> </c:otherwise>
  </c:choose>
  <c:choose>
  <c:when test="${!empty forecastlstt.forecast or forecastlstt.forecast ne null}"> 
  <c:set var="fcast_main" value="${forecastlstt.forecast}" scope="page" /> 
  </c:when>
  <c:otherwise> <c:set var="fcast_main" value="0" scope="page" /> </c:otherwise>
  </c:choose>
  
    <c:choose>
  <c:when test="${!empty forecastlstt.invoiced or forecastlstt.invoiced ne null}"> 
    <c:set var="fcast_invoice" value="${forecastlstt.invoiced}" scope="page" /> 
  </c:when>
  <c:otherwise>   <c:set var="fcast_invoice" value="0" scope="page" /> </c:otherwise>
  </c:choose>
  
<c:choose>
  <c:when test="${!empty forecastlstt.targ_perc or forecastlstt.targ_perc ne null}"> 
    <c:set var="fcast_perc" value="${forecastlstt.targ_perc}" scope="page" /> 
  </c:when>
  <c:otherwise>   <c:set var="fcast_perc" value="0" scope="page" /> </c:otherwise>
  </c:choose>
 <c:choose>
  <c:when test="${!empty forecastlstt.variance or forecastlstt.variance ne null}"> 
    <c:set var="fcast_variance" value="${forecastlstt.variance}" scope="page" /> 
  </c:when>
  <c:otherwise>   <c:set var="fcast_variance" value="0" scope="page" /> </c:otherwise>
  </c:choose>
</c:forEach></c:if>
  
   
   <c:set var="bknglst2yrs_yr0t" value="0" scope="page" /> 
   <c:set var="bknglst2yrs_yr0a" value="0" scope="page" /> 
   <c:set var="bknglst2yrs_yr1t" value="0" scope="page" /> 
   <c:set var="bknglst2yrs_yr1a" value="0" scope="page" /> 
   <c:set var="bknglst2yrs_yr2t" value="0" scope="page" /> 
   <c:set var="bknglst2yrs_yr2a" value="0" scope="page" /> 
  <c:if test="${BKNGS_LTWOYRS ne null}"> 
  <c:forEach var="bknglsttwoyr"  items="${BKNGS_LTWOYRS}" >
  <c:choose>
  <c:when test="${!empty bknglsttwoyr.curr_yrt or bknglsttwoyr.curr_yrt ne null}"> 
      <c:set var="bknglst2yrs_yr0t" value="${bknglsttwoyr.curr_yrt}" scope="page" /> 
  </c:when>
  <c:otherwise>   <c:set var="bknglst2yrs_yr0t" value="0" scope="page" /> </c:otherwise>
  </c:choose>
  
     <c:choose>
     <c:when test="${!empty bknglsttwoyr.curr_yra or bknglsttwoyr.curr_yra ne null}"> 
     <c:set var="bknglst2yrs_yr0a" value="${bknglsttwoyr.curr_yra}" scope="page" />  
  </c:when>
  <c:otherwise> <c:set var="bknglst2yrs_yr0a" value="0" scope="page" />  </c:otherwise>
  </c:choose>
   
     <c:choose>
     <c:when test="${!empty bknglsttwoyr.prev_yrt or bknglsttwoyr.prev_yrt ne null}"> 
    <c:set var="bknglst2yrs_yr1t" value="${bknglsttwoyr.prev_yrt}" scope="page" /> 
  </c:when>
  <c:otherwise> <c:set var="bknglst2yrs_yr1t" value="0" scope="page" />   </c:otherwise>
  </c:choose>
   
     <c:choose>
     <c:when test="${!empty bknglsttwoyr.prev_yra or bknglsttwoyr.prev_yra ne null}"> 
   <c:set var="bknglst2yrs_yr1a" value="${bknglsttwoyr.prev_yra}" scope="page" />  
  </c:when>
  <c:otherwise><c:set var="bknglst2yrs_yr1a" value="0" scope="page" />  </c:otherwise>
  </c:choose>
   
     <c:choose>
     <c:when test="${!empty bknglsttwoyr.scnd_prev_yrt or bknglsttwoyr.scnd_prev_yrt ne null}"> 
  <c:set var="bknglst2yrs_yr2t" value="${bknglsttwoyr.scnd_prev_yrt}" scope="page" /> 
  </c:when>
  <c:otherwise><c:set var="bknglst2yrs_yr2t" value="0" scope="page" />  </c:otherwise>
  </c:choose>
   
    <c:choose>
     <c:when test="${!empty bknglsttwoyr.scnd_prev_yra or bknglsttwoyr.scnd_prev_yra ne null}"> 
  <c:set var="bknglst2yrs_yr2a" value="${bknglsttwoyr.scnd_prev_yra}" scope="page" /> 
  </c:when>
  <c:otherwise><c:set var="bknglst2yrs_yr2a" value="0" scope="page" />   </c:otherwise>
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
  <c:forEach var="billinglsttwoyr"  items="${BILLNG_LTWOYRS}" >
    <c:choose>
  <c:when test="${!empty billinglsttwoyr.curr_yrt or billinglsttwoyr.curr_yrt ne null}"> 
    <c:set var="billinglst2yrs_yr0t" value="${billinglsttwoyr.curr_yrt}" scope="page" /> 
  </c:when>
  <c:otherwise>  <c:set var="billinglst2yrs_yr0t" value="${billinglsttwoyr.curr_yrt}" scope="page" /> </c:otherwise>
  </c:choose>
     
     
      <c:choose>
  <c:when test="${!empty billinglsttwoyr.curr_yra or billinglsttwoyr.curr_yra ne null}"> 
     <c:set var="billinglst2yrs_yr0a" value="${billinglsttwoyr.curr_yra}" scope="page" /> 
  </c:when>
  <c:otherwise>   <c:set var="billinglst2yrs_yr0a" value="0" scope="page" /> </c:otherwise>
  </c:choose>
  
      <c:choose>
  <c:when test="${!empty billinglsttwoyr.prev_yrt or billinglsttwoyr.prev_yrt ne null}"> 
     <c:set var="billinglst2yrs_yr1t" value="${billinglsttwoyr.prev_yrt}" scope="page" />
  </c:when>
  <c:otherwise>   <c:set var="billinglst2yrs_yr1t" value="0" scope="page" /> </c:otherwise>
  </c:choose>
  
         <c:choose>
  <c:when test="${!empty billinglsttwoyr.prev_yra or billinglsttwoyr.prev_yra ne null}"> 
      <c:set var="billinglst2yrs_yr1a" value="${billinglsttwoyr.prev_yra}" scope="page" />
  </c:when>
  <c:otherwise>   <c:set var="billinglst2yrs_yr1a" value="0" scope="page" /></c:otherwise>
  </c:choose>
  
        <c:choose>
  <c:when test="${!empty billinglsttwoyr.scnd_prev_yrt or billinglsttwoyr.scnd_prev_yrt ne null}"> 
      <c:set var="billinglst2yrs_yr2t" value="${billinglsttwoyr.scnd_prev_yrt}" scope="page" /> 
  </c:when>
  <c:otherwise>   <c:set var="billinglst2yrs_yr2t" value="0" scope="page" /> </c:otherwise>
  </c:choose>
   
          <c:choose>
  <c:when test="${!empty billinglsttwoyr.scnd_prev_yra or billinglsttwoyr.scnd_prev_yra ne null}"> 
     <c:set var="billinglst2yrs_yr2a" value="${billinglsttwoyr.scnd_prev_yra}" scope="page" /> 
  </c:when>
  <c:otherwise>  <c:set var="billinglst2yrs_yr2a" value="0" scope="page" /> </c:otherwise>
  </c:choose>
    
     </c:forEach>
  </c:if>
  <!-- Font Awesome -->
  <link rel="stylesheet" href="resources/bower_components/font-awesome/css/font-awesome.min.css">
 
  <!-- Theme style -->
  <link rel="stylesheet" href="resources/dist/css/AdminLTE.min.css">
  <!-- AdminLTE Skins. Choose a skin from the css/skins
       folder instead of downloading all of them to reduce the load. -->
  <link rel="stylesheet" href="resources/dist/css/skins/_all-skins.min.css">
<link rel="stylesheet" type="text/css" href="resources/datatables/datatables-fjtco/css/jquery.dataTables.min.css"/>
<link rel="stylesheet" type="text/css" href="resources/datatables/buttons-fjtco/css/buttons.dataTables.min.css"/>
<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/dataTables.buttons.min.js"></script>
<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.flash.min.js"></script>
<script type="text/javascript" src="resources/datatables/ajax/excelmake/jszip.min.js"></script>
<!--  <script type="text/javascript" src="resources/datatables/ajax/pdfmake/vfs_fonts.js"></script>-->
<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.html5.min.js"></script>
<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.print.min.js"></script>

<link href="resources/css/regularisation_report.css" rel="stylesheet" type="text/css" />
<script src="resources/js/regularisation_report.js"></script>
 <script type="text/javascript">
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
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
 <script type="text/javascript">
 $(document).ready(function($) {
	 var userRole="${fjtuser.role}";
 function preLoader(){ $('#laoding').show();}
 google.charts.load('current', {'packages':['corechart','gauge','bar']});
  google.charts.setOnLoadCallback(drawBillingtestSummary_graph);
  google.charts.setOnLoadCallback(drawBookingtestSummary_graph);
  google.charts.setOnLoadCallback(drawForecast_graph);
  google.charts.setOnLoadCallback(drawEnqtoQtnVisualization);
  google.charts.setOnLoadCallback(drawQtnToLoiVisualization);
  google.charts.setOnLoadCallback(drawLoiToSoVisualization);
  google.charts.setOnLoadCallback(drawOrderToInvcVisualization);

	 if(userRole=="mg"){ document.forms['mgmentForm'].submit();// for managments
	 }else{ window.location.href = "sipDivision";}
 });
</script>
 <!-- .. graph activities start..  -->

 <script type="text/javascript">



  function drawOrderToInvcVisualization() {
	 
	   // so to invc graph 
						   var data = google.visualization.arrayToDataTable([
						    ['Year', 'Order',{type: 'string', role: 'tooltip'}, 'Invoice',{type: 'string', role: 'tooltip'}],
						   
						     ['2016', 0,'', 0,''],
						     ['2017', 0,'', 0,''],
						     ['2018', 0,'', 0,''],
						    
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
						title : ' ORDER - BILLING ANALYSIS (YTD)',
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

	 }
  function drawLoiToSoVisualization() {
	   // loi to so graph
						   var data = google.visualization.arrayToDataTable([
							   ['Year', 'LOI' ,{type: 'string', role: 'tooltip'}, 'Order Recieved' ,{type: 'string', role: 'tooltip'}],    
						  
						    
						     ['2016', 0, '', 0, ''],
						     ['2017', 0, '', 0, ''],
						     ['2018', 0, '', 0, ''],
						   
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
							
						 title : ' LOI - ORDER ANALYSIS (YTD)',
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
	
	}
 function drawQtnToLoiVisualization() {
	   // qtn to loi
						   var data = google.visualization.arrayToDataTable([
						    ['Year', 'JIH',{type: 'string', role: 'tooltip'}, 'LOI Recieved',{type: 'string', role: 'tooltip'}],
						    
						  
						     ['2016',0,'',0,''],
						     ['2017', 0,'', 0,''],
						     ['2018', 0,'',0,''],
						     
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
								
						 title : ' JIH - LOI ANALYSIS (YTD)',
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
	
	}
		
 function drawEnqtoQtnVisualization() {
   // Some raw data (not necessarily accurate)
					   var data = google.visualization.arrayToDataTable([
					    ['Year', 'Enquiry', 'Quotation',  'Avg. Days to Quote'],
					 
					     ['2016',0,0,0],
					     ['2017', 0, 0,0],
					     ['2018', 0,0,0],
					     
					 ]);
					var view = new google.visualization.DataView(data);
					 view.setColumns([0, 1,
					                 
					                  2,3]);
					 
					 
					 
					var options = {
							
					 title : ' ENQUIRY fg - QUOTATION ANALYSIS (YTD) ',
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

}

 
 function drawForecast_graph() {
	 
	 var data = google.visualization.arrayToDataTable([ 
		 ['Month', 'Accuraccy % ','Average % ',{type: 'string', role: 'tooltip'}],
      
	     
	     <c:if test="${1 le MTH}">  ['JAN',0,0, 'Average % : 0'],  </c:if>
         <c:if test="${2 le MTH}"> ['FEB', 0,0, 'Average % : 0'], </c:if>
         <c:if test="${3 le MTH}"> ['MAR', 0,0, 'Average % : 0'], </c:if>
         <c:if test="${4 le MTH}"> ['APR', 0,0, 'Average % : 0'], </c:if>
         <c:if test="${5 le MTH}">  ['MAY',0,0, 'Average % : 0'], </c:if>
         <c:if test="${6 le MTH}">  ['JUN', 0,0, 'Average % : 0'], </c:if>
         <c:if test="${7 le MTH}"> ['JUL', 0,0, 'Average % : 0'], </c:if>
         <c:if test="${8 le MTH}"> ['AUG', 0,0, 'Average % : 0'], </c:if>
         <c:if test="${9 le MTH}">  ['SEP', 0,0, 'Average % : 0'],</c:if>
         <c:if test="${10 le MTH}">['OCT', 0,0, 'Average % : 0'], </c:if>
         <c:if test="${11 le MTH}"> ['NOV', 0,0, 'Average % : 0'], </c:if>
         <c:if test="${12 le MTH}">  ['DEC', 0,0, 'Average % : 0'], </c:if>

		 
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
     }
 
 



 </script>
 
 <!--  .graph activities end..  -->
 </head>
 <c:choose>
 <c:when test="${!empty fjtuser.emp_code and !empty fjtuser.sales_code and (fjtuser.role eq 'mg' or fjtuser.salesDMYn ge 1) and fjtuser.checkValidSession eq 1}">
 
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
  <c:set var="billing_Curr_Mnth_Perc" value="${billngsum.month_perc}" scope="page" />
    </c:otherwise>
  </c:choose>
  
  <c:set var="billing_Ytd_Perc" value="${billngsum.ytd_perc}" scope="page" /> 
   <c:set var="billing_Curr_Mnth_Actual" value="${billngsum.month_actual}" scope="page" /> 
  <c:set var="billing_Curr_Mnth_Target" value="${billngsum.month_target}" scope="page" /> 
  <c:set var="billing_ytm_Actual" value="${billngsum.ytm_actual}" scope="page" /> 
   <c:set var="billing_ytm_Target" value="${billngsum.ytm_target}" scope="page" /> 
  </c:forEach>
	</c:if>	
		
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
     
             <li><a href="DmInfo.jsp"><i class="fa fa-dashboard"></i><span>Sales Engineers Performance</span></a></li>
             <li  class="active" ><a href="DisionInfo.jsp"><i class="fa fa-line-chart"></i><span>Sub Division  Performance</span></a></li>
             <li ><a href="#"><i class="fa fa-pie-chart"></i><span>Division  Performance</span></a></li>
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>
  
  
  


    <!-- Main content -->  
	   <div class="content-wrapper" style="margin-top: -20px;">
	   
	   
	   
	   
  <div class="row" style="margin-right: 30px;"><div class="col-md-12"style="background:white; margin-left: 15px;box-shadow: 0 1px 1px rgba(0,0,0,0.1);margin-top: 20px;">
  <div class="row" style="padding-top: 7px;">
  <div class="col-md-5 col-xs-12" >
<h4 class="divheader" style="
    font-family:sans-serif;
    width:  fit-content;
    font-weight:bold;
    color: #0065b3;">Division Performance - ${DIVDEFTITL}</h4>
</div>
    <div class="col-md-7" >
   <form  class="form-inline" method="post" action="sipDivision" >

                 <input type="hidden" id="octjf" name="octjf" value="rtlfvid" />
                
                  
						
<div class="form-group">  
 
<select class="form-control form-control-sm"  id="division_list"  name="tslvid" required>
     <option value="${DIVDEFTITL}">Select Division</option>
     <c:forEach var="divisions"  items="${DIVLST}" >
     <option value="${divisions.div_code}" ${divisions.div_code  == selected_division ? 'selected':''}>${divisions.div_desc}</option>
					 
	</c:forEach>
     
	
   
</select>

</div>
<div class="form-group">
<button type="submit" class="btn btn-primary" onclick="preLoader();">Refresh</button></div>
</form> 
</div>
</div>
</div>

</div>


    
 		  <div class="row">
        <div class="col-md-6">
          <!--JIHV CHART -->
          <div class="box box-primary" style="margin-top: 10px;border-top-color: #9e9e9e;">
         <div class="box-header with-border">
              <h3 class="box-title">JIH – LOST  Analysis </h3>
                     <div class="help-right-lost" id="help-qtnlost"><i class="fa fa-info-circle pull-left"></i>  </div>
            </div>
            <div class="box-body">
              <div class="chart">
          <div id="jihv" style="margin-top: 0px;height: 200px;">
           <table> 
      
           <tr><th></th><th></th>
           <th> <i class=" fa fa-cloud-download" aria-hidden="true" style="color:green;cursor:pointer;">&nbsp;0-3 Months</i></th>
           <th> <i class=" fa fa-cloud-download" aria-hidden="true"   style="color:green;cursor:pointer;">&nbsp;3-6 Months</i></th>
           <th> <i class=" fa fa-cloud-download" aria-hidden="true" style="color:green;cursor:pointer;">&nbsp;>6 Months</i></th></tr>
            <tr><th rowspan="2">JIH </th><td>COUNT</td><td>0</td><td>0</td><td>0 </td></tr>
            <tr><td>VALUE</td><td> 0</td>
            <td>0</td>
            <td>0</td></tr>
           <tr><th rowspan="2">LOST</th><td>COUNT</td><td>0</td><td>0</td><td>0</td></tr>
            <tr><td>VALUE</td><td>0</td><td>0</td><td> 0</td></tr>
           
           </table>
           
           </div> 
           
           <div class="overlay">
     <a href="#" data-toggle="modal" data-target="#jihvlostDtls">More info <i class="fa fa-arrow-circle-right"></i></a> 
     </div>   
              </div>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->

          <!-- Booking CHART -->
          <div class="box box-primary" style="margin-top: 10px;border-top-color: #9e9e9e;">
            
              <div class="box-body">
              <div class="chart">
              <div class="col-xs-8 col-md-8 text-center" style="padding-right:5px; padding-left:0;">
           
             
          
       <div id="booking" style="margin-top: -19px;margin-left:-10px;height: 230px;"></div> 
        <div class="row" style=" border: 1px solid #795548;text-align:  center;">
         <div class="fj-box" style="font-size:85%;background: #795548;font-weight:bold; color:  white;text-align:  center;">Avg. Booking of Last 2 Years </div>
       <c:set var="avgbknglsttwoyr" value="${bknglst2yrs_yr1a + bknglst2yrs_yr2a}" />
       <fmt:formatNumber type="number"   value="${avgbknglsttwoyr / 2 }"/>
       </div>
       <div class="help-left"  id="help-booking"><i class="fa fa-info-circle pull-left"></i>  </div>
           <a href="#" class="small-box-footer" data-toggle="modal" data-target="#bookingDtls">More info <i class="fa fa-arrow-circle-right"></i></a> 
           </div>
                <div class="col-xs-4 col-md-4 text-center" style="padding-right:0; padding-left:0;">
                <div class="row" style=" border: 1px solid #795548;text-align:  center;">
       <div class="fj-box" style="font-size:85%;background: #795548;font-weight:bold; color:  white;text-align:  center;">
                  
                Booking Curr. Month </div>
                <span>Target : <fmt:formatNumber type="number"   value="${booking_Curr_Mnth_Target}"/></span><br/><span>
                Actual : <fmt:formatNumber type="number"   value="${booking_Curr_Mnth_Actual}"/> </span>
                
                  </div>
          
                  <div class="row fj-bk-per" style="border: 1px solid #795548;padding: 5px;padding-left: 22%;padding-right: 22%; margin-top: 4px;">
               <c:choose>
               <c:when test="${booking_Curr_Mnth_Perc > 100}">
                   <input type="text" class="knob" value="${booking_Curr_Mnth_Perc}" data-max="${booking_Curr_Mnth_Perc}" data-width="85" data-height="85" data-fgColor="#795548" data-readonly="true"  data-angleArc="250" data-angleOffset="-125">
                   </c:when>
                 <c:otherwise>  
                 <input type="text" class="knob" value="${booking_Curr_Mnth_Perc}" data-width="85" data-height="85" data-fgColor="#795548" data-readonly="true"  data-angleArc="250" data-angleOffset="-125">
                  </c:otherwise>
                 </c:choose>  
                       <div class="knob-label" style="margin-top: -20px;    font-size: 11px;">Curr. Month  %</div>
                   </div>
                 <div class="row fj-bk-per" style="border: 1px solid #795548;padding: 5px;padding-left: 22%;padding-right: 22%; margin-top:4px;">
               <c:choose>
               <c:when test="${booking_Ytd_Perc > 100}">
                   <input type="text" class="knob" value="${booking_Ytd_Perc}"  data-max="${booking_Ytd_Perc}" data-width="85" data-height="85" data-fgColor="#795548" data-readonly="true"   data-angleArc="250" data-angleOffset="-125">
                 </c:when>
                 <c:otherwise>
                 <input type="text" class="knob" value="${booking_Ytd_Perc}"  data-width="85" data-height="85" data-fgColor="#795548" data-readonly="true"   data-angleArc="250" data-angleOffset="-125">
                 </c:otherwise>
                 </c:choose>  
                       <div class="knob-label" style="margin-top: -20px;    font-size: 9px;">BOOKING VS TARGET YTD %</div>
                   </div>
                </div>
        
              </div>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->


 <!-- Enquiry to Qtn CHART -->
          <div class="box box-primary" style="margin-top: 10px;border-top-color: #9e9e9e;">
           
              <div class="box-body">
              <div class="chart">
             
           
             
          
       <div id="enq_to_qtn" style="margin-top: 0px;margin-left:0px;height: 230px;"></div> 
       <div class="help-right"  id="help-enqToqtn"><i class="fa fa-info-circle pull-left"></i>  </div>
        <div class="overlay">
     <a href="#" data-toggle="modal" data-target="#enq_to_qtn_modal">More info <i class="fa fa-arrow-circle-right"></i></a> 
     </div>
            </div>
            
            </div>
            <!-- /.Enquiry  box-body -->
          </div>
          <!-- /.Enquiry  box end -->
          <!-- Loi to So CHART -->
         <div class="box box-primary" style="margin-top: 10px;border-top-color: #9e9e9e;">
           
              <div class="box-body">
              <div class="chart">
             
           
             
          
       <div id="loi_to_so" style="margin-top: 0px;margin-left:0px;height: 230px;"></div> 
       <div class="help-right"  id="help-loiToso"><i class="fa fa-info-circle pull-left"></i>  </div>
        <div class="overlay">
     <a href="#" data-toggle="modal" data-target="#loi_to_so_modal">More info <i class="fa fa-arrow-circle-right"></i></a> 
     </div>
            </div>
        
            </div>
            <!-- /.Loi to So box-body -->
          </div>
          <!-- /.Loi to So box end -->

        </div>
        <!-- /.col (LEFT) -->
        <div class="col-md-6">
        
         
         <div class="box box-primary" style="margin-top: 10px;border-top-color: #9e9e9e;">
            
            <div class="box-body">
              <div class="chart">
              <div class="box-header with-border">
              <h3 class="box-title"> Forecasted vs  Billing  Analysis -${CURR_YR}</h3>
               
      
               
             
            </div>
	 
             
       <div id="forecast-graph" style="margin-top: 1px;height: 183px;float:left;width:70%;margin-right: 5px;    border: 1px solid gray;
    padding-right: 5px;"></div>  
      
       <div style="height: 183px;float:left;width:27%;margin-left: 5px;    border: 1px solid gray;
    padding: 5px;">
        <div  class="row" style="margin-bottom:5px;font-size:80%;font-weight:bold;"><strong>${CURR_MTH}-${CURR_YR} Analysis</strong>  </div>
       <div class="row" style=" border: 1px solid #0065b3;text-align:  center;font-weight:bold;">
         <div class="jj" style="
    background: #0065b3;font-weight:bold; color:  white;text-align:  center;">Forecast </div>
    <c:choose>
    <c:when  test="${fcast_main eq  0}"> Not set</c:when>
    <c:when  test="${fcast_main eq null }"> Not set</c:when>
    <c:otherwise><fmt:formatNumber type="number"   value="${fcast_main}"/></c:otherwise>
 </c:choose>
   
       </div>
       <div class="row" style="border: 1px solid #0065b3;text-align:  center;font-weight:bold;margin-top:4px;">
         <div class="jj" style="background: #0065b3;color:  white;font-weight:bold; text-align:  center;">Billing</div>
         
         <c:choose>
    <c:when  test="${fcast_invoice eq  0}"> 0</c:when>
    <c:when  test="${fcast_main eq null }"> 0</c:when>
    <c:otherwise><fmt:formatNumber type="number"   value="${fcast_invoice}"/></c:otherwise>
 </c:choose>
         
         
       </div>
       
       <div class="row" style="border: 1px solid #0065b3; text-align:  center;font-weight:bold;margin-top:4px;">
         <div class="jj" style=" background: #0065b3;color:  white;font-weight:bold;text-align:  center;">Actual %</div>
      <div class="row fj-bk-per" style="padding: 5px; margin-top: 4px;height:30px;">
             <div class="progress" style=" border: 1px solid #fff;  background: #01b8aa;">
   
               <c:choose>
               
               <c:when test="${fcast_perc > 0 }">
                 <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="${fcast_perc}" aria-valuemin="0" aria-valuemax="${fcast_perc}" style="width:${fcast_perc}%;background:black;">
      ${fcast_perc}%  </div>
               </c:when>
               <c:when test="${fcast_perc eq null}">
                       <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%;color:white !important;background:black;">
      0%  </div></c:when>
        <c:when test="${fcast_perc eq 0}">
                       <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width:0%;color:white !important;background:black;">
      0%  </div></c:when>
               <c:otherwise>
                        <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="${fcast_perc}" aria-valuemin="0" aria-valuemax="100" style="width:${fcast_perc}%;background:black;">
      ${fcast_perc}%  </div> </c:otherwise>
               </c:choose>
               
               </div>
      
      

       
       </div> 
 
       
               
              </div>
         
            </div>
            <div class="help-right"  id="help-frcst"><i class="fa fa-info-circle pull-left"></i>  </div>
             <div class="row">
                 <a href="#" class="small-box-footer" data-toggle="modal" data-target="#modal-default">More info <i class="fa fa-arrow-circle-right"></i></a> 
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.billing box -->
       
</div></div>
        
         <!-- BILLING CHART -->
          <div class="box box-primary" style="margin-top: 10px;border-top-color: #9e9e9e;">
            
              <div class="box-body">
              <div class="chart">
              <div class="col-xs-8 col-md-8 text-center" style="padding-right:5px; padding-left:0;">
           
          
       <div id="billing" style="margin-top: -19px;margin-left:-10px;height: 230px;"></div> 
        <div class="row" style=" border: 1px solid #607d8b;text-align:  center;">
         <div class="fj-box" style="font-size:85%;background: #607d8b;font-weight:bold; color:  white;text-align:  center;">Avg. Billing of Last 2 Years </div>
       <c:set var="avgbillinglsttwoyr" value="${billinglst2yrs_yr1a + billinglst2yrs_yr2a}" />
       <fmt:formatNumber type="number"   value="${avgbillinglsttwoyr / 2 }"/>
       </div>
       <div class="help-left"  id="help-billing"><i class="fa fa-info-circle pull-left"></i>  </div>
           <a href="#" class="small-box-footer" data-toggle="modal" data-target="#billingDtls">More info <i class="fa fa-arrow-circle-right"></i></a> 
           </div>
                <div class="col-xs-4 col-md-4 text-center" style="padding-right:0; padding-left:0;">
                <div class="row" style=" border: 1px solid #607d8b;text-align:  center;">
       <div class="fj-box" style="font-size:85%;background: #607d8b;font-weight:bold; color:  white;text-align:  center;">
                  
                Billing Curr. Month </div>
                <span>Target :  <fmt:formatNumber type="number"   value="${billing_Curr_Mnth_Target}"/></span><br/><span>
                Actual :  <fmt:formatNumber type="number"   value="${billing_Curr_Mnth_Actual}"/></span>
                
                  </div>
        
                  <div class="row fj-bk-per" style="border: 1px solid #607d8b;padding: 5px;padding-left: 22%;padding-right: 22%; margin-top: 4px;">
               <c:choose>
               
               <c:when test="${billing_Curr_Mnth_Perc > 100 }">
                <input type="text" class="knob" value="${billing_Curr_Mnth_Perc}" data-max="${billing_Curr_Mnth_Perc}" data-width="85" data-height="85" data-fgColor="#607d8b" data-readonly="true" data-angleArc="250" data-angleOffset="-125">
               </c:when>
               <c:otherwise>
                <input type="text" class="knob" value="${billing_Curr_Mnth_Perc}" data-width="85" data-height="85" data-fgColor="#607d8b" data-readonly="true" data-angleArc="250" data-angleOffset="-125">
               </c:otherwise>
               </c:choose>
                  
                       <div class="knob-label" style="margin-top: -20px;    font-size: 11px;">Curr. Month  %</div>
                   </div>
                 <div class="row fj-bk-per" style="border: 1px solid #607d8b;padding: 5px;padding-left: 22%;padding-right: 22%; margin-top:4px;">
               <c:choose>
               <c:when test="${billing_Ytd_Perc > 100 }">
                   <input type="text" class="knob" value="${billing_Ytd_Perc}" data-width="85" data-max="${billing_Ytd_Perc}" data-height="85" data-fgColor="#607d8b" data-readonly="true" data-angleArc="250" data-angleOffset="-125">
                  </c:when>
                  <c:otherwise>
                  <input type="text" class="knob" value="${billing_Ytd_Perc}" data-width="85" data-height="85" data-fgColor="#607d8b" data-readonly="true" data-angleArc="250" data-angleOffset="-125">
                  </c:otherwise></c:choose>    
                       <div class="knob-label" style="margin-top: -20px;    font-size: 9px;">BILLING VS TARGET YTD %</div>
                   </div>
                </div>
        
              </div>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.billing box -->
          
         <!-- Qtn to LOI CHART -->
          <div class="box box-primary" style="margin-top: 10px;border-top-color: #9e9e9e;">
           
              <div class="box-body">
              <div class="chart">
             
           
             
          
       <div id="qtn_to_loi" style="margin-top: 0px;margin-left:0px;height: 230px;"></div> 
       <div class="help-right"  id="help-jihToloi"><i class="fa fa-info-circle pull-left"></i>  </div>
        <div class="overlay">
     <a href="#" data-toggle="modal" data-target="#qtn_to_loi_modal">More info <i class="fa fa-arrow-circle-right"></i></a> 
     </div>
            </div>
        
            </div>
            <!-- /.QTN TO LOI  box-body -->
          </div>
          <!-- /.QTN TO LOI  box end -->


      <!-- ORDER to INVC CHART -->
          <div class="box box-primary" style="margin-top: 10px;border-top-color: #9e9e9e;">
           
              <div class="box-body">
              <div class="chart">
             
           
             
          
       <div id="order_to_invc" style="margin-top: 0px;margin-left:0px;height: 230px;"></div> 
       <div class="help-right"  id="help-soToinvc"><i class="fa fa-info-circle pull-left"></i>  </div>
        <div class="overlay">
     <a href="#" data-toggle="modal" data-target="#so_to_invc_modal">More info <i class="fa fa-arrow-circle-right"></i></a> 
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
	   
	   <form id="mgmentForm" name="mgmentForm" action="sipDivision" method="post">
                <input type="hidden" name="octjf" value="dmfsltdmd" />
                 <input type="hidden" name="dmCodemgmnt" value="${empCodee}" />
       </form>
     	
       <!--  Modal start -->
       
    
           
	<!--  modal end -->
	<div id="laoding" class="loader" ><img src="resources/images/wait.gif"></div>
    
    </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <div class="pull-right hidden-xs">
      <b>Version</b> 1.1.0
    </div>
    <strong>Copyright &copy; 1988-2018 <a href="http://www.faisaljassim.ae/">Faisal Jassim Group</a>.</strong> All rights
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

<!-- FastClick -->
<script src="resources/bower_components/fastclick/lib/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="resources/dist/js/adminlte.min.js"></script>

<script src="resources/bower_components/jquery-slimscroll/jquery.slimscroll.min.js"></script>
<script src="resources/bower_components/jquery-knob/js/jquery.knob.js"></script>

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
  
    /* END JQUERY KNOB */

 
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