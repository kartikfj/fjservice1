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
  request.setAttribute("CURR_YR",iYear);
  request.setAttribute("currCal", currCalDtTime);
  request.setAttribute("currWeek", week);
  
 %>
<%@page import="com.google.gson.Gson"%>
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
	<link rel="stylesheet" type="text/css" href="././resources/css/bootstrap-clockpicker.min.css">
	<script type="text/javascript" src="././resources/datatables/datatables-fjtco/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="././resources/datatables/datatables-fjtco/js/dataTables.buttons.min.js"></script>
	<script type="text/javascript" src="././resources/datatables/buttons-fjtco/js/buttons.flash.min.js"></script>
	<script type="text/javascript" src="././resources/datatables/ajax/excelmake/jszip.min.js"></script>
	<script type="text/javascript" src="././resources/datatables/buttons-fjtco/js/buttons.html5.min.js"></script>
	<script type="text/javascript" src="././resources/datatables/buttons-fjtco/js/buttons.print.min.js"></script>	
	<script type="text/javascript" src="resources/js/bootstrap-clockpicker.min.js"></script>
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
.content-header>h1 { letter-spacing: 0.1em !important;}
.main-header .navbar,.skin-blue .main-header .logo, .skin-blue .main-header .logo {background-color: #065685 !important;}
@media (max-width: 767px),@media (max-width: 375px){
.main-header { background: #065685;}.popover{ -ms-transform: scale(0.8);  -webkit-transform: scale(0.8); transform: scale(0.8);  top:10px !important;  margin-left:50px; }
}
.content{height: max-content;}.navbar-brand {  padding: 0px;} 
.navbar-brand>img {  height: 101%;  width: auto;  margin-left: 5px;   margin-right: 6px;}.navbar {border-radius: 0px; }
.navbar ul li{font-style: normal;font-variant-ligatures: normal;font-variant-caps: normal;   font-variant-numeric: normal;   font-variant-east-asian: normal; font-stretch: normal;   line-height: normal;   font-size: 14px;     font-weight: 700;}
.navbar-default .navbar-nav>li>a:hover, .navbar-default .navbar-nav>.open>li>a, .navbar-default .navbar-nav>.open>li>a:focus, .navbar-default .navbar-nav>.open>li>a:hover{background:#fff;color:#008ac1;} 
.tpm{margin-top: 10px;} .table-bordered>thead>tr>th, .table-bordered>tbody>tr>th, .table-bordered>tfoot>tr>th, .table-bordered>thead>tr>td, .table-bordered>tbody>tr>td, .table-bordered>tfoot>tr>td {border: 1px solid #607D8B !important;}
th { background: #3f51b314;}.box-title{letter-spacing: 0.09em; text-transform: uppercase;}.box-header{    border-bottom: 1px solid #9E9E9E;}.modal-header{ background: #335769; letter-spacing: 0.2em;  color: white; }
.modal-content {   -webkit-border-top-right-radius: 20px !important;  -moz-border-top-right-radius: 20px !important; border-top-right-radius: 20px !important;   -webkit-border-top-left-radius: 20px !important;  -moz-border-top-left-radius: 20px !important;    border-top-left-radius: 20px !important; }
.close {  color: #fff;     opacity: 1;} .loader {position: fixed; z-index: 999; height: 2em;width: 2em;overflow: show; margin: auto; top: 0;left: 0;bottom: 0; right: 0;}
.loader:before { content: '';display: block;position: fixed;top: 0; left: 0;width: 100%; height: 100%; background-color: rgba(0,0,0,0.3);} 
#err-msg{color:red;} .filetrs{width:110px;display:inline !important;margin-bottom:5px !important;}.navbar-nav>.notifications-menu>.dropdown-menu>li.header{background-color: #065685 !important;} 
@media only screen and (max-width: 640px) { } 
.hr-eval-timeline .catSummarys {border-top: 3px solid #795548;}.hr-eval-timeline .catSummarys .evl-cat-list {display: block;  position: relative;  text-align: center;  padding-top: 70px;  margin-right: 0;}
.hr-eval-timeline .catSummarys .evl-cat-list:before {content: ""; position: absolute;   height: 36px;  border-right: 2px dashed #795548c4;   top: 0;}
.hr-eval-timeline .catSummarys .evl-cat-list .evl-count-btn { position: absolute;  top: 38px;  left: 0;  right: 0;   width: max-content;  margin: 0 auto;  border-radius: 4px;  padding: 2px 8px;  color: #ffffff;}
@media (min-width: 1140px) {
.hr-eval-timeline .catSummarys .evl-cat-list {  display: inline-block;  width: 14%;  padding-top: 25px; }.hr-eval-timeline .catSummarys .evl-cat-list .evl-count-btn {top: -20px;}
}
.bg-evl-completed { background-color: #009688 !important;  border-color: #009688 !important;}.bg-evl-notCompleted {   /*background-color: red !important;*/} 
.eval-category-title{font-weight: 700;  font-family: monospace;   letter-spacing: 0.001em;  text-transform: uppercase;  background: #222d32; /*#607d8b;*/  padding: 5px 0px;  border-radius: 3px;  font-size: 85%; color:#fff !important;}
.category-summary { margin-top: 10px;}.contentColumn{width:20%;}.typingColumn{width:40%;}.viewColumn{width:20%;}.typingBox{width:100%;}.srlColumn, .actionColumn{width:10px;}.final-instruction{font-weight: bold;padding-right:20px;font-family: monospace;  font-size: 1.3em;}
#user-profile-box{    padding: 0px 0px !important;  letter-spacing: 0.01em;} #user-profile-box h5{ font-family: monospace !important;}.user-title{color: #9c27b0 !important; font-family: monospace;  font-weight: 700;}
#notification-btn-box{margin-top: -35px !important; width:max-content !important;} 
#notification { visibility: hidden;max-width: 50px;   height: 50px;  /*margin-left: -125px;*/margin: auto;  background-color: #fff;   color: #000;    text-align: center;  border-radius: 2px;  position: fixed;  z-index: 1;   left: 0;right:0;   bottom: 70%;  font-size: 17px;  white-space: nowrap;  border: 1px solid #065685;  box-shadow: 0 2px 26px #06568552;  font-family:'monospace';}
#notification #notification_icon{width: 49px; height: 49px;  float: left; padding-top: 12px; padding-bottom: 12px; box-sizing: border-box; background-color: #fff;  border: 1px solid #065685;  color: #065685 !important;}
#notification #notification_desc{color: #000;   padding: 12px;   overflow: hidden;white-space: nowrap;}
#notification.show { visibility: visible;  -webkit-animation: fadein 0.5s, expand 0.5s 0.5s,stay 3s 1s, shrink 0.5s 2s, fadeout 0.5s 2.5s;  animation: fadein 0.5s, expand 0.5s 0.5s,stay 3s 1s, shrink 0.5s 4s, fadeout 0.5s 4.5s;}
@-webkit-keyframes fadein {  from {bottom: 0; opacity: 0;}   to {bottom: 70%; opacity: 1;} }
@keyframes fadein { from {bottom: 0; opacity: 0;}  to {bottom:  70%; opacity: 1;} }
@-webkit-keyframes expand {   from {min-width: 50px}   to {min-width: 350px} }
@keyframes expand { from {min-width: 50px}  to {min-width: 350px} }
@-webkit-keyframes stay {  from {min-width: 350px}   to {min-width: 350px} }
@keyframes stay { from {min-width: 350px} to {min-width: 350px} }
@-webkit-keyframes shrink { from {min-width: 350px;}   to {min-width: 50px;} }
@keyframes shrink {  from {min-width: 350px;}   to {min-width: 50px;} }
@-webkit-keyframes fadeout { visibility: hidden;  from {bottom:  70%; opacity: 1;}  to {bottom:  75%; opacity: 0;}}
@keyframes fadeout { visibility: hidden;  from {bottom:  70%; opacity: 1;}  to {bottom:  75%; opacity: 0;}}
.user-content, .user-title{white-space: nowrap;   display: inline-block;}.cutomMinHeight{ min-height: 100% !important;  }.stickyBox{position: fixed; opacity: 0.8; left: -11px; z-index: 999; margin-top: 10%;}
.stickyBtn{    background-color: #ff9800 !important;  border-color: #ff9800 !important; padding: 4px 4px; border-radius: 4px;height: 50px !important;}.stickyBtn:hover{background-color: #009688 !important; border-color: #009688 !important;color: #fff ;}  
 .btn-app{min-width: 65px !important; color: #fff !important;}
.modal-dialog{ overflow-y: initial !important}#othrCmntRatingBox{color:#ff5722;}
.btn-employee, .btn-employee:hover {background-color: #795548;  border-color: #795548; cursor: none !important;color:#fff !important;}
.btn-manager, .btn-manager:hover{background-color: #607d8b;  border-color: #607d8b; cursor: none !important;color:#fff !important;}
.btn-hr, .btn-hr:hover{background-color: #8b607d;  border-color: #8b607d; cursor: none !important;color:#fff !important;}
.text-dark{color:black;font-weight: 700;}.totalScore{font-weight: 700;}#actualScore, #targetScore{ color:black;}.content{background: #ecf0f5 !important;height: auto !important;} 
#selected-user-box{margin-top: -35px !important; width:max-content !important;}
.generalHTitle{font-weight:700;}.generalPBlock{border:1px solid #000;padding:5px;}
#pendingBtn{border: 1px solid #dadce0;
    -webkit-border-radius: 18px;
    border-radius: 18px;letter-spacing: .25px;
    background: white;z-index: 0;
    -webkit-font-smoothing: antialiased;
    font-family: 'Google Sans', Roboto,RobotoDraft,Helvetica,Arial,sans-serif;margin-left: 40%;color: #616161;}
    #pendingArrow{vertical-align: 0% !important;}
    #pendingIcon{color:#f10b0b;}
    #modal-pending .modal-body{overflow-y: scroll;  max-height: 70%;}
    .ui-datepicker-year, .ui-datepicker-month{background: #000 !important;}
.category-summary { margin-top: 10px;}.mgcontentColumn{width:20%;}.typingColumn{width:40%;}.viewColumn{width:20%;}.mgtypingBox{width:100%;}.srlColumn, .mgactionColumn{width:10px;}.final-instruction{font-weight: bold;padding-right:20px;font-family: monospace;  font-size: 1.3em;}
</style>
</head>