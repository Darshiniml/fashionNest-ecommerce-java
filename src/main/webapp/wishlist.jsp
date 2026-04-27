<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*, com.ecommerce.model.Product" %>

<%
List<Product> list = (List<Product>) request.getAttribute("wishlist");
%>

<!DOCTYPE html>
<html>
<head>
<title>Wishlist</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light">

<jsp:include page="navbar.jsp" />

<div class="container mt-5">

<h3>❤️ My Wishlist</h3>

<div class="row">

<%
if(list != null && !list.isEmpty()){
for(Product p : list){
%>

<div class="col-md-3">
    <div class="card p-2 mb-3">

        <img src="<%= p.getImage() %>" style="height:200px; object-fit:cover;">

        <h6><%= p.getName() %></h6>
        <p>₹<%= p.getPrice() %></p>

        <a href="product?id=<%= p.getId() %>" class="btn btn-dark btn-sm">View</a>

    </div>
</div>

<%
}
}else{
%>

<h5>No items in wishlist</h5>

<%
}
%>

</div>

</div>

</body>
</html>