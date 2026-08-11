-- ============================================================
-- BREW BEAN COFFEE - DAY 5: WINDOW FUNCTIONS I
-- Complete Practice File
-- ============================================================

-- ============================================================
-- DATABASE SETUP
-- ============================================================

DROP DATABASE IF EXISTS brew_bean_coffee;
CREATE DATABASE brew_bean_coffee;
USE brew_bean_coffee;

-- ============================================================
-- CREATE TABLES
-- ============================================================

-- 1. Products Table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50),
    category VARCHAR(30),
    price DECIMAL(10,2),
    cost DECIMAL(10,2)
);

-- 2. Employees Table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(50),
    department VARCHAR(30),
    position VARCHAR(30),
    salary DECIMAL(10,2),
    hire_date DATE
);

-- 3. Sales Table (Main Transaction Table)
CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    employee_id INT,
    customer_name VARCHAR(50),
    sale_amount DECIMAL(10,2),
    quantity INT,
    sale_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- 4. Monthly Targets Table
CREATE TABLE monthly_targets (
    target_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_id INT,
    target_month DATE,
    target_amount DECIMAL(10,2),
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
);

-- ============================================================
-- INSERT SAMPLE DATA
-- ============================================================

-- Insert Products
INSERT INTO products (product_name, category, price, cost) VALUES
('Espresso', 'Coffee', 4.50, 1.20),
('Cappuccino', 'Coffee', 5.50, 1.80),
('Latte', 'Coffee', 5.50, 1.80),
('Americano', 'Coffee', 4.00, 1.00),
('Mocha', 'Specialty', 6.50, 2.50),
('Matcha Latte', 'Specialty', 6.00, 2.80),
('Chai Latte', 'Specialty', 5.50, 2.20),
('Croissant', 'Food', 3.50, 1.00),
('Muffin', 'Food', 4.00, 1.20),
('Bagel', 'Food', 4.50, 1.30),
('Coffee Beans 1lb', 'Merchandise', 15.00, 6.00),
('Coffee Mug', 'Merchandise', 12.00, 4.50),
('Tumbler', 'Merchandise', 18.00, 7.00),
('Iced Coffee', 'Coffee', 5.00, 1.50),
('Cold Brew', 'Coffee', 6.00, 2.00);

-- Insert Employees
INSERT INTO employees (employee_name, department, position, salary, hire_date) VALUES
('Emma Johnson', 'Coffee Shop', 'Barista', 32000, '2023-01-15'),
('Liam Smith', 'Coffee Shop', 'Senior Barista', 38000, '2023-02-01'),
('Olivia Davis', 'Coffee Shop', 'Barista', 32000, '2023-03-10'),
('Noah Wilson', 'Coffee Shop', 'Shift Supervisor', 42000, '2023-04-05'),
('Sophia Brown', 'Coffee Shop', 'Barista', 32000, '2023-05-20'),
('Mason Taylor', 'Coffee Shop', 'Assistant Manager', 48000, '2023-06-15'),
('Isabella Anderson', 'Coffee Shop', 'Barista', 32000, '2023-07-01'),
('James Martinez', 'Coffee Shop', 'Barista', 32000, '2023-08-10'),
('Charlotte Garcia', 'Coffee Shop', 'Senior Barista', 38000, '2023-09-05'),
('Benjamin Miller', 'Coffee Shop', 'Barista', 32000, '2023-10-01');

-- Insert Monthly Targets
INSERT INTO monthly_targets (employee_id, target_month, target_amount) VALUES
(1, '2024-01-01', 5000.00),
(1, '2024-02-01', 5200.00),
(1, '2024-03-01', 5500.00),
(2, '2024-01-01', 6000.00),
(2, '2024-02-01', 6200.00),
(2, '2024-03-01', 6500.00),
(3, '2024-01-01', 5000.00),
(3, '2024-02-01', 5100.00),
(3, '2024-03-01', 5400.00),
(4, '2024-01-01', 7000.00),
(4, '2024-02-01', 7200.00),
(4, '2024-03-01', 7500.00),
(5, '2024-01-01', 5000.00),
(5, '2024-02-01', 5300.00),
(5, '2024-03-01', 5600.00);

-- Insert Sales Data (January - March 2024)
INSERT INTO sales (product_id, employee_id, customer_name, sale_amount, quantity, sale_date) VALUES
-- January Sales
(1, 1, 'John Davis', 4.50, 1, '2024-01-01'),
(2, 2, 'Sarah Wilson', 5.50, 1, '2024-01-01'),
(3, 3, 'Mike Brown', 5.50, 1, '2024-01-01'),
(4, 1, 'Emily Clark', 4.00, 1, '2024-01-02'),
(5, 2, 'David Lee', 6.50, 1, '2024-01-02'),
(8, 3, 'Lisa White', 3.50, 1, '2024-01-02'),
(1, 4, 'James Taylor', 4.50, 1, '2024-01-03'),
(3, 1, 'Amanda Moore', 5.50, 1, '2024-01-03'),
(6, 5, 'Robert Green', 6.00, 1, '2024-01-03'),
(2, 2, 'Patricia Adams', 5.50, 1, '2024-01-04'),
(7, 3, 'Thomas Nelson', 5.50, 1, '2024-01-04'),
(11, 4, 'Jennifer Hall', 15.00, 1, '2024-01-04'),
(1, 5, 'Daniel Wright', 4.50, 1, '2024-01-05'),
(9, 1, 'Elizabeth King', 4.00, 1, '2024-01-05'),
(3, 2, 'Paul Baker', 5.50, 1, '2024-01-05'),
(10, 3, 'Barbara Allen', 4.50, 1, '2024-01-06'),
(12, 4, 'Mark Young', 12.00, 1, '2024-01-06'),
(2, 5, 'Sandra Hill', 5.50, 1, '2024-01-06'),
(5, 1, 'Anthony Scott', 6.50, 1, '2024-01-07'),
(4, 2, 'Deborah Turner', 4.00, 1, '2024-01-07'),

-- February Sales (More sales for better analysis)
(1, 1, 'Kevin Adams', 4.50, 1, '2024-02-01'),
(2, 2, 'Carol Thompson', 5.50, 1, '2024-02-01'),
(3, 3, 'Gary Walker', 5.50, 1, '2024-02-01'),
(5, 4, 'Helen Moore', 6.50, 1, '2024-02-02'),
(6, 5, 'Ryan Phillips', 6.00, 1, '2024-02-02'),
(8, 1, 'Katherine Evans', 3.50, 1, '2024-02-02'),
(1, 2, 'Justin Stewart', 4.50, 1, '2024-02-03'),
(7, 3, 'Megan Reed', 5.50, 1, '2024-02-03'),
(13, 4, 'Nathan Murphy', 18.00, 1, '2024-02-03'),
(2, 5, 'Karen Cook', 5.50, 1, '2024-02-04'),
(9, 1, 'Patrick Morgan', 4.00, 1, '2024-02-04'),
(11, 2, 'Rachel Cooper', 15.00, 1, '2024-02-04'),
(3, 3, 'Samuel Bennett', 5.50, 1, '2024-02-05'),
(10, 4, 'Christina Wood', 4.50, 1, '2024-02-05'),
(1, 5, 'Dennis Barnes', 4.50, 1, '2024-02-05'),
(4, 1, 'Diane Ross', 4.00, 1, '2024-02-06'),
(12, 2, 'Ronald Powell', 12.00, 1, '2024-02-06'),
(5, 3, 'Shirley Long', 6.50, 1, '2024-02-06'),
(15, 4, 'Arthur Morris', 6.00, 1, '2024-02-07'),
(2, 5, 'Joan Foster', 5.50, 1, '2024-02-07'),
(8, 1, 'Bruce Bryant', 3.50, 1, '2024-02-07'),
(3, 2, 'Rebecca Patterson', 5.50, 1, '2024-02-08'),
(6, 3, 'Jerry Cooper', 6.00, 1, '2024-02-08'),
(1, 4, 'Ann Butler', 4.50, 1, '2024-02-08'),

-- March Sales
(1, 1, 'Eugene Hughes', 4.50, 1, '2024-03-01'),
(2, 2, 'Doris Coleman', 5.50, 1, '2024-03-01'),
(3, 3, 'Joe Simmons', 5.50, 1, '2024-03-01'),
(5, 4, 'Norma Sanders', 6.50, 1, '2024-03-02'),
(4, 5, 'Frank Diaz', 4.00, 1, '2024-03-02'),
(11, 1, 'Lori Rodriguez', 15.00, 1, '2024-03-02'),
(8, 2, 'Todd Perry', 3.50, 1, '2024-03-03'),
(7, 3, 'Janet King', 5.50, 1, '2024-03-03'),
(13, 4, 'Peter Brooks', 18.00, 1, '2024-03-03'),
(2, 5, 'Rose Morris', 5.50, 1, '2024-03-04'),
(10, 1, 'Stephen Jenkins', 4.50, 1, '2024-03-04'),
(12, 2, 'Stephanie Rivera', 12.00, 1, '2024-03-04'),
(1, 3, 'Raymond Ward', 4.50, 1, '2024-03-05'),
(6, 4, 'Alice Bennett', 6.00, 1, '2024-03-05'),
(9, 5, 'Adam Allen', 4.00, 1, '2024-03-05'),
(3, 1, 'Nicole Gray', 5.50, 1, '2024-03-06'),
(5, 2, 'Eric Carter', 6.50, 1, '2024-03-06'),
(14, 3, 'Judy James', 5.00, 1, '2024-03-06'),
(2, 4, 'Walter Mitchell', 5.50, 1, '2024-03-07'),
(15, 5, 'Martha Moore', 6.00, 1, '2024-03-07'),
(1, 1, 'Harold White', 4.50, 1, '2024-03-07'),
(8, 2, 'Kathleen Nelson', 3.50, 1, '2024-03-08'),
(4, 3, 'Donald Lee', 4.00, 1, '2024-03-08'),
(11, 4, 'Evelyn Harris', 15.00, 1, '2024-03-08');

-- ============================================================
-- SECTION 1: BASIC WINDOW FUNCTIONS
-- ============================================================

-- 1.1 ROW_NUMBER() - Simple Global Ranking
SELECT 
    '=== 1.1 Global Ranking of Sales ===' as '';
SELECT 
    sale_id,
    product_name,
    employee_name,
    sale_amount,
    ROW_NUMBER() OVER (ORDER BY sale_amount DESC) as sale_rank_global
FROM sales s
JOIN products p ON s.product_id = p.product_id
JOIN employees e ON s.employee_id = e.employee_id
ORDER BY sale_rank_global
LIMIT 20;

-- 1.2 ROW_NUMBER() with PARTITION BY - Ranking by Category
SELECT 
    '=== 1.2 Ranking Products by Category ===' as '';
SELECT 
    product_name,
    category,
    price,
    ROW_NUMBER() OVER (PARTITION BY category ORDER BY price DESC) as price_rank_in_category
FROM products
ORDER BY category, price_rank_in_category;

-- ============================================================
-- SECTION 2: RANK vs DENSE_RANK vs ROW_NUMBER COMPARISON
-- ============================================================

SELECT 
    '=== 2.1 Comparison of Ranking Functions ===' as '';
SELECT 
    product_name,
    price,
    ROW_NUMBER() OVER (ORDER BY price DESC) as row_num,
    RANK() OVER (ORDER BY price DESC) as rank_num,
    DENSE_RANK() OVER (ORDER BY price DESC) as dense_rank_num
FROM products;

-- Create a table with duplicate values to demonstrate differences
SELECT 
    '=== 2.2 Ranking Functions with Duplicates ===' as '';
SELECT 
    sale_amount,
    ROW_NUMBER() OVER (ORDER BY sale_amount DESC) as row_num,
    RANK() OVER (ORDER BY sale_amount DESC) as rank_num,
    DENSE_RANK() OVER (ORDER BY sale_amount DESC) as dense_rank_num
FROM sales
LIMIT 20;

-- ============================================================
-- SECTION 3: BUSINESS METRICS WITH WINDOW FUNCTIONS
-- ============================================================

-- 3.1 Top Performers by Category
SELECT 
    '=== 3.1 Top Sales by Category ===' as '';
WITH category_sales AS (
    SELECT 
        p.category,
        SUM(s.sale_amount) as total_sales,
        RANK() OVER (ORDER BY SUM(s.sale_amount) DESC) as category_rank
    FROM sales s
    JOIN products p ON s.product_id = p.product_id
    GROUP BY p.category
)
SELECT *
FROM category_sales
ORDER BY category_rank;

-- 3.2 Employee Performance Ranking by Month
SELECT 
    '=== 3.2 Employee Monthly Performance Ranking ===' as '';
SELECT 
    e.employee_name,
    DATE_FORMAT(s.sale_date, '%Y-%m') as sale_month,
    SUM(s.sale_amount) as monthly_sales,
    RANK() OVER (PARTITION BY DATE_FORMAT(s.sale_date, '%Y-%m') 
                 ORDER BY SUM(s.sale_amount) DESC) as monthly_rank
FROM sales s
JOIN employees e ON s.employee_id = e.employee_id
GROUP BY e.employee_name, DATE_FORMAT(s.sale_date, '%Y-%m')
ORDER BY sale_month, monthly_rank;

-- 3.3 Find Top 3 Products in Each Category
SELECT 
    '=== 3.3 Top 3 Products in Each Category ===' as '';
WITH product_ranking AS (
    SELECT 
        p.product_name,
        p.category,
        SUM(s.sale_amount) as total_revenue,
        ROW_NUMBER() OVER (PARTITION BY p.category ORDER BY SUM(s.sale_amount) DESC) as rank_in_category
    FROM sales s
    JOIN products p ON s.product_id = p.product_id
    GROUP BY p.product_name, p.category
)
SELECT *
FROM product_ranking
WHERE rank_in_category <= 3
ORDER BY category, rank_in_category;

-- ============================================================
-- SECTION 4: PRACTICAL BUSINESS SCENARIOS
-- ============================================================

-- 4.1 Salesperson vs Target Comparison
SELECT 
    '=== 4.1 Employee Performance vs Target ===' as '';
WITH employee_monthly_sales AS (
    SELECT 
        e.employee_name,
        DATE_FORMAT(s.sale_date, '%Y-%m') as sale_month,
        SUM(s.sale_amount) as actual_sales
    FROM sales s
    JOIN employees e ON s.employee_id = e.employee_id
    GROUP BY e.employee_name, DATE_FORMAT(s.sale_date, '%Y-%m')
),
employee_targets AS (
    SELECT 
        e.employee_name,
        DATE_FORMAT(mt.target_month, '%Y-%m') as target_month,
        mt.target_amount
    FROM employees e
    JOIN monthly_targets mt ON e.employee_id = mt.employee_id
)
SELECT 
    ems.employee_name,
    ems.sale_month,
    ems.actual_sales,
    et.target_amount,
    ROUND(((ems.actual_sales - et.target_amount) / et.target_amount) * 100, 2) as performance_percentage,
    CASE 
        WHEN ems.actual_sales >= et.target_amount THEN 'Met Target'
        ELSE 'Below Target'
    END as target_status,
    RANK() OVER (PARTITION BY ems.sale_month ORDER BY (ems.actual_sales - et.target_amount) DESC) as performance_rank
FROM employee_monthly_sales ems
LEFT JOIN employee_targets et ON ems.employee_name = et.employee_name 
    AND ems.sale_month = et.target_month
WHERE et.target_amount IS NOT NULL
ORDER BY ems.sale_month, performance_rank;

-- 4.2 Products with Duplicate Pricing (Data Quality)
SELECT 
    '=== 4.2 Find Duplicate Product Prices ===' as '';
WITH price_duplicates AS (
    SELECT 
        product_name,
        price,
        ROW_NUMBER() OVER (PARTITION BY price ORDER BY product_name) as duplicate_count
    FROM products
)
SELECT 
    product_name,
    price
FROM price_duplicates
WHERE duplicate_count > 1;

-- 4.3 Running Total of Sales by Employee
SELECT 
    '=== 4.3 Running Total of Sales by Employee ===' as '';
SELECT 
    e.employee_name,
    s.sale_date,
    s.sale_amount,
    SUM(s.sale_amount) OVER (PARTITION BY e.employee_name ORDER BY s.sale_date) as running_total,
    ROW_NUMBER() OVER (PARTITION BY e.employee_name ORDER BY s.sale_date) as sale_number
FROM sales s
JOIN employees e ON s.employee_id = e.employee_id
WHERE e.employee_name IN ('Emma Johnson', 'Liam Smith')
ORDER BY e.employee_name, s.sale_date;

-- ============================================================
-- SECTION 5: CHALLENGE PROBLEMS
-- ============================================================

-- Challenge 1: Find the second highest sale in each category
SELECT 
    '=== CHALLENGE 1: Second Highest Sale in Each Category ===' as '';
WITH ranked_sales AS (
    SELECT 
        p.category,
        p.product_name,
        s.sale_amount,
        e.employee_name,
        RANK() OVER (PARTITION BY p.category ORDER BY s.sale_amount DESC) as amount_rank
    FROM sales s
    JOIN products p ON s.product_id = p.product_id
    JOIN employees e ON s.employee_id = e.employee_id
)
SELECT *
FROM ranked_sales
WHERE amount_rank = 2
ORDER BY category, sale_amount DESC;

-- Challenge 2: Employee ranking by total sales with performance tiers
SELECT 
    '=== CHALLENGE 2: Employee Performance Tiers ===' as '';
WITH employee_performance AS (
    SELECT 
        e.employee_name,
        SUM(s.sale_amount) as total_sales,
        RANK() OVER (ORDER BY SUM(s.sale_amount) DESC) as sales_rank,
        DENSE_RANK() OVER (ORDER BY SUM(s.sale_amount) DESC) as dense_sales_rank,
        NTILE(4) OVER (ORDER BY SUM(s.sale_amount) DESC) as quartile
    FROM sales s
    JOIN employees e ON s.employee_id = e.employee_id
    GROUP BY e.employee_name
)
SELECT 
    employee_name,
    total_sales,
    sales_rank,
    CASE 
        WHEN quartile = 1 THEN 'Top Performer'
        WHEN quartile = 2 THEN 'Above Average'
        WHEN quartile = 3 THEN 'Average'
        ELSE 'Needs Improvement'
    END as performance_tier
FROM employee_performance
ORDER BY total_sales DESC;

-- Challenge 3: Products that are consistently in top 3 by month
SELECT 
    '=== CHALLENGE 3: Consistent Top 3 Products by Month ===' as '';
WITH monthly_product_ranking AS (
    SELECT 
        p.product_name,
        DATE_FORMAT(s.sale_date, '%Y-%m') as sale_month,
        SUM(s.sale_amount) as monthly_revenue,
        RANK() OVER (PARTITION BY DATE_FORMAT(s.sale_date, '%Y-%m') 
                     ORDER BY SUM(s.sale_amount) DESC) as monthly_rank
    FROM sales s
    JOIN products p ON s.product_id = p.product_id
    GROUP BY p.product_name, DATE_FORMAT(s.sale_date, '%Y-%m')
)
SELECT 
    product_name,
    COUNT(DISTINCT sale_month) as months_in_top_3,
    GROUP_CONCAT(DISTINCT sale_month ORDER BY sale_month) as months_list
FROM monthly_product_ranking
WHERE monthly_rank <= 3
GROUP BY product_name
HAVING COUNT(DISTINCT sale_month) >= 2
ORDER BY months_in_top_3 DESC, product_name;

-- ============================================================
-- SECTION 6: VIEWS FOR REUSABLE ANALYSIS
-- ============================================================

-- Create View: Employee Monthly Performance
CREATE VIEW employee_monthly_performance AS
SELECT 
    e.employee_id,
    e.employee_name,
    DATE_FORMAT(s.sale_date, '%Y-%m') as sale_month,
    SUM(s.sale_amount) as total_sales,
    COUNT(*) as total_transactions,
    RANK() OVER (PARTITION BY DATE_FORMAT(s.sale_date, '%Y-%m') 
                 ORDER BY SUM(s.sale_amount) DESC) as monthly_rank
FROM sales s
JOIN employees e ON s.employee_id = e.employee_id
GROUP BY e.employee_id, e.employee_name, DATE_FORMAT(s.sale_date, '%Y-%m');

-- Create View: Product Category Performance
CREATE VIEW category_performance AS
SELECT 
    p.category,
    SUM(s.sale_amount) as total_revenue,
    COUNT(*) as units_sold,
    AVG(s.sale_amount) as avg_sale_amount,
    RANK() OVER (ORDER BY SUM(s.sale_amount) DESC) as revenue_rank
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.category;

-- ============================================================
-- SECTION 7: FINAL SUMMARY QUERY
-- ============================================================

SELECT 
    '=== FINAL: Comprehensive Business Dashboard ===' as '';
-- Executive Dashboard combining multiple metrics
WITH employee_sales_summary AS (
    SELECT 
        e.employee_name,
        SUM(s.sale_amount) as total_sales,
        COUNT(DISTINCT s.sale_date) as working_days,
        COUNT(*) as total_transactions,
        AVG(s.sale_amount) as avg_transaction_value,
        RANK() OVER (ORDER BY SUM(s.sale_amount) DESC) as performance_rank
    FROM sales s
    JOIN employees e ON s.employee_id = e.employee_id
    GROUP BY e.employee_name
)
SELECT 
    employee_name,
    total_sales,
    total_transactions,
    ROUND(avg_transaction_value, 2) as avg_transaction_value,
    ROUND(total_sales / working_days, 2) as sales_per_day,
    performance_rank,
    CASE 
        WHEN performance_rank <= 3 THEN '⭐ Top Performer'
        WHEN performance_rank <= 6 THEN '🌟 Strong Contributor'
        ELSE '📈 Developing'
    END as performance_category
FROM employee_sales_summary
ORDER BY performance_rank;

-- ============================================================
-- SECTION 8: CLEANUP (Optional - Uncomment to clean database)
-- ============================================================

-- DROP VIEW IF EXISTS employee_monthly_performance;
-- DROP VIEW IF EXISTS category_performance;
-- DROP TABLE IF EXISTS sales;
-- DROP TABLE IF EXISTS products;
-- DROP TABLE IF EXISTS employees;
-- DROP TABLE IF EXISTS monthly_targets;
-- DROP DATABASE IF EXISTS brew_bean_coffee;

-- ============================================================
-- END OF DAY 5: WINDOW FUNCTIONS I
-- ============================================================