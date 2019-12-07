# Logistic Regression
data(BreastCancer, package="mlbench")
View(BreastCancer)
bc <-BreastCancer
str(bc)
summary(bc)

bc1 <- BreastCancer[complete.cases(BreastCancer), ]  
str(bc1)
summary(bc1)
glm(Class ~ Cell.shape, family="binomial", data = bc1)

bc1 <- bc1[,-1]

for(i in 1:9) {bc1[, i] <- as.numeric(as.character(bc1[, i]))}
# When converting a factor to a numeric variable, you should always convert it to character and then to numeric, else, the values can get screwed up.

# Change Y values to 1's and 0's

(bc1$Class <- ifelse(bc1$Class == "malignant", 1, 0))
(bc1$Class <- factor(bc1$Class, levels = c(0, 1)))
