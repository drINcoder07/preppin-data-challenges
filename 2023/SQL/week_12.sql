SELECT * FROM year2023.wk_12_new_customers;
SELECT * FROM year2023.wk_12_roi_new_customers;
SELECT * FROM year2023.wk_12_uk_bank_holidays;

ALTER TABLE year2023.wk_12_uk_bank_holidays
ADD key_column SERIAL;


-- filling down values for year in uk_bank_holidays table and deleting null rows
CREATE TEMPORARY VIEW uk_bank_holidays AS
WITH tmp AS
(SELECT 
COALESCE(year, 0) AS year,
date,
bank_holiday, key_column
FROM year2023.wk_12_uk_bank_holidays)
, tmp_2 AS
(SELECT year, SUM(CASE WHEN year IS NOT NULL THEN year ELSE 0 END) OVER(ORDER BY key_column ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS year_partition,
date, bank_holiday
FROM tmp
)
, tmp_3 AS
(SELECT
SUM(year) OVER (PARTITION BY year_partition ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS year,
date,
bank_holiday 
FROM tmp_2)
SELECT
year,
(date || '-' || year)::DATE as date,
bank_holiday
FROM tmp_3
WHERE date IS NOT NULL;
