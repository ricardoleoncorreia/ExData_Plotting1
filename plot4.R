source('utils.R')
library(dplyr)

data <- download_data()

current.data <- data %>%
                mutate(Datetime = paste(Date, Time, sep = " ")) %>%
                mutate(Datetime = as.POSIXct(strptime(Datetime, format = "%d/%m/%Y %H:%M:%S"))) %>%
                mutate(Sub_metering_1 = as.numeric(Sub_metering_1)) %>%
                mutate(Sub_metering_2 = as.numeric(Sub_metering_2)) %>%
                mutate(Sub_metering_3 = as.numeric(Sub_metering_3)) %>%
                mutate(Global_active_power = as.numeric(Global_active_power)) %>%
                mutate(Global_reactive_power = as.numeric(Global_reactive_power)) %>%
                mutate(Voltage = as.numeric(Voltage))

png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

## Fist plot
with(current.data, plot(Datetime,
                        Global_active_power,
                        xlab = "",
                        ylab = "Global Active Power",
                        type = "l"))


## Second plot
with(current.data, plot(Datetime,
                        Voltage,
                        xlab = "datetime",
                        ylab = "Voltage",
                        type = "l"))


## Third plot
with(current.data, plot(Datetime,
                        Sub_metering_1,
                        xlab = "",
                        ylab = "Energy sub metering",
                        type = "l"))
with(current.data, lines(Datetime, Sub_metering_2, col = "red"))
with(current.data, lines(Datetime, Sub_metering_3, col = "blue"))
legend('topright',
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), bty = "n", lty = 1)


## Fourth plot
with(current.data, plot(Datetime,
                        Global_reactive_power,
                        xlab = "datetime",
                        ylab = "Global_reactive_power",
                        type = "l"))


dev.off()
