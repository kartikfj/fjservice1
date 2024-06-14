<%-- 
    Document   : holidaycalendar 
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@include file="mainview.jsp" %>
<jsp:useBean id="hday" class="beans.Holiday" scope="session"/>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:choose>
    <c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1 and ( fjtuser.role eq 'hr' or fjtuser.role eq 'hrmgr' )}">
        <jsp:setProperty name="hday" property="compCode" value="${fjtuser.emp_com_code}"/>
        <c:if test="${pageContext.request.method eq 'POST' and param.operationbutton ne 'listing'}">
            <jsp:setProperty name="hday" property="editor" value="${fjtuser.emp_code}"/>
            <jsp:setProperty name="hday" property="newHdayStr" param="holiday"/>
            <jsp:setProperty name="hday" property="newDesc" param="desc"/>
            <jsp:setProperty name="hday" property="compCode" param="comp_code"/>
            <c:if test="${param.operationbutton eq 'save'}">                       
                <c:set var="updatestatus" value="${hday.addHoliday}"/>
            </c:if>
            <c:if test="${param.operationbutton eq 'delete'}">
                <c:set var="updatestatus" value="${hday.delHoliday}"/>
            </c:if>
        </c:if>
        <c:if test="${pageContext.request.method eq 'POST' and param.operationbutton eq 'listing'}">
            <jsp:setProperty name="hday" property="compCode" param="comp_code_sel"/>
        </c:if>
        <c:set var="hdaysize" value="${hday.allHolidaysWithDescofCurYear}"/>     
        <!DOCTYPE html>
        <link href="resources/css/jquery-ui.css" rel="stylesheet">
        <script src="resources/js/jquery-1.10.2.js"></script>
        <script src="resources/js/jquery-ui.js"></script>
        <script>
            var hdaylist = [];
            <c:forEach items="${hday.holidayDetailLst}" var="hdayitem">
            var theitem = new Object();
            theitem.date = '<c:out value="${hdayitem.key}"/>'
            theitem.desc = '<c:out value="${hday.holidayDetailLst[ hdayitem.key ]}"/>'
            hdaylist.push(theitem);
            </c:forEach>
            function DisableHolidays(date) {
                var string = jQuery.datepicker.formatDate('yy-mm-dd', date);
                var i = 0;
                while (i < hdaylist.length) {
                    if (hdaylist[i].date == string)
                        return [true, "ui-state-hover", hdaylist[i].desc];
                    ++i;
                }
                return [true];
            }

            function changeDescription(datetxt) {
                var d1 = $("#datepicker-1").datepicker('getDate');
                var string = jQuery.datepicker.formatDate('yy-mm-dd', d1);
                var i = 0;
                while (i < hdaylist.length) {
                    //console.log(hdaylist[i].date+ " "+ string);
                    if (hdaylist[i].date == string) {
                        document.getElementById("descriptiontxt").value = hdaylist[i].desc;
                        document.getElementById("delbutton").disabled = false;
                        document.getElementById("delbutton").className = "sbt_btn2";
                        return;
                    }
                    ++i;
                }
                document.getElementById("delbutton").disabled = true;
                document.getElementById("delbutton").className = "disabled_button";
            }

            $(function () {
                var curyear = new Date().getFullYear();
                $("#datepicker-1").datepicker({minDate: new Date(curyear, 1, -1, 1), maxDate: '+1Y', dateFormat: 'dd/mm/yy', beforeShowDay: DisableHolidays, onSelect: changeDescription});
            });

            function verify() {
                var desc = document.getElementById("descriptiontxt").value;
                var newhday = document.getElementById("datepicker-1").value;
                var compcode = document.getElementById("comp_code_sel");
                var selectedcomp = compcode.options[compcode.selectedIndex].value;
                //console.log(selectedcomp);
                document.getElementById("comp_code").value = selectedcomp;
                if (desc == null || newhday == null || selectedcomp == null) {
                    alert("Please fill the details.");
                    return false;
                }
                if (desc.trim().length == 0 || newhday.trim().length == 0) {
                    alert("Please fill the details.");
                    return false;
                }
                //console.log("submitted");
                return true;
            }


        </script>


        <sql:query var="rs2" dataSource="jdbc/orclfjtcolocal">
            SELECT COMP_CODE FROM FJPORTAL.FM_COMPANY
        </sql:query>
        <div class="container">
            <div class="att_searchbox" style="border-bottom: gray 1px dotted;">
                <h1>Holidays
	                <a href="homepage.jsp" > <i class="fa fa-home pull-right" title="Home"></i></a>
				    <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a>
                </h1> 
            </div>
            <div class="l_one">
                <label><div class="n_text_narrow" style="margin-right: 8px;border:none"> 
                        Company code</div></label>
                <form method="post" name="thelist">
                    <select name="comp_code_sel" class="select_box" id="comp_code_sel" onchange="this.form.submit();" autocomplete="off">
                        <c:forEach var="current2" items="${rs2.rows}">
                            <c:choose>
                                <c:when test="${!empty param.comp_code_sel and param.comp_code_sel eq current2.COMP_CODE}">
                                    <option value="${current2.COMP_CODE}" selected="selected">${current2.COMP_CODE}</option>
                                </c:when>
                                <c:when test="${!empty param.comp_code and param.comp_code eq current2.COMP_CODE}">
                                    <option value="${current2.COMP_CODE}" selected="selected">${current2.COMP_CODE}</option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${current2.COMP_CODE}">${current2.COMP_CODE}</option>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>                         
                    </select>
                    <input type="hidden" name="operationbutton" id="operationbutton2" value="listing"/>
                </form>

            </div>
            <br/>

            <form onsubmit="return verify();" method="post">

                <div class="l_one">
                    <div class="n_text_narrow" style="margin-right: 8px;border:none"><label>Holiday : &nbsp;</label></div>
                    <input class="select_box2" type="text" id="datepicker-1" name="holiday" value="" />               
                </div>
                <div class="l_one">
                    <div class="n_text_narrow" style=" margin-right: 8px;border:none"><label>Description : &nbsp;</label></div>
                    <input type="text" class="select_box2" id="descriptiontxt" name="desc" value=""/>
                </div>
                <br/>
                <div class="l_one" style="margin-right: 8px;"> 

                    <input name="savebutton" type="submit" value="Save" id="savebutton" class="sbt_btn" style="float:left;padding: 4px 17px;" onclick="document.getElementById('operationbutton').value = 'save';return true;"/>                 
                    <input name="delbutton" type="submit" value="Delete" id="delbutton" class="disabled_button" disabled="true" id="delbutton" style="float:left;padding: 4px 17px;" onclick="document.getElementById('operationbutton').value = 'delete';return true;"/>
                </div>
                <input type="hidden" name="operationbutton" id="operationbutton" value=""/>
                <input type="hidden" name="comp_code" id="comp_code" value="" class="disabled_input"/>    
            </form>       

            <br/>  <br/><br/>

            <div class="n_text_msg" style="float:none;width:45%"> 
                <div class="att_searchbox" style="border-bottom: gray 1px dotted;">
                    <h1>Current holiday calender</h1> 
                </div>
                <br>
                <div style="width:90%"> 
                    <div class="table-responsive">  
                        <table class="table" cellpadding="1" cellspacing="1">
                            <thead>
                                <tr bgcolor="#2c2c2c" style="color:#FFFFFF;">
                                    <th class="tab_h">Holiday</th>
                                    <th class="tab_h">Description</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${hday.holidayDetailLst}" var="hdayitem"> 
                                    <fmt:formatDate pattern="dd-MM-yyyy" var="cfmdt" value="${hdayitem.key}" />
                                    <tr bgcolor="#e1e1e1" style="color:#000000;"> 
                                        <td class="tab_h2">${cfmdt}</td>
                                        <td class="tab_h2">${hday.holidayDetailLst[ hdayitem.key ]}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
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