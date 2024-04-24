SELECT *
FROM year2023.wk_6_customer_ratings;

-- EXAMPLE GUIDE FOR UNPIVOTING OTHER COLUMNS
 -- CREATE TEMP TABLE foo (id int, a text, b text, c text);
-- INSERT INTO foo VALUES (1, 'ant', 'cat', 'chimp'), (2, 'grape', 'mint', 'basil');
 -- SELECT id,
--        unnest(array['a', 'b', 'c']) AS colname,
--        unnest(array[a, b, c]) AS thing
-- FROM foo
-- ORDER BY id;
 WITH customer_ratings AS
  (SELECT customer_id,
          UNNEST(ARRAY[ 'ease_of_use', 'ease_of_access', 'navigation', 'likelihood_to_recommend']) AS mobile_app,
          UNNEST(ARRAY[mobile_app_ease_of_use, mobile_app_ease_of_access,mobile_app_navigation,mobile_app_likelihood_to_recommend]) AS ratings_for_mobile_app,
          UNNEST(ARRAY[ 'ease_of_use', 'ease_of_access', 'navigation', 'likelihood_to_recommend']) AS online_interface,
          UNNEST(ARRAY[online_interface_ease_of_use, online_interface_ease_of_access,online_interface_navigation,online_interface_likelihood_to_recommend]) AS ratings_for_online_interface
   FROM year2023.wk_6_customer_ratings),
      avg_rating_per_platform_per_customer AS
  (SELECT customer_id,
          AVG(ratings_for_mobile_app) AS avg_mobile_app_rating,
          AVG(ratings_for_online_interface) AS avg_online_interface_rating
   FROM customer_ratings
   GROUP BY customer_id),
      categorised_ratings AS
  (SELECT *,
          CASE
              WHEN avg_mobile_app_rating - avg_online_interface_rating >= 2 THEN 'Mobile App Superfan'
              WHEN avg_mobile_app_rating - avg_online_interface_rating >= 1 THEN 'Mobile App Fan'
              WHEN avg_online_interface_rating - avg_mobile_app_rating >= 2 THEN 'Online Interface Superfan'
              WHEN avg_online_interface_rating - avg_mobile_app_rating >= 1 THEN 'Online Interface Fan'
              ELSE 'Neutral'
          END AS rating_category
   FROM avg_rating_per_platform_per_customer
   ORDER BY avg_online_interface_rating DESC)
SELECT rating_category AS preference,
       ROUND(100 * COUNT(*)::DECIMAL/
               (SELECT COUNT(*)
                FROM categorised_ratings), 1) AS pct_of_total
FROM categorised_ratings
GROUP BY 1