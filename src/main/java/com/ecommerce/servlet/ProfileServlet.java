package com.ecommerce.servlet;

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.ecommerce.dao.DBConnection;
import com.ecommerce.model.User;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    // ✅ GET → Load profile
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 🔥 Use existing session ONLY
        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");

        // 🔍 DEBUG
        System.out.println("Profile Session ID: " + session.getId());
        System.out.println("UserId in session: " + userId);

        if (userId == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            Connection con = DBConnection.getConnection();

            String query = "SELECT * FROM users WHERE user_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User user = new User();
              
               

                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name")); // ✅ FIXED
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                request.setAttribute("user", user);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    // ✅ POST → Update profile
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        try {
            Connection con = DBConnection.getConnection();
            String query = "UPDATE users SET full_name=?, email=?, phone=?, address=? WHERE user_id=?";
           
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, address);
            ps.setInt(5, id);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/profile");
    }
}