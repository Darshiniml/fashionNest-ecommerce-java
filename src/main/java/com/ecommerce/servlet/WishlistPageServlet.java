package com.ecommerce.servlet;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.ecommerce.dao.DBConnection;
import com.ecommerce.model.Product;

@WebServlet("/wishlistPage")
public class WishlistPageServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null || session.getAttribute("userId") == null){
            response.sendRedirect("login.jsp");
            return;
        }

        Integer userId = (Integer) session.getAttribute("userId");

        List<Product> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            // ✅ CORRECT QUERY
            String query = "SELECT p.* FROM products p " +
                           "JOIN wishlist w ON p.product_id = w.product_id " +
                           "WHERE w.user_id=?";

            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();

                // ✅ MATCH YOUR DB COLUMNS
                p.setId(rs.getInt("product_id"));
                p.setName(rs.getString("product_name"));
                p.setPrice(rs.getDouble("price"));
                p.setImage(rs.getString("image_url"));

                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("wishlist", list);
        request.getRequestDispatcher("wishlist.jsp").forward(request, response);
    }
}