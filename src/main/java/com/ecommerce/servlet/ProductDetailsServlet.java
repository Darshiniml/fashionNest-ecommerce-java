package com.ecommerce.servlet;

import java.io.IOException;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.Product;

@WebServlet("/product")
public class ProductDetailsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        Product product = ProductDAO.getProductById(id);

        request.setAttribute("product", product);
        request.getRequestDispatcher("product-details.jsp").forward(request, response);
    }
}