# Thesis: Shapley and SHAP Values to Explain Models for Regression

## Overview
This document provides detailed information on the structure of the project, the purpose of each file, and the sequence in which the scripts should be executed. It is designed to help you understand how the project is organized and how to reproduce the results.

## Thesis Project

### Data
- **housing.csv**: Contains the housing data for the random forest model.

### Scripts
- **rf_prepare.R**: R script for data preparation, feature engineering, etc.
- **model_one.R**: R script for the random forest analysis.
- **refine_model_2.R**: Script for the improved random forest.
- **visualizing.R**: R script for descriptives like correlations or distributions.
- **visualize_improve.R**: R script to explore some patterns in the data.

### SHAP Analysis
- **shap_analysis.R**: R script with the SHAP analysis.

## Required Libraries
The following R libraries need to be installed to run the scripts:

```R
library(tidyverse)
library(dplyr)
library(reshape2)
library(caret)
library(treeshap) # to apply the tree SHAP algorithm
library(ranger) # for the random forest model
library(shapviz) # for the SHAP visualization
library(ggplot2) # for plotting
library(corrplot)
library(leaflet)
```

## Step 1: Data Preparation
To start, run the rf_prepare.R script. This script performs the following tasks:
* Check for Missing Values: Identifies and removes any rows with missing values to ensure the dataset is clean and ready for analysis.
* One-Hot Encoding: Converts the ocean_proximity categorical feature into numerical format using one-hot encoding. This transformation is essential for the Random Forest model to process categorical data.
* Feature Engineering: Introduces three new features to enhance the dataset

## Step 2 : Fitt the random forest model
In order to run the ranger function with the set seed the rf_prepare.R need to be sourced in:

```R
source("rf_prepare.R")


