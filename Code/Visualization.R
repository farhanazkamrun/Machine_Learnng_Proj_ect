install.packages("readr")
# Load required packages
library(ggplot2)
library(readr)
library(dplyr)
library(tidyr)

# Step 1: Load CSV files
results_df <- read_csv("D:/ML/Energy_Prediction/data/results.csv")        # Cross-validated metrics
confusion_df <- read_csv("D:/ML/Energy_Prediction/data/confusion.csv")  # Hold-out test confusion metrics

# Step 2: Reshape results.csv for visualization
results_long <- results_df %>%
  pivot_longer(cols = -Model, names_to = "Metric", values_to = "Score") %>%
  mutate(Score = Score * 100)  # Convert to percentage for consistency

# Step 3: Visualize cross-validated metrics
ggplot(results_long, aes(x = Model, y = Score, fill = Metric)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.8)) +
  labs(title = "Cross-Validated Performance Metrics by Model",
       x = "Model", y = "Score (%)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Step 4: Reshape confusion_df for test metrics visualization
confusion_metrics <- confusion_df %>%
  select(Model, `Accuracy (%)`, `Precision (%)`, `Recall (%)`, `F1-Score (%)`) %>%
  pivot_longer(cols = -Model, names_to = "Metric", values_to = "Score")

# Step 5: Visualize hold-out test performance metrics
ggplot(confusion_metrics, aes(x = Model, y = Score, fill = Metric)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.8)) +
  labs(title = "Hold-Out Test Metrics by Model",
       x = "Model", y = "Score (%)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# Step 6: Visualize confusion matrix counts
confusion_counts <- confusion_df %>%
  select(Model, TP, FP, TN, FN) %>%
  pivot_longer(cols = -Model, names_to = "Type", values_to = "Count")

ggplot(confusion_counts, aes(x = Model, y = Count, fill = Type)) +
  geom_bar(stat = "identity", position = "dodge") +
  labs(title = "Confusion Matrix Counts per Model",
       x = "Model", y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

