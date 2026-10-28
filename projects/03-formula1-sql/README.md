# Formula 1 SQL analysis

[← All projects](../../README.md)

**Goal:** Answer questions about historical Formula 1 circuits, drivers and races.

![SQL result summary](preview.png)

**What I did:** Imported three CSV datasets into SQLite and wrote queries using joins, filtering, grouping and sorting.

**Skills:** SQLite · SQL joins · aggregation · DBI / RSQLite

**Example findings from the assignment dataset:** The US had 11 listed circuits; Marina Bay Street Circuit was closest to the equator; Italy recorded 35 races from 2000 onward in the dataset.

**Code:** [SQL queries](queries.sql) · [Run SQL through R](f1_sql_in_r.R) · [Original Assignment 2](../../coursework/assignment2.Rmd)

To rerun, put `f1_circuits.csv`, `f1_drivers.csv` and `f1_races.csv` in this folder before running the R script. Data spans the historical period covered by the assignment, not current F1 results.

*The preview image is a new visual summary of the original SQL results, rather than a chart in the submitted assignment.*
