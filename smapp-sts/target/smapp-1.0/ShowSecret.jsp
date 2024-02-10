<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.iconx.SecretManager"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Information</title>
   
    </head>
  
  <body>
              
     <h2> This is super-duper secret:   <jsp:useBean id="sm" class = "com.iconx.SecretManager" />
<%=sm.showSecret() %>  </h2>
        <table>
            <tr>
                <td> <a href="HomePage.jsp"> Home</a></td>
            </tr>

        </table>
    </body>
</html>
