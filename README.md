# Socioeconomic Determinants of Hate Crimes in the United States

## Overview

This repository contains the code, data, and analysis used to examine the relationship between state-level socioeconomic factors and hate crimes in the United States. The analysis utilizes Bayesian hierarchical modeling to account for state-specific variability while investigating how factors such as income inequality, unemployment, education, and urbanization influence hate crime prevalence. The primary objective of this project is to identify key socioeconomic drivers of hate crimes and provide insights for targeted policy interventions.


## File Structure

The repo is structured as:

-   `data/00-simulated_data` contains simulated datasets for testing purposes.
-   `data/01-raw_data` contains the raw hate crimes dataset as obtained from [FiveThirtyEight](https://github.com/fivethirtyeight/data/tree/master/hate-crimes)
-   `data/02-analysis_data` contains the cleaned and preprocessed dataset used for analysis.
-   `model` contains the RDS file of the fitted models
-   `other` contains details about literature, LLM usage, supplementary materials, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage

The ChatGPT-4 model assisted in refining the writing of the Quarto document and some code snippets. The entire chat history is available in other/llm_usage/usage.txt.
