#plot1.R -- Recreate plot1.png (Global Active Power Histogram)
#Assume data is in working directory under directory: "exdata-data-household_power_consumption"
#and data is in file: "household_power_consumption.txt"
pathToFile <- "./exdata-data-household_power_consumption/household_power_consumption.txt"

powerConsumption <- read.table(pathToFile, sep=";", header = TRUE,na.strings = "?", colClasses = c("character","character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
#Subset only the data we'll be using
powerData <- subset(powerConsumption, Date == "2/2/2007" | Date == "1/2/2007")

#open the png, create the plot, and then close the png file
png(file = "plot1.png", width = 480, height = 480)
hist(powerData$Global_active_power, 
     col = "red", 
     main="Global Active Power",
     xlab = "Global Active Power (kilowatts)"
     )
dev.off()