-- DATA INSPECTION

SELECT *
FROM year2023.wk_1;

-- TASKS:
-- Split the Transaction Code to extract the letters at the start of the transaction code. These identify the bank who processes the transaction
-- Rename the new field with the Bank code 'Bank'.
-- Rename the values in the Online or In-person field, Online of the 1 values and In-Person for the 2 values.
-- Change the date to be the day of the week
-- Different levels of detail are required in the outputs. You will need to sum up the values of the transactions in three ways :
-- 1. Total Values of Transactions by each bank
-- 2. Total Values by Bank, Day of the Week and Type of Transaction (Online or In-Person)
-- 3. Total Values by Bank and Customer Code
-- Output each data file

CREATE
TEMPORARY VIEW wk_1_transformed AS
SELECT SPLIT_PART(transaction_code, '-', 1) AS bank,
       CASE
           WHEN online_or_in_person = 1 THEN 'online'
           ELSE 'in_person'
       END AS online_or_in_person,
       to_char(transaction_date, 'Day') AS transaction_date,
       customer_code,
       value
FROM year2023.wk_1;

-- 1. Total Values of Transactions by each bank

SELECT bank,
       SUM(value) AS value
FROM wk_1_transformed
GROUP BY bank;

-- 2. Total Values by Bank, Day of the Week and Type of Transaction (Online or In-Person)

SELECT bank,
       transaction_date,
       online_or_in_person,
       SUM(value) AS value
FROM wk_1_transformed
GROUP BY 1,
         2,
         3;

-- 3. Total Values by Bank and Customer Code

SELECT bank,
       customer_code,
       SUM(value) AS value
FROM wk_1_transformed
GROUP BY bank,
         customer_code;