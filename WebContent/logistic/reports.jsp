<%-- 
    Document   : LOGISTIC DASHBOAR IMPORT P 
--%>
<%@include file="/logistic/header.jsp" %> 

 <c:choose>
 	<c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1 and ( fjtuser.emp_divn_code eq 'LG' or  fjtuser.role eq 'mg' )}">
 	 <style>
     .hidden-content{display:none;} 
     .slid, th.slid>input{max-width:40px !important; width:40px !important; }    
     .dateFld, th.dateFld>input{max-width:75px !important; width:75px !important; }
     .cmnFld, th.cmnFld>input{max-width:max-content !important; width:80px !important; }  
     .textAreaFld, th.textAreaFld>input{max-width:80px !important; width:80px !important; }   
   table tr:FIRST-CHILD + tr + tr { display:none; }
   .sm-bx-row{display: table;  border: 1px solid #607d8b;margin-top: -10px; table-layout: fixed; margin-bottom: 2px;margin-left:15px;}
   .sm-bx-col{display: table-cell; padding:3px 10px; color:#000 !important;text-transform:uppercase;font-weight:bold;border: 1px solid #607d8b; }
   .genStyl{background:#dfe3f0;}
    /*tr.filters>th{background: white; color: #000 !important;}*/

	 </style>
 		<%@page import="com.google.gson.Gson"%>	 
 		<c:set var="importController" value="LogisticPOController" scope="page" />
 		<c:set var="deliveryController" value="LogisticDeliveryController" scope="page" />
 		<c:set var="reportController" value="LogisticReportController" scope="page" />
 		<jsp:useBean id="now" class="java.util.Date" scope="request"/> 
 		<fmt:formatDate var="currentDate" value="${now}" pattern="dd/mm/yyyy" scope="page" /> 
 		<c:set  value="${fjtuser.uname}" var="empName" scope="page" />	
 		<c:set value="FJ-Logistic" var="topHeaderFullName" scope="page" />
  		<c:set value="L" var="topHeaderShortName" scope="page" />
  		<c:set value="Reports" var="contentTitle" scope="page" />
  		<c:set value="Logistic Dashboard" var="dashboardFullName" scope="page" /> 
  		<c:set value="Logistic Portal" var="currentPortalName" scope="page" />

 	<body class="hold-transition skin-blue sidebar-mini sidebar-collapse sidebar-mini">
 		<div class="wrapper">
		 <%@include file="/logistic/dashboardHeader.jsp" %> 
		
  	 <!-- Left side column. contains the logo and sidebar -->
  	 <aside class="main-sidebar">
   			 <!-- sidebar-->
    		<section class="sidebar">
		      <!-- Sidebar user panel --> 
		      <!-- sidebar menu -->
		      <ul class="sidebar-menu" data-widget="tree">
		      <c:if test="${fjtuser.emp_divn_code eq 'LG' or  fjtuser.role eq 'mg'  }"> 
		       <li  class="active"><a href="${reportController}"><i class="fa fa-dashboard"></i><span>Dashboard</span></a></li> 
		      </c:if> 
		         <li><a href="${importController}"><i class="fa fa-tasks"></i><span>Import PO's</span></a></li>   
		         <li><a href="${deliveryController}"><i class="fa fa-truck"></i><span>Delivery</span></a></li>            
		         <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>      
		      </ul>
		    </section>
		    <!-- /.sidebar -->
  	 </aside>

	  <!-- Content Wrapper. Contains page content -->
	  <div class="content-wrapper">
	    <%@include file="/logistic/contentHeader.jsp" %>  
	    <!-- Main content -->	    
		    <%--Field Staff Home Section Start--%>
		    <section class="content">
		    <c:set var="rqstscount" value="0" scope="page" />  	     
		    <%-- TABLUAR DETAILS START --%>
		   <div class="row small">
	        <div class="col-xs-12">
	          <div class="box box-primary justify-content-center">
	          <div class="box-header">
	          <h4 class="box-title">Live Orders </h4>
	          
	          </div>
	          
	            <div class="box-body table-responsive  padding" style="/*display:flex;*/">
	         
	              <table class="table table-bordered small bordered display nowrap"  id="displayPos">
	                <thead>	           
	                <tr>
	                  <th class="slid" >SL. No.</th> 
	                 <%--<th>Company</th>  --%>
	                  <th class="cmnFld" >PO Number</th> 
	                  <th class="dateFld">PO Date</th>
	                  <th class="cmnFld" >Supplier</th>
	                  <th class="cmnFld">Payment Term</th>
	                  <th class=" cmnFld">Shipment Term</th>
	                  <th class=" cmnFld">Shipment<br/>Mode</th>
	                  <th class=" cmnFld">No. Of <br/>Containers</th>
	                  <th class=" dateFld">EX Factory<br/>Date</th>
	                  <th class=" cmnFld">Re-Export</th>
	                  <th class=" cmnFld">Contact<br/>Details</th>
	                  <th class=" cmnFld">Pick-Up<br/>Location</th>
	                  <th class=" cmnFld">Final<br/>Destination/Port</th>
	                  <th class=" cmnFld">Division<br/>Remarks</th> 
	                  <th class=" dateFld">ETD</th>
	                  <th class=" dateFld">ETA</th>
	                  <th class="  textAreaFld">Shipping <br/>Doc. Status</th> 
	                  <th class="  textAreaFld">Logistic<br/>Remarks</th>
	                  <th class=" cmnFld">Reference</th> 
	                </tr>
	                </thead>
	                <tbody>
	                <c:forEach var="request" items="${POLST}" >
	                <c:set var="rqstscount" value="${rqstscount + 1}" scope="page" />
	                <tr>
	                  <td class="slid"  id="${request.id}">${rqstscount}</td>
	                  <%--<td>${request.company}</td>--%>    
	                  <td id="poNo${request.id}"  class='cmnFld'>${request.poNumber}</td>      
	                  <td id="poDt${request.id}" class="dateFld"> 
	                  		<fmt:parseDate value="${request.poDate}" var="thePoDate"  dateStyle="short"   pattern="yyyy-MM-dd HH:mm" />
	                  		<fmt:formatDate value="${thePoDate}" pattern="dd/MM/yyyy"/>
	                  </td> 
	                  <td class="dtlsHeader cmnFld"> ${fn:substring(request.supplier, 0, 7)}<c:if test="${!empty request.supplier}">..<span class="dtlsContent"  id="suplr${request.id}">${request.supplier}</span></c:if></td>
	                   <td class="dtlsHeader cmnFld"> ${fn:substring(request.paymentTerms, 0, 7)}<c:if test="${!empty request.paymentTerms}">..<span class="dtlsContent">${request.paymentTerms}</span></c:if>
	                    <input type="hidden" id="divUpdByVal${request.id}" value="${request.divnUpdatedBy}"/>
	                    <input type="hidden" id="divUpdByName${request.id}" value="${request.divnEmpName}"/>
	                   </td> 	                   
	                     <td class=" dtlsHeader cmnFld"> ${fn:substring(request.shipmentTerm, 0, 7)}<c:if test="${!empty request.shipmentTerm}">..<span class="dtlsContent" >${request.shipmentTerm}</span></c:if></td>  
	                        <td class=" dtlsHeader cmnFld"> ${fn:substring(request.shipmentMode, 0, 9)}<c:if test="${!empty request.shipmentMode}"><span class="dtlsContent" >${request.shipmentMode}</span></c:if></td>  
	                 	  	 <td class=""> ${request.noOfContainers}</td>
	                 		 <td class="dateFld">
	                  			<fmt:parseDate value="${request.exFactoryDate}" var="theExFDate"  dateStyle="short"   pattern="yyyy-MM-dd HH:mm" />
	                  			<fmt:formatDate value="${theExFDate}" pattern="dd/MM/yyyy"/>
							</td>
							<td class="dtlsHeader cmnFld">re-export
							<c:choose>
			                  <c:when test="${request.reExport eq 'Y' }">YES</c:when>
			                  <c:otherwise>NO</c:otherwise>
			                 </c:choose>
							</td>   
	                  		<td class="dtlsHeader cmnFld"> ${fn:substring(request.contactDetails, 0, 7)}<c:if test="${!empty request.contactDetails}">...<span class="dtlsContent">${request.contactDetails}</span></c:if></td>  
	                  		<td class="dtlsHeader cmnFld"> ${fn:substring(request.pickLocation, 0, 7)}<c:if test="${!empty request.pickLocation}">...<span class="dtlsContent">${request.pickLocation}</span></c:if></td>   
	                  		<td class="dtlsHeader cmnFld"> ${fn:substring(request.finalDestination, 0, 7)}<c:if test="${!empty request.finalDestination}">...<span class="dtlsContent">${request.finalDestination}</span></c:if></td> 
	                  		<td class="dtlsHeader cmnFld"> ${fn:substring(request.divnRemarks, 0, 7)}<c:if test="${!empty request.divnRemarks}">...<span class="dtlsContent">${request.divnRemarks}</span></c:if></td>   
	                  		  
	                 		<td class="dateFld"> 
	                 			<fmt:parseDate value="${request.expTimeDeparture}" var="theDeptDate"  dateStyle="short"   pattern="yyyy-MM-dd HH:mm" />
			                  	<fmt:formatDate value="${theDeptDate}" pattern="dd/MM/yyyy"/> 
	                 		 </td>
		                  	<td class="dateFld">
		                  		<fmt:parseDate value="${request.expTimeArrival}" var="theArrvlDate"  dateStyle="short"   pattern="yyyy-MM-dd HH:mm" />
			                  	<fmt:formatDate value="${theArrvlDate}" pattern="dd/MM/yyyy"/> 
		                  	</td>   
		                  	 <td class="dtlsHeader cmnFld"> ${fn:substring(request.shipDocStatus, 0, 7)}<c:if test="${!empty request.shipDocStatus}">...<span class="lg_dtlsContent">${request.shipDocStatus}</span></c:if></td>
		                  	 <td class="dtlsHeader cmnFld"> ${fn:substring(request.logisticRemark, 0, 7)}<c:if test="${!empty request.logisticRemark}">...<span class="lg_dtlsContent">${request.logisticRemark}</span></c:if></td>
		                  	 <td class="dtlsHeader cmnFld" > ${fn:substring(request.reference, 0, 9)}<c:if test="${!empty request.reference}">..<span class="lg_dtlsContent" id="lgRef${request.id}">${request.reference}</span></c:if></td>  
		                                  	                 
	                </tr>
	               </c:forEach>      
	              </tbody></table> 
	            </div>
	            <!-- /.box-body -->
	          </div>
	          <!-- /.box -->
	        </div>
	      </div>
		  <%-- TABULAR DETAILS END --%> 
		    </section>
		    <%--Field Staff Home Section End --%>	        
	    <div id="laoding" class="loader" ><img src="././resources/images/wait.gif"></div> 
	    <!-- /.content -->
	   </div>   
  	<!-- /.content-wrapper -->
	<%@include file="/logistic/footer.jsp" %> 
	<!-- page script start -->
	</div>
<script>
var _url = 'LogisticPOController';
var _method = "POST"; 
var table;
$(function(){ 
	 $('.loader').hide();	 
	  $('#displayPos thead tr')
      .clone(true)
      .addClass('filters')
      .appendTo('#displayPos thead');
	 $('#displayPos').DataTable({  
		    dom: 'Bfrtip',  
			   buttons: [{ extend: 'excelHtml5', text:      '<i class="fa fa-file-excel-o" style="color: #dd4b39; font-size: 1.2em;">Export</i>', filename: 'LOGISTIC LIVE ORDERS REPORT - ${currCal}',
			   title: 'LOGISTIC LIVE ORDERS REPORT - ${currCal}', messageTop: 'The information in this file is copyright to FJ-Group.'}],	 
	        'paging'      : true,
	        'lengthChange': false,
	        'searching'   : true,
	        'ordering'    : true,
	        'info'        : false,
	       // "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
	        "columnDefs" : [{"targets":[2, 8, 15, 16], "type":"date-eu"}], 
	          responsive: true,
	    	  orderCellsTop: true,
	          fixedHeader: true, 

		        'autoWidth'   : false,
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
 	                    $(cell).html('<input type="text" placeholder="' + title + '" />');
 	 
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
	 
	
	 
});
function preLoader(){ $('.loader').show();}


function checkDateFormat(dateStr, dateName){  
	if(dateStr){
		if(!(moment(dateStr, "DD/MM/YYYY", true).isValid())){
			 alert("Please Select Correct "+dateName+" Date.");
			return false;
		}else{
			return true;
		} 
	}else{ return true;}
}
 function checkValidOrNot(value){
	 if(typeof value === 'undefined'){
		 return "-";
	 }else{
		 return value;
	 }
 }
 function checkValidOrNotDate(value){
	 if(typeof value === 'undefined'){
		 return "-";
	 }else{
		 return $.trim(value.substring(0, 10)).split("-").reverse().join("/");
	 }
 }
 function setContainerValue(noContainers, id){
	 if(Number.isInteger(noContainers)){ 
		document.getElementById('containers'+id+'').value = noContainers;
		 return noContainers;
	 }else{
		 document.getElementById('containers'+id+'').value = 0;
		 return 0;
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