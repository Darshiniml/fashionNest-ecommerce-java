package com.ecommerce.servlet;

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.ecommerce.dao.DBConnection;

@WebServlet("/cancelOrder")
public class CancelOrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("orderId"));

        try {
            Connection con = DBConnection.getConnection();

            String query = "UPDATE orders SET order_status='Cancelled' WHERE order_id=?";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, orderId);

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("orders");
    }
}