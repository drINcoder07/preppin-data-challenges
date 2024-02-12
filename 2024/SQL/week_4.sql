-- DATA INSPECTION

SELECT *
FROM year2024.wk_4_flow_card;


SELECT *
FROM year2024.wk_4_non_flow_card;


SELECT *
FROM year2024.wk_4_non_flow_card_2;


SELECT *
FROM year2024.wk_4_seat_plan;

-- TASKS
-- Input the Excel workbook containing the four worksheets of data
-- Union the Flow Card and Non-Flow card data sets together
-- Create a data field to show whether the seat was booked by someone with the Flow Card or not
-- Call this field 'Flow Card?'
-- Aggregate the Seat Bookings to count how many bookings there are for:
-- Each Seat
-- In each Row
-- In each Class
-- For Flow and Non-Flow Card holders
-- Join on the Seating Plan data to ensure you have a data set for every seat on the plane, even if it hasn't been book
-- Only return the records for the seats that haven't been booked
-- Output the data set showing what seat, rows and class have NOT been booked
 -- Adding column "Flow Card?" before union to each of the tables except the seat plan

ALTER TABLE year2024.wk_4_flow_card ADD COLUMN flow_card VARCHAR(3);


UPDATE year2024.wk_4_flow_card
SET flow_card = 'Yes';


ALTER TABLE year2024.wk_4_non_flow_card ADD COLUMN flow_card VARCHAR(3);


UPDATE year2024.wk_4_non_flow_card
SET flow_card = 'No';


ALTER TABLE year2024.wk_4_non_flow_card_2 ADD COLUMN flow_card VARCHAR(3);


UPDATE year2024.wk_4_non_flow_card_2
SET flow_card = 'No';


CREATE VIEW year2024.wk_4_merged AS
SELECT *
FROM year2024.wk_4_flow_card
UNION ALL
SELECT *
FROM year2024.wk_4_non_flow_card
UNION ALL
SELECT *
FROM year2024.wk_4_non_flow_card_2;


SELECT *
from year2024.wk_4_merged;

-- How many bookings for:
-- each seat in each row in each class for flow card and non-flow card holders
-- FOR FLOW CARD HOLDERS;

SELECT class,
       row,
       seat,
       COUNT(*) AS bookings
FROM year2024.wk_4_merged
WHERE flow_card = 'Yes'
GROUP BY 1,
         2,
         3
ORDER BY 1,
         2,
         3;

-- FOR NON-FLOW CARD HOLDERS

SELECT class,
       row,
       seat,
       COUNT(*) AS bookings
FROM year2024.wk_4_merged
WHERE flow_card = 'No'
GROUP BY 1,
         2,
         3
ORDER BY 1,
         2,
         3;

-- OVERALL

CREATE
TEMPORARY VIEW seat_aggr AS
SELECT class,
       row,
       seat,
       COUNT(*) AS bookings
FROM year2024.wk_4_merged
GROUP BY 1,
         2,
         3
ORDER BY 1,
         2,
         3;


SELECT *
FROM seat_aggr;

-- FINDING UNBOOKED SEATS
WITH CTE AS
  (SELECT s.class,
          s.seat,
          s.row,
          a.bookings
   FROM year2024.wk_4_seat_plan s
   LEFT JOIN seat_aggr a ON s.class = a.class
   AND s.row = a.row
   AND s.seat = a.seat)
SELECT class,
       seat,
       row
FROM CTE
WHERE bookings IS NULL;

-- FINDINGS
-- CLASS E, SEAT 5, ROW 28
-- CLASS E, SEAT 6, ROW 32
-- CLASS E, SEAT 5, ROW 36
-- CLASS E, SEAT 6, ROW 37
-- CLASS E, SEAT 5, ROW 40
-- CLASS E, SEAT 6, ROW 40
-- CLASS E, SEAT 5, ROW 41