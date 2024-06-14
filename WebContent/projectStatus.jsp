<%-- 
    Document   : HR Evaluation Performance , Reports 
--%>
<%@include file="/hr/header.jsp" %>
<style>
.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {  padding: 3px 5px !important;}.scoreValue{text-align:right;}.reportDtls{text-align:center !important;}
 #fullReport-Box{ height: 842px;  width: 595px;  /* to centre page on screen*/   margin-left: auto;  margin-right: auto;background: #ecf0f5; display:none;}
        .user-content{font-size:73%;}
        .moreItemBox{background: #ecf0f5;}
  .moreItem{    display: block; color: #ffffff; font-style: italic;   padding: 5px;  background: #607d8b;  border-bottom: 1px solid white;width: 100%;text-align: left;} 
   .moreIcon, th.moreIcon>input, .genderColumn, th.genderColumn>input{max-width:60px !important; width:60px !important; }   
  .compnyColumn, th.compnyColumn>input,  .codeColumn, th.codeColumn>input, .statusColumn,  th.statusColumn>input, .tenureColumn, th.tenureColumn>input{max-width:75px !important; width:75px !important;} 
   .stageColumn, th.stageColumn>input{max-width:20px !important; width:35px !important;} 
   .dateColumn,  th.dateColumn>input  {max-width:30px !important; width:60px !important; }  
   .ageColumn,  th.ageColumn>input{max-width:45px !important; width:45px !important; }    
    .divdeptColumn,  th.divdeptColumn>input, .staffColumn,  th.staffColumn>input  {max-width:80px !important; width:80px !important; }  
    .amountColumn, th.amountColumn>input{max-width:90px !important; width:90px !important;text-align:"right" } 
    .nationalityColumn, th.nationalityColumn>input, .locationColumn, th.locationColumn>input{max-width:110px !important; width:110px !important; } 
     .gradeColumn, th.gradeColumn>input{max-width:45px !important; width:45px !important; } 
    .responsiveDtls{ top: 0; bottom: 0; left: 0; right: 0; overflow: auto;} 
    .mobileNoColumn, th.mobileNoColumn>input{max-width:100px !important; width:100px !important;text-align:"right" } 
    .idColumn, th.idColumn>input{max-width:120px !important; width:120px !important;text-align:"right" }
</style>
<body class="hold-transition skin-blue sidebar-mini sidebar-collapse sidebar-mini"  style="height: auto !important; min-height: 100% !important;">
 <c:if test="${empty fjtuser.emp_code}"> <jsp:forward page="index.jsp"/> </c:if>
 <c:choose>
  <c:when test="${((!empty fjtuser.emp_code and !empty fjtuser.sales_code  and fjtuser.checkValidSession eq 1 ) ||  (!empty fjtuser.emp_code and fjtuser.role eq 'mkt'))}"> 
<div class="wrapper">
  <header class="main-header">
    <!-- Logo -->
    <a href="#" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>FJ</b>P</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg">
         <i class="fa fa-edit"></i> <b>FJ-Portal</b>
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
              <li class="header"><a  href="logout.jsp"  style="color: #fffbfb !important;"> <i class="fa fa-power-off"></i> Log-Out</a></li>      
            </ul>
          </li>         
        </ul>
      </div>
    </nav>
  </header>
  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">
    <!-- sidebar  -->
    <section class="sidebar">
      <!-- Sidebar user panel --> 
      <!-- sidebar menu:  -->
      <ul class="sidebar-menu" data-widget="tree">
      	  <c:if test="${fjtuser.role eq 'mkt'}">
	       		<li> <a href="ProjectLeads" ><i class="fa fa-address-card"></i><span>Marketing</span></a></li>
	      </c:if>
	       <c:choose>
          	<c:when test="${fjtuser.salesDMYn eq 1 or fjtuser.role eq 'mg'}">          		 
          		<li><a href="DisionInfo.jsp"><i class="fa fa-address-card"></i><span>Sales Dashboard</span></a></li>          		
          	</c:when>
          	<c:when test="${fjtuser.sales_code ne null and fjtuser.salesDMYn ne 1}"> 
          		<li><a href="sip.jsp"><i class="fa fa-address-card"></i><span>Sales Dashboard</span></a></li>    
          	</c:when>
          	<c:otherwise></c:otherwise>
          </c:choose> 
                            
         <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>      
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper"  style="height: auto !important; min-height: 100% !important;">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>Project Status</h1>
      <ol class="breadcrumb">
        <li><a href="homepage.jsp"><i class="fa fa-calendar"></i> Home</a></li>
        <li class="active">Project Status</li>
      </ol>
    </section>   
    <!-- Main content -->	    
	  
	    <section class="content">  
	  		   
	  		  <%-- Notification start --%>
	  		  <div class="row">
	  		  	<div id="notification"><div id="notification_icon"><i class="fa fa-lg fa-bell" aria-hidden="true"></i></div><div id="notification_desc"></div></div>
	  		  </div>
	  		  <%-- Notification end --%>
	  		  <%-- Complete details start --%>	  		
	  		   <div class="row">
	  		    <div class="col-md-12 col-xs-12"> 
	  		      <div class="panel-body responsiveDtls"> 
	  		      	  <table class="table table-bordered small bordered no-padding table-striped" id="emp-table">
		                <thead> 
		                  <tr>  
<!-- 		                   <th class="moreIcon"> </th> -->
		                   <th class="stageColumn btn-info">Stage</th> 		                
		                   <th class="divdeptColumn btn-info">Product<br/>Name</th>
		                   <th class="divdeptColumn btn-info">Quotation<br/> Details</th>
		                   <th class="codeColumn btn-info">Consultant</th>	
		                   <th class="divdeptColumn btn-info">Customer</th>		                  
		                   <th class="stageColumn btn-info">Cons<br/> Win %</th> 
		                   <th class="stageColumn btn-info">Cont<br/> Win %</th> 
		                   <th class="stageColumn btn-info">Tot<br/>Win %</th> 	
<%-- 		                   <c:if test="${fjtuser.role ne 'mkt'}"> --%>
<!-- 		                   		<th class="staffColumn btn-info">Amount</th> -->
<%-- 		                   </c:if> --%>
		                   <th class="stageColumn btn-info">Sm. Code</th>
		                   <th class="codeColumn btn-info">Sm. Name</th>	                   
		                   <th class="codeColumn btn-info">Project Name</th>
		                   <th class="stageColumn btn-info">Status</th>
		                   <th class="dateColumn btn-info">Txn Date</th>
		                   <th class="dateColumn btn-info">LOI Date</th>
		                   <th class="dateColumn btn-info">Exp. PO Date</th>
		                   <th class="dateColumn btn-info">Exp. Inv Date</th>	                   
		                </tr>              
		                </thead>
		                <tbody id="empDetails"> 
		                </tbody>		              
		              </table>
	  		      </div>
	  		     </div>
	  		    </div>
	
	  		
	</section>  
	<section class="modals">
		<div class="modal fade" id="modal_detail" role="dialog">
			<div class="modal-dialog" style="width: max-content; max-width:'80% !important'">
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
						   <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
					  </div>
				</div>
		</div>
	</div>
	</section>
	 <div id="laoding" class="loader" ><img src="resources/images/wait.gif"></div>		   
	</div>  	 
  <!-- /.content-wrapper -->

<%@include file="/hr/footer.jsp" %>
  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">    </aside>
  <!-- /.control-sidebar --> 
  <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->
<script src="././resources/bower_components/select2/dist/js/select2.full.min.js"></script>
<script src="././resources/bower_components/fastclick/lib/fastclick.js"></script>
<script src="././resources/dist/js/adminlte.min.js"></script>
<script src="././resources/bower_components/jquery-knob/js/jquery.knob.js"></script>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<!-- page script start -->
<script> 

var _url = '${dashboardController}';
var _method = "POST"; 
var empDetails = <%=new Gson().toJson(request.getAttribute("COMPLTEMPDTLS"))%>;
$(function(){ 	
	 $('.loader').hide(); 
	 dispalyEmpDetails();
}); 
function dispalyEmpDetails(){
	$('#laoding').show();
	if(empDetails.length > 0){
		var output = ""; 
		empDetails.map( item => { 
		  output += "<tr>"; 
		  //output += "<td class='moreIcon'> </td>";
		  output += "<td  class='scoreEmp stageColumn'>"+item.stage+"</td>";		 
		  output += "<td class='scoreEmp divdeptColumn'>"+item.txnName+"</td>";
		  output += "<td class='scoreEmp divdeptColumn'>"+item.txnCode+"-"+item.txnNo+"</td>";
		  output += "<td class='scoreEmp genderColumn'>"+(item.consultant ? item.consultant : '-') +"</td>";  
		  output += "<td class='scoreEmp divdeptColumn'>"+item.customer+"</td>";		 
// 		  <c:if test="${fjtuser.role ne 'mkt'}">
// 			  output += "<td class='scoreEmp statusColumn'>"+formatNumber(item.amount)+"</td>";
//     	  </c:if>
		  output += "<td class='scoreEmp stageColumn'>"+item.consultWin+"%</td>";
		  output += "<td class='scoreEmp stageColumn'>"+item.contractorWin+"%</td>";
		  output += "<td class='scoreEmp stageColumn'>"+item.totalWin+"%</td>";
		  output += "<td class='scoreEmp stageColumn'>"+item.smCode+"</td>";
		  output += "<td class='scoreEmp codeColumn'>"+item.smName+"</td>";		 
		  output += "<td class='scoreEmp'>"+item.projectName+"</td>";
		  output += "<td class='scoreEmp stageColumn'>"+item.status+"</td>";
		  output += "<td class='scoreEmp dateColumn'>"+validateDate(item.txnDate)+"</td>";
		  output += "<td class='scoreEmp dateColumn'>"+validateDate(item.loiDate)+"</td>";
		  output += "<td class='scoreEmp dateColumn'>"+validateDate(item.expPODate)+"</td>";
		  output += "<td class='scoreEmp dateColumn'>"+validateDate(item.expInvDate)+"</td>";
		  //output += "<td class='scoreEmp dateColumn'>"+validateDate(item.birth_dt)+"</td>";
		 // output += "<td class='scoreEmp ageColumn'>"+validateData(item.age)+"</td>";
		  
		  output += "</tr>";        
	});
		
	}else{output += "";}
	$("#empDetails").html(output); 
	  $('#emp-table thead tr')
      .clone(true)
      .addClass('filters')
      .appendTo('#emp-table thead');
       $('#emp-table').DataTable( { 
    	   responsive: true,
    	  orderCellsTop: true,
          fixedHeader: true,
    	 "autoWidth": false,
    	 dom: 'Bfrtip',  
    	 "pageLength": 25, 
    	 "dom": '<"top"iBf>rt<"bottom"lp><"clear">',
    	  "createdRow": function (row, data, dataIndex) {
	            // Loop through each column
	           //  var columnsToApplyLogic = [3, 4, 5];
	            for (var i = 0; i < 11; i++) {
	                var cell = $('td', row).eq(i);
	                var fullText = data[i];			               
	                var shortText = fullText != null ? fullText.substring(0, 20) : " ";

	                // Set short text for display
	                cell.text(shortText);

	                // Add a data attribute with full text for export
	                cell.attr('data-export', fullText);
	                
	             // Add mouseover event listener to show full text on hover
	               
	                cell.attr('title', fullText);
	            }
	        },
    	    buttons: [
    	        {
    	            extend: 'excelHtml5',
    	            text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 1.5em;"> Export</i>',
    	            filename: "Project Status Details",
    	            title: "Project Status Details",
    	            messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'	, 
    	            exportOptions: { columns: ':not(:first-child)', }
    	        }	            	      	            	       
    	    ],
    	    "columnDefs": [
                {
                    "targets": [   ],
                    "visible": false,
                    "searchable": true
                } 
            ],  
    	       initComplete: function () {
    	            var api = this.api();
    	 
    	            // For each column
    	            api
    	                .columns()
    	                .eq(0)
    	                .each(function (colIdx) {
    	                    // Set the header cell to contain the input element
    	                    var cell = $('.filters th').eq(
    	                        $(api.column(colIdx).header()).index()
    	                    );
    	                    var title = $(cell).text();
    	                    $(cell).html('<input type="text" style="color:Black" placeholder="' + title + '" />');
    	 
    	                    // On every keypress in this input
    	                    $(
    	                        'input',
    	                        $('.filters th').eq($(api.column(colIdx).header()).index())
    	                    )
    	                        .off('keyup change')
    	                        .on('keyup change', function (e) {
    	                            e.stopPropagation();
    	 
    	                            // Get the search value
    	                            $(this).attr('title', $(this).val());
    	                            var regexr = '({search})'; //$(this).parents('th').find('select').val();
    	 
    	                            var cursorPosition = this.selectionStart;
    	                            // Search the column for that value
    	                            api
    	                                .column(colIdx)
    	                                .search(
    	                                    this.value != ''
    	                                        ? regexr.replace('{search}', '(((' + this.value + ')))')
    	                                        : '',
    	                                    this.value != '',
    	                                    this.value == ''
    	                                )
    	                                .draw();
    	 
    	                            $(this)
    	                                .focus()[0]
    	                                .setSelectionRange(cursorPosition, cursorPosition);
    	                        });
    	                });
    	        },    
    	} );
       $('#laoding').hide();
}
function validateDate(date){
	if(date !== 'undefined' && date != null && typeof date !== 'undefined' && date !== ""){
		return  $.trim(date.substring(0, 10)).split("-").reverse().join("/");
	}else{
		return "-";
	}
}
function validateData(data){
	if(data !== 'undefined' && data != null && typeof data !== 'undefined' && data !== ""){
		return  $.trim(data);
	}else{
		return "-";
	}
}
function checkEmployeeStatus(status){
	if(status === 'ACTIVE'){
		return '<b class="text-success">'+status+'</b>';
	}else{
		return '<b class="text-danger">'+status+'</b>';
	}
}

function formatNumber(num) {return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");} 
 
 
function getEmpProfile(empCode, empName){ $('#laoding').show();
$("#modal_detail .modal-body").html("");
var ttl="<b>Employee Profile - "+empCode+", "+empName+"</b>"; 
var excelTtl="Employee Profile -"+empCode+", "+empName+"";
$("#modal_detail .modal-title").html(ttl);
var output="";
$.ajax({
	 type: _method,
	 url: _url, 
	 data: {action: "profile", hr0:empCode},
	 dataType: "json", 
	 success: function(data) { 
		 $('#laoding').hide();
		 
		 output += '<table id="excelTbl" class="table table-bordered  bordered no-padding table-striped">'+        		 
		 '<tbody>'+       		
		 '<tr  style="background-color:white;">	'+	        			 
     	 '<th data-title="Employee Code"><span  class="user-content">Employee Code :  </span> <span  class="user-content" > '+$.trim(data.empCode)+' </span></th>'+	
		 '<th data-title="Employee Name"><span  class="user-content">Employee Name : </span> <span  class="user-content" > '+$.trim(data.empName)+' </span></th>'+	
		 '<th data-title="Division"><span  class="user-content">Division :  </span> <span  class="user-content" >'+$.trim(data.division)+' </span></th>'+	 
       	 '<th data-title="Job Title"><span  class="user-content">Job Title :  </span> <span  class="user-content" >'+$.trim(data.jobTitle)+' </span></th>'+	         	 
         '<th data-title="Joining Date"><span  class="user-content">Joining Date : </span>'+	 
         '<span class="user-content">' + $.trim(data.joiningDate.substring(0, 10)).split("-").reverse().join("/") +	 '</span>'+		  
         '</th>'+			                                                                      
         '<th data-title="Manager"><span  class="user-content" >Manager: </span> <span  class="user-content" >'+$.trim(data.manager)+' </span></th>'+	     
	 	 '</tr>'+ 	
	     '</tbody>'+		
   	     '</table>';   
		$("#modal_detail .modal-body").html(output);
		$("#modal_detail").modal("show");
		$('#excelTbl').DataTable( {
    	dom: 'Bfrtip',     
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

},error:function(data,status,er) { $('#laoding').hide(); alert("please click again"); }});}
 


function getEmpLeave(empCode, empName){ $('#laoding').show();
$("#modal_detail .modal-body").html("");
$('#laoding').show();
var ttl="<b>Employee Leave Details -"+empCode+", "+empName+"</b>"; 
var excelTtl="Employee Leave Details -"+empCode+", "+empName;
$("#modal_detail .modal-title").html(ttl);
var output="";
 output += '<table id="excelTbl" class="table table-bordered small bordered no-padding table-striped">';
 output +="<thead><tr><th>Year</th><th>Leave Type</th><th>Accrued Days</th><th>Availed Days</th><th>Balance Days</th></tr></thead>"; 
$.ajax({
 type: _method,
 url: _url, 
 data: {action: "leaveDtls", hr0:empCode},
 dataType: "json", 
 success: function(data) { 
	 $('#laoding').hide();
	 
	 output += '<tbody>';   
		if(data.length > 0){ 
		  data.map( item => { 
			  output += "<tr>";
			  output += "<td class='scoreEmp'>"+validateData(item.year)+"</td>"; 
			  output += "<td class='scoreEmp'>"+validateData(item.leave)+"</td>"; 
			  output += "<td class='scoreValue'>"+validateData(item.accruedleaveDays)+"</td>"; 
			  output += "<td class='scoreValue'>"+validateData(item.availedLeaveDays)+"</td>"; 
			  output += "<td class='scoreValue'>"+validateData(item.balanceDays)+"</td>";  
			 
			  output += "</tr>"; 
		});
			
		}else{output += "";} 
		$("#salaryHistory").html(output);
     output +='</tbody></table>';   
     
	$("#modal_detail .modal-body").html(output);
	$("#modal_detail").modal("show");
	$('#excelTbl').DataTable( {
	dom: 'Bfrtip',     
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


},error:function(data,status,er) { $('#laoding').hide(); alert("please click again"); }});}
  
function getEmpLeaveHistory(empCode, empName){ 
	$("#modal_detail .modal-body").html("");
	$('#laoding').show();
	var ttl="<b>Employee Leave History - "+empCode+", "+empName+"</b>"; 
	var excelTtl="Employee Leave History -"+empCode+", "+empName;
	$("#modal_detail .modal-title").html(ttl);
  var output="";
	 output += '<table id="excelTbl" class="table table-bordered small bordered no-padding table-striped">';
     output +="<thead> <tr><th>Leave</th><th>From</th><th>To</th><th>Leave Days</th></tr></thead>"; 
$.ajax({
	 type: _method,
	 url: _url, 
	 data: {action: "leaveHistory", hr0:empCode},
	 dataType: "json", 
	 success: function(data) { 
		 $('#laoding').hide();
		 
		 output += '<tbody>';      		
		 if(data.length > 0){ 
			data.map( item => { 
			  output += "<tr>";
			  output += "<td class='scoreEmp'>"+validateData(item.leave)+"</td>"; 
			  output += "<td class='scoreEmp'>"+validateDate($.trim(item.fromDate))+"</td>"; 
			  output += "<td class='scoreEmp'>"+validateDate($.trim(item.toDate))+"</td>"; 
			  output += "<td class='scoreValue'>"+validateData(item.leaveDays)+"</td>";  
			 
			  output += "</tr>"; 
		});
			
		}else{output += "";}
	     output +='</tbody></table>';   
	     
		$("#modal_detail .modal-body").html(output);
		$("#modal_detail").modal("show");
		$('#excelTbl').DataTable( {
    	dom: 'Bfrtip',     
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

},error:function(data,status,er) { $('#laoding').hide(); alert("please click again"); }});}

function getOtherDetails(empCode, empName){ 
	$('#laoding').show(); 
	$("#modal_detail .modal-body").html("");
	var ttl="<b>Details Updated Employee - "+empCode+", "+empName+"</b>"; 
	var excelTtl="Details Updated Employee -"+empCode+", "+empName;
	$("#modal_detail .modal-title").html(ttl); 
var output = '<table id="excelTbl" class="table table-bordered small bordered no-padding table-striped">';
	output +='<thead><tr><th>Office Mobile No.</th><th>Emirates ID No.</th> <th>Emirates ID Expiry Dt.</th><th>Visa File No.</th><th>Visa Date Of Issue</th> <th>Visa Expiry Dt.</th> <th>UID No.</th>';
   // output +='<th>UID Expiry Dt.</th>
    output +='<th>Passport No.</th>';
    output +='<th>Passport Expiry Dt.</th><th>Medical Insurance Category</th><th>Emergency Contact Full Name</th><th>Emergency Contact Mobile No.</th>';
	output +='<th>Emergency Contact Relationship</th><th>End Of Service Nomination</th><th>End Of Service Mobile No.</th></tr></thead>'; 
 var employeeOtherDetails =  empDetails.filter( item=> item.emp_code ===empCode ); 
 if(employeeOtherDetails){ 
	 output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails[0].office_Mobile_Number)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails[0].emirates_Id_Number)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateDate(employeeOtherDetails[0].emirates_Id_Expiry_Date)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails[0].visa_Number)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateDate(employeeOtherDetails[0].date_Of_Issue)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateDate(employeeOtherDetails[0].visa_Expiry_Date)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails[0].uid_Number)+"</td>";
	  //output += "<td class='scoreEmp hideColumn'>"+validateDate(employeeOtherDetails[0].uID_Expiry_Date)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails[0].passport_Number)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateDate(employeeOtherDetails[0].passport_Expiry_Date)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails[0].medical_Insurance_Category)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails[0].emergency_Contact_Full_Name)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails[0].emergency_Contact_Mobile_Number)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails[0].emergency_Contact_Relationship)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails[0].end_Of_Service_Nomination)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails[0].end_Of_Service_Mobile_Number)+"</td>";
	  $('#laoding').hide();
	  
 }else{output += ""; $('#laoding').hide();} 
  output +='</tbody></table>';   
 
	$("#modal_detail .modal-body").html(output);
	$("#modal_detail").modal("show");
	$('#excelTbl').DataTable( {
	dom: 'Bfrtip',  
	"searching":   false,
	  "paging":   false,
      "ordering": false,
      "info":     false,
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
 

}
function getSalRevisions(empCode, empName){
$('#laoding').show(); 
$("#modal_detail .modal-body").html("");
var ttl="<b>Employee Salary Revision History - "+empCode+", "+empName+"</b>"; 
var excelTtl="Employee Salary Revision History -"+empCode+", "+empName;
$("#modal_detail .modal-title").html(ttl);
var output="";
 output += '<table id="excelTbl" class="table table-bordered small bordered no-padding table-striped">';
 output +="<thead><tr><th>From</th><th>Currency</th><th>Basic</th><th>Allowance </th> <th>Total Amount</th></tr></thead>"; 
$.ajax({
 type: _method,
 url: _url, 
 data: {action: "salaryRevision", hr0:empCode},
 dataType: "json", 
 success: function(data) { 
	 $('#laoding').hide(); 
	 output += '<tbody>';    
		if(data.length > 0){ 
			data.map( item => { 
			  output += "<tr>"; 
			  output += "<td class='scoreEmp'>"+validateDate($.trim(item.fromDate))+"</td>"; 
			//  output += "<td class='scoreEmp'>"+validateDate($.trim(item.toDate))+"</td>";
			 output += "<td class='scoreEmp'>"+validateData(item.currency)+"</td>";
			 output += "<td class='scoreValue'>"+validateData(item.orgAmount)+"</td>";
			  output += "<td class='scoreEmp'>"+validateData(item.allowance)+"</td>"; 
			 // output += "<td class='scoreValue'>"+validateData(item.adjAmount)+"</td>";
			  output += "<td class='scoreValue'>"+validateData(item.finalAmount)+"</td>";
			  output += "</tr>"; 
		}); 
			
		}else{output += "";} 
     output +='</tbody></table>';   
     
	$("#modal_detail .modal-body").html(output);
	$("#modal_detail").modal("show");
	$('#excelTbl').DataTable( {
	dom: 'Bfrtip', 
	"columnDefs" : [{"targets":[0], "type":"date-eu"}],
	"order": [[ 0, "desc" ]],
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

},error:function(data,status,er) { $('#laoding').hide(); alert("please click again"); }});}

</script>  
<!-- page Script  end -->
</c:when>
<c:otherwise>
        <body onload="window.top.location.href='logout.jsp'"></body> 
</c:otherwise>
</c:choose>
</html>