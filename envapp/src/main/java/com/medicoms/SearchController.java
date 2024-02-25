package com.medicoms;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.medicoms.UsersBean;
import java.util.ArrayList;
import java.sql.ResultSet;
import java.sql.SQLException;

@WebServlet(name="SearchController", urlPatterns = {"/finduser.do", "/adduser.do", "/isadmin.do"})

public class SearchController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Database db;
     private UsersBean ub;
       ResultSet rs;
    int userID;
    String firstName;
    String lastName;
    String password;
    String userAction;
    public void init() throws ServletException {
        // Initialization database...
        db = new Database();
    }

    protected void doPost(HttpServletRequest request,  HttpServletResponse
    response) throws ServletException, IOException {

        try{
                userID = Integer.parseInt(request.getParameter("ID"));
               }catch(NumberFormatException e){
                   request.getRequestDispatcher("/IDFailure.jsp").forward(request, response);
               }
firstName = request.getParameter("fname");
lastName = request.getParameter("lname");
 password = request.getParameter("password");
userAction = request.getServletPath()
        != null ? request.getServletPath() : "";
if (userAction.equals("/isadmin.do") && userID > 0 && password 
        != null && db.isAdmin(userID, password)) {
         ArrayList<UsersBean> users = new ArrayList<UsersBean>();               
         rs = db.getAllUsers();
try{
         while(rs.next()){
                ub = new UsersBean();
                ub.setID(rs.getInt("ID"));
                ub.setFirstName(rs.getString("firstName"));
                ub.setLastName(rs.getString("lastName"));
                users.add(ub);
        }
         request.setAttribute("users", users);            
         request.getRequestDispatcher("/MyUsers.jsp").forward(request, response);

}  catch (SQLException err) {
System.err.println("SQL Error");
 err.printStackTrace(System.err);
} finally {
try {
rs.close();
} catch (SQLException e) {

} catch (NullPointerException e){}
}

} else if (userAction.equals("/finduser.do") && userID > 0 &&
        db.doesUserExist(userID)) {
request.getRequestDispatcher("/Success.jsp").forward(request, response);
} else if (userAction.equals("/adduser.do") && userID > 0 &&
        firstName != null && lastName != null &&  db.addUser(userID, firstName, lastName)) {
    db.addUser(userID, firstName, lastName);         
    request.getRequestDispatcher("/Info.jsp").forward(request, response);
} else {   request.getRequestDispatcher("/Failure.jsp").forward(request, response);}

}   

}
