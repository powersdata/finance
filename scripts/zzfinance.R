library(fPortfolio)
data = SPISECTOR.RET
head(data)
library(PerformanceAnalytics)
data <- load("data/20160603dna.rda")
data2015 <- window(data, start=as.Date("2015-01-01"), end=as.Date("2015-12-31"))
databd <- window(Stocks)


pdf("summary2006.pdf")
charts.PerformanceSummary(databd)
dev.off()

library(tseries)

res <- portfolio.optim(data)
portfolio <- res$pw

barplot(portfolio, names.arg = names(data), col="#6699cc")

#barchart with percentages
eps <- 0.02
portfolio[which(portfolio<eps)] = 0
portfolio <- portfolio/sum(portfolio)

ylim_max <- max(ceiling(portfolio*10)/10)+0.1
portfolio_bar <- barplot(portfolio, names.arg = names(data), ylim =c(0, ylim_max), col = "#6699cc")
text(x=portfolio_bar, y=portfolio+par("cxy")[2], round(portfolio,4)*100, xpd=TRUE)

pie(portfolio)

library(quantmod)

getSymbols("IBM")
getSymbols("SPLK")
getSymbols("ORCL")
getSymbols("CVLT")
getSymbols("HPQ")
getSymbols("QLIK")
getSymbols("DATA")

portfolio_big_data <- c("IBM", "SPLK", "ORCL", "CVLT", "HPQ", "QLIK", "DATA", "MSTR")
StartDate <- as.Date("2015-01-01")

Stocks = lapply(portfolio_big_data, function(sym) {
        dailyReturn(na.omit(getSymbols(sym, from=StartDate, auto.assign=FALSE)))
})


do.call(merge.xts, Stocks)


ticker <- stocks
mean = c()
sd = c()
var005 = c()
var001 = c()
cvar005 = c()
i <- 1
for (t in ticker) {
        mean = c(mean, mean(data[,i]))
        sd = c(sd, sd(data[,i]))
        var005 = c(var005, quantile(data[,i], 0.05))
        var001 = c(var001, quantile(data[,i], 0.01))
        cvar = mean(sort(data[,i])[1:round(length(data[,i])*0.05)])
        cvar005 = c(cvar005, cvar)
        i = i + 1
}

risk_report <- data.frame(portfolio_big_data, mean, sd, var005, var001, cvar005)
names(risk_report) = c("Symbol", "Mean(1y)", "SD (1y)", "Var (0.05)", "CVar (0.05)")
write.csv2(risk_report, file = "risk_report.csv")

