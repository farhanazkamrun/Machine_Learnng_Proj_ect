# Install and load required packages
packages <- c("readr", "writexl", "naniar", "modeest", "dplyr", "ggplot2", "zoo",
              "DMwR2", "caret", "ROSE", "tidyverse")
installed_packages <- rownames(installed.packages())
for (pkg in packages) {
  if (!(pkg %in% installed_packages)) {
    install.packages(pkg)
  }
}
lapply(packages, library, character.only = TRUE)

# Load the dataset
dataset <- read.csv("E:/archive (1)/Energy_consumption.csv")  # <- UPDATE PATH
cat("Dataset Loaded\n")
View(dataset)

#histogram
hist(dataset$EnergyConsumption, main="Energy Usage Distribution", xlab="Energy", col="skyblue")
hist(dataset$Temperature,main = "Temperature Distribution",xlab = "Temperature (°C)",col = "tomato",breaks = 30)
hist(dataset$Humidity,main = "Humidity Distribution",xlab = "Humidity (%)",col = "lightgreen",breaks = 30)

#boxplot
boxplot(dataset$EnergyConsumption, main="Energy Consumption Boxplot", col="lightblue")
boxplot(dataset$Temperature, main="Temperature Boxplot", col="tomato")
boxplot(dataset$Humidity, main="Humidity Boxplot", col="lightgreen")
boxplot(dataset$Occupancy, main="Occupancy Boxplot", col="orange")




# Check missing values
missing_values <- colSums(is.na(dataset))
missing_values[missing_values > 0]

# Visualize missing values
gg_miss_var(dataset)




# Handle outliers using IQR
fix_outliers <- function(df, col_name) {
  Q1 <- quantile(df[[col_name]], 0.25)
  Q3 <- quantile(df[[col_name]], 0.75)
  IQR_val <- IQR(df[[col_name]])
  lower <- Q1 - 1.5 * IQR_val
  upper <- Q3 + 1.5 * IQR_val
  median_val <- median(df[[col_name]])
  df[[col_name]][df[[col_name]] < lower | df[[col_name]] > upper] <- median_val
  return(df)
}
numeric_cols <- sapply(dataset, is.numeric)
for (col in names(dataset)[numeric_cols]) {
  dataset <- fix_outliers(dataset, col)
  cat(paste("Outliers fixed in", col, "\n"))
}

# Convert categorical columns to numeric
dataset$HVACUsage <- as.numeric(as.factor(dataset$HVACUsage))
dataset$LightingUsage <- as.numeric(as.factor(dataset$LightingUsage))
dataset$DayOfWeek <- as.numeric(as.factor(dataset$DayOfWeek))
dataset$Holiday <- as.numeric(as.factor(dataset$Holiday))

# Normalize numeric columns using Z-score
normalize_zscore <- function(x) {
  if (is.numeric(x)) {
    return((x - mean(x, na.rm = TRUE)) / sd(x, na.rm = TRUE))
  } else {
    return(x)
  }
}
normalize_cols <- c("Temperature", "Humidity", "SquareFootage", "Occupancy",
                    "RenewableEnergy", "EnergyConsumption")
dataset[normalize_cols] <- lapply(dataset[normalize_cols], normalize_zscore)

# Replace negative values with NA (if any)
for (col in names(dataset)) {
  if (is.numeric(dataset[[col]])) {
    dataset[[col]][dataset[[col]] < 0] <- NA
  }
}

# Refill NA using median
for (col in names(dataset)) {
  if (is.numeric(dataset[[col]]) && any(is.na(dataset[[col]]))) {
    median_val <- median(dataset[[col]], na.rm = TRUE)
    dataset[[col]][is.na(dataset[[col]])] <- median_val
  }
}

# Remove duplicate rows
dataset <- dataset[!duplicated(dataset), ]


# Split into train and test sets
set.seed(123)
index <- sample(seq_len(nrow(dataset)), size = 0.8 * nrow(dataset))
train_data <- dataset[index, ]
test_data <- dataset[-index, ]
cat("Train set size:", nrow(train_data), "\n")
cat("Test set size:", nrow(test_data), "\n")


# Save cleaned dataset
write.csv(dataset, "E:/archive (1)/Cleaned_Energy_Consumption.csv", row.names = FALSE)
