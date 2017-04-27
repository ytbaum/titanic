# read in the training data, testing data, and submission files
train <- read.csv("train.csv")
test <- read.csv("test.csv")
submission.table <- read.csv("gender_submission.csv")

# load packages
library(tidyverse)

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
