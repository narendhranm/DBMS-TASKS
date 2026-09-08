-- Task 2: Product and Category Management
CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

CREATE TABLE IF NOT EXISTS Category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Product (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150) NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    stock INT NOT NULL DEFAULT 0 CHECK (stock >= 0),
    FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

-- CRUD examples
INSERT INTO Category (category_name, description) VALUES ('Electronics', 'Electronic products');
INSERT INTO Product (product_name, category_id, price, stock)
VALUES ('Wireless Headphones', 1, 2499.00, 50);

SELECT * FROM Product;
UPDATE Product SET price = 2299.00, stock = 55 WHERE product_id = 1;
DELETE FROM Product WHERE product_id = 1;

-- Category-wise product report
SELECT c.category_name, COUNT(p.product_id) AS product_count,
       SUM(p.stock) AS total_stock, AVG(p.price) AS average_price
FROM Category c
LEFT JOIN Product p ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY product_count DESC;
