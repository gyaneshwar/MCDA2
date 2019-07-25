
library(xts)
library(forecast)
library(tseries)

#getwd()

setwd('C:/Users/Meghashyam/Desktop')

#Loading daily, hourly and 15minute interval data
data_daily <- read.csv("dayWithDate.csv", na.strings=c("","NA"), header = FALSE)
data_hourly <- read.csv("hourly.csv", na.strings=c("","NA"), header = FALSE)
data_min <- read.csv("15minutes.csv", na.strings=c("","NA"), header = FALSE)


# Taking just the 2014 data
data_hourly_2014 <- data_hourly[26296:35061,,]
data_min_2014 <- data_min[105181:140244,]

#converting the data to vectors
data_daily <- data_daily[,2]
data_hourly <- data_hourly[,1]
data_min <- data_min[,1]





# converting the data to time series
daily_ts <- ts(as.vector(data_daily), start=c(2011,1) , frequency=365.25)
hourly_ts <- ts(as.vector(data_hourly), start=c(2011,1), frequency=8766)
min_ts <- ts(as.vector(data_min), start=c(2011,1), frequency=35064)


hourly_ts_2014 <- ts(as.vector(data_hourly_2014), start=c(2014,1), frequency=8766)
min_ts_2014 <- ts(as.vector(data_min_2014), start=c(2014,1), frequency=35064)
  
plot.ts(daily_ts)
plot.ts(hourly_ts_2014)
plot.ts(min_ts_2014)

#test for stationarity
adf.test(daily_ts)
#adf.test(hourly_ts)
#adf.test(min_ts)
adf.test(hourly_ts_2014)
adf.test(min_ts_2014)

#identifying auto-correlation
acf(daily_ts, lag.max = 25)
pacf(daily_ts, lag.max = 25)


acf(hourly_ts_2014, lag.max = 50)
pacf(hourly_ts_2014, lag.max = 50)


acf(min_ts_2014, lag.max = 96)
pacf(min_ts_2014, lag.max = 96)



plot(stl(daily_ts,s.window="periodic"))
plot(stl(hourly_ts,s.window="periodic"))
plot(stl(min_ts,s.window="periodic"))



# Using Auto.Arima
daily_res = auto.arima(daily_ts, stepwise = F, approximation = F)
#hourly_res = auto.arima(hourly_ts, stepwise = F, approximation = F)
#min_res= auto.arima(min_ts, stepwise = F, approximation = F)

hourly_res_2014 = auto.arima(hourly_ts_2014, stepwise = F, approximation = F )
min_res_2014 = auto.arima(min_ts_2014, stepwise = F, approximation = F )

#Auto.Arima results - Daily
daily_res
mean(100*abs(fitted(daily_res) - daily_ts)/daily_ts)

#Auto.Arima results - Hourly - 2014
hourly_res_2014
mean(100*abs(fitted(hourly_res_2014) - hourly_ts_2014)/hourly_ts_2014)

#Auto.Arima results - 15 minutes - 2014
min_res_2014
mean(100*abs(fitted(min_res_2014) - min_ts_2014)/min_ts_2014)


# Your Arima error - daily
ar <- Arima(daily_ts,order=c(4,0,7))
mean(100*abs(fitted(ar) - daily_ts)/daily_ts)
summary(ar)


# Your Arima error - hourly 2014
ar <- Arima(hourly_ts_2014,order=c(10,1,11))
mean(100*abs(fitted(ar) - hourly_ts_2014)/hourly_ts_2014)
summary(ar)



# Your Arima error - min 2014
ar <- Arima(min_ts_2014,order=c(3,1,7))
mean(100*abs(fitted(ar) - min_ts_2014)/min_ts_2014)
summary(ar)




