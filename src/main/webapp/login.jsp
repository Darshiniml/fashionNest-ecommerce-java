<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login - FashionNest</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">

<style>
.login-box {
    max-width: 450px;
    margin: 100px auto;
    padding: 30px;
    background: white;
    border-radius: 10px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
}
</style>

</head>

<body class="bg-light">

<div class="login-box">

    <h3 class="text-center mb-4">Login to FashionNest</h3>

    <form action="login" method="post">

        <div class="mb-3">
            <input type="email" name="email" class="form-control" placeholder="Email" required>
        </div>

        <div class="mb-3">
            <input type="password" name="password" class="form-control" placeholder="Password" required>
        </div>

        <button class="btn btn-dark w-100">Login</button>

    </form>

    <p class="text-center mt-3">
        Don't have an account? 
        <a href="register.jsp">Register</a>
    </p>

</div>

</body>
</html>