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
  int week = cal.get(Calendar.WEEK_OF_YEAR);
  String currCalDtTime = dateFormat.format(cal.getTime());
  request.setAttribute("CURR_YR",iYear);
  request.setAttribute("MTH",month);
  request.setAttribute("currCal", currCalDtTime);
  request.setAttribute("currWeek", week);
  
 %>
 <head> 
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
	<link rel="stylesheet" href="resources/bower_components/select2/dist/css/select2.min.css">
	<link rel="stylesheet" href="resources/css/sipCommonStyle.css?v=3.0.6">
	<script src="././resources/bower_components/moment/moment.js"></script>	
	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.6.4/angular.min.js"></script>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script src="resources/js/sipCommonUtil.js?v4.5"></script>
</head>