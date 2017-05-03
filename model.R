# read in the training data, testing data, and submission files
library(dismo)
train <- read.csv("train.csv")
test <- read.csv("test.csv")
submission.table <- read.csv("gender_submission.csv")



# Replacing random prediction for a logistic model
logit.model <- glm(Survived ~ Pclass*Sex*Age*SibSp*Parch+Fare+Embarked,data=train,family=binomial) # That was number of interactions I could pull up before crashing R.
logit.simplified <- step(logit.model) # simplifying the model using stepwise model selection

#Testing the model
prob.train <- predict(logit.simplified,type="response")
model.test <- evaluate(p=prob.train[train$Survived],a=prob.train [!train$Survived]) # Models AUC is 0.1160. The AUC from random choice is 0.5, so this model is horrible!
pred.survival <- prob.train > c(threshold(model.test)[2])

write.csv(submission.table, "submission.csv", row.names = FALSE, quote = FALSE)