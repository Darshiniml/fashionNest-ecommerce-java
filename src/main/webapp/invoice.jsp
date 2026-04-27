<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*, com.ecommerce.model.CartItem" %>

<%
List<CartItem> items = (List<CartItem>) request.getAttribute("items");
int orderId = (int) request.getAttribute("orderId");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Invoice</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body { background:#f5f5f5; }

.invoice-box {
    max-width: 750px;
    margin: auto;
    background: white;
    padding: 30px;
    border-radius: 12px;
}

.logo {
    color:#ff3f6c;
    font-weight:bold;
    font-size:24px;
}
</style>
</head>

<body>

<div class="container mt-5">
<div class="invoice-box shadow">

<div class="d-flex justify-content-between">
    <div class="logo">FashionNest</div>
    <div>
        <strong>Order ID:</strong> <%= orderId %><br>
        <strong>Date:</strong> <%= new java.util.Date() %>
    </div>
</div>

<hr>

<p><strong>Payment Method:</strong> Cash on Delivery</p>

<table class="table mt-3">
<thead>
<tr>
<th>Product</th>
<th>Qty</th>
<th>Price</th>
<th>Total</th>
</tr>
</thead>

<tbody>

<%
double subtotal = 0;
for(CartItem item : items){
    double itemTotal = item.getPrice() * item.getQuantity();
    subtotal += itemTotal;
%>

<tr>
<td><%= item.getName() %></td>
<td><%= item.getQuantity() %></td>
<td>₹<%= item.getPrice() %></td>
<td>₹<%= itemTotal %></td>
</tr>

<%
}
%>

</tbody>
</table>

<%
double tax = subtotal * 0.05;
double grand = subtotal + tax;
%>

<div class="text-end">
    <p>Subtotal: ₹<%= subtotal %></p>
    <p>Tax (5%): ₹<%= tax %></p>
    <h5><strong>Grand Total: ₹<%= grand %></strong></h5>
</div>

<div class="text-center mt-4">
    <button onclick="window.print()" class="btn btn-dark">
        Print Invoice
    </button>
</div>

</div>
</div>

</body>
</html>