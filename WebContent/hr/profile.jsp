<%-- 
    Document   : HR Evaluation Performance , Reports 
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@include file="/hr/header.jsp" %>
<style>
.table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td, .table>thead>tr>th {  padding: 3px 5px !important;}.scoreValue{text-align:right;}.reportDtls{text-align:center !important;}
 #fullReport-Box{ height: 842px;  width: 595px;  /* to centre page on screen*/   margin-left: auto;  margin-right: auto;background: #ecf0f5; display:none;}
        .user-content{font-size:73%;}
        .moreItemBox{background: #ecf0f5;}
  .moreItem{    display: block; color: #ffffff; font-style: italic;   padding: 5px;  background: #607d8b;  border-bottom: 1px solid white;width: 100%;text-align: left;} 
   .moreIcon, th.moreIcon>input, .genderColumn, th.genderColumn>input{max-width:60px !important; width:60px !important; }   
  .compnyColumn, th.compnyColumn>input,  .codeColumn, th.codeColumn>input, .statusColumn,  th.statusColumn>input, .tenureColumn, th.tenureColumn>input{max-width:75px !important; width:75px !important; } 
   .ageColumn,  th.ageColumn>input{max-width:45px !important; width:45px !important; }    
    .divdeptColumn,  th.divdeptColumn>input, .dateColumn,  th.dateColumn>input, .staffColumn,  th.staffColumn>input  {max-width:80px !important; width:80px !important; }  
    .amountColumn, th.amountColumn>input{max-width:90px !important; width:90px !important;text-align:"right" } 
    .nationalityColumn, th.nationalityColumn>input, .locationColumn, th.locationColumn>input{max-width:110px !important; width:110px !important; } 
     .gradeColumn, th.gradeColumn>input{max-width:45px !important; width:45px !important; } 
    .responsiveDtls{ top: 0; bottom: 0; left: 0; right: 0; overflow: auto;} 
    .profile-h-line{margin-top:5px !important;margin-bottom:5px !important;}
    .titleColumn{text-align:center !important; text-transform:uppercase; background :#607d8b !important;color:#fff !important;}
     .mobileNoColumn, th.mobileNoColumn>input{max-width:120px !important; width:120px !important;text-align:"right" } 
      .idColumn, th.idColumn>input{max-width:140px !important; width:140px !important;text-align:"right" }
</style>
<body class="hold-transition skin-blue sidebar-mini sidebar-collapse sidebar-mini"  style="height: auto !important; min-height: 100% !important;">
 <c:if test="${empty fjtuser.emp_code}"> <jsp:forward page="index.jsp"/> </c:if>
 <c:choose>
 <c:when test="${!empty fjtuser.emp_code and fjtuser.checkValidSession eq 1  }">  
 		<sql:query var="rs" dataSource="jdbc/orclfjtcolocal">
				SELECT code,description from religion			
 		</sql:query> 
 		<sql:query var="educationresults" dataSource="jdbc/orclfjtcolocal">
				SELECT code,description from education			
 		</sql:query> 
  <c:set var="profileController" value="profile" scope="page" />
  <c:set var="selfcontroller" value="SelfEvaluation" scope="page" />
  <c:set var="managerController" value="EmployeeEvaluation" scope="page" />
   <c:set var="reportController" value="EvaluationReport" scope="page" />
   <c:set var="dashboardController" value="HrDashboard" scope="page" />    
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
        <li   class="active"><a href="${profileController}"><i class="fa fa-address-card"></i><span>Profile</span></a></li> 
         <c:if test="${fjtuser.role eq 'hrmgr' }"><li><a href="${dashboardController}"><i class="fa fa-dashboard"></i><span>HR Dashbaord</span></a></li></c:if>  
         <li><a href="${selfcontroller}"><i class="fa fa-user"></i><span>Self Evaluation</span></a></li> 
         <c:if test="${EVLMNGRORNOT ge 1}"><li><a href="${managerController}"><i class="fa fa-users"></i><span>Employee Evaluation</span></a></li></c:if>
         <li  ><a href="${reportController}"><i class="fa fa-table"></i><span>Evaluation Report</span></a></li>            
         <li><a href="homepage.jsp"><i class="fa fa-home"></i><span>HR Portal</span></a></li>      
      </ul>
    </section>
    <!-- /.sidebar -->
  </aside>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper"  style="height: auto !important; min-height: 100% !important;">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>HR <small>Profile</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="homepage.jsp"><i class="fa fa-calendar"></i> Home</a></li>
        <li class="active">HR Portal</li>
      </ol>
    </section>   
    <!-- Main content -->	    
	  <section class="content">

      <div class="row">
        <div class="col-md-3">

          <!-- Profile Image -->
          <div class="box box-primary">
            <div class="box-body box-profile">
              <%-- <img class="profile-user-img img-responsive img-circle" src="././resources/images/1.png" alt="User profile picture">--%>

              <h3 class="profile-username text-center">${COMPLTEMPDTLS.name}</h3>

              <p class="text-muted text-center">${COMPLTEMPDTLS.designation}</p> 
              <p class="text-center">
              <c:choose>
              <c:when test="${COMPLTEMPDTLS.status eq 'ACTIVE' or COMPLTEMPDTLS.status eq 'active'  or COMPLTEMPDTLS.status eq 'Active' }">
               <span class="label label-success">ACTIVE</span>
              </c:when>
              <c:otherwise><span class="label label-danger">LEFT</span></c:otherwise>
              </c:choose> 
              </p> 
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->

          <!-- About Me Box -->
          <div class="box box-primary">
            <div class="box-header with-border">
              <h3 class="box-title">About Me</h3>
            </div>
            <!-- /.box-header -->
            <div class="box-body">    
             <strong> Gender  <span class="text-muted">:</span> ${COMPLTEMPDTLS.gender}</strong> 
              <hr class="profile-h-line">         
              <strong>Email  <span class="text-muted">:</span> ${COMPLTEMPDTLS.email}</strong> 
              <hr class="profile-h-line">   
 			  <strong> Age   <span class="text-muted">:</span> ${COMPLTEMPDTLS.age}</strong> 
              <hr class="profile-h-line">
              <strong>DOB  
              <span class="text-muted">:</span> 
                <fmt:parseDate value="${COMPLTEMPDTLS.birth_dt}" var="dobDate"    pattern="yyyy-MM-dd HH:mm" />
			    <fmt:formatDate value="${dobDate}" pattern="dd/MM/yyyy"/>   
            </strong> 
              <hr class="profile-h-line">
              <strong> Nationality   <span class="text-muted">:</span> ${COMPLTEMPDTLS.nationality}</strong> 
            </div>
            <!-- /.box-body -->
          </div>
          <!-- /.box -->
        </div>
        <!-- /.col -->
        <div class="col-md-9">
          <div class="nav-tabs-custom">
            <ul class="nav nav-tabs">
              <li class="active"><a href="#activity" data-toggle="tab">Employee Details</a></li>
              <li><a href="#settings" data-toggle="tab">Update</a></li>
            </ul>
            <div class="tab-content">
              <div class="active tab-pane" id="activity">
          		      <div class="panel-body responsiveDtls"> 
	  		      	  <table class="table table-bordered small bordered no-padding table-striped" id="emp-table">
		                <thead> 
		                <tr>  
					       <th class="titleColumn" colspan="10" >Job Details</th>
					      </tr>
		                  <tr>   
		                   <th class="compnyColumn">Emp. Code</th>  
		                   <th class="compnyColumn">Company</th>      
		                   <th class="divdeptColumn">Division</th>
		                   <th class="divdeptColumn">Department</th> 	 		                   
		                   <th class="dateColumn">Joining Date</th>
		                   <th class="dateColumn"> End Of Service Date</th>
		                   <th class="tenureColumn">Tenure</th>
		                   <th class="locationColumn">Job Location</th>
		                   <th class="staffColumn">Type</th>	 
		                   <th class="gradeColumn">Grade</th> 
		                </tr>              
		                </thead>
		                <tbody class="empDetails"> 
		                <tr>
		                  <td  class="scoreEmp">${COMPLTEMPDTLS.emp_code}</td> 
		                  <td  class="scoreEmp">${COMPLTEMPDTLS.emp_comp_code}</td> 
		                  <td  class="scoreEmp">${COMPLTEMPDTLS.division}</td>  
		                  <td  class="scoreEmp">${COMPLTEMPDTLS.department}</td>  
		                  <td  class="scoreEmp">
		                  <fmt:parseDate value="${COMPLTEMPDTLS.join_date}" var="joinDate"    pattern="yyyy-MM-dd HH:mm" />
						  <fmt:formatDate value="${joinDate}" pattern="dd/MM/yyyy"/> 
		                  </td> 
		                  <td  class="scoreEmp">
		                  <fmt:parseDate value="${COMPLTEMPDTLS.emp_end_of_service_dt}" var="eosDate"    pattern="yyyy-MM-dd HH:mm" />
						  <fmt:formatDate value="${eosDate}" pattern="dd/MM/yyyy"/>    		                  
		                  </td>
		                  
		                   <td  class="scoreEmp">${COMPLTEMPDTLS.tenure}</td>   
		                  <td  class="scoreEmp">${COMPLTEMPDTLS.job_location}</td>   		                  
						  <td class='scoreEmp'>${COMPLTEMPDTLS.emp_type}</td>  
						   <td class='scoreEmp'>${COMPLTEMPDTLS.grade}</td>  
						 </tr>
		                </tbody>		              
		              </table>
		              
		               <table class="table table-bordered small bordered no-padding table-striped" id="emp-table">
		                <thead> 
		                 <tr>  
					       <th class="titleColumn" colspan="5" >Bank  Details</th>
					      </tr> 
		                  <tr>   
		                   <th>IBAN No.</th>  
		                   <th class="amountColumn">Basic</th>
		                   <th class="amountColumn">Allowance</th>  
		                   <th class="amountColumn">Total Salary</th>  		                   
		                  
		                </tr>              
		                </thead>
		                <tbody class="empDetails"> 
		                <tr> 
		                  <td  class="scoreEmp">${COMPLTEMPDTLS.iban_no}</td>  	
		                  <c:choose>
		                  <c:when test ="${COMPLTEMPDTLS.emp_type eq 'Labor'}">	              
			                  <td  class="scoreEmp">0</td>   
			                  <td  class="scoreEmp">0</td>   		                  
							  <td class='scoreEmp'>0</td> 
						  </c:when> 
						  <c:otherwise>
						  	  <td  class="scoreEmp">${COMPLTEMPDTLS.basic_amt}</td>   
			                  <td  class="scoreEmp">${COMPLTEMPDTLS.allow_amt}</td>   		                  
							  <td class='scoreEmp'>${COMPLTEMPDTLS.tot_sal}</td> 
						  </c:otherwise>
						  </c:choose>
						 </tr>
		                </tbody>		              
		              </table>
		              
		                 <table class="table table-bordered small bordered no-padding table-striped" >
					                <thead> 
					                   <tr>  
					                    <th class="titleColumn" colspan="8" >Official Documents Details</th>
					                  </tr> 
					                  <tr>   
					                   <th class="mobileNoColumn">Office Mobile No.</th>
					                    <th class="hideColumn">Emirates ID No.</th>
					                    <th class="hideColumn">Emirates ID Expiry Dt.</th>
					                     <th class="hideColumn">Religion</th>
					                    <th class="hideColumn">Education1</th>
					                    <th class="hideColumn">Education2</th>
					                    <th class="hideColumn">Education3</th>
					                  <%--  <th class="hideColumn">Visa Date Of Issue</th>
					                    <th class="hideColumn">Visa Expiry Dt.</th>
					                   
					                    <th class="hideColumn">UID Expiry Dt.</th> --%>             					                  
					                </tr>              
					                </thead>
					                <tbody class="empDetails"> 
					                <tr>
					                  <td class="scoreEmp">${COMPLTEMPDTLS.office_Mobile_Number}</td> 
					                  <td class="scoreEmp">${COMPLTEMPDTLS.emirates_Id_Number}</td>  	 
					                  <td  class="scoreEmp">
					                  <fmt:parseDate value="${COMPLTEMPDTLS.emirates_Id_Expiry_Date}" var="eidexpDate"    pattern="yyyy-MM-dd HH:mm" />
									  <fmt:formatDate value="${eidexpDate}" pattern="dd/MM/yyyy"/>    		                  
					                  </td>  
					                    <td class='scoreEmp'>${COMPLTEMPDTLS.religiondesc}</td>  
					                  <td class="scoreEmp">${COMPLTEMPDTLS.education1Desc}</td>  
					                  <td class="scoreEmp">${COMPLTEMPDTLS.education2Desc}</td>
					                  <td class="scoreEmp">${COMPLTEMPDTLS.education3Desc}</td>  
									 <%--   <td  class="scoreEmp">
					                <fmt:parseDate value="${COMPLTEMPDTLS.date_Of_Issue}" var="issueDate"    pattern="yyyy-MM-dd HH:mm" />
									  <fmt:formatDate value="${issueDate}" pattern="dd/MM/yyyy"/>    		                  
					                  </td>   
									  <td  class="scoreEmp">
					                  <fmt:parseDate value="${COMPLTEMPDTLS.visa_Expiry_Date}" var="visaExpDate"    pattern="yyyy-MM-dd HH:mm" />
									  <fmt:formatDate value="${visaExpDate}" pattern="dd/MM/yyyy"/>    		                  
					                  </td>  
									  
									   <td  class="scoreEmp">
					                  <fmt:parseDate value="${COMPLTEMPDTLS.uID_Expiry_Date}" var="uidExpDate"    pattern="yyyy-MM-dd HH:mm" />
									  <fmt:formatDate value="${uidExpDate}" pattern="dd/MM/yyyy"/>    		                  
					                  </td> 
					                  --%>  
									 </tr>
					                </tbody>		              
					              </table>
					                <table class="table table-bordered small bordered no-padding table-striped" >
					                <thead> 
					                  <tr>   
					                    <th class="hideColumn">Passport No.</th>
					                    <th class="hideColumn">Passport Expiry Dt.</th>
					                    <th class="hideColumn">Medical Insurance Category</th>
					                    <th class="hideColumn">Emergency Contact Full Name</th>
					                    <th class="hideColumn">Emergency Contact Mobile No.</th>
					                    <th class="hideColumn">Emergency Contact Relationship</th>
					                    <th class="hideColumn">End Of Service Nomination</th>
					                    <th class="hideColumn">End Of Service Mobile No.</th>                   					                  
					                </tr>              
					                </thead>
					                <tbody class="empDetails"> 
					                <tr>   
									  <td class='scoreEmp'>${COMPLTEMPDTLS.passport_Number}</td>   
									  <td  class="scoreEmp">
					                  <fmt:parseDate value="${COMPLTEMPDTLS.passport_Expiry_Date}" var="passportExpDate"    pattern="yyyy-MM-dd HH:mm" />
									  <fmt:formatDate value="${passportExpDate}" pattern="dd/MM/yyyy"/>    		                  
					                  </td>  
									  <td class='scoreEmp'>${COMPLTEMPDTLS.medical_Insurance_Category}</td>  
									  <td class='scoreEmp'>${COMPLTEMPDTLS.emergency_Contact_Full_Name}</td> 
									  <td class='scoreEmp'>${COMPLTEMPDTLS.emergency_Contact_Mobile_Number}</td>  
									  <td class='scoreEmp'>${COMPLTEMPDTLS.emergency_Contact_Relationship}</td> 
									  <td class='scoreEmp'>${COMPLTEMPDTLS.end_Of_Service_Nomination}</td>  
									  <td class='scoreEmp'>${COMPLTEMPDTLS.end_Of_Service_Mobile_Number}</td>    
									 </tr>
					                </tbody>		              
					              </table>
		              
	  		      </div>

          
              </div>
              <!-- /.tab-pane -->
              <div class="tab-pane" id="settings">
                <form class="form-horizontal" >
                <div class="col-lg-6, col-md-6 col-sm-12 col-xs-12 small">
                  <div class="form-group">
                    <label for="ofcMblNo" class="col-sm-4 control-label">Office Mobile Number</label>
                    <div class="col-sm-8">
                      <input type="text" class="form-control" id="ofcMblNo" name="ofcMblNo" value="${COMPLTEMPDTLS.office_Mobile_Number}" placeholder="Office Mobile Number" autocomplete="off">
                    </div>
                  </div>
             <%--       <div class="form-group">
                    <label for="passportno" class="col-sm-4 control-label">Passport Number</label>

                    <div class="col-sm-8">
                      <input type="text" class="form-control" id="passportno" name="passportno" value="${COMPLTEMPDTLS.passport_Number}"  placeholder="Passport Number" autocomplete="off">
                    </div>  
                  </div>--%>
                  <div class="form-group">
                    <label for="emergcontctfn" class="col-sm-4 control-label">Emergency Contact Full Name</label>

                    <div class="col-sm-8">
                      <input type="text" class="form-control" id="emergcontctfn" name="emergcontctfn" value="${COMPLTEMPDTLS.emergency_Contact_Full_Name}"  placeholder="Emergency Contact Full Name" autocomplete="off"/>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="emergcontctrltshp" class="col-sm-4 control-label">Emergency Contact Relationship</label>

                    <div class="col-sm-8">
                      <input type="text" class="form-control" id="emergcontctrltshp" name="emergcontctrltshp" value="${COMPLTEMPDTLS.emergency_Contact_Relationship}"  placeholder="Emergency Contact Relationship" autocomplete="off"/>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="religon" class="col-sm-4 control-label">Religion</label>
	                    <div class="col-sm-8">
	                    	<select name="religion" class="form-control form-control-sm" id="religion" autocomplete="off">	
	                    		<option value="NONE">Select Religion</option>                       	   
			                     <c:forEach var="relig" items="${rs.rows}">	 			                                 
										 <option value="${relig.code}"  <c:if test="${relig.code eq COMPLTEMPDTLS.religioncode}">selected="selected"</c:if>>${relig.description}</option>
							     </c:forEach>  
						     </select> 
					     </div>
                  </div>
                  <div class="form-group">
                    <label for="education" class="col-sm-4 control-label">Education1</label>
	                    <div class="col-sm-8">
	                    	<select name="eduction" class="form-control form-control-sm" id="education1" autocomplete="off">
	                    		 <option value="NONE">Select Education</option>        
			                     <c:forEach var="edu" items="${educationresults.rows}">	                   
										 <option value="${edu.code}" <c:if test="${edu.code eq COMPLTEMPDTLS.education1Code}">selected="selected"</c:if>>${edu.description}</option>
							     </c:forEach>  
						     </select> 
					     </div>
                  </div>
                  <div class="form-group">
                    <label for="education" class="col-sm-4 control-label">Education2</label>
	                    <div class="col-sm-8">
	                    	<select name="eduction" class="form-control form-control-sm" id="education2" autocomplete="off">
	                    		 <option value="NONE">Select Education</option>        
			                     <c:forEach var="edu" items="${educationresults.rows}">	                   
										 <option value="${edu.code}" <c:if test="${edu.code eq COMPLTEMPDTLS.education2Code}">selected="selected"</c:if>>${edu.description}</option>
							     </c:forEach>  
						     </select> 
					     </div>
                  </div>
                  <div class="form-group">
                    <label for="education" class="col-sm-4 control-label">Education3</label>
	                    <div class="col-sm-8">
	                    	<select name="eduction" class="form-control form-control-sm" id="education3" autocomplete="off">
	                    		 <option value="NONE">Select Education</option>        
			                     <c:forEach var="edu" items="${educationresults.rows}">	                   
										 <option value="${edu.code}" <c:if test="${edu.code eq COMPLTEMPDTLS.education3Code}">selected="selected"</c:if>>${edu.description}</option>
							     </c:forEach>  
						     </select> 
					     </div>
                  </div>
                 <%--  <div class="form-group">
                    <label for="eidNo" class="col-sm-4 control-label">Emirates ID Numnber</label>
                    <div class="col-sm-8">
                      <input type="text" class="form-control" id="eidNo" name="eidNo" value="${COMPLTEMPDTLS.emirates_Id_Number}" placeholder="Emirates ID Numnber" autocomplete="off">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="eidexpdate" class="col-sm-4 control-label">Emirates ID Expiry Date</label>
                    <div class="col-sm-8"> 
                      <fmt:parseDate value="${COMPLTEMPDTLS.emirates_Id_Expiry_Date}" var="theeidexpdate"  dateStyle="short"   pattern="yyyy-MM-dd HH:mm" />
		              <input  class="form-control"   type="text" id="eidexpdate" name="eidexpdate" readonly  value="<fmt:formatDate value="${theeidexpdate}" pattern="dd/MM/yyyy"/>"  placeholder="Emirates ID Expiry Date" autocomplete="off"   />
                    </div>
                  </div>
                  
                  <div class="form-group">
                    <label for="uidno" class="col-sm-4 control-label">UID Number</label>

                    <div class="col-sm-8">
                      <input type="text" class="form-control" id="uidno" name="uidno" value="${COMPLTEMPDTLS.uid_Number}" placeholder="UID Number" autocomplete="off">
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="visano" class="col-sm-4 control-label">Visa File Number</label> 
                    <div class="col-sm-8">
                      <input type="text" class="form-control" id="visano" name="visano" value="${COMPLTEMPDTLS.visa_Number}" placeholder="Visa Number" autocomplete="off"/>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="visadateofissue" class="col-sm-4 control-label">Visa Date of issue</label> 
                    <div class="col-sm-8"> 
                      <fmt:parseDate value="${COMPLTEMPDTLS.date_Of_Issue}" var="thevisadateofissue"  dateStyle="short"   pattern="yyyy-MM-dd HH:mm" />
		              <input  class="form-control"   type="text" id="visadateofissue" readonly name="visadateofissue"  value="<fmt:formatDate value="${thevisadateofissue}" pattern="dd/MM/yyyy"/>"  placeholder="Visa Date of issue" autocomplete="off"   />
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="visaexpdate" class="col-sm-4 control-label">Visa Expiry Date</label>

                    <div class="col-sm-8">
                    <fmt:parseDate value="${COMPLTEMPDTLS.visa_Expiry_Date}" var="thevisaExpDate"  dateStyle="short"   pattern="yyyy-MM-dd HH:mm" />
		              <input  class="form-control"   type="text" id="visaexpdate" readonly name="visaexpdate"  value="<fmt:formatDate value="${thevisaExpDate}" pattern="dd/MM/yyyy"/>"  placeholder="Visa Expiry Date" autocomplete="off"   />
                    </div>
                  </div>
                  
                  <div class="form-group">
                    <label for="uidexpdate" class="col-sm-4 control-label">UID Expiry Date</label> 
                    <div class="col-sm-8">
                      <fmt:parseDate value="${COMPLTEMPDTLS.uID_Expiry_Date}" var="theUIDExpDate"  dateStyle="short"   pattern="yyyy-MM-dd HH:mm" />
		              <input  class="form-control"   type="text" id="uidexpdate" name="uidexpdate"  readonly value="<fmt:formatDate value="${theUIDExpDate}" pattern="dd/MM/yyyy"/>"  placeholder="UID Expiry Date" autocomplete="off"   />	                  		    

                    </div>
                  </div>
                  --%>
                  </div>
                  <div class="col-lg-6, col-md-6 col-sm-12 col-xs-12 small">
                   <div class="form-group">
                    <label for="medinsrncecatg" class="col-sm-4 control-label">Medical Insurance Category</label>

                    <div class="col-sm-8">
                      <input type="text" class="form-control" id="medinsrncecatg" name="medinsrncecatg" value="${COMPLTEMPDTLS.medical_Insurance_Category}" placeholder="Medical Insurance Category" autocomplete="off"/>
                    </div>
                  </div>
               <%--     <div class="form-group">  
                  <label for="passportexpdate" class="col-sm-4 control-label">Passport Expiry Date</label>
                    <div class="col-sm-8">
                      <fmt:parseDate value="${COMPLTEMPDTLS.passport_Expiry_Date}" var="thepsprtExpDate"  dateStyle="short"   pattern="yyyy-MM-dd HH:mm" />
		              <input  class="form-control"   type="text" id="passportexpdate" readonly name="passportexpdate"  value="<fmt:formatDate value="${thepsprtExpDate}" pattern="dd/MM/yyyy"/>"  placeholder="Passport Expiry Dat" autocomplete="off"   />	                  		    
                    </div>
                  </div> --%>
                 
                 
                  <div class="form-group">
                    <label for="emergcontctmobno" class="col-sm-4 control-label">Emergency Contact Mobile No.</label>

                    <div class="col-sm-8">
                      <input type="text" class="form-control" id="emergcontctmobno"  name="emergcontctmobno" value="${COMPLTEMPDTLS.emergency_Contact_Mobile_Number}" placeholder="Emergency Contact Mobile Number" autocomplete="off"/>
                    </div>
                  </div>
                 
                  <div class="form-group">
                    <label for="eodnomination" class="col-sm-4 control-label">End Of Service - Nomination</label>

                    <div class="col-sm-8">
                      <input type="text" class="form-control" id="eodnomination" name="eodnomination"  value="${COMPLTEMPDTLS.end_Of_Service_Nomination}" placeholder="End Of Service - Nomination" autocomplete="off"/>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="inputSkills" name="eosmobno" class="col-sm-4 control-label">End of Service - Mobile Number</label>

                    <div class="col-sm-8">
                      <input type="text" class="form-control" id="eosmobno" name="eosmobno"  value="${COMPLTEMPDTLS.end_Of_Service_Mobile_Number}" placeholder="End of Service - Mobile Number" autocomplete="off"/>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="passoutyear" class="col-sm-4 control-label">Duration1</label>
                    <div class="col-sm-8">
                      <input type="text" class="form-control" id="duration1" name="duration1" value="${COMPLTEMPDTLS.duration1desc}"  placeholder="Duration1" autocomplete="off"/>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="passoutyear" class="col-sm-4 control-label">Duration2</label>
                    <div class="col-sm-8">
                      <input type="text" class="form-control" id="duration2" name="duration2" value="${COMPLTEMPDTLS.duration2desc}"  placeholder="Duration2" autocomplete="off"/>
                    </div>
                  </div>
                  <div class="form-group">
                    <label for="passoutyear" class="col-sm-4 control-label">Duration3</label>
                    <div class="col-sm-8">
                      <input type="text" class="form-control" id="duration3" name="duration3" value="${COMPLTEMPDTLS.duration3desc}"  placeholder="Duration3" autocomplete="off"/>
                    </div>
                  </div>
                  </div> 
                  <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-12">
                      <button type="submit" class="btn btn-danger" id="docsupdate">Update</button>
                    </div>
                  </div>
                </form>
              </div>
              <!-- /.tab-pane -->
            </div>
            <!-- /.tab-content -->
          </div>
          <!-- /.nav-tabs-custom -->
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->

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

var _url = '${profileController}';
var _method = "POST"; 
var empDetails = <%=new Gson().toJson(request.getAttribute("COMPLTEMPDTLS"))%>;
$(function(){ 	
	 $("#visadateofissue").datepicker({ "dateFormat" : "dd/mm/yy", yearRange: "2019:2030", minDate : -750, changeMonth: true,   changeYear: true,});
	 $(" #uidexpdate, #visaexpdate, #eidexpdate").datepicker({ "dateFormat" : "dd/mm/yy", yearRange: "2020:2035", minDate : 0, changeMonth: true,   changeYear: true,});
	 $("#passportexpdate").datepicker({ "dateFormat" : "dd/mm/yy", yearRange: "2020:2040", minDate : 0, changeMonth: true,   changeYear: true,});
	 $("#passportexpdate, #uidexpdate, #visaexpdate, #eidexpdate, #visadateofissue").prop('maxlength', 10);
	 $('.loader').hide(); 
	$('#docsupdate').on('click', function(e){		  		   
		    e.preventDefault();  
		    updateUserPersonalDetails();
	});
}); 

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

 
 
 
function updateUserPersonalDetails(){   	
 var  ofcMblNo = $.trim(document.getElementById('ofcMblNo').value);   
 var  eidNo  = "";//$.trim(document.getElementById('eidNo').value);
 var  eidexpdate = "";//$.trim(document.getElementById('eidexpdate').value);
 var  visano ="";// $.trim(document.getElementById('visano').value);
 var  visadateofissue ="";// $.trim(document.getElementById('visadateofissue').value);
 var  visaexpdate ="";// $.trim(document.getElementById('visaexpdate').value);
 var  uidno =""; //$.trim(document.getElementById('uidno').value);
 var  uidexpdate = ""; //$.trim(document.getElementById('uidexpdate').value);
 var  passportno = "";// $.trim(document.getElementById('passportno').value);
 var  passportexpdate  = "";//$.trim(document.getElementById('passportexpdate').value);
 var  medinsrncecatg = $.trim(document.getElementById('medinsrncecatg').value);
 var  emergcontctfn = $.trim(document.getElementById('emergcontctfn').value);
 var  emergcontctmobno  = $.trim(document.getElementById('emergcontctmobno').value);
 var  emergcontctrltshp = $.trim(document.getElementById('emergcontctrltshp').value);
 var  eodnomination  = $.trim(document.getElementById('eodnomination').value);
 var  eosmobno = $.trim(document.getElementById('eosmobno').value);
 var  religion  = $.trim(document.getElementById('religion').value);
 var  education1 = $.trim(document.getElementById('education1').value);
 var  education2 = $.trim(document.getElementById('education2').value);
 var  education3 = $.trim(document.getElementById('education3').value);
 var  duration1 = $.trim(document.getElementById('duration1').value);
 var  duration2 = $.trim(document.getElementById('duration2').value);
 var  duration3 = $.trim(document.getElementById('duration3').value);
 if(ofcMblNo.trim().length <=7 || emergcontctmobno .trim().length <=7){
	 alert("Mobile Number should be atleast 8 digits");
	 return false;
 }
 
 if ((confirm('Are You sure, You Want to update this details!'))) {  
	 $('#laoding').show();
		$.ajax({
		 type: _method,
 	 url: _url, 
 	 data: {action: "upupdtls",   d1:ofcMblNo, d2:eidNo, d3:eidexpdate, d4:visano, d5:visadateofissue, d6:visaexpdate, d7:uidno, d8:uidexpdate,
 		 d9:passportno, d10:passportexpdate, d11:medinsrncecatg, d12:emergcontctfn, d13:emergcontctmobno, d14:emergcontctrltshp, d15:eodnomination, d16:eosmobno ,d17:religion,
 		 d18:education1,d19:education2 ,d20:education3 ,d21:duration1 ,d22:duration2 ,d23:duration3  },
 	 success: function(data) {  
 	 $('#laoding').hide();
 	 if (parseInt(data) == 1) {	
 		  //alert("Details updated successfully!.");
 		  location.reload();
         }else if(parseInt(data) == 0){ 
         	alert("Details not updated,Please refresh the page!.");
         	 return false;
         }else{
         	 alert("Details not updated,Please refresh the page!.");
         	 return false;
         }
  		},error:function(data,status,er) {
 		 $('#loading').hide();
 		 alert("Details not updated,Please refresh the page!.");
 		 return false;	 
  		}
			}); 
		} else{return false;} 
 }
 



  

function getOtherDetails(empCode, empName){ 
	$('#laoding').show(); 
	$("#modal_detail .modal-body").html("");
	var ttl="<b>Details Updated Employee - "+empCode+", "+empName+"</b>"; 
	var excelTtl="Details Updated Employee -"+empCode+", "+empName;
	$("#modal_detail .modal-title").html(ttl); 
var output = '<table id="excelTbl" class="table table-bordered small bordered no-padding table-striped">';
	output +='<thead><tr><th>Office Mobile No.</th><th>Emirates ID No.</th> <th>Emirates ID Expiry Dt.</th> <th>Religion</th>';
    output +='<th>Education</th><th>Passport No.</th><th>Passport Expiry Dt.</th><th>Medical Insurance Category</th><th>Emergency Contact Full Name</th><th>Emergency Contact Mobile No.</th>';
	output +='<th>Emergency Contact Relationship</th><th>End Of Service Nomination</th><th>End Of Service Mobile No.</th></tr></thead>'; 
 var employeeOtherDetails =  empDetails.filter( item=> item.emp_code ===empCode ); 
 if(employeeOtherDetails){
	 output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails.office_Mobile_Number)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails.emirates_Id_Number)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails.emirates_Id_Expiry_Date)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails.religion)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails.education)+"</td>";
	  //output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails.visa_Expiry_Date)+"</td>";
	 // output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails.uid_Number)+"</td>";
	 // output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails.uID_Expiry_Date)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails.passport_Number)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails.passport_Expiry_Date)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails.medical_Insurance_Category)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails.emergency_Contact_Full_Name)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails.emergency_Contact_Mobile_Number)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails.emergency_Contact_Relationship)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails.end_Of_Service_Nomination)+"</td>";
	  output += "<td class='scoreEmp hideColumn'>"+validateData(employeeOtherDetails.end_Of_Service_Mobile_Number)+"</td>";
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
 output +="<thead><tr><th>From</th><th>To</th> <th>Allowance</th><th>Currency</th><th>Original Amount</th> <th>Adj. Amount</th> <th>Final Amount</th></tr></thead>"; 
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
			  output += "<td class='scoreEmp'>"+validateDate($.trim(item.toDate))+"</td>"; 
			  output += "<td class='scoreEmp'>"+validateData(item.allowance)+"</td>";
			  output += "<td class='scoreEmp'>"+validateData(item.currency)+"</td>";
			  output += "<td class='scoreValue'>"+validateData(item.orgAmount)+"</td>";
			  output += "<td class='scoreValue'>"+validateData(item.adjAmount)+"</td>";
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