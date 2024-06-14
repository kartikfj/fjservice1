<%-- 
    Document   : SALES DASHBAORD PORTAL , WEEKLY REPORT 
--%>
<%@include file="/service/header.jsp" %>
<%@page import="com.google.gson.Gson"%>
<style>
@media only screen and (max-width: 375px) {
	 
} 
}
.txt-trim + [title]  {border: 5px solid blue;}table.dataTable td { width:max-content !important;}
table.dataTable{border-collapse: collapse !important;}
.table>tbody>tr>td{line-height: 1.1 !important;vertical-align: middle !important;font-weight: 600; text-align: right;}
table.dataTable thead th{    padding: 3px 8px !important;}
.filetrs-r{ display: inline !important;  margin-bottom: 5px !important;}
.small-box>.inner{    color: #e9cf08 !important;
    text-align: center; }
    .small-box{border-radius: 7px;}
.sb{   background: linear-gradient(22deg, #2b4075,#619a94);
    -webkit-box-shadow: 0px 0px 15px #9ba8b1;
    -moz-box-shadow: 0px 0px 15px #9ba8b1;
    box-shadow: 0px 0px 15px #9ba8b1;
    border: 1px solid #378dbc;
    height: 140px !important; }
    .sb h3{    font-size: 25px;} 
.small-box>.inner>p{	font-family: proxima_nova_rgregular, Arial, sans-serif;
    font-size: 11.28px; 
    text-align: center;
    color: #ffffff;
    font-weight: bold;
    font-style: normal;
    text-decoration: none;
    margin-top: -10px;
    border: 1px solid #ecf0f5;
    padding: 3px;    text-transform: uppercase;}
.box {  border-top: 3px solid #2a5779 !important;  }  .box-header{background:#2a5779 !important;color:#fff !important;} 
.dt-buttons{display:none;}
 .stageDetails{color:gray;}
.txt-left{text-align:left !important;}
.txt-right{text-align:right !important;}
.table-scroll {position:relative;max-width:100%;margin:auto;overflow:hidden;border:1px solid #c1c1c1;background: #ecf0f5;}
.table-wrap {width:100%;overflow:auto;	height:60%;}
.table-scroll table {width:100%;margin:auto;border-collapse:separate;border-spacing:0;}.table-scroll th, .table-scroll td {	padding:3px 8px;border:1px solid #2a5779;background:#fff;	white-space:nowrapvertical-align:middle;}.table-scroll thead, .table-scroll tfoot {background:#f9f9f9;}
.clone {position:absolute;top:0;left:0;pointer-events:none;}.clone th, .clone td {visibility:hidden}.clone td, .clone th {border-color:transparent}.clone tbody th {visibility:visible;color:red;}.clone .fixed-side {border:1px solid #e9cf08;background:#2a5779;visibility:visible;color:#fff !important;}.clone thead, .clone tfoot{background:transparent;}
.spclHeader{	border:1px solid #e9cf08 !important;background:#2a5779 !important;  color:#fff !important;}.countRw{background:#fff !important;     color: #080808 !important;}.valueRw{background:#e0f2f1 !important; }		
.dtlsHeader{  position:relative;cursor:pointer;}
.dtlsContent{  display:none; position:absolute; z-index:100;border:1px solid #0a0a0a; color:#fff; border-radius:5px;  background-color:#0a0a0a;  padding:7px;  top:20px; left:20px;}
.dtlsHeader:hover span.dtlsContent{ display:block;}

#radioBtn .notActive{
    color: #3276b1;
    background-color: #fff;
}
.Category{background: linear-gradient( 22deg, #fffefa,#ecf0f5);
    -webkit-box-shadow: 0px 0px 15px #9ba8b1;
    -moz-box-shadow: 0px 0px 15px #9ba8b1;
    box-shadow: 0px 0px 15px #9ba8b1;
    border: 1px solid #378dbc;
    height: 85px !important;}
     .select2-selection {display: block; max-height: 85px !important;overflow-y: scroll;}
</style>
<body class="hold-transition skin-blue sidebar-mini sidebar-collapse sidebar-mini">
 <c:if test="${empty fjtuser.emp_code}"> <jsp:forward page="index.jsp"/> </c:if>
 <c:choose>
 <c:when test="${!empty fjtuser.emp_code and fjtuser.checkValidSession eq 1}">
 
<div class="wrapper">

  <header class="main-header">
    <!-- Logo -->
    <a href="#" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>FJ</b>D</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg">
         <i class="fa fa-edit"></i> <b>FJ-Dashboard</b>
      </span>
    </a>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>

      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
 
          <!-- User Account: style can be found in dropdown.less -->
          <li class="dropdown user user-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-user-circle"></i>
              <span class="hidden-xs">${fjtuser.uname}</span>
            </a>
          
          </li>
           <%--Settings--%>
          <li class="dropdown notifications-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <i class="fa fa-gears"></i>
            </a>
            <ul class="dropdown-menu">
              <li class="header"><a  href="logout.jsp"> <i class="fa fa-power-off"></i> Log-Out</a></li>      
            </ul>
          </li>
          
        </ul>
      </div>
    </nav>
  </header>
  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <!-- Sidebar user panel -->
      <!-- sidebar menu -->
      <ul class="sidebar-menu" data-widget="tree">
      	<c:choose>
             <c:when test="${fjtuser.role eq 'mg' and fjtuser.sales_code ne null}"> 
      		     <li><a href="SipBranchPerformance"><i class="fa fa-building-o"></i><span>Branch Performance</span></a></li> 
                 <li><a href="DmInfo.jsp"><i class="fa fa-dashboard"></i><span>SE Perf.</span></a></li>
				 <li><a href="DisionInfo.jsp"><i class="fa fa-line-chart"></i><span>Sub Division Perf.</span></a></li>
				 <li><a href="CompanyInfo.jsp?empcode=${DFLTDMCODE}"><i class="fa fa-pie-chart"></i><span>Division 	Perf.</span></a></li>
				 <li><a href="SipUserActivity"><i class="fa fa-user"></i><span>SE Activity History</span></a></li>
<!-- 				 <li><a href="SipJihDues"><i class="fa fa-table"></i><span>JIH Dues</span></a></li>    -->
				 <li class="active"><a href="sipWeeklyReport"><i class="fa fa-bar-chart"></i><span>Weekly-Sales Report</span></a></li>
				 <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>Home</span></a></li>   
               </c:when>
               <c:when test="${fjtuser.salesDMYn eq 1  and fjtuser.sales_code ne null}">
                 <c:if test="${fjtuser.role eq 'gm'}">
      		     <li><a href="SipBranchPerformance"><i class="fa fa-building-o"></i><span>Branch Performance</span></a></li>
      		     </c:if>
                 <li><a href="DmInfo.jsp"><i class="fa fa-dashboard"></i><span>SE Perf.</span></a></li>
				 <li><a href="DisionInfo.jsp"><i class="fa fa-line-chart"></i><span>Sub Division Perf.</span></a></li>
				 <li><a href="CompanyInfo.jsp?empcode=${DFLTDMCODE}"><i class="fa fa-pie-chart"></i><span>Division Perf.</span></a></li>
				 <li><a href="SipUserActivity"><i class="fa fa-user"></i><span>SE Activity History</span></a></li>
<!-- 				 <li><a href="SipJihDues"><i class="fa fa-table"></i><span>JIH Dues</span></a></li>    -->
				 <li class="active"><a href="sipWeeklyReport"><i class="fa fa-bar-chart"></i><span>Weekly-Sales Report</span></a></li>
				  <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>Home</span></a></li>
               </c:when>
               <c:otherwise> 
                   <li><a href="DmInfo.jsp"><i class="fa fa-dashboard"></i><span>SE Perf.</span></a></li>
<!--                    <li><a href="SipJihDues"><i class="fa fa-table"></i><span>JIH Dues</span></a></li>  -->
				    <li><a href="ProjectStatus"><i class="fa fa fa-bars"></i><span>Project Status</span></a></li> 
                   <li class="active"><a href="sipWeeklyReport"><i class="fa fa-bar-chart"></i><span>Weekly-Sales Report</span></a></li>
                   <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>Home</span></a></li>
               </c:otherwise>               
              </c:choose>
							
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1> Sales Weekly Reports <small>Sales Dashboard</small></h1>
      <ol class="breadcrumb">
        <li><a href="homepage.jsp"><i class="fa fa-calendar"></i> Home</a></li>
        <li class="active">Service Portal</li>
      </ol>     
    </section>   
    <!-- Main content -->	    
	    <%--Office Staff Entry Section Start--%>
	    <section class="content">         
	    <%-- BOX DETAILS START --%>	
	    <div class='box'></div> 
	    
	   
	    <div class="row"> 
        <!-- ./col -->
        <div class="col-lg-2 col-md-2  col-sm-6 col-xs-12">
         <!-- small box -->
           <div class="small-box  sb col-xs-10">      
             <div class="inner col-xs-12">
              <h3>STAGE - 2</h3>             
              <p>Count: <span id="s2CntDiv"></span> <br/> Value: <span id="s2ValDiv"></span> <br/>Weekly Avg Count: <span id="s2AvgCntDiv"></span><br/>Weekly Avg Value: <span id="s2AvgValDiv"></span></p>
            </div>
          </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-2 col-md-2  col-sm-6 col-xs-12">
          <!-- small box -->
        <div class="small-box  sb col-xs-10">      
             <div class="inner col-xs-12">
              <h3>STAGE - 3</h3>
              <p>Count: <span id="s3CntDiv"></span> <br/> Value: <span id="s3ValDiv"></span><br/>Weekly Avg Count: <span id="s3AvgCntDiv"></span><br/>Weekly Avg Value: <span id="s3AvgValDiv"></span></p>  
            </div>
          </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-2 col-md-2  col-sm-6 col-xs-12">
         <div class="small-box  sb col-xs-10">      
             <div class="inner col-xs-12">
              <h3>STAGE - 4</h3>
              <p>Count: <span id="s4CntDiv"></span>  <br/> Value: <span id="s4ValDiv"></span><br/>Weekly Avg Count: <span id="s4AvgCntDiv"></span><br/>Weekly Avg Value: <span id="s4AvgValDiv"></span></p>  
            </div>
          </div>
        </div> 
        <div class="col-lg-2 col-md-2  col-sm-6 col-xs-12">
         <div class="small-box  sb col-xs-10">      
             <div class="inner col-xs-12">
              <h3>STAGE - 5</h3>
              <p>Count: <span id="s5CntDiv"></span>  <br/> Value: <span id="s5ValDiv"></span><br/>Weekly Avg Count: <span id="s5AvgCntDiv"></span><br/>Weekly Avg Value: <span id="s5AvgValDiv"></span></p>  
            </div>
          </div>
        </div> 
        <!-- ./col --> 		
        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
        	
        	 <div class="form-group form-inline"> 
                <select class="form-control select2" id="slctDvsns" multiple="multiple" data-placeholder="Select Sales Engineer" style="width:70%;"> </select>
                <input type="checkbox" id="checkbox" >Select All
                <button class="btn btn-primary" onClick="customeReportView();">Filter</button>
              </div>
        </div>		
		<div class="col-lg-4">
        	<h4><a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a></h4>       
        </div>				
      </div>
	    <%-- BOX DETAILS END --%>    
	    <%-- TABLUAR DETAILS START --%>
	   <div class="row">
        <div class="col-lg-12 col-md-12 col-xs-12">
          <div class="box box-default">
            <div class="box-header">
              <h3 class="box-title pull-left"><b>WEEK WISE SALES REPORT ANALYSYS </b></h3>
              <button class="btn btn-sm btn-danger pull-right" id="ExportReporttoExcel"><i class="fa fa-file-excel-o"></i> Download</button>
               <span class="small pull-left" style="font-weight:bold;color:red;font-size:16px;"> ( <span id="weekCntId" style="font-weight:bold;color:red;font-size:16px;"></span>TH WEEK/ 52 )</span>
              
              </div> 
            <!-- /.box-header --> 
            <div class="table-scroll"  id="table-scroll"  >
             <div class="table-wrap">
              <table class="main-table small" id="report-table">
                <thead>
                  <tr>
                  <th rowspan="3" width="65"   class="spclHeader" scope="col">Sales Engineer</th> 
                  <th rowspan="3"  width="90"   class="spclHeader" scope="col">Division</th> 
                  <th rowspan="3"   class="spclHeader" scope="col">STAGES</th>
                   <th colspan="4"  class="spclHeader" scope="col">Weekly Avg</th>       
                     <c:forEach var="i" begin="1" end="${currWeek}" >
					    <c:set var="reverseIndex" value="${currWeek - i + 1}" />
					    <th colspan="4"  class="spclHeader" scope="col">Week-<c:out value="${reverseIndex}"/></th>
					 </c:forEach>
                  </tr>   
                   <tr>
                    <th class="spclHeader"  scope="col">S2</th><th class="spclHeader"  scope="col">S3</th><th class="spclHeader"  scope="col">S4</th><th class="spclHeader"  scope="col">S5</th>
                     <c:forEach var="i" begin="1" end="${currWeek}" step="1" >  
					        <th class="spclHeader"  scope="col">S2</th><th class="spclHeader"  scope="col">S3</th><th class="spclHeader"  scope="col">S4</th><th class="spclHeader"  scope="col">S5</th>
					</c:forEach> 
                  </tr>             
                </thead>
                <tbody id="wrTBody">     
              </tbody>
              
                 <tfoot>                    
                   <tr>
                   <th rowspan="3" width="65" class="spclHeader" scope="col">Sales Engineer</th> 
                  <th rowspan="3"  width="90"  class="spclHeader" scope="col">Division</th> 
                  <th rowspan="3"  class="spclHeader" scope="col">STAGES</th>
                  <th class="spclHeader" scope="col">S2</th><th class="spclHeader" scope="col">S3</th><th class="spclHeader" scope="col">S4</th><th class="spclHeader"  scope="col">S5</th>
                    <c:forEach var="i" begin="1" end="${currWeek}" step="1" >
					        <th class="spclHeader" scope="col">S2</th><th class="spclHeader" scope="col">S3</th><th class="spclHeader" scope="col">S4</th><th class="spclHeader"  scope="col">S5</th>
					</c:forEach> 
                  </tr>  
                   <tr>   
                    <th colspan="4"  class="spclHeader" scope="col">Weekly Avg</th>                    
                    <c:forEach var="i" begin="1" end="${currWeek}" step="1" >
                    	<c:set var="reverseIndex" value="${currWeek - i + 1}" />
					        <th colspan="4"  class="spclHeader"  scope="col">Week-<c:out value="${reverseIndex}"/></th>
					</c:forEach> 
                  </tr>           
                </tfoot>
              </table>
              </div>
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div> 
         <div id="exclData" style="display:none;"></div>
        <div class="col-xs-12">${MSG}</div>
      </div>
	  <%-- TABULAR DETAILS END --%>
	  	  
	  	     
	    </section>
	     <div class="row">
	     <div class="col-md-12 col-sm-12">
	      <div id="laoding" class="loader" ><img src="././resources/images/wait.gif"></div>
	     </div> 
	     </div>
    	<%--Field Staff Entry Section End--%>   
    <!-- /.content -->
   </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <div class="pull-right hidden-xs">
      <b>Version</b> 2.0.0
    </div>
    <strong>Copyright &copy; 1988-${CURR_YR} <a href="http://www.faisaljassim.ae">FJ-Group</a>.</strong> All rights reserved.
  </footer>

  
</div>
<script src="././resources/bower_components/select2/dist/js/select2.full.min.js"></script>
<script src="././resources/bower_components/fastclick/lib/fastclick.js"></script>
<script src="././resources/dist/js/adminlte.min.js"></script>
<script src="././resources/bower_components/jquery-knob/js/jquery.knob.js"></script>
<!-- page script start -->
<script>  
var weeknumber = parseInt(moment(new Date(), "MM-DD-YYYY").week()); 
var reportsList = <%=new Gson().toJson(request.getAttribute("YTDSWR"))%>;  
var totS2Count = 0, totS2Val = 0, totS3Count = 0, totS3Val = 0, totS4Count = 0, totS4Val = 0, totS5Count = 0, totS5Val = 0;
var totS2AvgCount = 0, totS2AvgVal = 0, totS3AvgCount = 0, totS3AvgVal = 0, totS4AvgCount = 0, totS4AvgVal = 0, totS5AvgCount = 0, totS5AvgVal = 0;
var extractedReport = [], table;
var exportTable = "<table class='table' id='exclexprtTble'><thead>";
var filterOptions = [...new Set(reportsList.map(item => { return {'name' : item.smName +"- ("+ item.smCode+")" ,'value' : item.smCode }  } )  )];  
var uniqueDivisions = [...new Set(reportsList.map(item => item.smCode))];   

getDivisionsOption(uniqueDivisions);
createCustomeReportObj(uniqueDivisions);
 
function getDivisionsOption(uniqueDivisions){
	 daySelect = document.getElementById('slctDvsns'); 
	 var list = [];
	 filterOptions.map( item => {
		 if(!list.includes(item.value)) {
			 daySelect.options.add( new Option(item.name, item.value));
			 list.push(item.value);
		 }
		
	 });
	 
}
function createCustomeReportObj(uniqueDivisions){
	uniqueDivisions.filter( item =>{		
		 var weekTmp = '';
			 var company = '';
			 var division = '';
			 var smName = '';
			 console.log("divitem : "+item);
			 
			 var divisions = [];
				divisions =  [...new Set(reportsList.map(items => {
					if(items.division && items.smCode == item ) {
						return items.division;
					}
				}  ))];
			 
			 divisions.filter( divisionItem => {
				 if(!divisionItem) {
					 return;
				 }
				 var obj={'smCode':item}; 
				 for(var i=${currWeek},s2CntSum=0,s3CntSum=0,s4CntSum=0,s5CntSum=0,s2ValSum=0,s3ValSum=0,s4ValSum=0,s5ValSum=0; i>= 1 ; i --){
						
						if(parseInt(i)<=9){
							weekTmp = '0'+i;
						}else{ weekTmp = i;}
						
						var filteredValues = reportsList.find( singleRw =>  singleRw.smCode == item &&  singleRw.division == divisionItem  && singleRw.week == weekTmp  );
						console.log(filteredValues);
						 if(typeof filteredValues === 'undefined'){
								 obj[i] = {
										"s2Count":0,
										"s2Value":0,
										"s3Count":0,
										"s3Value":0,
										"s4Count":0,
										"s4Value":0,
										"s5Count":0,
										"s5Value":0
								};
				    	 }else{
				    		 company = filteredValues.smCode;
				    		 smName = filteredValues.smName;
				    		 division = filteredValues.division;
				    		 totS2Count += parseInt((filteredValues.s2Count)? filteredValues.s2Count : 0); totS2Val += Math.round((filteredValues.s2Value)? filteredValues.s2Value : 0); 
				    		 totS3Count += parseInt((filteredValues.s3Count)? filteredValues.s3Count : 0); totS3Val += Math.round((filteredValues.s3Value)? filteredValues.s3Value : 0); 
				    		 totS4Count += parseInt((filteredValues.s4Count)? filteredValues.s4Count : 0); totS4Val += Math.round((filteredValues.s4Value)? filteredValues.s4Value : 0); 
				    		 totS5Count += parseInt((filteredValues.s5Count)? filteredValues.s5Count : 0); totS5Val += Math.round((filteredValues.s5Value)? filteredValues.s5Value : 0); 
				    		console.log("filteredValues== "+filteredValues.division+""+filteredValues.smCode+""+divisionItem);
				    		 if(divisionItem == filteredValues.division){			    			
				    			 s2CntSum += parseInt((filteredValues.s2Count)? filteredValues.s2Count : 0);
				    			 s3CntSum += parseInt((filteredValues.s3Count)? filteredValues.s3Count : 0);
				    			 s4CntSum += parseInt((filteredValues.s4Count)? filteredValues.s4Count : 0);
				    			 s5CntSum += parseInt((filteredValues.s5Count)? filteredValues.s5Count : 0);
				    			 s2ValSum += parseInt((filteredValues.s2Value)? filteredValues.s2Value : 0);
				    			 s3ValSum += parseInt((filteredValues.s3Value)? filteredValues.s3Value : 0);
				    			 s4ValSum += parseInt((filteredValues.s4Value)? filteredValues.s4Value : 0);
				    			 s5ValSum += parseInt((filteredValues.s5Value)? filteredValues.s5Value : 0);
				    			 obj["s2CntSum"] = s2CntSum;
				    			 obj["s3CntSum"] = s3CntSum;
				    			 obj["s4CntSum"] = s4CntSum;
				    			 obj["s5CntSum"] = s5CntSum;
				    			 obj["s2ValSum"] = s2ValSum;
				    			 obj["s3ValSum"] = s3ValSum;
				    			 obj["s4ValSum"] = s4ValSum;
				    			 obj["s5ValSum"] = s5ValSum;
				    		 }
				    		 obj[i] = {
										"s2Count":(filteredValues.s2Count)? filteredValues.s2Count : 0,
										"s2Value":(filteredValues.s2Value)? filteredValues.s2Value : 0 ,
										"s3Count":(filteredValues.s3Count)? filteredValues.s3Count : 0,
										"s3Value":(filteredValues.s3Value)? filteredValues.s3Value : 0,
										"s4Count":(filteredValues.s4Count)? filteredValues.s4Count : 0,
										"s4Value":(filteredValues.s4Value)? filteredValues.s4Value : 0,
										"s5Count":(filteredValues.s5Count)? filteredValues.s5Count : 0,
										"s5Value":(filteredValues.s5Value)? filteredValues.s5Value : 0,								
								};
				    		 
				    	 } 
						}
				 
				    obj["smCode"] = smName +"-" + "( "+company +")";
					obj["division"] = divisionItem;
					extractedReport.push(obj);
				 
				 
			 })
			 
		
			 weekTmp = '';
			
		
		console.dir(extractedReport);
	
	});
}
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

	    : Math.round(Number(value));
	    
	}
$(function(){  
	 $('.loader').hide(); 
	 $('.select2').select2();
	 $('#radioBtn a').on('click', function(){
		    var sel = $(this).data('title');
		    var tog = $(this).data('toggle');
		    $('#'+tog).prop('value', sel);
		    
		    $('a[data-toggle="'+tog+'"]').not('[data-title="'+sel+'"]').removeClass('active').addClass('notActive');
		    $('a[data-toggle="'+tog+'"][data-title="'+sel+'"]').removeClass('notActive').addClass('active');
		})
	 $("#weekCntId").html(weeknumber); 
	 createReport();
	 $("#ExportReporttoExcel").on("click", function() { 
		    table.button( '.dt-button' ).trigger();
		});

	 $(".main-table").clone(true).appendTo('#table-scroll').addClass('clone'); 
	 
	 $("#checkbox").click(function(){
		    if($("#checkbox").is(':checked') ){
		        $("#slctDvsns > option").prop("selected","selected");
		        $("#slctDvsns").trigger("change");
		    }else{
		    	console.log("hi ns");
		    	$("#slctDvsns").find('option').prop("selected",false);
		        $("#slctDvsns").trigger('change');
		     }
		});
});
function createReport(){
	 var output, countRws,valueRws; 
	 console.log("createReport calling...")
	 extractedReport.map(item => { 
	 output += "<tr><td rowspan='2' class='txt-left spclHeader' scope='col'>"+item.smCode+"</td><td rowspan='2' class='txt-left spclHeader' scope='col'>"+item.division+"</td><td class='txt-left spclHeader' scope='col'>Count</td> ";
	 output += "<td class='txt-right spclHeader' scope='col' >"+Math.round(item.s2CntSum/weeknumber)+"</td>";
	 output += "<td class='txt-right spclHeader' scope='col' >"+Math.round(item.s3CntSum/weeknumber)+"</td>";
	 output += "<td class='txt-right spclHeader' scope='col' >"+Math.round(item.s4CntSum/weeknumber)+"</td>";
	 output += "<td class='txt-right spclHeader' scope='col' >"+Math.round(item.s5CntSum/weeknumber)+"</td>";	
	  for(var i=${currWeek};i>=1;i--){ 
		     countRws += "<td class='countRw txt-right dtlsHeader' scope='col' >"+item[""+i+""].s2Count+"<span class='dtlsContent'>Division: "+item.division+"<br/> Week: "+i+"<br/> S2 Count: "+item[""+i+""].s2Count+"</span></td>"+
		     			 "<td class='countRw txt-right dtlsHeader' scope='col' >"+item[""+i+""].s3Count+"<span class='dtlsContent'>Division: "+item.division+"<br/> Week: "+i+"<br/> S3 Count: "+item[""+i+""].s3Count+"</span></td>"+
		     			 "<td class='countRw txt-right dtlsHeader' scope='col' >"+item[""+i+""].s4Count+"<span class='dtlsContent'>Division: "+item.division+"<br/> Week: "+i+"<br/> S4 Count: "+item[""+i+""].s4Count+"</span></td>"+
		     			 "<td class='countRw txt-right dtlsHeader' scope='col' >"+item[""+i+""].s5Count+"<span class='dtlsContent'>Division: "+item.division+"<br/> Week: "+i+"<br/> S5 Count: "+item[""+i+""].s5Count+"</span></td>"; 
			 valueRws += "<td class='valueRw txt-right dtlsHeader' scope='col' >"+extractValue(item[""+i+""].s2Value)+"<span class='dtlsContent'>Division: "+item.division+"<br/> Week: "+i+"<br/> S2 Value: "+formatNumber(item[""+i+""].s2Value)+"</span></td>"+
			 			 "<td class='valueRw txt-right dtlsHeader' scope='col' >"+extractValue(item[""+i+""].s3Value)+"<span class='dtlsContent'>Division: "+item.division+"<br/> Week: "+i+"<br/> S3 Value: "+formatNumber(item[""+i+""].s3Value)+"</span></td>"+
			 			 "<td class='valueRw txt-right dtlsHeader' scope='col' >"+extractValue(item[""+i+""].s4Value)+"<span class='dtlsContent'>Division: "+item.division+"<br/> Week: "+i+"<br/> S4 Value: "+formatNumber(item[""+i+""].s4Value)+"</span></td>"+
			 			 "<td class='valueRw txt-right dtlsHeader' scope='col' >"+extractValue(item[""+i+""].s5Value)+"<span class='dtlsContent'>Division: "+item.division+"<br/> Week: "+i+"<br/> S5 Value: "+formatNumber(item[""+i+""].s5Value)+"</span></td>";  
			
		 }
	  output += countRws; 
	  output += "</tr><tr><td class='txt-left spclHeader'  scope='col spclHeader'>Value</td>";
	  output += "<td class='txt-right spclHeader' scope='col' >"+Math.round(item.s2ValSum/weeknumber)+"</td>";
	  output += "<td class='txt-right spclHeader' scope='col' >"+Math.round(item.s3ValSum/weeknumber)+"</td>";
	  output += "<td class='txt-right spclHeader' scope='col' >"+Math.round(item.s4ValSum/weeknumber)+"</td>";
	  output += "<td class='txt-right spclHeader' scope='col' >"+Math.round(item.s5ValSum/weeknumber)+"</td>";
	  output += valueRws; 
	  output += "</tr>";
	  countRws = '';
	  valueRws = '';
	 });
	
	 $("#wrTBody").html(output);  
	 $("#s2CntDiv").html(totS2Count);  $("#s2ValDiv").html(extractValue(totS2Val));  
	 $("#s2AvgCntDiv").html(Math.round(totS2Count/weeknumber));  $("#s2AvgValDiv").html(extractValue(totS2Val/weeknumber));
	 $("#s3CntDiv").html(totS3Count);  $("#s3ValDiv").html(extractValue(totS3Val)); 
	 $("#s3AvgCntDiv").html(Math.round(totS3Count/weeknumber));  $("#s3AvgValDiv").html(extractValue(totS3Val/weeknumber));
	 $("#s4CntDiv").html(totS4Count);  $("#s4ValDiv").html(extractValue(totS4Val));
	 $("#s4AvgCntDiv").html(Math.round(totS4Count/weeknumber));  $("#s4AvgValDiv").html(extractValue(totS4Val/weeknumber)); 
	 $("#s5CntDiv").html(totS5Count);  $("#s5ValDiv").html(extractValue(totS5Val));
	 $("#s5AvgCntDiv").html(Math.round(totS5Count/weeknumber));  $("#s5AvgValDiv").html(extractValue(totS5Val/weeknumber)); 
	 downloadReports(weeknumber, extractedReport);
	
}
function downloadReports(weeknumber, extractedReport){ 
	var  exclCountRws, exclValueRws;
	exportTable +="<tr><th>Sales Engineer</th><th>Division</th><th></th><th>Weekly Avg/S2</th><th>Weekly Avg/S3</th><th>Weekly Avg/S4</th><th>Weekly Avg/S5</th>";
 
	 for(var i=${currWeek};i>=1;i--){
		 exportTable += "<th>W"+i+"/S2</th><th>W"+i+"/S3</th><th>W"+i+"/S4</th><th>W"+i+"/S5</th>";
	 }
	 exportTable +="</tr></thead><tbody>"
	 extractedReport.map(item => { 
		 exportTable += "<tr><td>"+item.smCode+"</td><td>"+item.division+"</td><td>Count</td><td>"+Math.round(item.s2CntSum/weeknumber)+"</td><td>"+Math.round(item.s3CntSum/weeknumber)+"</td><td>"+Math.round(item.s4CntSum/weeknumber)+"</td><td>"+Math.round(item.s5CntSum/weeknumber)+"</td>";		
		  for(var i=${currWeek};i>=1;i--){ 
			  exclCountRws += "<td>"+item[""+i+""].s2Count+"</td><td>"+item[""+i+""].s3Count+"</td><td>"+item[""+i+""].s4Count+"</td><td>"+item[""+i+""].s5Count+"</td>";
			     			 
			  exclValueRws += "<td>"+formatNumber(item[""+i+""].s2Value)+"</td><td>"+formatNumber(item[""+i+""].s3Value)+"</td><td>"+formatNumber(item[""+i+""].s4Value)+"</td><td>"+formatNumber(item[""+i+""].s5Value)+"</td>";
				
			 }
		  exportTable += exclCountRws;
		  exportTable += "</tr><tr><td>"+item.smCode+"</td><td>"+item.division+"</td><td>Value</td><td>"+Math.round(item.s2ValSum/weeknumber)+"</td><td>"+Math.round(item.s3ValSum/weeknumber)+"</td><td>"+Math.round(item.s4ValSum/weeknumber)+"</td><td>"+Math.round(item.s5ValSum/weeknumber)+"</td> ";
		  exportTable += exclValueRws;  
		  exportTable += "</tr>";
		  exclCountRws = '';
		  exclValueRws = '';
	 });  
	 exportTable += "</tbody></table>";	 
		$("#exclData").html(exportTable); 
	  table = $('#exclexprtTble').DataTable({   dom: 'Bfrtip', "paging":   false,  
		   "ordering": false, "info":false, "searching": false,   
	   buttons: [{ extend: 'excelHtml5', text:      '<i class="fa fa-file-excel-o" style="color: #fff; font-size: 1.5em;">Download</i>', filename: 'WEEK WISE SALES REPORT - ${currCal}',
	   title: 'WEEK WISE SALES REPORT - ${currCal}', messageTop: 'The information in this file is copyright to FJ-Group.'}]
	 } ); 
}
function formatNumber(num) {return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");}
function customeReportView(){
	var uniqueDivisions  = $("#slctDvsns").val();
	//console.log(uniqueDivisions);
	if(uniqueDivisions === null || typeof uniqueDivisions === 'undefined' || uniqueDivisions === '' || uniqueDivisions.length == 0){
		 $("#slctDvsns").focus();
		 alert("Please select atleast one division");
	}else{
		 totS2Count = 0, totS2Val = 0, totS3Count = 0, totS3Val = 0, totS4Count = 0, totS4Val = 0, totS5Count = 0, totS5Val = 0,extractedReport = [];
		 exportTable = "<table class='table' id='exclexprtTble'><thead>";
	     $("#exclData").html(""); 
		 $("#wrTBody").html("<tr><td>Loading......</td></tr>"); 
		
		 createCustomeReportObj(uniqueDivisions);
		 createReport();
	}
	
	
}
</script>
<!-- page Script  end -->

</c:when>
<c:otherwise>

        <body onload="window.top.location.href='logout.jsp'">
   
            
        </body>
  
</c:otherwise>
</c:choose>
</html>