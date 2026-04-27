package com.ecommerce.servlet;

import java.io.IOException;
import java.sql.*;
import java.util.List;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.ecommerce.dao.DBConnection;
import com.ecommerce.model.CartItem;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    // ✅ GET → Load checkout page with user address
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Integer userId = (Integer) session.getAttribute("userId");
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();

            String query = "SELECT address FROM users WHERE user_id=?";
            ps = con.prepareStatement(query);
            ps.setInt(1, userId);

            rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("address", rs.getString("address"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }

        request.getRequestDispatcher("/checkout.jsp").forward(request, response);
    }

    // ✅ POST → Place order with address + payment
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        Integer userId = (Integer) session.getAttribute("userId");
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        String address = request.getParameter("address");
        String payment = request.getParameter("payment");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp");
            return;
        }

        Connection con = null;
        PreparedStatement ps = null;
        PreparedStatement ps2 = null;
        ResultSet rs = null;

        try {
            con = DBConnection.getConnection();
            con.setAutoCommit(false);

            // 1️⃣ Calculate total
            double totalAmount = 0;
            for (CartItem item : cart) {
                totalAmount += item.getTotal();
            }

            // 2️⃣ Insert into orders (ADVANCED)
            String orderQuery = "INSERT INTO orders(user_id, total_amount, order_status, order_date, address, payment_method) VALUES(?,?,?,?,?,?)";

            ps = con.prepareStatement(orderQuery, Statement.RETURN_GENERATED_KEYS);

            ps.setInt(1, userId);
            ps.setDouble(2, totalAmount);
            ps.setString(3, "Placed");
            ps.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
            ps.setString(5, address);
            ps.setString(6, payment);

            ps.executeUpdate();

            // 3️⃣ Get order_id
            rs = ps.getGeneratedKeys();
            int orderId = 0;

            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            if (orderId == 0) {
                throw new Exception("Order ID not generated!");
            }

            // 4️⃣ Insert order items
            String itemQuery = "INSERT INTO order_items(order_id, product_id, product_name, quantity, unit_price, subtotal) VALUES(?,?,?,?,?,?)";

            ps2 = con.prepareStatement(itemQuery);

            for (CartItem item : cart) {
                ps2.setInt(1, orderId);
                ps2.setInt(2, item.getId());
                ps2.setString(3, item.getName());
                ps2.setInt(4, item.getQuantity());
                ps2.setDouble(5, item.getPrice());
                ps2.setDouble(6, item.getTotal());

                ps2.executeUpdate();
            }

            // ✅ Commit
            con.commit();

            // ✅ Save total for success page
            session.setAttribute("lastTotal", totalAmount);

            // ✅ Clear cart
            session.removeAttribute("cart");

            response.sendRedirect("success.jsp");

        } catch (Exception e) {
            e.printStackTrace();

            try {
                if (con != null) con.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }

        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (ps != null) ps.close(); } catch (Exception ignored) {}
            try { if (ps2 != null) ps2.close(); } catch (Exception ignored) {}
            try { if (con != null) con.close(); } catch (Exception ignored) {}
        }
    }
}