# read in the training data, testing data, and submission files
train <- read.csv("train.csv")
test <- read.csv("test.csv")
submission.table <- read.csv("gender_submission.csv")

# load packages
library(tidyverse)
library(caret)

##########
# data exploration - visualize data

ggplot(train) +
  geom_boxplot(aes(x = as.factor(Survived), y = Age))
# no clear difference when looking at overall trend

ggplot(train) +
  geom_boxplot(aes(x = as.factor(Survived), y = Fare))
# survivors seemed to have paid more

sub <- train %>% as_tibble %>%
  group_by(Pclass, Sex) %>%
  summarise(Survivors = sum(Survived),
            Total = n()) %>%
  mutate(survProb = Survivors/Total)

ggplot(sub) +
  geom_col(aes(x = as.factor(Pclass), y = survProb, fill = Sex),
           position=position_dodge())

ggplot(train) +
  geom_point(aes(x = Fare, y = Age, color = as.factor(Survived), shape = Sex)) +
  xlim(c(0, 300))

scales <- list(x=list(relation="free"), y=list(relation="free"))
vars <- train %>% select(Pclass, Age, Parch, Fare)
featurePlot(y = as.factor(train$Survived), x = vars, plot = "density", scales = scales)
#pink = survived, blue = died
#many babies survived, families survived more than single individuals,
#the lowest class/lowest fares died most, first class survived more