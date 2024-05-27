##### Script 3

#Preparing for SHAP analysis


# Unify the model and data for TreeSHAP
unified_model = ranger.unify(original_model,train[-14])

# Compute SHAP values
#use package treeshap: https://cran.r-project.org/web/packages/treeshap/index.html
shaps <- treeshap(unified_model,  train[-14] , interactions = FALSE) 
shp = shapviz(shaps, X=train) # for visualization better than the default plots https://cran.r-project.org/web/packages/shapviz/index.html


############### Global interpretation
#SHAP importance plots
png("importance.png", width = 1600, height = 1200, res = 150)
sv_importance(shp)
dev.off()

#importance with numerical values
png("importance_num.png", width = 1600, height = 1200, res = 150)
sv_importance(shp, show_numbers = TRUE)
dev.off()

#beeswarm plot
png("importance_bee.png", width = 1600, height = 1200, res = 150)
sv_importance(shp, kind="bee")
dev.off()


#original importance plot provided by the treeshap package
png("original_importance.png", width = 1600, height = 1200, res = 150)
plot_feature_importance(shaps, max_vars = 13)
dev.off()



#######SHAP dependece plots

# Dependence plot for mean_population

#Using auto will automatically select the feature it determines has the highest dependency.
png("dependnece_pop.png", width = 1600, height = 1200, res = 150)
sv_dependence(shp, v = "mean_population", color_var = "auto", interactions = FALSE)
dev.off()

png("dependnece_pop.png", width = 1600, height = 1200, res = 150)
sv_dependence(shp, v = "mean_population", color_var = "median_income", interactions = FALSE)
dev.off()

png("dependnece_pop.png", width = 1600, height = 1200, res = 150)
sv_dependence(shp, v = "mean_population", color_var = "mean_rooms", interactions = FALSE)
dev.off()


# Dependence plot for mean_rooms
png("dependnece_rooms.png", width = 1600, height = 1200, res = 150)
sv_dependence(shp, v = "mean_rooms", color_var = "auto", interactions = FALSE)
dev.off()


png("dependnece_rooms.png", width = 1600, height = 1200, res = 150)
sv_dependence(shp, v = "mean_rooms", color_var = "inland", interactions = FALSE)
dev.off()
#clear interactions with the binary inland feature

png("dependnece_rooms.png", width = 1600, height = 1200, res = 150)
sv_dependence(shp, v = "mean_rooms", color_var = "mean_population", interactions = FALSE)
dev.off()





# Dependence plots for median income feature
png("dependnece_income.png", width = 1600, height = 1200, res = 150)
sv_dependence(shp, v = "median_income", color_var = "auto", interactions = FALSE)
dev.off()

png("dependnece_income.png", width = 1600, height = 1200, res = 150)
sv_dependence(shp, v = "median_income", color_var = "inland", interactions = FALSE)
dev.off()

png("dependnece_income.png", width = 1600, height = 1200, res = 150)
sv_dependence(shp, v = "median_income", color_var = "mean_population", interactions = FALSE)
dev.off()



# Dependence plots for inland just for testing
png("dependnece_inland.png", width = 1600, height = 1200, res = 150)
sv_dependence(shp, v = "inland", color_var = "auto", interactions = FALSE)
dev.off()

 




#Local interpretation
#Waterfall plots for specific observations

# for observation 7
png("waterfallt.png", width = 1600, height = 1200, res = 150)
sv_waterfall(shp,row_id = 7)
dev.off()

#for observation 12
png("waterfallt.png", width = 1600, height = 1200, res = 150)
sv_waterfall(shp,row_id = 12)
dev.off()

#Once again from the orginal SHAP package for observation 12
png("waterfallte.png", width = 1600, height = 1200, res = 150)
plot_contribution(shaps, obs = 12, min_max = c(0, 300000))
dev.off()



####
#Force plots
#The force plot is another useful visualization tool,
#but I haven't used it in this analysis as I believe the waterfall plots provide clearer insights.
sv_force(shp,row_id = 3)











