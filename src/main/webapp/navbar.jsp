<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*, com.ecommerce.model.User" %>

<%
User user = (User) session.getAttribute("user");
List cart = (List) session.getAttribute("cart");
int cartCount = (cart != null) ? cart.size() : 0;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<style>

/* ===== NAVBAR ===== */
.navbar {
    position: sticky;
    top: 0;
    z-index: 1000;
    background: #ffffff;
    padding: 12px 40px;

    display: flex;
    align-items: center;
    justify-content: space-between;

    border-bottom: 1px solid #eee;
}

/* ===== LEFT ===== */
.nav-left {
    display: flex;
    align-items: center;
    gap: 30px;
}

.logo {
    font-size: 24px;
    font-weight: 700;
    color: #ff3f6c;
    text-decoration: none;
}

/* MENU */
.menu a {
    text-decoration: none;
    color: #333;
    margin-right: 18px;
    font-weight: 500;
    position: relative;
    font-size: 14px;
}

/* underline animation */
.menu a::after {
    content: "";
    position: absolute;
    width: 0%;
    height: 2px;
    bottom: -5px;
    left: 0;
    background: #ff3f6c;
    transition: 0.3s ease;
}

.menu a:hover::after {
    width: 100%;
}

/* ===== SEARCH ===== */
.search-box {
    flex: 1;
    display: flex;
    justify-content: center;
}

.search-box input {
    width: 420px;
    padding: 10px 18px;
    border-radius: 25px;
    border: none;
    background: #f5f5f6;
    outline: none;
    font-size: 14px;
}

/* ===== RIGHT ===== */
.nav-right {
    display: flex;
    align-items: center;
    gap: 22px;
}

.nav-right a {
    text-decoration: none;
    color: #333;
    font-size: 14px;
    display: flex;
    align-items: center;
    gap: 5px;
    transition: 0.2s;
}

.nav-right a:hover {
    color: #ff3f6c;
}

/* USER NAME */
.username {
    font-weight: 600;
    color: #111;
}

/* ===== CART BADGE ===== */
.cart-link {
    position: relative;
}

.badge {
    position: absolute;
    top: -6px;
    right: -10px;
    background: #ff3f6c;
    color: white;
    font-size: 11px;
    padding: 3px 6px;
    border-radius: 50%;
}

/* ===== LOGOUT BUTTON ===== */
.logout {
    border: 1px solid #ff3f6c;
    padding: 5px 12px;
    border-radius: 20px;
    transition: 0.3s;
}

.logout:hover {
    background: #ff3f6c;
    color: white;
}

/* ===== ICON STYLE ===== */
.icon {
    font-size: 15px;
}

/* ===== TOAST ===== */
.toast-box {
    position: fixed;
    bottom: 30px;
    right: 30px;
    background: black;
    color: white;
    padding: 12px 18px;
    border-radius: 10px;
    opacity: 0;
    transition: 0.4s;
    z-index: 9999;
}

.toast-box.show {
    opacity: 1;
    transform: translateY(-10px);
}

</style>

</head>

<body>

<div class="navbar">

    <!-- LEFT -->
    <div class="nav-left">
        <a href="index.jsp" class="logo">FashionNest</a>

        <div class="menu">
            <a href="category?cat=1">MEN</a>
            <a href="category?cat=2">WOMEN</a>
            <a href="category?cat=3">SHOES</a>
        </div>
    </div>

    <!-- SEARCH -->
    <div class="search-box">
        <form action="search">
            <input type="text" name="query" placeholder="Search for products, brands and more">
        </form>
    </div>

    <!-- RIGHT -->
    <div class="nav-right">

        <a href="wishlistPage">
            <span class="icon">❤️</span> Wishlist
        </a>

        <a href="cart.jsp" class="cart-link">
            <span class="icon">🛒</span> Bag
            <% if(cartCount > 0){ %>
                <span class="badge"><%= cartCount %></span>
            <% } %>
        </a>

        <% if(user == null){ %>
            <a href="login.jsp">Login</a>
        <% } else { %>
            <span class="username"><%= user.getFullName() %></span>
            <a href="profile">Profile</a>
            <a href="orders">Orders</a>
            <a href="logout" class="logout">Logout</a>
        <% } %>

    </div>

</div>

<!-- TOAST -->
<div id="toast" class="toast-box"></div>

<script>
function showToast(msg){
    let t = document.getElementById("toast");
    t.innerText = msg;
    t.classList.add("show");

    setTimeout(()=> t.classList.remove("show"),2000);
}
</script>

</body>
</html>