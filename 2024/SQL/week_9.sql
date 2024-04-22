SELECT *
FROM year2024.wk_9_customer_actions;

-- Filtering out the customer actions table and sorting out cancelled bookings

CREATE
TEMPORARY VIEW updated_customer_actions AS WITH ordered_actions AS
  (SELECT *,
          ROW_NUMBER() OVER (PARTITION BY customer_id,
                                          flight_number,
                                          flight_date
                             ORDER BY date DESC) AS action_sorted
   FROM year2024.wk_9_customer_actions)
SELECT flight_number,
       flight_date,
       class,
       customer_id,
       action, date, row,
                     seat
FROM ordered_actions
WHERE action_sorted = 1
  AND action != 'Cancelled'
ORDER BY flight_number,
         flight_date,
         class;

-- Joining the two tables for the final output
WITH joined_updated_customer_actions_and_flight_details AS
  (SELECT f.*,
          u.customer_id,
          u.action,
          u.date,
          u.row,
          u.seat,
          CASE
              WHEN u.customer_id IS NULL THEN 0
              ELSE 1
          END AS seat_booked
   FROM year2024.wk_9_flight_details f
   LEFT JOIN updated_customer_actions u ON f.flight_number = u.flight_number
   AND f.flight_date = u.flight_date
   AND f.class = u.class),
     with_running_total AS
  (SELECT *,
          SUM(seat_booked) OVER (PARTITION BY flight_number,
                                              flight_date,
                                              class
                                 ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS total_seats_booked_over_time
   FROM joined_updated_customer_actions_and_flight_details)
SELECT flight_number,
       flight_date,
       class,
       total_seats_booked_over_time,
       capacity,
       (total_seats_booked_over_time::DECIMAL / capacity)::REAL AS capacity_pct,
       customer_id,
       action, date, row,
                     seat
FROM with_running_total
ORDER BY flight_number,
         flight_date,
         class,
         total_seats_booked_over_time