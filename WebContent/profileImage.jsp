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
  try{	 
		  int len = 0;
		  DataSource fds;	    
		  byte[] b = new byte[1024];
		  
		  File f = new File("//fjtco-ho-svr-03/HR-emp_photo/PHOTO/EMPLOYEES/"+fjtuser.getEmp_code()+".jpg");
		  System.out.println("isFile() emp fff photo///  "+f.exists());
		  if(f.exists()){
			  fds = new FileDataSource("//fjtco-ho-svr-03/HR-emp_photo/PHOTO/EMPLOYEES/"+fjtuser.getEmp_code()+".jpg");
		      System.out.println("success in loading the image");
		  }
		  else{
			  fds = new FileDataSource("D://FJWISHES/CONFIG/E000000.jpg");
		      System.out.println("loading the default image");
		  }	  
		  is = fds.getInputStream(); 
		  if(is !=null){
			  while ((len = is.read(b)) > 0) {
			        os.write(b, 0, len);
			  }
			  os.flush();
		 	 } 
	  }catch (Exception e) {
		  System.out.println("Error in catch block"+e);
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
