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


## Plot multiple consumption charts to PNG
png(file="plot4.png", width=480, height=480)
par(mfcol=c(2,2))
plot(data$Time, data$Global_active_power, type="n",
     xlab="", ylab="Global Active Power (kilowatts)")
lines(data$Time, data$Global_active_power)
plot(data$Time, data$Sub_metering_1, type="n",
     xlab="", ylab="Energy sub metering")
lines(data$Time, data$Sub_metering_1, col="black")
lines(data$Time, data$Sub_metering_2, col="red")
lines(data$Time, data$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1, col=c("black", "red", "blue"))
plot(data$Time, data$Voltage, type="n",
     xlab="datetime", ylab="Voltage")
lines(data$Time, data$Voltage)
plot(data$Time, data$Global_reactive_power, type="n",
     xlab="datetime", ylab="Global_reactive_power")
lines(data$Time, data$Global_reactive_power)
dev.off()
