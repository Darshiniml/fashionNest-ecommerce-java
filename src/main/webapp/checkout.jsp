<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.ecommerce.model.CartItem" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Checkout - FashionNest</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body { background: #f5f5f5; }

.checkout-card {
    background: white;
    padding: 20px;
    border-radius: 10px;
}

.summary-box {
    background: white;
    padding: 20px;
    border-radius: 10px;
}

</style>

</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="container mt-5">
<div class="row">

<!-- 🔥 LEFT SIDE (ADDRESS + PAYMENT) -->
<div class="col-md-7">

<div class="checkout-card mb-4">

<h5>Delivery Address</h5>

<form action="checkout" method="post">

<input type="text" name="address" class="form-control mb-3"
       value="<%= request.getAttribute("address") != null ? request.getAttribute("address") : "" %>"
       placeholder="Address" required>

<input type="text" name="city" class="form-control mb-3" placeholder="City" required>

<input type="text" name="state" class="form-control mb-3" placeholder="State" required>

<input type="text" name="pincode" class="form-control mb-3" placeholder="Pincode" required>

<h5 class="mt-4">Payment Method</h5>

<div class="form-check">
  <input class="form-check-input" type="radio" name="payment" value="COD" required>
  <label class="form-check-label">Cash on Delivery</label>
</div>

<div class="form-check">
  <input class="form-check-input" type="radio" name="payment" value="UPI">
  <label class="form-check-label">UPI</label>
</div>

<div class="form-check">
  <input class="form-check-input" type="radio" name="payment" value="CARD">
  <label class="form-check-label">Card</label>
</div>

<button class="btn btn-dark w-100 mt-4">Place Order</button>

</form>

</div>

</div>

<!-- 🔥 RIGHT SIDE (ORDER SUMMARY) -->
<div class="col-md-5">

<div class="summary-box">

<h5>Order Summary</h5>
<hr>

<%
List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
double total = 0;

if(cart != null){
for(CartItem item : cart){
total += item.getTotal();
%>

<div class="d-flex justify-content-between mb-2">
    <span><%= item.getName() %> (x<%= item.getQuantity() %>)</span>
    <span>₹<%= item.getTotal() %></span>
</div>

<%
}
}
%>

<hr>

<h5 class="d-flex justify-content-between">
    <span>Total</span>
    <span>₹<%= total %></span>
</h5>

</div>

</div>

</div>
</div>

</body>
</html>