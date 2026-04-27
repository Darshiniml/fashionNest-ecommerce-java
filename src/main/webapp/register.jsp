<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register - FashionNest</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/style.css">

<style>
.register-box {
    max-width: 500px;
    margin: 80px auto;
    padding: 30px;
    background: white;
    border-radius: 10px;
    box-shadow: 0 4px 20px rgba(0,0,0,0.1);
}
</style>

</head>

<body class="bg-light">

<div class="register-box">

    <h3 class="text-center mb-4">Create Account</h3>

    <form action="register" method="post">

        <div class="mb-3">
            <input type="text" name="name" class="form-control" placeholder="Full Name" required>
        </div>

        <div class="mb-3">
            <input type="email" name="email" class="form-control" placeholder="Email" required>
        </div>

        <div class="mb-3">
            <input type="password" name="password" class="form-control" placeholder="Password" required>
        </div>

        <div class="mb-3">
            <input type="text" name="phone" class="form-control" placeholder="Phone Number" required>
        </div>

        <div class="mb-3">
            <textarea name="address" class="form-control" placeholder="Address" required></textarea>
        </div>

        <button class="btn btn-dark w-100">Register</button>

    </form>

    <p class="text-center mt-3">
        Already have an account? 
        <a href="login.jsp">Login</a>
    </p>

</div>

</body>
</html>