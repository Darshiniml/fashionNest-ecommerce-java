package com.ecommerce.servlet;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.ecommerce.dao.DBConnection;
import com.ecommerce.model.CartItem;

@WebServlet("/invoice")
public class InvoiceServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("orderId"));

        List<CartItem> items = new ArrayList<>();
        double total = 0;

        try {
            Connection con = DBConnection.getConnection();

            String query = "SELECT * FROM order_items WHERE order_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, orderId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                CartItem item = new CartItem(); // ✅ correct

                item.setName(rs.getString("product_name"));
                item.setQuantity(rs.getInt("quantity"));
                item.setPrice(rs.getDouble("unit_price"));

                total += rs.getDouble("subtotal");

                items.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("items", items);
        request.setAttribute("total", total);
        request.setAttribute("orderId", orderId);

        request.getRequestDispatcher("invoice.jsp").forward(request, response);
    }
}