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

CREATE TABLE year2023.wk_4_January (id VARCHAR(6),
                                       joining_day INTEGER, demographic VARCHAR(30),
                                                                        value VARCHAR(20));


CREATE TABLE year2023.wk_4_February (id VARCHAR(6),
                                        joining_day INTEGER, demographic VARCHAR(30),
                                                                         value VARCHAR(20));


CREATE TABLE year2023.wk_4_March (id VARCHAR(6),
                                     joining_day INTEGER, demographic VARCHAR(30),
                                                                      value VARCHAR(20));


CREATE TABLE year2023.wk_4_April (id VARCHAR(6),
                                     joining_day INTEGER, demographic VARCHAR(30),
                                                                      value VARCHAR(20));


CREATE TABLE year2023.wk_4_May (id VARCHAR(6),
                                   joining_day INTEGER, demographic VARCHAR(30),
                                                                    value VARCHAR(20));


CREATE TABLE year2023.wk_4_June (id VARCHAR(6),
                                    joining_day INTEGER, demographic VARCHAR(30),
                                                                     value VARCHAR(20));


CREATE TABLE year2023.wk_4_July (id VARCHAR(6),
                                    joining_day INTEGER, demographic VARCHAR(30),
                                                                     value VARCHAR(20));


CREATE TABLE year2023.wk_4_August (id VARCHAR(6),
                                      joining_day INTEGER, demographic VARCHAR(30),
                                                                       value VARCHAR(20));


CREATE TABLE year2023.wk_4_September (id VARCHAR(6),
                                         joining_day INTEGER, demographic VARCHAR(30),
                                                                          value VARCHAR(20));


CREATE TABLE year2023.wk_4_October (id VARCHAR(6),
                                       joining_day INTEGER, demographic VARCHAR(30),
                                                                        value VARCHAR(20));


CREATE TABLE year2023.wk_4_November (id VARCHAR(6),
                                        joining_day INTEGER, demographic VARCHAR(30),
                                                                         value VARCHAR(20));


CREATE TABLE year2023.wk_4_December (id VARCHAR(6),
                                        joining_day INTEGER, demographic VARCHAR(30),
                                                                         value VARCHAR(20));


CREATE TABLE year2023.wk_6_customer_ratings (customer_id VARCHAR(10),
                                                         mobile_app_ease_of_use INTEGER, mobile_app_ease_of_access INTEGER, mobile_app_navigation INTEGER, mobile_app_likelihood_to_recommend INTEGER, mobile_app_overall_rating INTEGER, online_interface_ease_of_use INTEGER, online_interface_ease_of_access INTEGER, online_interface_navigation INTEGER, online_interface_likelihood_to_recommend INTEGER, online_interface_overall_rating INTEGER);

-- \copy year2023.wk_4_January (id, joining_day, demographic, value) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\New Customers January.csv' DELIMITER ',' CSV HEADER;
-- \copy year2023.wk_4_February (id, joining_day, demographic, value) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\New Customers February.csv' DELIMITER ',' CSV HEADER;
-- \copy year2023.wk_4_March (id, joining_day, demographic, value) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\New Customers March.csv' DELIMITER ',' CSV HEADER;
-- \copy year2023.wk_4_April (id, joining_day, demographic, value) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\New Customers April.csv' DELIMITER ',' CSV HEADER;
-- \copy year2023.wk_4_May (id, joining_day, demographic, value) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\New Customers May.csv' DELIMITER ',' CSV HEADER;
-- \copy year2023.wk_4_June (id, joining_day, demographic, value) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\New Customers June.csv' DELIMITER ',' CSV HEADER;
-- \copy year2023.wk_4_July (id, joining_day, demographic, value) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\New Customers July.csv' DELIMITER ',' CSV HEADER;
-- \copy year2023.wk_4_August (id, joining_day, demographic, value) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\New Customers August.csv' DELIMITER ',' CSV HEADER;
-- \copy year2023.wk_4_September (id, joining_day, demographic, value) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\New Customers September.csv' DELIMITER ',' CSV HEADER;
-- \copy year2023.wk_4_October (id, joining_day, demographic, value) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\New Customers October.csv' DELIMITER ',' CSV HEADER;
-- \copy year2023.wk_4_November (id, joining_day, demographic, value) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\New Customers November.csv' DELIMITER ',' CSV HEADER;
-- \copy year2023.wk_4_December (id, joining_day, demographic, value) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\New Customers December.csv' DELIMITER ',' CSV HEADER;
-- \copy year2023.wk_6_customer_ratings (customer_id, mobile_app_ease_of_use, mobile_app_ease_of_access,mobile_app_navigation,mobile_app_likelihood_to_recommend,mobile_app_overall_rating,online_interface_ease_of_use, online_interface_ease_of_access,online_interface_navigation,online_interface_likelihood_to_recommend,online_interface_overall_rating) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\DSB Customer Survery.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE year2023.wk_7_transaction_path (transaction_id VARCHAR(15),
                                                            account_to VARCHAR(15),
                                                                       account_from VARCHAR(15));

-- \copy year2023.wk_7_transaction_path (transaction_id,account_to, account_from) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\Transaction Path.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE year2023.wk_7_transaction_detail (transaction_id VARCHAR(15),
                                                              transaction_date DATE, value DECIMAL, cancelled_or_not VARCHAR(1));

-- \copy year2023.wk_7_transaction_detail (transaction_id,transaction_date,value, cancelled_or_not) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\Transaction Detail.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE year2023.wk_7_account_information (account_number VARCHAR(15),
                                                               account_type VARCHAR(15),
                                                                            account_holder_id VARCHAR(40),
                                                                                              balance_date DATE, balance DECIMAL);

-- \copy year2023.wk_7_account_information (account_number,account_type, account_holder_id, balance_date, balance) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\Account Information.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE year2023.wk_7_account_holders (account_holder_id VARCHAR(15),
                                                              name VARCHAR(50),
                                                                   date_of_birth DATE, contact_number VARCHAR(20),
                                                                                                      first_line_of_address VARCHAR(50));

-- \copy year2023.wk_7_account_holders (account_holder_id, name,date_of_birth,contact_number,first_line_of_address) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\Account Holders.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE year2023.wk_8_january (id VARCHAR(10),
                                       first_name VARCHAR(20),
                                                  last_name VARCHAR(20),
                                                            ticker VARCHAR(10),
                                                                   sector VARCHAR(30),
                                                                          market VARCHAR(10),
                                                                                 stock_name VARCHAR(100),
                                                                                            market_cap VARCHAR(15),
                                                                                                       purchase_price VARCHAR(10));


CREATE TABLE year2023.wk_8_february (id VARCHAR(10),
                                        first_name VARCHAR(20),
                                                   last_name VARCHAR(20),
                                                             ticker VARCHAR(10),
                                                                    sector VARCHAR(30),
                                                                           market VARCHAR(10),
                                                                                  stock_name VARCHAR(100),
                                                                                             market_cap VARCHAR(15),
                                                                                                        purchase_price VARCHAR(10));


CREATE TABLE year2023.wk_8_march (id VARCHAR(10),
                                     first_name VARCHAR(20),
                                                last_name VARCHAR(20),
                                                          ticker VARCHAR(10),
                                                                 sector VARCHAR(30),
                                                                        market VARCHAR(10),
                                                                               stock_name VARCHAR(100),
                                                                                          market_cap VARCHAR(15),
                                                                                                     purchase_price VARCHAR(10));


CREATE TABLE year2023.wk_8_april (id VARCHAR(10),
                                     first_name VARCHAR(20),
                                                last_name VARCHAR(20),
                                                          ticker VARCHAR(10),
                                                                 sector VARCHAR(30),
                                                                        market VARCHAR(10),
                                                                               stock_name VARCHAR(100),
                                                                                          market_cap VARCHAR(15),
                                                                                                     purchase_price VARCHAR(10));


CREATE TABLE year2023.wk_8_may (id VARCHAR(10),
                                   first_name VARCHAR(20),
                                              last_name VARCHAR(20),
                                                        ticker VARCHAR(10),
                                                               sector VARCHAR(30),
                                                                      market VARCHAR(10),
                                                                             stock_name VARCHAR(100),
                                                                                        market_cap VARCHAR(15),
                                                                                                   purchase_price VARCHAR(10));


CREATE TABLE year2023.wk_8_june (id VARCHAR(10),
                                    first_name VARCHAR(20),
                                               last_name VARCHAR(20),
                                                         ticker VARCHAR(10),
                                                                sector VARCHAR(30),
                                                                       market VARCHAR(10),
                                                                              stock_name VARCHAR(100),
                                                                                         market_cap VARCHAR(15),
                                                                                                    purchase_price VARCHAR(10));


CREATE TABLE year2023.wk_8_july (id VARCHAR(10),
                                    first_name VARCHAR(20),
                                               last_name VARCHAR(20),
                                                         ticker VARCHAR(10),
                                                                sector VARCHAR(30),
                                                                       market VARCHAR(10),
                                                                              stock_name VARCHAR(100),
                                                                                         market_cap VARCHAR(15),
                                                                                                    purchase_price VARCHAR(10));


CREATE TABLE year2023.wk_8_august (id VARCHAR(10),
                                      first_name VARCHAR(20),
                                                 last_name VARCHAR(20),
                                                           ticker VARCHAR(10),
                                                                  sector VARCHAR(30),
                                                                         market VARCHAR(10),
                                                                                stock_name VARCHAR(100),
                                                                                           market_cap VARCHAR(15),
                                                                                                      purchase_price VARCHAR(10));


CREATE TABLE year2023.wk_8_september(id VARCHAR(10),
                                        first_name VARCHAR(20),
                                                   last_name VARCHAR(20),
                                                             ticker VARCHAR(10),
                                                                    sector VARCHAR(30),
                                                                           market VARCHAR(10),
                                                                                  stock_name VARCHAR(100),
                                                                                             market_cap VARCHAR(15),
                                                                                                        purchase_price VARCHAR(10));


CREATE TABLE year2023.wk_8_october (id VARCHAR(10),
                                       first_name VARCHAR(20),
                                                  last_name VARCHAR(20),
                                                            ticker VARCHAR(10),
                                                                   sector VARCHAR(30),
                                                                          market VARCHAR(10),
                                                                                 stock_name VARCHAR(100),
                                                                                            market_cap VARCHAR(15),
                                                                                                       purchase_price VARCHAR(10));


CREATE TABLE year2023.wk_8_november (id VARCHAR(10),
                                        first_name VARCHAR(20),
                                                   last_name VARCHAR(20),
                                                             ticker VARCHAR(10),
                                                                    sector VARCHAR(30),
                                                                           market VARCHAR(10),
                                                                                  stock_name VARCHAR(100),
                                                                                             market_cap VARCHAR(15),
                                                                                                        purchase_price VARCHAR(10));


CREATE TABLE year2023.wk_8_december (id VARCHAR(10),
                                        first_name VARCHAR(20),
                                                   last_name VARCHAR(20),
                                                             ticker VARCHAR(10),
                                                                    sector VARCHAR(30),
                                                                           market VARCHAR(10),
                                                                                  stock_name VARCHAR(100),
                                                                                             market_cap VARCHAR(15),
                                                                                                        purchase_price VARCHAR(10));

-- \copy year2023.wk_8_january  (id, first_name, last_name, ticker, sector, market, stock_name, market_cap, purchase_price) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\MOCK_DATA.csv' DELIMITER ',' CSV HEADER;
-- \copy year2023.wk_8_february (id, first_name, last_name, ticker, sector, market, stock_name, market_cap, purchase_price) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\MOCK_DATA-2.csv' DELIMITER ',' CSV HEADER;
-- \copy year2023.wk_8_march    (id, first_name, last_name, ticker, sector, market, stock_name, market_cap, purchase_price) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\MOCK_DATA-3.csv' DELIMITER ',' CSV HEADER;
-- \copy year2023.wk_8_april    (id, first_name, last_name, ticker, sector, market, stock_name, market_cap, purchase_price) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\MOCK_DATA-4.csv' DELIMITER ',' CSV HEADER;
-- \copy year2023.wk_8_may      (id, first_name, last_name, ticker, sector, market, stock_name, market_cap, purchase_price) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\MOCK_DATA-5.csv' DELIMITER ',' CSV HEADER;
-- \copy year2023.wk_8_june     (id, first_name, last_name, ticker, sector, market, stock_name, market_cap, purchase_price) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\MOCK_DATA-6.csv' DELIMITER ',' CSV HEADER;
-- \copy year2023.wk_8_july     (id, first_name, last_name, ticker, sector, market, stock_name, market_cap, purchase_price) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\MOCK_DATA-7.csv' DELIMITER ',' CSV HEADER;
-- \copy year2023.wk_8_august   (id, first_name, last_name, ticker, sector, market, stock_name, market_cap, purchase_price) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\MOCK_DATA-8.csv' DELIMITER ',' CSV HEADER;
-- \copy year2023.wk_8_september(id, first_name, last_name, ticker, sector, market, stock_name, market_cap, purchase_price) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\MOCK_DATA-9.csv' DELIMITER ',' CSV HEADER;
-- \copy year2023.wk_8_october  (id, first_name, last_name, ticker, sector, market, stock_name, market_cap, purchase_price) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\MOCK_DATA-10.csv' DELIMITER ',' CSV HEADER;
-- \copy year2023.wk_8_november (id, first_name, last_name, ticker, sector, market, stock_name, market_cap, purchase_price) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\MOCK_DATA-11.csv' DELIMITER ',' CSV HEADER;
-- \copy year2023.wk_8_december (id, first_name, last_name, ticker, sector, market, stock_name, market_cap, purchase_price) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2023\Raw Files\MOCK_DATA-12.csv' DELIMITER ',' CSV HEADER;