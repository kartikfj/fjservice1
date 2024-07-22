<%-- 
    Document   : MARKETING LEAD
    Created on : January 10, 2019, 10:06:00 AM
    Author     : Nufail Achath
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
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
<%@page import = "java.util.Set"%>;
<%@page import = "java.util.Arrays"%>;
<%@page import = "java.util.HashSet"%>;
<%@page import = "java.util.List"%>;
<%@page import="com.google.gson.Gson"%>	
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
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title>Faisal Jassim Trading Co L L C</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="././resources/abc/style.css" rel="stylesheet" type="text/css" />
	<link href="././resources/abc/responsive.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="././resources/abc/bootstrap.min.css">
	<script src="././resources/abc/jquery.min.js"></script>
	<script src="././resources/abc/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"/>
	<script src="././resources/js/mainview.js"></script>
	<link href="././resources/css/multiple_product_list.css" rel="stylesheet" type="text/css" />
	<script src="././resources/js/multiple_product_list.js"></script>
    <link rel="stylesheet" href="././resources/bower_components/font-awesome/css/font-awesome.min.css">
    <link rel="stylesheet" href="././resources/dist/css/skins/_all-skins.min.css">
	<link rel="stylesheet" type="text/css" href="././resources/datatables/datatables-fjtco/css/jquery.dataTables.min.css" />
	<link rel="stylesheet" type="text/css" href="././resources/datatables/buttons-fjtco/css/buttons.dataTables.min.css" />
	<script type="text/javascript" src="././resources/datatables/datatables-fjtco/js/jquery.dataTables.min.js"></script>
	<script type="text/javascript" src="././resources/datatables/datatables-fjtco/js/dataTables.buttons.min.js"></script>
	<script type="text/javascript" src="././resources/datatables/buttons-fjtco/js/buttons.flash.min.js"></script>
	<script type="text/javascript" src="././resources/datatables/ajax/excelmake/jszip.min.js"></script>
	<script type="text/javascript" src="././resources/datatables/buttons-fjtco/js/buttons.html5.min.js"></script>
	<script type="text/javascript" src="././resources/datatables/buttons-fjtco/js/buttons.print.min.js"></script>
	
	<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.5/xlsx.full.min.js"></script>
	
 
  <!-- Theme style -->
  <link rel="stylesheet" href="././resources/dist/css/AdminLTE.min.css">
  <link rel="stylesheet" href="././resources/dist/css/skins/_all-skins.min.css">
   <link rel="stylesheet" href="././resources/css/mkt-layout.css?v=13032020">
 <style>
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
        .pagination {
            display: flex;
            list-style: none;
            padding: 0;
        }

        .pagination li {
            margin-right: 5px;
            cursor: pointer;
        }

        .active {
            font-weight: bold;
        }
        td {
      white-space: nowrap; /* Prevent text from wrapping to multiple lines */
      overflow: hidden; /* Hide overflowed content */
      text-overflow: ellipsis; /* Show ellipsis (...) for truncated text */
    }
    .tooltip-trigger {
    cursor: pointer; 
	}
	.highlight-firstrow {
    background-color: !important;color:#cd3f15 /* or any other color */
	}
	.highlight-secondrow {
    background-color: !important;color:blue /* or any other color */
	}
    
#fj-page-head{padding:4px 8px !important;color:#065685;margin-top:-20px;}
#fj-page-head-box{border: none;};
 .btn-group.open .dropdown-toggle {max-width: 180px !important;overflow: hidden  !important;}
  #nmlstforrprt .open>.dropdown-menu {display: block; max-height: 314px !important;overflow-y: scroll;}
</style>

</head>
<body class="hold-transition skin-blue sidebar-mini">
 <c:if test="${empty fjtuser.emp_code}"> <jsp:forward page="index.jsp"/> </c:if>
 <c:choose>
 <c:when test="${!empty fjtuser.emp_code and ( fjtuser.role eq 'mkt' or fjtuser.role eq 'mg' or fjtuser.sales_code ne null ) and fjtuser.checkValidSession eq 1  }">
 	<sql:query var="service" dataSource="jdbc/orclfjtcolocal">
				SELECT USER_TYPE, DIVN_CODE FROM FJPORTAL.MARKETING_SALES_USERS WHERE  EMPID = ?  AND ROWNUM = 1
			<sql:param value="${fjtuser.emp_code}"/>
 	</sql:query>
<div class="wrapper">

  <header class="main-header">
    <!-- Logo -->
    <a href="index2.html" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>FJ</b>M</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg">
          <img src="././resources/images/logo_t5.jpg" height="49px" class="img-circle pull-left"  alt="Logo"><b>Marketing</b>
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
      <!-- search form -->
       <form method="POST" action="ConsultantLeads" class="sidebar-form">
        <div class="input-group">
          <input type="text" class="form-control" placeholder="Search by consultant..." name="srch-term" id="srch-term" type="text" required>
          <input type="hidden" name="octjf" value="sbcnfpdw"/>
          <span class="input-group-btn">
                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                </button>
              </span>
        </div>
      </form>
      <!-- /.search form -->
      <!-- sidebar menu: : style can be found in sidebar.less -->
      <ul class="sidebar-menu" data-widget="tree">
         <c:if test="${fjtuser.emp_code eq 'E004272' || fjtuser.emp_code eq 'E003066'}">
	         <li><a href="MktDashboard"><i class="fa fa-dashboard"></i><span>Dashboard - Sales Leads</span></a></li>
	         <li ><a href="SalesLeads"><i class="fa fa-pie-chart"></i><span>Sales Leads Details</span></a></li>
         </c:if>
          <c:if test="${!empty service.rows}">  
         	<li><a href="SupportRequest"><i class="fa fa-table"></i><span> BDM Support Request </span></a></li>
         </c:if>         
         <li><a href="ProjectLeads"><i class="fa fa-columns"></i><span>Project Stages 0 & 1</span></a></li> 
         <li><a href="ProjectStatus"><i class="fa fa fa-bars"></i><span>Project Status</span></a></li>
         <li><a href="ConsultantVisits"><i class="fa fa-columns"></i><span>Consultant Visits</span></a></li> 
         <li><a href="ConsultantLeads"><i class="fa fa-line-chart"></i><span>Consultant Approval Status</span></a></li>
         <li class="active"><a href="ConsultantProductReport"><i class="fa fa-columns"></i><span>Consultant Product Report</span></a></li>               
         <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>      
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Consultant Product Status
        <small>Marketing Portal</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="homepage.jsp"><i class="fa fa-calendar"></i> Home</a></li>
        <li class="active">Marketing</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">
    
           
<div  class="fjtco-table" ><br/>
 <form class="form-inline" id="consultantTypeForm" method="post" action="ConsultantProductReport">
        <input type="hidden" name="fjtco" value="rpeotrpad1" />
        <div class="form-group" id="consultant_type_section">
            <label for="consultant_type1">Consultant Type:</label>
            <select class="form-control" id="consultant_type1" multiple="multiple" name="consultantTypeList1">
                <option value="PRIMARY CONSULTANT">Primary Consultant</option>
                <option value="SECONDARY CONSULTANT">Secondary Consultant</option>
                <option value="PRIMARY CLIENT">Primary Client</option>
                <option value="SECONDARY CLIENT">Secondary Client</option>
                <option value="OVERSEAS CONSULTANT">OverSeas Consultants & Clients</option>
                 <option value="PA">Not Any Type</option>
            </select>
        </div>
    </form>


	<form  class="form-inline" id="myForm" method="post" action="ConsultantProductReport"> 
	
	             <i class="fa fa-filter" style="font-size: 24px;color: #065685;"></i>
                 <input type="hidden" id="fjtco" name="fjtco" value="rpeotrpad" /> 
				<!-- 	  <input type="hidden" id="fjtco" name="fjtco" value="consultlist" /> -->
	                  <input type="hidden" id="uid" name="uid" value="E001090" />
	
	
	<div class="form-group" id="nmlstforrprt" style="display: none;">
    <label for="filtered_consultant_list"></label>
    <select class="form-control" id="filtered_consultant_list" multiple="multiple" name="filteredConsultantList">
        <!-- Options will be populated dynamically -->
    </select>
</div>
	  <div class="form-group" id="nmlstforrprt1" style="display:true;">
	  	   <label for="filtered_consultant_list"></label>
		<select class="form-control"  id="consultant_list" multiple="multiple" name="consltList">
		   <c:forEach var="consultLst"  items="${CLFCL}" >
				<c:choose>
			 		<c:when test="${selectedConsultCheckBoxes.contains(consultLst.conslt_name)}">	 					
			 			  <option value="${consultLst.conslt_name}" selected >${consultLst.conslt_name}</option>
			 		</c:when>
			 		<c:otherwise>
			 			 <option value="${consultLst.conslt_name}" >${consultLst.conslt_name}</option>
			 		</c:otherwise>
			 </c:choose>
		</c:forEach>
		
		</select>
	</div> 
	
	<div class="form-group" id="nmlstforrprt">
	<select class="form-control form-control-sm"  id="product_list" multiple="multiple" name="productList" required>
	   	<c:forEach var="productLst"  items="${PLFCL}" >
			<c:choose>
		 		<c:when test="${selectedProdcutCheckBoxes.contains(productLst.product)}">	 					
		 			  <option value="${productLst.product}" selected >${productLst.product}</option>
		 		</c:when>
		 		<c:otherwise>
		 			 <option value="${productLst.product}" >${productLst.product}</option>
		 		</c:otherwise>
		 </c:choose>
	</c:forEach>
	</select>
	</div>
	<div class="form-group">
	<button type="submit" class="btn btn-primary"  onclick="getSeletedval();">Details</button></div>
	<button  type="button" class="btn btn-primary btn-success"  onClick="exportToExcel();"><i class="fa fa-file-excel-o"></i> Export</button>
	</form>
</div>
	<c:if test="${!empty CON_PRO_MATRIX_LIST}">
<div class="tb"  style="overflow-x: scroll;">

<div style="    color: #2196F3;text-align: center;font-weight: bold;"> 
       <br/><br/>     
</div>

<table class='table table-bordered large dataTable no-footer' id="displayConProList"  style="border-top:1px solid #111;">

<tbody>
</tbody>  </table> <br/>
	 <ul id="pagination" class="pagination"></ul>
	     <button id="prevButton">Previous</button>
	     <span id="pageNumberContainer"></span>
    <button id="nextButton">Next</button>
	  </div>
	  </c:if>


 <!--Box End -->
	
    
    </section>
    <!-- /.content -->

   </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <div class="pull-right hidden-xs">
      <b>Version</b> 1.0.0
    </div>
    <strong>Copyright &copy; 1988-${CURR_YR} <a href="http://www.faisaljassim.ae">FJ-Group</a>.</strong> All rights
    reserved.
  </footer>
	
  
</div>
<script src="././resources/bower_components/fastclick/lib/fastclick.js"></script>
<script src="././resources/dist/js/adminlte.min.js"></script>
<!-- page script start -->
<script>
$(function() {
    // Initialize multiselect plugins
    
$(function () {
    $('#product_list').multiselect({
    	nonSelectedText: 'Select Product',
        includeSelectAllOption: true
    });
});
    $('#consultant_type1').multiselect({
        nonSelectedText: 'Select Consultant Type',
        includeSelectAllOption: true,
    });

    $('#filtered_consultant_list').multiselect({
        nonSelectedText: 'Select Filtered Consultant',
        includeSelectAllOption: true
    });

    $('#consultant_list').multiselect({
        nonSelectedText: 'Select Consultant',
        includeSelectAllOption: true
    });
   
    
    $('#nmlstforrprt1').show();
    $('#nmlstforrprt').hide();

    // Event listener for consultant type selection change
    $('#consultant_type1').change(function() {
        var selectedValues = $(this).val();
        console.log("Selected Consultant Types:", selectedValues);

        if (selectedValues && selectedValues.length > 0) {
            // Make AJAX call to fetch filtered consultants
            $.ajax({
                type: "POST",
                url: "ConsultantProductReport",
                data: {
                    fjtco: "rpeotrpad1",
                    consultantTypeList1: selectedValues
                },
                traditional: true,
                success: function(response) {
                    console.log("Success:", response);
                    updateFilteredConsultantList(response);
                },
                error: function(error) {
                    console.log("Error:", error);
                    alert("Error in fetching filtered consultants.");
                }
            });

            // Show the filtered consultant list and hide the default consultant list
            $('#nmlstforrprt').show();
            $('#nmlstforrprt1').hide();

            // Enable the filtered consultant list and disable the default consultant list
            $('#filtered_consultant_list').prop('disabled', false);
            $('#consultant_list').prop('disabled', true);
        } else {
            // Show the default consultant list and hide the filtered consultant list
            $('#nmlstforrprt1').show();
            $('#nmlstforrprt').hide();

            // Enable the default consultant list and disable the filtered consultant list
            $('#consultant_list').prop('disabled', false);
            $('#filtered_consultant_list').prop('disabled', true);
        }
    });

    // Function to update the filtered consultants list
    function updateFilteredConsultantList(response) {
        var consultants;

        // Check if the response needs parsing
        if (typeof response === 'string') {
            try {
                consultants = JSON.parse(response);
            } catch (e) {
                console.error("Error parsing JSON response:", e);
                return;
            }
        } else {
            consultants = response;
        }

        // Ensure consultants is an array
        if (!Array.isArray(consultants)) {
            console.error("Expected an array but got:", consultants);
            return;
        }

        var $filteredConsultantList = $("#filtered_consultant_list");
        $filteredConsultantList.empty(); // Clear existing options

        if (consultants.length > 0) {
            consultants.forEach(function(consultant) {
                // Use `cnslt_id` as the value and `conslt_name` as the display text
                $filteredConsultantList.append(
                    $("<option></option>").val(consultant.cnslt_id).text(consultant.cnslt_id)
                );
            });
        } else {
            $filteredConsultantList.append(
                $("<option></option>").text("No consultants found for selected types")
            );
        }

        // Reinitialize the multiselect to ensure it works properly with new options
        $filteredConsultantList.multiselect('rebuild');
    }
});
</script>
<script>
function preLoader(){ $('#laoding').show();}

function exportToExcel() {
	

	var twoDArray = <%=new Gson().toJson(request.getAttribute("CON_PRO_MATRIX_LIST"))%>;
		if(twoDArray != null ){
		    var wb = XLSX.utils.book_new();		  
		    var ws = XLSX.utils.aoa_to_sheet(twoDArray);
		    XLSX.utils.book_append_sheet(wb, ws, 'Sheet1');		    
		    var wbout = XLSX.write(wb, { bookType: 'xlsx', type: 'binary' });
	
		    // Convert the binary string to a Blob
		    var blob = new Blob([s2ab(wbout)], { type: 'application/octet-stream' });
	
		    // Create a link element to trigger the download
		    var link = document.createElement('a');
		    link.href = URL.createObjectURL(blob);
		    link.download = "ConsulatantProductList.xlsx";
	
		    // Append the link to the document and trigger the download
		    document.body.appendChild(link);
		    
		    link.click();
	
		    // Remove the link from the document
		    document.body.removeChild(link);
		}
	  }

	function s2ab(s) {
	    var buf = new ArrayBuffer(s.length);
	    var view = new Uint8Array(buf);
	    for (var i = 0; i !== s.length; ++i) {
	      view[i] = s.charCodeAt(i) & 0xFF;
	    }
	    return buf;
	  }
	
	const data = <%=new Gson().toJson(request.getAttribute("CON_PRO_MATRIX_LIST"))%>; // Replace this with your actual data
   
	const itemsPerPage = 10; // Adjust the number of items per page
    const totalPages = Math.ceil(data.length / itemsPerPage);

    // Function to display a specific page
    function displayPage(page) {
        const start = (page - 1) * itemsPerPage;
        const end = start + itemsPerPage;
        const pageData = data.slice(start, end);

        // Clear table body
        const tableBody = document.querySelector('#displayConProList tbody');
        tableBody.innerHTML = '';

        for (let rowIndex = 0; rowIndex < pageData.length; rowIndex++) {
            const rowData = pageData[rowIndex];
            const row = document.createElement('tr');
			
            // Add CSS class to the first row
            if (rowIndex === 0) {
                row.classList.add('highlight-firstrow');
            }
            if (rowIndex === 1) {
                row.classList.add('highlight-secondrow');
            }
            rowData.forEach((cellData, cellIndex) => {
                const cell = document.createElement('td');               
                cell.className = 'tooltip-trigger';
                cell.setAttribute('data-tooltip', cellData); 
                cell.title = cellData;
                cell.textContent = cellData;
                console.log("rowIndex== "+rowIndex);
                console.log("curen == "+cellData);
                console.log("pri "+pageData[rowIndex][cellIndex-1]);
               // const prevRow = tableBody.rows[rowIndex - 1];
               
                    row.appendChild(cell);
              // }
            });

            tableBody.appendChild(row);
        }
    }

    // Function to generate pagination links
    function generatePagination() {
        const paginationElement = document.getElementById('pagination');
        paginationElement.innerHTML = '';

        // Display only 3 pages at a time
        for (let i = currentPage - 1; i <= currentPage + 1; i++) {
            if (i > 0 && i <= totalPages) {
                const li = document.createElement('li');
                li.textContent = i;
                li.addEventListener('click', () => {
                    currentPage = i;
                    displayPage(currentPage);
                    generatePagination();
                });
                if (i === currentPage) {
                    li.classList.add('active');
                }
                paginationElement.appendChild(li);
            }
        }
    }

    // Previous and Next button handlers
    document.getElementById('prevButton').addEventListener('click', () => {
        if (currentPage > 1) {
            currentPage--;
            displayPage(currentPage);
            generatePagination();
        }
    });

    document.getElementById('nextButton').addEventListener('click', () => {
        if (currentPage < totalPages) {
            currentPage++;
            displayPage(currentPage);
            generatePagination();
        }
    });

    // Initialize pagination
    let currentPage = 1;
    displayPage(currentPage);
    generatePagination();

    // Display current page number in the container
    document.getElementById('pageNumberContainer').textContent = `Page ${currentPage}`;
    
    
</script>
<!-- page Script  end -->

</c:when>
<c:otherwise>

        <body onload="window.top.location.href='../logout.jsp'">
   
            
        </body>
  
</c:otherwise>
</c:choose>
</html>