# Clustering algorithms — comparative lab

[← Back to the portfolio](../../README.md)

**R · unsupervised learning · model evaluation · reproducibility**

The goal: apply four methods to the **same 640-point synthetic dataset** and see how their answers differ. The true groups are known, so we can compare methods using **Adjusted Rand Index (ARI)**.

![Four clustering previews](clustering_preview.png)

### What the methods do

| Approach | Main idea |
| --- | --- |
| **K-means** | Finds groups around a specified number of centres |
| **Hierarchical (Ward)** | Builds a tree of groups; choose where to cut it |
| **DBSCAN** | Finds dense regions, and can flag noise |
| **Gaussian mixture** | Models groups as overlapping probability distributions |

### Preview results

These preview scores were calculated from the included synthetic dataset using **scikit-learn (Python)**, to make the comparison viewable without R. The R script independently fits equivalent families of models; its scores may differ.

| method              |   clusters_found |   noise_points |   adjusted_rand_index_preview |
|:--------------------|-----------------:|---------------:|------------------------------:|
| K-means             |                4 |              0 |                         0.959 |
| Hierarchical (Ward) |                4 |              0 |                         0.975 |
| DBSCAN              |                4 |             41 |                         0.912 |
| Gaussian mixtures   |                4 |              0 |                         0.992 |

**Code:** [Open R script](clustering_in_r.R) · [Synthetic dataset](synthetic_clusters.csv) · [Preview results](preview_comparison.csv)

**Run in R:** install `dbscan` and `mclust` once, open this folder in RStudio, then run `source("clustering_in_r.R")`. It saves `clustering_r_output.png` and `clustering_r_results.csv` in the project directory.

**Provenance:** This is a **new, AI-assisted portfolio extension**, motivated by DATA202 Weeks 11–12 teaching examples; it is **not** one of the three graded assignments. I studied the algorithms in the course; the original lecture example files were course-provided, not written solely by me. No personal marks are attached to this project.
