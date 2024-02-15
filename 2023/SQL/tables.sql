CREATE TABLE year2023.wk_1 (transaction_code VARCHAR(30),
                                             value INTEGER, customer_code VARCHAR(25),
                                                                          online_or_in_person SMALLINT, transaction_date DATE);

-- \copy year2023.wk_1(transaction_code, value, customer_code, online_or_in_person, transaction_date) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\PD 2023 Wk 1 Input.csv' DELIMITER ',' CSV HEADER;
