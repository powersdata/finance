#morningstar
select.source <- "ms"
setwd(directory)
source("scripts/1001libraries.R")
source("scripts/1005functions.R")
source("scripts/1010imports.R")

#Browser Initialization
#source("scripts/1104rselenium.R")
MS_Web_Setup()
MS_Login("####")

period <- c("qtr", "yr")
report <- c("IS", "CF", "BS")
stocks <- c("HOLX", "FMI", "BIO", "MYGN", "QGEN")

#download from ms for year
for (j in report) {
        for (k in stocks) {
                MS_Download(Stock = k, Type = j, Period = "yr")
        }
}

#Cut files from download directory and move to data/ms/spreadsheets/yr
#Download from ms for qtr
for (j in report) {
        for (k in stocks) {
                MS_Download(Stock = k, Type = j, Period = "qtr")
        }
}

#Cut files from download directory and move to data/ms/spreadsheets/qtr

#import files after copying to proper directory
for (i in period) {
        for (j in report) {
                for (k in stocks) {
                        MS_Import(Stock = k, Type = j, Period = i)
                }
        }
}

#import ratios


