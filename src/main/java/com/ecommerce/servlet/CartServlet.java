package com.ecommerce.servlet;

import java.io.IOException;
import java.util.*;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.ecommerce.model.CartItem;

@WebServlet("/addToCart")
public class CartServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));

        HttpSession session = request.getSession();
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null) cart = new ArrayList<>();

        boolean exists = false;

        for (CartItem item : cart) {
            if (item.getId() == id) {
                item.setQuantity(item.getQuantity() + 1);
                exists = true;
                break;
            }
        }

        if (!exists) {
            cart.add(new CartItem(id, name, price, 1));
        }

        session.setAttribute("cart", cart);
        response.sendRedirect("products");
    }
}