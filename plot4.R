## Exploratory Data Analysis - Assignment 1 - PLOT 4
## Author: Andre Felix Miertschink
## Date  : 15/04/2020
##
## This scripts is an assignment project for the course Exploratory Data Analysis
## of Coursera

## Set the file name for the dataset from current work directory
datasetFilename <- "./household_power_consumption.txt"

# Install (if needed) and load the package "sqldf" which is required for read.csv.sql
require("sqldf")
## Loading Data
mydata <- read.csv.sql(file=datasetFilename,
                        sql="select * from file where (Date == '1/2/2007' or Date == '2/2/2007') and Voltage != '?' ",
                        sep = ";")

# Creating the new column based on Date and Time and converting the columns 
mydata$DateTime  <- strptime(paste(mydata$Date,mydata$Time,sep = " "), format="%d/%m/%Y %H:%M:%S")
mydata$Date  <- suppressWarnings(as.Date(mydata$Date,"%d/%m/%Y"))
mydata$Global_active_power  <- suppressWarnings(as.numeric(mydata$Global_active_power))
mydata$Global_reactive_power  <- suppressWarnings(as.numeric(mydata$Global_reactive_power))
mydata$Voltage  <- suppressWarnings(as.numeric(mydata$Voltage))
mydata$Global_intensity  <- suppressWarnings(as.numeric(mydata$Global_intensity))
mydata$Sub_metering_1 <- suppressWarnings(as.numeric(mydata$Sub_metering_1))
mydata$Sub_metering_2 <- suppressWarnings(as.numeric(mydata$Sub_metering_2))
mydata$Sub_metering_3 <- suppressWarnings(as.numeric(mydata$Sub_metering_3))

## PLOT 4
# The standard size is 480x480, therefore no need to change anything
png("plot4.png")
par(mfrow = c(2,2))
par(bg=NA)

#Similar to PLOT 2 ; Had to remove "(kilowatts)" from ylab
plot(mydata$DateTime,mydata$Global_active_power,type = "l",  ylab = "Global Active Power",  xlab = "")

#New PLOT
plot(mydata$DateTime,mydata$Voltage,type = "l",  ylab = "Voltage",  xlab = "datetime")

#Similar to PLOT 3  ; added box.lty=0 to remove border from the legend
plot(mydata$DateTime,
     mydata$Sub_metering_1,
     type = "l",  
     ylab = "Energy sub metering",  
     xlab = "",
     col = "black")
lines(mydata$DateTime,
     mydata$Sub_metering_2,
     col = "red")
lines(mydata$DateTime,
     mydata$Sub_metering_3,
     col = "blue")

legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1, box.lty=0)

#New PLOT
plot(mydata$DateTime,mydata$Global_reactive_power,type = "l",  ylab = "Global_reactive_power",  xlab = "datetime")


dev.off()

