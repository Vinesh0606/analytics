# comment to explain your code
mtcars #control + enter
?mtcars
?mean
class(mtcars)
summary(mtcars) # summary of the table data
str(mtcars)
table(mtcars$gear)
table(mtcars$vs)
table(mtcars$cyl)
table(mtcars$mpg, mtcars$disp)
table(mtcars$cyl, mtcars$gear, dnn= c("cyl","gear"))
