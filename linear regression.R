library(DAAG)
data(ais)
ais
levels(ais$sex)

library(dplyr)
data = filter(ais,sex=="m")
data       
str(data)
summary(data)

library(ggplot2)
ggplot(data,aes(hg,hc))+geom_point()+geom_smooth()
par(mfrow=c(1,2))
boxplot(data$hc)
boxplot(data$hg)

plot(density(data$hc),main = "density plot = hc")
plot(density(data$hg),main = "density plot = hg")

library(ggplot2)
ggplot(data,aes(hc))+geom_histogram(bind=15)
ggplot(data,aes(hg))+geom_histogram(bins = 15)


cor(data$hg,data$hc)

lm1 = lm(hc~hg,data) 
lm1
summary(lm1)

set.seed(1234)
rowind = sample(1:nrow(data),0.8*nrow(data))
train = data[rowind,]
test = data[-rowind,]


train_lm = lm(hc~hg,train)
predit = predict(train_lm,test) 
cbind(test$hc,predit,resid(train_lm))


library(Metrics)
mape(test$hc,predit)

val = data.frame(hg = c(19,20,15))
predict(train_lm,val)
par(mfrow= c(2,2))

plot(train_lm)   
