-- Task 6: Product Review and Rating Management
USE ecommerce_db;

CREATE TABLE IF NOT EXISTS Review (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    review_text VARCHAR(1000),
    review_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (customer_id, product_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

CREATE TABLE IF NOT EXISTS Rating (
    rating_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    rating_value INT NOT NULL CHECK (rating_value BETWEEN 1 AND 5),
    rating_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (customer_id, product_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Example feedback/rating
-- INSERT INTO Review (customer_id, product_id, review_text)
-- VALUES (1, 1, 'Good product and fast delivery.');
-- INSERT INTO Rating (customer_id, product_id, rating_value)
-- VALUES (1, 1, 5);

-- Retrieve reviews
SELECT r.review_id, c.customer_name, p.product_name,
       r.review_text, r.review_date
FROM Review r
JOIN Customer c ON r.customer_id = c.customer_id
JOIN Product p ON r.product_id = p.product_id
ORDER BY r.review_date DESC;

-- Average rating for each product
SELECT p.product_id, p.product_name,
       ROUND(AVG(rt.rating_value), 2) AS average_rating,
       COUNT(rt.rating_id) AS rating_count
FROM Product p
LEFT JOIN Rating rt ON p.product_id = rt.product_id
GROUP BY p.product_id, p.product_name
ORDER BY average_rating DESC;

-- Highly rated products (average >= 4)
SELECT p.product_id, p.product_name,
       ROUND(AVG(rt.rating_value), 2) AS average_rating
FROM Product p
JOIN Rating rt ON p.product_id = rt.product_id
GROUP BY p.product_id, p.product_name
HAVING AVG(rt.rating_value) >= 4
ORDER BY average_rating DESC;
