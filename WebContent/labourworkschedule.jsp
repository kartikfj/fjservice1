<%-- 
    Document   : workschedule 
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@include file="mainview.jsp" %>
<jsp:useBean id="cmp_param" class="beans.CompParam" scope="session"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:choose>
    <c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1 and ( fjtuser.role eq 'hr' or fjtuser.role eq 'hrmgr' )}">  
        <jsp:useBean id="newsch" class="beans.WorkSchedule" scope="request"/>
        <jsp:setProperty name="newsch" property="companyCode" value="${fjtuser.emp_com_code}"/>
        <c:set var="errormessage" value=""/> 
        <c:if test="${pageContext.request.method eq 'POST'}">                     
            <c:choose>
                <c:when test="${param.operationbutton eq 'savesch'}">
                    <jsp:setProperty name="newsch" property="dayStartStr" param="staff_fromtime"/>
                    <jsp:setProperty name="newsch" property="dayEndStr" param="staff_totime"/>
                    <jsp:setProperty name="newsch" property="valid_fromStr" param="schfrom"/>
                    <jsp:setProperty name="newsch" property="valid_toStr" param="schto"/>
                    <jsp:setProperty name="newsch" property="type" value="LABOUR"/>
                    <jsp:setProperty name="newsch" property="editor" value="${fjtuser.emp_code}"/>
                    <jsp:setProperty name="newsch" property="companyCode" value="${param.compcode}"/>
                    <c:set var="staffSchValidity" value="${newsch.checkScheduleValidity}"/>           
                    <c:if test="${staffSchValidity eq 1}">               
                        <c:set var="staffupdate" value="${newsch.addNewWorkSchedule}"/>
                    </c:if>  
                </c:when>
                <c:when test="${param.operationbutton eq 'delsch'}">
                    <jsp:setProperty name="newsch" property="dayStartStr" param="staff_fromtime"/>
                    <jsp:setProperty name="newsch" property="dayEndStr" param="staff_totime"/>
                    <jsp:setProperty name="newsch" property="valid_fromStr" param="schfrom"/>
                    <jsp:setProperty name="newsch" property="valid_toStr" param="schto"/>
                    <jsp:setProperty name="newsch" property="type" value="LABOUR"/>
                    <jsp:setProperty name="newsch" property="editor" value="${fjtuser.emp_code}"/>
                    <jsp:setProperty name="newsch" property="companyCode" value="${param.compcode}"/>
                    <c:set var="staffupdate" value="${newsch.delWorkSchedule}"/>
                </c:when>
                <c:when test="${param.operationbutton eq 'listing'}">
                    <jsp:setProperty name="newsch" property="companyCode" value="${param.comp_code_sel}"/>
                </c:when>
            </c:choose>
        </c:if>      
        <sql:query var="rs" dataSource="jdbc/mysqlfjtcolocal">
            SELECT valid_from ,valid_to, min(param_value) as starttime, max(param_value) as endtime FROM  system_params where (param_name= 'LABOUR_DAY_START' or param_name= 'LABOUR_DAY_END') and status=1 and company_code=? group by valid_from,valid_to
            <sql:param>${newsch.companyCode}</sql:param>
        </sql:query>
        <sql:query var="rs2" dataSource="jdbc/orclfjtcolocal">
            SELECT COMP_CODE FROM FJPORTAL.FM_COMPANY where COMP_FRZ_FLAG = 'N' order by COMP_CODE
        </sql:query>      

        <html>
            <head>
                <link href="resources/css/wrksch.css" rel="stylesheet" type="text/css" />
                <link rel='stylesheet' type='text/css' href="resources/css/timepicki.css" />
                <link href="resources/css/jquery-ui.css" rel="stylesheet">
                <script src="resources/js/jquery-1.10.2.js"></script>
                <script src="resources/js/jquery-ui.js"></script>
                <script src="resources/js/timepicki.js"></script>
                <script>
                    $(function () {
                        $("#datepicker-2").datepicker({minDate: new Date('${newsch.lastScheduleStartDateForLabour}'), maxDate: '+1Y', dateFormat: 'dd/mm/yy'});
                        // $( "#datepicker-3" ).datepicker({minDate : new Date('${cmp_param.currentProcMonthStartDate}'), maxDate : '+1Y',dateFormat: 'dd/mm/yy',disabled: true});
                        $('#staff_fromtime').timepicki({show_meridian: false,
                            min_hour_value: 0,
                            max_hour_value: 23,
                            step_size_minutes: 15,
                            overflow_minutes: true,
                            increase_direction: 'up',
                            disable_keyboard_mobile: true});
                        $('#staff_totime').timepicki({show_meridian: false,
                            min_hour_value: 0,
                            max_hour_value: 23,
                            step_size_minutes: 15,
                            overflow_minutes: true,
                            increase_direction: 'up',
                            disable_keyboard_mobile: true});

                    });
                    function verifySchedule() {
                        var staff_fromtime = document.getElementById("staff_fromtime").value;
                        var staff_totime = document.getElementById("staff_totime").value;
                        var sch1 = document.getElementById("datepicker-2").value;
                        var sch2 = document.getElementById("datepicker-3").value;
                        if (staff_fromtime == null || staff_totime == null || sch1 == null || sch2 == null) {
                            alert(" Please fill the details");
                            return false;
                        } else if (staff_fromtime.trim().length == 0 || staff_totime.trim().length == 0 || sch1.trim().length == 0 || sch2.trim().length == 0) {
                            alert(" Please fill the details");
                            return false;
                        }
                        var compcode = document.getElementById("comp_code_sel");
                        var selectedcomp = compcode.options[compcode.selectedIndex].value;
                        console.log(selectedcomp);
                        document.getElementById("compcode").value = selectedcomp;
                        document.getElementById("staff_fromtime").value = staff_fromtime.trim().replace(/ /g, "") + ":00";
                        document.getElementById("staff_totime").value = staff_totime.trim().replace(/ /g, "") + ":00";
                        return true;
                    }
                    function closeDiv() {
                        document.getElementById("messagebox").style.display = "none";
                        return;
                    }
                </script>
            </head>
            <body>
                <div class="container">
                    <h1>Work schedules : Labourers &nbsp;
			            <a href="homepage.jsp" > <i class="fa fa-home pull-right" title="Home"></i></a>
			            <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a>   
		            </h1>
                    <div class="n_text_msg" style="float:right;width: auto">Relaxation of 30 minutes in the beginning and 10 minutes at the end is applied for all schedules automatically.</div>

                    <c:if test="${pageContext.request.method eq 'POST' and param.operationbutton eq 'savesch'}">   
                        <c:choose>
                            <c:when test="${staffSchValidity eq 1}">               
                                <c:if test="${staffupdate eq 1}">
                                    <div class="n_text_msg" style="float:left;width:60%" id="messagebox">
                                        &nbsp;Successfully added new schedule.
                                    </div> 
                                </c:if>
                                <c:if test="${staffupdate ne 1}">
                                    <div class="n_text_msg" style="float:left;width:60%" id="messagebox">
                                        &nbsp;Failed to add new schedule.
                                    </div>
                                </c:if>

                            </c:when> 
                            <c:when test="${staffSchValidity eq 0}">               
                                <div class="n_text_msg" style="float:left;width:60%" id="messagebox">
                                    Cannot add new schedule for the specified time period. Already scheduled. Do you want to overwrite? 
                                    <form method="post">
                                        <input type="hidden" name="schfrom"  value="${param.schfrom}"/> 
                                        <input type="hidden" name="schto"  value="${param.schto}"/> 
                                        <input type="hidden" name="staff_fromtime"  value="${param.staff_fromtime}"/> 
                                        <input type="hidden" name="staff_totime"  value="${param.staff_totime}"/> 
                                        <input type="hidden" name="operationbutton" value="updatesch"/>
                                        <input type="hidden" name="editor" id="editorid" value="${fjtuser.emp_code}"/>
                                        <input type="submit" class="btn_can" value="Update"/> 
                                        <input type="hidden" name="compcode"  value="${param.compcode}"/> 
                                        <input type="button" class="btn_can" value="Cancel" onclick="closeDiv();"/> 
                                    </form>
                                </div>
                            </c:when>              
                            <c:otherwise>
                                <div class="n_text_msg" style="float:left;width:60%" id="messagebox">
                                    Cannot add new schedule for the specified time period. It overlaps the existing schedule(s). Please edit the existing one.</div>
                                </c:otherwise>
                            </c:choose>

                    </c:if>

                    <form class="form-horizontal" method="post" name="listform">
                        <div class="form-group">
                            <label class="col-sm-3">Company code</label>
                            <div class="col-sm-3"> 
                                <select name="comp_code_sel" class="select_box" id="comp_code_sel" onchange="this.form.submit();" autocomplete="off">
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
                            </div>
                        </div>
                        <input type="hidden" name="operationbutton" id="operationbutton2" value="listing"/>
                    </form>
                    <form class="form-horizontal" method="post" onsubmit="return verifySchedule();">       
                        <div class="form-group">   
                            <label  class="col-sm-3">New work schedule from </label>
                            <div class="col-sm-3"> <input class="form-control" type="text" id="datepicker-2" name="schfrom" value="" /></div>
                            <label  class="col-sm-1"> to</label>
                            <div class="col-sm-3"><input class="form-control" type="text" id="datepicker-3" name="schto" value="31/12/2099" /> </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-3">Staff timing :</label>
                            <div class="col-sm-3"> <input class="form-control" id="staff_fromtime" name="staff_fromtime" size="7" /> </div>
                            <label  class="col-sm-1">to</label>
                            <div class="col-sm-3"><input name="staff_totime" class="form-control" id ="staff_totime" size="7" /></div>
                        </div>
                        <div class="form-group">
                            <input type="hidden" name="operationbutton" id="toperationbutton" value=""/>
                            <input type="hidden" name="compcode" id="compcode" value=""/>
                            <input type="hidden" name="editor" id="editorid" value="${fjtuser.emp_code}"/> 
                            <input name="savebutton" type="submit" value="Save" id="tsavebutton" class="sbt_btn" style="padding: 4px 17px;" onclick="document.getElementById('toperationbutton').value = 'savesch';return true;"/>
                        </div>
                    </form> 
                    <!--iframe name="result" style="width:1em; float:right; height:1em;border:0px"></iframe-->
                        <c:choose>
                            <c:when test="${!empty rs.rows}">
                            <div class="table-responsive">
                                <table class="table" width="100%" cellpadding="1" cellspacing="1">
                                    <thead>
                                        <tr style="color:#FFFFFF;" bgcolor="#2c2c2c">
                                            <th class="tab_h">Effective from</th>
                                            <th class="tab_h" height="20" >Effective to</th>
                                            <th class="tab_h">Work start time</th>   
                                            <th class="tab_h">Work end time </th>   
                                            <th></th>
                                        </tr>  
                                    </thead>
                                    <tbody>
                                        <c:forEach var="current" items="${rs.rows}">
                                            <fmt:formatDate pattern="dd/MM/yyyy" var="cfmdt" value="${current.valid_from}" />
                                            <fmt:formatDate pattern="dd/MM/yyyy" var="afmdt" value="${current.valid_to}" />
                                            <tr bgcolor="#e1e1e1" style="color:#000000;"> 
                                                <td class="tab_h2">${cfmdt}</td>
                                                <td class="tab_h2"><c:out value="${afmdt}"/></td>
                                                <td class="tab_h2">${current.starttime}</td> 
                                                <td class="tab_h2">${current.endtime}</td> 
                                                <td>
                                                    <c:if test="${current.valid_from.time gt cmp_param.currentProcMonthStartDate.time and current.valid_to.time gt cmp_param.currentProcMonthStartDate.time}">
                                                        <form method="post">
                                                            <input type="hidden" name="schfrom"  value="${cfmdt}"/> 
                                                            <input type="hidden" name="schto"  value="${afmdt}"/> 
                                                            <input type="hidden" name="staff_fromtime"  value="${current.starttime}"/> 
                                                            <input type="hidden" name="staff_totime"  value="${current.endtime}"/> 
                                                            <input type="hidden" name="operationbutton" value="delsch"/>
                                                            <input type="submit" class="btn_can" value="Delete"/>
                                                        </form>    
                                                    </c:if>                       
                                                </td>
                                            </tr>

                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="n_text_lvdetails">
                                No schedules.
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