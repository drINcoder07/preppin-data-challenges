CREATE SCHEMA year2024
CREATE TABLE wk_1 ( flight_details VARCHAR(100),
																				flow_card SMALLINT, bags_checked SMALLINT, meal_type VARCHAR(50));

-- Inserting csv file to table:
-- \copy year2024.wk_1(flight_details, flow_card, bags_checked, meal_type) FROM 'C:<file location>\PD 2024 Wk 1 Input.csv' DELIMITER ',' CSV HEADER;