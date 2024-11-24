#### Preamble ####
# Purpose: Model the relationship between socioeconomic factors and hate crimes
# Author: Yuxuan Wei
# Date: 24 November 2024
# Contact: shaw.wei@mail.utoronto.ca
# License: MIT
# Pre-requisites: 03-clean_data.R should have produced cleaned_hate_crimes.csv
# Any other information needed? Fit a single Bayesian hierarchical model for analysis

#### Workspace setup ####
# Load necessary libraries
library(dplyr)
library(rstanarm)
library(ggplot2)

# Load the cleaned data
analysis_data <- read_csv("data/02-analysis_data/cleaned_hate_crimes.csv")

# Verify the structure of the data
str(analysis_data)

#### Perfect Model: Bayesian Hierarchical Model ####
# Prepare Bayesian priors
priors <- normal(location = 0, scale = 2.5, autoscale = TRUE)

# Fit the Bayesian hierarchical model
bayesian_model <- stan_glmer(
  hate_crimes_per_100k_splc ~ median_income + unemployment_rate + gini_index + (1 | state),
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
# Display the plot of predicted hate crimes vs median income
ggplot(analysis_data, aes(x = median_income, y = hate_crimes_per_100k_splc)) +
  geom_point(alpha = 0.7) +
  labs(
    title = "Relationship Between Median Income and Hate Crimes",
    x = "Median Household Income ($)",
    y = "Hate Crimes per 100k"
  ) +
  theme_minimal()

#### Save the Model ####
# Save the Bayesian model for further use
saveRDS(bayesian_model, file = "models/perfect_bayesian_model.rds")

#### Completion Message ####
print("Bayesian hierarchical model completed and saved successfully.")
