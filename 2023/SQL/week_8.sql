-- Week 8 - Taking Stock
 -- Requirements
-- Input each of the 12 monthly files
-- Create a 'file date' using the month found in the file name
-- The Null value should be replaced as 1
-- Clean the Market Cap value to ensure it is the true value as 'Market Capitalisation'
-- Remove any rows with 'n/a'
-- Categorise the Purchase Price into groupings
-- 0 to 24,999.99 as 'Low'
-- 25,000 to 49,999.99 as 'Medium'
-- 50,000 to 74,999.99 as 'High'
-- 75,000 to 100,000 as 'Very High'
-- Categorise the Market Cap into groupings
-- Below $100M as 'Small'
-- Between $100M and below $1B as 'Medium'
-- Between $1B and below $100B as 'Large'
-- $100B and above as 'Huge'
-- Rank the highest 5 purchases per combination of: file date, Purchase Price Categorisation and Market Capitalisation Categorisation.
-- Output only records with a rank of 1 to 5

ALTER TABLE year2023.wk_8_january ADD COLUMN file_date DATE;


ALTER TABLE year2023.wk_8_february ADD COLUMN file_date DATE;


ALTER TABLE year2023.wk_8_march ADD COLUMN file_date DATE;


ALTER TABLE year2023.wk_8_april ADD COLUMN file_date DATE;


ALTER TABLE year2023.wk_8_may ADD COLUMN file_date DATE;


ALTER TABLE year2023.wk_8_june ADD COLUMN file_date DATE;


ALTER TABLE year2023.wk_8_july ADD COLUMN file_date DATE;


ALTER TABLE year2023.wk_8_august ADD COLUMN file_date DATE;


ALTER TABLE year2023.wk_8_september ADD COLUMN file_date DATE;


ALTER TABLE year2023.wk_8_october ADD COLUMN file_date DATE;


ALTER TABLE year2023.wk_8_november ADD COLUMN file_date DATE;


ALTER TABLE year2023.wk_8_december ADD COLUMN file_date DATE;


UPDATE year2023.wk_8_january
SET file_date='2023-01-01';


UPDATE year2023.wk_8_february
SET file_date='2023-02-01';


UPDATE year2023.wk_8_march
SET file_date='2023-03-01';


UPDATE year2023.wk_8_april
SET file_date='2023-04-01';


UPDATE year2023.wk_8_may
SET file_date='2023-05-01';


UPDATE year2023.wk_8_june
SET file_date='2023-06-01';


UPDATE year2023.wk_8_july
SET file_date='2023-07-01';


UPDATE year2023.wk_8_august
SET file_date='2023-08-01';


UPDATE year2023.wk_8_september
SET file_date='2023-09-01';


UPDATE year2023.wk_8_october
SET file_date='2023-10-01';


UPDATE year2023.wk_8_november
SET file_date='2023-11-01';


UPDATE year2023.wk_8_december
SET file_date='2023-12-01';


CREATE
TEMPORARY TABLE taking_stock AS
SELECT *
FROM year2023.wk_8_january
UNION ALL
SELECT *
FROM year2023.wk_8_february
UNION ALL
SELECT *
FROM year2023.wk_8_march
UNION ALL
SELECT *
FROM year2023.wk_8_april
UNION ALL
SELECT *
FROM year2023.wk_8_may
UNION ALL
SELECT *
FROM year2023.wk_8_june
UNION ALL
SELECT *
FROM year2023.wk_8_july
UNION ALL
SELECT *
FROM year2023.wk_8_august
UNION ALL
SELECT *
FROM year2023.wk_8_september
UNION ALL
SELECT *
FROM year2023.wk_8_october
UNION ALL
SELECT *
FROM year2023.wk_8_november
UNION ALL
SELECT *
FROM year2023.wk_8_december;


DROP TABLE IF EXISTS categorised_marketcap_purchase_price;


CREATE
TEMPORARY TABLE categorised_marketcap_purchase_price AS WITH cleaned_marketcap_purchaseprice AS
  (SELECT id,
          first_name,
          last_name,
          ticker,
          sector,
          market,
          stock_name,
          REPLACE(market_cap, '$', '') AS market_cap,
          REPLACE(purchase_price, '$', '') AS purchase_price,
          file_date
   FROM taking_stock
   WHERE market_cap <> 'n/a'),
                converted_marketcap_purchaseprice_decimal AS
  (SELECT id,
          first_name,
          last_name,
          ticker,
          sector,
          market,
          stock_name,
          file_date,
          CASE
              WHEN RIGHT(market_cap, 1) = 'B' THEN REPLACE(market_cap, 'B', '')::DECIMAL * 1000000000
              WHEN RIGHT(market_cap, 1) = 'M' THEN REPLACE(market_cap, 'M', '')::DECIMAL * 1000000
              ELSE market_cap::DECIMAL
          END AS market_cap,
          purchase_price::DECIMAL
   FROM cleaned_marketcap_purchaseprice)
SELECT CASE
           WHEN market_cap < 100000000 THEN 'Small'
           WHEN market_cap < 1000000000 THEN 'Medium'
           WHEN market_cap < 100000000000 THEN 'Large'
           ELSE 'Huge'
       END AS market_capitalisation_category,
       CASE
           WHEN purchase_price <= 24999.99 THEN 'Low'
           WHEN purchase_price <= 49999.99 THEN 'Medium'
           WHEN purchase_price <= 74999.99 THEN 'High'
           ELSE 'Very High'
       END AS purchase_price_category,
       file_date,
       ticker,
       sector,
       market,
       stock_name,
       market_cap AS market_capitalisation,
       purchase_price
FROM converted_marketcap_purchaseprice_decimal;

WITH ranked_categories AS
  (SELECT *,
          RANK() OVER(PARTITION BY file_date, market_capitalisation_category, purchase_price_category
                      ORDER BY market_capitalisation, purchase_price) AS rank
   FROM categorised_marketcap_purchase_price)
SELECT *
FROM ranked_categories
WHERE rank <= 5;