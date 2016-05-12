if (exists("select.source") == FALSE)
        select.source <- "main"

if (select.source == "main") {
        
        starttime <- Sys.time()
        
        if (!dir.exists("data")) {
                dir.create("data")
        }
        
        #         if (!file.exists(paste0("data/", filename))) {
        #                 fileUrl <- "https://dataset/Coursera-SwiftKey.zip"
        #                 setInternet2(use = TRUE)
        #                 download.file(fileUrl, destfile = paste0("data/", filename))
        #                 dateDownloaded <- date()
        #                 write(dateDownloaded, file = "data/dateDownloaded.txt")
        #         }
        
        timer(starttime)
        rm(starttime)
        
}

#morningstar
if (select.source == "ms") {
        
        starttime <- Sys.time()
        
        if (!dir.exists("data/ms")) {
                dir.create("data/ms")
        }
        
        if (!dir.exists("data/ms/spreadsheets")) {
                dir.create("data/ms/spreadsheets")
        }
        
        if (!dir.exists("data/ms/spreadsheets/qtr")) {
                dir.create("data/ms/spreadsheets/qtr")
        }
        
        if (!dir.exists("data/ms/spreadsheets/yr")) {
                dir.create("data/ms/spreadsheets/yr")
        }
        
        if (!dir.exists("data/ms/rds")) {
                dir.create("data/ms/rds")
        }
        
#         checkForServer()
#         startServer()
#         fprof <- getFirefoxProfile("C:/Users/Ted/AppData/Roaming/Mozilla/Firefox/Profiles/wlb50pz5.WebDriver_Profile", useBase = TRUE)
#         mybrowser <- remoteDriver(extraCapabilities = fprof)
#         mybrowser$open()
#         #testURL <- "https://www.webscorer.com/resources/templatestart"
#         #mybrowser$navigate(testURL)
#         #testbutton <- mybrowser$findElement(using = "class", "downloadlink")
#         #testbutton$clickElement()
#         
#         if (!file.exists(paste0("data/", filename))) {
#                         fileUrl <- "https://dataset/Coursera-SwiftKey.zip"
#                         setInternet2(use = TRUE)
#                         download.file(fileUrl, destfile = paste0("data/", filename))
#                         dateDownloaded <- date()
#                         write(dateDownloaded, file = "data/dateDownloaded.txt")
#                 }
#         
        timer(starttime)
        rm(starttime)
        
}


