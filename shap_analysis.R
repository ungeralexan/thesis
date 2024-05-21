#SHAP analysis


#lets explain our predictions with TreeSHAP
unified_model = ranger.unify(original_model,train[-14])

#use package treeshap: https://cran.r-project.org/web/packages/treeshap/index.html
shaps <- treeshap(unified_model,  train[-14] , interactions = TRUE) # If interactions are set TRUE it might take a bit
shp = shapviz(shaps, X=train) # for visualization better then the default plots https://cran.r-project.org/web/packages/shapviz/index.html


###############Global scale
#SHAP importance plots
png("importance.png", width = 1600, height = 1200, res = 150)
sv_importance(shp)
dev.off()

#importance with numerical values
png("importance_num.png", width = 1600, height = 1200, res = 150)
sv_importance(shp, show_numbers = TRUE)
dev.off()

#beeswarm plots
png("importance_bee.png", width = 1600, height = 1200, res = 150)
sv_importance(shp, kind="bee")
dev.off()


#original importance plot provided by the treeshap package
png("original_importance.png", width = 1600, height = 1200, res = 150)
plot_feature_importance(shaps, max_vars = 13)
dev.off()



#######SHAP dependece plots

#For mean_population

#Using auto will automatically select the feature it determines has the highest dependency.
png("dependnece_pop.png", width = 1600, height = 1200, res = 150)
sv_dependence(shp, v = "mean_population", color_var = "auto", interactions = TRUE)
dev.off()

png("dependnece_pop.png", width = 1600, height = 1200, res = 150)
sv_dependence(shp, v = "mean_population", color_var = "median_income", interactions = TRUE)
dev.off()

png("dependnece_pop.png", width = 1600, height = 1200, res = 150)
sv_dependence(shp, v = "mean_population", color_var = "mean_rooms", interactions = TRUE)
dev.off()

#mean rooms feature
png("dependnece_rooms.png", width = 1600, height = 1200, res = 150)
sv_dependence(shp, v = "mean_rooms", color_var = "auto", interactions = TRUE)
dev.off()
#There may be a slight trend indicating that, for a steady level of rooms, higher income yields higher SHAP values.


png("dependnece_rooms.png", width = 1600, height = 1200, res = 150)
sv_dependence(shp, v = "mean_rooms", color_var = "inland", interactions = TRUE)
dev.off()
#clear interactions with the binary inland feature

png("dependnece_rooms.png", width = 1600, height = 1200, res = 150)
sv_dependence(shp, v = "mean_rooms", color_var = "mean_population", interactions = TRUE)
dev.off()
#clear interactions with the binary inland feature





#median income feature
png("dependnece_income.png", width = 1600, height = 1200, res = 150)
sv_dependence(shp, v = "median_income", color_var = "auto", interactions = TRUE)
dev.off()

png("dependnece_income.png", width = 1600, height = 1200, res = 150)
sv_dependence(shp, v = "median_income", color_var = "inland", interactions = TRUE)
dev.off()

png("dependnece_income.png", width = 1600, height = 1200, res = 150)
sv_dependence(shp, v = "median_income", color_var = "mean_population", interactions = TRUE)
dev.off()



#inland just for testing
png("dependnece_inland.png", width = 1600, height = 1200, res = 150)
sv_dependence(shp, v = "inland", color_var = "auto", interactions = TRUE)
dev.off()

 



#real feature dependence plots provided by the TreeSHAP package instead of shapviz
png("dependnece_incomereal.png", width = 1600, height = 1200, res = 150)
plot_interaction(shaps, "median_income", "inland")
dev.off()

png("dependnece_roomreal.png", width = 1600, height = 1200, res = 150)
plot_interaction(shaps, "mean_rooms", "inland")
dev.off()

png("dependnece_longreal.png", width = 1600, height = 1200, res = 150)
plot_interaction(shaps, "longitude", "inland")
dev.off()


#Local analysis
# for observation three
png("waterfallt.png", width = 1600, height = 1200, res = 150)
sv_waterfall(shp,row_id = 7)
dev.off()

png("waterfallt.png", width = 1600, height = 1200, res = 150)
sv_waterfall(shp,row_id = 12)
dev.off()

#Once again from the orginal SHAP package
png("waterfallte.png", width = 1600, height = 1200, res = 150)
plot_contribution(shaps, obs = 12, min_max = c(0, 300000))
dev.off()



####
#Force plots
#The force plot is another useful visualization tool,
#but I haven't used it in this analysis as I believe the waterfall plots provide more insights.
sv_force(shp,row_id = 3)










