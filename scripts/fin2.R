# load package quantmod
require("quantmod")

# create a list of all ticker symbols from the DJIA (composition as of December 2012)
portfolio_big_data <- c("IBM", "SPLK", "ORCL", "CVLT", "HPQ", "QLIK", "DATA", "MSTR")

# select ticker symbols and time frame
stocks <- portfolio_big_data
date_begin <- as.Date("2015-01-01")
date_end <- as.Date("2016-02-26")

# retrive data of all stocks
tickers <- getSymbols(stocks, from=date_begin, to=date_end, auto.assign=TRUE)

# combine the adjusted close values in one (xts) data.frame
dataset <- Ad(get(tickers[1]))
for (i in 2:length(tickers)) { dataset <- merge(dataset, Ad(get(tickers[i]))) }

# handle NA values (four common alternatives)
data_omit <- na.omit(dataset) # omit values with NA values
data_locf <- na.locf(dataset) # last observation carried forward
data_approx <- na.approx(dataset) # linear approximation
data_spline <- na.spline(dataset) # cubic spline interpolation

# calculate returns
return_lag <- 5 # (crude) weekly returns
data <- na.omit(ROC(data_spline, return_lag, type="discrete"))
names(data) <- stocks

# check returns
head(data)
tail(data)

# save data as RData
save(data, file="djia2012w.rda")