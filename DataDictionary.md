# Data Dictionary for Affordable Housing by Town (2011-2023)

## Column Descriptions

- **Town**: Name of the town where the property is located.

- **Year**: Year of the record.

- **Median Price**: Median housing price for the respective year in dollars.

- **Population**: Total population of the town.

- **Area**: Geographical area of the town in square miles.

- **Average Income**: Average income of residents in the town (in dollars).

- **School Quality**: Rating of the school quality.
  
  | Value  | Description                             |
  |--------|-----------------------------------------|
  | 1      | Poor                                   |
  | 2      | Fair                                   |
  | 3      | Average                                |
  | 4      | Good                                   |
  | 5      | Excellent                               |

- **Crime Rate**: Rating indicating the crime rate.
  
  | Value  | Description                             |
  |--------|-----------------------------------------|
  | 1      | Very High                              |
  | 2      | High                                   |
  | 3      | Average                                |
  | 4      | Low                                    |
  | 5      | Very Low                               |

## Additional Notes

- **Missing Values**: Ensure to handle any missing values appropriately during data preprocessing.
- **Data Types**: 
  - **Town**: Character
  - **Year**: Integer
  - **Median Price**: Numeric
  - **Population**: Numeric
  - **Area**: Numeric
  - **Average Income**: Numeric
  - **School Quality**: Categorical (factor)
  - **Crime Rate**: Categorical (factor)