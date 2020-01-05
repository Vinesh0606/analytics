library(dplyr)
data_adult <-read.csv("E:/rWork/rProjects/analytics/adult.csv")
View(data_adult)

data_adult[ data_adult == "?" ] <- NA
da1 <- data_adult[complete.cases(data_adult), ]  # create copy
str(da1)
summary(da1)
View(da1)


continuous <-select_if(da1, is.numeric)
summary(continuous)
 

library(ggplot2)
ggplot(continuous, aes(x = hours.per.week)) +
  geom_density(alpha = .2, fill = "#FF6666")


top_one_percent <- quantile(data_adult$hours.per.week, .99)
top_one_percent

data_adult_drop <-da1 %>%
  filter(hours.per.week<top_one_percent)
dim(data_adult_drop)
View(data_adult_drop)


data_adult_rescale <- data_adult_drop %>%
  mutate_if(is.numeric, funs(as.numeric(scale(.))))
head(data_adult_rescale)


factor <- data.frame(select_if(data_adult_rescale, is.factor))
ncol(factor)
library(ggplot2)

graph <- lapply(names(factor),
                function(x) 
                  ggplot(factor, aes(get(x))) +
                  geom_bar() +
                  theme(axis.text.x = element_text(angle = 90)))

graph

recast_data <- data_adult_rescale %>%
  select(-x) %>%
  mutate(education = factor(ifelse(education == "Preschool" | education == "10th" | 
                                     education == "11th" | education == "12th" | 
                                     education == "1st-4th" | education == "5th-6th" | 
                                     education == "7th-8th" | education == "9th", "dropout", 
                                   ifelse(education == "HS-grad", "HighGrad",
                                          ifelse(education == "Some-college" | 
                                                   education == "Assoc-acdm" | 
                                                   education == "Assoc-voc", "Community",
                                                 ifelse(education == "Bachelors", "Bachelors",
                                                        ifelse(education == "Masters" | 
                                                                 education == "Prof-school", "Master", "PhD")))))))

recast_data %>%
  group_by(education) %>%
  summarize(average_educ_year = mean(educational.num),
            count = n()) %>%
  arrange(average_educ_year)


recast_data <- recast_data %>%
  mutate(marital.status = factor(ifelse(marital.status == "Never-married" | 
                                          marital.status == "Married-spouse-absent", "Not_married", 
                                        ifelse(marital.status == "Married-AF-spouse" | 
                                                 marital.status == "Married-civ-spouse", "Married", 
                                               ifelse(marital.status == "Separated" | 
                                                        marital.status == "Divorced", "Separated", "Widow")))))

table(recast_data$marital.status)


ggplot(recast_data, aes(x = gender, fill = income)) +
  geom_bar(position = "fill") +
  theme_classic()


ggplot(recast_data, aes(x = race, fill = income)) +
  geom_bar(position = "fill") +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90))


ggplot(recast_data, aes(x = gender, y = hours.per.week)) +
  geom_boxplot() +
  stat_summary(fun.y = mean,
               geom = "point",
               size = 3,
               color = "steelblue") +
  theme_classic()


View(recast_data)
trainDataIndex <- sample(1:nrow(recast_data),0.7*nrow(recast_data), replace = F)
trainData <-recast_data[trainDataIndex, ]
testData <- recast_data[-trainDataIndex, ]
View(trainData)
View(testData)


table(trainData$income)


logit <- glm(income~., data = trainData, family = 'binomial')
summary(logit)

logit <- glm(income~
               age+workclass+education+educational.num+
               marital.status+ 
               gender+hours.per.week, data = trainData, family = 'binomial')
summary(logit)


testData$income <- ifelse(testData$income == ">50K", 1, 0)


testData$Pred_Income <- predict(logit,testData,type =c("response"))
View(testData)
table(testData$income)/nrow(testData)


quantile(testData$Pred_Income, probs = seq(0,1,0.05))
table(testData$income)

testData$Pred_Income <- ifelse(testData$Pred_Income > 0.405,1,0)
View(testData)


table(testData$Pred_Income)/nrow(testData)
table_mat<-table(testData$Pred_Income,testData$income)
table_mat

accuracy_Test <- sum(diag(table_mat)) / sum(table_mat)
accuracy_Test

