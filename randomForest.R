#Random Forest
#XG Boost
#loading the required packages
install.packages("randomForest")
library(randomForest)
library(MASS)
attach(Boston)
set.seed(101)

dim(Boston)
View(Boston)
#Seperating training and test series
#training Samples with 300 Obserbvations
train=sample(1:nrow(Boston),300)
?Boston
#Fitiing the random forest
Boston.rf=randomForest(medv~.,data=Boston,subset=train)
Boston.rf
#this plot shows the error and number of trees. we can easily notice that how the error is dropping as we keep on