
#Forecasting with a Moving Average & ES
#library
library(tidyverse)      # data manipulation and visualization
library(lubridate)      # easily work with dates and times
library(fpp2)           # working with time series data
library(zoo)            # working with time series data
library(TTR)            # Moving Avg
data(economics)
head(economics)
tail(economics)
class(economics)
colSums(is.na(economics))
names(economics)
?economics

#see the example for psavert : personal savings rate,
#then perform similar operations for unemploy : number of unemployed in thousands,
#Moving average values : 3 months - Left Aligned
ts1_ma3L <- economics %>%  select(date, srate = psavert) %>%  mutate(srate_tma = rollmean(srate, k = 3, fill = NA, align = "left"))
rbind(head(ts1_ma3L),tail(ts1_ma3L))

#Moving average values : 3 months - Center Aligned
ts1_ma3C <- economics %>%  select(date, srate = psavert) %>%  mutate(srate_tma = rollmean(srate, k = 3, fill = NA, align = "center"))
rbind(head(ts1_ma3C),tail(ts1_ma3C))
#Moving average values : 3 months - Right Aligned
ts1_ma3R <- economics %>%  select(date, srate = psavert) %>%  mutate(srate_tma = rollmean(srate, k = 3, fill = NA, align = "right"))
rbind(head(ts1_ma3R),tail(ts1_ma3R))
#convert to time series
ts1 <- ts(economics$psavert, c(1967,7), frequency = 12)
ts1
range(ts1)
#moving average
ts1_ma3 <- TTR::SMA(ts1, n=3)
ts1_ma3
#window of data
(year2010 = window(ts1, start=c(2010,1), end=c(2010,12)))
#forecast for next 3 periods using SMA-3
ts1_ma3 %>% na.omit() %>% forecast::forecast(h=3)
#Expnonential Smoothening
ts1_es = TTR::EMA(ts1)
ts1_es
forecast::forecast(ts1_es,3)  #errors due to missing values
ts1_es %>% na.omit() %>% forecast::forecast(h=3)
#Create Time Series from zoo library
library(zoo)
ts2 <- zoo(economics$psavert, order.by = economics$date)
head(ts2)
ts2
#plot
plot(ts2)
ts2

#Perform for unemploy : number of unemployed in thousands,
#....
ts1_ma3L <- economics %>%  select(date, srate = unemploy) %>%  mutate(srate_tma = rollmean(srate, k = 3, fill = NA, align = "left"))
rbind(head(ts1_ma3L),tail(ts1_ma3L))

#Moving average values : 3 months - Center Aligned
ts1_ma3C <- economics %>%  select(date, srate = unemploy) %>%  mutate(srate_tma = rollmean(srate, k = 3, fill = NA, align = "center"))
rbind(head(ts1_ma3C),tail(ts1_ma3C))
#Moving average values : 3 months - Right Aligned
ts1_ma3R <- economics %>%  select(date, srate = unemploy) %>%  mutate(srate_tma = rollmean(srate, k = 3, fill = NA, align = "right"))
rbind(head(ts1_ma3R),tail(ts1_ma3R))
#convert to time series
ts1 <- ts(economics$unemploy, c(1967,7), frequency = 12)
ts1
range(ts1)
#moving average
ts1_ma3 <- TTR::SMA(ts1, n=3)
ts1_ma3
#window of data
(year2010 = window(ts1, start=c(2010,1), end=c(2010,12)))
#forecast for next 3 periods using SMA-3
ts1_ma3 %>% na.omit() %>% forecast::forecast(h=3)
#Expnonential Smoothening
ts1_es = TTR::EMA(ts1)
ts1_es
forecast::forecast(ts1_es,3)  #errors due to missing values
ts1_es %>% na.omit() %>% forecast::forecast(h=3)
#Create Time Series from zoo library
library(zoo)
ts2 <- zoo(economics$unemploy, order.by = economics$date)
head(ts2)
ts2
#plot
plot(ts2)
ts2
