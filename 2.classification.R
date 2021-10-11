rm(list = ls())

# install mlr3 package
if(!require(mlr3))
  install.packages("mlr3")
if(!require(mlr))
  install.packages("mlr")

library(mlr3)
library(mlr) #older version - used in the book
library(tidyverse)

data(diabetes, package = "mclust")
dbTib <- as_tibble(diabetes)
dbTib

summary(dbTib)

ggplot(dbTib, aes(glucose, insulin, shape = class, col = class)) +
  geom_point() +
  theme_bw() 
ggplot(dbTib, aes(glucose, sspg, col = class)) +
  geom_point() +
  theme_bw()
ggplot(dbTib, aes(insulin, sspg, col = class)) +
  geom_point() +
  theme_bw()

# define the task
task_diabetes <- makeClassifTask(data = dbTib, target = "class")

# define the learner
listLearners()$class
listLearners("classif")$class
listLearners("regr")$class
listLearners("cluster")$class

knn <- makeLearner("classif.knn", par.vals = list("k" = 2))
knn

# train the model
knnModel <- train(knn, task_diabetes)
knnModel
knnPred <- predict(knnModel, newdata = dbTib)
knnPred
performance(knnPred, measures = list(mmce, acc))

# holdout cross-validation
holdout <- makeResampleDesc(method = "Holdout", split = 2/3, stratify = TRUE)
holdoutCV <- mlr::resample(learner = knn, task = task_diabetes, 
                           resampling = holdout, measures = list(mmce, acc))
calculateConfusionMatrix(holdoutCV$pred, relative = TRUE)

# k-fold cross-validation