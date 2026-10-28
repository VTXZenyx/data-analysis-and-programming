# Ancient Egypt strontium isotope data analysis
# Extracted from my DATA202 Assignment 2, Questions 1 & 2.
# Requires EgyptData.xlsx with the original sheet names in this folder.
# From inside this project folder, run: source("isotope_analysis.R")

library(dplyr)
library(ggplot2)
library(readxl)

filename <- "EgyptData.xlsx"

sheet_names <- excel_sheets(filename)
sheet_names

mineral_measures <- read_excel(
  filename,
  sheet = "mineral_measures"
)

materials <- read_excel(
  filename,
  sheet = "materials"
)

hyksos <- full_join(
  materials,
  mineral_measures,
  by = c("material_id" = "sample_id")
)

df <- hyksos %>%
  select(
    relative_dating_upper_limit,
    biological_sex,
    sr87_sr86
  ) %>%
  rename(
    dates = relative_dating_upper_limit,
    sex = biological_sex,
    sr = sr87_sr86
  )

df <- df %>% 
  mutate(
    sex = gsub(
      'F\\?',
      'F',
      gsub('M\\?', 'M', sex)
    )
  )

df <- df %>%
  mutate(
    period = ifelse(
      dates >= -1991 & dates <= -1649,
      "Pre-Hyksos",
      "Hyksos"
    )
  )

sex_summary <- df %>% 
  filter(!is.na(sex)) %>%
  group_by(sex) %>%
  summarise(
    Mean = mean(sr),
    SD = sd(sr),
    Count = n()
  )

print(sex_summary)

period_summary <- df %>% 
  filter(!is.na(period)) %>%
  group_by(period) %>%
  summarise(
    Mean = mean(sr),
    SD = sd(sr),
    Count = n()
  )

print(period_summary)

df %>% 
  arrange(sr) %>%
  mutate(rank = row_number()) %>%
  ggplot(aes(x = rank, y = sr)) +
  geom_point()

df %>% 
  filter(!is.na(sex)) %>%
  ggplot(aes(x = sex, y = sr)) +
  geom_boxplot() +
  geom_dotplot(
    binaxis = "y",
    stackdir = "center",
    method = "histodot",
    binwidth = 0.00002
  )
