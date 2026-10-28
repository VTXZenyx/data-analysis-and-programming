# 🏎️ Formula 1 — SQL analysis

[← Back to the portfolio](../../README.md) · [Browse all projects](../../index.html)

**SQL · SQLite · DBI · RSQLite · joins**

I imported Formula 1 datasets into SQLite and wrote queries to combine racing information across tables. I used filters, joins and `GROUP BY` to answer real questions.

![Formula 1 race country counts](f1_results.png)

**Results from my submitted report:**

| Question | Result |
| --- | --- |
| Country with the most circuits | USA — 11 |
| Circuit closest to the equator | Marina Bay Street Circuit, Singapore |
| 2001 European Grand Prix country | Germany |
| Countries with 24+ races since 2000 | Italy 35, Spain 29, Germany 26, UK 25, Hungary 24 |

**Quick code:** [Read SQL queries](queries.sql) · [SQL in R](f1_sql_in_r.R) · **Full source:** [Assignment 2](../../source/assignment2.Rmd)

To run: copy the three `f1_*.csv` files from `02_LOCAL_DATA_PRIVATE` into this folder; open it in RStudio; install `DBI` and `RSQLite`; run `source("f1_sql_in_r.R", echo = TRUE)`.

*The chart is a new visual summary of the SQL output in my rendered assignment, not a plot produced by my submitted SQL code. Results refer to the assignment's historic dataset.*
