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
		    <h3>IT Queries
		    <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a></h3>      
		  </div> 				
 		  <div class="row">
 		   <div class="col-sm-3">
		    <div class="card">
		      <div class="card-body">
		        <h6 class="card-title">Division Performance</h6>
		        <form id="myDownloadServlet" action="DownloadQueries" method="post">	
			        <input type="hidden" id="fileName" name = 'fileName' value="DivisionPerformance.docx" />
				    <input type="submit" id="btnDownload" name="btnDownload" class="btn btn-sm btn-success" value="Download" />	 
			    </form>			       
		      </div>
		    </div>
		   </div>
 		   <div class="col-sm-3">
			    <div class="card">
			      <div class="card-body">
			        <h6 class="card-title">SubDivision Performance</h6>			       
			         <form id="myDownloadServlet" action="DownloadQueries" method="post">	
				        <input type="hidden" id="fileName" name = 'fileName' value="SubDivisionPerformance.docx" />
					    <input type="submit" id="btnDownload" name="btnDownload" class="btn btn-sm btn-success" value="Download" />	
				    </form>
			      </div>
			    </div>
			  </div>
			  <div class="col-sm-3">
			    <div class="card">
			      <div class="card-body">
			        <h6 class="card-title">Branch Performance</h6>
				      <form id="myDownloadServlet" action="DownloadQueries" method="post">
				        <input type="hidden" id="fileName" name = 'fileName' value="BranchPerformance.docx" />
						<input type="submit" id="btnDownload" name="btnDownload" class="btn btn-sm btn-success" value="Download" />
					 </form>
			      </div>
			    </div>
			  </div>
			  <div class="col-sm-3">
			    <div class="card">
			      <div class="card-body">
			        <h6 class="card-title">SalesManagerPerformance</h6>
			        <form id="myDownloadServlet" action="DownloadQueries" method="post">
				        <input type="hidden" id="fileName" name = 'fileName' value="SalesManagerPerformance.docx" />
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
				      <h6 class="card-title">SalesEngineerPerformance</h6>				      	        
				        <form id="myDownloadServlet" action="DownloadQueries" method="post">	
					        <input type="hidden" id="fileName" name = 'fileName' value="SalesEnginerPerformance.docx" />
							<input type="submit" id="btnDownload" name="btnDownload" class="btn btn-sm btn-success" value="Download" />
						</form>
				      </div>
				    </div>
			    </div>					  
			  <div class="col-sm-3">
			    <div class="card">
			      <div class="card-body">
			        <h6 class="card-title">STGFLWUP/WEEKLYRPT/PRJSTS</h6>
			        <form id="myDownloadServlet" action="DownloadQueries" method="post">	
				        <input type="hidden" id="fileName" name = 'fileName' value="STGFLWUP_WEEKLYRT.docx" />
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