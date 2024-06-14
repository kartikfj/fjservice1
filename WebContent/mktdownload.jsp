<%-- 
    Document   : MARKETING TO DOWNLOAD DATA 
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="mainview.jsp" %>
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
 <head>
 
 <!-- Font Awesome -->
    <link rel="stylesheet" href="resources/bower_components/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="resources/dist/css/skins/_all-skins.min.css">
	<link rel="stylesheet" type="text/css" href="resources/datatables/datatables-fjtco/css/jquery.dataTables.min.css" />
	<link rel="stylesheet" type="text/css" href="resources/datatables/buttons-fjtco/css/buttons.dataTables.min.css" />
	<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/dataTables.buttons.min.js"></script>
	<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.flash.min.js"></script>
	<script type="text/javascript" src="resources/datatables/ajax/excelmake/jszip.min.js"></script>
	<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.html5.min.js"></script>
	<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.print.min.js"></script>
 
  <!-- Theme style -->
  <link rel="stylesheet" href="resources/dist/css/AdminLTE.min.css">
  <link rel="stylesheet" href="resources/dist/css/skins/_all-skins.min.css">
   <link rel="stylesheet" href="resources/css/mkt-layout.css">
 <style>

 </style>
 
 <script>
$(document).ready(function(){
    $('[data-toggle="tooltip"]').tooltip(); 
});
</script>
 </head>


<c:choose>
<c:when test="${!empty fjtuser.emp_code and fjtuser.emp_code eq 'E000020' or fjtuser.emp_code eq 'E000001'  or fjtuser.emp_code eq 'E000063' or fjtuser.sales_code ne null or fjtuser.emp_code eq 'E003066'  and fjtuser.checkValidSession eq 1  and fjtuser.emp_com_code ne 'EME'}">
<body>

	<div class="container" style="margin-top: -20px;">
	<div class="panel panel-default  small" >
                     <div class="panel-heading" style="padding:4px 8px !important;color:#065685;text-transform: uppercase;">
                        
                        <h4 class="text-center">
                      <a href="homepage.jsp" > <i class="fa fa-home pull-right"></i></a>
                       Marketing Portal 
                       <a href="MarketingLeads.jsp" > <i class="fa fa-refresh pull-right"></i></a></h4>
                      
                     </div>
    </div>
    <ul class="nav nav-tabs">
     <li><a  href="MarketingLeads.jsp">Projects Under Design</a></li>
     <li>
     <form method="post" action="MarketingLeads.jsp">
     <input type="hidden" value="lctlmftc" name="octjf" />
     <button type="submit" class="cnsltfrm-btn" >Consultant Leads</button>
     </form>
     </li>
      <li class="active"><a data-toggle="tab" href="#mkt04">Download</a></li>
    </ul>
   
    <div class="tab-content">
   <div id="mkt01" class="tab-pane fade">
   
  
   
   
   <!-- Marketing Leads Details Start -->
   
          <div class="box box-default">
            <div class="box-header">
              <h3 class="box-title" style="text-transform: uppercase;color: #065685;">Under Design Details</h3>
               <!-- download Marketing leads start 1-->

             <div class="pull-right" id="dwnldexcl">
              <table id="dwnldLeads" style="display:none;">
             <thead><tr> <th>Opportunities</th><th>Status</th>   <th>Location</th>
             <th>Leads</th><!-- <th>Contact Details </th> --><th>Products</th>
             <th>Remarks</th><th>Main Contractor</th><th>MEP Contractor</th><th>Updated on </th> </tr>
             </thead> <tbody> <c:forEach var="mktLst"  items="${MLWD}" > <tr>
             <td>${mktLst.opt}<span class='highlight'>${mktLst.updateStatus}</span></td><td>${mktLst.status}</td> <td>${mktLst.location}</td><!--<td>${mktLst.leads}</td>-->
             <td>${mktLst.contactDtls} </td><td>${mktLst.products}</td>   <td>${mktLst.remarks}</td> 
             <td><p class="long-letters">${mktLst.mainContractor}</p></td>
                         <td><p class="long-letters">${mktLst.mepContractor}</p></td>
             
               <td>
             <i style="color:#065685;"> <fmt:parseDate value=" ${mktLst.updatedDate}" var="theDate"    pattern="yyyy-MM-dd HH:mm" />
             <fmt:formatDate value="${theDate}" pattern="MMM-YYYY"/> </i> </td>  </tr>
              </c:forEach> </tbody>  </table></div>
              
    
   <!-- download Marketing leads end 1 -->
               <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
               
              </div>
            </div>
            <!-- /.box-header -->
             <c:if test="${fjtuser.emp_code eq 'E000020' }">
               <button type="button" class="btn btn-info add-new" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#newUnderDsgn"><i class="fa fa-plus"></i> Add New</button>
           </c:if>
            <div class="box-body table-responsive no-padding small" style="margin-top: -10px;">
            
              <table class="table table-hover" id="displayLeads" >
        		 
        			 
        		    <thead>
        			 <tr style="background-color:#000;color:#fff;">
        			     <th>#</th>
        				 <th>Opportunities</th>
                         <th>Status</th>
                        <th>Location</th>
                         <th>Leads</th>
                        <!--  <th>Contact Details </th>-->
                         <th>Products</th>
                         <th>Remarks</th>
                         <th>Week</th>
                         <th  width="90">Updated on </th>
                      <c:if test="${fjtuser.emp_code eq 'E000020' }">   <th>Action</th></c:if>
                     </tr>
                     </thead>
                     <c:set var="mcount" value="0"/>
                    <tbody>
                      <c:forEach var="mktLst"  items="${MLWD}" >
                     <c:set var="mcount" value="${mcount + 1 }"/>
                      <tr>
        			     <td>${mcount}</td>
        				 <td>${mktLst.opt}</td>
                         <td><span class="label label-warning">${mktLst.status}</span></td>
                        <td><i class="fa fa-map-marker" style="color:green;"> ${mktLst.location}</i></td>
                         <!-- <td>${mktLst.leads}</td>-->
                         <td>${mktLst.contactDtls} </td>
                         <td>${mktLst.products}</td>
                         <td>${mktLst.remarks}</td>
                         <th align="center"><span class="label label-info" >
                         ${fn:substring(mktLst.updatedYr,2, 4)}
                         -
                         <c:choose>
                         <c:when test="${mktLst.updtdWeek lt 10}">0${mktLst.updtdWeek}</c:when>
                         <c:otherwise>${mktLst.updtdWeek}</c:otherwise>
                         </c:choose>
                         
                         </span></th>
                         <td>
                        <i style="color:#065685;"> <fmt:parseDate value=" ${mktLst.updatedDate}" var="theDate"    pattern="yyyy-MM-dd HH:mm" />
                             <fmt:formatDate value="${theDate}" pattern="dd-MM-yyyy"/>
                        </i>
                         </td>
                         <c:if test="${fjtuser.emp_code eq 'E000020' }">
                              <td>
                          <a href="#"   id="eg" class="btn btn-primary btn-xs" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#editIGoal${mcount}">
						       		 <i class=" fa fa-pencil" aria-hidden="true"></i>
						       		 </a>
						        	 <!-- delete -->
   											<form action="MarketingLeads.jsp" method="POST" style="display: inline !important;" name="gs_form_delete">
	   											 <input type="hidden" value="${mktLst.id}" name="mktli" />
	     										<input type="hidden" name="octjf" value="DELETE" />
	     									     <button type="submit" id="mkld"  class="btn btn-danger btn-xs"  onclick="if (!(confirm('Are You sure You Want to delete this Marketing Opportunitty!'))) return false" >
								        		 <i class="fa fa-trash" aria-hidden="true"></i></button>
								        	</form>
								        	</td>
								        	</c:if>
                     </tr>
                     
                     
                         <c:if test="${fjtuser.emp_code eq 'E000020' }">    <div class="row">
				<div class="modal fade" id="editIGoal${mcount}" role="dialog">
				
			       <div class="modal-dialog">
			    
				      <!-- Modal content-->
				      <div class="modal-content">
				        <div class="modal-header">
				          <button type="button" class="close" data-dismiss="modal">&times;</button>
				          <h4 class="modal-title">Edit Under Design Details</h4>
				        </div>
				        <div class="modal-body">
				          
                        
  							<form action="MarketingLeads.jsp" method="POST" class="form-vertical" name="gi_form_edit">
  						 
	                    
						<input type="hidden" name="octjf" value="UPDATE" />
	                    <input type="hidden" name="mktli" value="${mktLst.id}" />
	                  <div class="row">  
               <div class="col-md-8">
                <div class="form-group">
                  <label for="mktOpportunity">Opportunity</label>
                  <textarea class="form-control" rows="3" id="mktOpportunity" placeholder="Enter Opportunity " name="mktOpportunity" required>${mktLst.opt}</textarea>
             
                </div>
                <div class="form-group">
                  <label for="mktLocation">Location</label>
                  
                  
                  <input type="text" class="form-control" id="mktLocation" placeholder="Enter Location Details" name="mktLocation" value="${mktLst.location}">
                </div>
                <div class="form-group">
                  <label for="mktContact">Contact Details</label>
                  <input type="text" class="form-control" id="mktContact" placeholder="Enter Contact Details" name="mktContact" value="${mktLst.contactDtls}">
                </div>
               <div class="form-group">
                  <label for="mktRmrk">Remarks</label>
                  <textarea class="form-control" rows="3" id="mktRmrk" placeholder="Enter Contact Details" name="mktRmrk">${mktLst.remarks}</textarea>
                </div>
                </div>
                <div class="col-md-4">
                  <div class="form-group">
                  <label>Status</label>
                  <select class="form-control" name="mkstatus">
                    <option value="${mktLst.status}">${mktLst.status}</option>
                    <option value="Concept">Concept</option>
                    <option value="Design">Design</option>
                    <option value="Tender">Tender</option>
                    <option value="JIH">JIH</option>
                  </select>
                </div>
                 <div class="form-group" >
                  <label>Leads</label>
                  <select class="form-control" name="mkLeads">
                  <option value="${mktLst.leads}">${mktLst.leads}</option>
                    <option value="Owner">Owner</option>
                    <option value="Developer">Developer</option>
                    <option value="Consultant">Consultant</option>
                    <option value="Contractor">Contractor</option>
                  </select>
                </div>
              <div class="form-group">
                  <label for="mktPdct">Products / Division</label>
                  <textarea class="form-control" rows="3" id="mkPdct" placeholder="Enter Products/Division Details" name="mkPdct">${mktLst.products}</textarea>
                </div>
                 <div class="form-group">
                  <label for="week">Week</label>
                  <input type="number" min="1" max="53" class="form-control" id="mktWeek" placeholder="Enter Week Number" name="mktWeek" value="${mktLst.updtdWeek}" onkeypress='validate(event)'>
                </div>
                </div>
              
              </div>    <div class="box-footer">
                <button type="submit" class="btn btn-primary">Submit</button>
              </div>
						</form>
									        </div>
				        <div class="modal-footer">
				          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				        </div>
				      </div>
			   		 </div>
 					</div>
  
		</div></c:if>
                     </c:forEach>
                    </tbody>
                    </table>
            </div>
            <!-- /.box-body -->
          </div>
             
   <!-- Marketing Leads Details End -->
    
  </div>


   <div id="mkt04" class="tab-pane fade  in active">
    <!-- download Marketing leads start 1--><br/>
    <div class="row dwnldprvs">
             <div class="box-header">
             <h3 class="box-title" style="color: #065685;">Download Previous Under Design Details - ${CURR_YR}</h3>
             <div class="pull-left dwnldexcl">
             <table id="mkt_modal_table" style="display:none;">
            <thead><tr> <th>Opportunities</th><th>Status</th>   <th>Location</th>
             <th>Leads</th><!-- <th>Contact Details </th> --><th>Products</th>
             <th>Remarks</th><th>Main Contractor</th><th>MEP Contractor</th><th>Updated on </th> </tr>
             </thead> <tbody> <c:forEach var="mktLst"  items="${MLAD}" > <tr>
             <td>${mktLst.opt}<span class='highlight'>${mktLst.updateStatus}</span></td><td>${mktLst.status}</td> <td>${mktLst.location}</td><!--<td>${mktLst.leads}</td>-->
             <td>${mktLst.contactDtls} </td>           
              <td>     
             <c:forEach var="dvnLst"  items="${DLFCL}" >
             <c:choose>
             <c:when test="${mktLst.products eq dvnLst.divn_code}">           
               ${dvnLst.divn_name}              
             </c:when>         
             </c:choose>
            </c:forEach>         
            </td> 
                <td>${mktLst.remarks}</td> 
             <td><p class="long-letters">${mktLst.mainContractor}</p></td>
                         <td><p class="long-letters">${mktLst.mepContractor}</p></td>
             
               <td>
             <i style="color:#065685;"> <fmt:parseDate value=" ${mktLst.updatedDate}" var="theDate"    pattern="yyyy-MM-dd HH:mm" />
             <fmt:formatDate value="${theDate}" pattern="MMM-YYYY"/> </i> </td>  </tr>
              </c:forEach> </tbody> </table> </div>
              </div>
     </div>
   <!-- download Marketing leads end 1 -->
   </div>
   <div id="mkt05" class="tab-pane fade">
 
   <div class="row" id="conultant-wrapper">
   <div class="col-md-8">
   <form method="POST" action="MarketingLeads.jsp">
    <div class="input-group add-on">
    
    
   <input type="hidden" value="sbcnfpdw" name="octjf" />
    <input class="form-control" placeholder="Search by consultant name..." name="srch-term" id="srch-term" type="text">
   <div class="input-group-btn">
        <button class="btn btn-default" type="submit"><i class="fa fa-search"></i></button>
      </div>
      
       </div>
    </form>
    
    
     
      
   
   </div>
   <div class="col-md-2">
   <c:if test="${fjtuser.emp_code eq 'E000020' }">
    <button type="button" class="btn btn-info add-new" data-backdrop="static" data-keyboard="false" data-toggle="modal" data-target="#newConsltnLds"><i class="fa fa-plus"></i> Add New</button>
   </c:if>
   </div>
   <div class="col-md-2">
  
   <form method="POST" action="MarketingLeads.jsp">
     
   <input type="hidden" value="dlcav" name="octjf" />
    <button type="submit" class="btn btn-info add-new"  >View All</button>
    </form>
  
   </div>
    </div>
     <div class="row" id="consltant-data-wrapper">
     <div id="cnslt-content"></div>
     </div>
     
   </div>
   
   </div>
</div>
    
	
                         <c:if test="${fjtuser.emp_code eq 'E000020' }">    <div class="row">
				<div class="modal fade" id="newUnderDsgn" role="dialog">
				
			       <div class="modal-dialog">
			    
				      <!-- Modal content-->
				      <div class="modal-content">
				        <div class="modal-header">
				          <button type="button" class="close" data-dismiss="modal">&times;</button>
				          <h4 class="modal-title">Enter Under Design Details</h4>
				        </div>
				        <div class="modal-body">
				          
                        
  					<form role="form" action="MarketingLeads.jsp" method="post">
              <div class="box-body">
               <div class="row">  
               <div class="col-md-8">
                <div class="form-group">
                  <label for="mktOpportunity">Opportunity</label>
                  <textarea class="form-control" rows="3" id="mktOpportunity" placeholder="Enter Opportunity " name="mktOpportunity" required></textarea>
             
                </div>
                <div class="form-group">
                  <label for="mktLocation">Location</label>
                  
                  
                  <input type="text" class="form-control" id="mktLocation" placeholder="Enter Location Details" name="mktLocation" required>
                </div>
                <div class="form-group">
                  <label for="mktContact">Contact Details</label>
                  <input type="text" class="form-control" id="mktContact" placeholder="Enter Contact Details" name="mktContact" required>
                </div>
               <div class="form-group">
                  <label for="mktRmrk">Remarks</label>
                  <textarea class="form-control" rows="3" id="mktRmrk" placeholder="Enter Contact Details" name="mktRmrk" required></textarea>
                </div>
                </div>
                <div class="col-md-4">
                  <div class="form-group">
                  <label>Status</label>
                  <select class="form-control" name="mkstatus" required>
                    <option value="">Select Status</option>
                    <option value="Concept">Concept</option>
                    <option value="Design">Design</option>
                    <option value="Tender">Tender</option>
                    <option value="JIH">JIH</option>
                  </select>
                </div>
                 <div class="form-group" >
                  <label>Leads</label>
                  <select class="form-control" name="mkLeads" required>
                  <option>Select Leads</option>
                    <option value="Owner">Owner</option>
                    <option value="Developer">Developer</option>
                    <option value="Consultant">Consultant</option>
                    <option value="Contractor">Contractor</option>
                  </select>
                </div>
              <div class="form-group">
                  <label for="mktPdct">Products / Division</label>
                  <textarea class="form-control" rows="3" id="mkPdct" placeholder="Enter Products/Division Details" name="mkPdct" required></textarea>
                </div>
                <div class="form-group">
                  <label for="week">Week</label>&nbsp;<span class="small">( Only enter Week number. Eg: 1,2,3...53)</span>
                  <input type="number"  min="1" max="53" class="form-control" id="mktWeek" placeholder="Enter Week Number" name="mktWeek" onkeypress='validate(event)' required>
                </div>
                </div>
              </div>
              </div>
              <!-- /.box-body -->
              <input type="hidden" name="octjf" value="etadputkm">
              <div class="box-footer">
                <button type="submit" class="btn btn-primary">Submit</button>
              </div>
            </form>
									        </div>
				        <div class="modal-footer">
				          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				        </div>
				      </div>
			   		 </div>
 					</div>
  
		</div>
		
		
		 <div class="row">
				<div class="modal fade" id="newConsltnLds" role="dialog">
				
			       <div class="modal-dialog">
			    
				      <!-- Modal content-->
				      <div class="modal-content">
				        <div class="modal-header">
				          <button type="button" class="close" data-dismiss="modal">&times;</button>
				          <h4 class="modal-title">Enter New Consultant Leads  Details</h4>
				        </div>
				        <div class="modal-body">
				          
                        
  					<form role="form" id="newConsult_form"  >
              <div class="box-body">
               <div class="row">  
               <div class="col-md-8">
                <div class="form-group">
                  <label for="newConsltnt">Consultant</label>
                  <input type="text" class="form-control" id="newConsltnt" placeholder="Enter Consultant Details" name="newConsltnt" required>
             
                </div>
                <div class="form-group">
                  <label for="mktLocation">Product Name</label>
                  
                  
                  <input type="text" class="form-control" id="newProduct" placeholder="Enter Location Details" name="newProduct" required>
                </div>
            
               <div class="form-group">
                  <label for="mktRmrk">Remarks</label>
                  <textarea class="form-control" rows="3" id="newConsRmrk" placeholder="Enter Contact Details" name="newConsRmrk" required></textarea>
                </div>
                </div>
                <div class="col-md-4">
                  <div class="form-group">
                  <label>Status</label>
                  <select class="form-control" name="newstatus" id="newstatus" required>
                    <option value="">Select Status</option>
                    <option value="Approved">Approved</option>
                    <option value="Not Yet Approved">Not Yet Approved</option>
                    <option value="Not Initiated">Not Initiated</option>            
                  </select>
                </div>
                 <div class="form-group" >
                  <label>Division</label>
                  <select class="form-control" name="newDiv" id="newDiv" required>
                  <option>Select Division</option>
                   <c:forEach var="dvnLst"  items="${DLFCL}" >
                    <option value="${dvnLst.divn_code}">${dvnLst.divn_name}</option>
                    </c:forEach>
                  </select>
                </div>
            
              
                </div>
              </div>
              </div>
              <!-- /.box-body -->
              <div class="box-footer">
                <button type="button" id="crtNewCnsltLds" class="btn btn-primary">Submit</button>
              </div>
            </form>
									        </div>
				        <div class="modal-footer">
				          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				        </div>
				      </div>
			   		 </div>
 					</div>
  
		</div>
		
		
		</c:if>
            		
    </div>

<script src="resources/bower_components/fastclick/lib/fastclick.js"></script>
<!-- AdminLTE App -->
<script src="resources/dist/js/adminlte.min.js"></script>
<script>
$(document).ready(function() {
	   $('#mkt_modal_table').DataTable( {
	        dom: 'Bfrtip',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-cloud-download" style="color: green; font-size: 2em;"></i>',
	                filename: "Under Design Details - ${CURR_YR}",
	                title: "Under Design Details -  ${CURR_YR}",
	                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	          
	           
	        ]
	    } );
	   
	   $('#displayLeads').DataTable( {
	        "paging":   false,
	        "ordering": true,
	        "info":     false,
	    } );
	   
	   $('#dwnldLeads').DataTable( {
		   dom: 'Bfrtipr',
	        "paging":   false,
	        "ordering": false,
	        "info":     false,
	        "searching": false,
	        buttons: [
	            {
	                extend: 'excelHtml5',
	                text:      '<i class="fa fa-cloud-download" style="color: green; font-size: 2em;"></i>',
	                filename: "Under Design Details - ${currCal}",
	                title: "Under Design Details -  ${currCal}",
	                messageTop: 'The information in this file is copyright to Faisal Jassim Group.'
	                
	                
	            }
	          
	           
	        ]
	    } );
	   
	   
	   $('#allConsltnLds').on('click', function(e){ 
		
		   $.ajax({	        	    
	    		 'async': false,
	     		 type: 'POST',
	        	 url: 'MarketingLeads.jsp',
	        	 data: {octjf: "dlcav"},
		  		 success: function(data) {
			     var op="";
			     var outdate="";
		  			var output="<table id='all-table' class='table table-bordered small'><thead><tr>"+"<th>#</th><th>Consultant</th><th>Product</th><th>Status</th>"+
		  			 "<th>Division</th><th>Remarks</th><th>Last Updated</th><th>Action</th></tr></thead><tbody>";
		  			 var j=0;for (var i in data) { 
		  				if(data[i].updated_date == '' || data[i].updated_date == undefined){
		  					outdate=$.trim(data[i].created_date.substring(0, 10)).split("-").reverse().join("/");
		  					}else{
		  						outdate=$.trim(data[i].updated_date);
		  						}
		  				 j=j+1; output+="<tr><td>"+j+"</td><td><span>" + $.trim(data[i].conslt_name)+ "</span></td>"+
		  			 "<td>" + $.trim(data[i].product)+ "</td><td>" + $.trim(data[i].status) + "</td>"+ "<td>" +$.trim(data[i].division)+ "</td><td>" + $.trim(data[i].remarks )+ "</td>"+		  
					 "<td>" +outdate+ "</td>"+
		  			 "<td>"+
		  			"<a href='#'  id='cedt' class='btn btn-primary btn-xs' data-backdrop='static' data-keyboard='false' data-toggle='modal' data-target='#editCDtls"+$.trim(data[i].cnslt_id)+"' >"+
		       		 "<i class=' fa fa-pencil' aria-hidden='true'></i>"+
		       		 "</a>"+
		       		"<form action='MarketingLeads.jsp' method='POST' style='display: inline !important;' name='cnslt_form_delete'>"+
					 "<input type='hidden' value="+$.trim(data[i].cnslt_id)+" name='dic' />"+
					"<input type='hidden' name='octjf' value='etldpc' />"+
				     "<button type='submit' id='mkld'  class='btn btn-danger btn-xs'  onclick='if (!(confirm('Are You sure You Want to delete this Marketing Opportunitty!'))) return false' >"+
        		 "<i class='fa fa-trash' aria-hidden='true'></i></button>"+
        	"</form>"+
			 "</td>"+ "</tr>"; 
		  				 output+=""+$.trim(data[i].cnslt_id);
		  			 
		  			 } 
		  			
		  			 
		  			 output+="</tbody></table>";  $("#cnslt-content").html(output);
			    
			    
		  },
		  error:function(data,status,er) {	        		
		    alert(data);
		   }
		 });
		   
		   
	   }); 
	   
	   $('#crtNewCnsltLds').on('click', function(e){        
			  var consltant_name = $('#newConsltnt').val();
			  var product=$('#newProduct').val();
			  var status=$('#newstatus').val();
			  var divsn=$('#newDiv').val();
			  var remark=$('#newConsRmrk').val();
			  if(consltant_name  != '' && product  != ''  && status != '' &&  divsn != '' &&  remark != ''){
	        	       
	        	    	 $.ajax({	        	    
	        	    		 'async': false,
	        	     		 type: 'POST',
	        	        	 url: 'MarketingLeads.jsp',
	        	        	 data: {octjf: "cnclfpad", cd1:$('#newConsltnt').val(), cd2:$('#newProduct').val(),cd3:$('#newstatus').val(),
	        	       		   cd4:$('#newDiv').val(),cd5:$('#newConsRmrk').val()},
	        		  		 success: function(data) {
	        			   
	        			    $("#newConsltnLds").modal('hide');
	        			    
	        			    alert(data);
	        			    
	        			    
	        		  },
	        		  error:function(data,status,er) {	        		
	        		    alert(data);
	        		   }
	        		 });
			  }else{alert("Please fill all data's");}
          }); 
});

function validate(evt) {
	  var theEvent = evt || window.event;

	  // Handle paste
	  if (theEvent.type === 'paste') {
	      key = event.clipboardData.getData('text/plain');
	     
	  } else {
	  // Handle key press
	      var key = theEvent.keyCode || theEvent.which;
	      key = String.fromCharCode(key);
	  }
	  var regex = /[0-9]/;
	
	  if( !regex.test(key) ) {
		  if (key.length > 2) {
		        limitField.value = limitField.value.substring(0, limitNum);
		    }
		  document.getElementById('mktWeek').value="";
	    theEvent.returnValue = false;
	    if(theEvent.preventDefault) theEvent.preventDefault();
	  }
	  else{
		  if (key.length > 2) {
			  document.getElementById('mktWeek').value="";
			  theEvent.returnValue = false;
		    }
		 
	  }
	}
</script>




  
</body>

</c:when>
<c:otherwise>
    <html>
        <body onload="window.top.location.href='homepage.jsp'">
        </body>
            
        </body>
    </html>
</c:otherwise>
</c:choose>