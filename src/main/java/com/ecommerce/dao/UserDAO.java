package com.ecommerce.dao;

import java.sql.*;

import com.ecommerce.model.User;

public class UserDAO {

    // REGISTER
    public static int register(User user) {
        int status = 0;

        try {
            Connection con = DBConnection.getConnection();
            String query = "INSERT INTO users(full_name,email,password,phone,address) VALUES(?,?,?,?,?)";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getPhone());
            ps.setString(5, user.getAddress());

            status = ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // LOGIN
    public static User login(String email, String password) {
        User user = null;

        try {
            Connection con = DBConnection.getConnection();
            String query = "SELECT * FROM users WHERE email=? AND password=?";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}