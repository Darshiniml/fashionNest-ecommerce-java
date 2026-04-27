package com.ecommerce.servlet;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;

import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.Product;

@WebServlet("/category")
public class CategoryServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    int catId = Integer.parseInt(request.getParameter("cat"));

	    List<Product> list = ProductDAO.getProductsByCategory(catId);

	    request.setAttribute("productList", list);
	    request.getRequestDispatcher("products.jsp").forward(request, response);
	}
}