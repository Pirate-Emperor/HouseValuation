library(cluster)
library(corrplot)
library(ROCR)
library(caTools)
library(glmnet)
library(factoextra)

print("Feature Importance Analysis")
rf_model <- randomForest(as.formula(paste(numerical_columns[1], "~ .")), data = train_data)
importance <- importance(rf_model)
varImpPlot(rf_model, main = "Random Forest Feature Importance")
print("Lasso Regression Feature Selection")
x_train <- model.matrix(as.formula(paste(numerical_columns[1], "~ .")), train_data)[,-1]
y_train <- train_data[[numerical_columns[1]]]
lasso_model <- cv.glmnet(x_train, y_train, alpha = 1)
plot(lasso_model)
best_lambda <- lasso_model$lambda.min
coef(lasso_model, s = best_lambda)
print("K-means Clustering")
data_scaled <- scale(select_if(data_clean, is.numeric))
fviz_nbclust(data_scaled, kmeans, method = "wss")
kmeans_model <- kmeans(data_scaled, centers = 3)
fviz_cluster(kmeans_model, data = data_scaled)
print("Hierarchical Clustering")
dist_matrix <- dist(data_scaled)
hc_model <- hclust(dist_matrix)
plot(hc_model)
rect.hclust(hc_model, k = 3, border = 2:4)
if (length(categorical_columns) > 0) {
  print("Logistic Regression")
  bin_target <- categorical_columns[1] 
  glm_model <- glm(as.formula(paste(bin_target, "~ .")), family = binomial, data = train_data)
  summary(glm_model)
  glm_pred <- predict(glm_model, test_data, type = "response")
  pred <- prediction(glm_pred, test_data[[bin_target]])
  perf <- performance(pred, "tpr", "fpr")
  plot(perf, col = "blue", main = "ROC Curve")
}


print("Statistical Analysis")
if (length(categorical_columns) > 0) {
  for (col in numerical_columns) {
    aov_result <- aov(as.formula(paste(col, "~", categorical_columns[1])), data = data_clean)
    print(summary(aov_result))
  }
}
if (length(categorical_columns) > 1) {
  chi_test <- chisq.test(table(data_clean[[categorical_columns[1]]], data_clean[[categorical_columns[2]]]))
  print(chi_test)
}
for (col in numerical_columns) {
  t_test_result <- t.test(data_clean[[col]], mu = mean(data_clean[[col]]))
  print(paste("T-test for", col))
  print(t_test_result)
}
print("Interaction Terms Analysis")
interaction_formula <- as.formula(paste(numerical_columns[1], "~ .^2"))
interaction_model <- lm(interaction_formula, data = train_data)
summary(interaction_model)
par(mfrow = c(2, 2))
plot(interaction_model)
aic_value <- AIC(interaction_model)
bic_value <- BIC(interaction_model)
print(paste("AIC:", aic_value, "BIC:", bic_value))
pdf("analysis_results.pdf")
varImpPlot(rf_model, main = "Random Forest Feature Importance")
plot(lasso_model)
plot(hc_model)
rect.hclust(hc_model, k = 3, border = 2:4)
plot(perf, col = "blue", main = "ROC Curve")
plot(interaction_model)
dev.off()
