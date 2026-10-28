# Clustering methods — portfolio extension, not an assessed assignment.
# Based on topics in DATA202 Weeks 11–12 (course demonstration files are not personal code).
# This standalone implementation was prepared with AI assistance.
# Run from THIS project folder: source("clustering_in_r.R")
# Install once: install.packages(c("dbscan", "mclust"))

if (!requireNamespace("dbscan", quietly = TRUE) ||
    !requireNamespace("mclust", quietly = TRUE)) {
  stop("Install packages: install.packages(c('dbscan', 'mclust'))")
}

points <- read.csv("synthetic_clusters.csv")
stopifnot(all(c("x", "y", "true_group") %in% names(points)))
features <- as.matrix(points[, c("x", "y")])
truth <- points$true_group
set.seed(42)

# 1. K-means: multiple random starts reduce poor local solutions.
km <- kmeans(features, centers = 4, nstart = 30, iter.max = 100)

# 2. Hierarchical: Ward's method merges clusters to minimise within-group variation.
hierarchy <- hclust(dist(features), method = "ward.D2")
ward_labels <- cutree(hierarchy, k = 4)

# 3. DBSCAN: density-based clustering; label 0 denotes a noise observation.
density <- dbscan::dbscan(features, eps = 0.72, minPts = 8)

# 4. Model-based: Gaussian mixture model with four mixture components.
mixture <- mclust::Mclust(features, G = 4, verbose = FALSE)

# Adjusted Rand Index compares partition agreement regardless of label numbering.
methods <- list(
  "K-means" = km$cluster,
  "Hierarchical (Ward)" = ward_labels,
  "DBSCAN" = density$cluster,
  "Gaussian mixtures" = mixture$classification
)
comparison <- data.frame(
  method = names(methods),
  clusters_found = vapply(methods, function(x) length(setdiff(unique(x), 0)), 1L),
  noise_points = vapply(methods, function(x) sum(x == 0), 1L),
  adjusted_rand_index = vapply(methods, function(x) mclust::adjustedRandIndex(truth, x), 1.0)
)
print(comparison)

# Save the actual R output locally. This differs from Python preview statistics.
write.csv(comparison, "clustering_r_results.csv", row.names = FALSE)
png("clustering_r_output.png", width = 1400, height = 1080, res = 155)
oldpar <- par(mfrow = c(2, 2), mar = c(3.5, 3.5, 3, 1))
for (method in names(methods)) {
  label <- methods[[method]]
  plot(features[, 1], features[, 2], col = as.integer(factor(label)),
       pch = 16, cex = .55, xlab = "Feature 1", ylab = "Feature 2", main = method)
}
par(oldpar)
dev.off()
