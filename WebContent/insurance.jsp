<%-- 
    Document   : Insurance
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
.navbar {margin-bottom: 8px !important;}
</style>
<%@include file="mainview.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html><head>
<style> 
.row { margin-left: 0px;margin-right: 0px;}.panel-body { padding: 10px;}.panel-heading { padding: 5px 10px !important;}.panel {  margin-bottom: 5px; }.panel-default>.panel-heading{color: #333;background-color: #fff;   border-color: #065685; }
.navbar-brand {  padding: 0px;}.navbar-brand>img {height: 100%;width: auto;}
#main-div{margin-top: -10px !important;}.card{letter-spacing: 0.1em;background-image: linear-gradient(45deg, #065685 0%, #bac9d6 100%); color: #fff;padding: 14px; border-radius: 5px;margin-bottom:5px;}
.card .card-title{font-weight: bold; text-transform: uppercase;}.page-header{letter-spacing: 0.1em;padding-bottom: 5px !important; margin: 5px 0 5px !important;border-bottom: 1px solid #607D8B !important;}
</style>
    </head>
    <c:choose>
	<c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1}">
  	<body>
 		<div class="container" id="main-div">
 		
 		 <div class="page-header">
		    <h3>Medical Insurance - 2023-2024
		    <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a></h3>      
		  </div> 				
 		  <div class="row">
 		   <div class="col-sm-3">
		    <div class="card">
		      <div class="card-body">
		        <h5 class="card-title">Category- A+ </h5>
		        <p class="card-text">Cat-A GN+ Network List</p>
		        <form id="myDownloadServlet" action="downloadInsDocs" method="post">	
			        <input type="hidden" id="fileName" name = 'fileName' value="GN+ Member's Access UAE March -CAT A+.xlsx" />
				    <input type="submit" id="btnDownload" name="btnDownload" class="btn btn-sm btn-success" value="Download" />	 
			    </form>			       
		      </div>
		    </div>
		   </div>
 		   <div class="col-sm-3">
			    <div class="card">
			      <div class="card-body">
			        <h5 class="card-title">Category- A</h5>
			        <p class="card-text">Cat-A GN Network List</p>
			         <form id="myDownloadServlet" action="downloadInsDocs" method="post">	
				        <input type="hidden" id="fileName" name = 'fileName' value="GN Member's Access UAE March -CAT A.xlsx" />
					    <input type="submit" id="btnDownload" name="btnDownload" class="btn btn-sm btn-success" value="Download" />	
				    </form>
			      </div>
			    </div>
			  </div>
			  <div class="col-sm-3">
			    <div class="card">
			      <div class="card-body">
			        <h5 class="card-title">Category-B </h5>
			        <p class="card-text">Cat-B RN2 Network List</p>
				      <form id="myDownloadServlet" action="downloadInsDocs" method="post">
				        <input type="hidden" id="fileName" name = 'fileName' value="RN2 Member's Access UAE March -CAT B.xlsx" />
						<input type="submit" id="btnDownload" name="btnDownload" class="btn btn-sm btn-success" value="Download" />
					 </form>
			      </div>
			    </div>
			  </div>
			  <div class="col-sm-3">
			    <div class="card">
			      <div class="card-body">
			        <h5 class="card-title">Category-C </h5>
			        <p class="card-text">Cat-C RN3 Network List</p>
			        <form id="myDownloadServlet" action="downloadInsDocs" method="post">
				        <input type="hidden" id="fileName" name = 'fileName' value="RN3 Member's Access UAE March -CAT C.xlsx" />
						<input type="submit" id="btnDownload" name="btnDownload" class="btn btn-sm btn-success" value="Download" />
					</form>
			      </div>
			    </div>
			  </div>
			</div>
			
		  <div class="row">	
		       <div class="col-sm-3">
				    <div class="card">
				      <div class="card-body">
				        <h5 class="card-text">Labor's Medical Insurance</h5>
				         <p class="card-text">Network List for Workers</p> 
				        <form id="myDownloadServlet" action="downloadInsDocs" method="post">	
					        <input type="hidden" id="fileName" name = 'fileName' value="FMC NETWORK UAE STANDARD NETWORK LIST - APRIL 2024.xlsx" />
							<input type="submit" id="btnDownload" name="btnDownload" class="btn btn-sm btn-success" value="Download" />
						</form>
				      </div>
				    </div>
			    </div>					  
			  <div class="col-sm-3">
			    <div class="card">
			      <div class="card-body">
			        <h5 class="card-title">Category-D </h5>
			        <p class="card-text">Cat-D PCP Network List</p>
			        <form id="myDownloadServlet" action="downloadInsDocs" method="post">	
				        <input type="hidden" id="fileName" name = 'fileName' value="PCP Member's Access UAE October 2022.xlsx" />
						<input type="submit" id="btnDownload" name="btnDownload" class="btn btn-sm btn-success" value="Download" />
					</form>
			      </div>
			    </div>
			  </div>
			  <div class="col-sm-3">
			    <div class="card">
			      <div class="card-body">
			        <h5 class="card-title">Category- A+,A Benefits </h5>
			        <p class="card-text">Cat-A+, A table of benefits.</p>
			        <form id="myDownloadServlet" action="downloadInsDocs" method="post">	
				        <input type="hidden" id="fileName" name = 'fileName' value="TOB - CAT A+ & CAT A.pdf" />
						<input type="submit" id="btnDownload" name="btnDownload" class="btn btn-sm btn-success" value="Download" />
					</form>
			      </div>
			    </div>
			  </div>	
			   <div class="col-sm-3">
			    <div class="card">
			      <div class="card-body">
			        <h5 class="card-title">Category- B, C Benefits </h5>
			        <p class="card-text">Cat-B, C  table of benefits.</p>
			        <form id="myDownloadServlet" action="downloadInsDocs" method="post">	
				        <input type="hidden" id="fileName" name = 'fileName' value="TOB - CAT B & CAT C.pdf" />
						<input type="submit" id="btnDownload" name="btnDownload" class="btn btn-sm btn-success" value="Download" />
					</form>
			      </div>
			    </div>
			  </div>  
		</div>
		<div class="row">	
		<div class="col-sm-3">
			    <div class="card">
			      <div class="card-body">
			        <h5 class="card-title">Category- D Benefits </h5>
			        <p class="card-text">Cat-D  table of benefits.</p>
				        <form id="myDownloadServlet" action="downloadInsDocs" method="post">
					        <input type="hidden" id="fileName" name = 'fileName' value="TOB - CAT D.pdf" />
							<input type="submit" id="btnDownload" name="btnDownload" class="btn btn-sm btn-success" value="Download" />
				         </form>			        
			      </div>
			    </div>
			  </div>					  
			  <div class="col-sm-3">
			    <div class="card">
			      <div class="card-body">
			        <h5 class="card-title">Category- A  Abu Dhabi </h5>
			         <p class="card-text">Cat-A Abu Dhabi benefits.</p>
				        <form id="myDownloadServlet" action="downloadInsDocs" method="post">	
					        <input type="hidden" id="fileName" name = 'fileName' value="TOB - CAT A- ABU DHABI POLICY.pdf" />
							<input type="submit" id="btnDownload" name="btnDownload" class="btn btn-sm btn-success" value="Download" />
						</form>
			      </div>
			    </div>
			  </div>
		  	  <div class="col-sm-3">
			    <div class="card">
			      <div class="card-body">
			        <h5 class="card-text">Labor's Medical Insurance </h5>
			         <p class="card-text">Table of benefits for workers.</p>
				        <form id="myDownloadServlet" action="downloadInsDocs" method="post">	
					        <input type="hidden" id="fileName" name = 'fileName' value="TOB - Faisal Jassim Trading Co LLC - 2024-2025.pdf" />
							<input type="submit" id="btnDownload" name="btnDownload" class="btn btn-sm btn-success" value="Download" />
						</form>
			      </div>
			    </div>
			  </div>
			  
			</div>
			
 		</div>
	</body>
	

	</c:when>
	<c:otherwise>
    <html>
        <body onload="window.top.location.href='logout.jsp'">
        </body>
            
        </body>
    </html>
	</c:otherwise>
	</c:choose>