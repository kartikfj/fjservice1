<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
        response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
        response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
        response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
        response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
%>
<jsp:useBean id="fjtuser" class="beans.fjtcouser" scope="session"/>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%
  DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
  Calendar cal = Calendar.getInstance();
  int week = cal.get(Calendar.WEEK_OF_YEAR);
  int iYear = cal.get(Calendar.YEAR);  
  String currCalDtTime = dateFormat.format(cal.getTime());
  request.setAttribute("CURR_Dtime",currCalDtTime);
  request.setAttribute("CURR_YR",iYear);
  request.setAttribute("currCal", currCalDtTime);
  request.setAttribute("currWeek", week);
  
 %>
 <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title>FJ Group</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<link href="././resources/abc/style.css" rel="stylesheet" type="text/css" />
	<link href="././resources/abc/responsive.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="././resources/abc/bootstrap.min.css">
	<script src="././resources/abc/jquery.min.js"></script>
	<script src="././resources/abc/bootstrap.min.js"></script>
    <link rel="stylesheet" href="././resources/bower_components/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="././resources/dist/css/skins/_all-skins.min.css">
	<link rel="stylesheet" type="text/css" href="././resources/datatables/datatables-fjtco/css/jquery.dataTables.min.css" />
	<link rel="stylesheet" type="text/css" href="././resources/datatables/buttons-fjtco/css/buttons.dataTables.min.css" /> 
	<script type="text/javascript" src="././resources/datatables/datatables-fjtco/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="././resources/datatables/datatables-fjtco/js/dataTables.buttons.min.js"></script> 
	<script type="text/javascript" src="././resources/datatables/buttons-fjtco/js/buttons.flash.min.js"></script>
	<script type="text/javascript" src="././resources/datatables/ajax/excelmake/jszip.min.js"></script>
	<script type="text/javascript" src="././resources/datatables/buttons-fjtco/js/buttons.html5.min.js"></script>
	<script type="text/javascript" src="././resources/datatables/buttons-fjtco/js/buttons.print.min.js"></script>	 
 	<link href="././resources/css/jquery-ui.css" rel="stylesheet">
	<script src="././resources/js/jquery-ui.js"></script>
	<script src="././resources/bower_components/moment/moment.js"></script>	
	<script src="resources/js/date-eu.js"></script>
		
  <!-- Theme style -->
  <link rel="stylesheet" href="././resources/bower_components/select2/dist/css/select2.min.css">
  <link rel="stylesheet" href="././resources/dist/css/AdminLTE.min.css">
  <link rel="stylesheet" href="././resources/dist/css/skins/_all-skins.min.css"> 
   <script>
   if ( window.history.replaceState ) {
	    window.history.replaceState( null, null, window.location.href );
	}
   </script>
   <style>
.content-header>h1 {
    letter-spacing: 0.1em !important;
}
.main-header .navbar,.skin-blue .main-header .logo, .skin-blue .main-header .logo {background-color: #065685 !important;}
@media (max-width: 767px),@media (max-width: 375px){
.main-header { background: #065685;}
.popover{-ms-transform: scale(0.8);  -webkit-transform: scale(0.8);   transform: scale(0.8); top:10px !important;margin-left:50px; }}}
.content{height: max-content;}
.navbar-brand { padding: 0px;}
.navbar-brand>img { height: 101%;  width: auto; margin-left: 5px;margin-right: 6px;}
.navbar {border-radius: 0px; }
.navbar ul li{font-style: normal;font-variant-ligatures: normal;  font-variant-caps: normal;font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal;  line-height: normal; font-size: 14px; font-weight: 700;}

.navbar-default .navbar-nav>li>a:hover, .navbar-default .navbar-nav>.open>li>a, .navbar-default .navbar-nav>.open>li>a:focus, .navbar-default .navbar-nav>.open>li>a:hover{background:#fff;color:#008ac1;} 
.table-bordered>thead>tr>th, .table-bordered>tbody>tr>th, .table-bordered>tfoot>tr>th, .table-bordered>thead>tr>td, .table-bordered>tbody>tr>td, .table-bordered>tfoot>tr>td {  border: 1px solid #607D8B !important;}
th {background: #3f51b314;}
.box-title{letter-spacing: 0.09em;text-transform: uppercase;}
.box-header{    border-bottom: 1px solid #9E9E9E;}
.loader {position: fixed; z-index: 999; height: 2em;width: 2em;overflow: show; margin: auto; top: 0;left: 0;bottom: 0; right: 0;}
.loader:before { content: '';display: block;position: fixed;top: 0; left: 0;width: 100%; height: 100%; background-color: rgba(0,0,0,0.3);}
#err-msg{color:red;} 
.filetrs{width: 85px; font-size: 12px; display: inline !important; margin-bottom: 1px !important; height: 25px !important;}
.filetrs-txtArea{width: 90px; font-size: 12px; display: inline !important; margin-bottom: 1px !important;}
 
    .navbar-nav>.notifications-menu>.dropdown-menu>li.header{background-color: #065685 !important;} 
    @media only screen and (max-width: 800px) {
}
 
@media only screen and (max-width: 640px) { 
	  .table-responsive>.table>tbody>tr>td{white-space: normal !important;}
	 table tr>th, table tr>td{font-size:10px !important;}
	 #btn-nw-rqst{margin-left: 15px !important;}
	 .entry-btn-div {margin-top: -30px !important;}
	 div.dt-buttons,.dataTables_wrapper .dataTables_info {  float: left !important;}
	 .box-header .box-title, .content-header>h1{font-size: 14px !important;}
}
.divnStyl{background-color: #ffeb3b54; color: #000000 !important;}
.fnStyl{background-color: #8bc34a47;color: #000000 !important;}
.lgStyl{background-color: #ff57223d;color: #000000 !important;}
.updatedStyl{color:#009688 !important;}
.pmtStatus{padding: 5px; font-weight:bold;}
table.dataTable tbody th, table.dataTable tbody td {  padding: 2px 4px !important;}
table.dataTable {position:relative;max-width:100%;margin:auto;overflow:hidden;border:1px solid #c1c1c1;background: #ecf0f5;}
table.dataTable {width:100%;overflow:auto;	height:max-content;}
.dtlsHeader{  position:relative;cursor:pointer;}
.dtlsContent{  display:none; position:absolute; z-index:100;border:1px solid #020202; color:#000000; border-radius:5px;  background-color:#ffffff;  padding:5px;  top:22px; left:5px;}
.lg_dtlsContent{  display:none; position:absolute; z-index:100;border:1px solid #020202; color:#000000; border-radius:5px;  background-color:#ffffff;  padding:5px;  top:22px; right:22%;}
.dtlsHeader:hover span.dtlsContent, .dtlsHeader:hover span.lg_dtlsContent{
 display:block;   width: 250px;  word-wrap: break-word;white-space: normal
 }
table.dataTable thead th, table.dataTable thead td {  padding: 5px 8px !important; }
.table>tbody>tr>td{vertical-align: middle !important;}
.updateBtn:active  + span.dtlsContent, .updateBtn:hover  + span.dtlsContent{ display:none !important;}
.updateBtn:active  + span.lg_dtlsContent, .updateBtn:hover  + span.lg_dtlsContent{ display:none !important;}
 #exportPo{margin-left:45%;margin-top:10px;}.box-body{margin-top: -14px !important;}
 .form-control{padding: 1px 1px !important;}
 
</style>

</head>