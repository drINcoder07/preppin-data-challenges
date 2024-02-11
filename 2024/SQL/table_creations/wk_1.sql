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

CREATE TABLE year2024.q1 (month INTEGER, class VARCHAR(3),
																											target SMALLINT);


CREATE TABLE year2024.q2 (month INTEGER, class VARCHAR(3),
																											target SMALLINT);


CREATE TABLE year2024.q3 (month INTEGER, class VARCHAR(3),
																											target SMALLINT);


CREATE TABLE year2024.q4 (month INTEGER, class VARCHAR(3),
																											target SMALLINT);