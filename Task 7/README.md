# Task-VII — SQL Query Implementation for E-Commerce Database

## Objective
To implement and demonstrate practical SQL queries for the existing **E-Commerce Order Management Database System** created in Tasks 1–6.

## Description
Task 7 focuses on retrieving, filtering, sorting, searching, joining, and summarizing data already defined in the coursework database. It does not create a new database or modify the existing schema.

## Requirements Covered
1. SELECT, WHERE, ORDER BY and DISTINCT queries.
2. Product searches based on price, category and availability.
3. Customer and product information retrieval.
4. Filtering with AND, OR, NOT, BETWEEN, IN, LIKE, IS NULL and IS NOT NULL.
5. Basic business reports using JOIN, aggregate functions, GROUP BY and HAVING.

## Tables Used
- Customer
- Category
- Product
- Seller
- Inventory
- Orders
- Order_Details

## Query Categories
### 1. SELECT
Retrieves products, customers, orders, and product/category information.

### 2. WHERE
Filters by product price, stock, customer address, and order amount.

### 3. ORDER BY
Sorts products, customers, and orders using ASC and DESC.

### 4. DISTINCT
Retrieves unique categories, sellers, and customer addresses.

### 5. Product Search
Searches by price, category, and availability.

### 6. Customer and Product Information
Uses JOINs for customer orders, order details, product categories, seller inventory, and products purchased.

### 7. Filtering Conditions
Demonstrates AND, OR, NOT, BETWEEN, IN, LIKE, IS NULL, and IS NOT NULL.

### 8. Business Reports
Includes inventory, availability, category, price-range, customer-order, sales, quantity, and customer-total reports.

Aggregate functions used include COUNT(), SUM(), AVG(), MIN(), and MAX(). GROUP BY and HAVING are also demonstrated.

## How to Execute
1. Make sure MySQL is running.
2. Execute Tasks 1–6 in their intended order to create and populate the existing database.
3. Open `task7_queries.sql` in MySQL Workbench or another MySQL client.
4. Execute the file against `ecommerce_db`.
5. Review each numbered query section and its result.

## Expected Outcome
The queries demonstrate core SQL operations required for Task-VII and produce practical e-commerce information and business reports without changing the existing database design.

## Coursework Notes
- No new schema is created in Task 7.
- Tasks 1–6 are left unchanged.
- Example filter values such as price thresholds and category names can be adjusted to match available sample data.
- SQL follows the MySQL style already used in the repository.
