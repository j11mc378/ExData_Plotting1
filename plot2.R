#plot2.R -- Recreate plot2.png - Global Active Power
pathToFile <- "./exdata-data-household_power_consumption/household_power_consumption.txt"

powerConsumption <- read.table(pathToFile, sep=";", header = TRUE,na.strings = "?", colClasses = c("character","character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
#Subset only the data we'll be using
powerData <- subset(powerConsumption, Date == "2/2/2007" | Date == "1/2/2007")

#create a datetime variable
datetime <- paste(powerData$Date,powerData$Time, sep = " ")
#Need to convert this from character type to date/time types
datetime <- strptime(datetime, "%d/%m/%Y %H:%M:%S")

#add the datetime to the powerData dataset
powerData$datetime <- datetime

#open the png, create the plot, and then close the png file
png(file = "plot2.png", width = 480, height = 480)
with(powerData, plot(datetime, Global_active_power, 
                     type = "l", 
                     xlab="",
                     ylab="Global Active Power (kilowatts)"))

dev.off()