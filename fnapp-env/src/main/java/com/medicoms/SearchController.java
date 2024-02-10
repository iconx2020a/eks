package com.medicoms;

import java.io.IOException;
import jakarta.servlet.ServletException;
import java.sql.SQLException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.sql.ResultSet;

import com.medicoms.UsersBean;

@WebServlet(name="SearchController", urlPatterns = {"/finduser.do", "/adduser.do", "/isadmin.do"})

public class SearchController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private Database db;
    private UsersBean ub;
    int userID;
    String firstName;
    String lastName;
    String password;
    String userAction;
    ResultSet rs;
   
    public void init() throws ServletException {
        // Initialization database...
        db = new Database();

    }

protected void doPost(HttpServletRequest request,  HttpServletResponse
            response) throws ServletException, IOException {
      
        userID = Integer.parseInt(request.getParameter("ID"));
        firstName = request.getParameter("fname");
        lastName = request.getParameter("lname");
         password = request.getParameter("password");
        userAction = request.getServletPath()
                != null ? request.getServletPath() : "";
        if (userAction.equals("/isadmin.do") && userID > 0 && password 
                != null && db.isAdmin(userID, password)) {
                 ArrayList<UsersBean> ubArray = new ArrayList<UsersBean>();
               
                 rs = db.getAllUsers();
        try{
                 while(rs.next()){
                        ub = new UsersBean();
                        ub.setID(rs.getInt("ID"));
                        ub.setFirstName(rs.getString("firstName"));
                        ub.setLastName(rs.getString("lastName"));
                        ubArray.add(ub);
                }
                 request.setAttribute("users", ubArray);            
                 request.getRequestDispatcher("/MyUsers.jsp").forward(request, response);

        }  catch (SQLException err) {
       System.err.println("SQL Error");
         err.printStackTrace(System.err);
     } finally {
    try {
      rs.close();
    } catch (SQLException ignored) {}
}
            
    } else if (userAction.equals("/finduser.do") && userID > 0 &&
                db.doesUserExist(userID)) {
request.getRequestDispatcher("/Success.jsp").forward(request, response);
        } else if (userAction.equals("/adduser.do") && userID > 0 &&
                firstName != null && lastName != null) {
            db.addUser(userID, firstName, lastName);         
            request.getRequestDispatcher("/Info.jsp").forward(request, response);
        } else {   request.getRequestDispatcher("/Failure.jsp").forward(request, response);
        }

    }

}
