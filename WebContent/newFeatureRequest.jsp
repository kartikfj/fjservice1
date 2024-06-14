<%-- 
    Document   : LOGISTIC DASHBOAR IMPORT P 
--%>
<%@page import="java.util.Calendar"%>
<%@include file="/logistic/header.jsp" %> 

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
 
 <c:choose>
 	<c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1 }">
 	 <jsp:useBean id="portalitprojects" class="beans.PortalITProjects" scope="request"/>
 	  <script src="resources/js/newFeaturreRequest.js?v=05052021v9"></script>
	  <c:set var="ITREQLIST" value="${portalitprojects.displayDefaultItProjects}"/>
  
 	 <style>
 	 .dtlsContent{  display:none; position:absolute; z-index:100;border:1px solid #020202; color:#000000; border-radius:5px;  background-color:#ffffff;  padding:5px;  top:22px; left:5px;}
     .hidden-content{display:none;} 
     .slid, th.slid>input{max-width:40px !important; width:40px !important; }    
     .dateFld, th.dateFld>input{max-width:75px !important; width:75px !important; }
     .cmnFld, th.cmnFld>input{max-width:max-content !important; width:60px !important; }  
     .textAreaFld, th.textAreaFld>input{max-width:80px !important; width:80px !important; }   
  /* table tr:FIRST-CHILD + tr + tr { display:none; } */
   .sm-bx-row{display: table;  border: 1px solid #607d8b;margin-top: -10px; table-layout: fixed; margin-bottom: 2px;margin-left:15px;}
   .sm-bx-col{display: table-cell; padding:3px 10px; color:#000 !important;text-transform:uppercase;font-weight:bold;border: 1px solid #607d8b; }
   .genStyl{background:#dfe3f0;}
    /*tr.filters>th{background: white; color: #000 !important;}*/
	.divnStyl{background-color: #ffeb3b54; color: #000000 !important;}
	.divnStyltd{background-color: white;width:30px !important;}
	.dtlsHeader:hover span.dtlsContent, .dtlsHeader:hover span.lg_dtlsContent{
		 display:block;   width: 250px;  word-wrap: break-word;white-space: normal
		 }
	 </style>
	    <%  java.util.Date start_dt = ((beans.CompParam) request.getSession().getAttribute("cmp_param")).getCurrentProcMonthStartDate();
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(start_dt);
            int month = calendar.get(Calendar.MONTH);
            int day = calendar.get(Calendar.DAY_OF_MONTH);
            int year = calendar.get(Calendar.YEAR);

        %>
       
 		<%@page import="com.google.gson.Gson"%>	 
 		<c:set var="controller" value="PortalITProjects" scope="page" /> 	
 		<jsp:useBean id="now" class="java.util.Date" scope="request"/> 
 		<fmt:formatDate var="currentDate" value="${now}" pattern="dd/mm/yyyy" scope="page" /> 
 		<c:set  value="${fjtuser.uname}" var="empName" scope="page" />	
 		<c:set value="FJ-New Feature Request" var="topHeaderFullName" scope="page" />
  		<c:set value="N" var="topHeaderShortName" scope="page" />
  		<c:set value="Portal IT Projects" var="contentTitle" scope="page" />
  		<c:set value="" var="dashboardFullName" scope="page" /> 
  		<c:set value="" var="currentPortalName" scope="page" />
	
<c:if test="${pageContext.request.method eq 'POST' and param.update eq 'DV'}"> 
	<jsp:setProperty name="portalitprojects" property="division" param="division"/>
	<jsp:setProperty name="portalitprojects" property="requestedBy" param="requestedBy"/> 
	<jsp:setProperty name="portalitprojects" property="project" param="project"/>
	<jsp:setProperty name="portalitprojects" property="usedBy" param="usedBy"/>
	<jsp:setProperty name="portalitprojects" property="priority" param="priority"/>
	<jsp:setProperty name="portalitprojects" property="monthlySavings" param="saving"/>	
	<jsp:setProperty name="portalitprojects" property="remarksbydiv" param="remarksbydiv"/>	
	<jsp:setProperty name="portalitprojects" property="createdBy" value="${fjtuser.emp_code}"/>			
	<c:set var="appstatus" value="${portalitprojects.updateProjectRequestByDivision}"/>
	<c:set var="ITREQLIST" value="${portalitprojects.displayDefaultItProjects}"/>
</c:if>	
<c:if test="${pageContext.request.method eq 'POST' and param.update eq 'IT'}">
	<jsp:setProperty name="portalitprojects" property="id" param="edit_${request.id}"/>
	<jsp:setProperty name="portalitprojects" property="approxComplDateStr" param="approxComplDate"/>
	<jsp:setProperty name="portalitprojects" property="outSrcCost" param="outSrcCost"/> 
	<jsp:setProperty name="portalitprojects" property="status" param="status"/>
	<jsp:setProperty name="portalitprojects" property="remarks" param="remarks"/>
	<jsp:setProperty name="portalitprojects" property="id" param="serialNo"/>	
	<jsp:setProperty name="portalitprojects" property="updatedBy" value="${fjtuser.emp_code}"/>			
	<c:set var="appstatus" value="${portalitprojects.updateProjectRequestByIT}"/>
	<c:set var="ITREQLIST" value="${portalitprojects.displayDefaultItProjects}"/>
</c:if>
<c:if test="${pageContext.request.method eq 'POST' and param.update eq 'FB'}">	
	<jsp:setProperty name="portalitprojects" property="id" param="id"/>	
	<jsp:setProperty name="portalitprojects" property="feedback" param="feedback"/>			
	<c:set var="appstatus" value="${portalitprojects.updateFeedback}"/>
	<c:set var="ITREQLIST" value="${portalitprojects.displayDefaultItProjects}"/>
</c:if>
 	<body class="hold-transition skin-blue sidebar-mini sidebar-collapse sidebar-mini">
 		<div class="wrapper">
		 <%@include file="/logistic/dashboardHeader.jsp" %> 
		
  	 <!-- Left side column. contains the logo and sidebar -->


	  <!-- Content Wrapper. Contains page content -->
	  <div class="content-wrapper" style="min-height: 760px;">
	    <%@include file="/logistic/contentHeader.jsp" %> 
	    	    
	    <!-- Main content -->	    
		    <%--Field Staff Home Section Start--%>
		    <section class="content" style="height: 80%;">
		    <c:set var="rqstscount" value="0" scope="page" />  	     
		    <%-- TABLUAR DETAILS START --%>
		   <div class="row small">
	        <div class="col-xs-12">
	          <div class="box box-primary justify-content-center">
 
	          <button class="btn btn-xs btn-danger" id="exportPo" onClick="getPortalITRequests()"><i class="fa fa-file-excel-o"></i> Export</button>
	            <!-- /.box-header -->  
	            
	             	<div align="left" style="margin-bottom:5px;margin-left:15px;">
			    		<button type="button" name="add" id="newVst" class="btn btn-success btn-xs"  data-toggle="modal" data-target="#modal-division-update" ><i class="fa fa-plus" > </i>New Request</button>
			   		</div>	               
			   		<!--  <input type="button" id="newReq" value="New Request" class="genStyl sm-bx-col" />	
	                 <div class="genStyl sm-bx-col">New Request</div>		
	                <input type="button" value="Update by IT" class="genStyl sm-bx-col" />	    
				    <!--  <div class="divnStyl  sm-bx-col">UPDATE by IT</div>-->
			
	            <div class="box-body table-responsive  padding" style="/*display:flex;*/">
	         
	              <table class="table table-bordered small bordered display nowrap"  id="displayPos">
	                <thead>
		                <tr>
		                  <th class="slid">SL. No.</th> 	              
		                  <th class="cmnFld">Division</th> 
		                  <th class="cmnFld">Requested By</th>
		                   <th class="cmnFld">Requested On</th>
		                  <th class="cmnFld">Project</th>
		                  <th class="cmnFld">Applicable <br/> (or) <br/>Useful</th>
		                  <th class="cmnFld">Priority</th>
		                  <th class="cmnFld">Saving<br/>(Monthly)</th>	
		                  <th class="cmnFld">Remarks <br/>By Division</th>
		                  <th class="divnStyl cmnFld">Update<br/> by IT</th>	                  
		                  <th class="dateFld divnStyl">Approx date to<br/> complete <br/></th>
		                  <th class="divnStyl cmnFld">Outsource cost</th>
		                  <th class="divnStyl cmnFld">Status</th>
		                  <th class="divnStyl cmnFld">Remarks<br/> By IT</th> 
				          <th class="divnStyl cmnFld">Feedback</th>					                         
		                </tr>
		               
	                </thead>
	                <tbody>
	                 <c:forEach var="request" items="${ITREQLIST}" >
	                <c:set var="rqstscount" value="${rqstscount + 1}" scope="page" />
	                <tr>
	                 		<td class="slid"  id="${request.id}">${rqstscount}</td>	                  	                   
	                 		<td class="divnStyltd dtlsHeader"> ${fn:substring(request.division, 0, 7)}<c:if test="${!empty request.division}">..<span class="dtlsContent" >${request.division}</span></c:if></td>	                 		
	                        <td class="divnStyltd dtlsHeader"> ${fn:substring(request.requestedBy, 0, 9)}<c:if test="${!empty request.requestedBy}"><span class="dtlsContent" >${request.requestedBy}</span></c:if></td> 
	                          <td class="dateFld cmnFld"> 
		                  		<fmt:parseDate value="${request.createdOn}" var="theRequestedDate"  dateStyle="short"   pattern="yyyy-MM-dd" />
		                  		<fmt:formatDate value="${theRequestedDate}" pattern="dd/MM/yyyy"/>		                  		
	                		  </td> 
	                 	  	 <td class="divnStyltd dtlsHeader"> ${fn:substring(request.project, 0, 30)}<c:if test="${!empty request.project}">..<span class="dtlsContent" >${request.project}</span></c:if></td>
	                 	  	 <td class="divnStyltd"> ${request.usedBy}</td>
	                 	  	 <td class="divnStyltd"> ${request.priority}</td>
	                 	  	 <td class="divnStyltd"> ${request.monthlySavings}</td> 
	                 	  	 <td class="divnStyltd dtlsHeader"> ${fn:substring(request.remarksbydiv, 0, 30)}<c:if test="${!empty request.remarksbydiv}">..<span class="dtlsContent" >${request.remarksbydiv}</span></c:if></td>
	                 	  	 <c:choose>
				                 <c:when test="${fjtuser.emp_divn_code eq 'IT' and request.itStatus == 0}"> 
				                 	 <td>
				                 		<button type="button" name="edit" id="${request.id}" class="btn btn-success btn-xs"  data-toggle="modal" data-target="#modal-it-update" onclick="setSerialNo(${request.id},'${request.outSrcCost}','${request.status}','','${request.approxComplDate}')">Update</button>
				                 	</td>
			                    </c:when>
			                    <c:otherwise>
			                   		<td class="divnStyltd cmnFld">${request.updatedBy}</td>
			                    </c:otherwise>
		                  	</c:choose>	
	                 	  	  <td class="dateFld cmnFld"> 
		                  		<fmt:parseDate value="${request.approxComplDate}" var="theapproxComplDate"  dateStyle="short"   pattern="yyyy-MM-dd" />
		                  		<fmt:formatDate value="${theapproxComplDate}" pattern="dd/MM/yyyy"/>		                  		
	                		  </td> 
			                 <td class="divnStyltd cmnFld">${request.outSrcCost}</td>
			                 <td class="divnStyltd cmnFld">${request.status}</td>
			                 <td class="divnStyltd cmnFld dtlsHeader" id='remarks_${request.id}' data-full-remarks="${request.remarks}"> ${fn:substring(request.remarks, 0, 30)}<c:if test="${!empty request.remarks}">..<span class="dtlsContent" >${request.remarks}</span></c:if></td>			                
		                   <c:choose>
				                 <c:when test="${request.divisionStatus == 1 and request.itStatus == 1 and empty(request.feedback)}"> 
				                 	<td>
				                 		<button type="button" name="feedback" id="${request.id}" class="btn btn-success btn-xs"  data-toggle="modal" data-target="#modal-feedbcak-update" onclick="setSerialNo(${request.id})">Feedback</button>
				                 	</td>
				                 </c:when>
				                 <c:otherwise>
			                   		<td class="divnStyltd cmnFld">${request.feedback}</td>
			                    </c:otherwise>
				           </c:choose>
	                </tr>
	               </c:forEach>      
	                </tbody>
	              </table>
	              <div id="exclData" style="display:none;"></div>
	            </div>
	            <!-- /.box-body -->
	          </div>
	          <!-- /.box -->
	        </div>
	      </div>
		  <%-- TABULAR DETAILS END --%> 
		    </section>
		    <%--Field Staff Home Section End --%>	        
	    <div id="laoding" class="loader" style="display:none;" ><img src="././resources/images/wait.gif"></div> 
	    <!-- /.content -->
	   </div>   
  	<!-- /.content-wrapper -->
	<%@include file="/logistic/footer.jsp" %> 
	<!-- page script start -->
	</div>
	                         



	<form  method="POST" id="requestform"   action="newFeatureRequest.jsp"  class="seg-reg-form">
	  <div class="modal fade" id="modal-division-update"  data-backdrop="static" data-keyboard="false">
          <div class="modal-dialog modal-lg"  >
            <div class="modal-content">
              <div class="modal-header">
		        <h5 class="modal-title">New Request Form</h5>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
              <div class="modal-body"> 	  		 
			        <!--  Process - 1 -->
			        <div class="row" id="vst-entry-block">
			            <div class=" col-md-12 col-xs-12" id="errMsg"></div>
					        <div class="col-md-12 col-xs-12 form-inline">	
					        <div class="l_one">				           
					          <div class="input-group  pull-left" style="width:30%" >	 
								 <label><i class="fa fa-comments mr-1 text-info" aria-hidden="true"></i>Division</label> 
					             <input type="text" class="form-control"    id="division"  name="division" value=""  onkeypress="clearErrorMessage()" required/> 
					           </div>							
					        <!--   <div class="form-group  col-sm-6 col-md-6 col-xs-12" style="padding-top:5px;">  -->
								 <div class="input-group  pull-right"  style="padding-right:5%;width:30%">	 
									 <label><i class="fa fa-comments mr-1 text-info" aria-hidden="true"></i>Requested By</label> 
						             <input type="text" class="form-control"    id="requestedBy"  name="requestedBy" value=""  onkeypress="clearErrorMessage()" required/> 
				           <!--   </div> -->
               			    	</div>   
               			    	</div>  
               			  <!--  <div class="form-group  col-sm-6 col-md-6 col-xs-12" style="padding-top:5px;"> --> 
							
               			 <!--    </div>  -->
               			       <div class="l_one">
	               			 	<div class="input-group pull-left" style="width:30%" >
						         	<label><i class="fa fa-comments mr-1 text-info" aria-hidden="true"></i>Applicable</label>
						              <select class="form-control select2 input-xs" id="usedBy" name="usedBy" required>
						                <option value="">Select</option>					                
					                    <option value="Division" class="">Division</option>
					                    <option value="Group" class="">Group</option>
						              </select>
						          </div> 
						          <div class="input-group pull-center" style="padding-left:5%;width:25%">
						         	 <label><i class="fa fa-comments mr-1 text-info" aria-hidden="true"></i>Priority</label>
						              <select class="form-control select2 input-xs" id="priority" name="priority" required>
						                <option value="">Select</option>					                
					                    <option value="Must" class="">Must</option>
					                    <option value="Good to have" class="">Good to have</option>
						              </select>
					        	 </div>  
								<div class="input-group  pull-right" style="padding-right:5%;width:30%">	 
									 <label><i class="fa fa-comments mr-1 text-info" aria-hidden="true"></i>Saving(Monthly)</label> 
						             <input type="text" class="form-control" name="saving" id="saving" value=""  onkeypress="clearErrorMessage()" required/> 
					             </div>
               			      </div> 
					         <div class="input-group  pull-left" style="width:95%" >	 
								 <label><i class="fa fa-comments mr-1 text-info" aria-hidden="true"></i>Project</label> 
					             <textarea  class="form-control" rows="3" placeholder="Enter Description..."  name="project" id="project"  onkeypress="clearErrorMessage()" required></textarea> 
				             </div> 
				            
					            <div class="input-group  pull-left" style="width:95%">	 
								 <label><i class="fa fa-comments mr-1 text-info" aria-hidden="true"></i>Remarks</label> 
					             <textarea class="form-control" rows="3" name="remarksbydiv" id="remarksbydiv" onkeypress="clearErrorMessage()" required></textarea> 
					           </div>  
					         
					       </div> 	        					       
					 
					    </div>  			                
			         </div>                
		               <div class="modal-footer">    
		              	  <input type="hidden" name="update" id="update" value="DV"/>          
			              	<button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Close</button>	
			              <input type="submit" name ="save" class="btn btn-primary pull-right"/>
		              </div>
            </div>
            <!-- /.modal-content -->
          </div>        
          <!-- /.modal-dialog -->         
        </div>
        </form>
        <form  method="POST" id="requestitform"   action="newFeatureRequest.jsp"  class="seg-reg-form">
        <div class="modal fade" id="modal-it-update"  data-backdrop="static" data-keyboard="false">
          <div class="modal-dialog modal-lg"  >
            <div class="modal-content">
              <div class="modal-header">
		        <h5 class="modal-title">Update by IT Team</h5>
		        <button type="button" class="close" data-dismiss="modal">&times;</button>
		      </div>
              <div class="modal-body"> 	  		 
			        <!--  Process - 1 -->
			        <div class="row" id="vst-entry-block">
			         		<div class=" col-md-12 col-xs-12" id="errMsg"></div>
					        <div class="col-md-12 col-xs-12 form-inline">
					        <div class="l_one">	
						        <div class="input-group  pull-left" style="width:35%">	
	                           	  <label><i class="fa fa-comments mr-1 text-info" aria-hidden="true"></i>Approx Date to complete</label> 
	                                  <input type="text" id="datepicker-13" class="select_box2" name="approxComplDate" autocomplete="off" value="${param.fromdate}"  required="required">
	                              </div>		
	                              <div class="input-group  pull-left">	 
								    <label><i class="fa fa-comments mr-1 text-info" aria-hidden="true"></i>Status</label>
						              <select class="form-control select2 input-xs" id="status" name="status" required>
						                <option value="">Select</option>					                
					                    <option value="Done" class="">Done</option>
					                    <option value="WIP" class="">WIP</option>
					                    <option value="Yet to start" class="">Yet to start</option>
					                    <option value="Cancelled" class="">Cancelled</option>
						              </select>
						          </div>			         
						       <!-- <div class="form-group  col-sm-6 col-md-6 col-xs-12" style="padding-top:5px;left:-12px;">  -->
								 <div class="input-group  pull-right">	  
								 <label><i class="fa fa-comments mr-1 text-info" aria-hidden="true"></i>Out Source Cost(If needed)</label> 
					             <input type="text" class="form-control"  style="width:75%" id="outSrcCost"  name="outSrcCost" value=""  onkeypress="clearErrorMessage()" required/> 
					             </div>
				             </div> 
               			    <!-- </div>   
               			   <div class="form-group  col-sm-6 col-md-6 col-xs-12" style="padding-top:5px;left:-12px;">  -->  
							
               			    <div class="input-group pull-left" style="width:90%">	 
							 <label><i class="fa fa-comments mr-1 text-info" aria-hidden="true"></i>Remarks by IT</label> 
				             <textarea class="form-control"  rows="3" placeholder="Enter Description..."  name="remarks" id="remarks" style="width:100%"  maxlength="300" wrap="hard" onkeypress="clearErrorMessage()" required></textarea>
               			    </div> 
					       </div>
					    </div>  			                
			         </div>                
              <div class="modal-footer"> 
                   <input type="hidden" name="update" id="update" value="IT"/>
                   <input type="hidden" name="serialNo" id="serialNo" value="IT"/>              
	              <button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Close</button>	
	              <input type="submit" name ="save" value="Save" class="btn btn-primary pull-right"/>
              </div>
            </div>
            <!-- /.modal-content -->
          </div>        
          <!-- /.modal-dialog -->         
        </div>
     </form>
     <form  method="POST" id="requestform"   action="newFeatureRequest.jsp"  class="seg-reg-form">
	  <div class="modal fade" id="modal-feedbcak-update"  data-backdrop="static" data-keyboard="false">
          <div class="modal-dialog modal-lg"  >
            <div class="modal-content">             
              <div class="modal-body"> 	  		 
			        <!--  Process - 1 -->
			        <div class="row" id="vst-entry-block">
			            <div class=" col-md-12 col-xs-12" id="errMsg"></div>
					        <div class="col-md-12 col-xs-12 form-inline">	
					            <div class="input-group  pull-left" style="width:90%">	 
								 <label><i class="fa fa-comments mr-1 text-info" aria-hidden="true"></i>Feedback</label> 
					             <input type="text" class="form-control" name="feedback" id="feedback" onkeypress="clearErrorMessage()" required></input> 
					           </div>  
					         
					       </div> 	        					       
					 
					    </div>  			                
			         </div>                
		               <div class="modal-footer">    
		              	  <input type="hidden" name="update" id="update" value="FB"/>  
		              	  <input type="hidden" name="id" id="id" value=""/>         
			              	<button type="button" class="btn btn-danger pull-left" data-dismiss="modal">Close</button>	
			              <input type="submit" name ="save" class="btn btn-primary pull-right"/>
		              </div>
            </div>
            <!-- /.modal-content -->
          </div>        
          <!-- /.modal-dialog -->         
        </div>
        </form>
<script>
var _url = 'PortalITProjects';
var _method = "POST";
var poList = <%=new Gson().toJson(request.getAttribute("ITREQLIST"))%>;  
var exportTable = "<table class='table' id='exclexprtTble'><thead>"; 
var table;
$(function(){ 
	 $('.loader').hide();	 
	 $(".approxComplDate").datepicker({ "dateFormat" : "dd/mm/yyyy", yearRange: "2019:2030", minDate : -7});
	 //$("#todate").datepicker({"dateFormat" : "dd/mm/yy",maxDate : 0 });
	  $('#displayPos thead tr')
      .clone(true)
      .addClass('filters')
      .appendTo('#displayPos thead');
	 $('#displayPos').DataTable({  
	        'paging'      : true,
	        'lengthChange': false,
	        'searching'   : true,
	        'ordering'    : true,
	        'info'        : false,
	        "lengthMenu": [[20, 25, 50, -1], [10, 25, 50, "All"]],
	        //"columnDefs" : [{"targets":[2, 8, 15, 16], "type":"date-eu"}], 
	          responsive: true,
	    	  orderCellsTop: true,
	          fixedHeader: true, 

		        'autoWidth'   : false,
	    	 initComplete: function () {
 	            var api = this.api();
 	 	console.log("api :"+api)
 	            // For each column
 	            api
 	                .columns()
 	                .eq(0)
 	                .each(function (colIdx) {
 	                	 console.log("colIdx "+colIdx);
 	                	 
 	                    // Set the header cell to contain the input element
 	                    var cell = $('.filters th').eq(
 	                        $(api.column(colIdx).header()).index()
 	                    );
 	                    
 	                 /*   if( colIdx == 12 ) {
 	                	  $(cell).hide();
	                		 return;
	                	 } */
 	                    
 	                    var title = $(cell).text();
 	                    console.log("title "+title);
 	                   // if( title != "update by IT") {
 	                    	$(cell).html('<input type="text" placeholder="' + title + '" />');	
 	                    //}
 	                    
 	 
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
	 
	 exportTable += "<tr><th>Division</th> <th >Requested By</th><th >Requested On</th><th>Project</th><th>Applicable or Useful</th> <th>Priority</th> <th>Savings(Monthly)</th>  <th>Remarks</th>"+
	 "<th>Approx date to Complete</th> <th>OutSource Cost</th>  <th>Status</th>  <th>Remarks</th><th>Updated By</th>"+
	 "</tr></thead><tbody>";	 
	 poList.map(item =>{
		 exportTable +="<tr>";
		 exportTable +="<td>"+checkValidOrNot(item.division)+"</td><td>"+checkValidOrNot(item.requestedBy)+"</td><td>"+checkValidOrNotDate(item.createdOn)+"</td><td>"+checkValidOrNotDate(item.project)+"</td><td>"+checkValidOrNot(item.usedBy)+"</td><td>"+checkValidOrNot(item.priority)+"</td><td>"+checkValidOrNot(item.monthlySavings)+"</td><td>"+checkValidOrNot(item.feedback)+"</td>"; 
		 exportTable +="<td>"+checkValidOrNotDate(item.approxComplDate)+"</td><td>"+checkValidOrNotDate(item.outSrcCost)+"</td><td>"+checkValidOrNot(item.status)+"</td><td>"+checkValidOrNot(item.remarks)+"</td><td>"+checkValidOrNot(item.updatedBy)+"</td>"; 
		 exportTable +="</tr>";
	 });
	 exportTable +="</tbody></table>";  
	 $("#exclData").html(exportTable);    
	 table = $('#exclexprtTble').DataTable({   dom: 'Bfrtip',  
		   buttons: [{ extend: 'excelHtml5', text:      '<i class="fa fa-file-excel-o" style="color: #fff; font-size: 1.5em;">Download</i>', filename: 'PORTAL IT PROJECTS REPORT - ${currCal}',
		   title: 'PORTAL IT PROJECTS REPORT- ${currCal}', messageTop: 'The information in this file is copyright to FJ-Group.'}]
	} ); 
	
	 $("#exportPo").on("click", function() {
		   // table.button( '.dt-button' ).trigger();
		});
});
$(function () {      
	//var date = new Date(); 
	//date. setDate(date. getDate() - 10);                 	        	
	 $("#datepicker-13").datepicker({minDate:0, maxDate: '+1Y', dateFormat: 'dd/mm/yy'});
});
function clearErrorMessage(){	
	$('#errMsg').html("");    
}
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
 function divisionUpdateBox(){
	 $('#modal-division-update').css( { display:''});
 }
 function setSerialNo(id,outsourcecost,status,remarks,date){
	 document.getElementById('serialNo').value = id;
	 document.getElementById('id').value = id;
	 let format1;
	 if(date != null && date != '' && date != 'undefined'){
		 var datee = new Date(date);	
		 var day= datee.getDate();
		 var month = (datee.getMonth()+1);
		 if (day < 10) {
			    day = '0' + day;
			}

			if (month < 10) {
			    month = '0'+ month;
			}
			format1 = day + "/" + month + "/" + datee.getFullYear();
	 }
	

	 
	 $("#modal-it-update .modal-body #datepicker-13").val(format1);
	 $("#modal-it-update .modal-body #status").val(status);
	 $("#modal-it-update .modal-body #outSrcCost").val(outsourcecost);
	 var remarksElement = $("#remarks_" + id);
	 var fullRemarks = remarksElement.data('full-remarks');
	 //var remarks = $("#remarks_"+id).text();
	 
	 $("#modal-it-update .modal-body #remarks").val(fullRemarks);	 
	 } 
  
 //-- By Nufail for company code Start -->          

$(document).ready(function() { 
	$( "#datepicker-13" ).datepicker();	
    // console.log(companyCode+" "+calCode+" "+hr22LvPolicy);
 });
function clearErrorMessage(){	
	$('#errMsg').html("");    
}

function getPortalITRequests(){ 	
	// var title = "PORTAL IT PROJECTS REPORT ";
		var output ="";
			 $.ajax({
	    		 type: _method,
	        	 url: _url, 
	        	 data: {action: "export"},
	         success: function(data) {
	        	 $('#laoding').hide();
	        	 var output="<table id='exclexprtTble' class='table'><thead><tr>"+"<th>Division</th> <th >Requested By</th><th >Requested On</th><th>Project</th><th>Applicable or Useful</th> <th>Priority</th> <th>Savings(Monthly)</th>  <th>Remarks By Division</th>"+
	        	 "<th>Approx date to Complete</th> <th>OutSource Cost</th>  <th>Status</th>  <th>Remarks By IT</th><th>Updated By</th><th>Feedback</th>"+
	        	 "</tr></thead><tbody>";
	        	 var j=0; 
	        	 for (var i in data) {
	        		 j=j+1;
	        	output+="<tr><td>" + $.trim(data[i].division) + "</td>"+ "<td>" + $.trim( data[i].requestedBy ) + "</td>"+ "<td>" + checkValidOrNotDate($.trim( data[i].createdOn)) + "</td>"+"<td>" + $.trim( data[i].project ) + "</td>"+
		        	 "<td>" + $.trim( data[i].usedBy ) + "</td><td>" + $.trim(data[i].priority) + "</td>"+ "<td>" + $.trim(data[i].monthlySavings )+ "</td><td>" + $.trim(data[i].remarksbydiv) + "</td>"+
		        	 "<td>" + checkValidOrNotDate($.trim(data[i].approxComplDate)) + "</td><td>" + $.trim(data[i].outSrcCost) +"</td><td>"+ $.trim(data[i].status) +"</td><td>" + $.trim(data[i].remarks) +"</td><td>" + $.trim(data[i].updatedBy) + "</td><td>" + $.trim(data[i].feedback) + "</td></tr>"; 
	        	 }          	
	        	 output+="</tbody></table>";
	        	 $("#exclData").html(output); 
	             table = $('#exclexprtTble').DataTable({   dom: 'Bfrtip',  
	      		   buttons: [{ extend: 'excelHtml5', text:      '<i class="fa fa-file-excel-o" style="color: #fff; font-size: 1.5em;">Download</i>', filename: 'PORTAL IT PROJECTS REPORT - ${currCal}',
	      		   title: 'PORTAL IT PROJECTS REPORT- ${currCal}', messageTop: 'The information in this file is copyright to FJ-Group.'}]
	      		} ); 
	             table.button( '.dt-button' ).trigger();
	         },error:function(data,status,er) { 
	        	 $('#laoding').hide();
	        	 alert("Please refresh the page!."); 
	        	 
	        	 }
	       });
		 	
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