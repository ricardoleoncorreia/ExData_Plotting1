source('utils.R')
library(dplyr)

important_columns <- c("Date", "Time", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
data <- download_data(columns = important_columns)

current.data <- data %>%
                mutate(Sub_metering_1 = as.numeric(Sub_metering_1)) %>%
                mutate(Sub_metering_2 = as.numeric(Sub_metering_2)) %>%
                mutate(Sub_metering_3 = as.numeric(Sub_metering_3)) %>%
                mutate(Datetime = paste(Date, Time, sep = " ")) %>%
                mutate(Datetime = as.POSIXct(strptime(Datetime, format = "%d/%m/%Y %H:%M:%S")))

png(filename = "plot3.png", width = 480, height = 480)

with(current.data, plot(Datetime,
                        Sub_metering_1,
                        xlab = "",
                        ylab = "Energy sub metering",
                        type = "l"))
with(current.data, lines(Datetime, Sub_metering_2, col = "red"))
with(current.data, lines(Datetime, Sub_metering_3, col = "blue"))
legend('topright',
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), lty = 1)

dev.off()
