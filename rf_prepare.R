####### File 1


#1)  Preparing the the Data for "model_one" and "visualize_improve" Files



#clearing the workspace
rm(list=ls())

#Loading necessary libraries
library(tidyverse)
library(dplyr)
library(reshape2)
library(caret)
#read in the data set from kaggle : https://www.kaggle.com/datasets/camnugent/california-housing-prices 
#or from my github page : https://github.com/ungeralexan/thesis


#Reading the dataset
house = read.csv("housing.csv")

#Initial Data Inspection
head(house)



#Checking for missing observations
sum(is.na(house))
#there are 207 observations where we detect missing entries 


#to locate where the missing observations are, a function called countNas was created
countNAs <- function(data) {
  na_count <- sapply(data, function(y) sum(length(which(is.na(y)))))
  return(na_count)
}


na_counts <- countNAs(house)
print(na_counts) #shows which columns have missing values and the extent


#handling missing values (omit the rows as the dataset size is already large enough)
house = na.omit(house)

#check the data distribution 
summary(house)
#- Income ranges from 0.5 to 15
#- Median house value includes some very valuable houses
#- Housing median age includes some old properties


#######################
# Extracting features for visualization
# Store 'ocean_proximity' as a separate feature for visualization
ocean_feature = house$ocean_proximity
ocean_feature = as.data.frame(ocean_feature) #store it as frame
#Drop 'ocean_proximity' for distribution analysis
drop_for_distributions =  c('ocean_proximity')
distributions = house[ , !(names(house) %in% drop_for_distributions)]
distributions = as.data.frame(distributions)
# Check that all the remaining features are numeric
str(distributions) 
#######################

#######
# One-Hot-Encoding the 'ocean_proximity' feature
house$ocean_proximity <- as.factor(house$ocean_proximity)
dummies <- dummyVars(~ ocean_proximity, data = house)
house_encoded <- predict(dummies, newdata = house)
house_encoded <- as.data.frame(house_encoded)

# Combine the encoded features with the numerical features
house <- cbind(house, house_encoded)

# Drop the original 'ocean_proximity' feature as it is now encoded
drop_vector <- c('ocean_proximity')
house <- house[ , !(names(house) %in% drop_vector)] #drop the old featzre
############




#Feature engineering and data transformation

#creating new features

# Calculate average population per household
house$mean_population = house$population/house$households 

# Calculate average number of bedrooms per household
house$mean_bedrooms = house$total_bedrooms/house$households 

# Calculate average number of rooms per household
house$mean_rooms = house$total_rooms/house$households 

# Dropping redundant features
drop_again = c('total_bedrooms', 'total_rooms', 'population')

house = house[ , !(names(house) %in% drop_again)] # updates the housing dataframe to keep only the columns not listed in drops.

# check the updated data frame
head(house) 




# The dataframe for the analysis will be called df
df = house 

#Rename teh columns resulting from one-hot encoding for better readability
new_column_names <- c("lessoneOcean", "inland","island", "nearBay", "nearOcean")

colnames(df)[7:11] <- new_column_names


# Specify the desired column order based on actual column names
desired_order <- c('nearBay', 'lessoneOcean', 'inland', 'nearOcean',
                   'island', 'longitude', 'latitude', 'housing_median_age', 'households', 'median_income',
                   'mean_population', 'mean_bedrooms', 'mean_rooms', 'median_house_value')

# Reorder the dataframe columns
df <- df[, desired_order]