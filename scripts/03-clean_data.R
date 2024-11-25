#### Preamble ####
# Purpose: Cleans and preprocesses the Hate Crimes dataset, keeping only the required columns
# Author: Yuxuan Wei
# Date: 24 November 2024
# Contact: shaw.wei@mail.utoronto.ca
# License: MIT
# Pre-requisites: 02-download_data.R should have successfully downloaded the data
# Any other information needed? Retains only specified columns for analysis

#### Workspace setup ####
# Load necessary libraries
library(dplyr)
library(readr)  # For write_csv()
library(arrow)

# Read the raw data
raw_data <- read.csv("data/01-raw_data/raw_data.csv")

# Select and rename the required columns
cleaned_data <- raw_data %>%
  select(
    state,
    median_income = median_household_income,
    unemployment_rate = share_unemployed_seasonal,
    metro_area_population_share = share_population_in_metro_areas,
    high_school_education_share = share_population_with_high_school_degree,
    gini_index,
    non_white_population_share = share_non_white,
    hate_crimes_per_100k_splc,
    avg_hatecrimes_per_100k_fbi
  )

# Check and convert data types
cleaned_data <- cleaned_data %>%
  mutate(
    state = as.factor(state),                                 # Convert to factor
    median_income = as.numeric(median_income),                # Convert to numeric
    unemployment_rate = as.numeric(unemployment_rate),        # Convert to numeric
    metro_area_population_share = as.numeric(metro_area_population_share),
    high_school_education_share = as.numeric(high_school_education_share),
    gini_index = as.numeric(gini_index),
    non_white_population_share = as.numeric(non_white_population_share),
    hate_crimes_per_100k_splc = as.numeric(hate_crimes_per_100k_splc),
    avg_hatecrimes_per_100k_fbi = as.numeric(avg_hatecrimes_per_100k_fbi)
  )

# Remove rows with any NA values
cleaned_data <- cleaned_data %>%
  drop_na()

# Verify the cleaned dataset
print(head(cleaned_data))
summary(cleaned_data)

#### Save data ####
# Save the cleaned dataset to a new CSV file
write_csv(cleaned_data, "data/02-analysis_data/cleaned_hate_crimes.csv")

write_parquet(cleaned_data, "data/02-analysis_data/cleaned_hate_crimes.parquet")

