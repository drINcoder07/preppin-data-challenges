-- 2023: Week 9 : Customer Bank Statements
-- REQUIREMENTS:
-- Input the data
-- For the Transaction Path table:
-- Make sure field naming convention matches the other tables
-- i.e. instead of Account_From it should be Account From
-- Filter out the cancelled transactions
-- Split the flow into incoming and outgoing transactions
-- Bring the data together with the Balance as of 31st Jan
-- Work out the order that transactions occur for each account
-- Hint: where multiple transactions happen on the same day, assume the highest value transactions happen first
-- Use a running sum to calculate the Balance for each account on each day (hint)
-- The Transaction Value should be null for 31st Jan, as this is the starting balance
-- Output the data

SELECT *
FROM year2023.wk_7_account_information;


SELECT *
FROM year2023.wk_7_transaction_detail;


SELECT *
FROM year2023.wk_7_transaction_path;


CREATE
TEMPORARY VIEW account_information AS
SELECT account_number,
       balance_date,
       balance
FROM year2023.wk_7_account_information;


CREATE
TEMPORARY VIEW transaction_detail AS
SELECT *
FROM year2023.wk_7_transaction_detail
WHERE cancelled_or_not = 'N';


SELECT *
FROM transaction_detail;


SELECT *
FROM account_information;


CREATE
TEMPORARY VIEW incoming_transactions AS
SELECT p.account_to,
       d.transaction_date,
       d.value
FROM year2023.wk_7_transaction_path p
LEFT JOIN transaction_detail d ON p.transaction_id = d.transaction_id
LEFT JOIN account_information a ON p.account_to = a.account_number;


CREATE
TEMPORARY VIEW outgoing_transactions AS
SELECT p.account_from,
       d.transaction_date, -(d.value) AS value
FROM year2023.wk_7_transaction_path p
LEFT JOIN transaction_detail d ON p.transaction_id = d.transaction_id
LEFT JOIN account_information a ON p.account_from = a.account_number;


CREATE
TEMPORARY VIEW balance_transactions AS WITH combined_tables AS
  (SELECT *
   FROM account_information
   UNION ALL SELECT *
   FROM incoming_transactions
   UNION ALL SELECT *
   FROM outgoing_transactions
   ORDER BY account_number,
            balance_date),
               merged_values AS
  (SELECT a.account_number,
          a.balance_date,
          a.balance AS combined_values,
          ABS(a.balance) as abs_values,
          COALESCE(i.value, 0) + COALESCE(o.value, 0) AS transaction_value,
          ai.balance
   FROM combined_tables a
   LEFT JOIN account_information ai ON a.account_number = ai.account_number
   AND a.balance_date = ai.balance_date
   AND a.balance = ai.balance
   LEFT JOIN incoming_transactions i ON a.account_number = i.account_to
   AND a.balance_date = i.transaction_date
   AND a.balance = i.value
   LEFT JOIN outgoing_transactions o ON a.account_number = o.account_from
   AND a.balance_date = o.transaction_date
   AND a.balance = o.value)
SELECT account_number,
       balance_date,
       transaction_value,
       SUM(combined_values) OVER (PARTITION BY account_number
                                  ORDER BY balance_date,
                                           abs_values DESC) AS balance
FROM merged_values;

SELECT * FROM balance_transactions;

-- 2023: Week 10 - What's my balance on this day?
 -- AS OF FEBRUARY 1, 2023
WITH filtered_transactions AS 
  (SELECT account_number,
          balance_date, 
          transaction_value, 
          balance, 
          ROW_NUMBER() OVER(PARTITION BY account_number
                            ORDER BY balance_date DESC, ABS(balance)) AS ranking
   FROM balance_transactions 
   WHERE balance_date <= '2023-02-01')
SELECT account_number,
       transaction_value,
       balance
FROM filtered_transactions
WHERE ranking = 1;