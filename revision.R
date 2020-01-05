ns=200
(age= round(runif(n=ns,min=20, max=30)))
mean(age)
(gender = sample(x=c('M','F'), size=ns,replace=T, prob=c(.7,.3)))
table(gender)
(batch = sample (x=c('2017','2018','2019'), size=ns, replace=T, prob=c(.2,.3,.5)))
table(batch)  
(cgpa= round(rnorm(n=ns,mean=7,sd=.75),2))
range(cgpa)
(ug=round(rnorm(n=ns,mean=70,sd=5),2))
range(ug)  
(class12=round(rnorm(n=ns,mean=70,sd=7),2))
range(class12)
(domain=sample(c('Finance','HR','Operations','Marketing'),size=ns,replace=T))
students= data.frame(age,gender,batch,cgpa,ug,class12,domain)
head(students)
students$select=sample(c('Placed','Notplaced'), size=ns, replace=T,prob=c(.7,.3))
table(students$select)
(students$salary=round(rnorm(n=ns,mean=12,sd=1),2))
(students$salary=ifelse(students$select=='Notplaced', NA, students$salary))
head(students)
nrow(students)
table(students$domain)
table(students$batch)
table(students$batch, students$domain, students$gender)
hist(students$cgpa)
hist(students$cgpa, breaks=c(0, 6.5, 8.5, 10))
hist(students$age)
hist(students$age, breaks=c(20,24,26,30))


library(dplyr)
library(ggplot2)
t1<-students %>% group_by(gender) %>% summarize(meanAge=mean(age))
barplot(height=t1$meanAge)

ggplot(students, aes(x=gender, fill=gender))+geom_bar(stat='count')
ggplot(students, aes(x=gender, fill=gender))+geom_bar(stat='count')+geom_text(stat='count',aes(label=..count..))
ggplot(students, aes(x=domain, fill=gender))+geom_bar(stat='count')+geom_text(stat='count',aes(label=..count..))
ggplot(students, aes(x=batch, fill=gender))+geom_bar(stat='count')+geom_text(stat='count',aes(label=..count..))

ggplot(students, aes(x=batch, fill=domain))+geom_bar(stat='count')+geom_text(stat='count',aes(label=..count..), position = position_stack())

ggplot(students, aes(x=gender, fill=gender))+geom_bar(stat='count')+geom_text(stat='count',aes(label=..count..), position = position_stack(), vjust=1)+facet_grid(batch~domain)

ggplot(students, aes(x=cgpa))+geom_histogram()
ggplot(students, aes(x=cgpa))+geom_histogram(breaks=c(0,5,7,9,10), fill=1:4)
ggplot(students, aes(x=cgpa))+stat_bin(bins=5, fill=1:5)

ggplot(students, aes(x=gender, fill=gender))+geom_bar(stat='count')+geom_text(stat='count',aes(label=..count..))+facet_grid(batch~domain, scale='free')

students %>% group_by(batch,domain) %>% summarise(avgsal=mean(salary, na.rn=T))

students %>% filter(batch=='2018' & select=='Placed') %>% group_by(domain,gender)%>% summarise(meanSal=mean(salary)) %>% ggplot(., aes(x=domain, y=meanSal, fill=domain)) =geom_bar()
  
