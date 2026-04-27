package com.ecommerce.model;

import java.util.*;

public class OrderGroup {

    private int orderId;
    private String orderDate;
    private String status;
    private double total;
    private List<CartItem> items = new ArrayList<>();

    // getters & setters

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public String getOrderDate() { return orderDate; }
    public void setOrderDate(String orderDate) { this.orderDate = orderDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }

    public List<CartItem> getItems() { return items; }
}