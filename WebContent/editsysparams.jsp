<%-- 
    Document   : editsysparams 
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@include file="mainview.jsp" %>
<jsp:useBean id="cmp_param" class="beans.CompParam" scope="session"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:choose>
    <c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1 and ( fjtuser.role eq 'hr' or fjtuser.role eq 'hrmgr' )}">
        <c:if test="${pageContext.request.method eq 'POST'}">
            <c:if test="${param.operationbutton eq 'saveproc'}">
                <jsp:setProperty name="cmp_param" property="ref_date" param="procmb"/>
                <jsp:setProperty name="cmp_param" property="year" param="yearlist"/>
                <jsp:setProperty name="cmp_param" property="month" param="monthlist"/>
                <jsp:setProperty name="cmp_param" property="editor" value="${fjtuser.emp_code}"/>
                <c:set var="procstatus" value="${cmp_param.addCurProcMonth}"/>
                <c:set var="refreshstatus" value="${cmp_param.readCurrentProcMonthStartDate}"/>
            </c:if>
        </c:if>
        <sql:query var="rs" dataSource="jdbc/mysqlfjtcolocal">
            SELECT  param_value, month(valid_from) as month , year(valid_from) as year FROM  system_params where param_name= 'CUR_PROCM_START' and status=1 order by valid_from desc
        </sql:query>
        <!DOCTYPE html>
        <link rel='stylesheet' type='text/css' href="resources/css/timepicki.css" />
        <link href="resources/css/jquery-ui.css" rel="stylesheet">
        <script src="resources/js/jquery-1.10.2.js"></script>
        <script src="resources/js/jquery-ui.js"></script>

        <script>
            $(function () {
                //var curyear=new Date().getFullYear();
                $("#datepicker-1").datepicker({minDate: new Date('${cmp_param.currentProcMonthStartDate}'), maxDate: '+1Y', dateFormat: 'dd/mm/yy'});
            });

            function addOption(selectbox, text, value, status)
            {
                var optn = document.createElement("OPTION");
                optn.text = text;
                optn.value = value;
                if (status == 'selected')
                    optn.selected = 'selected';
                selectbox.options.add(optn);

            }
            function populateMonthAndYear() {
                var curyear = ${cmp_param.procYear}; //new Date().getFullYear(); 
                var beginning = ${cmp_param.procMonth};
                if (beginning == 12) {
                    addOption(document.getElementById("yearlist"), curyear + 1, curyear + 1, "selected");
                    beginning = 0;
                } else {
                    addOption(document.getElementById("yearlist"), curyear, curyear, "selected");
                }

                var month = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
                for (var i = beginning; i < month.length; ++i) {
                    if (i == beginning)
                        addOption(document.getElementById("monthlist"), month[i], [i + 1], "selected");
                    else
                        addOption(document.getElementById("monthlist"), month[i], [i + 1], "");
                }
            }

            function verify() {
                var newprocday = document.getElementById("datepicker-1").value;
                var yr = document.getElementById("yearlist").value;
                var mth = document.getElementById("monthlist").value;
                if (newprocday == null || yr == null || mth == null)
                {
                    alert("Please fill the deatils.");
                    return false;
                } else if (newprocday.trim().length == 0) {
                    alert("Please fill the deatils.");
                    return false;
                }
                newprocday = newprocday.trim();
                return true;
            }


        </script>
    </head>
    <body onload="populateMonthAndYear();">
        <div class="container">
            <div class="att_searchbox">
                <h1>System parameters
                    <a href="homepage.jsp" > <i class="fa fa-home pull-right" title="Home"></i></a> 
				    <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a>
			    </h1> 
                <c:if test="${!empty errormessage}">
                    <c:out value="${errormessage}"/>
                </c:if>
            </div>
            <div class="n_text_msg" style="float:left;width:60%"> 
                <br/>
                <div class="att_searchbox"><h1>Last processing month beginning : ${cmp_param.currentProcMonthStartDate}</h1> </div> <br/><br>
                <form method="post" onsubmit="return verify();">  
                    <div class="l_one">
                        <div class="n_text_narrow" style="width:10%"><label>Year: </label></div>
                        <select id="yearlist" class="select_box" name="yearlist"> </select></div>
                    <div class="l_one"> <div class="n_text_narrow" style="width:10%"><label>Month:</label></div>
                        <select id="monthlist" class="select_box" name="monthlist"> </select> 
                    </div>
                    <div class="l_one"><div class="n_text_narrow" style="width:40%"><label>Processing month beginning: </label></div>
                        <input class="select_box2" type="text" id="datepicker-1" name="procmb" value="" /> 
                    </div>
                    <div class="l_one"> <!--<input name="delbutton" type="submit" value="Delete" id="delbutton" class="sbt_btn2" style="float:right;padding: 4px 17px;" onclick="document.getElementById('operationbutton').value='delete';return true;"/> -->
                        <input name="savebutton" type="submit" value="Save" id="savebutton" class="sbt_btn" style="float:right;padding: 4px 17px;" onclick="document.getElementById('operationbutton').value = 'saveproc';return true;"/>
                        <input type="hidden" name="operationbutton" id="operationbutton" value=""/></div>
                </form>
            </div>
            <c:choose>
                <c:when test="${!empty rs.rows}">
                    <div class="table-responsive">  
                        <table class="table" cellpadding="1" cellspacing="1">
                            <thead>
                                <tr bgcolor="#2c2c2c" style="color:#FFFFFF;">
                                    <td class="tab_h">Year</td>
                                    <td class="tab_h" height="20" >Month</td>
                                    <td class="tab_h">Processing month beginning</td>   
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="current" items="${rs.rows}">
                                    <tr bgcolor="#e1e1e1" style="color:#000000;"> 
                                        <td class="tab_h2">${current.year}</td> 
                                        <td class="tab_h2">${current.month}</td> 
                                        <td class="tab_h2">${current.param_value}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="n_text_lvdetails">
                        No entries.
                    </div>
                </c:otherwise>
            </c:choose>
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