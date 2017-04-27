# read in the training data, testing data, and submission files
train <- read.csv("train.csv")
test <- read.csv("test.csv")
submission.table <- read.csv("gender_submission.csv")

# randomly generate a prediction for each passenger we have to predict for
num.predictions <- nrow(submission.table)
predictions <- rbinom(num.predictions, 1, 0.8)
submission.table$Survived <- predictions

write.csv(submission.table, "submission.csv")
#hi doods