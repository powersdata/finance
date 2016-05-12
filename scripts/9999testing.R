#testing files
Stock <- "HOLX"
Type <- "IS"
Period <- "yr"

rm(Stock, Type, Period, type, filename, starttime, datafile, testURL, msbutton, msPeriod, msPeriodli, msSpan, msTimeframe, period, type, fileURL, endURL, i, j, k)


#rselenium
#testing files
Stock <- "HOLX"
Type <- "IS"
Period <- "yr"



MS_Login <- function(password){
        loginURL <- "https://www.morningstar.com/members/login.html?vurl="
        mybrowser$navigate(loginURL)
        msEmail <- mybrowser$findElement(using = 'css selector', "#uEmail")
        msEmail$sendKeysToElement(list("ted@powersdata.com"))
        msP <- mybrowser$findElement(using = 'css selector', "#uPassword")
        msP$sendKeysToElement(list(password))
        msbutton <- mybrowser$findElement(using = "xpath", "//*/input[@ng-click = 'submit(user)']")
        msbutton$clickElement()
}


mybrowser$navigate(fileURL)
#msTimeframe <- mybrowser$findElement(using = 'xpath', "//*/li [@onclick='showDropdown1(event,this);']")
msTimeframe <- mybrowser$findElement(using = 'css selector', "#Li1")


msTimeframe$clickElement()
#msSpan <- mybrowser$findElement(using = "xpath", "//*/li [@class = 'prem1']")

msSpan <- mybrowser$findElement(using = 'class', "prem1")
msSpan$clickElement()

#msTimeframe$sendKeysToElement(list("10 Years"))
#msTimeframe$sendKeysToElement(list("span class", key = "down_arrow", key = "enter"))

msbutton <- mybrowser$findElement(using = "class", "rf_export")
msbutton$clickElement(fprof)




library("RSelenium")
checkForServer()
startServer()
fprof <- getFirefoxProfile("C:/Program Files (x86)/Mozilla Firefox/", useBase = TRUE)
#remDr <- remoteDriver(extraCapabilities = fprof)
#FirefoxProfile fprof <- new FirefoxProfile()
fprof <- makeFirefoxProfile(list(browser.download.folderList="2", browser.download.dir = "C:/Temp", browser.download.manager.showWhenStarting="FALSE", browser.helperApps.neverAsk.saveToDisk= "text/csv"))

fprof <- makeFirefoxProfile(list(browser.download.folderList="2"))
#fprof.setPreference("browser.helperApps.neverAsk.saveToDisk","text/csv")
#remDr <- remoteDriver(extraCapabilities = fprof)
#remDr$open()


mybrowser <- remoteDriver(extraCapabilities = fprof)
mybrowser$open()
mybrowser$navigate(loginURL)
mybrowser$findElement(using = 'css selector', "#inputstring")
wxbox <- mybrowser$findElement(using = 'css selector', "#inputstring")
wxbox$sendKeysToElement(list("01701"))
wxbutton <- mybrowser$findElement(using = 'css selector', "#btnSearch")
wxbutton$clickElement()
mybrowser$goBack()
wxbox <- mybrowser$findElement(using = 'css selector', "#inputstring")
wxbox$sendKeysToElement(list("01701", "\uE007"))


#login
loginURL <- "https://www.morningstar.com/members/login.html?vurl="
mybrowser$navigate(loginURL)
msEmail <- mybrowser$findElement(using = 'css selector', "#uEmail")
msEmail$sendKeysToElement(list("ted@powersdata.com"))
msP <- mybrowser$findElement(using = 'css selector', "#uPassword")
msP$sendKeysToElement(list("pD42data"))
#msbutton <- mybrowser$findElement(using = 'name', "submit")
msbutton <- mybrowser$findElement(using = "xpath", "//*/input[@ng-click = 'submit(user)']")
msbutton$clickElement()



mybrowser$navigate(fileURL)
#msTimeframe <- mybrowser$findElement(using = 'xpath', "//*/li [@onclick='showDropdown1(event,this);']")
msTimeframe <- mybrowser$findElement(using = 'css selector', "#Li1")


msTimeframe$clickElement()
#msSpan <- mybrowser$findElement(using = "xpath", "//*/li [@class = 'prem1']")

msSpan <- mybrowser$findElement(using = 'class', "prem1")
msSpan$clickElement()

#msTimeframe$sendKeysToElement(list("10 Years"))
#msTimeframe$sendKeysToElement(list("span class", key = "down_arrow", key = "enter"))

msbutton <- mybrowser$findElement(using = "class", "rf_export")
msbutton$clickElement(fprof)


