-- Week 7: Flagging Fraudulent Suspicions
 -- Requirements
-- Input the data
-- For the Transaction Path table:
-- Make sure field naming convention matches the other tables
-- i.e. instead of Account_From it should be Account From
-- For the Account Information table:
-- Make sure there are no null values in the Account Holder ID
-- Ensure there is one row per Account Holder ID
-- Joint accounts will have 2 Account Holders, we want a row for each of them
-- For the Account Holders table:
-- Make sure the phone numbers start with 07
-- Bring the tables together
-- Filter out cancelled transactions
-- Filter to transactions greater than £1,000 in value
-- Filter out Platinum accounts
-- Output the data

SELECT *
FROM year2023.wk_7_account_holders;


SELECT *
FROM year2023.wk_7_account_information;


SELECT *
FROM year2023.wk_7_transaction_detail;


SELECT *
FROM year2023.wk_7_transaction_path;

-- CLEANING TABLES

CREATE
TEMPORARY TABLE account_holders AS
SELECT account_holder_id,
       name,
       date_of_birth,
       '0' || contact_number AS contact_number,
       first_line_of_address
FROM year2023.wk_7_account_holders;


CREATE
TEMPORARY TABLE account_information AS
SELECT account_number,
       account_type,
       TRIM(UNNEST(STRING_TO_ARRAY(account_holder_id, ','))) AS account_holder_id,
       balance_date,
       balance
FROM year2023.wk_7_account_information;


CREATE
TEMPORARY TABLE transaction_detail AS
SELECT *
FROM year2023.wk_7_transaction_detail
WHERE cancelled_or_not = 'N';

-- JOINING ALL TABLES

SELECT d.transaction_id,
       p.account_to,
       d.transaction_date,
       d.value,
       i.account_number,
       i.account_type,
       i.balance_date,
       i.balance,
       h.name,
       h.date_of_birth,
       h.contact_number,
       h.first_line_of_address
FROM transaction_detail d
LEFT JOIN year2023.wk_7_transaction_path p ON d.transaction_id = p.transaction_id
LEFT JOIN account_information i ON p.account_from = i.account_number
LEFT JOIN account_holders h ON i.account_holder_id = h.account_holder_id
WHERE d.value > 1000
  AND i.account_type <> 'Platinum';

