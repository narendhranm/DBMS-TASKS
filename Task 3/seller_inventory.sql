-- Task 3: Seller and Inventory Management
USE ecommerce_db;

CREATE TABLE IF NOT EXISTS Seller (
    seller_id INT PRIMARY KEY AUTO_INCREMENT,
    seller_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE,
    phone VARCHAR(20)
);

CREATE TABLE IF NOT EXISTS Inventory (
    inventory_id INT PRIMARY KEY AUTO_INCREMENT,
    seller_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL DEFAULT 0 CHECK (quantity >= 0),
    availability ENUM('AVAILABLE','UNAVAILABLE') NOT NULL DEFAULT 'AVAILABLE',
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE (seller_id, product_id),
    FOREIGN KEY (seller_id) REFERENCES Seller(seller_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

INSERT INTO Seller (seller_name, email, phone)
VALUES ('Demo Seller', 'seller@example.com', '9876543210');

-- Seller-product-stock relationship
SELECT s.seller_name, p.product_name, i.quantity, i.availability
FROM Inventory i
JOIN Seller s ON i.seller_id = s.seller_id
JOIN Product p ON i.product_id = p.product_id;

-- Track availability
UPDATE Inventory
SET availability = CASE WHEN quantity > 0 THEN 'AVAILABLE' ELSE 'UNAVAILABLE' END
WHERE inventory_id = 1;

-- Inventory report
SELECT s.seller_name,
       COUNT(i.product_id) AS products_managed,
       SUM(i.quantity) AS total_stock,
       SUM(i.quantity = 0) AS unavailable_items
FROM Seller s
LEFT JOIN Inventory i ON s.seller_id = i.seller_id
GROUP BY s.seller_id, s.seller_name;
