package com.ecommerce.servlet;

import java.io.IOException;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.ecommerce.dao.UserDAO;
import com.ecommerce.model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = UserDAO.login(email, password);

        if (user != null) {

            // 🔥 IMPORTANT: create session
            HttpSession session = request.getSession(true);

            session.setAttribute("userId", user.getUserId());
            session.setAttribute("user", user);

            // 🔍 DEBUG
            System.out.println("Login Session ID: " + session.getId());
            System.out.println("UserId stored: " + user.getUserId());

            // ✅ ALWAYS use context path
            response.sendRedirect(request.getContextPath() + "/index.jsp");

        } else {
            response.getWriter().println("Invalid Login!");
        }
    }
}