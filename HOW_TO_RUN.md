# How to run the projects

**Browsing the portfolio?** You don't need to install anything. Open the [README](README.md) and click a project.

**Running the code?** Install R and RStudio, then open the chosen project's folder as your working directory. Install its listed packages once. For each project:

| Project | Script to run in RStudio | Dataset needed |
|---|---|---|
| Dinosaur fossils | `source("dinosaur_analysis.R")` | `dinosaurs.csv` (not included) |
| Ancient Egypt | `source("isotope_analysis.R")` | `EgyptData.xlsx` (not included) |
| Formula 1 SQL | `source("f1_sql_in_r.R")` | Three `f1_*.csv` files (not included) |
| Simulations | `source("simulations.R")` | No additional data |
| Clustering | `source("clustering_in_r.R")` | Included synthetic CSV |

### Packages

- Dinosaur: `install.packages(c("ggplot2", "maps"))`
- Egypt: `install.packages(c("readxl", "dplyr", "ggplot2"))`
- Formula 1: `install.packages(c("DBI", "RSQLite"))`
- Simulations: base R only
- Clustering: `install.packages(c("dbscan", "mclust"))`

**Transparency:** SQL queries were tested with SQLite against the user's CSVs. Full R execution has **not** been verified in this packaging environment (R was unavailable). All four coursework projects use the original assignment source or extracted scripts; the clustering comparison is AI-assisted. Dataset reuse should follow its licence and the university's applicable rules.
