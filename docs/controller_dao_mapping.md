# Controller to DAO Mapping

This document illustrates how each Controller (Servlet) in the application interacts with the underlying Data Access Objects (DAOs) or the database directly to process user requests.

| Servlet (Controller) | Target DAO | Method Called | Description of Operation |
|---|---|---|---|
| **RegisterServlet** | `UserDAO` | `register(User)` | Takes user input from registration form and inserts it into the `users` table. |
| **LoginServlet** | `UserDAO` | `login(email, password)` | Validates credentials against the `users` table and initializes a user session. |
| **ProductServlet** | `ProductDAO` | `getAllProducts()` | Retrieves the full inventory of products from the database for display. |
| **ProductDetailsServlet** | `ProductDAO` | `getProductById(id)` | Fetches the complete details of a single product for the product detail view. |
| **CategoryServlet** | `ProductDAO` | `getProductsByCategory(catId)` | Retrieves all products belonging to a specific selected category. |
| **FilterServlet** | `ProductDAO` | `filterProducts(category, price)` | Builds dynamic SQL queries to search and filter products based on user criteria. |
| **SearchServlet** | `ProductDAO` | `searchProducts(keyword)` | Performs a `LIKE` query against product names based on a search string. |
| **CartServlet** | *None* | *N/A* | Manages the `CartItem` list entirely within the HttpSession. No direct database interaction. |
| **RemoveFromCartServlet** | *None* | *N/A* | Removes an item from the session cart. No database interaction. |
| **CheckoutServlet** | *Direct DB Connection* | *Custom SQL* | Selects user address, calculates totals, and executes inserts into `orders` and `order_items` within a transactional `Commit()`. Avoids `OrderDAO` directly. |
| **OrderServlet** | *Direct DB Connection* | *Custom SQL* | Performs an advanced `JOIN` operation on `orders` and `order_items` tables to map order history data into an `OrderGroup` mapping. |

## Data Flow Notes

1. **Transaction Management:** In `CheckoutServlet`, a direct DB Connection is utilized rather than a DAO in order to enforce standard SQL Transaction safety (`con.setAutoCommit(false)` and `con.commit()`). This guarantees that if inserting `order_items` fails, the `orders` insertion is rolled back.
2. **Session State vs Database State:** The "Cart" is managed almost entirely in server memory (HttpSession) using `CartItem` objects to limit database overhead. It is only flushed to persistent storage (`order_items` table) during the final confirmation phase within `CheckoutServlet`.
