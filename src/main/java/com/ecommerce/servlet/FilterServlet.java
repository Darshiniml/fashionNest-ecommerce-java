package com.ecommerce.servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.Product;

@WebServlet("/filter")
public class FilterServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String category = request.getParameter("category");
        String price = request.getParameter("price");

        List<Product> list = ProductDAO.filterProducts(category, price);

        request.setAttribute("productList", list);
        request.getRequestDispatcher("products.jsp").forward(request, response);
    }
}