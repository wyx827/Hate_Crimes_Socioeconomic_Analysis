#### Preamble ####
# Purpose: Tests the cleaned Hate Crimes data for completeness and consistency
# Author: Yuxuan Wei
# Date: 13 November 2024
# Contact: shaw.wei@mail.utoronto.ca
# License: MIT
# Pre-requisites: 03-clean_data.R should have produced cleaned data
# Any other information needed? Validates key variables for analysis

#### Workspace setup ####
# Load necessary libraries
library(tidyverse)
library(testthat)
library(dplyr)
library(here)

analysis_data <- read_csv(here("data", "02-analysis_data", "cleaned_hate_crimes.csv"))

  
#### Test data ####
  test_that("cleaned data has no missing socioeconomic indicators", {
    expect_true(all(!is.na(analysis_data$median_income)), 
                info = "There are missing values in median_income.")
    expect_true(all(!is.na(analysis_data$unemployment_rate)), 
                info = "There are missing values in unemployment_rate.")
    expect_true(all(!is.na(analysis_data$metro_area_population_share)), 
                info = "There are missing values in metro_area_population_share.")
    expect_true(all(!is.na(analysis_data$high_school_education_share)), 
                info = "There are missing values in high_school_education_share.")
    expect_true(all(!is.na(analysis_data$gini_index)), 
                info = "There are missing values in gini_index.")
    expect_true(all(!is.na(analysis_data$non_white_population_share)), 
                info = "There are missing values in non_white_population_share.")
    expect_true(all(!is.na(analysis_data$hate_crimes_per_100k_splc)), 
                info = "There are missing values in hate_crimes_per_100k_splc.")
    expect_true(all(!is.na(analysis_data$avg_hatecrimes_per_100k_fbi)), 
                info = "There are missing values in avg_hatecrimes_per_100k_fbi.")
  })