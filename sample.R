#SAMPLE

set.seed(1234) # to get random numbers
sample(1:10)

letters[1:26]
sample(letters[1:26])

?sample
sample(x=letters[1-26], size=100, replace=T)

gender= c('m','f')
gender
sample(x=gender)
sample(x=gender, size=100) # error will come
sample(x=gender, size=100, replace=T)
x=sample(x=gender, size=100, replace=T)
x
table(x)

x2=sample(x=gender, size=1000, replace=T, prob=c(4,6))
table(x2)
prop.table(table(x2))

set.seed(1234)
course= c('mba', 'bba')
course
x3=sample(x=course)
x3
x3=sample(x=course, size=1000, replace=T, prob=c(6,4))
table(x3)
