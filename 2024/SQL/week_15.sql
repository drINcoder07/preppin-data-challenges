-- 2024: Week 15 - Store Data Part 2

-- Requirements
-- Input the data
-- Calculate how long it has taken for each item to be removed, based off the day the recall was announced (13/05/2025)
-- Categorise items that were recalled on or by 20/05/2025 as ‘On Target’, those that were recalled after that date as ‘Overdue’, and those that haven’t been removed from the shelves yet as ‘Incomplete’
-- Calculate and rank stores by how long it takes them on average to remove the recalled items
-- Convert the average time it has taken for each store to remove recalled items to 2 fields for days and hours 
-- e.g. 6.5 days would be 6 days and 12 hours
-- Create an output for this
-- For items in the ‘Overdue and ‘Incomplete’ categories, calculate how many days overdue they are
-- Calculate how long, on average, each store is overdue, as well as how many items each store has to remove
-- Round to the nearest whole number
-- Create an output for this

SELECT * FROM year2024.wk_15_advanced_stock_per_store;

CREATE TEMPORARY TABLE categorised_items AS
SELECT 
s.city,
s.store,
s.store_id,
s.date,
s.date - '2025-05-13' AS days_recalled,
CASE
WHEN s.date - '2025-05-13' <= 7 THEN 'On Target'
WHEN s.date - '2025-05-13' > 7 THEN 'Overdue'
ELSE 'Incomplete' END AS category,
s.quantity
FROM year2024.wk_15_advanced_stock_per_store s
JOIN year2024.wk_14_recalled_items r
ON s.product_id = r.product_id AND s.category = r.category;


SELECT * 
FROM categorised_items;

-- OUTPUT 1

SELECT
store,
FLOOR(AVG(days_recalled)) AS days_to_removal,
ROUND(MOD(AVG(days_recalled),FLOOR(AVG(days_recalled)))* 24) AS hours_to_removal
FROM categorised_items
GROUP BY 1
ORDER BY 2,3;


-- OUTPUT 2

SELECT store,
ROUND(AVG(date - '2025-05-20')) AS days_overdue,
SUM(quantity) AS quantity
FROM categorised_items
WHERE category IN ('Overdue', 'Incomplete')
GROUP BY 1;