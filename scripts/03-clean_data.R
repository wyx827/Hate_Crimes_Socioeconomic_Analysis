#### Preamble ####
# Purpose: Cleans and preprocesses the Hate Crimes dataset
# Author: Yuxuan Wei
# Date: 13 November 2024
# Contact: shaw.wei@mail.utoronto.ca
# License: MIT
# Pre-requisites: 02-download_data.R should have successfully downloaded the data
# Any other information needed? Cleans socioeconomic variables for analysis

#### Workspace setup ####
# Load necessary libraries
library(dplyr)

# Read the raw data
raw_data <- read.csv("data/01-raw_data/raw_data.csv")
colnames(raw_data)

# Rename columns
cleaned_data <- raw_data %>%
  rename(
    state = state,
    median_income = median_household_income,
    unemployment_rate = share_unemployed_seasonal,
    metro_area_population_share = share_population_in_metro_areas,
    high_school_education_share = share_population_with_high_school_degree,
    non_citizen_share = share_non_citizen,
    white_population_poverty_share = share_white_poverty,
    gini_index = gini_index,
    non_white_population_share = share_non_white,
    trump_voter_share = share_voters_voted_trump,
    hate_crimes_per_100k_splc = hate_crimes_per_100k_splc,
    avg_hatecrimes_per_100k_fbi = avg_hatecrimes_per_100k_fbi
  )

cleaned_data <- cleaned_data %>%
  filter(!is.na(median_income)) %>%
  mutate(
    state = as.factor(state),                                 # Convert to factor
    median_income = as.numeric(median_income),                # Convert to numeric
    unemployment_rate = as.numeric(unemployment_rate),        # Convert to numeric
    metro_area_population_share = as.numeric(metro_area_population_share),
    high_school_education_share = as.numeric(high_school_education_share),
    non_citizen_share = as.numeric(non_citizen_share),
    white_population_poverty_share = as.numeric(white_population_poverty_share),
    gini_index = as.numeric(gini_index),
    non_white_population_share = as.numeric(non_white_population_share),
    trump_voter_share = as.numeric(trump_voter_share),
    hate_crimes_per_100k_splc = as.numeric(hate_crimes_per_100k_splc),
    avg_hatecrimes_per_100k_fbi = as.numeric(avg_hatecrimes_per_100k_fbi)
  ) %>%
  drop_na()  # Remove rows with any NA values

# Clean and Convert Data Types
cleaned_data <- cleaned_data %>%
  mutate(
    non_citizen_share = ifelse(is.na(non_citizen_share), median(non_citizen_share, na.rm = TRUE), non_citizen_share)
  )


# View the cleaned dataset
head(cleaned_data)

#### Save data ####
# Save the cleaned dataset to a new CSV file
write_csv(cleaned_data, "data/02-analysis_data/cleaned_hate_crimes.csv")

