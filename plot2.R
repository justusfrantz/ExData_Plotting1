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


png(filename="plot2.png", width=480, height=480,bg ="transparent")
plot(rangedData$DateTime, 
     rangedData$Global_active_power, 
     type="l",
     col="black", 
     xlab="", 
     ylab="Global Active Power (kilowatts)", 
     main="")
dev.off()