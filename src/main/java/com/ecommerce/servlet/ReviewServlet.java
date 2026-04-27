package com.ecommerce.servlet;

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.ecommerce.dao.DBConnection;

@WebServlet("/addReview")   // 🔥 MUST MATCH JSP FORM ACTION
public class ReviewServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        int productId = Integer.parseInt(req.getParameter("productId"));
        int rating = Integer.parseInt(req.getParameter("rating"));
        String comment = req.getParameter("comment");

        try {
            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO reviews(user_id, product_id, rating, comment) VALUES(?,?,?,?)"
            );

            ps.setInt(1, userId);
            ps.setInt(2, productId);
            ps.setInt(3, rating);
            ps.setString(4, comment);

            ps.executeUpdate();

        } catch(Exception e){
            e.printStackTrace();
        }

        // 🔥 redirect back to product page
        res.sendRedirect("product?id=" + productId);
    }
}