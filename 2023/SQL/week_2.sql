SELECT *
FROM year2023.wk_2_swift_codes;


SELECT *
FROM year2023.wk_2_transactions;

--TASKS
-- In the Transactions table, there is a Sort Code field which contains dashes. We need to remove these so just have a 6 digit string
-- Use the SWIFT Bank Code lookup table to bring in additional information about the SWIFT code and Check Digits of the receiving bank account
-- Add a field for the Country Code
-- Hint: all these transactions take place in the UK so the Country Code should be GB
-- Create the IBAN as above
-- Hint: watch out for trying to combine sting fields with numeric fields - check data types
-- Remove unnecessary fields
-- Output the data

SELECT t.transaction_id,
       'GB' ||s.check_digits|| s.swift_code || REPLACE(t.sort_code, '-', '') || t.account_number AS "IBAN"
FROM year2023.wk_2_transactions t
LEFT JOIN year2023.wk_2_swift_codes s ON t.bank = s.bank;

