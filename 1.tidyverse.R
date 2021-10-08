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
