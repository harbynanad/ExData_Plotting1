library("data.table")

# set working directory

setwd("~/Desktop/Coursera/Exploratory Data Analysis")

# subset data for dates

globalPower <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# prevents scientific notation in histogram

globalPower[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Change Date column to date type

globalPower[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# filter dates

globalPower <- globalPower[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

# save to a PNG file with a width of 480 pixels and a height of 480 pixels

png("plot1.png", width=480,	 height=480)

# Plot

hist(globalPower[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()
