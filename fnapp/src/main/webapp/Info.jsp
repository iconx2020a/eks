<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Information</title>
    </head>
    <body>
        <h2> The user <%=request.getParameter("ID")%> failed to add because backend does not exist yet, it will be added later, ride on :) </h2>
        <table>
            <tr>
                <td> <a href="HomePage.jsp"> Home</a></td>
            </tr>

        </table>
    </body>
</html>
