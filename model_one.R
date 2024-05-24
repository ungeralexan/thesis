####### File 2
# Source the preparation script
source("rf_prepare.R")

# Creates the first random forest model
# The SHAP analysis is based on this model


# Load necessary libraries
library(treeshap) #to apply the tree SHAP algorithm
library(ranger) #for the random forest model
library(shapviz) #for the shap visualisation
library(dplyr) #to do some data engineering
library(ggplot2) # for plotting




# Set a random seed so that same sample can be reproduced in future runs
set.seed(21000)

# Randomly sample indices for the training set
ix = sample(nrow(df), 0.7 * nrow(df))

# Create training and testing datasets
train = df[ix, ]
test = df[-ix, ]

#store train and test set as csv to ensure reproducibility (is not needed)
#write.csv(train, "train_data.csv", row.names = FALSE)
#write.csv(test, "test_data.csv", row.names = FALSE)

# Confirm that the total number of rows matches the original dataset
print(nrow(train) + nrow(test) == nrow(df))

# Building the random forest model
original_model <- ranger(
  formula = median_house_value ~ ., 
  data = train, 
  importance = "permutation", 
  max.depth = 4, 
  mtry = 4,
  num.trees = 500
)

# Check the performance of the model (Out-Of-Bag error and other metrics)
print(original_model)

# check feature importance
importance_ranger = original_model$variable.importance

# Look at the importance values
print(importance_ranger)




# Plotting feature importance
# Create a data frame for the plot
importance_df <- data.frame(Feature = names(importance_ranger), Importance = importance_ranger)

# Plotting 
png("Pfi.png", width = 1600, height = 1200, res = 150)
ggplot(importance_df, aes(x = reorder(Feature, Importance), y = Importance)) +
  geom_col() +
  coord_flip() +  # Flip to make it horizontal
  labs(title = "Feature Importance in Random Forest Model",
       x = "Features",
       y = "Importance") +
  theme_minimal()
dev.off()
# From the plot, it is evident that median_income is the most important feature.





######
#Evaluation of model performance on test set
#predictions for test data
testPred = predict(original_model, data = test)

#compare with the actual values
actuals <- test$median_house_value
predictions <- testPred$predictions

# calculate the mean squared error (MSE)
mse_rf = mean((predictions - actuals)^2)

# Output the RMSE value
test_rmse = sqrt(mse_rf)
test_rmse

