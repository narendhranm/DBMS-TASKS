# E-Commerce Order Management Database System

This repository contains the DBMS coursework tasks for an E-Commerce Order Management System.

## Project Structure

```text
DBMS-TASKS/
├── Task 1/
├── Task 2/
├── Task 3/
├── Task 4/
├── Task 5/
├── Task 6/
├── Task 7/
├── Task 8/
│   ├── README.md
│   └── task8_joins.sql
├── Task 9/
│   ├── README.md
│   └── task9_analytics.sql
├── Task 10/
│   ├── README.md
│   └── task10_advanced_queries.sql
└── AUTHENTICATION.md
```

## Task Overview

1. **Task 1:** Requirement Analysis and Customer Database Module
2. **Task 2:** Product and Category Management System
3. **Task 3:** Seller and Inventory Management System
4. **Task 4:** Order Management System
5. **Task 5:** Payment Transaction Management System
6. **Task 6:** Product Review and Rating Management System
7. **Task 7:** SQL Query Implementation
8. **Task 8:** Database Relationship Analysis using Joins
9. **Task 9:** Sales and Customer Analytics System
10. **Task 10:** Advanced SQL Query System

## Database Flow

Customer → Orders → Order_Details → Product → Category

Seller → Inventory → Product

Orders → Payment

Customer → Review / Rating → Product

## SQL

The SQL files use the shared `ecommerce_db` database. Run Tasks 1–6 in their intended order so the referenced tables are available. Tasks 7–10 then build query and reporting capabilities on the same schema.

## Authentication

The repository does not implement application authentication. See [AUTHENTICATION.md](AUTHENTICATION.md) for the authentication/credential audit, request-flow explanation, and secure token-handling guidance.
