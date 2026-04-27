package com.ecommerce.dao;

import java.sql.*;
import java.util.*;

import com.ecommerce.model.Product;

public class ProductDAO {

    // GET ALL PRODUCTS
    public static List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM products";
            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();

                p.setId(rs.getInt("product_id"));
                p.setName(rs.getString("product_name"));
                p.setPrice(rs.getDouble("price"));
                p.setDescription(rs.getString("description"));
                p.setImage(rs.getString("image_url"));

                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // GET PRODUCT BY ID
    public static Product getProductById(int id) {
        Product p = null;

        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM products WHERE product_id=?";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                p = new Product();

                p.setId(rs.getInt("product_id"));
                p.setName(rs.getString("product_name"));
                p.setPrice(rs.getDouble("price"));
                p.setDescription(rs.getString("description"));
                p.setImage(rs.getString("image_url"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return p;
    }

    // SEARCH PRODUCTS
    public static List<Product> searchProducts(String keyword) {
        List<Product> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM products WHERE product_name LIKE ?";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, "%" + keyword + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();

                p.setId(rs.getInt("product_id"));
                p.setName(rs.getString("product_name"));
                p.setPrice(rs.getDouble("price"));
                p.setDescription(rs.getString("description"));
                p.setImage(rs.getString("image_url"));

                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

 // GET PRODUCTS BY CATEGORY
    public static List<Product> getProductsByCategory(int catId) {
        List<Product> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM products WHERE category_id=?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, catId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();

                p.setId(rs.getInt("product_id"));
                p.setName(rs.getString("product_name"));
                p.setPrice(rs.getDouble("price"));
                p.setDescription(rs.getString("description"));
                p.setImage(rs.getString("image_url"));

                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    public static List<Product> filterProducts(String category, String price) {

        List<Product> list = new ArrayList<>();

        try {
            Connection con = DBConnection.getConnection();

            String query = "SELECT * FROM products WHERE 1=1";

            if (category != null && !category.isEmpty()) {
                query += " AND category_id=" + category;
            }

            if (price != null && !price.isEmpty()) {
                if (price.equals("1")) {
                    query += " AND price < 1000";
                } else if (price.equals("2")) {
                    query += " AND price BETWEEN 1000 AND 2000";
                } else if (price.equals("3")) {
                    query += " AND price > 2000";
                }
            }

            PreparedStatement ps = con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();

                p.setId(rs.getInt("product_id"));
                p.setName(rs.getString("product_name"));
                p.setPrice(rs.getDouble("price"));
                p.setDescription(rs.getString("description"));
                p.setImage(rs.getString("image_url"));

                list.add(p);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}