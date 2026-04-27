<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*, com.ecommerce.model.Product" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Products</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body { background:#f5f5f6; }

.product-card {
    background:white;
    border-radius:12px;
    padding:12px;
    transition:0.3s;
    position:relative;
}

.product-card:hover {
    transform:translateY(-6px);
    box-shadow:0 10px 20px rgba(0,0,0,0.15);
}

.product-img {
    width:100%;
    height:220px;
    object-fit:cover;
    border-radius:10px;
}

.wishlist-btn {
    position:absolute;
    top:10px;
    right:10px;
    border:none;
    background:white;
    border-radius:50%;
}

.price {
    color:#03a685;
    font-weight:600;
}
</style>
</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="container mt-4">
<div class="row">

<!-- PRODUCTS -->
<div class="col-md-12">
<div class="row g-4">

<%
List<Product> list = (List<Product>) request.getAttribute("productList");

for(Product p : list){
%>

<div class="col-md-3">
    <div class="product-card">

        <!-- ❤️ -->
        <button class="wishlist-btn"
        onclick="addToWishlist(<%= p.getId() %>)">
        🤍
        </button>

        <a href="product?id=<%= p.getId() %>">
            <img src="<%= p.getImage() %>" class="product-img">
        </a>

        <h6 class="mt-2"><%= p.getName() %></h6>
        <p class="price">₹<%= p.getPrice() %></p>

    </div>
</div>

<% } %>

</div>
</div>

</div>
</div>

<script>
function addToWishlist(id){
    fetch('wishlist', {
        method:'POST',
        headers:{'Content-Type':'application/x-www-form-urlencoded'},
        body:'productId='+id
    });
    showToast('Wishlist updated ❤️');
}
</script>

</body>
</html>