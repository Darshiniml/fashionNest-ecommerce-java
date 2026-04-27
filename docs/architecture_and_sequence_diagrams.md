# Architecture and Sequence Diagrams

## MVC Architecture Overview

The application follows the Model-View-Controller (MVC) architectural pattern:

- **Model**: Java POJO classes representing the business entities (`User`, `Product`, `Order`, etc.) and Data Access Objects (DAOs) executing the logic to persist and retrieve data from the database.
- **View**: JSP (JavaServer Pages) files handle the presentation logic, displaying data to the users and sending requests to the Controllers. (Inferred based on standard Java EE structure)
- **Controller**: Java Servlets intercept HTTP requests from the views, invoke the appropriate DAOs for data operations, and dispatch the response back to the views.

```mermaid
graph TD
    Client[Web Browser] -->|HTTP Request| Controller[Servlets]
    Controller -->|Update / Get Data| DAO[DAO Layer]
    DAO -->|Map Data| Model[Model Layer POJOs]
    DAO <-->|SQL Queries| DB[(Database)]
    Controller -->|Forward / Redirect| View[JSP Pages]
    View -->|Render HTML| Client
```

---

## Sequence Diagrams

### 1. User Registration Flow

```mermaid
sequenceDiagram
    participant User
    participant RegisterServlet
    participant UserDAO
    participant Database

    User->>RegisterServlet: POST /register (Details)
    RegisterServlet->>UserDAO: register(User obj)
    UserDAO->>Database: INSERT INTO users
    Database-->>UserDAO: Return Status
    UserDAO-->>RegisterServlet: Return Status
    RegisterServlet-->>User: Redirect to Login/Home
```

### 2. User Login Flow

```mermaid
sequenceDiagram
    participant User
    participant LoginServlet
    participant UserDAO
    participant Database

    User->>LoginServlet: POST /login (email, password)
    LoginServlet->>UserDAO: login(email, password)
    UserDAO->>Database: SELECT * FROM users
    Database-->>UserDAO: ResultSet
    UserDAO-->>LoginServlet: User Object
    alt Valid User
        LoginServlet->>LoginServlet: Create Session
        LoginServlet-->>User: Redirect to Home
    else Invalid User
        LoginServlet-->>User: Redirect back to Login with Error
    end
```

### 3. Product Browsing Flow

```mermaid
sequenceDiagram
    participant User
    participant ProductServlet
    participant ProductDAO
    participant Database

    User->>ProductServlet: GET /products
    ProductServlet->>ProductDAO: getAllProducts()
    ProductDAO->>Database: SELECT * FROM products
    Database-->>ProductDAO: ResultSet
    ProductDAO-->>ProductServlet: List<Product>
    ProductServlet-->>User: Forward to products.jsp with List
```

### 4. Checkout Flow (Direct DB Access Example)

```mermaid
sequenceDiagram
    participant User
    participant CheckoutServlet
    participant Database

    User->>CheckoutServlet: POST /checkout (Address, Payment)
    CheckoutServlet->>CheckoutServlet: Validate Session & Cart
    CheckoutServlet->>Database: INSERT INTO orders (total, status)
    Database-->>CheckoutServlet: Generated Order ID
    loop For each CartItem
        CheckoutServlet->>Database: INSERT INTO order_items
    end
    CheckoutServlet->>Database: COMMIT
    CheckoutServlet->>CheckoutServlet: Clear Cart Session
    CheckoutServlet-->>User: Redirect to Success Page
```
