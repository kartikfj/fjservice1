<%-- 
    Document   : mainworkschedule 
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@include file="mainview.jsp" %>
<jsp:useBean id="cmp_param" class="beans.CompParam" scope="session"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:choose>
    <c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1 and fjtuser.role eq 'hr'}">
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><title>Faisal Jassim Trading Co L L C</title>
                <link href="resources/css/wrksch.css" rel="stylesheet" type="text/css" />
                <script>
                    function openTab(evt, tabname) {
                        var pane = document.getElementById("displaywindow");
                        if (tabname == 'staff') {
                            pane.src = "staffworkschedule.jsp";
                        } else if (tabname == 'labour') {
                            pane.src = "labourworkschedule.jsp";
                        }
                    }
                    function setTab() {
                        document.getElementById("stafftab").focus();
                    }
                </script>
            </head>
            <body onload="setTab();">
                <div class="container">
                <ul class="tab">
                    <li><a href="javascript:void(0)" class="tablinks" onclick="openTab(event, 'staff')" id="stafftab">Staff timings</a></li>
                    <li><a href="javascript:void(0)" class="tablinks" onclick="openTab(event, 'labour')">Labour timings</a></li>
                </ul>
                <iframe src="staffworkschedule.jsp" id="displaywindow" style="border: solid 1px #CCCCCC"></iframe>

                </div>
            </body>
        </c:when>
        <c:otherwise>
            <html>
                <body onload="window.top.location.href = 'logout.jsp'">
                </body>

            </body>
        </html>
    </c:otherwise>
</c:choose>