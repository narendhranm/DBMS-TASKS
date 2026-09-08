-- Task 5: Payment Transaction Management
USE ecommerce_db;

CREATE TABLE IF NOT EXISTS Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_method ENUM('CASH','CARD','UPI','NET_BANKING','WALLET') NOT NULL,
    payment_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    payment_status ENUM('SUCCESSFUL','FAILED','PENDING') NOT NULL DEFAULT 'PENDING',
    amount DECIMAL(12,2) NOT NULL CHECK (amount >= 0),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Example transaction records
-- INSERT INTO Payment (order_id, payment_method, payment_status, amount)
-- VALUES (1, 'UPI', 'SUCCESSFUL', 4598.00);

-- Successful/failed transaction report
SELECT payment_status, COUNT(*) AS transaction_count,
       SUM(amount) AS total_amount
FROM Payment
GROUP BY payment_status;

-- Payment method analysis
SELECT payment_method, COUNT(*) AS transaction_count,
       SUM(amount) AS total_amount
FROM Payment
GROUP BY payment_method
ORDER BY transaction_count DESC;

-- Detailed payment report
SELECT p.payment_id, p.order_id, p.payment_method,
       p.payment_date, p.payment_status, p.amount
FROM Payment p
ORDER BY p.payment_date DESC;
