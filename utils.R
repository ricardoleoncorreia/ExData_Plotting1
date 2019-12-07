url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download_data <- function(columns) {
    temp <- tempfile()
    
    download.file(url, temp)
    
    data <- read.table(
        unzip(temp, exdir = "./"),
        sep = ";",
        stringsAsFactors = FALSE,
        header = TRUE)
    unlink(temp)
    
    desired_range <- data$Date == '1/2/2007' | data$Date == '2/2/2007'
    data[desired_range, columns]
}