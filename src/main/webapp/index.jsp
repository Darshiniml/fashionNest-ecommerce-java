<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*, com.ecommerce.model.Product" %>
<%@ page import="com.ecommerce.dao.ProductDAO" %>
<%@ page import="java.sql.*" %>

<%
List<Product> list = ProductDAO.getAllProducts();

/* FILTER */
String priceParam = request.getParameter("price");
if(priceParam != null && !priceParam.isEmpty()){
    double maxPrice = Double.parseDouble(priceParam);
    list.removeIf(p -> p.getPrice() > maxPrice);
}

/* WISHLIST LOAD */
Set<Integer> wishlistSet = new HashSet<>();
Integer userId = (Integer) session.getAttribute("userId");

if(userId != null){
    try{
        Connection con = com.ecommerce.dao.DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(
            "SELECT product_id FROM wishlist WHERE user_id=?");

        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();

        while(rs.next()){
            wishlistSet.add(rs.getInt("product_id"));
        }

    } catch(Exception e){
        e.printStackTrace();
    }
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FashionNest</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body { background:#f5f5f6; }

/* CARD */
.product-card {
    background:white;
    border-radius:14px;
    overflow:hidden;
    transition:0.3s;
    box-shadow:0 2px 10px rgba(0,0,0,0.08);
}

.product-card:hover {
    transform:translateY(-5px);
    box-shadow:0 10px 20px rgba(0,0,0,0.15);
}

/* IMAGE */
.img-wrapper {
    position:relative;
}

.product-img {
    width:100%;
    height:260px;
    object-fit:cover;
    transition:0.3s;
}

.product-img:hover {
    transform:scale(1.03);
}

/* ❤️ BUTTON */
.wishlist-btn {
    position:absolute;
    top:10px;
    right:10px;

    width:36px;
    height:36px;

    border:none;
    background:white;
    border-radius:50%;

    display:flex;
    align-items:center;
    justify-content:center;

    font-size:18px;
    cursor:pointer;

    box-shadow:0 2px 6px rgba(0,0,0,0.2);
}

.heart {
    color:#999;
    transition:0.3s;
}

.wishlist-btn.active .heart {
    color:red;
}

/* INFO */
.product-info {
    padding:12px;
}

.price {
    color:#03a685;
    font-weight:600;
}

/* BUTTON */
.btn-dark {
    border-radius:10px;
}

.btn-dark:hover {
    background:#ff3f6c;
    border-color:#ff3f6c;
}

/* TOAST */
.toast-box {
    position:fixed;
    bottom:30px;
    right:30px;
    background:black;
    color:white;
    padding:12px 18px;
    border-radius:10px;
    opacity:0;
    transition:0.4s;
    z-index:9999;
}

.toast-box.show {
    opacity:1;
    transform:translateY(-10px);
}
</style>

</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="container mt-4">

<!-- FILTER -->
<form method="get" class="mb-3 d-flex gap-2">
    <select name="price" class="form-select w-25">
        <option value="">All Prices</option>
        <option value="1000">Below ₹1000</option>
        <option value="2000">Below ₹2000</option>
    </select>

    <button class="btn btn-dark">Apply</button>
</form>

<div class="row g-4">

<%
for(Product p : list){
%>

<div class="col-md-3">

    <div class="product-card">

        <!-- IMAGE + ❤️ -->
        <div class="img-wrapper">

            <a href="product?id=<%= p.getId() %>">
                <img src="<%= p.getImage() %>" class="product-img">
            </a>

            <!-- ❤️ BUTTON -->
            <button type="button" class="wishlist-btn 
            <%= wishlistSet.contains(p.getId()) ? "active" : "" %>"
            onclick="handleWishlist(this, <%= p.getId() %>)">

                <span class="heart">
                <%= wishlistSet.contains(p.getId()) ? "❤" : "♡" %>
                </span>

            </button>

        </div>

        <!-- INFO -->
        <div class="product-info">
            <h6><%= p.getName() %></h6>
            <p class="price">₹<%= p.getPrice() %></p>
        </div>

        <!-- CART -->
        <form action="addToCart" method="post">
            <input type="hidden" name="id" value="<%= p.getId() %>">
            <input type="hidden" name="name" value="<%= p.getName() %>">
            <input type="hidden" name="price" value="<%= p.getPrice() %>">

            <button class="btn btn-dark w-100"
            onclick="showToast('Added to cart 🛒')">
            Add to Bag
            </button>
        </form>

    </div>

</div>

<%
}
%>

</div>
</div>

<!-- TOAST -->
<div id="toast" class="toast-box"></div>

<script>
function handleWishlist(btn, productId){

    fetch('wishlist', {
        method:'POST',
        headers:{'Content-Type':'application/x-www-form-urlencoded'},
        body:'productId=' + productId
    });

    btn.classList.toggle("active");

    let heart = btn.querySelector(".heart");
    heart.innerText = btn.classList.contains("active") ? "❤" : "♡";

    showToast('Wishlist updated ❤️');
}

function showToast(msg){
    let t = document.getElementById("toast");
    t.innerText = msg;
    t.classList.add("show");

    setTimeout(()=>t.classList.remove("show"),2000);
}
</script>

</body>
</html>