-- WEEK 1

-- Inspecting and Analyzing Data
SELECT * FROM year2024.wk_1;

-- ACTIVITIES:
-- Split flight details to columns,
-- convert Date column to date, Price column to Decimal
-- and creating a VIEW for extracting the two tables later (for Flow Card and non-Flow Card holders)

CREATE VIEW wk_1_prepped AS
SELECT 	
		-- splitting flight details to columns
		-- converting Date to date
	TO_DATE(SPLIT_PART(flight_details, '//',  1), 'YYYY-MM-DD') as "Date",
	SPLIT_PART(flight_details, '//',  2) as "Flight Number",
	SPLIT_PART(SPLIT_PART(flight_details, '//',  3), '-', 1) as "From",
	SPLIT_PART(SPLIT_PART(flight_details, '//',  3), '-', 2) as "To",
	SPLIT_PART(flight_details, '//',  4) as "Class",
		-- converting price to decimal value
	SPLIT_PART(flight_details, '//',  5)::DECIMAL as "Price",
	CASE WHEN flow_card = 1 THEN 'Yes' ELSE 'No' END AS "Flow Card",
		bags_checked AS "Bags Checked",
		meal_type AS "Meal Type"	
FROM year2024.wk_1;

-- Output for Flow Card holders
SELECT * FROM wk_1_prepped
WHERE "Flow Card" = 'Yes';
-- contains 1883 entries

-- Output for non-Flow Card holders
SELECT * FROM wk_1_prepped
WHERE "Flow Card" = 'No';
-- contains 1895 entries