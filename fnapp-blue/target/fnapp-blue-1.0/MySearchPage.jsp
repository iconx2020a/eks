<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="ISO-8859-1">
        <title>Search Page</title>
    </head>
    <body style="background-color:blue;">
        <form action="finduser.do" method="post">
            <table>
                <tr> 
                    <td> Your ID</td>
                    <td> <input type="text" name="ID"/></td>

                </tr>

                <tr> 
                    <td><input type="submit" /> </td>
                    <td> <input type="reset" /> </td>
                    <td> <a href="HomePage.jsp"> Home</a></td>
                </tr>
            </table>
        </form>
    </body>
</html>
