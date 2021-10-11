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

