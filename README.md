<link rel="stylesheet" type="text/css" href="style.css">

<!-- 
Author: Pirate-Emperor
Date: [Insert Date]
Description: README file for BigData Pipeline project.
-->

# House Valuation

## Overview

The **House Valuation** project analyzes affordable housing data from 2011 to 2023, aiming to uncover insights and trends in housing values across various towns. The project utilizes various statistical and machine learning techniques to perform data analysis, model building, and feature selection.

## Data

The dataset used in this project is `Affordable_Housing_by_Town_2011-2023.csv`, which contains information about housing prices and related features across different towns. 

### Data Structure

The dataset includes the following columns:

- **Town**: The name of the town.
- **Year**: The year of the record.
- **Median Price**: The median housing price for the respective year.
- **Population**: The total population of the town.
- **Area**: The geographical area of the town in square miles.
- **Average Income**: The average income of residents in the town.
- **School Quality**: A rating of the school quality (categorical).
- **Crime Rate**: A rating indicating the crime rate (categorical).

### Data Source

This dataset is hypothetical and is designed for educational purposes to demonstrate data analysis techniques.

## Requirements

- R (version 4.0 or later)
- R libraries:
  - `dplyr`
  - `ggplot2`
  - `caret`
  - `randomForest`
  - `glmnet`
  - `cluster`
  - `corrplot`
  - `ROCR`
  - `factoextra`

## Installation

To install the required R packages, run the following commands in your R console:

```r
install.packages(c("dplyr", "ggplot2", "caret", "randomForest", "glmnet", "cluster", "corrplot", "ROCR", "factoextra"))
```

## Usage

1. **Load the Dataset**: Read the CSV file into R and inspect the data.
2. **Data Cleaning**: Perform data preprocessing, including handling missing values and converting data types.
3. **Exploratory Data Analysis (EDA)**:
   - Generate summary statistics.
   - Create visualizations to explore relationships between variables.
4. **Model Building**:
   - Split the dataset into training and testing sets.
   - Build predictive models (e.g., linear regression, random forest).
5. **Feature Importance Analysis**: Assess the importance of different features in predicting housing values.
6. **Clustering**: Apply clustering algorithms to identify groups within the data.
7. **Statistical Tests**: Perform statistical tests to assess relationships between variables.
8. **Results Visualization**: Generate plots for model diagnostics and feature importance.

## Code Explanation

### Data Preprocessing

```r
# Load Libraries
library(dplyr)

# Load Data
data <- read.csv("Affordable_Housing_by_Town_2011-2023.csv")

# Data Cleaning
data_clean <- data %>%
  filter(!is.na(Median_Price)) %>%  # Remove NA values
  mutate(School_Quality = as.factor(School_Quality),  # Convert to factor
         Crime_Rate = as.factor(Crime_Rate))
```

### Exploratory Data Analysis

```r
# Summary Statistics
summary(data_clean)

# Visualizations
library(ggplot2)

ggplot(data_clean, aes(x = Year, y = Median_Price, color = Town)) +
  geom_line() +
  labs(title = "Median Price by Year", x = "Year", y = "Median Price")
```

### Model Building

```r
# Train/Test Split
set.seed(123)
train_index <- createDataPartition(data_clean$Median_Price, p = 0.8, list = FALSE)
train_data <- data_clean[train_index, ]
test_data <- data_clean[-train_index, ]

# Linear Regression
linear_model <- lm(Median_Price ~ ., data = train_data)
summary(linear_model)
```

### Feature Importance

```r
# Random Forest
library(randomForest)

rf_model <- randomForest(Median_Price ~ ., data = train_data)
importance(rf_model)
varImpPlot(rf_model)
```

### Clustering

```r
# K-means Clustering
data_scaled <- scale(select_if(data_clean, is.numeric))
kmeans_model <- kmeans(data_scaled, centers = 3)
```

### Statistical Tests

```r
# ANOVA
aov_result <- aov(Median_Price ~ School_Quality, data = data_clean)
summary(aov_result)
```

## Results

The project will generate various visualizations and outputs, which will be saved in a PDF file named `analysis_results.pdf`. This document will include:

- Random Forest Feature Importance
- K-means Clustering Visualization
- Hierarchical Clustering Dendrogram
- ROC Curve for Logistic Regression
- T-test Results and ANOVA Summaries

## Conclusion

The **House Valuation** project provides insights into housing prices and their influencing factors through comprehensive data analysis and visualization techniques. This project serves as a foundational model for further research and exploration in housing valuation.

## Contributing

Feel free to fork the repository, make changes, and submit pull requests. Contributions are welcome!

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Author

**Pirate-Emperor**

[![Twitter](https://skillicons.dev/icons?i=twitter)](https://twitter.com/PirateKingRahul)
[![Discord](https://skillicons.dev/icons?i=discord)](https://discord.com/users/1200728704981143634)
[![LinkedIn](https://skillicons.dev/icons?i=linkedin)](https://www.linkedin.com/in/piratekingrahul)

[![Reddit](https://img.shields.io/badge/Reddit-FF5700?style=for-the-badge&logo=reddit&logoColor=white)](https://www.reddit.com/u/PirateKingRahul)
[![Medium](https://img.shields.io/badge/Medium-42404E?style=for-the-badge&logo=medium&logoColor=white)](https://medium.com/@piratekingrahul)

- GitHub: [Pirate-Emperor](https://github.com/Pirate-Emperor)
- Reddit: [PirateKingRahul](https://www.reddit.com/u/PirateKingRahul/)
- Twitter: [PirateKingRahul](https://twitter.com/PirateKingRahul)
- Discord: [PirateKingRahul](https://discord.com/users/1200728704981143634)
- LinkedIn: [PirateKingRahul](https://www.linkedin.com/in/piratekingrahul)
- Skype: [Join Skype](https://join.skype.com/invite/yfjOJG3wv9Ki)
- Medium: [PirateKingRahul](https://medium.com/@piratekingrahul)


---