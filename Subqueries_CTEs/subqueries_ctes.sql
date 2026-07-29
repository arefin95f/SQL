USE brew_bean_coffee;

-- Add more sales data for richer analysis
INSERT INTO sales VALUES
(1011, '2026-07-06', 'P001', 101, 5),
(1012, '2026-07-06', 'P003', 103, 3),
(1013, '2026-07-07', 'P002', 102, 2),
(1014, '2026-07-07', 'P005', 101, 4),
(1015, '2026-07-08', 'P006', 103, 2),
(1016, '2026-07-08', 'P001', 102, 3),
(1017, '2026-07-09', 'P004', 101, 6),
(1018, '2026-07-09', 'P002', 103, 1),
(1019, '2026-07-10', 'P003', 102, 4),
(1020, '2026-07-10', 'P006', 101, 2);

-- Verify
SELECT COUNT(*) AS total_orders FROM sales;

-- Find sales where quantity is above average
SELECT 
    order_id,
    product_id,
    quantity
FROM sales
WHERE quantity > (SELECT AVG(quantity) FROM sales);

-- Products with total quantity above the overall average
SELECT 
    product_id,
    SUM(quantity) AS total_sold
FROM sales
GROUP BY product_id
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- Employees who sold on the highest revenue day
SELECT DISTINCT employee_id
FROM sales
WHERE sale_date = (
    SELECT sale_date
    FROM sales
    GROUP BY sale_date
    ORDER BY SUM(quantity) DESC
    LIMIT 1
);

SELECT 
    s.order_id,
    s.product_id,
    s.quantity,
    (SELECT AVG(quantity) FROM sales) AS overall_avg,
    s.quantity - (SELECT AVG(quantity) FROM sales) AS diff_from_avg
FROM sales s;