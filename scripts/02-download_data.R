#### Preamble ####
# Purpose: Downloads Hate Crimes dataset from FiveThirtyEight
# Author: Yuxuan Wei
# Date: 13 November 2024
# Contact: shaw.wei@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - The `tidyverse` package must be installed and loaded
# Any other information needed? This downloads the dataset from a GitHub repository.

#### Workspace setup ####
library(tidyverse)

#### Download data ####
raw_data <-
  read_csv(
    file = 
      "https://raw.githubusercontent.com/fivethirtyeight/data/master/hate-crimes/hate_crimes.csv",
    show_col_types = FALSE,
    skip = 0)

#### Save data ####
write_csv(x = raw_data, file = "data/01-raw_data/raw_data.csv")

