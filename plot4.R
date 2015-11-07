#plot4.R -- Recreate plot4.png - Multiple plots
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
png(file = "plot4.png", width = 480, height = 480, bg="transparent")

#this plot will contain 2 columns and 2 rows. Each element will contain
#a separate plot.
#we'll start by creating the 2x2 sections then create/add each plot individually
par(mfrow = c(2,2))

#First plot (top left) - Global Active Power
with(powerData, plot(datetime, Global_active_power, 
                     type = "l", 
                     xlab="",
                     ylab="Global Active Power"))

#Second plot (top right) - Voltage
with(powerData, plot(datetime, Voltage, 
                     type = "l", 
                     ylab="Voltage"))


#Third plot (bottom left) - Energy sub metering
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

#Fourth plot (bottom right) - Global Reactive Power
with(powerData, plot(datetime, Global_reactive_power, 
                     type = "l"))

dev.off()