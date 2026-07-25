-- ============================================
-- Brew & Bean Coffee - SQL JOINs
-- ============================================

USE brew_bean_coffee;

-- ============================================
-- Step 1: Create and populate regions table
-- ============================================

CREATE TABLE regions (
    region_id VARCHAR(5) PRIMARY KEY,
    region_name VARCHAR(30),
    manager VARCHAR(50)
);

INSERT INTO regions VALUES
('R1', 'North', 'Alice Johnson'),
('R2', 'South', 'Bob Williams'),
('R3', 'East', 'Carol Smith'),
('R4', 'West', NULL);

-- Add region_id to employees
ALTER TABLE employees ADD COLUMN region_id VARCHAR(5);

UPDATE employees SET region_id = 'R1' WHERE employee_id = 101;
UPDATE employees SET region_id = 'R2' WHERE employee_id = 102;
UPDATE employees SET region_id = 'R3' WHERE employee_id = 103;

-- Add an employee with no region (for LEFT JOIN demo)
INSERT INTO employees VALUES
(104, 'David Brown', 'Sales', '2026-01-01', NULL);

-- View the setup
SELECT * FROM regions;
SELECT * FROM employees;

-- ============================================
-- Step 2: INNER JOIN (matching records only)
-- ============================================

-- Employees with their regions
SELECT 
    e.employee_name,
    e.department,
    r.region_name,
    r.manager
FROM employees e
INNER JOIN regions r ON e.region_id = r.region_id;

-- Sales with product names and calculated totals
SELECT 
    s.order_id,
    s.sale_date,
    p.product_name,
    p.category,
    s.quantity,
    p.price,
    (s.quantity * p.price) AS total_amount
FROM sales s
INNER JOIN products p ON s.product_id = p.product_id;

-- Three-table JOIN (sales + employees + products)
SELECT 
    s.order_id,
    s.sale_date,
    e.employee_name,
    p.product_name,
    s.quantity,
    (s.quantity * p.price) AS total_amount
FROM sales s
INNER JOIN employees e ON s.employee_id = e.employee_id
INNER JOIN products p ON s.product_id = p.product_id;

-- ============================================
-- Step 3: LEFT JOIN (all from left table)
-- ============================================

-- All employees even if no region
SELECT 
    e.employee_name,
    r.region_name
FROM employees e
LEFT JOIN regions r ON e.region_id = r.region_id;

-- All products even if never sold
SELECT 
    p.product_name,
    p.category,
    s.order_id,
    s.quantity
FROM products p
LEFT JOIN sales s ON p.product_id = s.product_id
ORDER BY p.product_name, s.order_id;

-- ============================================
-- Step 4: RIGHT JOIN (all from right table)
-- ============================================

-- All regions even if no employees
SELECT 
    r.region_name,
    e.employee_name
FROM employees e
RIGHT JOIN regions r ON e.region_id = r.region_id;

-- Find regions with no employees
SELECT 
    r.region_name,
    r.manager
FROM employees e
RIGHT JOIN regions r ON e.region_id = r.region_id
WHERE e.employee_id IS NULL;

-- ============================================
-- Step 5: FULL OUTER JOIN (simulated with UNION)
-- ============================================

SELECT 
    e.employee_name,
    r.region_name
FROM employees e
LEFT JOIN regions r ON e.region_id = r.region_id

UNION

SELECT 
    e.employee_name,
    r.region_name
FROM employees e
RIGHT JOIN regions r ON e.region_id = r.region_id;

-- ============================================
-- Step 6: JOINs with Aggregation
-- ============================================

-- Total revenue per employee
SELECT 
    e.employee_name,
    COUNT(s.order_id) AS total_orders,
    SUM(s.quantity * p.price) AS total_revenue
FROM sales s
INNER JOIN employees e ON s.employee_id = e.employee_id
INNER JOIN products p ON s.product_id = p.product_id
GROUP BY e.employee_name
ORDER BY total_revenue DESC;

-- Total sales by category
SELECT 
    p.category,
    SUM(s.quantity) AS items_sold,
    SUM(s.quantity * p.price) AS total_revenue
FROM sales s
INNER JOIN products p ON s.product_id = p.product_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- Monthly sales trend
SELECT 
    DATE_FORMAT(s.sale_date, '%Y-%m') AS month,
    COUNT(s.order_id) AS orders,
    SUM(s.quantity * p.price) AS revenue
FROM sales s
INNER JOIN products p ON s.product_id = p.product_id
GROUP BY DATE_FORMAT(s.sale_date, '%Y-%m')
ORDER BY month;

-- ============================================
-- Step 7: Self JOIN (table joins itself)
-- ============================================

-- Employees in the same region
SELECT 
    e1.employee_name AS employee1,
    e2.employee_name AS employee2,
    r.region_name
FROM employees e1
INNER JOIN employees e2 ON e1.region_id = e2.region_id
INNER JOIN regions r ON e1.region_id = r.region_id
WHERE e1.employee_id < e2.employee_id;

-- ============================================
-- End of Script
-- ============================================