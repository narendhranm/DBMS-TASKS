-- Task 7: SQL Query Implementation for E-Commerce Database
USE ecommerce_db;

-- 1. SELECT QUERIES
SELECT * FROM Product;
SELECT product_name, price, stock FROM Product;
SELECT customer_id, customer_name, email, phone FROM Customer;
SELECT order_id, customer_id, order_date, total_amount FROM Orders;
SELECT p.product_id, p.product_name, c.category_name, p.price, p.stock
FROM Product p JOIN Category c ON p.category_id = c.category_id;

-- 2. WHERE / FILTERING QUERIES
SELECT product_id, product_name, price FROM Product WHERE price > 1000;
SELECT product_id, product_name, price FROM Product WHERE price < 5000;
SELECT product_name, price FROM Product WHERE price >= 1000;
SELECT product_name, price FROM Product WHERE price <> 1000;
SELECT product_id, product_name, stock FROM Product WHERE stock > 0;
SELECT product_id, product_name, stock FROM Product WHERE stock = 0;
SELECT customer_id, customer_name, email, address FROM Customer WHERE address = 'Chennai';
SELECT order_id, customer_id, order_date, total_amount FROM Orders WHERE total_amount > 5000;

-- 3. ORDER BY QUERIES
SELECT product_id, product_name, price FROM Product ORDER BY price ASC;
SELECT product_id, product_name, price FROM Product ORDER BY price DESC;
SELECT product_id, product_name, price FROM Product ORDER BY product_name ASC;
SELECT customer_id, customer_name, email FROM Customer ORDER BY customer_name ASC;
SELECT order_id, customer_id, order_date, total_amount FROM Orders ORDER BY order_date DESC;

-- 4. DISTINCT QUERIES
SELECT DISTINCT c.category_name
FROM Category c JOIN Product p ON c.category_id = p.category_id
ORDER BY c.category_name;
SELECT DISTINCT s.seller_id, s.seller_name
FROM Seller s JOIN Inventory i ON s.seller_id = i.seller_id
ORDER BY s.seller_name;
SELECT DISTINCT address FROM Customer WHERE address IS NOT NULL ORDER BY address;

-- 5. PRODUCT SEARCH: PRICE, CATEGORY AND AVAILABILITY
SELECT product_id, product_name, price FROM Product
WHERE price < 3000 ORDER BY price ASC;
SELECT product_id, product_name, price FROM Product
WHERE price > 1000 ORDER BY price DESC;
SELECT product_id, product_name, price FROM Product
WHERE price BETWEEN 1000 AND 5000 ORDER BY price ASC;
SELECT p.product_id, p.product_name, c.category_name, p.price
FROM Product p JOIN Category c ON p.category_id = c.category_id
WHERE c.category_name = 'Electronics' ORDER BY p.product_name;
SELECT product_id, product_name, stock FROM Product
WHERE stock > 0 ORDER BY stock DESC;
SELECT product_id, product_name, stock FROM Product
WHERE stock = 0 ORDER BY product_name;

-- 6. CUSTOMER AND PRODUCT INFORMATION
SELECT c.customer_id, c.customer_name, o.order_id, o.order_date, o.total_amount
FROM Customer c JOIN Orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_name, o.order_date DESC;

SELECT o.order_id, o.order_date, od.product_id, od.quantity, od.unit_price, od.subtotal
FROM Orders o JOIN Order_Details od ON o.order_id = od.order_id
ORDER BY o.order_date DESC, o.order_id;

SELECT p.product_id, p.product_name, c.category_name, p.price, p.stock
FROM Product p JOIN Category c ON p.category_id = c.category_id
ORDER BY c.category_name, p.product_name;

SELECT p.product_id, p.product_name, s.seller_id, s.seller_name,
       i.quantity, i.availability
FROM Product p
JOIN Inventory i ON p.product_id = i.product_id
JOIN Seller s ON i.seller_id = s.seller_id
ORDER BY p.product_name, s.seller_name;

SELECT c.customer_id, c.customer_name, o.order_id, o.order_date,
       p.product_id, p.product_name, od.quantity, od.unit_price, od.subtotal
FROM Customer c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Details od ON o.order_id = od.order_id
JOIN Product p ON od.product_id = p.product_id
ORDER BY c.customer_name, o.order_date DESC;

-- 7. PRACTICAL FILTERING CONDITIONS
SELECT product_id, product_name, price, stock FROM Product
WHERE price <= 5000 AND stock > 0 ORDER BY price ASC;

SELECT product_id, product_name, price, stock FROM Product
WHERE price < 1000 OR stock = 0;

SELECT p.product_id, p.product_name, c.category_name
FROM Product p JOIN Category c ON p.category_id = c.category_id
WHERE NOT c.category_name = 'Electronics';

SELECT product_id, product_name, price FROM Product
WHERE price BETWEEN 1000 AND 5000;

SELECT p.product_id, p.product_name, c.category_name
FROM Product p JOIN Category c ON p.category_id = c.category_id
WHERE c.category_name IN ('Electronics', 'Clothing');

SELECT product_id, product_name, price FROM Product
WHERE product_name LIKE '%phone%';

SELECT customer_id, customer_name, email FROM Customer
WHERE address IS NULL;

SELECT customer_id, customer_name, email, address FROM Customer
WHERE address IS NOT NULL;

-- 8. BASIC BUSINESS REPORTS

-- 8.1 Product inventory report
SELECT p.product_id, p.product_name, c.category_name, p.price, p.stock,
       CASE WHEN p.stock > 0 THEN 'AVAILABLE' ELSE 'UNAVAILABLE' END AS stock_status
FROM Product p JOIN Category c ON p.category_id = c.category_id
ORDER BY c.category_name, p.product_name;

-- 8.2 Available/unavailable product summary
SELECT CASE WHEN stock > 0 THEN 'AVAILABLE' ELSE 'UNAVAILABLE' END AS availability_status,
       COUNT(*) AS product_count, SUM(stock) AS total_stock
FROM Product
GROUP BY CASE WHEN stock > 0 THEN 'AVAILABLE' ELSE 'UNAVAILABLE' END;

-- 8.3 Products by category
SELECT c.category_name, COUNT(p.product_id) AS product_count,
       SUM(p.stock) AS total_stock, ROUND(AVG(p.price), 2) AS average_price,
       MIN(p.price) AS minimum_price, MAX(p.price) AS maximum_price
FROM Category c LEFT JOIN Product p ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
ORDER BY product_count DESC, c.category_name;

-- 8.4 Products within a price range
SELECT product_id, product_name, price, stock
FROM Product WHERE price BETWEEN 1000 AND 5000 ORDER BY price ASC;

-- 8.5 Customer order history
SELECT c.customer_id, c.customer_name, o.order_id, o.order_date, o.total_amount
FROM Customer c JOIN Orders o ON c.customer_id = o.customer_id
ORDER BY c.customer_name, o.order_date DESC;

-- 8.6 Orders with customer details
SELECT o.order_id, o.order_date, c.customer_id, c.customer_name, c.email, o.total_amount
FROM Orders o JOIN Customer c ON o.customer_id = c.customer_id
ORDER BY o.order_date DESC;

-- 8.7 Product sales/order report
SELECT p.product_id, p.product_name,
       COUNT(DISTINCT od.order_id) AS order_count,
       SUM(od.quantity) AS total_quantity_ordered,
       ROUND(SUM(od.subtotal), 2) AS total_sales
FROM Product p JOIN Order_Details od ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sales DESC;

-- 8.8 Total quantity ordered per product
SELECT p.product_id, p.product_name,
       COALESCE(SUM(od.quantity), 0) AS total_quantity_ordered
FROM Product p LEFT JOIN Order_Details od ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_ordered DESC, p.product_name;

-- 8.9 Total order amount by customer
SELECT c.customer_id, c.customer_name,
       COUNT(o.order_id) AS order_count,
       COALESCE(SUM(o.total_amount), 0) AS total_order_amount,
       COALESCE(AVG(o.total_amount), 0) AS average_order_amount
FROM Customer c LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_order_amount DESC;

-- 8.10 Basic category/product report
SELECT c.category_name, p.product_name, p.price, p.stock
FROM Category c JOIN Product p ON c.category_id = p.category_id
ORDER BY c.category_name, p.price DESC;

-- 8.11 HAVING example
SELECT c.category_name, COUNT(p.product_id) AS product_count
FROM Category c JOIN Product p ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name
HAVING COUNT(p.product_id) > 1
ORDER BY product_count DESC;
