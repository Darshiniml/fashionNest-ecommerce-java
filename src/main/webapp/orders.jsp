<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*, com.ecommerce.model.OrderGroup, com.ecommerce.model.CartItem" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Orders</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body { background: #f5f5f5; }

.order-card {
    background: white;
    border-radius: 12px;
    padding: 20px;
    margin-bottom: 20px;
}

/* TRACKER */
.progress-container {
    position: relative;
    margin: 25px 0;
}

.progress-bar-bg {
    width: 100%;
    height: 6px;
    background: #ddd;
    border-radius: 10px;
}

.progress-bar-fill {
    width: 0%;
    height: 6px;
    background: #28a745;
    border-radius: 10px;
    transition: width 1.2s ease-in-out;
}

/* TRUCK */
.truck {
    position: absolute;
    left: 0%;
    top: -20px;
    font-size: 24px;
    transition: left 1.2s ease-in-out;
    transform: scaleX(-1);
    animation: bounce 0.5s infinite alternate;
}

@keyframes bounce {
    from { transform: translateY(0) scaleX(-1); }
    to { transform: translateY(-4px) scaleX(-1); }
}

/* Steps */
.step {
    font-size: 12px;
    text-align: center;
}
</style>

</head>

<body>

<jsp:include page="navbar.jsp" />

<div class="container mt-5">

<h3 class="mb-4">📦 My Orders</h3>

<%
List<OrderGroup> orders = (List<OrderGroup>) request.getAttribute("orders");

if(orders != null && !orders.isEmpty()){
for(OrderGroup order : orders){

    String status = order.getStatus();

    int progress = 0;
    if("Placed".equals(status)) progress = 25;
    else if("Packed".equals(status)) progress = 50;
    else if("Shipped".equals(status)) progress = 75;
    else if("Delivered".equals(status)) progress = 100;
%>

<div class="order-card shadow-sm">

    <!-- HEADER -->
    <div class="d-flex justify-content-between mb-3">
        <div>
            <h5>Order #<%= order.getOrderId() %></h5>
            <p class="text-muted">Date: <%= order.getOrderDate() %></p>
        </div>

        <div class="text-end">
            <h5>₹<%= order.getTotal() %></h5>

            <span class="badge 
                <%= "Cancelled".equals(status) ? "bg-danger" : "bg-success" %>">
                <%= status %>
            </span>
        </div>
    </div>

    <!-- TRACKER -->
    <% if(!"Cancelled".equals(status)){ %>

    <div class="progress-container">
        <div class="progress-bar-bg"></div>
        <div class="progress-bar-fill" data-progress="<%= progress %>"></div>
        <div class="truck" data-progress="<%= progress %>">🚚</div>
    </div>

    <div class="d-flex justify-content-between">
        <div class="step">Placed</div>
        <div class="step">Packed</div>
        <div class="step">Shipped</div>
        <div class="step">Delivered</div>
    </div>

    <% } else { %>

    <div class="alert alert-danger mt-3">
        ❌ This order has been cancelled
    </div>

    <% } %>

    <hr>

    <!-- ITEMS -->
    <% for(CartItem item : order.getItems()){ %>
    <div class="d-flex justify-content-between mb-2">
        <span><%= item.getName() %> (x<%= item.getQuantity() %>)</span>
        <span>₹<%= item.getTotal() %></span>
    </div>
    <% } %>

    <!-- INVOICE BUTTON -->
    <div class="mt-2">

        <% if("Delivered".equals(status)) { %>

            <a href="invoice?orderId=<%= order.getOrderId() %>" 
               class="btn btn-outline-dark btn-sm">
               View Invoice
            </a>

        <% } else if("Cancelled".equals(status)) { %>

            <button class="btn btn-secondary btn-sm" disabled>
                Invoice Not Available
            </button>

        <% } else { %>

            <button class="btn btn-light btn-sm" disabled>
                Invoice Available After Delivery
            </button>

        <% } %>

    </div>

    <!-- CANCEL BUTTON -->
    <div class="mt-3 text-end">

    <% if(!"Shipped".equals(status) && !"Delivered".equals(status) && !"Cancelled".equals(status)){ %>

        <form action="cancelOrder" method="post">
            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
            <button class="btn btn-danger btn-sm">Cancel Order</button>
        </form>

    <% } %>

    </div>

</div>

<%
}
}else{
%>

<h4>No Orders Found</h4>

<%
}
%>

</div>

<!-- ANIMATION SCRIPT -->
<script>
window.onload = function() {

    document.querySelectorAll('.progress-bar-fill').forEach(bar => {
        let progress = bar.getAttribute('data-progress');
        setTimeout(() => {
            bar.style.width = progress + '%';
        }, 200);
    });

    document.querySelectorAll('.truck').forEach(truck => {
        let progress = truck.getAttribute('data-progress');
        setTimeout(() => {
            truck.style.left = `calc(${progress}% - 20px)`;
        }, 200);
    });

};
</script>

</body>
</html>