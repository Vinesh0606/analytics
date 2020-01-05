cars
head(cars)
lm= lm(dist~speed,cars)
lm

mtcars
lm2= lm(mpg~cyl+gear+carb, mtcars)
lm2
 summary(lm2)
plot(lm2) 

install.packages('caTools')
library(caTools)
