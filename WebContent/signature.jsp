<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.io.*"%>

<%@page import="javax.activation.DataHandler" %>
<%@page import="javax.activation.DataSource"%>
<%@page import="javax.activation.FileDataSource" %>
<%@ page trimDirectiveWhitespaces="true" %>
<% 			 
     response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
     response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
     response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
     response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
  %>
  <jsp:useBean id="fjtuser" class="beans.fjtcouser" scope="session"/>     
  <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
  <%
  InputStream is=null;
  OutputStream os = response.getOutputStream();     
  int len = 0;
  DataSource fds;	    
  byte[] b = new byte[1024];
  try{	 
		 
	     String signtype =  request.getParameter("signtype");
	     String compCode =  request.getParameter("compCode");
	    
	     
	    
	     if(signtype.equals("header")){	    	 
			  File f = new File("D://SIGNATURES/HEADERS/fjlogo.jpg");
			  if(f.exists()){
				  fds = new FileDataSource("D://SIGNATURES/HEADERS/fjlogo.jpg");
			  }
			  else{
				  fds = new FileDataSource("D://SIGNATURES/HEADERS/001.jpg");
			  }	  
			  is = fds.getInputStream(); 
			  if(is !=null){
				  while ((len = is.read(b)) > 0) {
				        os.write(b, 0, len);
				  }
				  os.flush();
			 	 } 
	     }else if(signtype.equals("footer")){
	    	 File f = new File("D://SIGNATURES/FOOTERS/"+compCode+".png");
	    	 
			  if(f.exists()){ 
				  fds = new FileDataSource("D://SIGNATURES/FOOTERS/"+compCode+".png");
				  System.out.println("in footer"+compCode);
			  }
			  else{
				  fds = new FileDataSource("D://SIGNATURES/FOOTERS/001.png");
			  }	  
			  is = fds.getInputStream(); 
			  if(is !=null){
				  while ((len = is.read(b)) > 0) {
				        os.write(b, 0, len);
				  }
				  os.flush();
			 	 } 
	    	 
	     }
	     else if(signtype.equals("hrsign")){
	    	 File f = new File("D://SIGNATURES/HRSIGN/hrsign.png");
			  if(f.exists()){
				  fds = new FileDataSource("D://SIGNATURES/HRSIGN/hrsign.png");
			  }
			  else{
				  fds = new FileDataSource("D://SIGNATURES/HRSIGN/hrsign.png");
			  }	  
			  is = fds.getInputStream(); 
			  if(is !=null){
				  while ((len = is.read(b)) > 0) {
				        os.write(b, 0, len);
				  }
				  os.flush();
			 	 } 
	    	 
	     }
	  }catch (Exception e) {
	   }
      finally {
	    	  try {
	    		  is.close();
	    	      os.close();
	             
	          } catch (Exception e) {
	        	  System.out.print("Error in Finally block of profileimage"+e);
	          }
	        

	      }
  %>
