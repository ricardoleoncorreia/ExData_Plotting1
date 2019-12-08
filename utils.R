url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
data.file <- 'household_power_consumption.txt'

get_data <- function(columns) {
    
    if (!file.exists(data.file)) download_data()
    
    data <- read.table(data.file, sep = ";", stringsAsFactors = FALSE, header = TRUE) %>%
            mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>%
            filter(Date == '2007-02-01' | Date == '2007-02-02')
    
    data[, columns]
}

download_data <- function() {
    temp <- tempfile()
    download.file(url, temp)
    unzip(temp, exdir = "./")
    unlink(temp)
}