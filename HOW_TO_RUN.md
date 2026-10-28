# Reproduce the portfolio

**Just browsing?** You need **nothing** installed. Open [the homepage](README.md) or [the visual website](index.html) and click the projects.

**Want to run the code?** The ZIP contains datasets in `02_LOCAL_DATA_PRIVATE` **outside** the `01_UPLOAD_TO_GITHUB` folder. Copy the corresponding files into the selected project folder on your computer before running its `.R` script in RStudio.

| Project | Local dataset file(s) | R packages to install |
| --- | --- | --- |
| Dinosaur fossils | `dinosaurs.csv` | `ggplot2`, `maps` |
| Egypt isotopes | `EgyptData.xlsx` | `readxl`, `dplyr`, `ggplot2` |
| Formula 1 SQL | `f1_circuits.csv`, `f1_drivers.csv`, `f1_races.csv` | `DBI`, `RSQLite` |
| Simulations | None | Base R |
| Clustering methods | `synthetic_clusters.csv` is already included | `dbscan`, `mclust` |

Open RStudio, set the **project's folder** as the working directory, then use `source("script_name.R")` (see each project README for its script name).

- All original assignment charts were extracted from the supplied rendered HTML reports.
- The SQL examples were independently rechecked with SQLite against the supplied historical dataset.
- **R was not installed in the packaging environment**, so full R execution and matching freshly generated output plots have **not** been verified here.
- The clustering illustration is explicitly Python-generated using the included synthetic data; its R version is independently reproducible.

**Data sharing:** The original course-supplied datasets are kept outside the public GitHub folder pending permission/licence checks. The Ancient Egypt workbook includes CC BY 4.0 metadata, but it should still be attributed appropriately if redistributed. Do not upload datasets simply because they're included in your private ZIP.
