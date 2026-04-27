CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

-- USERS
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100),
    phone VARCHAR(15),
    address VARCHAR(255)
);

-- CATEGORIES
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100)
);

-- PRODUCTS
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    category_id INT,
    product_name VARCHAR(100),
    description TEXT,
    price DECIMAL(10,2),
    image_url VARCHAR(255),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- ORDERS
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    total_amount DECIMAL(10,2),
    order_status VARCHAR(50),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    address TEXT,
    payment_method VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- ORDER ITEMS
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    product_name VARCHAR(100),
    quantity INT,
    unit_price DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- WISHLIST
CREATE TABLE wishlist (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    product_id INT,
    UNIQUE(user_id, product_id)
);

-- REVIEWS
CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    product_id INT,
    rating INT,
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- DATA
INSERT INTO categories (category_name) VALUES
('Men'), ('Women'), ('Shoes');

INSERT INTO products (category_id, product_name, description, price, image_url) VALUES
(1, 'Blue Straight Fit Trousers', 'Stylish trousers', 1499, 'images/men/Blue_straight_fit_trousers.jpg'),
(1, 'Brown Casual Shirt', 'Casual wear shirt', 1299, 'images/men/brown_casual_shirt.jpg'),
(1, 'Formal Blue Shirt', 'Office shirt', 1599, 'images/men/formal_shirt_blue.jpg'),
(1, 'Formal Cream Shirt', 'Elegant shirt', 1499, 'images/men/formal_shirt_cream.jpg'),
(1, 'Formal White Shirt', 'Classic shirt', 1399, 'images/men/formal_white_shirt.jpg'),
(1, 'Cream Color Pant', 'Stylish pant', 1199, 'images/men/mens_cream_color_pant.jpg'),
(1, 'T-Shirt', 'Comfort T-shirt', 799, 'images/men/tshirt1.jpg'),

(2, 'Cotton Kurtha', 'Comfort kurtha', 1499, 'images/women/cotton_kurtha.jpg'),
(2, 'Designer Kurtha', 'Designer wear', 1999, 'images/women/Designer_kurtha.jpg'),
(2, 'Indo Western Top', 'Fusion wear', 1799, 'images/women/indo_western.jpg'),
(2, 'Lavender Kurtha', 'Elegant kurtha', 1699, 'images/women/lavendar_color_kurtha.jpg'),
(2, 'Purple Kurtha', 'Trendy kurtha', 1599, 'images/women/purple_kurtha.jpg'),
(2, 'Round Neck Kurtha', 'Casual wear', 1399, 'images/women/round_neck_kurtha.jpg'),
(2, 'Western Dress', 'Stylish dress', 2499, 'images/women/western_dress1.jpg'),

(3, 'Black Leather Shoes', 'Formal shoes', 2999, 'images/shoes/black_leather_shoes.jpg'),
(3, 'Casual Red Shoes', 'Casual wear', 1999, 'images/shoes/casual_red_women.jpg'),
(3, 'Kids Shoes', 'Comfort shoes', 1499, 'images/shoes/kid_shoes.jpg'),
(3, 'Sports Shoes', 'Running shoes', 2499, 'images/shoes/sports_shoes.jpg'),
(3, 'White Sports Shoes', 'Trendy shoes', 2599, 'images/shoes/white_sports_boys_shoe.jpg');