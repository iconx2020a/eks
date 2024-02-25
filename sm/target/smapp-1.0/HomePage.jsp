<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@page import="java.sql.Connection"%>
<%
    response.setHeader("Cache-Control", "private, no-store,"
            + " no-cache, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expire", 0);
%>
<html>
    <head>
        <meta charset="ISO-8859-1">
        <title>Welcome to Secret Manager  Test App</title>
    </head>
    <body>
        <h1></h1>
        <table>
            <tr> 
                <td><a href="ShowSecret.jsp">Get Secret</a></td>

            </tr>
            
        </table>
    </body>
</html>
