#### Preamble ####
# Purpose: Simulates data for Hate Crimes final paper
# Author: Yuxuan Wei
# Date: 13 November 2024
# Contact: shaw.wei@mail.utoronto.ca
# License: MIT
# Pre-requisites: None, generates simulated data
# Any other information needed? This script creates mock datasets to test workflows

#### Workspace setup ####
# Load necessary libraries
library(dplyr)

# Simulate socioeconomic data for US states
set.seed(123)
simulated_data <- data.frame(
  state = state.name,
  median_income = rnorm(50, mean = 60000, sd = 15000),
  unemployment_rate = runif(50, 3, 10),
  education_level = sample(10:100, 50, replace = TRUE),
  hate_crime_incidents = rpois(50, lambda = 20)
)


# Save simulated data
write.csv(simulated_data, "data/00-simulated_data/simulated_data.csv", row.names = FALSE)
