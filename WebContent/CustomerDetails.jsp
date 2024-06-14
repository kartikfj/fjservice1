<%-- 
    Document   : businesstripleaveappln.jsp 
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="mainview.jsp" %>
<%@page import="java.util.concurrent.ConcurrentHashMap"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Calendar"%>


<c:choose>
    <c:when test="${!empty fjtuser.emp_code  and fjtuser.checkValidSession eq 1}">     
       
	    <jsp:useBean id="businessleave" class="beans.OraclePage" scope="request"/>       
      
<%--        <c:set var="pendsize" value="${businessleave.allPendingLeaveApplications}"/>  --%>
        <%  java.util.Date start_dt = ((beans.CompParam) request.getSession().getAttribute("cmp_param")).getCurrentProcMonthStartDate();
            Calendar cal = Calendar.getInstance();
            cal.setTime(start_dt);
            int month = cal.get(Calendar.MONTH);
            int day = cal.get(Calendar.DAY_OF_MONTH);
            int year = cal.get(Calendar.YEAR);
            String today = day + "/" + month + "/" + year;
        %>
       
        <!DOCTYPE html>
        <head>
        
          <style>
          input[type="date"]::-webkit-clear-button {
    display: none;
}

/* Removes the spin button */
input[type="date"]::-webkit-inner-spin-button { 
    display: none;
}

/* Always display the drop down caret */
input[type="date"]::-webkit-calendar-picker-indicator {
    color: #2c3e50;
}

hr{margin-top:15px;margin-bottom:10px;border:0;border-top:1px solid #eeeeee;}

/* A few custom styles for date inputs */
input[type="date"] {
    appearance: none;
    -webkit-appearance: none;
    color: #95a5a6;
    font-family: "Helvetica", arial, sans-serif;
    font-size: 18px;
    border:1px solid #ecf0f1;
    background:#ecf0f1;
    padding:5px;
    display: inline-block !important;
    visibility: visible !important;
}

input[type="date"], focus {
    color: #95a5a6;
    box-shadow: none;
    -webkit-box-shadow: none;
    -moz-box-shadow: none;
}
  
.l_left1{width:48%; float:left; padding-right:1%;} 
.l_left2{width:26%; float:left;padding-right:1%;} 
.l_right1{width:49%; float:right;padding-right:1%;}
.l_leftcustome{width:50%; height:50px;float:left; padding-right:1%;}
.l_rightcustome{width:50%; float:right;}
.l_one{width:50%; float:left; margin: 0 0 0.5em 0;font-family: Arial, Helvetica, sans-serif;}
.l_left{width:48%; float:left;border-right:None ! important}
.l_right{width:49%; float:right;}
     
</style>
            <link href="resources/css/jquery-ui.css" rel="stylesheet">
            <script src="resources/js/jquery-1.10.2.js"></script>
            <script src="resources/js/jquery-ui.js"></script>
            <script src="resources/js/leaveapplication.js?v=15062022"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>           		    
            <!-- Javascript -->
            <script>
            
  
           
                
               

                function checkUid(uidbox){
                   //var uid = document.getElementById('fjuid').value;  
                   var uid = uidbox.value;
                  
                        //valid format - send it to server to check if it is a new user
                       // alert("valid format");//subtype
                       document.getElementById('subtype').value="uidchk";
                      // console.log(uidbox.form);
                      window.sessionStorage.setItem("lastlogin",uid); 
                       uidbox.form.submit();
                       return true;
                   
                }
                function verifyEnter(event){
                    if (event.which === 13) {
                        event.stopPropagation();
                        event.preventDefault();
                        var uid = document.getElementById('traveler_emp_code').value;       
                        if(uid!=null)
                        uid = uid.trim();   
                        if(uid.length == 0)
                        {
                            alert("Please enter empcode");
                            return false;
                        }                          
                        }
                }
               
            </script>
            
        </head>
        <div class="container">
        
        	<div class="panel panel-default  small" id="fj-page-head-box">
                     <div class="panel-heading" id="fj-page-head">
                        
                        <h4 class="text-left">
                       		Customer Details
	                       <a href="homepage.jsp" > <i class="fa fa-home pull-right" title="Home"></i></a>
	                       <a href="javascript:history.back()"><i class="fa fa-step-backward pull-right" title="Back"></i></a>                   
                       </h4>
                      
                     </div>
            </div>
            <div class="rest_box1">
                <c:choose>
                    <c:when test="${pageContext.request.method eq 'POST'}">                         
                       <c:if test="${!empty param.applybutton and param.applybutton eq 'Apply'}"> 
                            <c:set var="appstatus" value="${0}"/>                           
                            <jsp:setProperty name="businessleave" property="travelerUid" param="traveler_emp_code"/>
                            <jsp:setProperty name="businessleave" property="travelUName" param="travelUName"/>
                            <jsp:setProperty name="businessleave" property="emp_code" value="${fjtuser.emp_code}"/>                                 
                            <c:set var="appstatus" value="${businessleave.saveOraclePage}"/>
                            <c:set var="refresh" value="${businessleave.refreshOraclePage}"/> 
                            
                            <c:choose>
                                <c:when test="${appstatus eq 1}">                                   
                                     <form method="POST" action="CustomerDetails.jsp">
										<div class="l_left">
			                                <div class="l_one">
			                                	  <div class="n_text_narrow" id="frdt_label">Customer ID<span>*</span></div>
			                                	  <input type="hidden" name="subtype" value="" id="subtype" /> 
			                                      <input type="text" class="leave_text" id="travelerUid" name="traveler_emp_code" tabindex="1"  onblur="return checkUid(this);" onkeypress="verifyEnter(event);"  autocomplete="off" required="required">
			                                </div>  
			                                <div class="l_one">
			                                	   <div class="n_text_narrow" id="frdt_label">Description</div>
			                                       <input type="text" class="text_area" id="traveluName" name="traveluName"  required="required">
			                                 </div>
			                                </div>  
			
			                            <div class="clear"></div>
			                            <div class="s_box2">
			                                <input name="operationbutton" type="hidden" value="" id="calbutton" />
			                                <input name="applybutton" type="button" value="Apply" class="sbt_btn" onclick='invokeApply(this);' />
			                                <input name="resetbutton" type="reset" value="Cancel" class="btn_can" />
			                            </div>
			                        </form>
			                         <div class="l_one">
                                        <div class="n_text_msg">
                                            Updated successfully.
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                <div class="n_text_msg">
                                          Something was wrong.
                                    </div>
                                </c:otherwise>
                            </c:choose>

                        </c:if> 
                      
                        <c:if test="${param.subtype eq 'uidchk'}">                                                				
	                          <jsp:setProperty name="businessleave" property="traveler_emp_code" param="traveler_emp_code"/> 
	                          <c:set var="loginstatus" value="${businessleave.checkUid}"/> 	                         
	                         <form method="POST" action="CustomerDetails.jsp">
	                         <%--  <div class="l_one"> --%> 
	                         <div class="l_left">
	                            <div class="l_one">	                               
                               	  <div class="n_text_narrow" id="frdt_label">Customer IDD<span>*</span></div>
                               	  <input type="hidden" name="subtype" value="" id="subtype" /> 
                                  <input type="text" class="leave_text" id="travelerUid" name="traveler_emp_code" tabindex="1" onblur="return checkUid(this);" onkeypress="verifyEnter(event);" value="${param.traveler_emp_code}" required="required">
                                   <c:if test="${loginstatus eq -1}"><div class="l_right" style="text-decoration:none; color: red">Invalid User</div>
                                   </c:if>	
                                 </div>
                                 <div class="l_one">
                                	  <div class="n_text_narrow" id="frdt_label">Description</div>
                                       <input type="text" class="text_area"  id="traveluName" name="travelUName"  tabindex="2" value="${businessleave.travelUName}" required="required">
                                 </div> 
                                
                          <%--  </div>      --%>                       
                            <div class="clear"></div>
	                            <div class="s_box2">
	                                 <input type="hidden" name="projectDetails" class="sbt_btn" value="" id="projectDetails"/>
	                        	     <input type="hidden" name="purpose" class="sbt_btn" value="" id="purpose"/>
	                        	     <input type="hidden" name="otherDetails" class="sbt_btn" value="" id="otherDetails"/>	                        	    
	                                <input name="applybutton" type="submit" value="Apply" class="sbt_btn"/>
	                            </div>
	                        </form> 
                    </c:if>  
                    </c:when>	
                   
                    <c:otherwise>
                        <form method="POST" action="CustomerDetails.jsp"> 
		                     		                
                           <div class="l_left">

                                <div class="l_one">
                                	  <div class="n_text_narrow" id="frdt_label">Customer ID<span>*</span></div>
                                	  <input type="hidden" name="subtype" value="" id="subtype" /> 
                                      <input type="text" class="leave_text" id="travelerUid" name="traveler_emp_code" tabindex="1" value="${param.traveler_emp_code}" onblur="return checkUid(this);" onkeypress="verifyEnter(event);"  autocomplete="off" required="required">
                                </div>  
                                <div class="l_one">
                                	   <div class="n_text_narrow" id="frdt_label">Description</div>
                                       <input type="text" class="text_area" id="traveluName" name="traveluName"  required="required">
                                 </div>  

                            <div class="clear"></div>
                            <div class="s_box2">
                                <input name="operationbutton" type="hidden" value="" id="calbutton" />
                                <input name="applybutton" type="button" value="Apply" class="sbt_btn" onclick='invokeApply(this);' />
                                <input name="resetbutton" type="reset" value="Cancel" class="btn_can" />
                            </div>
                        </form>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="att_searchbox">
                <h1>Customer Details Results</h1>
            </div>
            <c:choose> 
                <c:when test="${!empty businessleave.refreshOraclePage}">
<%--                  <jsp:setProperty name="businessleave" property="emp_code" value="${fjtuser.emp_code}"/> --%>
                    <div class="table-responsive">  
                        <table class="table" cellpadding="1" cellspacing="1">
                            <thead>
                                <tr bgcolor="#2c2c2c" style="color:#FFFFFF;">
                                    <th class="tab_h">Customer ID</th>
                                    <th class="tab_h">Description</th>
                                     
                                </tr>                
                            </thead>
                            <tbody>
                                <c:forEach items="${businessleave.pendleaveapplications}" var = "current">
                                                                  
                                    <tr bgcolor="#e1e1e1" style="color:#FFFFFF;">                                        
                                      
                                        <td class="tab_h2">${current.name}</td>
                                        <td class="tab_h2">${current.description}</td> 
                                    </tr>
                                </c:forEach>                               
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>    
                    <div class="rest_box">
                        <div class="l_one">
                            <div class="n_text_msg">
                                No pending leave applications.
                            </div>
                        </div>
                    </div>

                </c:otherwise>
            </c:choose>   
        </div>   


        <div class="clear"></div>
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