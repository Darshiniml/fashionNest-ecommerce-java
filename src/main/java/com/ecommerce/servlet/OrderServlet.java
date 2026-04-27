package com.ecommerce.servlet;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.ecommerce.dao.DBConnection;
import com.ecommerce.model.*;

@WebServlet("/orders")
public class OrderServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        Map<Integer, OrderGroup> orderMap = new LinkedHashMap<>();

        try {
            Connection con = DBConnection.getConnection();

            String query = "SELECT o.order_id, o.order_date, o.order_status, o.total_amount, " +
                           "oi.product_name, oi.quantity, oi.unit_price, oi.subtotal " +
                           "FROM orders o JOIN order_items oi ON o.order_id = oi.order_id " +
                           "WHERE o.user_id=? ORDER BY o.order_id DESC";

            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                int orderId = rs.getInt("order_id");

                OrderGroup group = orderMap.get(orderId);

                if (group == null) {
                    group = new OrderGroup();
                    group.setOrderId(orderId);
                    group.setOrderDate(rs.getString("order_date"));
                    group.setStatus(rs.getString("order_status"));
                    group.setTotal(rs.getDouble("total_amount"));

                    orderMap.put(orderId, group);
                }

                CartItem item = new CartItem(
                        0,
                        rs.getString("product_name"),
                        rs.getDouble("unit_price"),
                        rs.getInt("quantity")
                );

                group.getItems().add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("orders", new ArrayList<>(orderMap.values()));
        request.getRequestDispatcher("orders.jsp").forward(request, response);
    }
}