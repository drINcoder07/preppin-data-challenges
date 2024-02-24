CREATE TABLE year2023.wk_1 (transaction_code VARCHAR(30),
                                             value INTEGER, customer_code VARCHAR(25),
                                                                          online_or_in_person SMALLINT, transaction_date DATE);

-- \copy year2023.wk_1(transaction_code, value, customer_code, online_or_in_person, transaction_date) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\PD 2023 Wk 1 Input.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE year2023.wk_2_transactions (transaction_id INTEGER, account_number INTEGER, sort_code VARCHAR(15),
                                                                                                   bank VARCHAR(30));


CREATE TABLE year2023.wk_2_swift_codes (bank VARCHAR(30),
                                             swift_code VARCHAR(4),
                                                        check_digits VARCHAR(2));

-- \copy year2023.wk_2_transactions(transaction_id, account_number, sort_code, bank ) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\Transactions.csv' DELIMITER ',' CSV HEADER;
-- \copy year2023.wk_2_swift_codes(bank, swift_code, check_digits) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\Swift Codes.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE year2023.wk_3_targets (online_or_in_person VARCHAR(20),
                                                        q1 INTEGER, q2 INTEGER, q3 INTEGER, q4 INTEGER);

-- \copy year2023.wk_3_targets(online_or_in_person, q1, q2, q3, q4) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\Targets.csv' DELIMITER ',' CSV HEADER;
