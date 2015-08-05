if (!file.exists("data.zip")) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile="data.zip",
                method="curl")
  unzip("data.zip")  
}

datafile <- "./household_power_consumption.txt"
data <- read.table(datafile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
data$DateTime <- as.POSIXct(paste(data$Date, data$Time, sep=" "), 
                            format="%d/%m/%Y %H:%M:%S")
data$Date = as.Date(data$Date, format="%d/%m/%Y")
startDate = as.Date("01/02/2007", format="%d/%m/%Y")
endDate = as.Date("02/02/2007", format="%d/%m/%Y")
rangedData <- data[data$Date %in% c(startDate,endDate) ,]


png(filename="plot4.png", width=480, height=480, bg ="transparent")
par(mfcol=c(2,2))
plot(rangedData$DateTime, 
     rangedData$Global_active_power, 
     type="l",
     col="black", 
     xlab="", 
     ylab="Global Active Power (kilowatts)", 
     main="")

plot(rangedData$DateTime, 
     rangedData$Sub_metering_1, 
     type="l",
     col="black", 
     xlab="", 
     ylab="Energy sub metering", 
     main="")
lines(rangedData$DateTime, rangedData$Sub_metering_2, col="red")
lines(rangedData$DateTime, rangedData$Sub_metering_3, col="blue")
legend("topright",
       col = c("black", "red", "blue"),
       lwd=1, 
       lty=1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(rangedData$DateTime, 
     rangedData$Voltage, 
     type="l",
     col="black", 
     xlab="datetime", 
     ylab="Voltage", 
     main="")

plot(rangedData$DateTime, 
     rangedData$Global_reactive_power, 
     type="l",
     col="black", 
     xlab="datetime", 
     ylab="Global_reactive_power", 
     main="")

dev.off()