<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.ecommerce.model.Product, java.sql.*" %>

<%
Product p = (Product) request.getAttribute("product");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%= p.getName() %></title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body { background:#f5f5f6; }

.product-img {
    width:100%;
    border-radius:12px;
}

.size-box label {
    margin-right:10px;
}

.review-box {
    background:white;
    padding:15px;
    border-radius:10px;
    margin-bottom:10px;
}
</style>
</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="container mt-5">

<div class="row">

<!-- IMAGE -->
<div class="col-md-6">
    <img src="<%= p.getImage() %>" class="product-img">
</div>

<!-- DETAILS -->
<div class="col-md-6">

    <h2><%= p.getName() %></h2>

    <h4 class="text-success">₹<%= p.getPrice() %></h4>

    <p><%= p.getDescription() %></p>

    <!-- ⭐ RATING AVG -->
    <%
    double avg = 0;
    int count = 0;

    Connection con = com.ecommerce.dao.DBConnection.getConnection();
    PreparedStatement ps = con.prepareStatement(
        "SELECT AVG(rating) as avg_rating, COUNT(*) as total FROM reviews WHERE product_id=?");

    ps.setInt(1, p.getId());
    ResultSet rs = ps.executeQuery();

    if(rs.next()){
        avg = rs.getDouble("avg_rating");
        count = rs.getInt("total");
    }
    %>

    <p>⭐ <%= String.format("%.1f", avg) %> / 5 (<%= count %> reviews)</p>

    <!-- FORM -->
    <form action="addToCart" method="post">

        <input type="hidden" name="id" value="<%= p.getId() %>">
        <input type="hidden" name="name" value="<%= p.getName() %>">
        <input type="hidden" name="price" value="<%= p.getPrice() %>">

        <!-- SIZE -->
        <h5>Select Size</h5>
        <div class="size-box">
            <label><input type="radio" name="size" value="S" required> S</label>
            <label><input type="radio" name="size" value="M"> M</label>
            <label><input type="radio" name="size" value="L"> L</label>
        </div>

        <!-- QTY -->
        <h5 class="mt-3">Quantity</h5>
        <input type="number" name="qty" value="1" min="1" class="form-control w-25">

        <button class="btn btn-dark w-100 mt-3"
        onclick="showToast('Added to cart')">
        Add to Bag
        </button>

    </form>

    <!-- ❤️ -->
    <button class="btn btn-outline-danger w-100 mt-2"
    onclick="addToWishlist(<%= p.getId() %>)">
    ❤️ Add to Wishlist
    </button>

</div>
</div>

<!-- ⭐ ADD REVIEW -->
<div class="mt-5">
<h4>Add Review</h4>

<form action="addReview" method="post">
    <input type="hidden" name="productId" value="<%= p.getId() %>">

    <select name="rating" class="form-control mb-2" required>
        <option value="">Rating</option>
        <option value="5">⭐⭐⭐⭐⭐</option>
        <option value="4">⭐⭐⭐⭐</option>
        <option value="3">⭐⭐⭐</option>
        <option value="2">⭐⭐</option>
        <option value="1">⭐</option>
    </select>

    <textarea name="comment" class="form-control mb-2"></textarea>

    <button class="btn btn-dark">Submit</button>
</form>
</div>

<!-- REVIEWS -->
<div class="mt-4">
<h4>Customer Reviews</h4>

<%
PreparedStatement ps2 = con.prepareStatement(
"SELECT * FROM reviews WHERE product_id=? ORDER BY created_at DESC");

ps2.setInt(1, p.getId());
ResultSet rs2 = ps2.executeQuery();

while(rs2.next()){
%>

<div class="review-box">
    ⭐ <%= rs2.getInt("rating") %>/5 <br>
    <%= rs2.getString("comment") %>
</div>

<% } %>

</div>

</div>

<script>
function addToWishlist(id){
    fetch('wishlist', {
        method:'POST',
        headers:{'Content-Type':'application/x-www-form-urlencoded'},
        body:'productId='+id
    });
    showToast('Added to wishlist ❤️');
}
</script>

</body>
</html>