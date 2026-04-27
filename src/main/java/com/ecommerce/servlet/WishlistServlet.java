package com.ecommerce.servlet;

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.ecommerce.dao.DBConnection;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        HttpSession session = req.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        int productId = Integer.parseInt(req.getParameter("productId"));

        try {
            Connection con = DBConnection.getConnection();

            // 🔍 check if already exists
            PreparedStatement check = con.prepareStatement(
                "SELECT * FROM wishlist WHERE user_id=? AND product_id=?");

            check.setInt(1, userId);
            check.setInt(2, productId);

            ResultSet rs = check.executeQuery();

            if(rs.next()){
                // ❌ remove if exists
                PreparedStatement delete = con.prepareStatement(
                    "DELETE FROM wishlist WHERE user_id=? AND product_id=?");

                delete.setInt(1, userId);
                delete.setInt(2, productId);
                delete.executeUpdate();

            } else {
                // ✅ insert
                PreparedStatement insert = con.prepareStatement(
                    "INSERT INTO wishlist(user_id, product_id) VALUES(?,?)");

                insert.setInt(1, userId);
                insert.setInt(2, productId);
                insert.executeUpdate();
            }

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}