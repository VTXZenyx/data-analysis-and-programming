# Probabilistic simulation: genetic drift, customers and latent groups
# Extracted from my DATA202 Assignment 3 (code chunks in their original order).
# Requires base R only. From inside this project folder run:
# source("simulations.R")

set.seed(9876)

N <- 50
L <- 100
num_generations <- 21

# Make a new generation from the previous one
breed_new_gen <- function(df) {
    N <- nrow(df)
    L <- ncol(df) / 2

    df_new <- matrix(NA_integer_, nrow = N, ncol = L * 2)

    for (i in 1:N) {
        # Pick two different parents for this child
        parent_idxs <- sample(1:N, 2, replace = FALSE)
        parent1 <- parent_idxs[1]
        parent2 <- parent_idxs[2]

        # Randomly choose which copy each parent passes on at every marker
        allele_idxs <- matrix(
            sample(1:2, L * 2, replace = TRUE),
            nrow = L,
            ncol = 2
        )

        for (l in 1:L) {
            # The first copy comes from parent 1
            df_new[i, 2 * (l - 1) + 1] <-
                df[parent1, 2 * (l - 1) + allele_idxs[l, 1]]

            # The second copy comes from parent 2
            df_new[i, 2 * (l - 1) + 2] <-
                df[parent2, 2 * (l - 1) + allele_idxs[l, 2]]
        }
    }

    return(df_new)
}

# Start with a 60% chance of allele 0 and a 40% chance of allele 1
initial_population <- matrix(
    sample(
        0:1,
        N * L * 2,
        replace = TRUE,
        prob = c(0.6, 0.4)
    ),
    nrow = N,
    ncol = L * 2
)

# Keep the data from every generation. Each row is a person,
# each pair of columns is a marker, and each array slice is a generation.
all_generations <- array(
    NA_integer_,
    dim = c(N, L * 2, num_generations)
)

all_generations[, , 1] <- initial_population

# Use each generation to produce the next one
for (g in 2:num_generations) {
    all_generations[, , g] <-
        breed_new_gen(all_generations[, , g - 1])
}

# Check that all 21 generations were saved
dim(all_generations)

# Randomly choose 20 people from each generation without replacement
initial_sample_idxs <- sample(1:N, 20, replace = FALSE)
final_sample_idxs <- sample(1:N, 20, replace = FALSE)

initial_sample <- all_generations[initial_sample_idxs, , 1]
final_sample <- all_generations[final_sample_idxs, , num_generations]

# Work out the proportion of allele 0 for each marker
initial_freq <- sapply(1:L, function(j) {
    cols <- 2 * (j - 1) + (1:2)
    sum(initial_sample[, cols] == 0) / (20 * 2)
})

final_freq <- sapply(1:L, function(j) {
    cols <- 2 * (j - 1) + (1:2)
    sum(final_sample[, cols] == 0) / (20 * 2)
})

# Show the lowest and highest frequencies in each sample
range(initial_freq)
range(final_freq)

par(mfrow = c(1, 2))

hist(
    initial_freq,
    breaks = seq(-0.025, 1.025, by = 0.05),
    xlim = c(0, 1),
    main = "Allele 0 Frequencies\nOriginal Generation",
    xlab = "Relative frequency of allele 0",
    ylab = "Number of markers"
)

hist(
    final_freq,
    breaks = seq(-0.025, 1.025, by = 0.05),
    xlim = c(0, 1),
    main = "Allele 0 Frequencies\nGeneration 20",
    xlab = "Relative frequency of allele 0",
    ylab = "Number of markers"
)

par(mfrow = c(1, 1))

set.seed(2026)

simulate_day <- function() {
    current_time <- 0
    number_customers <- 0

    while (TRUE) {
        # Use the rate for the time when the gap starts
        if (current_time < 180) {
            gap <- rexp(1, rate = 1/8)
        } else {
            gap <- rexp(1, rate = 1/4)
        }

        next_arrival <- current_time + gap

        # Do not count someone who arrives after 5pm
        if (next_arrival > 480) {
            break
        }

        number_customers <- number_customers + 1
        current_time <- next_arrival
    }

    return(number_customers)
}

# Repeat the shop day simulation 1000 times
daily_customers <- replicate(1000, simulate_day())

# Calculate the lowest count, highest count and average
customer_range <- range(daily_customers)
customer_mean <- mean(daily_customers)

customer_range
customer_mean

hist(
    daily_customers,
    main = "Number of Customers per Simulated Day",
    xlab = "Number of customers",
    ylab = "Frequency"
)

set.seed(1010)

N <- 10000
p <- 5

# Randomly decide which cluster each observation belongs to
clusters <- sample(
    1:3,
    size = N,
    replace = TRUE,
    prob = c(0.20, 0.50, 0.30)
)

# Store the five category values for each observation
output <- matrix(NA_integer_, nrow = N, ncol = p)

# Cluster 1: category probabilities 0.10, 0.20, 0.70
output[clusters == 1, ] <- sample(
    1:3,
    sum(clusters == 1) * p,
    replace = TRUE,
    prob = c(0.10, 0.20, 0.70)
)

# Cluster 2: category probabilities 0.80, 0.15, 0.05
output[clusters == 2, ] <- sample(
    1:3,
    sum(clusters == 2) * p,
    replace = TRUE,
    prob = c(0.80, 0.15, 0.05)
)

# Cluster 3: category probabilities 0.25, 0.60, 0.15
output[clusters == 3, ] <- sample(
    1:3,
    sum(clusters == 3) * p,
    replace = TRUE,
    prob = c(0.25, 0.60, 0.15)
)

# Check how many observations ended up in each cluster
table(clusters)

par(mfrow = c(1, 3))

for (k in 1:3) {
    cluster_values <- factor(
        output[clusters == k, ],
        levels = 1:3
    )

    category_proportions <- prop.table(table(cluster_values))

    barplot(
        category_proportions,
        names.arg = c("1", "2", "3"),
        ylim = c(0, 1),
        main = paste("Cluster", k),
        xlab = "Category",
        ylab = "Relative frequency"
    )
}

par(mfrow = c(1, 1))

overall_mean <- mean(output)
overall_mean
