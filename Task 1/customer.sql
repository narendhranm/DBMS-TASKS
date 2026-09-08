-- Task 1: Customer Database Module
CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

CREATE TABLE IF NOT EXISTS Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    phone VARCHAR(20),
    address VARCHAR(255)
);

-- CRUD operations
INSERT INTO Customer (customer_name, email, phone, address)
VALUES ('Demo Customer', 'customer@example.com', '9876543210', 'Chennai');

SELECT * FROM Customer;
UPDATE Customer SET phone = '9999999999', address = 'Tamil Nadu' WHERE customer_id = 1;
-- DELETE FROM Customer WHERE customer_id = 1;

-- Customer order history (after Task 4 tables are created)
SELECT c.customer_id, c.customer_name, o.order_id, o.order_date, o.total_amount
FROM Customer c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE c.customer_id = 1
ORDER BY o.order_date DESC;
