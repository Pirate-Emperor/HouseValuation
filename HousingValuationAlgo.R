library(dplyr)
library(ggplot2)
library(caret)
library(randomForest)
library(e1071)
library(MASS)
library(rpart)
library(tidyverse)
library(lmtest)

file_path <- "Affordable_Housing_by_Town_2011-2023.csv" 
data <- read.csv(file_path)
print(head(data))
summary(data)
str(data)
missing_vals <- sapply(data, function(x) sum(is.na(x)))
print("Missing Values:")
print(missing_vals)
data_clean <- na.omit(data)
data_clean <- data_clean %>% mutate_if(is.character, as.factor)
numerical_columns <- names(select_if(data_clean, is.numeric))
categorical_columns <- names(select_if(data_clean, is.factor))
for (col in numerical_columns) {
  print(ggplot(data_clean, aes_string(x = col)) + 
    geom_histogram(binwidth = 10, fill = "blue", color = "black") + 
    ggtitle(paste("Histogram of", col)) +
    theme_minimal())
}
cor_matrix <- cor(select_if(data_clean, is.numeric), use = "complete.obs")
print(cor_matrix)
pairs(select_if(data_clean, is.numeric), pch = 19, col = "blue")
generate_combinations <- function(features) {
  combn(features, m = 2, simplify = FALSE)
}
set.seed(123)
train_index <- createDataPartition(data_clean[[numerical_columns[1]]], p = 0.8, list = FALSE)
train_data <- data_clean[train_index, ]
test_data <- data_clean[-train_index, ]
results <- list()
model_algorithms <- c("lm", "rpart", "randomForest", "svmLinear")
for (model_type in model_algorithms) {
  print(paste("Running model:", model_type))
  for (comb in generate_combinations(c(numerical_columns, categorical_columns))) {
    predictor_cols <- comb
    target_col <- setdiff(numerical_columns, predictor_cols)   
    if (length(target_col) == 0) {
      next
    }     
    formula_str <- paste(target_col, "~", paste(predictor_cols, collapse = "+"))
    formula <- as.formula(formula_str)   
    model <- train(formula, data = train_data, method = model_type, trControl = trainControl(method = "cv", number = 5)) 
    predictions <- predict(model, test_data)   
    model_performance <- postResample(predictions, test_data[[target_col]])
    print(paste("Performance for", model_type, "with predictors", paste(predictor_cols, collapse = ", "), ":"))
    print(model_performance)        
    results[[paste(model_type, paste(predictor_cols, collapse = ", "), sep = "_")]] <- model_performance
  }
}
best_model <- which.min(sapply(results, function(res) res["RMSE"]))
print("Best model:")
print(names(best_model))
print(results[[best_model]])
results_df <- do.call(rbind, lapply(results, as.data.frame))
write.csv(results_df, "model_performance_results.csv")
