##### Script 5

#Analyzing distributions and correlations
# package necessary for plotting
library(ggplot2)





# Analyzing Categorical feature: Ocean Proximity
# We start by examining the frequency distribution of the categorical feature ocean_proximity.
category_counts <- table(ocean_feature)
category_data <- as.data.frame(category_counts)
names(category_data) <- c("Category", "Frequency")

png("ocean_prox.png", width = 1600, height = 1200, res = 150)
# Creating the bar plot with labels
ggplot(category_data, aes(x = Category, y = Frequency, fill = Category)) +
  geom_bar(stat = "identity", color = "black", show.legend = FALSE) + # "identity" to use actual frequencies
  geom_text(aes(label = Frequency), vjust = -0.3, color = "black", size = 3.5) + # Adding text labels on bars
  scale_fill_brewer(palette = "Set1") + # Different colors for each category
  labs(title = "Frequency of Categories in Ocean Proximity",
       x = "Ocean Proximity Categories",
       y = "Frequency") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) # Improve x-axis label readability
dev.off()





# now plot the map 
# We visualize the geographic distribution of the properties using the leaflet package.

#load the necessary package
library(leaflet)

# Extract the coordinates
coords= df %>% select(longitude,latitude)

#Create the map
themap = coords %>%
  as.matrix() %>%
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(radius = 1)

#show the map
themap


# Analyzing the Distributions of numerical features

#create the plot to show all the histograms
png("distributions_num.png", width = 1600, height = 1200, res = 150)
ggplot(data = melt(distributions), mapping = aes(x = value)) + 
  geom_histogram(bins = 50) + facet_wrap(~variable, scales = 'free_x')
dev.off()


# Correlation analysis
#we will be using the Spearman correlation as there is no clear normal distribution visible

## Initial correlation analysis
# Calculate the Spearman correlation matrix
cor_one_variables = distributions
cor_matrix <- cor(cor_one_variables, method="spearman")  

#Load the necessary packages
library(corrplot) 
# Visualize the correlation matrix
png("spearman_one.png", width = 1600, height = 1200, res = 150)
corrplot(cor_matrix, method="number", type="lower")
dev.off()

# Correlation Analysis for Accommodation Variables
# Check the correlations among the accommodation variables
corr_accom <- cor_one_variables[, !names(cor_one_variables) %in% c("longitude", "latitude", "housing_median_age", "median_income", "median_house_value")]

cor_matrix_sec <- cor(corr_accom, method="spearman")  

# Visualize the correlation matrix for accommodation variables
png("corr_accom.png", width = 1600, height = 1200, res = 150)
corrplot(cor_matrix_sec, method="number", type="lower")
dev.off()


# Correlation Analysis After Feature Engineering

# Prepare the dataset with numerical features only
drops_3 = c('nearBay', 'lessoneOcean', 'inland', 'nearOcean','island')
house_num =  df[ , !(names(df) %in% drops_3)] #updates housing_num to include only the columns not listed in drops_1. This leaves you with a dataset of purely numerical features.



# Calculate the Spearman correlation matrix for new features
cor_newvar = house_num
cor_matrix <- cor(cor_newvar, method="spearman")  


# Visualize the correlation matrix for ne features
png("spearman_two.png", width = 1600, height = 1200, res = 150)
corrplot(cor_matrix, method="number", type="lower")
dev.off()

