#### Preamble ####
# Purpose: Fits a regression model to explore socioeconomic predictors of hate crimes
# Author: Yuxuan Wei
# Date: 13 November 2024
# Contact: shaw.wei@mail.utoronto.ca
# License: MIT
# Pre-requisites: 05-exploratory_data_analysis.R should have provided EDA insights
# Any other information needed? Uses linear regression for initial model

#### Workspace setup ####
# Load necessary libraries
library(dplyr)
library(broom)

#### Modeling Data ####
cleaned_data <- read.csv("cleaned_hate_crimes_data.csv")

# Fit linear regression model
model <- lm(hate_crimes ~ median_household_income + unemployment_rate + education_level, data = cleaned_data)
summary(model)
