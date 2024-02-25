<%@ taglib uri="http://java.sun.com/jsp/jstl/core"
    prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
 
<html>
    <head>
        <meta charset="ISO-8859-1">
        <title> APP Admin Page</title>
    </head>
    <body>
    
    <div align="center">
        <table border="1" cellpadding="5">
            <caption><h2>Users</h2></caption>
            <tr>
                <th>ID</th>
                <th>First Name</th>
                 <th>Last Name</th>
            </tr>
            <c:forEach var="user" items="${requestScope.users}">
                <tr>
                     <td><c:out value="${user.ID}" /></td>
                    <td><c:out value="${user.firstName}" /></td>
                    <td><c:out value="${user.lastName}" /></td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
    </body>
</html>
