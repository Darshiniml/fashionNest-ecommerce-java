// Alert when item added to cart
function addedToCart() {
    alert("Item added to cart!");
}

// Confirm before checkout
function confirmCheckout() {
    return confirm("Are you sure you want to place the order?");
}

// Search validation
function validateSearch() {
    let query = document.getElementById("searchBox").value;

    if (query.trim() === "") {
        alert("Please enter something to search");
        return false;
    }
    return true;
}

// Remove confirmation
function confirmRemove() {
    return confirm("Remove this item from cart?");
}