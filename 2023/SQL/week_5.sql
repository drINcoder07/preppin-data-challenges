--2023 Week 5 DSB Ranking
-- Requirements
-- Input data
-- Create the bank code by splitting out off the letters from the Transaction code, call this field 'Bank'
-- Change transaction date to the just be the month of the transaction
-- Total up the transaction values so you have one row for each bank and month combination
-- Rank each bank for their value of transactions each month against the other banks. 1st is the highest value of transactions, 3rd the lowest.
-- Without losing all of the other data fields, find:
-- The average rank a bank has across all of the months, call this field 'Avg Rank per Bank'
-- The average transaction value per rank, call this field 'Avg Transaction Value per Rank'
-- Output the data

SELECT *
FROM year2023.wk_1;

WITH transactions_by_month_bank AS
  (SELECT TO_CHAR(transaction_date, 'Month') AS month,
          SPLIT_PART(transaction_code, '-', 1) AS bank,
          SUM(value) AS value
   FROM year2023.wk_1
   GROUP BY 1,
            2
   ORDER BY 1,
            3 DESC),
     transactions_ranked AS
  (SELECT *,
          RANK() OVER(PARTITION BY month
                      ORDER BY value DESC) as bank_rank_per_month
   FROM transactions_by_month_bank),
     avg_rank_per_bank_table AS
  (SELECT bank,
          AVG(bank_rank_per_month) AS avg_rank_per_bank
   FROM transactions_ranked
   GROUP BY 1),
     avg_transaction_value_per_rank_table AS
  (SELECT bank_rank_per_month,
          AVG(value) AS avg_transaction_value_per_rank
   FROM transactions_ranked
   GROUP BY 1)
SELECT t.*,
       v.avg_transaction_value_per_rank,
       b.avg_rank_per_bank
FROM transactions_ranked t
LEFT JOIN avg_rank_per_bank_table b ON t.bank = b.bank
LEFT JOIN avg_transaction_value_per_rank_table v ON t.bank_rank_per_month = v.bank_rank_per_month;