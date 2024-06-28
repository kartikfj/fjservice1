<%@page contentType="image/jpeg" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.ServletContext" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    InputStream is = null;
    OutputStream os = response.getOutputStream();

    try {
        String empCode = (String) session.getAttribute("emp_code");
        String imagePath = "//fjtco-ho-svr-03/HR-emp_photo/PHOTO/EMPLOYEES/" + empCode + ".jpg";
        
        File imageFile = new File(imagePath);
        if (!imageFile.exists()) {
            imagePath = "D://FJWISHES/CONFIG/E000000.jpg"; // Default image path
        }

        is = new FileInputStream(imagePath);
        byte[] buffer = new byte[1024];
        int bytesRead;

        while ((bytesRead = is.read(buffer)) != -1) {
            os.write(buffer, 0, bytesRead);
        }
    } catch (IOException e) {
        e.printStackTrace();
    } finally {
        try {
            if (is != null) is.close();
            os.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
%>
