# First save data to working directory. Data can be found at the following address:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# Read in data
newFile <- read.table("household_power_consumption.txt", header=TRUE, 
                      sep=";", na.strings = "?",  dec=".",
                      stringsAsFactors=FALSE,
                      colClasses=c(rep("character",2), rep("numeric",7)))
# Subset data to include only 2/1/2007-2/2/2007
Sub1 <- subset(newFile,as.Date(newFile$Date,format='%d/%m/%Y')>=as.Date('2007-02-01',format='%Y-%m-%d')) 
Power <- subset(Sub1,as.Date(Sub1$Date,format='%d/%m/%Y')<=as.Date('2007-02-02',format='%Y-%m-%d'))
# Create and format a DateTime variable
Power$DateTime <- paste(Power$Date, Power$Time)
Power$DateTime <-strptime(Power$DateTime, "%d/%m/%Y %H:%M:%S")

#Create a PNG file with 4 graphs
png(file = "plot4.png", width = 480, height = 480, units = 'px') # create PNG file in working directory
par(mfrow = c(2,2)) #Set format as 2 rows/2 columns
with(Power, {
  # Plot 1
  plot(DateTime, Global_active_power, type="l", xlab=' ', 
       ylab='Global Active Power') 
  # Plot 2
  plot(DateTime, Voltage, type="l", xlab='datetime', ylab='Voltage') 
  # Plot 3
  plot(DateTime, Sub_metering_1, type="l", xlab=' ', ylab='Energy sub metering')
  lines(DateTime, Sub_metering_2, col='red')
  lines(DateTime, Sub_metering_3, col='blue')
  legend("topright", col=c("black", "red", "blue"), lty = 1, bty = "n",
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  #Plot 4
  plot(DateTime, Global_reactive_power, type="l", xlab='datetime', 
       ylab='Global_reactive_power') 
})
dev.off() ## Close PNG device