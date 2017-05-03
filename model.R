# read in the training data, testing data, and submission files
train <- read.csv("train.csv")
test <- read.csv("test.csv")
submission.table <- read.csv("gender_submission.csv")

##########
# randomly generate a prediction for each passenger we have to predict for
num.predictions <- nrow(submission.table)
<<<<<<< HEAD
predictions <- rbinom(num.predictions, 1, 0.8)
=======
predictions <- rbinom(num.predictions, 1, 0.2)
>>>>>>> c32d675fd036123d67c66f08e42af3fe1cdc2df2
submission.table$Survived <- predictions

write.csv(submission.table, "submission.csv", row.names = FALSE, quote = FALSE)