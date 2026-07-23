-- ============================================
-- Brew & Bean Coffee - Complete Database Setup
-- ============================================

-- Step 1: Create the database
DROP DATABASE IF EXISTS brew_bean_coffee;
CREATE DATABASE brew_bean_coffee;
USE brew_bean_coffee;

-- ============================================
-- Step 2: Create tables
-- ============================================

-- Products table
CREATE TABLE products (
    product_id VARCHAR(10) PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(30),
    price DECIMAL(5,2)
);

-- Employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(30),
    join_date DATE
);

-- Sales table
CREATE TABLE sales (
    order_id INT PRIMARY KEY,
    sale_date DATE,
    product_id VARCHAR(10),
    employee_id INT,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- ============================================
-- Step 3: Insert data
-- ============================================

-- Insert products
INSERT INTO products VALUES
('P001', 'Americano', 'Coffee', 4.50),
('P002', 'Latte', 'Coffee', 5.50),
('P003', 'Cappuccino', 'Coffee', 5.00),
('P004', 'Muffin', 'Pastry', 3.75),
('P005', 'Croissant', 'Pastry', 3.50),
('P006', 'Sandwich', 'Food', 8.00);

-- Insert employees
INSERT INTO employees VALUES
(101, 'Alice Johnson', 'Sales', '2024-01-15'),
(102, 'Bob Williams', 'Sales', '2024-03-22'),
(103, 'Carol Smith', 'Sales', '2025-06-10');

-- Insert sales
INSERT INTO sales VALUES
(1001, '2026-07-01', 'P001', 101, 2),
(1002, '2026-07-01', 'P002', 102, 1),
(1003, '2026-07-02', 'P004', 101, 3),
(1004, '2026-07-02', 'P006', 103, 1),
(1005, '2026-07-03', 'P003', 102, 2),
(1006, '2026-07-03', 'P005', 101, 1),
(1007, '2026-07-04', 'P001', 103, 4),
(1008, '2026-07-04', 'P002', 102, 2),
(1009, '2026-07-05', 'P006', 101, 1),
(1010, '2026-07-05', 'P004', 103, 3);

-- ============================================
-- Step 4: Basic Queries
-- ============================================

-- View all tables
SELECT * FROM products;
SELECT * FROM employees;
SELECT * FROM sales;

-- Select specific columns
SELECT product_name, price FROM products;

-- Filter with WHERE
SELECT * FROM sales WHERE employee_id = 101;

-- Multiple conditions
SELECT * FROM sales WHERE employee_id = 101 AND quantity > 1;

-- Order results
SELECT * FROM products ORDER BY price DESC;

-- ============================================
-- Step 5: Aggregations
-- ============================================

-- Count total orders
SELECT COUNT(*) AS total_orders FROM sales;

-- Total quantity sold
SELECT SUM(quantity) AS total_items_sold FROM sales;

-- Average product price
SELECT AVG(price) AS average_price FROM products;

-- Highest and lowest price
SELECT 
    MAX(price) AS highest_price, 
    MIN(price) AS lowest_price 
FROM products;

-- ============================================
-- Step 6: GROUP BY Analysis
-- ============================================

-- Total quantity sold per product
SELECT 
    product_id, 
    SUM(quantity) AS total_sold
FROM sales
GROUP BY product_id
ORDER BY total_sold DESC;

-- Sales per employee
SELECT 
    employee_id, 
    COUNT(*) AS total_orders, 
    SUM(quantity) AS total_items_sold
FROM sales
GROUP BY employee_id
ORDER BY total_orders DESC;

-- Daily sales
SELECT 
    sale_date, 
    COUNT(*) AS orders, 
    SUM(quantity) AS items_sold
FROM sales
GROUP BY sale_date
ORDER BY sale_date;

-- ============================================
-- End of Script
-- ============================================