-- Task 9: Sales and Customer Analytics System
USE ecommerce_db;

-- 1. Overall sales statistics using COUNT, SUM, AVG, MIN and MAX.
SELECT COUNT(DISTINCT o.order_id) AS total_orders,
       COUNT(od.order_detail_id) AS total_order_lines,
       COALESCE(SUM(od.quantity), 0) AS total_units_sold,
       COALESCE(SUM(od.subtotal), 0) AS total_sales,
       COALESCE(AVG(od.subtotal), 0) AS average_line_sales,
       COALESCE(MIN(od.subtotal), 0) AS minimum_line_sales,
       COALESCE(MAX(od.subtotal), 0) AS maximum_line_sales
FROM Orders o LEFT JOIN Order_Details od ON o.order_id = od.order_id;

-- 2. Total sales report by order.
SELECT o.order_id, o.order_date, c.customer_name, o.total_amount,
       COALESCE(SUM(od.subtotal), 0) AS calculated_sales
FROM Orders o
INNER JOIN Customer c ON o.customer_id = c.customer_id
LEFT JOIN Order_Details od ON o.order_id = od.order_id
GROUP BY o.order_id, o.order_date, c.customer_name, o.total_amount
ORDER BY o.order_date DESC;

-- 3. Top customers based on purchase amount.
SELECT c.customer_id, c.customer_name,
       COUNT(DISTINCT o.order_id) AS order_count,
       COALESCE(SUM(od.subtotal), 0) AS purchase_amount
FROM Customer c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
LEFT JOIN Order_Details od ON o.order_id = od.order_id
GROUP BY c.customer_id, c.customer_name
HAVING COALESCE(SUM(od.subtotal), 0) > 0
ORDER BY purchase_amount DESC LIMIT 10;

-- 4. Best-selling products by quantity.
SELECT p.product_id, p.product_name,
       SUM(od.quantity) AS units_sold,
       ROUND(SUM(od.subtotal), 2) AS sales_amount
FROM Product p INNER JOIN Order_Details od ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name
ORDER BY units_sold DESC, sales_amount DESC LIMIT 10;

-- 5. Best-selling products by revenue.
SELECT p.product_id, p.product_name,
       COUNT(DISTINCT od.order_id) AS order_count,
       SUM(od.quantity) AS units_sold,
       ROUND(SUM(od.subtotal), 2) AS revenue
FROM Product p INNER JOIN Order_Details od ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name
ORDER BY revenue DESC LIMIT 10;

-- 6. Category-wise sales analysis.
SELECT cat.category_id, cat.category_name,
       COUNT(DISTINCT o.order_id) AS order_count,
       SUM(od.quantity) AS units_sold,
       ROUND(SUM(od.subtotal), 2) AS category_sales,
       ROUND(AVG(od.unit_price), 2) AS average_selling_price,
       MIN(od.unit_price) AS minimum_selling_price,
       MAX(od.unit_price) AS maximum_selling_price
FROM Category cat
INNER JOIN Product p ON cat.category_id = p.category_id
INNER JOIN Order_Details od ON p.product_id = od.product_id
INNER JOIN Orders o ON od.order_id = o.order_id
GROUP BY cat.category_id, cat.category_name
ORDER BY category_sales DESC;

-- 7. Customer average order value.
SELECT c.customer_id, c.customer_name,
       COUNT(o.order_id) AS order_count,
       ROUND(AVG(o.total_amount), 2) AS average_order_value,
       ROUND(MIN(o.total_amount), 2) AS minimum_order_value,
       ROUND(MAX(o.total_amount), 2) AS maximum_order_value,
       ROUND(SUM(o.total_amount), 2) AS total_order_value
FROM Customer c INNER JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_order_value DESC;

-- 8. Sales summary by customer and category.
SELECT c.customer_name, cat.category_name,
       SUM(od.quantity) AS units_bought,
       ROUND(SUM(od.subtotal), 2) AS category_purchase_amount
FROM Customer c
INNER JOIN Orders o ON c.customer_id = o.customer_id
INNER JOIN Order_Details od ON o.order_id = od.order_id
INNER JOIN Product p ON od.product_id = p.product_id
INNER JOIN Category cat ON p.category_id = cat.category_id
GROUP BY c.customer_id, c.customer_name, cat.category_id, cat.category_name
ORDER BY c.customer_name, category_purchase_amount DESC;

-- 9. Overall product price statistics.
SELECT COUNT(*) AS product_count,
       ROUND(AVG(price), 2) AS average_price,
       MIN(price) AS minimum_price,
       MAX(price) AS maximum_price,
       SUM(stock) AS total_current_stock
FROM Product;

-- 10. Products with their sales performance, including products with no sales.
SELECT p.product_id, p.product_name,
       COALESCE(SUM(od.quantity), 0) AS units_sold,
       COALESCE(SUM(od.subtotal), 0) AS total_sales
FROM Product p LEFT JOIN Order_Details od ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sales DESC, p.product_name;
