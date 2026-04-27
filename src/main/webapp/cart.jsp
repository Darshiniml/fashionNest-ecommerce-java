<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="java.util.*, com.ecommerce.model.CartItem" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart - FashionNest</title>
<jsp:include page="navbar.jsp" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">

</head>

<body class="bg-light">

<div class="container mt-5">

<h2 class="mb-4">🛒 Your Cart</h2>

<%
List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
double total = 0;

if(cart != null && !cart.isEmpty()){
for(CartItem item : cart){
total += item.getTotal();
%>

<div class="card mb-3 p-3 shadow-sm">
    <div class="d-flex justify-content-between align-items-center">

        <div>
            <h5><%= item.getName() %></h5>
            <p>Price: &#8377;<%= item.getPrice() %></p>
            <p>Quantity: <%= item.getQuantity() %></p>
        </div>

        <div>
            <h5>&#8377;<%= item.getTotal() %></h5>

            <form action="removeItem" method="post">
                <input type="hidden" name="id" value="<%= item.getId() %>">
                <button class="btn btn-danger btn-sm">Remove</button>
            </form>
        </div>

    </div>
</div>

<% } %>

<h3 class="mt-4">Total: &#8377;<%= total %></h3>

<!-- ✅ FIXED BUTTON -->
<a href="checkout" class="btn btn-success mt-3">Proceed to Checkout</a>

<%
}else{
%>

<h4>Your cart is empty 😢</h4>

<%
}
%>

</div>

</body>
</html>