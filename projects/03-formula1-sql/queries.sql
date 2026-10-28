-- SQL queries extracted from the submitted Assignment 2 .Rmd
-- Tables are named f1_drivers, f1_circuits and f1_races.
-- Import CSV files first (see f1_sql_in_r.R).

-- Query 1
SELECT forename, surname
  FROM f1_drivers
  WHERE nationality = 'Czech';

-- Query 2
SELECT *
  FROM f1_drivers
  WHERE surname = 'Rosberg'
  AND nationality = 'Finnish'
  OR forename = 'Robert'
  AND code LIKE 'K%';

-- Query 3
SELECT name, country
  FROM f1_circuits
  ORDER BY ABS(latitude)
  LIMIT 1;

-- Query 4
SELECT f1_circuits.country
  FROM f1_races 
  INNER JOIN f1_circuits
  ON f1_races.circuitId = f1_circuits.circuitId
  WHERE f1_races.year = 2001
  AND f1_races.name = 'European Grand Prix';

-- Query 5
SELECT country, COUNT(*) AS number_of_races
  FROM f1_races 
  LEFT JOIN f1_circuits
  ON f1_races.circuitId = f1_circuits.circuitId 
  WHERE year >= 2000
  GROUP BY country
  HAVING number_of_races >= 24 
  ORDER BY number_of_races DESC;

-- Query 6
SELECT country, COUNT(*) AS number_of_circuits
  FROM f1_circuits
  GROUP BY country
  ORDER BY number_of_circuits DESC
  LIMIT 1;
