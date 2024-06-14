<%@page import="beans.HrPolicy"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% String company = request.getParameter("company");%> 
<%HrPolicy hp=new HrPolicy();%>
<%= hp.getNameList(company) %>