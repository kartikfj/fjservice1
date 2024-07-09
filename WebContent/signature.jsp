<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.*" %>

<%@ page trimDirectiveWhitespaces="true" %>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "no-cache");

    InputStream is = null;
    OutputStream os = response.getOutputStream();
    byte[] buffer = new byte[1024];
    int bytesRead;

    try {
        String signtype = request.getParameter("signtype");
        String compCode = request.getParameter("compCode");
        
        // Determine the file path based on the signtype and compCode
        String filePath = null;
        if ("header".equalsIgnoreCase(signtype)) {
            filePath = "D://SIGNATURES/HEADERS/fjlogo.jpg";
            if (!new File(filePath).exists()) {
                filePath = "D://SIGNATURES/HEADERS/001.jpg";
            }
        } else if ("footer".equalsIgnoreCase(signtype)) {
            filePath = "D://SIGNATURES/FOOTERS/" + compCode + ".png";
            if (!new File(filePath).exists()) {
                filePath = "D://SIGNATURES/FOOTERS/001.png";
            }
        } else if ("hrsign".equalsIgnoreCase(signtype)) {
            filePath = "D://SIGNATURES/HRSIGN/hrsign.png";
            if (!new File(filePath).exists()) {
                filePath = "D://SIGNATURES/HRSIGN/default.png"; // Fallback to a default file
            }
        }

        // Check if the file path is set and the file exists
        if (filePath != null && new File(filePath).exists()) {
            is = new FileInputStream(filePath);
            
            // Set the response content type based on file extension (basic handling)
            if (filePath.endsWith(".jpg") || filePath.endsWith(".jpeg")) {
                response.setContentType("image/jpeg");
            } else if (filePath.endsWith(".png")) {
                response.setContentType("image/png");
            } else {
                response.setContentType("application/octet-stream");
            }
            response.setHeader("Content-Disposition", "attachment; filename=\"" + new File(filePath).getName() + "\"");

            // Write file content to the response output stream
            while ((bytesRead = is.read(buffer)) != -1) {
                os.write(buffer, 0, bytesRead);
            }
            os.flush();
        } else {
            response.setContentType("text/plain");
            os.write("File not found.".getBytes());
            os.flush();
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (is != null) try { is.close(); } catch (IOException e) { e.printStackTrace(); }
        if (os != null) try { os.close(); } catch (IOException e) { e.printStackTrace(); }
    }
%>
