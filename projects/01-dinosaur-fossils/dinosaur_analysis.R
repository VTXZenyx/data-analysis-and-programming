# Dinosaur fossils: map and diet summary
# Extracted from my DATA202 Assignment 1, Question 7.
# Requires dinosaurs.csv in this folder, ggplot2 and maps.
# From inside this project folder, run: source("dinosaur_analysis.R")

# Load required libraries
library(ggplot2)
library(maps)

# Create the world map data
world <- map_data("world")

# Read the dinosaur dataset
dinos <- read.csv("dinosaurs.csv")

# Create the dinosaur type factor
dinos$type_factor <- factor(
  dinos$type,
  levels = c(
    "armored dinosaur",
    "ceratopsian",
    "large theropod",
    "ornithopod",
    "sauropod",
    "small theropod"
  )
)

########## 1st COMMENT LINE - Insert code below this line

dinos <- dinos[dinos$lng <= 180, ]

dinos <- dinos[!is.na(dinos$type_factor), ]

########## 2nd COMMENT LINE - Insert code above this line

ggplot() +
  geom_polygon(
    data = world,
    aes(x = long, y = lat, group = group),
    fill = "grey90",
    colour = "grey50"
  ) +
  geom_point(
    data = dinos,
    aes(x = lng, y = lat, colour = type_factor)
  ) +
  coord_fixed(1.3) +
  xlab("Longitude") +
  ylab("Latitude") +
  labs(colour = "Type")

dinos_diet <- dinos[dinos$diet != "", ]

barplot(
  table(dinos_diet$diet),
  main = "Number of Dinosaurs in Each Diet Category",
  xlab = "Diet",
  ylab = "Number of Dinosaurs"
)
