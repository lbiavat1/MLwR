rm(list = ls())

library(tidyverse)

# tibbles
myTib <- tibble(x = 1:4, 
                y = c("london", "beijing", "las vegas", "berlin"))
myTib

# converting data.frame into tibble
mydf <- data.frame(x = 1:4, 
                   y = c("london", "beijing", "las vegas", "berlin"))

dfToTib <- as_tibble(mydf)
dfToTib

data("starwars")
starwars

data(mtcars)
mtcars
mtcars <- as_tibble(mtcars)
mtcars

# select() all columns except qsec & vs
sel <- mtcars %>% select(!c(qsec, vs))
sel

fil <- mtcars %>% filter(cyl != 8)
ex <- mtcars %>% group_by(gear) %>% summarise(medianMPG = median(mpg), medianDisp = median(disp)) %>%
  mutate(newVar = medianMPG/medianDisp)

# use ggplot2
myPlot <- ggplot(mtcars, aes(x = drat, y = wt, col = carb)) +
  geom_point() +
  theme_bw()
myPlot

data(iris)
irisPlot <- ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, col = Species)) +
  geom_point() +
  theme_bw()
irisPlot +
  geom_density2d() +
  geom_smooth() +
  facet_wrap(~ Species)

# make tidy what's untidy

# untidy tibble: each row contains all the observations made on that patient
ptData <- tibble(Patient = c("A", "B", "C"),
                 Month0 = c(21, 17, 29),
                 Month3 = c(20, 21, 27),
                 Month6 = c(21, 22, 23))
ptData

tidyptData <- gather(ptData, key = Month, 
                     value = BMI, -Patient)
# convert to wide format
spread(tidyptData, key = Month, value = BMI)

# gather vs, am, gear, carb variables from mtcars into a single key-value pair
mtcars
gathermtcars <- gather(mtcars, key = "variable", value = "value", c(vs, am, gear, carb))

# purrr

mtcars
map_dbl(mtcars, sum)
map_lgl(mtcars, ~sum(.) > 100)
map_lgl(mtcars, function(.) sum(.) > 100)

listOfNumerics <- list( a = rnorm(10),
                        b = rnorm(100),
                        c = rnorm(1000))
par(mfrow = c(1,3))

# walk() - apply a function to each element of a list to produce the function's side effects
walk(listOfNumerics, hist)

# iwalk() - makes name/index of each element available. 
# use .x to reference the list element and .y to reference its name/index
iwalk(listOfNumerics, ~ hist(.x, main = .y))

# iterating over multiple lists simultaneously

multipliers <- list(0.5, 10, 3)

map2(.x = listOfNumerics, .y = multipliers, ~.x * .y)

# use pmap()
args <- expand.grid(n = c(1000, 10000, 1000000),
                    mean = c(1),
                    sd = c(0.1, 1, 10))
args
par(mfrow = c(3,3))

pmap(args, rnorm) %>%
  iwalk(~hist(.x, main = paste("Element", .y, sep = "_")))
