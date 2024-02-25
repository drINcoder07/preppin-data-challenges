SELECT *
FROM year2023.wk_3_targets;

-- TASKS
-- For the transactions file:
-- Filter the transactions to just look at DSB (help)
-- These will be transactions that contain DSB in the Transaction Code field
-- Rename the values in the Online or In-person field, Online of the 1 values and In-Person for the 2 values
-- Change the date to be the quarter (help)
-- Sum the transaction values for each quarter and for each Type of Transaction (Online or In-Person) (help)
-- For the targets file:
-- Pivot the quarterly targets so we have a row for each Type of Transaction and each Quarter (help)
--  Rename the fields
-- Remove the 'Q' from the quarter field and make the data type numeric (help)
-- Join the two datasets together (help)
-- You may need more than one join clause!
-- Remove unnecessary fields
-- Calculate the Variance to Target for each row (help)
-- Output the data
 WITH actual_values AS
  (SELECT CASE
              WHEN online_or_in_person = 1 THEN 'Online'
              ELSE 'In-Person'
          END AS online_or_in_person,
          EXTRACT(QUARTER
                  FROM transaction_date) AS quarter,
          SUM(value) as value
   FROM year2023.wk_1
   WHERE SPLIT_PART(transaction_code, '-', 1) = 'DSB'
   GROUP BY 1,
            2),
      target_values AS
  (SELECT t.online_or_in_person,
          u.i AS quarter,
          u.targets
   FROM year2023.wk_3_targets t
   CROSS JOIN LATERAL UNNEST(ARRAY[q1, q2, q3, q4]) WITH
   ORDINALITY AS u(targets, i))
SELECT a.online_or_in_person,
       a.quarter,
       a.value,
       t.targets,
       a.value - t.targets AS variance_to_target
FROM actual_values a
JOIN target_values t ON a.online_or_in_person = t.online_or_in_person
AND a.quarter = t.quarter;

