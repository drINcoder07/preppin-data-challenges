-- DATA INSPECTION

SELECT *
FROM year2024.wk_7_couples;


SELECT *
FROM year2024.wk_7_gifts;

-- TASKS
-- Create a field for today's date (14/02/2024)
-- To count the number of Valentine's days, we need to think a little more creatively than using a simple datediff function to count the number of years. A couple of potential routes could be:
-- Scaffolding the data so there is a row per day, filtering to Valentine's days and counting the number of rows
-- A logical calculation that takes into consideration whether the Couple's Relationship Start date is before or after Valentines Day
-- To prepare to join onto the Gift ideas dataset, make the Year field match the data type of the Number of Valentine's field
-- Join the 2 datasets together
-- Remove unnecessary fields
-- Output the data
 WITH added_valentines_day_column AS 
  (SELECT *, 
          '2024-02-14'::DATE AS valentines_2024
   FROM year2024.wk_7_couples), 
      couples_with_number_of_valentines_celebrated AS 
  (SELECT couple, 
          relationship_start, 
          CASE 
              WHEN relationship_start < (EXTRACT(YEAR
                                                 FROM relationship_start) || '-02-14')::DATE THEN EXTRACT(YEAR
                                                                                                          FROM valentines_2024) - EXTRACT(YEAR
                                                                                                                                          FROM relationship_start) + 1 
              ELSE EXTRACT(YEAR
                           FROM valentines_2024) - EXTRACT(YEAR
                                                           FROM relationship_start) 
          END AS number_of_valentines_day_as_couple 
   FROM added_valentines_day_column), 
      removed_str_from_year_gifts_table AS 
  (SELECT REGEXP_REPLACE(year,'[[:alpha:]]','','g')::INTEGER as year,
          gift
   FROM year2024.wk_7_gifts)
SELECT c.couple,
       c.number_of_valentines_day_as_couple,
       r.gift
FROM couples_with_number_of_valentines_celebrated c
LEFT JOIN removed_str_from_year_gifts_table r ON c.number_of_valentines_day_as_couple = r.year
ORDER BY c.number_of_valentines_day_as_couple;

-- RESULTS match the same as the outputs!
 -- The Loves, 4, Fruit/Flowers
 -- The Archers, 5, Wood
 -- The Harts, 6, Iron
 -- The Darlings, 7, Copper/Wool
 -- The Potters, 9, Pottery
 -- The Lovelaces, 15, Crystal
 -- The Doves, 30, Pearl
 -- The Bakers, 35, Coral
 -- The Gardeners, 50, Gold
 -- The Roses, 60, Diamond
