#plot3.R -- Recreate plot3.png - Energy by Submetering
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
png(file = "plot3.png", width = 480, height = 480)

#Create a plot and add the submetering elements individually
#Main plot elements and adding submetering 1 for y coordinates
plot(powerData$datetime, powerData$Sub_metering_1, 
                     type = "n",
                      xlab = "",
                      ylab="Energy sub metering")

#add the data lines, and assign respective colors
lines(powerData$datetime, powerData$Sub_metering_1)
lines(powerData$datetime, powerData$Sub_metering_2, col="red")
lines(powerData$datetime, powerData$Sub_metering_3, col="blue")

#add the required legend with solid lines and correct colors
legend("topright", #location
       c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), #text to display
       lty = "solid" , #type of line
       col = c("black", "red", "blue")) #line colors

dev.off()