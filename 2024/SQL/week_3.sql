-- DATA INSPECTIONS:

SELECT *
FROM year2024.wk_3_q1;


SELECT *
FROM year2024.wk_3_q2;


SELECT *
FROM year2024.wk_3_q3;


SELECT *
FROM year2024.wk_3_q4;

-- TASKS:
-- Correct the Classes being incorrect as per last week
-- Economy to First
-- First Class to Economy
-- Business Class to Premium
-- Premium Economy to Business
-- Find the First Letter from each word in the Class to help with joining the Targets data to Sales data
-- Change the date to a month number
-- Total up the sales at the level of:
-- Class
-- Month
-- Join the Targets data on to the Sales data (note - you should have 48 rows of data after the join)
-- Calculate the difference between the Sales and Target values per Class and Month
-- Output the data

CREATE
TEMPORARY VIEW wk3_q1 AS
SELECT month,
       CASE
           WHEN class = 'FC' THEN 'E'
           WHEN class = 'E' THEN 'FC'
           WHEN class = 'BC' THEN 'PE'
           ELSE 'BC'
       END AS class,
       target
FROM year2024.wk_3_q1;


CREATE
TEMPORARY VIEW wk3_q2 AS
SELECT month,
       CASE
           WHEN class = 'FC' THEN 'E'
           WHEN class = 'E' THEN 'FC'
           WHEN class = 'BC' THEN 'PE'
           ELSE 'BC'
       END AS class,
       target
FROM year2024.wk_3_q2;


CREATE
TEMPORARY VIEW wk3_q3 AS
SELECT month,
       CASE
           WHEN class = 'FC' THEN 'E'
           WHEN class = 'E' THEN 'FC'
           WHEN class = 'BC' THEN 'PE'
           ELSE 'BC'
       END AS class,
       target
FROM year2024.wk_3_q3;


CREATE
TEMPORARY VIEW wk3_q4 AS
SELECT month,
       CASE
           WHEN class = 'FC' THEN 'E'
           WHEN class = 'E' THEN 'FC'
           WHEN class = 'BC' THEN 'PE'
           ELSE 'BC'
       END AS class,
       target
FROM year2024.wk_3_q4; -- USING VIEW wk_1_prepped as sales file


CREATE
TEMPORARY VIEW sales AS
SELECT EXTRACT(MONTH
               FROM "Date") as month,
       LEFT("Class", 1) AS class,
       SUM("Price") AS price
FROM wk_1_prepped
GROUP BY 1,
         2;


SELECT *
FROM sales;

-- Combining all quarter targets first before merging with the sales data

CREATE
TEMPORARY VIEW targets AS
SELECT *
FROM wk3_q1
UNION ALL
SELECT *
FROM wk3_q2
UNION ALL
SELECT *
FROM wk3_q3
UNION ALL
SELECT *
FROM wk3_q4;


SELECT *
FROM targets;

-- Merging sales, targets, and finding the difference to target

SELECT (s.price - t.target) AS "Difference to Target",
       s.month AS "Date",
       s.price AS "Price",
       CASE
           WHEN t.class = 'FC' THEN 'E'
           WHEN t.class = 'E' THEN 'FC'
           WHEN t.class = 'BC' THEN 'PE'
           ELSE 'BC'
       END AS "Class",
       t.target AS "Target"
FROM sales s
JOIN targets t ON s.month = t.month
AND s.class = LEFT(t.class, 1);