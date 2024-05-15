-- 2024: Week 16 - Budget vs Actuals

-- Requirements
-- Input the Excel file
-- Match Sheet 1 and Sheet 2 in formatting. Both should include:
-- Category field [String]
-- Budget/Actual field [Number (Decimal)]
-- Join both sheets based on Category field to create a single table with 3 columns:
-- Category [String]
-- Budget [Number]
-- Actual [Number]
-- Rename the fields to:
-- Category
-- Forecasted Spending
-- Actual Spending
-- Create a new calculated column with the differences between forecasted and actual values.
-- Values in the new column should be rounded to whole numbers [ROUND(...)]
-- Output the data
SELECT * FROM year2024.wk_16_actual;

-- Cleaning data
WITH budget_data AS
(
    SELECT
        category,
        (CASE WHEN budget LIKE '%K' THEN REPLACE(budget, 'K', '000')
                ELSE REPLACE(budget, ',', '') END)::INT AS budget
    FROM year2024.wk_16_budget
    WHERE category IS NOT NULL
)
, actual_data AS
(
    SELECT 
        CASE
            WHEN category = 'TransactionFees' THEN 'Transaction Fees'
            ELSE category END AS category,
        REPLACE(actual, ',', '')::DECIMAL AS actual
    FROM year2024.wk_16_actual
)
SELECT b.category, b.budget AS forecasted_spending,
        a.actual AS actual_spending,
        ROUND(a.actual - b.budget) AS difference
FROM budget_data b
LEFT JOIN actual_data a
ON b.category = a.category;