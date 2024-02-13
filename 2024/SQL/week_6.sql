-- DATA INSPECITON

SELECT *
FROM year2024.wk_6_salaries;

-- TASKS
-- Add a row number to the data set
-- Find the latest row (largest row number) to capture the individuals correct salary information
-- Find each team member's annual salary
-- Find each team member's maximum tax band based on their annual salary
-- 20% rate
-- 40% rate
-- 45% rate
-- Work out how much tax an individual paid for each of the % bands. Call these fields:
-- 20% tax rate paid
-- 40% tax rate paid
-- 45% tax rate paid
-- Total the tax paid across all three % bands. Call this field 'Total Tax Paid'

ALTER TABLE year2024.wk_6_salaries ADD COLUMN row_number serial; -- Add a row number to the data set


SELECT *
FROM year2024.wk_6_salaries
WHERE (staff_id,
       row_number) IN
    (SELECT staff_id,
            MAX(row_number)
     FROM year2024.wk_6_salaries
     GROUP BY staff_id);

-- UNPIVOTING THE data

CREATE VIEW unpivoted_data AS WITH adjusted_data AS
  (SELECT *
   FROM year2024.wk_6_salaries
   WHERE (staff_id,
          row_number) IN
       (SELECT staff_id,
               MAX(row_number) -- Find the latest row (largest row number) to capture the individuals correct salary information

        FROM year2024.wk_6_salaries
        GROUP BY staff_id))
SELECT s.staff_id,
       'month_'||t.i AS month,
       t.salary
FROM adjusted_data s
CROSS JOIN LATERAL UNNEST(ARRAY[month_1, month_2,month_3,month_4,month_5,month_6,month_7,month_8,month_9,month_10,month_11,month_12]) with
ORDINALITY as t(salary, i);


SELECT *
FROM unpivoted_data;

-- FINAL OUTPUT!!
WITH total_salaries AS
  (SELECT staff_id,
          SUM(salary) AS total_salary
   FROM unpivoted_data
   GROUP BY 1),
     total_salaries_categorized AS
  (SELECT staff_id,
          total_salary,
          CASE
              WHEN total_salary BETWEEN 12571 AND 50270 THEN '20% rate'
              WHEN total_salary BETWEEN 50271 AND 125140 THEN '40% rate'
              ELSE '45% rate'
          END AS max_tax_rate,
          CASE
              WHEN total_salary BETWEEN 12571 AND 50270 THEN 0.2*(total_salary-12570)
              WHEN total_salary < 12571 THEN 0
              ELSE (50270 - 12570)*0.2
          END AS rate_tax_paid_20_pct,
          CASE
              WHEN total_salary BETWEEN 50271 AND 125140 THEN 0.4*(total_salary-50270)
              WHEN total_salary < 50270 THEN 0
              ELSE (125140 - 50270)*.4
          END AS rate_tax_paid_40_pct,
          CASE
              WHEN total_salary > 125140 THEN 0.45*(total_salary-125140)
              ELSE 0
          END AS rate_tax_paid_45_pct
   FROM total_salaries)
SELECT staff_id,
       total_salary as salary,
       max_tax_rate,
       rate_tax_paid_20_pct + rate_tax_paid_40_pct + rate_tax_paid_45_pct AS total_tax_paid,
       rate_tax_paid_20_pct,
       rate_tax_paid_40_pct,
       rate_tax_paid_45_pct
FROM total_salaries_categorized;