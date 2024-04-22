--filtering 2023 and 2024 transactions only

SELECT *
FROM year2024.wk_10_transactions
WHERE transaction_date >= '2023-01-01';


CREATE
TEMPORARY VIEW transactions AS WITH date_table AS
  (SELECT generate_series(
                            (SELECT MIN(transaction_date)
                             FROM year2024.wk_10_transactions
                             WHERE transaction_date >= '2023-01-01'),
                            (SELECT MAX(transaction_date)
                             FROM year2024.wk_10_transactions
                             WHERE transaction_date >= '2023-01-01'), '1 day'::INTERVAL) AS date)
SELECT d.date::DATE AS transaction_date,
       t.transaction_number,
       SPLIT_PART(t.product_id, '-', 1) AS product_type,
       REPLACE(SPLIT_PART(t.product_id, '-', 2), '_', ' ') AS product_scent,
       SPLIT_PART(t.product_id, '-', 3) AS product_size,
       CASE
           WHEN t.cash_or_card = 1 THEN 'Card'
           WHEN t.cash_or_card = 2 THEN 'Cash'
           ELSE NULL
       END AS cash_or_card,
       t.loyalty_number,
       t.sales_before_discount
FROM date_table d
LEFT JOIN year2024.wk_10_transactions t ON d.date = t.transaction_date;


CREATE
TEMPORARY VIEW products AS
SELECT product_type,
       product_scent,
       COALESCE(pack_size, '') || COALESCE(product_size, '') AS product_size,
       unit_cost,
       selling_price
FROM year2024.wk_10_product;


SELECT *
FROM transactions;


SELECT *
FROM products;


CREATE
TEMPORARY VIEW joined_transactions_products AS
SELECT t.*,
       p.unit_cost,
       (t.sales_before_discount/p.selling_price)::INTEGER AS quantity
FROM transactions t
LEFT JOIN products p ON t.product_type = p.product_type
AND t.product_scent = p.product_scent
AND t.product_size = p.product_size;


SELECT *
FROM joined_transactions_products;

-- loyalty table
-- clean names
-- clean Sliver, Bronz, silver, Goald, bronze, gold in loyalty_tier
-- BRONZE 5, SILVER 10, GOLD 15 discount

CREATE
TEMPORARY VIEW loyalty AS WITH tmp AS
  (SELECT loyalty_number,
          INITCAP(TRIM(SPLIT_PART(customer_name, ',', 2))) || ' ' || INITCAP(SPLIT_PART(customer_name, ',', 1)) AS customer_name,
          REPLACE(REPLACE(REPLACE(REPLACE(INITCAP(loyalty_tier), 'Sliver', 'Silver'), 'Bronz', 'Bronze'), 'Goald', 'Gold'), 'Bronzee', 'Bronze') AS loyalty_tier
   FROM year2024.wk_10_loyalty)
SELECT *,
       CASE
           WHEN loyalty_tier = 'Bronze' THEN 5
           WHEN loyalty_tier = 'Silver' THEN 10
           WHEN loyalty_tier = 'Gold' THEN 15
       END AS loyalty_discount
FROM tmp;


SELECT *
FROM loyalty;

-- joining all tables
-- adding sales_after_discount column
-- calculate profit
WITH tmp AS
  (SELECT j.*,
          l.customer_name,
          l.loyalty_tier,
          (l.loyalty_discount::DECIMAL/100)::REAL AS loyalty_discount,
          (j.sales_before_discount * (1-(l.loyalty_discount::DECIMAL/100)))::REAL AS sales_after_discount
   FROM joined_transactions_products j
   LEFT JOIN loyalty l ON j.loyalty_number = l.loyalty_number)
SELECT transaction_date,
       transaction_number,
       product_type,
       product_scent,
       product_size,
       cash_or_card,
       loyalty_number,
       customer_name,
       loyalty_tier,
       loyalty_discount,
       quantity,
       sales_before_discount,
       sales_after_discount,
       sales_after_discount - (unit_cost * quantity) AS profit
FROM tmp;

