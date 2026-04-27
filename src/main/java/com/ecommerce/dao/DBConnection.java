package com.ecommerce.dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    public static Connection getConnection() {
        Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String url =  "jdbc:mysql://172.31.128.1:3306/ecommerce?useSSL=false&allowPublicKeyRetrieval=true";

            con = DriverManager.getConnection(url, "dockeruser", "Darsh123");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }
}