#### Preamble ####
# Purpose: Conducts exploratory data analysis on Hate Crimes dataset
# Author: Yuxuan Wei
# Date: 13 November 2024
# Contact: shaw.wei@mail.utoronto.ca
# License: MIT
# Pre-requisites: 04-test_analysis_data.R should have validated the cleaned data
# Any other information needed? EDA to understand data patterns

#### Workspace setup ####
# Load necessary libraries
library(ggplot2)
library(dplyr)

#### Exploratory Data Analysis ####
cleaned_data <- read.csv("data/02-analysis_data/cleaned_hate_crimes.csv")

# Visualize income vs. hate crime incidents
ggplot(cleaned_data, aes(x = median_household_income, y = hate_crimes)) +
  geom_point() +
  labs(title = "Income vs Hate Crimes")
