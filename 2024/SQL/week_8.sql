SELECT *
FROM year2024.wk_8_updated_customers;

-- checking if all customer ids are unique and distinct

SELECT COUNT(*),
       COUNT(DISTINCT customer_id)
FROM year2024.wk_8_updated_customers;

-- cleaning updated customers table

CREATE
TEMPORARY VIEW customers AS WITH tmp AS
       (SELECT customer_id,
               first_flight,
               last_date_flown,
               number_of_flights, -- tier grouping
 DIV(number_of_flights, 5) AS tier, -- finding average number of flights
 number_of_flights / (DATE_PART('year', last_date_flown) - DATE_PART('year', first_flight)+1) as avg_flights_per_year
        FROM year2024.wk_8_updated_customers
        WHERE last_date_flown >= '2023-02-21'),
               tmp_2 AS
       (SELECT *,
               SUBSTRING('0,1,2,3,4,5,6', 1, POSITION(tier::TEXT IN '0,1,2,3,4,5,6')) AS tiers_down
        FROM tmp)
SELECT customer_id,
       first_flight,
       last_date_flown,
       number_of_flights,
       avg_flights_per_year,
       unnest(string_to_array(tiers_down, ','))::INTEGER as tier
FROM tmp_2;

-- cleaning loyalty schemes table

CREATE
TEMPORARY VIEW loyalty_schemes_cleaned AS
SELECT REPLACE(tier, 'Tier ', '')::INTEGER AS tier,
       benefits
FROM year2024.wk_8_loyalty_schemes
WHERE tier_grouping = 5;

-- joining customers and loyalty schemes table

CREATE
TEMPORARY VIEW joined_customers_loyalty AS WITH tmp AS
       (SELECT c.*,
               l.benefits
        FROM customers c
        LEFT JOIN loyalty_schemes_cleaned l ON c.tier = l.tier)
SELECT customer_id,
       tier,
       avg_flights_per_year,
       TRIM(unnest(string_to_array(benefits, ','))) AS benefits
FROM tmp;

-- cleaned costings

CREATE
TEMPORARY VIEW costings AS
SELECT benefit,
       TO_NUMBER(REGEXP_REPLACE(cost, '[[:alpha:]]', '', 'g'), 'L999') AS cost,
       SUBSTRING(REGEXP_REPLACE(cost, '[0-9]', '', 'g')
                 FROM 3) AS frequency
FROM year2024.wk_8_costings;

-- joining costings and joined_customers_loyalty tables
WITH tmp AS
       (SELECT j.*,
               c.cost,
               c.frequency
        FROM joined_customers_loyalty j
        LEFT JOIN costings c ON j.benefits = c.benefit),
     tmp_2 AS
       (SELECT customer_id,
               MAX(tier) AS tier,
               SUM(CASE
                       WHEN frequency = 'per flight' THEN avg_flights_per_year * cost
                       ELSE cost
                   END) AS yearly_cost
        FROM tmp
        GROUP BY customer_id)
SELECT tier,
       SUM(yearly_cost) AS yearly_cost,
       COUNT(DISTINCT customer_id)
FROM tmp_2
GROUP BY tier;