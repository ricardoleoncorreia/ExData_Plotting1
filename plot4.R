source('utils.R')
library(dplyr)

data <- download_data()

current.data <- data %>%
                mutate(Datetime = paste(Date, Time, sep = " ")) %>%
                mutate(Datetime = as.POSIXct(strptime(Datetime, format = "%d/%m/%Y %H:%M:%S")))

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

## Fist plot
global_active_power <- sapply(data$Global_active_power, as.numeric)
plot(current.data$Datetime,
     global_active_power,
     xlab = "",
     ylab = "Global Active Power",
     type = "l")


## Second plot
voltage <- sapply(data$Voltage, as.numeric)
plot(current.data$Datetime,
     voltage,
     xlab = "datetime",
     ylab = "Voltage",
     type = "l")


## Third plot
sub_metering_data <- current.data %>%
    mutate(Sub_metering_1 = as.numeric(Sub_metering_1)) %>%
    mutate(Sub_metering_2 = as.numeric(Sub_metering_2)) %>%
    mutate(Sub_metering_3 = as.numeric(Sub_metering_3))

plot(sub_metering_data$Datetime,
     sub_metering_data$Sub_metering_1,
     xlab = "",
     ylab = "Energy sub metering",
     type = "l")
lines(sub_metering_data$Datetime, sub_metering_data$Sub_metering_2, col = "red")
lines(sub_metering_data$Datetime, sub_metering_data$Sub_metering_3, col = "blue")
legend('topright',
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), bty = "n", lty = 1)


## Fourth plot
global_reactive_power <- sapply(data$Global_reactive_power, as.numeric)
plot(current.data$Datetime,
     global_reactive_power,
     xlab = "datetime",
     ylab = "Global_reactive_power",
     type = "l")


dev.off()
