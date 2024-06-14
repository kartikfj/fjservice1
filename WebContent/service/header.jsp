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
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title>Faisal Jassim Trading Co L L C</title>
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
.popover{
    -ms-transform: scale(0.8);
    -webkit-transform: scale(0.8); 
    transform: scale(0.8);
   top:10px !important;
    margin-left:50px; }
}
}


.content{height: max-content;}


.navbar-brand {
  padding: 0px;
}
/* new style by nufail */
.navbar-brand>img {
  height: 101%;
  width: auto;
  margin-left: 5px;
  margin-right: 6px;
}
.navbar {
    border-radius: 0px; 
}
.navbar ul li{
	
	
	font-style: normal;
    font-variant-ligatures: normal;
    font-variant-caps: normal;
    font-variant-numeric: normal;
    font-variant-east-asian: normal;
    font-stretch: normal;
    line-height: normal;
    font-size: 14px;
    font-weight: 700;
}

.navbar-default .navbar-nav>li>a:hover, .navbar-default .navbar-nav>.open>li>a, .navbar-default .navbar-nav>.open>li>a:focus, .navbar-default .navbar-nav>.open>li>a:hover{
background:#fff;
color:#008ac1;


}
.prjctDetails{display:none;border: 1px solid #9E9E9E;background: #fffcfc;    margin-top: 10px;}
.tpm{margin-top: 10px;}
.cost-div{border-bottom: 1px solid #0f395a;
    padding: 5px;
    letter-spacing: 0.07em;
    font-weight: 700;
}
.srvc-form-footer{border-top: 2px solid #f4f4f4;
    padding: 10px;}
    
 .table-bordered>thead>tr>th, .table-bordered>tbody>tr>th, .table-bordered>tfoot>tr>th, .table-bordered>thead>tr>td, .table-bordered>tbody>tr>td, .table-bordered>tfoot>tr>td {
    border: 1px solid #607D8B !important;
}
th { background: #3f51b314;}
.box-title{letter-spacing: 0.09em;
    text-transform: uppercase;}
.box-header{    border-bottom: 1px solid #9E9E9E;}
.entry-btns{padding:10px;margin-bottom:15px;}
.fld-entry-dtls{background: #f39c12ed;
    color: #fff;}
    .mob-vst-view{width: 115px; border: 0.05em solid #b78900;}
    
    .entry-vst-head{    background: #b78900;
    padding: 5px;
    color: whitesmoke;
    letter-spacing: 0.09em;
    font-family: monospace;
    border-top-right-radius: 5px;
    border-top-left-radius: 5px;
    text-align: center;
    margin-top: -15px;}
    .entry-vst-flds{color: #b78900;
    letter-spacing: 0.15em;padding-top: 5px;}
    
    .etry-vst-modal-header{
        background: #335769;
    letter-spacing: 0.2em;
    color: white;
    border-top-right-radius: 20px;
    border-top-left-radius: 20px;
     -webkit-border-topradius: 20px !important;
    -moz-border-radius: 20px !important;
      -webkit-border-top-left-radius: 20px !important;
    -moz-border-top-left-radius: 20px !important;
}
    #modal-entryOffice .modal-content,  #modal-officestaff .modal-content, #modal-officestaff .modal-content, #modal-entrystaff .modal-content  {
    -webkit-border-top-right-radius: 20px !important;
    -moz-border-top-right-radius: 20px !important;
    border-top-right-radius: 20px !important; 
     -webkit-border-top-left-radius: 20px !important;
    -moz-border-top-left-radius: 20px !important;
    border-top-left-radius: 20px !important; 
}
#modal-entryOffice .close,#modal-entrystaff .close {
    color: #fff; 
    opacity: 1;
}
.actual-cost{border-color: #795548 !important;background-color: #795548 !important;color:#fff !important;}
.loader {position: fixed; z-index: 999; height: 2em;width: 2em;overflow: show; margin: auto; top: 0;left: 0;bottom: 0; right: 0;}
.loader:before { content: '';display: block;position: fixed;top: 0; left: 0;width: 100%; height: 100%; background-color: rgba(0,0,0,0.3);}
#pdata_table{margin-bottom: 0px !important;}
#err-msg{color:red;} 
.entry-btn-div{padding:20px;margin-top:-25px;}
.cls-btn-cust{color:#fff !important;opacity : 1 !important;}
#message-block{display:none;}
.remove {
  display:none !important;
}
td.truncate {
  max-width:100px;
  /*white-space: nowrap;*/
  overflow: hidden;
  text-overflow: ellipsis;
} 
.filetrs{width:110px;display:inline !important;margin-bottom:5px !important;}
.txt-trim{ } 
    [title]{color:red;} 
    .navbar-nav>.notifications-menu>.dropdown-menu>li.header{background-color: #065685 !important;} 
</style>

</head>