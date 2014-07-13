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

## Plot histogram of global active power to PNG
png(file="plot1.png", width=480, height=480)
hist(data$Global_active_power, col="red", 
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.off()
