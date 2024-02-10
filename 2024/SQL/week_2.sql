-- Data Inspection

SELECT *
FROM year2024.wk_2_non_flow_card;


SELECT *
FROM year2024.wk_2_flow_card;

-- TASKS:
-- Input the two csv files
-- Union the files together
-- Convert the Date field to a Quarter Number instead
-- Name this field Quarter
-- Aggregate the data in the following ways:
-- Median price per Quarter, Flow Card? and Class
-- Minimum price per Quarter, Flow Card? and Class
-- Maximum price per Quarter, Flow Card? and Class
-- Create three separate flows where you have only one of the aggregated measures in each.
-- One for the minimum price
-- One for the median price
-- One for the maximum price
-- Now pivot the data to have a column per class for each quarter and whether the passenger had a flow card or not
-- Union these flows back together

CREATE VIEW wk_2 AS
SELECT *
FROM year2024.wk_2_flow_card
UNION ALL
SELECT *
FROM year2024.wk_2_non_flow_card;


SELECT *
FROM wk_2;

-- Median price per Quarter, Flow Card? and Class

CREATE
TEMPORARY VIEW median_prices AS WITH subq AS
    (SELECT EXTRACT(Quarter
                    FROM dates) AS quarter,
            flow_card,
            class,
            PERCENTILE_CONT(0.5) WITHIN
     GROUP (
            ORDER BY price) AS median_price
     FROM wk_2
     GROUP BY 1,
              2,
              3)
SELECT flow_card,
       quarter,
       SUM(CASE
               WHEN class = 'Economy' THEN median_price
               ELSE 0
           END) AS economy,
       SUM(CASE
               WHEN class = 'Business Class' THEN median_price
               ELSE 0
           END) AS business,
       SUM(CASE
               WHEN class = 'First Class' THEN median_price
               ELSE 0
           END) AS "first",
       SUM(CASE
               WHEN class = 'Premium Economy' THEN median_price
               ELSE 0
           END) AS premium
FROM subq
GROUP BY 1,
         2;

-- Minimum price per Quarter, Flow Card? and Class

CREATE
TEMPORARY VIEW min_prices AS WITH subq AS
    (SELECT EXTRACT(Quarter
                    FROM dates) AS quarter,
            flow_card,
            class,
            MIN(price) AS min_price
     FROM wk_2
     GROUP BY 1,
              2,
              3)
SELECT flow_card,
       quarter,
       SUM(CASE
               WHEN class = 'Economy' THEN min_price
               ELSE 0
           END) AS economy,
       SUM(CASE
               WHEN class = 'Business Class' THEN min_price
               ELSE 0
           END) AS business,
       SUM(CASE
               WHEN class = 'First Class' THEN min_price
               ELSE 0
           END) AS "first",
       SUM(CASE
               WHEN class = 'Premium Economy' THEN min_price
               ELSE 0
           END) AS premium
FROM subq
GROUP BY 1,
         2;

-- Maximum price per Quarter, Flow Card? and Class

CREATE
TEMPORARY VIEW max_prices AS WITH subq AS
    (SELECT EXTRACT(Quarter
                    FROM dates) AS quarter,
            flow_card,
            class,
            MAX(price) AS max_price
     FROM wk_2
     GROUP BY 1,
              2,
              3)
SELECT flow_card,
       quarter,
       SUM(CASE
               WHEN class = 'Economy' THEN max_price
               ELSE 0
           END) AS economy,
       SUM(CASE
               WHEN class = 'Business Class' THEN max_price
               ELSE 0
           END) AS business,
       SUM(CASE
               WHEN class = 'First Class' THEN max_price
               ELSE 0
           END) AS "first",
       SUM(CASE
               WHEN class = 'Premium Economy' THEN max_price
               ELSE 0
           END) AS premium
FROM subq
GROUP BY 1,
         2;

-- union files back together
-- Change the name of the following columns:
-- Economy to First
-- First Class to Economy
-- Business Class to Premium
-- Premium Economy to Business
-- Output the data
 WITH combined_files AS
    (SELECT *
     FROM median_prices
     UNION ALL SELECT *
     FROM min_prices
     UNION ALL SELECT *
     FROM max_prices)
SELECT flow_card AS "Flow Card?",
       quarter AS "Quarter",
       "first" AS "Economy",
       business AS "Premium",
       premium AS "Business",
       economy AS "First"
FROM combined_files;

