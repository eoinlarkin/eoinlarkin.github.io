library(ggplot2)
library(forecast)


data("AirPassengers")

# Through the end of 1956, but no months in 1957
air_train <- window(AirPassengers, end = 1956+11/12)

# everything in 1957 and on
air_test  <- window(AirPassengers, start = 1957)

n_test <- length(air_test)

# //////////////////////////////////////////////////////////////////////////////

# Fit model to first few years of AirPassengers data
air_model <- auto.arima(air_train)

# So we get an Arima model back
air_model
#> Series: air_train 
#> ARIMA(1,1,0)(1,1,0)[12] 
#> 
#> Coefficients:
#>           ar1     sar1
#>       -0.2250  -0.2274
#> s.e.   0.1076   0.1081
#> 
#> sigma^2 estimated as 92.5:  log likelihood=-304.98
#> AIC=615.97   AICc=616.27   BIC=623.22

# You can look at the "performance", but this is the in sample performance
# i.e. it is computing performance using the data that it was fit with
accuracy(air_model)
#>                     ME     RMSE      MAE       MPE     MAPE      MASE
#> Training set 0.4424643 8.834477 6.351387 0.1376786 2.870884 0.2174955
#>                     ACF1
#> Training set 0.003854251

# Its an "Arima" object
class(air_model)
#> [1] "ARIMA" "Arima"

# //////////////////////////////////////////////////////////////////////////////


# We could do "multistep" forecasts for as many days are in the test set
# This repeatedly feeds the predicted data point back into the prediction
# equation to get the next prediction
library(fabletools)

air_multi_forecast <- air_model %>%
  forecast(h = n_test)

air_multi_forecast %>%
  forecast::autoplot()


library(fabletools)
library(ggplot2)

fdeaths %>% 
  fabletools::forecast() %>% 
  autoplot() + geom_text(show.legend = FALSE)


fdeaths %>% 
  forecast()

d.arima <- forecast::auto.arima(AirPassengers)
autoplot(forecast::forecast(d.arima, h = 10))
autoplot(forecast::forecast(d.arima, level = c(85), h = 10))
autoplot(forecast::forecast(d.arima, h = 5), conf.int = FALSE, is.date = FALSE)
autoplot(forecast::forecast(stats::HoltWinters(UKgas), h = 10))
