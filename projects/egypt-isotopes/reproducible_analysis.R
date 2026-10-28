# Optional portfolio refactor, not the original submitted assignment.
# Explicitly follows material -> sample -> measurement foreign keys.
# Requires EgyptData.xlsx in THIS folder. R packages: readxl, dplyr, ggplot2.
library(readxl); library(dplyr); library(ggplot2)

materials <- read_excel("EgyptData.xlsx", sheet = "materials")
samples <- read_excel("EgyptData.xlsx", sheet = "samples")
measurements <- read_excel("EgyptData.xlsx", sheet = "mineral_measures")

joined <- measurements %>%
  left_join(samples %>% select(sample_id, material_id), by = "sample_id") %>%
  left_join(materials %>% select(material_id, biological_sex,
                                relative_dating_upper_limit), by = "material_id") %>%
  mutate(
    biological_sex = sub("\\?", "", biological_sex),
    period = if_else(relative_dating_upper_limit <= -1649,
                     "Pre-Hyksos", "Hyksos")
  )
stopifnot(nrow(joined) == nrow(measurements))

summary <- joined %>%
  group_by(period, biological_sex) %>%
  summarise(n = n(), mean_sr = mean(sr87_sr86, na.rm = TRUE),
            sd_sr = sd(sr87_sr86, na.rm = TRUE), .groups = "drop")
print(summary)

p <- ggplot(joined, aes(x = period, y = sr87_sr86)) +
  geom_boxplot() +
  geom_jitter(width = 0.12, alpha = .4) +
  labs(x = "Archaeological period", y = "87Sr/86Sr ratio",
       title = "Strontium isotope ratios by period") +
  theme_minimal()
print(p)
