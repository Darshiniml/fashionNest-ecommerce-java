package com.ecommerce.dao;

import java.sql.*;
import java.util.*;

import com.ecommerce.model.Order;
import com.ecommerce.model.OrderItem;

public class OrderDAO {

    // CREATE ORDER
    public static int createOrder(Order order) {
        int orderId = 0;

        try {
            Connection con = DBConnection.getConnection();

            String query = "INSERT INTO orders(user_id,total_amount,payment_method,order_status,delivery_address) VALUES(?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);

            ps.setInt(1, order.getUserId());
            ps.setDouble(2, order.getTotalAmount());
            ps.setString(3, order.getPaymentMethod());
            ps.setString(4, order.getOrderStatus());
            ps.setString(5, order.getDeliveryAddress());

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orderId;
    }

    // INSERT ORDER ITEMS
    public static void insertOrderItems(List<OrderItem> items, int orderId) {

        try {
            Connection con = DBConnection.getConnection();

            String query = "INSERT INTO order_items(order_id,product_id,product_name,quantity,unit_price,subtotal) VALUES(?,?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(query);

            for (OrderItem item : items) {

                ps.setInt(1, orderId);
                ps.setInt(2, item.getProductId());
                ps.setString(3, item.getProductName());
                ps.setInt(4, item.getQuantity());
                ps.setDouble(5, item.getUnitPrice());
                ps.setDouble(6, item.getSubtotal());

                ps.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public static List<OrderItem> getOrdersByUser(int userId) {

        List<OrderItem> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String query = "SELECT oi.product_name, oi.quantity, oi.unit_price, oi.subtotal " +
                           "FROM orders o JOIN order_items oi ON o.order_id = oi.order_id " +
                           "WHERE o.user_id = ?";

            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem item = new OrderItem();

                item.setProductName(rs.getString("product_name"));
                item.setQuantity(rs.getInt("quantity"));
                item.setUnitPrice(rs.getDouble("unit_price"));
                item.setSubtotal(rs.getDouble("subtotal"));

                list.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}

    