# Thesis: Shapley and SHAP Values for Feature Importance in House Price Predictions

## Overview
This document provides detailed information on the structure of the project, the purpose of each file, and the sequence in which the scripts should be executed. It is designed to help you understand how the project is organized and how to reproduce the results.

## Thesis Project

### Data
- **housing.csv**: Contains the housing data for the random forest model.

### Preparation Script
- **rf_prepare.R**: R script for data preparation, feature engineering, etc.

### Analysis Script
- **model_one.R**: R script that entails the random forest the SHAP analysis is build on.
- **refine_model_2.R**: R script for the more nuanced random forest model after the SHAP analysis.

### Scripts for descriptives and visualizations
- **visualizing.R**: R script for descriptives like correlations or distributions.
- **visualize_improve.R**: R script to explore some patterns in the data.

### SHAP Analysis
- **shap_analysis.R**: R script with the SHAP analysis, entails all the plots.

## Required Libraries
The following R libraries need to be installed to run the scripts:

```R
library(tidyverse)
library(dplyr)
library(reshape2)
library(caret)
library(treeshap) # to apply the tree SHAP algorithm
library(ranger) # for the random forest model
library(shapviz) # for nice SHAP visualizations
library(ggplot2) 
library(corrplot)
library(leaflet)
```

## Step 1: Data Preparation
To start, run the rf_prepare.R script. This script performs the following tasks:
* Check for Missing Values: Identifies and removes any rows with missing values to ensure the dataset is clean and ready for analysis.
* One-Hot Encoding: Converts the ocean_proximity categorical feature into numerical format using one-hot encoding. This transformation is essential to later gain more insights about how every category impacted the prediction in the SHAP analysis.
* Feature Engineering: Introduces three new features to enhance the dataset.
* It creates subsets of the dataset for the correlation analysis before feature engineering and after.

## Step 2 : Fitt the random forest model
The rf_prepare.R can also be sourced in in the model_one.R script. Once the rf_prepare.R script is run all the other scripts can be run.

```R
source("rf_prepare.R")
```
## Step 3 : Run the other scripts
After having executed the rf_prepare.R script, run the model_one.R script to perform the random forest analysis. This script will also evaluate the performance of the model. Proceed with the shap_analysis.R script to perform SHAP analysis. This reveals the most significant features influencing the model. Use the refine_model_2.R script to develop a second random forest model. This iteration uses a reduced set of features based on insights gained from the SHAP analysis. Visualization scripts can be executed at any stage to generate plots for descriptive statistics and correlation analysis. 




## Important note
The performance of the `ranger` function may exhibit minor variations across different devices. These variations can lead to similar, yet not identical, results. This behavior underscores observations made by the ranger authors and reflects inherent differences in computing environments.
For detailed discussions related to this issue, please refer to [this GitHub issue](https://github.com/imbs-hl/ranger/issues/533).

**Repository Development Environment:**
- **Created on**: MacBook Air, macOS Version 12.7.4, R Version 4.3.1 (2023-06-16).
- **Tested on Windows 11**: Using the same R version (4.3.1, released on 2023-06-16), the results differed slightly. This variation supports the assertions made by the ranger authors about potential differences in function performance across platforms.









