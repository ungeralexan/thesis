# this script is independent from rf_prepare
#Here we observe the distributions of the varibales
# and calculate the correlations before and after feature engineering
library(ggplot2)





#what abou the categorial Ocean Proximity variable
# Calculating the frequency of each category
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





#now plot the map 
library(leaflet)


coords= df %>% select(longitude,latitude)

themap = coords %>%
  as.matrix() %>%
  leaflet() %>%
  addTiles() %>%
  addCircleMarkers(radius = 1)

#show the map
themap


#create one plot to show all the histograms
png("distributions_num.png", width = 1600, height = 1200, res = 150)
ggplot(data = melt(distributions), mapping = aes(x = value)) + 
  geom_histogram(bins = 50) + facet_wrap(~variable, scales = 'free_x')
dev.off()

#now lets do a correlation analysis with this data 
#we will be using the Spearman correlation as there is no clear normal distribution visible
cor_one_variables = distributions
cor_matrix <- cor(cor_one_variables, method="spearman")  # or use method="spearman" if the data is not normally distributed

library(corrplot)
# Visualize the correlation matrix
png("spearman_one.png", width = 1600, height = 1200, res = 150)
corrplot(cor_matrix, method="number", type="lower")
dev.off()

#correlations two
#check the correlations among the acomodation variables, only for me
corr_accom <- cor_one_variables[, !names(cor_one_variables) %in% c("longitude", "latitude", "housing_median_age", "median_income", "median_house_value")]

cor_matrix_sec <- cor(corr_accom, method="spearman")  # or use method="spearman" if the data is not normally distributed

png("corr_accom.png", width = 1600, height = 1200, res = 150)
corrplot(cor_matrix_sec, method="number", type="lower")
dev.off()




#for the next visualization 
drops_3 = c('nearBay', 'lessoneOcean', 'inland', 'nearOcean','island')
house_num =  df[ , !(names(df) %in% drops_3)] #updates housing_num to include only the columns not listed in drops_1. This leaves you with a dataset of purely numerical features without the target variable.



#now lets calculate the correlations for our new features to see whether we effectively reduced correlations
#we will be using the Spearman correlation as there is no clear normal distribution visible
cor_newvar = house_num
cor_matrix <- cor(cor_newvar, method="spearman")  # or use method="spearman" if the data is not normally distributed

library(corrplot)
# Visualize the correlation matrix
png("spearman_two.png", width = 1600, height = 1200, res = 150)
corrplot(cor_matrix, method="number", type="lower")
dev.off()

