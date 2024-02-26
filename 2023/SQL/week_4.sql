-- APPENDING ALL DATA

CREATE
TEMPORARY VIEW appended_data AS
SELECT id,
       ('January ' || joining_day || ', 2023')::DATE AS joining_date,
       demographic,
       value
FROM year2023.wk_4_January
UNION ALL
SELECT id,
       ('February ' || joining_day || ', 2023')::DATE AS joining_date,
       demographic,
       value
FROM year2023.wk_4_February
UNION ALL
SELECT id,
       ('March ' || joining_day || ', 2023')::DATE AS joining_date,
       demographic,
       value
FROM year2023.wk_4_March
UNION ALL
SELECT id,
       ('April ' || joining_day || ', 2023')::DATE AS joining_date,
       demographic,
       value
FROM year2023.wk_4_April
UNION ALL
SELECT id,
       ('May ' || joining_day || ', 2023')::DATE AS joining_date,
       demographic,
       value
FROM year2023.wk_4_May
UNION ALL
SELECT id,
       ('June ' || joining_day || ', 2023')::DATE AS joining_date,
       demographic,
       value
FROM year2023.wk_4_June
UNION ALL
SELECT id,
       ('July ' || joining_day || ', 2023')::DATE AS joining_date,
       demographic,
       value
FROM year2023.wk_4_July
UNION ALL
SELECT id,
       ('August ' || joining_day || ', 2023')::DATE AS joining_date,
       demographic,
       value
FROM year2023.wk_4_August
UNION ALL
SELECT id,
       ('September ' || joining_day || ', 2023')::DATE AS joining_date,
       demographic,
       value
FROM year2023.wk_4_September
UNION ALL
SELECT id,
       ('October ' || joining_day || ', 2023')::DATE AS joining_date,
       demographic,
       value
FROM year2023.wk_4_October
UNION ALL
SELECT id,
       ('November ' || joining_day || ', 2023')::DATE AS joining_date,
       demographic,
       value
FROM year2023.wk_4_November
UNION ALL
SELECT id,
       ('December ' || joining_day || ', 2023')::DATE AS joining_date,
       demographic,
       value
FROM year2023.wk_4_December;


SELECT *
from appended_data;

-- PIVOT DEMOGRAPHIC DATA
WITH pivoted_data AS
  (SELECT id,
          joining_date,
          CASE
              WHEN demographic = 'Account Type' THEN value
              ELSE NULL
          END AS account_type,
          CASE
              WHEN demographic = 'Date of Birth' THEN value
              ELSE NULL
          END AS date_of_birth,
          CASE
              WHEN demographic = 'Ethnicity' THEN value
              ELSE NULL
          END AS ethnicity
   from appended_data),
     removed_nulls AS
  (SELECT m.id,
          m.joining_date,
          m.account_type,
          n.date_of_birth,
          o.ethnicity
   FROM
     (SELECT id,
             joining_date,
             account_type
      FROM pivoted_data
      WHERE account_type IS NOT NULL) m
   LEFT JOIN
     (SELECT id,
             joining_date,
             date_of_birth
      FROM pivoted_data
      WHERE date_of_birth IS NOT NULL) n ON (m.id = n.id
                                             AND m.joining_date = n.joining_date)
   LEFT JOIN
     (SELECT id,
             joining_date,
             ethnicity
      FROM pivoted_data
      WHERE ethnicity IS NOT NULL) o ON (n.id = o.id
                                         AND n.joining_date = o.joining_date)),
     removed_duplicates AS
  (SELECT DISTINCT id,
                   joining_date,
                   account_type,
                   date_of_birth,
                   ethnicity
   FROM removed_nulls),
     ordered_by_date AS
  (SELECT *,
          ROW_NUMBER() OVER (PARTITION BY id
                             ORDER BY joining_date) AS row_num
   FROM removed_duplicates)
SELECT id,
       joining_date,
       account_type,
       date_of_birth,
       ethnicity
FROM ordered_by_date
WHERE row_num = 1;