# Credit Loan Prediction Model

## Project Description

This project involves a **Credit Loan Prediction Model** developed as part of the DSCI 451 coursework. The model employs a **Random Forest classifier** to predict loan approvals while addressing fairness and ethical considerations. Through this project, we explored how biases in datasets can propagate through machine learning models, emphasizing the importance of fairness and accountability in AI applications. The experience underscored the potential negative real-world impacts of biased models on individuals and communities.

## Learning Experience

This project provided invaluable insights into:
1. **Bias in Datasets**:
   - The dataset exhibited significant biases, particularly against Black and Native Hawaiian applicants.
   - Addressing this bias required critical evaluation of feature selection and fairness metrics.

2. **Real-World Implications**:
   - Understanding how machine learning models can unintentionally perpetuate systemic inequalities.
   - Highlighting the ethical responsibility of data scientists to ensure models are fair and transparent.

3. **Fairness in AI**:
   - Application of fairness metrics, such as demographic parity, disparate impact, and equalized odds.
   - Exclusion of protected classes (e.g., race, sex, ethnicity) to reduce bias in predictions.

## Model Details

- **Algorithm**: Random Forest with 10-fold cross-validation.
- **Dataset**: Loan application data sourced from the U.S. CFPB (HMDA dataset).
- **Initial Dataset Size**: ~294,000 entries.
- **Final Dataset Size**: ~284,000 entries after preprocessing.
- **Features Used**: Includes loan amount, income, property value, loan type, and other financial factors while excluding protected classes.

## Key Metrics

| Metric          | Value   |
|------------------|---------|
| Precision        | 0.992   |
| Recall           | 0.990   |
| F1-Score         | 0.991   |
| Overall Accuracy | 98.59%  |

## Ethical Considerations

- **Bias Mitigation**: Protected classes such as race, sex, and ethnicity were excluded to avoid bias.
- **Awareness of Limitations**: Despite these efforts, the dataset itself exhibits historical biases, which could impact predictions.
- **Real-World Impact**: This project reinforced the understanding that unfair models can negatively affect individuals' access to opportunities.

## Revisions and Improvements

1. **Preprocessing**:
   - Removed columns with >50% missing data to retain more rows.
   - Excluded features containing protected class information.
2. **Feature Selection**:
   - Selected features based on domain knowledge and peer analysis.
   - Retained relevant financial and geographical attributes.
3. **Model Adjustments**:
   - Increased the number of trees from 10 to 100 for improved accuracy.
   - Conducted fairness checks using metrics such as demographic parity, disparate impact, and equalized odds.

## Results

- Improved accuracy from **97.73%** to **98.59%** after revisions.
- Fairness improvements by excluding protected attributes without sacrificing performance.

## Code Overview

The implementation is provided in the R Markdown file `credit_loan_prediction.Rmd` and includes:
1. **Data Cleaning**: Filters missing data and excludes protected classes.
2. **Model Training**:
   - Implements Random Forest with 10-fold cross-validation.
   - Compares performance metrics for different configurations.
3. **Fairness Analysis**: Evaluates demographic parity, disparate impact, and equalized odds metrics.
4. **Visualization**: Generates confusion matrices and performance graphs.

## Model Card

Key details about the model's use, training, and evaluation are summarized in the included **Model Card**.

## How to Run

1. Open the `credit_loan_prediction.Rmd` file in RStudio or a compatible editor.
2. Install required R packages, such as `randomForest`, `caret`, and `ggplot2`.
3. Knit the document to execute the code and generate results.

## Resources

- **Presentation**: [Credit Prediction Presentation](https://drive.google.com/file/d/19B9252yU5ykXUHfrNvzajzXy0VS2jwdt/view?usp=sharing)
- **Model Card**: Provided in the project files.

## Caveats

- The dataset is based on loan data from Georgia, U.S., and may not generalize well to other regions.
- The model is not intended for fully automated loan decisions.

## Reflection

This project was a profound learning experience in:
- Recognizing and addressing dataset bias.
- Developing models that align with ethical standards.
- Balancing accuracy and fairness to ensure equitable outcomes.

The lessons learned here will serve as a foundation for building responsible AI systems in the future.

---

For more details, refer to the presentation, model card, or codebase.
