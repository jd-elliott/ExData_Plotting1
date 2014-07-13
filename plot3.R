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


## Plot chart of sub metering by datetime to PNG
png(file="plot3.png", width=480, height=480)
plot(data$Time, data$Sub_metering_1, type="n",
     xlab="", ylab="Energy sub metering")
lines(data$Time, data$Sub_metering_1, col="black")
lines(data$Time, data$Sub_metering_2, col="red")
lines(data$Time, data$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1, col=c("black", "red", "blue"))
dev.off()
