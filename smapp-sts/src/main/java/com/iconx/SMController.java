package com.iconx;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name="SMController", urlPatterns = {"/ShowSecret.do"})

public class SMController extends HttpServlet {
    private static final long serialVersionUID = 1L;
   
protected void doPost(HttpServletRequest request,  HttpServletResponse
            response) throws ServletException, IOException {
             request.getRequestDispatcher("/ShowSecret.jsp").forward(request, response);

      }
}
