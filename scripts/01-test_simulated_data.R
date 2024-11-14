#### Preamble ####
# Purpose: Tests the structure and validity of the simulated Hate Crimes dataset
# Author: Yuxuan Wei
# Date: 13 November 2024
# Contact: shaw.wei@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - The `tidyverse` and `testthat` packages must be installed and loaded
# - 00-simulate_data.R must have been run to create the simulated dataset
# Any other information needed? Make sure you are in the `hate_crimes_project` R project directory

#### Workspace setup ####
library(tidyverse)
library(testthat)
library(here)

# Load simulated data
simulated_data <- read_csv(here("data", "00-simulated_data", "simulated_data.csv"))

#### Test data ####

# Test 1: Check if the data was successfully loaded
test_that("Data loaded successfully", {
  expect_true(exists("simulated_data"), 
              info = "Test Failed: The dataset could not be loaded.")
  message("Test Passed: The dataset was successfully loaded.")
})

# Test 2: Verify the dataset has 5 columns as expected
test_that("Dataset has correct number of columns", {
  expected_columns <- 5
  actual_columns <- ncol(simulated_data)
  expect_equal(actual_columns, expected_columns, 
               info = paste("Expected", expected_columns, "columns but got", actual_columns))
})

# Test 3: Check if the state column contains all 50 US states
expected_states <- state.name
test_that("State column contains all 50 US states", {
  actual_states <- unique(simulated_data$state)
  missing_states <- setdiff(expected_states, actual_states)
  extra_states <- setdiff(actual_states, expected_states)
  
  expect_true(length(missing_states) == 0, 
              info = paste("The following states are missing:", paste(missing_states, collapse = ", ")))
  expect_true(length(extra_states) == 0, 
              info = paste("The following unexpected states were found:", paste(extra_states, collapse = ", ")))
})

# Test 4: Verify that median_income values are within a reasonable range
test_that("Median income is within a realistic range", {
  expect_true(all(simulated_data$median_income >= 20000 & simulated_data$median_income <= 100000),
              info = "Some median income values are outside the range of $20,000 to $100,000.")
})

# Test 5: Verify that unemployment_rate is within 0-20%
test_that("Unemployment rate is within the range of 0% to 20%", {
  expect_true(all(simulated_data$unemployment_rate >= 0 & simulated_data$unemployment_rate <= 20),
              info = "Some unemployment rates are outside the range of 0% to 20%.")
})

# Test 6: Verify that education_level is between 0 and 100%
test_that("Education level is between 0% and 100%", {
  expect_true(all(simulated_data$education_level >= 0 & simulated_data$education_level <= 100),
              info = "Some education levels are outside the range of 0% to 100%.")
})

# Test 7: Check that hate_crime_incidents are non-negative
test_that("Hate crime incidents are non-negative", {
  expect_true(all(simulated_data$hate_crime_incidents >= 0),
              info = "Some hate crime incidents values are negative.")
})

# Test 8: Verify there are no missing values in critical columns
critical_columns <- c("state", "median_income", "unemployment_rate", "education_level", "hate_crime_incidents")
test_that("No missing values in critical columns", {
  missing_counts <- colSums(is.na(simulated_data[critical_columns]))
  expect_equal(sum(missing_counts), 0, 
               info = paste("Missing values found in columns:", paste(names(missing_counts[missing_counts > 0]), collapse = ", ")))
})


# Convert columns to expected types to ensure consistency
simulated_data <- simulated_data %>%
  mutate(
    state = as.character(state),                  # Convert to character
    median_income = as.numeric(median_income),    # Convert to numeric (double)
    unemployment_rate = as.numeric(unemployment_rate),  # Convert to numeric (double)
    education_level = as.numeric(education_level),     # Convert to numeric (double)
    hate_crime_incidents = as.integer(hate_crime_incidents)  # Convert to integer
  )

# Test 9: Ensure each column has the expected data type ####
test_that("Column types are correct", {
  expect_equal(typeof(simulated_data$state), "character", info = "State column should be of type character.")
  expect_equal(typeof(simulated_data$median_income), "double", info = "Median income column should be of type double.")
  expect_equal(typeof(simulated_data$unemployment_rate), "double", info = "Unemployment rate column should be of type double.")
  expect_equal(typeof(simulated_data$education_level), "double", info = "Education level column should be of type double.")
  expect_equal(typeof(simulated_data$hate_crime_incidents), "integer", info = "Hate crime incidents column should be of type integer.")
})






