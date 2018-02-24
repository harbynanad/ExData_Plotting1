library("data.table")

setwd("~/Desktop/Coursera/Exploratory Data Analysis")

# Subsets data for specified dates

globalPower <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Prevents scientific notation in the graph

globalPower[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Using POSIXct date to filter day and time

globalPower[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filter dates for 2007-02-01 and 2007-02-02

globalPower <- globalPower[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot3.png", width=480, height=480)

# Plot graph

plot(globalPower[, dateTime], globalPower[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(globalPower[, dateTime], globalPower[, Sub_metering_2],col="red")
lines(globalPower[, dateTime], globalPower[, Sub_metering_3],col="blue")
legend("topright"
       , col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       ,lty=c(1,1), lwd=c(1,1))

dev.off()
