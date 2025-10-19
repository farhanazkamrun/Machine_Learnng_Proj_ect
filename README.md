 # Household Energy Consumption Prediction

This project focuses on predicting household energy consumption using machine learning. Worked through raw data, cleaned and prepared it, and then applied classification models to generate useful insights.

## 📌 What This Project Is About
A real-world dataset to explore energy usage patterns and built models to predict consumption levels. The goal was to not just build models, but understand what drives energy usage and how to make sense of that data. Primary preprocessing and data visualization was done in R, which was then used in a Python-based machine learning workflow.

## 🛠️ What I Did
- Cleaned and preprocessed messy data
- Handled missing values, and feature selection
- Trained classification models using scikit-learn
- Compared models using evaluation metrics like accuracy, precision, recall, and F1 score.
- Visualized results with R language

## 📂 Dataset
The dataset used is `Preprocessed_Energy_Classification.csv`, which includes cleaned and feature-selected data for household energy classification.  
Original preprocessing steps (missing value imputation, outlier handling, feature selection) were performed in R and Python.

Source of the original dataset: [Kaggle - Energy Consumption Prediction](https://www.kaggle.com/datasets/mrsimple07/energy-consumption-prediction)

## 📈 Results (Model Performance)
The following table summarizes the average cross-validated performance metrics of each model:

| Model                | Accuracy | Precision | Recall | F1-Score | ROC-AUC |
|----------------------|----------|-----------|--------|----------|---------|
| K-Nearest Neighbors  | 0.7813   | 0.7869    | 0.7807 | 0.7800   | 0.8377  |
| Decision Tree        | 0.7813   | 0.7807    | 0.7891 | 0.7815   | 0.7811  |
| Random Forest        | 0.7894   | 0.7979    | 0.7768 | 0.7849   | 0.8530  |
| AdaBoost             | 0.7894   | 0.7952    | 0.7809 | 0.7859   | 0.8686  |
| XGBoost              | 0.7490   | 0.7817    | 0.6998 | 0.7347   | 0.8322  |

👉 Full evaluation data is available in `results.csv` and `confusion.csv`. Further improvements can be made by applying hyperparameter tuning or exploring more advanced feature engineering.

## 📊 Tools & Technologies
- **Language**: Python, R
- **Platform**: Google Colab (cloud-based Jupyter notebook)
- **Data Handling**: Pandas, NumPy
- **Outlier Detection**: SciPy (z-score)
- **Machine Learning**: Scikit-learn, XGBoost
- **Model Evaluation**: Cross-validation, Confusion Matrix, Accuracy, Precision, Recall, F1-score, ROC-AUC
- **Storage**: Google Drive (for loading/saving datasets and results)

## 💡 Why This Matters
With a passion for transforming raw data into actionable insights, this project allowed me to tackle a real-world challenge and apply data science techniques that have practical value in everyday situations.
