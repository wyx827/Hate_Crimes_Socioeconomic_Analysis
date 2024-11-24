#### Preamble ####
# Purpose: Perform exploratory data analysis (EDA) on the cleaned Hate Crimes dataset
# Author: Yuxuan Wei
# Date: 24 November 2024
# Contact: shaw.wei@mail.utoronto.ca
# License: MIT
# Pre-requisites: Get the cleaned Hate Crimes dataset
# Any other information needed? NA

#### Workspace setup ####
library(tidyverse)
library(ggplot2)
library(rstanarm)
library(modelsummary)

#### Read data ####
analysis_data <- read_csv("data/02-analysis_data/cleaned_hate_crimes.csv")
colnames(analysis_data)

#### Summary of the data ####
summary(analysis_data)

#### Visualize distributions ####
# Histogram of hate crimes per 100k (SPLC)
ggplot(analysis_data, aes(x = hate_crimes_per_100k_splc)) +
  geom_histogram(binwidth = 1, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Hate Crimes per 100k (SPLC)", x = "Hate Crimes per 100k", y = "Count") +
  theme_minimal()

# Histogram of median household income
ggplot(analysis_data, aes(x = median_income)) +
  geom_histogram(binwidth = 5000, fill = "green", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Median Household Income", x = "Median Household Income ($)", y = "Count") +
  theme_minimal()

# Scatter plot of hate crimes vs. unemployment rate
ggplot(analysis_data, aes(x = unemployment_rate, y = hate_crimes_per_100k_splc)) +
  geom_point(alpha = 0.7) +
  labs(title = "Hate Crimes vs. Unemployment Rate", x = "Unemployment Rate (%)", y = "Hate Crimes per 100k") +
  theme_minimal()

# Bar plot of average hate crimes by state
ggplot(analysis_data, aes(x = reorder(state, -avg_hatecrimes_per_100k_fbi), y = avg_hatecrimes_per_100k_fbi)) +
  geom_bar(stat = "identity", fill = "purple", alpha = 0.7) +
  labs(title = "Average Hate Crimes per 100k (FBI) by State", x = "State", y = "Hate Crimes per 100k") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#### Relationship between variables ####
# Scatter plot of median income vs. hate crimes
ggplot(analysis_data, aes(x = median_income, y = hate_crimes_per_100k_splc)) +
  geom_point(alpha = 0.7) +
  labs(title = "Hate Crimes vs. Median Income", x = "Median Income ($)", y = "Hate Crimes per 100k") +
  theme_minimal()

# Box plot of hate crimes by Gini index
ggplot(analysis_data, aes(x = factor(round(gini_index, 2)), y = hate_crimes_per_100k_splc)) +
  geom_boxplot(fill = "orange", alpha = 0.7) +
  labs(title = "Hate Crimes by Gini Index", x = "Gini Index", y = "Hate Crimes per 100k") +
  theme_minimal()

#### Basic models ####
#### Logistic Regression ####
# Scale hate_crimes_per_100k_splc to be within (0, 1)
logistic_data <- analysis_data %>%
  mutate(hate_crimes_scaled = (hate_crimes_per_100k_splc - min(hate_crimes_per_100k_splc)) / 
           (max(hate_crimes_per_100k_splc) - min(hate_crimes_per_100k_splc)),
         hate_crimes_scaled = pmin(0.9999, pmax(0.0001, hate_crimes_scaled))) # Adjust to strictly (0, 1)

logistic_reg <- glm(hate_crimes_scaled ~
                      median_income + unemployment_rate + gini_index, 
                    data = logistic_data, family = quasibinomial)

# Summary of the model
summary(logistic_reg)


#### Bayesian models ####
# Bayesian model setup
bayesian_model <- analysis_data %>%
  mutate(non_white_share_scaled = scale(non_white_population_share))

# Model formula
model_formula <- hate_crimes_per_100k_splc ~ median_income + unemployment_rate + (1 | state)

# Specify priors
priors <- normal(0, 2.5, autoscale = TRUE)

# Fit Bayesian model
bayesian_model <- stan_glmer(
  formula = model_formula,
  data = bayesian_model,
  family = gaussian,
  prior = priors,
  prior_intercept = priors,
  seed = 123,
  cores = 4,
  adapt_delta = 0.95
)

# Posterior predictive checks
pp_check(bayesian_model)

# Summarize Bayesian model
summary(bayesian_model)

#### Save models ####
saveRDS(logistic_reg, file = "models/logistic_reg.rds")
saveRDS(bayesian_model, file = "models/bayesian_model.rds")

#### Completion Message ####
print("EDA has completed.")

