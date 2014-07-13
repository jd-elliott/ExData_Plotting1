## Read consumption data
raw <- read.table("household_power_consumption.txt", sep=";", header=TRUE,
                   colClasses=c("character", "character", "numeric", "numeric",
                                "numeric", "numeric", "numeric", "numeric",
                                "numeric"),
                   na.strings="?")


## Subset data for target date range
data <- subset(raw, Date=="1/2/2007" | Date=="2/2/2007")

## Conform datetime columns
x <- paste(data$Date, data$Time)
data[["Date"]] <- as.Date(x, format="%d/%m/%Y")
data[["Time"]] <- strptime(x, format="%d/%m/%Y %H:%M:%S")


## Plot chart of global active power by datetime to PNG
png(file="plot2.png", width=480, height=480)
plot(data$Time, data$Global_active_power, type="n",
     xlab="", ylab="Global Active Power (kilowatts)")
lines(data$Time, data$Global_active_power)
dev.off()
