#performance test (on plots)
#some plotting options for performance
# Calculating residuals
residuals <- predictions - actuals

# Plotting residuals
ggplot(data = data.frame(Actuals = actuals, Residuals = residuals), aes(x = Actuals, y = Residuals)) +
  geom_point(alpha = 0.5) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "red") +
  labs(title = "Residuals Plot", x = "Actual House Values", y = "Residuals") +
  theme_minimal()

#residual plot is normally distributed
ggplot(data = data.frame(Residuals = residuals), aes(x = Residuals)) +
  geom_histogram(bins = 30, fill = "blue", color = "black") +
  labs(title = "Histogram of Residuals", x = "Residuals", y = "Frequency") +
  theme_minimal()

#predictions vs actuals
ggplot(data = data.frame(Actuals = actuals, Predictions = predictions), aes(x = Actuals, y = Predictions)) +
  geom_point(alpha = 0.4) +
  geom_abline(slope = 1, intercept = 0, color = "red", linetype = "dashed") +
  labs(title = "Predictions vs Actuals", x = "Actual House Values", y = "Predicted House Values") +
  theme_minimal()
















#performance test (MAE)
##############################
# Extra analysis to assess how good my model is 
# Calculate and print summary statistics for median house values
summary_stats <- summary(cleaned_housing$median_house_value)
print(summary_stats)


# Calculate mean and median of the house values
mean_value_mae <- mean(cleaned_housing$median_house_value)
median_value_mae <- median(cleaned_housing$median_house_value)

# Calculate MAE as a percentage of mean and median
mae_percentage_mean <- (MAE / mean_value_mae) * 100
mae_percentage_median <- (MAE / median_value_mae) * 100

print(paste("MAE as a percentage of the mean: ", round(mae_percentage_mean, 2), "%"))
print(paste("MAE as a percentage of the median: ", round(mae_percentage_median, 2), "%"))

# Calculate errors
errors <- predictions - actuals

# Plot error distribution
hist(errors, breaks = 50, main = "Distribution of Prediction Errors", xlab = "Prediction Error")
#############