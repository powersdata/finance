#main functions
if (exists("select.source") == FALSE)
        select.source <- "main"

if (select.source == "main") {
        timer <- function(starttime) {
                x <- difftime(Sys.time(), starttime, units = "sec")
                x <- round(x, digits = 1)
                y <- paste("TIME:",x,"seconds")
                #assign("timelength",y,envir = .GlobalEnv)
                print(y)
        }
        
}

#ms functions
if (select.source == "ms") {
        ms.env <- new.env()
        MS_Download <- function(Stock, Type, Period){
# fileURL <- "http://financials.morningstar.com/income-statement/is.html?t=HOLX&region=USA&culture=en_US"
# fileURL <- "http://financials.morningstar.com/balance-sheet/bs.html?t=HOLX&region=usa&culture=en-US"
# fileURL <- "http://financials.morningstar.com/cash-flow/cf.html?t=HOLX&region=usa&culture=en-US"
#             http://financials.morningstar.com/cash-flow/cf.html?t=HOLX&region=usa&culture=en-US
                
                fileURL <- "http://financials.morningstar.com/"
                endURL <- "&region=USA&culture=en_US"
                type <- ifelse(Type == "IS",  "income-statement/is.html?t=", "balance-sheet/bs.html?t=")
                if (Type == "CF") type <- "cash-flow/cf.html?t="
                period <- ifelse(Period == "yr",  "Annual", "Quarterly")
                fileURL <- paste0(fileURL, type, Stock, endURL)
                mybrowser$navigate(fileURL)
                Sys.sleep(2)
                
                msTimeframe <- mybrowser$findElement(using = 'css selector', "#Li1")
                msTimeframe$clickElement()
                msSpan <- mybrowser$findElement(using = 'class', "prem1")
                msSpan$clickElement()
                Sys.sleep(2)
                
                msPeriod <- mybrowser$findElement(using = 'css selector', "#menu_A")
                msPeriod$clickElement()
                msPeriodli <- mybrowser$findElement(using = 'li', period)
                msPeriodli$clickElement()
                Sys.sleep(2)
       
                msbutton <- mybrowser$findElement(using = "class", "rf_export")
                msbutton$clickElement()
                Sys.sleep(2)
        }
        
        
        
        
        MS_Import <- function(Stock = c("PG", "IBM", "AAPL"),
                              Type = c("IS", "BS", "CF"),
                              Period = c("yr", "qtr")) {
                type <- ifelse(Type == "IS",  "Income Statement", "Balance Sheet")
                if (Type == "CF") {
                        type <- "Cash Flow"
                }
                filename <-
                        paste0("data/ms/spreadsheets/",Period,"/",Stock," ",type,".csv")
                
                if (file.exists(filename)) {
                        headers <-
                                c(
                                        "Desc", paste0(Period,"10"), paste0(Period,"9"), paste0(Period,"8"),paste0(Period,"7"), paste0(Period,"6"), paste0(Period,"5"), paste0(Period,"4"),paste0(Period,"3"), paste0(Period,"2"), paste0(Period,"1"), paste0(Period,"TTM")
                                )
                        datafile <- read.table(
                                file = filename, header = FALSE, sep = ",",
                                stringsAsFactors = FALSE, strip.white = TRUE,
                                fill = TRUE, quote = "\"", skip = 1,
                                col.names = headers
                        )
                        
                } else {
                        datafile <- print(paste0(filename, " Does not Exist!"))
                }
                
                assign(paste(Type, Stock, Period, sep = "_"), datafile, envir = .GlobalEnv)
                
                return(datafile)
                
        }
        
        MS_Login <- function(password){
                MS_Web_Setup()
                loginURL <- "https://www.morningstar.com/members/login.html?vurl="
                ms.env$mybrowser$navigate(loginURL)
                msEmail <- mybrowser$findElement(using = 'css selector', "#uEmail")
                msEmail$sendKeysToElement(list("ted@powersdata.com"))
                msP <- mybrowser$findElement(using = 'css selector', "#uPassword")
                msP$sendKeysToElement(list(password))
                msbutton <- mybrowser$findElement(using = "xpath", "//*/input[@ng-click = 'submit(user)']")
                msbutton$clickElement()
        }
        MS_Web_Setup <- function(){
                checkForServer()
                startServer()
                
                fprof <- getFirefoxProfile("C:/Users/Ted/AppData/Roaming/Mozilla/Firefox/Profiles/wlb50pz5.WebDriver_Profile", useBase = TRUE)
                assign("fprof", getFirefoxProfile("C:/Users/Ted/AppData/Roaming/Mozilla/Firefox/Profiles/wlb50pz5.WebDriver_Profile", useBase = TRUE), envir = as.environment(ms.env) )
                mybrowser <- remoteDriver(extraCapabilities = fprof)
                assign("mybrowser", remoteDriver(extraCapabilities = ms.env$fprof), envir = as.environment(ms.env))
                mybrowser$open()
                ms.env$mybrowser$open()
                ms.env$mybrowser$setImplicitWaitTimeout(milliseconds = 10000)
        }
        
        environment(fun=MS_Login) <- ms.env
        environment(MS_Download) <- ms.env
        environment(MS_Import) <- ms.env
        environment(MS_Web_Setup) <- ms.env
        
}
