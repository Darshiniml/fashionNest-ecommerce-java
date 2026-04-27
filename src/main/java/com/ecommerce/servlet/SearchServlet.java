package com.ecommerce.servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.Product;


@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("query");

        List<Product> list = ProductDAO.searchProducts(keyword);

        request.setAttribute("productList", list);
        request.getRequestDispatcher("products.jsp").forward(request, response);
    }
}