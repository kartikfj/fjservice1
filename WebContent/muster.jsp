<%-- 
    Document   : muster   
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@include file="mainview.jsp" %>
<jsp:useBean id="cmp_param" class="beans.CompParam" scope="session"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:choose>
    <c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1 and  ( fjtuser.role eq 'hr' or   fjtuser.role eq 'hrmgr')}">     
        <sql:query var="rs2" dataSource="jdbc/orclfjtcolocal">
            SELECT COMP_CODE FROM FJPORTAL.FM_COMPANY where COMP_FRZ_FLAG = 'N' order by COMP_CODE
        </sql:query>
        <c:choose>
            <c:when test="${pageContext.request.method != 'POST'}">
                <sql:query var="rs3" dataSource="jdbc/orclfjtcolocal">
                    SELECT distinct EMP_DIVN_CODE from FJPORTAL.PM_EMP_KEY where EMP_COMP_CODE=?
                    <sql:param>${rs2.rows[0].COMP_CODE}</sql:param>
                </sql:query> 
            </c:when>
            <c:when test="${pageContext.request.method eq 'POST' and !empty param.comp_code_sel}">     
                <sql:query var="rs3" dataSource="jdbc/orclfjtcolocal">
                    SELECT distinct EMP_DIVN_CODE from FJPORTAL.PM_EMP_KEY where EMP_COMP_CODE=?
                    <sql:param>${param.comp_code_sel}</sql:param>
                </sql:query>       
            </c:when>
            <c:when test="${pageContext.request.method eq 'POST' and !empty param.compcode and !empty param.divcode}">     
                <sql:query var="rs3" dataSource="jdbc/orclfjtcolocal">
                    SELECT distinct EMP_DIVN_CODE from FJPORTAL.PM_EMP_KEY where EMP_COMP_CODE=?
                    <sql:param>${param.compcode}</sql:param>
                </sql:query> 
                <jsp:useBean id="newmuster" class="beans.Muster" scope="request"/>
                <jsp:setProperty name="newmuster" property="compcode" param="compcode"/>
                <jsp:setProperty name="newmuster" property="sectionCode" param="divcode"/>
                <jsp:setProperty name="newmuster" property="startdtStr" param="fromdate"/>
                <jsp:setProperty name="newmuster" property="enddtStr" param="todate"/>
                <c:set var="retval" value="${newmuster.processAllEmployeeDeatilsOfThecompany}"/>

            </c:when>
        </c:choose>
        <link href="resources/css/jquery-ui.css" rel="stylesheet">
        <script src="resources/js/jquery-1.10.2.js"></script>
        <script src="resources/js/jquery-ui.js"></script>
        <link rel="stylesheet" type="text/css" href="resources/datatables/datatables-fjtco/css/jquery.dataTables.min.css" />
		<link rel="stylesheet" type="text/css" href="resources/datatables/buttons-fjtco/css/buttons.dataTables.min.css" />
		<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/jquery.dataTables.min.js"></script>
		<script type="text/javascript" src="resources/datatables/datatables-fjtco/js/dataTables.buttons.min.js"></script>
		<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.flash.min.js"></script>
		<script type="text/javascript" src="resources/datatables/ajax/excelmake/jszip.min.js"></script>
		<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.html5.min.js"></script>
		<script type="text/javascript" src="resources/datatables/buttons-fjtco/js/buttons.print.min.js"></script>
        <script>      
            $(function () {
                $("#datepicker-2").datepicker({minDate: null, maxDate: null, dateFormat: 'dd/mm/yy', onSelect: function (dateText, inst) {
                        $("#datepicker-3").datepicker("option", "minDate", $("#datepicker-2").datepicker("getDate"));
                        $("#datepicker-3").datepicker('enable');
                        $("#datepicker-3").datepicker('setDate', null);
                    }});
                $("#datepicker-3").datepicker({minDate: null, maxDate: null, dateFormat: 'dd/mm/yy'});
                var fromdtExp = document.getElementById("datepicker-2").value;
                var todtExp = document.getElementById("datepicker-3").value;
                var compcodeExp = document.getElementById("comp_code_sel").value;
                var divcodeExp = document.getElementById("div_code_sel").value;
                var bexclttl ='Muster Roll Report For '+compcodeExp+"/"+divcodeExp+" from:"+fromdtExp+" to:"+todtExp+" ";
                $('#muster-table').DataTable( {
 			        dom: 'Bfrtip',  "paging":false,  "ordering": false,"info":false,"searching": false,      
 			        buttons: [
 			            {
 			                extend: 'excelHtml5',
 			                text:      '<i class="fa fa-file-excel-o" style="color: green; font-size: 1.5em;">EXPORT</i>',
 			                filename: bexclttl,
 			                title: bexclttl,
 			                messageTop: 'File Processed on : ${currCal} ,The information in this file is copyright to Faisal Jassim Group.'
 			                
 			                
 			            }
 			          
 			           
 			        ]
 			    } );
            });

            function verify() {
                var fromdt = document.getElementById("datepicker-2").value;
                var todt = document.getElementById("datepicker-3").value;
                var compcode = document.getElementById("comp_code_sel").value;
                var divcode = document.getElementById("div_code_sel").value;
                
                compcodeExp = compcode; fromdtExp = fromdt; todtExp = todt; divcodeExp = divcode;
                if (fromdt == null || todt == null || compcode == null || divcode == null) {
                    alert("Please fill the details properly");
                    return false;
                } else if (fromdt.trim().length == 0 || todt.trim().length == 0 || compcode.trim().length == 0 || divcode.trim().length == 0) {
                    alert("Please fill the details properly");
                    return false;
                }
                document.getElementById("compcode").value = compcode;
                document.getElementById("divcode").value = divcode;
                return true;
            }
        </script>
        <style>
        div.dt-buttons { float: right !important; }
        </style>
        <div class="container">
            <div class="att_searchbox">
                <h1>Muster roll &nbsp;
	                <a href="homepage.jsp" > <i class="fa fa-home pull-right" title="Home"></i></a>
					<a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a>&nbsp;&nbsp;
                </h1> 
            </div>
            <div class="n_text_msg" style="float:left;width:60%">
                <div class="l_one">
                    <div class="n_text_narrow"><label>Company code : </label></div>
                    <form method="post" id="theform">
                        <select name="comp_code_sel" class="select_box" id="comp_code_sel" onchange="this.form.submit();" autocomplete="off">
                        	
                        	<c:choose>
                        	<c:when test="${empty param.comp_code_sel}">                        		
                        		<option value="ALL">ALL</option>
                        	</c:when>
                        	<c:otherwise>
                        		<option value="ALL" selected="selected">ALL</option>
                        	</c:otherwise>
                        	</c:choose>
                            <c:forEach var="current2" items="${rs2.rows}">
                                <c:choose>
                                    <c:when test="${!empty param.compcode and param.compcode eq current2.COMP_CODE}">
                                        <option value="${current2.COMP_CODE}" selected="selected">${current2.COMP_CODE}</option>
                                    </c:when>
                                    <c:when test="${!empty param.comp_code_sel and param.comp_code_sel eq current2.COMP_CODE}">
                                        <option value="${current2.COMP_CODE}" selected="selected">${current2.COMP_CODE}</option>
                                    </c:when>
                                    <c:otherwise>
                                        <option value="${current2.COMP_CODE}">${current2.COMP_CODE}</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>                         
                        </select>
                    </form>                   
                    <br/><br/>
                    <div class="n_text_narrow"><label>Division </label></div>
                    <select name="div_code_sel" class="select_box" id="div_code_sel" onchange="this.form.submit();" autocomplete="off">
                    <c:choose>
                    	<c:when test="${empty param.comp_code_sel || param.comp_code_sel eq 'ALL'}">
                   			<option value="ALL">ALL</option>
                   		</c:when>
                   		<c:otherwise>
                        <c:forEach var="current3" items="${rs3.rows}">
                            <c:choose>
                                <c:when test="${!empty param.divcode and param.divcode eq current3.EMP_DIVN_CODE}">
                                    <option value="${current3.EMP_DIVN_CODE}" selected="selected">${current3.EMP_DIVN_CODE}</option>
                                </c:when>
                                <c:when test="${!empty param.div_code_sel and param.div_code_sel eq current3.EMP_DIVN_CODE}">
                                    <option value="${current3.EMP_DIVN_CODE}" selected="selected">${current3.EMP_DIVN_CODE}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${current3.EMP_DIVN_CODE}">${current3.EMP_DIVN_CODE}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>  
                        </c:otherwise>
                        </c:choose>                       
                    </select>
                </div>    
                <div class="l_one">
                    <form method="post" name="musterform" onsubmit="return verify();">
                        <div class="n_text_narrow" id="frdt_label"><label>From Date</label></div>
                        <c:choose>
                            <c:when test="${!empty param.fromdate}">
                                <input class="select_box2" type="text" id="datepicker-2" name="fromdate" value="${param.fromdate}">  
                            </c:when>
                            <c:otherwise>
                                <input class="select_box2" type="text" id="datepicker-2" name="fromdate" autocomplete="off">  
                            </c:otherwise>
                        </c:choose>
                                <br/><br/>
                        <div class="n_text_narrow"><label>To Date</label></div>
                        <c:choose>
                            <c:when test="${!empty param.todate}">
                                <input class="select_box2" type="text" id="datepicker-3" name="todate" value="${param.todate}">  
                            </c:when>
                            <c:otherwise>
                                <input type="text"  class="select_box2"  id="datepicker-3" name="todate" autocomplete="off">  
                            </c:otherwise>
                        </c:choose>
                                <br/><br/>
                        <input type="submit" name="muster" class="sbt_btn" value="Generate muster"/>
                        <input type="hidden" name="compcode" class="sbt_btn" value="" id="compcode"/>
                        <input type="hidden" name="divcode" class="sbt_btn" value="" id="divcode"/>
                    </form>
                </div>    

            </div>
            <c:if test="${pageContext.request.method eq 'POST' and !empty param.compcode and !empty param.divcode}">
                <c:choose>
                    <c:when test="${retval gt 0}">
                        <div class="table-responsive"> 
                            <table id="muster-table" class="table table-bordered small" cellpadding="1" cellspacing="1">
                                <thead>
                                    <tr bgcolor="#2c2c2c" style="color:#FFFFFF;">
                                    	 <th class="tab_h">Company code</th>
                                    	 <th class="tab_h">Division</th>
                                        <th class="tab_h">Employee code</th>
                                        <th class="tab_h" height="20" >Employee name</th>
                                        <th class="tab_h">Present days</th> 
                                        <th class="tab_h">Early go/ Late come</th>                     
                                        <th class="tab_h">Single swipe</th> 
                                        <th class="tab_h">Fully Absent days</th> 
                                        <th class="tab_h">Pending Regularisation</th> 
                                        <th class="tab_h">Pending Leaves</th> 
                                        <th class="tab_h">Leave days</th> 
                                        <th class="tab_h">Absent days</th> 
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${newmuster.lst}" var = "current">

                                        <tr bgcolor="#e1e1e1" style="color:#FFFFFF;"> 
                                            <td class="tab_h2">${current.emp_com_code}</td>
                                             <td class="tab_h2">${current.division}</td>
                                            <td class="tab_h2">${current.empcode}</td>
                                            <td class="tab_h2">${current.empname}</td>                                           
                                            <td class="tab_h2">${current.present}</td>
                                            <td class="tab_h2">${current.earlyOrlate}</td>                       
                                            <td class="tab_h2">${current.singleswipe}</td>
                                            <td class="tab_h2">${current.fulldayAbsent}</td>
                                            <td class="tab_h2">${current.regpend}</td>
                                            <td class="tab_h2">${current.lvpend}</td>
                                            <td class="tab_h2">${current.lvdays}</td>
                                            <td class="tab_h2">${current.absent}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>

                    </c:otherwise>
                </c:choose>
            </c:if>
        </div>
    </body>
</html>
</c:when>
<c:otherwise>
    <html>
        <body onload="window.top.location.href = 'logout.jsp'">
        </body>

    </body>
</html>
</c:otherwise>
</c:choose>