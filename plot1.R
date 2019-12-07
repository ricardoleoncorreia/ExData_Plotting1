source('utils.R')

important_columns <- c("Date", "Time", "Global_active_power")
data <- download_data(columns = important_columns)

global_active_power <- sapply(data$Global_active_power, as.numeric)

png(filename = "plot1.png", width = 480, height = 480)

hist(global_active_power,
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

dev.off()
