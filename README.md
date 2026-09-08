# E-Commerce Order Management Database System

This repository contains the six DBMS tasks for an E-Commerce Order Management System.

## Project Structure

```text
DBMS-TASKS/
├── Task 1/
│   ├── README.md
│   ├── requirement_specification.md
│   └── customer.sql
├── Task 2/
│   ├── README.md
│   └── product_category.sql
├── Task 3/
│   ├── README.md
│   └── seller_inventory.sql
├── Task 4/
│   ├── README.md
│   └── order_management.sql
├── Task 5/
│   ├── README.md
│   └── payment.sql
└── Task 6/
    ├── README.md
    └── review_rating.sql
```

## Task Overview

1. **Task 1:** Requirement Analysis and Customer Database Module
2. **Task 2:** Product and Category Management System
3. **Task 3:** Seller and Inventory Management System
4. **Task 4:** Order Management System
5. **Task 5:** Payment Transaction Management System
6. **Task 6:** Product Review and Rating Management System

## Database Flow

Customer → Orders → Order_Details → Product → Category

Seller → Inventory → Product

Orders → Payment

Customer → Review / Rating → Product

## SQL
The SQL files are organized by task and use the shared `ecommerce_db` database. Run Task 1 first, followed by Tasks 2–6 so the referenced tables are available.
