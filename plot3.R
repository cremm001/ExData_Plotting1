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

#Create a plot of DateTime and 3 Sub_metering variables and save as a PNG file
png(file = "plot3.png", width = 480, height = 480, units = 'px') # create PNG file in working directory
plot(Power$DateTime, Power$Sub_metering_1, type="l", xlab=' ', ylab='Energy sub metering') # Create plot   
lines(Power$DateTime, Power$Sub_metering_2, col='red') # Add line 2
lines(Power$DateTime, Power$Sub_metering_3, col='blue') # Add line 3
legend("topright", col=c("black", "red", "blue"), lty = 1,
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))  # Create legend
dev.off() ## Close PNG device