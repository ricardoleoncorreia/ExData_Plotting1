source('utils.R')
library(dplyr)

data <- download_data()

global_active_power <- sapply(data$Global_active_power, as.numeric)
data <- data %>%
            mutate(Datetime = paste(Date, Time, sep = " ")) %>%
            mutate(Datetime = as.POSIXct(strptime(Datetime, format = "%d/%m/%Y %H:%M:%S")))

png(filename = "plot2.png", width = 480, height = 480)

plot(data$Datetime,
     global_active_power,
     xlab = "",
     ylab = "Global Active Power (kilowatts)",
     type = "l")

dev.off()
