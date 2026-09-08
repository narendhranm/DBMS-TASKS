-- Task 4: Order Management System
USE ecommerce_db;

CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(12,2) NOT NULL DEFAULT 0 CHECK (total_amount >= 0)
);

CREATE TABLE IF NOT EXISTS Order_Details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL CHECK (unit_price >= 0),
    subtotal DECIMAL(12,2) GENERATED ALWAYS AS (quantity * unit_price) STORED,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Insert an order (customer_id must exist in the final Customer table)
-- INSERT INTO Orders (customer_id) VALUES (1);
-- INSERT INTO Order_Details (order_id, product_id, quantity, unit_price)
-- VALUES (1, 1, 2, 2299.00);

-- Recalculate order total
UPDATE Orders o
SET total_amount = (
    SELECT COALESCE(SUM(od.subtotal), 0)
    FROM Order_Details od
    WHERE od.order_id = o.order_id
)
WHERE o.order_id = 1;

-- Customer order history
SELECT o.order_id, o.order_date, o.total_amount,
       od.product_id, od.quantity, od.unit_price, od.subtotal
FROM Orders o
JOIN Order_Details od ON o.order_id = od.order_id
WHERE o.customer_id = 1
ORDER BY o.order_date DESC;
