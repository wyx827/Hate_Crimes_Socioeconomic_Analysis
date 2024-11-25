#### Preamble ####
# Purpose: Model the relationship between socioeconomic factors and hate crimes
# Author: Yuxuan Wei
# Date: 24 November 2024
# Contact: shaw.wei@mail.utoronto.ca
# License: MIT
# Pre-requisites: 03-clean_data.R should have produced cleaned_hate_crimes.parquet
# Any other information needed? Fit a Bayesian hierarchical model for analysis and visualize relationships

#### Workspace setup ####
# Load necessary libraries
library(dplyr)
library(arrow)  # For reading Parquet files
library(rstanarm)
library(ggplot2)

# Load the cleaned data from Parquet file
analysis_data <- read_parquet("data/02-analysis_data/cleaned_hate_crimes.parquet")

# Verify the structure of the data
str(analysis_data)

#### Perfect Model: Bayesian Hierarchical Model ####
# Prepare Bayesian priors
priors <- normal(location = 0, scale = 2.5, autoscale = TRUE)

# Fit the Bayesian hierarchical model
bayesian_model <- stan_glmer(
  hate_crimes_per_100k_splc ~ median_income + unemployment_rate + 
    metro_area_population_share + high_school_education_share + 
    gini_index + non_white_population_share + (1 | state),
  data = analysis_data,
  family = gaussian,  # Suitable for continuous outcomes
  prior = priors,
  prior_intercept = priors,
  seed = 123,
  cores = 4,
  adapt_delta = 0.95
)

# Summarize the Bayesian model
summary(bayesian_model)

# Posterior predictive checks
pp_check(bayesian_model)

#### Visualization ####
# Define predictor names
predictors <- c(
  "median_income",
  "unemployment_rate",
  "metro_area_population_share",
  "high_school_education_share",
  "gini_index",
  "non_white_population_share"
)

# Create scatter plots for each predictor vs hate_crimes_per_100k_splc
for (predictor in predictors) {
  plot <- ggplot(analysis_data, aes(x = .data[[predictor]], y = hate_crimes_per_100k_splc)) +
    geom_point(alpha = 0.7) +
    labs(
      title = paste("Relationship Between", predictor, "and Hate Crimes"),
      x = predictor,
      y = "Hate Crimes per 100k"
    ) +
    theme_minimal()
  
  print(plot)  # Display each plot
}

#### Save the Model ####
# Save the Bayesian model for further use
saveRDS(bayesian_model, file = "models/final_bayesian_model.rds")

#### Completion Message ####
print("Bayesian hierarchical model completed successfully, and plots displayed.")
