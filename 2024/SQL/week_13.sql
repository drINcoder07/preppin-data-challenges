SELECT * 
FROM year2024.wk_13_2020;

CREATE TEMPORARY TABLE appended_sales_data AS
SELECT * FROM year2024.wk_13_2020
UNION ALL
SELECT * FROM year2024.wk_13_2021
UNION ALL
SELECT * FROM year2024.wk_13_2022
UNION ALL
SELECT * FROM year2024.wk_13_2023
UNION ALL
SELECT * FROM year2024.wk_13_2024;


WITH tmp AS
(SELECT sales_date,
EXTRACT(DOW FROM sales_date) as weekday,
TRIM(TO_CHAR(sales_date, 'Day')) AS day,
DATE_PART('week', sales_date) AS orig_weeknum,
product,
price,
quantity_sold
FROM appended_sales_data)
, tmp_2 AS
(select DISTINCT sales_date
FROM tmp
WHERE day = 'Monday')
, tmp_3 AS
(SELECT sales_date, ROW_NUMBER() OVER(ORDER BY sales_date) AS week_num
FROM tmp_2)
, tmp_4 AS
(SELECT tmp.*, tmp_3.week_num
FROM tmp
LEFT JOIN tmp_3 ON tmp.sales_date = tmp_3.sales_date)
SELECT 
EXTRACT(YEAR FROM sales_date) AS year,
sales_date,
(SUM(week_num) OVER(PARTITION BY orig_weeknum ORDER BY sales_date) / count(week_num) OVER(PARTITION BY orig_weeknum ORDER BY sales_date))::INT AS easter_weeknumber,
CASE
    WHEN day = 'Monday' THEN 'M'
    WHEN day = 'Tuesday' THEN 'Tu'
    WHEN day = 'Wednesday' THEN 'W'
    WHEN day = 'Thursday' THEN 'Th'
    WHEN day = 'Friday' THEN 'F'
    WHEN day = 'Saturday' THEN 'Sa'
    ELSE 'Su' END AS weekday,
CASE WHEN day = 'Sunday' THEN 7 ELSE weekday END AS weekday_order,
product,
price,
quantity_sold,
(price * quantity_sold) AS sales
FROM tmp_4
ORDER BY 1, 2;