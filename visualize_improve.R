#more descriptive plots
#correlations for all features
matrixe <- cor(df, method="spearman")  # or use method="spearman" if the data is not normally distributed

png("all_corr.png", width = 1600, height = 1200, res = 150)
corrplot(matrixe, method="number", type="lower")
dev.off()





#SOme scatter plots
library(ggplot2)

# scatter plot income and house value
png("median_income.png", width = 1600, height = 1200, res = 150)
ggplot(df, aes(x = median_income, y = median_house_value)) +
  geom_point(alpha = 0.6) +
  theme_minimal() +
  labs(x = "Median_income", y = "Median House Value", title = "Scatter Plot of Feature vs. Median House Value")
dev.off()


#scatter income and house prices
png("income_rooms.png", width = 1600, height = 1200, res = 150)
ggplot(df, aes(x = median_income, y = mean_rooms)) +
  geom_point(alpha = 0.6) +
  theme_minimal() +
  labs(x = "Median_income", y = "Mean Rooms", title = "Scatter Plot of Feature vs. Median House Value")
dev.off()

#scatter longitude and latitude
png("long_lat.png", width = 1600, height = 1200, res = 150)
ggplot(df, aes(x = longitude, y = latitude)) +
  geom_point(alpha = 0.6) +
  theme_minimal() +
  labs(x = "longitude", y = "latitude", title = "Scatter Plot of Feature vs. Median House Value")
dev.off()


# clustering for median house value prices
png("long_lat_mhv.png", width = 1600, height = 1200, res = 150)
ggplot(df, aes(x = longitude, y = latitude, color = median_house_value)) +
  geom_point(alpha = 0.6) +  # Adjust alpha for better visibility if needed
  scale_color_gradient(low = "blue", high = "red", name = "Median House Value") +  # Color gradient from blue to red
  theme_minimal() +
  labs(x = "Longitude", y = "Latitude", title = "Scatter Plot of Housing Prices Across Geographic Coordinates") +
  theme(legend.position = "right")  # Adjust legend position as needed
dev.off()


# clustering for income in several blocks
png("long_lat_income.png", width = 1600, height = 1200, res = 150)
ggplot(df, aes(x = longitude, y = latitude, color = median_income)) +
  geom_point(alpha = 0.6) +  # Adjust alpha for better visibility if needed
  scale_color_gradient(low = "blue", high = "red", name = "Median Income") +  # Color gradient from blue to red
  theme_minimal() +
  labs(x = "Longitude", y = "Latitude", title = "Scatter Plot of income Across Geographic Coordinates") +
  theme(legend.position = "right")  # Adjust legend position as needed
dev.off()


# clustering for house age in several blocks
png("long_lat_age.png", width = 1600, height = 1200, res = 150)
ggplot(df, aes(x = longitude, y = latitude, color = housing_median_age)) +
  geom_point(alpha = 0.6) +  # Adjust alpha for better visibility if needed
  scale_color_gradient(low = "blue", high = "red", name = "Median House Age") +  # Color gradient from blue to red
  theme_minimal() +
  labs(x = "Longitude", y = "Latitude", title = "Scatter Plot of Housing Age Across Geographic Coordinates") +
  theme(legend.position = "right")  # Adjust legend position as needed
dev.off()
