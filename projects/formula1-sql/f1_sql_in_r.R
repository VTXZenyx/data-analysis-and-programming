# Formula 1 relational data queries using R + SQLite
# Extracted from my DATA202 Assignment 2, Question 3.
# Requires f1_circuits.csv, f1_drivers.csv and f1_races.csv here.
# From inside this project folder, run: source("f1_sql_in_r.R")

library(DBI)
library(RSQLite)

f1_circuits <- read.csv(
  "f1_circuits.csv",
  fileEncoding = "UTF-8"
)

f1_drivers <- read.csv(
  "f1_drivers.csv",
  fileEncoding = "UTF-8"
)

f1_races <- read.csv(
  "f1_races.csv",
  fileEncoding = "UTF-8"
)

f1_conn <- dbConnect(
  RSQLite::SQLite(),
  "f1.sqlite"
)

dbWriteTable(
  f1_conn,
  "f1_circuits",
  f1_circuits,
  overwrite = TRUE
)

dbWriteTable(
  f1_conn,
  "f1_drivers",
  f1_drivers,
  overwrite = TRUE
)

dbWriteTable(
  f1_conn,
  "f1_races",
  f1_races,
  overwrite = TRUE
)

dbListTables(f1_conn)

dbGetQuery(
  f1_conn,
  "
  SELECT forename, surname
  FROM f1_drivers
  WHERE nationality = 'Czech'
  "
)

drivers1 <- dbGetQuery(
  f1_conn,
  "
  SELECT *
  FROM f1_drivers
  WHERE surname = 'Rosberg'
  AND nationality = 'Finnish'
  OR forename = 'Robert'
  AND code LIKE 'K%'
  "
)

drivers1

dbGetQuery(
  f1_conn,
  "
  SELECT name, country
  FROM f1_circuits
  ORDER BY ABS(latitude)
  LIMIT 1
  "
)

dbGetQuery(
  f1_conn,
  "
  SELECT f1_circuits.country
  FROM f1_races 
  INNER JOIN f1_circuits
  ON f1_races.circuitId = f1_circuits.circuitId
  WHERE f1_races.year = 2001
  AND f1_races.name = 'European Grand Prix'
  "
)

dbGetQuery(
  f1_conn,
  "
  SELECT country, COUNT(*) AS number_of_races
  FROM f1_races 
  LEFT JOIN f1_circuits
  ON f1_races.circuitId = f1_circuits.circuitId 
  WHERE year >= 2000
  GROUP BY country
  HAVING number_of_races >= 24 
  ORDER BY number_of_races DESC
  "
)

dbGetQuery(
  f1_conn,
  "
  SELECT country, COUNT(*) AS number_of_circuits
  FROM f1_circuits
  GROUP BY country
  ORDER BY number_of_circuits DESC
  LIMIT 1
  "
)

dbDisconnect(f1_conn)
