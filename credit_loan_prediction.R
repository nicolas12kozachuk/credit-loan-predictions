# load and read in data
data <- data.frame(read.csv("C:/Users/nkoza/Downloads/state_GA_actions_taken_1-3.csv"))

# display first 6 data entries and prints the number of entries(rows)
head(data)
nrow(data)
# Identify columns with more than 50% missing values
high_missing <- colnames(data)[colMeans(is.na(data) | data == "") > 0.5]
print("Columns with more than 50% missing values:")
print(high_missing)

# Remove columns with more than 50% missing values
data <- data[, !(names(data) %in% high_missing)]
#install.packages("caret")
#install.packages("randomForest")
# Select relevant features based on domain knowledge
relevant_features <- c("loan_amount", "income", 
                       "property_value", "hoepa_status", "lien_status", "loan_type", 
                       "loan_purpose", "applicant_credit_score_type","purchaser_type","occupancy_type","lei","derived_msa.md","ffiec_msa_md_median_family_income","business_or_commercial_purpose")

# Handle missing and infinite values in numerical features
numerical_features <- names(data)[sapply(data, is.numeric)]
for (feature in numerical_features) {
  data[[feature]] <- as.numeric(as.character(data[[feature]]))
  data[[feature]][is.infinite(data[[feature]]) | is.na(data[[feature]])] <- median(data[[feature]], na.rm = TRUE)
}

# Add back the target variable
relevant_features <- c(relevant_features, "action_taken")

# Create a new dataset with selected features
clean_data <- data[, relevant_features]

# Print the selected features
print("Selected features:")
print(relevant_features)

# Remove rows with missing values in the selected features
clean_data <- na.omit(clean_data)

print(paste("Final number of rows:", nrow(clean_data)))
print(paste("Final number of features:", ncol(clean_data)))

# Convert action_taken to factor
clean_data$action_taken <- as.factor(clean_data$action_taken)
library(caret)      
library(randomForest) 

set.seed(123)  # For reproducibility

# Convert action taken variable from int to factor
clean_data$action_taken <- as.factor(clean_data$action_taken)

clean_data <- clean_data[!is.na(clean_data$action_taken), ]

# Randomly shuffle the data
clean_data<-clean_data[sample(nrow(clean_data)),]

# Create 10 equally size folds for cross validation
folds <- cut(seq(1,nrow(clean_data)),breaks=10,labels=FALSE)

# Initialize an empty confusion matrix
overall_confusion <- matrix(0, nrow = length(unique(clean_data$action_taken)), 
                            ncol = length(unique(clean_data$action_taken)))

# Initialize empty vector to hold accuracies for each cross validation run
accuracies <- c() 

# Perform 10-fold cross-validation
for(i in 1:10) {
    # Segments data by fold 
    testIndexes <- which(folds == i, arr.ind = TRUE)
    testData <- clean_data[testIndexes, ]
    trainData <- clean_data[-testIndexes, ]
    
    # Build a Random Forest model to predict 'action_taken'
    rf_model <- randomForest(action_taken ~ ., data = trainData, ntree = 100, importance = TRUE)
    
    # Test the model on test data
    predictions <- predict(rf_model, newdata = testData)
    
    # Calculate confusion matrix for this fold
    cm <- confusionMatrix(predictions, testData$action_taken)$table
    
     # Calculate accuracy for each fold
    fold_accuracy <- sum(diag(cm)) / sum(cm)
    accuracies <- c(accuracies, fold_accuracy)
    
    # Add the confusion matrix of this fold to the overall confusion matrix
    overall_confusion <- overall_confusion + cm
}
# Print the overall confusion matrix after the loop
print(overall_confusion)

# Calculate the accuracy from the confusion matrix
accuracy <- sum(diag(overall_confusion)) / sum(overall_confusion)

# Print the accuracy
print(paste("Overall Accuracy:", accuracy))
writeLines("\n")

for(i in 1:10){
  print(paste("Cross Validation", i, "accuracy: ",  round(accuracies[i],4)))
}

# Get detailed confusion matrix results
cm_results <- confusionMatrix(predictions, testData$action_taken)

# Print Precision, Recall, and F1-score
print(cm_results$byClass[5])  
print(cm_results$byClass[6])  
print(cm_results$byClass[7])  
varImpPlot(rf_model, cex = 0.5)
