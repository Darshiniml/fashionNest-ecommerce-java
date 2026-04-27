# FashionNest eCommerce Java Application

A full-stack Java-based eCommerce web application with features like product browsing, shopping cart, user wishlist, comprehensive order management, invoice generation, and real-time UI interactions. 

This project follows a standard **Model-View-Controller (MVC)** architectural pattern and manages data via a relational database structure.

## 🌟 Key Features

* **User Authentication:** Secure registration and login workflows.
* **Product Catalog:** Browse products, filter by categories, and search via keywords.
* **Shopping Cart & Checkout:** Persistent shopping cart via server sessions, transforming into robust transactional database orders upon checkout.
* **Order Management:** View order history and itemized receipts/invoices.
* **Dynamic Views:** Responsive UI built directly with JavaServer Pages (JSP).

## 🛠️ Technology Stack

* **Backend:** Java (Servlets, POJOs, Data Access Objects)
* **Frontend:** JSP, HTML5, Vanilla CSS, JavaScript
* **Database:** MySQL
* **Build/Deploy:** Maven / Eclipse (Dynamic Web Project structure), Docker (supported)

## 📐 Architecture Overview

The application is structured logically separating concerns between the presentation, controller, and data access layers:

1. **Models (`com.ecommerce.model`):** Plain Java Objects (POJOs) representing the core entities: Users, Products, Categories, Orders, etc.
2. **Controllers (`com.ecommerce.servlet`):** Java Servlets that handle HTTP request routing, session management, and passing data between views and DAOs.
3. **Data Access (`com.ecommerce.dao`):** DAOs containing JDBC logic to interface securely with the MySQL Database.
4. **Views (`src/main/webapp`):** JSP files displaying dynamically injected backend attributes.

## 📚 Detailed Documentation

Extensive developer documentation can be found in the `docs/` directory of this repository. This includes:

* [Architecture and Sequence Diagrams](./docs/architecture_and_sequence_diagrams.md) - Contains the high-level MVC diagram and specific flow charts for Login, Registration, and Checkout sequences.
* [Database Schema & Entity Relationships](./docs/database_schema.md) - Includes an interactive ER diagram of the Database structure.
* [Controller to DAO Mappings](./docs/controller_dao_mapping.md) - Details how specific backend servlets route their execution commands into the Database.
* **Printable Documentation:** `docs/EcommerceApp_Documentation.pdf` is provided as an offline, printable overview of the application design.

## 🚀 Setup and Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Darshiniml/fashionNest-ecommerce-java.git
   ```
2. **Database Setup:**
   * Install and configure MySQL.
   * A SQL script to generate the required tables (`users`, `categories`, `products`, `orders`, `order_items`) will need to be executed.
   * Update `DBConnection.java` (in `src/main/java/com/ecommerce/dao/`) with your local MySQL credentials.
3. **Run Application:**
   * Import the project into an IDE like Eclipse IDE for Enterprise Java.
   * Deploy to an application server such as Apache Tomcat.
   * Navigate to `http://localhost:8080/EcommerceApp/` in your browser.
