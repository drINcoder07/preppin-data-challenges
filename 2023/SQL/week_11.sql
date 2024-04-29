-- 2023: Week 11 - Which customers are closest?

CREATE
TEMPORARY VIEW merged_locations AS
SELECT *
FROM year2023.wk_11_customer_locations,
     LATERAL
      (SELECT *
       FROM year2023.wk_11_branch_locations);

-- SOLVING THE CHALLENGE
 WITH converted_to_radians AS
      (SELECT *,
              address_long/(180/PI()) long1,
              branch_long/(180/PI()) long2,
              address_lat/(180/PI()) lat1,
              branch_lat/(180/PI()) lat2
       FROM merged_locations),
      with_distance AS
      (SELECT customer,
              address_long,
              address_lat,
              branch,
              branch_long,
              branch_lat,
              ROUND((3963 * acos((sin(lat1) * sin(lat2)) + cos(lat1) * cos(lat2) * cos(long2 - long1)))::NUMERIC, 2) AS distance
       FROM converted_to_radians),
      top_near_location_per_customer AS
      (SELECT *,
              RANK() OVER(PARTITION BY customer
                          ORDER BY distance) AS ranking
       FROM with_distance
       ORDER BY customer,
                ranking)
SELECT branch,
       branch_long,
       branch_lat,
       distance,
       RANK() OVER(PARTITION BY branch
                   ORDER BY distance) AS customer_priority,
       customer,
       address_long,
       address_lat
FROM top_near_location_per_customer
WHERE ranking = 1
ORDER BY branch;

