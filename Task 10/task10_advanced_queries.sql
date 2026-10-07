-- Task 10: Advanced SQL Query System
USE ecommerce_db;

-- 1. Products priced above the overall average product price.
SELECT product_id, product_name, price
FROM Product
WHERE price > (SELECT AVG(price) FROM Product)
ORDER BY price DESC;

-- 2. Products priced above their own category average (correlated subquery).
SELECT p.product_id, p.product_name, c.category_name, p.price
FROM Product p
INNER JOIN Category c ON p.category_id = c.category_id
WHERE p.price > (
    SELECT AVG(p2.price)
    FROM Product p2
    WHERE p2.category_id = p.category_id
)
ORDER BY c.category_name, p.price DESC;

-- 3. Customer(s) with the maximum purchase amount.
WITH CustomerPurchases AS (
    SELECT c.customer_id, c.customer_name,
           COALESCE(SUM(od.subtotal), 0) AS purchase_amount
    FROM Customer c
    LEFT JOIN Orders o ON c.customer_id = o.customer_id
    LEFT JOIN Order_Details od ON o.order_id = od.order_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT customer_id, customer_name, purchase_amount
FROM CustomerPurchases
WHERE purchase_amount = (SELECT MAX(purchase_amount) FROM CustomerPurchases);

-- 4. Customers whose purchase amount is above the average customer purchase.
WITH CustomerPurchases AS (
    SELECT c.customer_id, c.customer_name,
           COALESCE(SUM(od.subtotal), 0) AS purchase_amount
    FROM Customer c
    LEFT JOIN Orders o ON c.customer_id = o.customer_id
    LEFT JOIN Order_Details od ON o.order_id = od.order_id
    GROUP BY c.customer_id, c.customer_name
)
SELECT customer_id, customer_name, purchase_amount
FROM CustomerPurchases
WHERE purchase_amount > (SELECT AVG(purchase_amount) FROM CustomerPurchases)
ORDER BY purchase_amount DESC;

-- 5. Products that have been ordered at least once using EXISTS.
SELECT p.product_id, p.product_name, p.price
FROM Product p
WHERE EXISTS (
    SELECT 1 FROM Order_Details od WHERE od.product_id = p.product_id
)
ORDER BY p.product_name;

-- 6. Products that have never been ordered using NOT EXISTS.
SELECT p.product_id, p.product_name, p.price, p.stock
FROM Product p
WHERE NOT EXISTS (
    SELECT 1 FROM Order_Details od WHERE od.product_id = p.product_id
)
ORDER BY p.product_name;

-- 7. Customers who placed more orders than the average number of orders per customer.
SELECT c.customer_id, c.customer_name, COUNT(o.order_id) AS order_count
FROM Customer c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > (
    SELECT AVG(order_count)
    FROM (
        SELECT customer_id, COUNT(order_id) AS order_count
        FROM Orders
        GROUP BY customer_id
    ) AS customer_order_counts
)
ORDER BY order_count DESC;

-- 8. Best-selling product(s) by total quantity, including ties.
WITH ProductSales AS (
    SELECT p.product_id, p.product_name,
           COALESCE(SUM(od.quantity), 0) AS units_sold
    FROM Product p
    LEFT JOIN Order_Details od ON p.product_id = od.product_id
    GROUP BY p.product_id, p.product_name
)
SELECT product_id, product_name, units_sold
FROM ProductSales
WHERE units_sold = (SELECT MAX(units_sold) FROM ProductSales);

-- 9. Complex business query: customer + orders + sales + payment status.
SELECT c.customer_id, c.customer_name,
       COUNT(DISTINCT o.order_id) AS total_orders,
       COALESCE(SUM(od.subtotal), 0) AS purchase_amount,
       COALESCE(SUM(pay.amount), 0) AS paid_amount,
       COALESCE(SUM(od.subtotal), 0) - COALESCE(SUM(pay.amount), 0) AS balance_amount
FROM Customer c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
LEFT JOIN Order_Details od ON o.order_id = od.order_id
LEFT JOIN Payment pay ON o.order_id = pay.order_id
GROUP BY c.customer_id, c.customer_name
ORDER BY purchase_amount DESC;

-- 10. Products whose sales revenue is above average product revenue.
WITH ProductRevenue AS (
    SELECT p.product_id, p.product_name,
           COALESCE(SUM(od.subtotal), 0) AS revenue
    FROM Product p
    LEFT JOIN Order_Details od ON p.product_id = od.product_id
    GROUP BY p.product_id, p.product_name
)
SELECT product_id, product_name, revenue
FROM ProductRevenue
WHERE revenue > (SELECT AVG(revenue) FROM ProductRevenue)
ORDER BY revenue DESC;

-- 11. Advanced category performance report compared with the category average.
WITH CategorySales AS (
    SELECT cat.category_id, cat.category_name,
           COALESCE(SUM(od.subtotal), 0) AS sales_amount
    FROM Category cat
    LEFT JOIN Product p ON cat.category_id = p.category_id
    LEFT JOIN Order_Details od ON p.product_id = od.product_id
    GROUP BY cat.category_id, cat.category_name
)
SELECT category_id, category_name, sales_amount,
       ROUND((SELECT AVG(sales_amount) FROM CategorySales), 2) AS average_category_sales,
       CASE
           WHEN sales_amount > (SELECT AVG(sales_amount) FROM CategorySales) THEN 'ABOVE AVERAGE'
           ELSE 'AT OR BELOW AVERAGE'
       END AS performance
FROM CategorySales
ORDER BY sales_amount DESC;

-- 12. Customers who purchased products from more than one category.
SELECT c.customer_id, c.customer_name,
       COUNT(DISTINCT p.category_id) AS categories_purchased,
       COALESCE(SUM(od.subtotal), 0) AS purchase_amount
FROM Customer c
INNER JOIN Orders o ON c.customer_id = o.customer_id
INNER JOIN Order_Details od ON o.order_id = od.order_id
INNER JOIN Product p ON od.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(DISTINCT p.category_id) > 1
ORDER BY categories_purchased DESC, purchase_amount DESC;
