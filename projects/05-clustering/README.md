# Comparing clustering methods

[← All projects](../../README.md)

**Goal:** Understand how different algorithms group the same data.

![Clustering comparison](preview.png)

**What I did:** Compared k-means, hierarchical clustering (Ward), DBSCAN and Gaussian mixture modelling using the same **synthetic 2D data**. The methods are compared with Adjusted Rand Index (ARI), which accounts for cluster-label switching.

**Skills:** Unsupervised learning · distance-based grouping · density clustering · model comparison

**Code:** [R implementation](clustering_in_r.R) · [Synthetic dataset](synthetic_clusters.csv)

**Run:** From this folder, install the R packages `dbscan` and `mclust`, then run `source("clustering_in_r.R")`.

**Attribution:** This is a **new AI-assisted portfolio exercise** based on topics covered in DATA202 Weeks 11–12, **not** a graded university assignment. The displayed comparison was calculated in Python using the included synthetic data; the R version may return slightly different results.
