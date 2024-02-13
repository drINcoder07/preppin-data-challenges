-- DATA INSPECTION

SELECT *
FROM year2024.wk_5_flights;


SELECT *
FROM year2024.wk_5_customers;


SELECT *
FROM year2024.wk_5_ticket_sales;

-- TASKS
-- For the first output:
-- Create a dataset that gives all the customer details for booked flights in 2024. Make sure the output also includes details on the flights origin and destination
-- When outputting the data, create an excel file with a new sheet for each output (so 1 file for all outputs this week!)
-- For the second output:
-- Create a dataset that allows Prep Air to identify which flights have not yet been booked in 2024
-- Add a datestamp field to this dataset for today's date (31/01/2024) so that Prep Air know the unbooked flights as of the day the workflow is run
-- When outputting the table to a new sheet in the Excel Workbook, choose the option "Append to Table" under Write Options. This means that if the workflow is run on a different day, the results will add additional rows to the dataset, rather than overwriting the previous run's data
-- For the third output:
-- Create a dataset that shows which customers have yet to book a flight with Prep Air in 2024
-- Create a field which will allow Prep Air to see how many days it has been since the customer last flew (compared to 31/01/2024)
-- Categorise customers into the following groups:
-- Recent fliers - flown within the last 3 months
-- Taking a break - 3-6 months since last flight
-- Been away a while - 6-9 months since last flight
-- Lapsed Customers - over 9 months since last flight
-- Output the data to a new sheet in the Excel Workbook
 -- FIRST OUTPUT

SELECT t.date,
       f.from_location,
       f.to_location,
       t.flight_number,
       t.customer_id,
       c.last_date_flown,
       c.first_name,
       c.last_name,
       c.email,
       c.gender,
       t.ticket_price
FROM year2024.wk_5_ticket_sales t
JOIN year2024.wk_5_customers c ON t.customer_id = c.customer_id
JOIN year2024.wk_5_flights f ON f.date = t.date
AND f.flight_number = t.flight_number;

-- SECOND OUTPUT
WITH CTE AS
  (SELECT f.date,
          f.flight_number,
          f.from_location,
          f.to_location,
          t.ticket_price
   FROM year2024.wk_5_flights f
   LEFT JOIN
     (SELECT DISTINCT date, flight_number,
                            ticket_price
      FROM year2024.wk_5_ticket_sales) t ON f.date = t.date
   AND f.flight_number = t.flight_number
   ORDER BY 1)
SELECT CURRENT_DATE AS flights_unbooked_as_of, date, from_location,
                                                     to_location
FROM CTE
WHERE ticket_price IS NULL;

-- THIRD OUTPUT
WITH customers_ticketsales_merged AS
  (SELECT c.customer_id,
          c.last_date_flown,
          c.first_name,
          c.last_name,
          c.email,
          c.gender,
          t.date,
          t.flight_number
   FROM year2024.wk_5_customers c
   LEFT JOIN year2024.wk_5_ticket_sales t ON c.customer_id = t.customer_id)
SELECT customer_id,
       CASE
           WHEN last_date_flown BETWEEN CURRENT_DATE - INTERVAL '3 MONTHS' AND CURRENT_DATE THEN 'Recent fliers - flown within the last 3 months'
           WHEN last_date_flown BETWEEN CURRENT_DATE - INTERVAL '6 MONTHS' AND CURRENT_DATE THEN 'Taking a break - 3-6 months since last flight'
           WHEN last_date_flown BETWEEN CURRENT_DATE - INTERVAL '9 MONTHS' AND CURRENT_DATE THEN 'Been away a while - 6-9 months since last flight'
           ELSE 'Lapsed Customers - over 9 months since last flight'
       END AS customer_category,
       CURRENT_DATE - last_date_flown AS days_since_last_flown,
                      last_date_flown,
                      first_name,
                      last_name,
                      email,
                      gender
FROM customers_ticketsales_merged
WHERE date IS NULL;