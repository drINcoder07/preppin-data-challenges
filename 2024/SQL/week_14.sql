-- 2024: Week 14 - Store Data

-- Requirements 
-- Input the data tables
-- Identify which recalled items are located in each store
-- Create a field which shows how much money will be lost for each item
-- Then calculate how much money will be lost for each category, and round it to 2 dp
-- Output this first dataset
-- Phill Down (the CEO of SuperBytes) now needs to know how much money each store has lost! Find those values for each store, again rounding to 2 dp.
-- Mr Down has decided that any store that has lost £5000 or more is considered 'High Priority' and anything below that is 'Low Priority'. Create a new field that identifies which stores are High or Low priority. 
-- Output this second dataset


-- Data Inspection
SELECT * FROM year2024.wk_14_recalled_items;
SELECT * FROM year2024.wk_14_stock_per_store
ORDER BY 1, 2;

-- Output 1
WITH tmp AS
(SELECT s.*
FROM year2024.wk_14_stock_per_store s
JOIN year2024.wk_14_recalled_items r
ON s.product_id = r.product_id AND s.category = r.category
ORDER BY s.city, s.store
)
SELECT category, SUM(unit_price * quantity) AS total_price
FROM tmp
GROUP BY category;


-- Output 2
WITH tmp AS
(SELECT s.*
FROM year2024.wk_14_stock_per_store s
JOIN year2024.wk_14_recalled_items r
ON s.product_id = r.product_id AND s.category = r.category
ORDER BY s.city, s.store
)
SELECT store, SUM(unit_price * quantity) AS total_price,
CASE WHEN SUM(unit_price * quantity) >= 5000 THEN 'High Priority'
ELSE 'Low Priority' END AS issue_level
FROM tmp
GROUP BY store
ORDER BY 2;
