-- Task 8: Database Relationship Analysis using Joins
USE ecommerce_db;

-- 1. INNER JOIN: Complete order details with customer, product and payment information.
SELECT o.order_id, o.order_date, c.customer_id, c.customer_name, c.email,
       p.product_id, p.product_name, cat.category_name,
       od.quantity, od.unit_price, od.subtotal,
       pay.payment_method, pay.payment_status, pay.amount AS payment_amount
FROM Orders o
INNER JOIN Customer c ON o.customer_id = c.customer_id
INNER JOIN Order_Details od ON o.order_id = od.order_id
INNER JOIN Product p ON od.product_id = p.product_id
INNER JOIN Category cat ON p.category_id = cat.category_id
LEFT JOIN Payment pay ON o.order_id = pay.order_id
ORDER BY o.order_date DESC, o.order_id;

-- 2. LEFT JOIN: Show every customer, including customers who have never placed an order.
SELECT c.customer_id, c.customer_name, c.email,
       o.order_id, o.order_date, COALESCE(o.total_amount, 0) AS order_amount
FROM Customer c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_name, o.order_date DESC;

-- 3. RIGHT JOIN: Show every product, including products that have never appeared in an order.
SELECT od.order_id, p.product_id, p.product_name, p.price,
       od.quantity, od.subtotal
FROM Order_Details od
RIGHT JOIN Product p ON od.product_id = p.product_id
ORDER BY p.product_name, od.order_id;

-- 4. Customer purchase history.
SELECT c.customer_id, c.customer_name, o.order_id, o.order_date,
       p.product_name, cat.category_name, od.quantity, od.unit_price, od.subtotal
FROM Customer c
INNER JOIN Orders o ON c.customer_id = o.customer_id
INNER JOIN Order_Details od ON o.order_id = od.order_id
INNER JOIN Product p ON od.product_id = p.product_id
INNER JOIN Category cat ON p.category_id = cat.category_id
ORDER BY c.customer_name, o.order_date DESC;

-- 5. Complete order + payment report.
SELECT o.order_id, o.order_date, c.customer_name, o.total_amount AS order_total,
       pay.payment_id, pay.payment_method, pay.payment_status,
       pay.amount AS paid_amount, pay.payment_date
FROM Orders o
INNER JOIN Customer c ON o.customer_id = c.customer_id
LEFT JOIN Payment pay ON o.order_id = pay.order_id
ORDER BY o.order_date DESC;

-- 6. Multi-table sales report by product.
SELECT p.product_id, p.product_name, cat.category_name,
       COUNT(DISTINCT o.order_id) AS order_count,
       SUM(od.quantity) AS units_sold,
       ROUND(SUM(od.subtotal), 2) AS sales_amount
FROM Product p
INNER JOIN Category cat ON p.category_id = cat.category_id
INNER JOIN Order_Details od ON p.product_id = od.product_id
INNER JOIN Orders o ON od.order_id = o.order_id
GROUP BY p.product_id, p.product_name, cat.category_name
ORDER BY sales_amount DESC;

-- 7. Multi-table customer report.
SELECT c.customer_id, c.customer_name,
       COUNT(DISTINCT o.order_id) AS order_count,
       COUNT(DISTINCT od.order_detail_id) AS line_items,
       COALESCE(SUM(od.subtotal), 0) AS purchase_amount
FROM Customer c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
LEFT JOIN Order_Details od ON o.order_id = od.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY purchase_amount DESC;

-- 8. Payment status report linked to customers and orders.
SELECT c.customer_name, o.order_id, o.order_date, o.total_amount,
       COALESCE(pay.payment_status, 'NOT PAID') AS payment_status,
       COALESCE(pay.payment_method, 'N/A') AS payment_method,
       COALESCE(pay.amount, 0) AS payment_amount
FROM Customer c
INNER JOIN Orders o ON c.customer_id = o.customer_id
LEFT JOIN Payment pay ON o.order_id = pay.order_id
ORDER BY o.order_date DESC;
