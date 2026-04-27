<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="com.ecommerce.model.User" %>

<%
User user = (User) request.getAttribute("user");

// 🔴 Safety check
if(user == null){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Profile</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body { background: #f5f5f5; }

.profile-card {
    background: white;
    padding: 30px;
    border-radius: 10px;
    max-width: 500px;
    margin: auto;
}
</style>

</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="container mt-5">

<div class="profile-card shadow">

<h4 class="mb-4">👤 My Profile</h4>

<form action="profile" method="post">

    <input type="hidden" name="id" value="<%= user.getUserId() %>">

    <input type="text" name="name" class="form-control mb-3"
           value="<%= user.getFullName() %>" required>

    <input type="email" name="email" class="form-control mb-3"
           value="<%= user.getEmail() %>" required>

    <input type="text" name="phone" class="form-control mb-3"
           value="<%= user.getPhone() %>" required>

    <textarea name="address" class="form-control mb-3" required><%= user.getAddress() %></textarea>

    <button class="btn btn-dark w-100">Update Profile</button>

</form>

</div>

</div>

</body>
</html>