CREATE SCHEMA year2024
CREATE TABLE wk_1 (flight_details VARCHAR(100),
																				flow_card SMALLINT, bags_checked SMALLINT, meal_type VARCHAR(50));


CREATE TABLE year2024.wk_2_flow_card (dates Date, flight_number VARCHAR(10),
																																							from_location VARCHAR(20),
																																							to_location VARCHAR(20),
																																							class VARCHAR(20),
																																							price DECIMAL, flow_card VARCHAR(5),
																																							bags_checked SMALLINT, meal_type VARCHAR(20));


CREATE TABLE year2024.wk_2_non_flow_card (dates Date, flight_number VARCHAR(10),
																																											from_location VARCHAR(20),
																																											to_location VARCHAR(20),
																																											class VARCHAR(20),
																																											price DECIMAL, flow_card VARCHAR(5),
																																											bags_checked SMALLINT, meal_type VARCHAR(20));

-- Inserting csv file to table:
-- \copy year2024.wk_1(flight_details, flow_card, bags_checked, meal_type) FROM 'C:<file location>\PD 2024 Wk 1 Input.csv' DELIMITER ',' CSV HEADER;
-- \copy year2024.wk_2_flow_card(dates, flight_number, from_location, to_location, class, price, flow_card, bags_checked, meal_type) FROM 'C:\<file location>\preppin-data-solutions\preppin-data-challenges\2024\Raw Files\PD 2024 Wk 1 Output Flow Card.csv' DELIMITER ',' CSV HEADER;
-- \copy year2024.wk_2_non_flow_card(dates, flight_number, from_location, to_location, class, price, flow_card, bags_checked, meal_type) FROM 'C:\<file location>\preppin-data-solutions\preppin-data-challenges\2024\Raw Files\PD 2024 Wk 1 Output Non-Flow Card.csv' DELIMITER ',' CSV HEADER;
--
-- WEEK 3

CREATE TABLE year2024.wk_3_q1 (month INTEGER, class VARCHAR(3),
																																target INTEGER);


CREATE TABLE year2024.wk_3_q2 (month INTEGER, class VARCHAR(3),
																																target INTEGER);


CREATE TABLE year2024.wk_3_q3 (month INTEGER, class VARCHAR(3),
																																target INTEGER);


CREATE TABLE year2024.wk_3_q4 (month INTEGER, class VARCHAR(3),
																																target INTEGER);

-- \copy year2024.wk_3_q1(month, class, target) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2024\Raw Files\PD 2024 Wk 3 Input Q1.csv' DELIMITER ',' CSV HEADER;
-- \copy year2024.wk_3_q2(month, class, target) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2024\Raw Files\PD 2024 Wk 3 Input Q2.csv' DELIMITER ',' CSV HEADER;
-- \copy year2024.wk_3_q3(month, class, target) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2024\Raw Files\PD 2024 Wk 3 Input Q3.csv' DELIMITER ',' CSV HEADER;
-- \copy year2024.wk_3_q4(month, class, target) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2024\Raw Files\PD 2024 Wk 3 Input Q4.csv' DELIMITER ',' CSV HEADER;
--
-- WEEK 4

CREATE TABLE year2024.wk_4_flow_card(customer_ID SMALLINT, seat SMALLINT, row SMALLINT, class VARCHAR(2));


CREATE TABLE year2024.wk_4_non_flow_card(customer_ID SMALLINT, seat SMALLINT, row SMALLINT, class VARCHAR(2));


CREATE TABLE year2024.wk_4_non_flow_card_2(customer_ID SMALLINT, seat SMALLINT, row SMALLINT, class VARCHAR(2));


CREATE TABLE year2024.wk_4_seat_plan(class VARCHAR(2),
																																						seat SMALLINT, row SMALLINT);

-- \copy year2024.wk_4_flow_card(customer_ID, seat, row, class) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2024\Raw Files\PD 2024 Wk 4 Input Flow Card.csv' DELIMITER ',' CSV HEADER;
-- \copy year2024.wk_4_non_flow_card(customer_ID, seat, row, class) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2024\Raw Files\PD 2024 Wk 4 Input Non-Flow Card.csv' DELIMITER ',' CSV HEADER;
-- \copy year2024.wk_4_non_flow_card_2(customer_ID, seat, row, class) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2024\Raw Files\PD 2024 Wk 4 Input Non-Flow Card 2.csv' DELIMITER ',' CSV HEADER;
-- \copy year2024.wk_4_seat_plan(class, seat, row) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2024\Raw Files\PD 2024 Wk 4 Input Seat Plan.csv' DELIMITER ',' CSV HEADER;
 -- WEEK 5

CREATE TABLE year2024.wk_5_flights (date DATE, flight_number VARCHAR(5),
																																					from_location VARCHAR(15),
																																					to_location VARCHAR(15));


CREATE TABLE year2024.wk_5_ticket_sales (date DATE, flight_number VARCHAR(5),
																																										customer_id VARCHAR(30),
																																										ticket_price DECIMAL);


CREATE TABLE year2024.wk_5_customers (customer_id VARCHAR(30),
																																							last_date_flown DATE, first_name VARCHAR(20),
																																							last_name VARCHAR(20),
																																							email VARCHAR(50),
																																							gender VARCHAR(20));

-- \copy year2024.wk_5_flights(date, flight_number, from_location, to_location) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2024\Raw Files\Prep Air 2024 Flights.csv' DELIMITER ',' CSV HEADER;
-- \copy year2024.wk_5_ticket_sales(date, flight_number, customer_id, ticket_price) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2024\Raw Files\Prep Air Ticket Sales.csv' DELIMITER ',' CSV HEADER;
-- \copy year2024.wk_5_customers(customer_id, last_date_flown, first_name, last_name, email, gender) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2024\Raw Files\Prep Air Customers.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE year2024.wk_6_salaries (staff_id VARCHAR(10),
																																						month_1 DECIMAL, month_2 DECIMAL, month_3 DECIMAL, month_4 DECIMAL, month_5 DECIMAL, month_6 DECIMAL, month_7 DECIMAL, month_8 DECIMAL, month_9 DECIMAL, month_10 DECIMAL, month_11 DECIMAL, month_12 DECIMAL);

-- \copy year2024.wk_6_salaries(staff_id, month_1,month_2,month_3,month_4,month_5,month_6,month_7,month_8,month_9,month_10,month_11,month_12 ) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2024\Raw Files\PD 2024 Wk 6 Input.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE year2024.wk_7_couples (couple VARCHAR(30),
																																					relationship_start date);

-- \copy year2024.wk_7_couples(couple, relationship_start) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2024\Raw Files\Valentine PD - Couples.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE year2024.wk_7_gifts (year VARCHAR(5),
																																			gift VARCHAR(20));

-- \copy year2024.wk_7_gifts(year, gift) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2024\Raw Files\Valentine PD - Gifts.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE year2024.wk_8_updated_customers (customer_id VARCHAR(30),
																																															first_name VARCHAR(20),
																																															last_name VARCHAR(20),
																																															email VARCHAR(50),
																																															gender VARCHAR(20),
																																															first_flight DATE, last_date_flown DATE, number_of_flights INTEGER);

-- \copy year2024.wk_8_updated_customers(customer_id,  first_name, last_name, email, gender, first_flight, last_date_flown, number_of_flights) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2024\Raw Files\Prep Air Updated Customers.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE year2024.wk_8_costings (benefit VARCHAR(50),
																																						cost VARCHAR(20));

-- \copy year2024.wk_8_costings(benefit, cost) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2024\Raw Files\Prep Air Costings.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE year2024.wk_8_loyalty_schemes (tier_grouping INTEGER, number_of_flights VARCHAR(10),
																																													tier VARCHAR(10),
																																													benefits VARCHAR(100));

-- \copy year2024.wk_8_loyalty_schemes(tier_grouping, number_of_flights, tier, benefits) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2024\Raw Files\Prep Air Loyalty Schemes.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE year2024.wk_9_customer_actions (flight_number VARCHAR(10),
																																														flight_date DATE, customer_ID VARCHAR(20),
																																														action VARCHAR(15), date DATE, class VARCHAR(15),
																																														row INTEGER, seat INTEGER);

-- \copy year2024.wk_9_customer_actions(flight_number, flight_date, customer_ID, action, date, class, row, seat) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2024\Raw Files\PD 2024 Week 9 Input.xlsx - Customer Actions.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE year2024.wk_9_flight_details (flight_number VARCHAR(10),
																																												flight_date DATE, class VARCHAR(15),
																																												capacity INTEGER);

-- \copy year2024.wk_9_flight_details (flight_number, flight_date, class, capacity) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2024\Raw Files\PD 2024 Week 9 Input.xlsx - Flight Details.csv' DELIMITER ',' CSV HEADER;

CREATE TABLE year2024.wk_10_transactions (transaction_date DATE, transaction_number VARCHAR(15),
																																											product_id VARCHAR(30),
																																											cash_or_card INTEGER, loyalty_number VARCHAR(10),
																																											sales_before_discount DECIMAL); -- \copy year2024.wk_10_transactions(transaction_date, transaction_number, product_id, cash_or_card, loyalty_number, sales_before_discount) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2024\Raw Files\2024W10 Input.xlsx - Transaction Data.csv' DELIMITER ',' CSV HEADER;


CREATE TABLE year2024.wk_10_loyalty (loyalty_number VARCHAR(10),
																																						customer_name VARCHAR(50),
																																						loyalty_tier VARCHAR(15),
																																						loyalty_discount VARCHAR(5)); -- \copy year2024.wk_10_loyalty(loyalty_number, customer_name, loyalty_tier, loyalty_discount) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2024\Raw Files\2024W10 Input.xlsx - Loyalty Table.csv' DELIMITER ',' CSV HEADER;


CREATE TABLE year2024.wk_10_product (product_type VARCHAR(10),
																																						product_scent VARCHAR(20),
																																						pack_size VARCHAR(5),
																																						product_size VARCHAR(5),
																																						unit_cost DECIMAL, selling_price DECIMAL); -- \copy year2024.wk_10_product(product_type, product_scent, pack_size, product_size, unit_cost, selling_price) FROM 'C:\Users\drin\Desktop\PROJECTS\preppin-data-solutions\preppin-data-challenges\2024\Raw Files\2024W10 Input.xlsx - Product Table.csv' DELIMITER ',' CSV HEADER;
