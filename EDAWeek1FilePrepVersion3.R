## EDA WEEK 1 PEER REVIEWED ASSIGNMENT
## JOHN ROGARD TABORI
## APRIL 27, 2020
## DATA SOURCE: archive.ics.uci.edu/ml/index.php
## DATA FILE TITLE: exdata_data_household_power_consumption.zip
## DATA FILE INTERNET LOCATION: d396qusza40orc.cloudfront.net
## NOTES:  Please note that the "household_power_consumption.txt"
## NOTES:  must be in your working directory or you must manipulate
## NOTES:  my code to provide a link to it for this program to work.
## NOTES:  My png files have been set to a 720 by 720 pixel display.
## NOTES:  They are unreadable at the the default 400 by 400 display on
## NOTES:  my computer, especially Plot 4.
## NOTES:  To those of you reviewing my work, "Thank You, Stay Safe!"
#######################################################################
## STANDARD PACKAGES CALLED AT OUTSET
library(dplyr)
library(readr)
library(tidyverse)
library(lubridate)
## ANALYSIS FILE SETUP CODE
EDAElecMasterFile <- read.table("household_power_consumption.txt", sep = ";", 
	header = T, stringsAsFactors = F)
EDAW1 <- filter(EDAElecMasterFile, Date == "1/2/2007")
EDAW2 <- filter(EDAElecMasterFile, Date == "2/2/2007")
EDAW1Final <- rbind(EDAW1, EDAW2)
EDAW1Final <- mutate(EDAW1Final, DateTime = paste(Date, Time))
EDAW1Final <- mutate(EDAW1Final, DateTime = dmy_hms(DateTime))
EDAW1Final <- mutate(EDAW1Final, Global_reactive_power = as.numeric(Global_reactive_power))
EDAW1Final <- mutate(EDAW1Final, Global_active_power = as.numeric(Global_active_power))
EDAW1Final <- mutate(EDAW1Final, Voltage = as.numeric(Voltage))
EDAW1Final <- mutate(EDAW1Final, Sub_metering_1 = as.integer(Sub_metering_1))
EDAW1Final <- mutate(EDAW1Final, Sub_metering_2 = as.integer(Sub_metering_2))
## PLOT 1 CODE FOR HISTOGRAM OF GLOBAL ACTIVE POWER
png(file = "Plot1.png", width = 720, height = 720)
hist(EDAW1Final$Global_active_power, col = "red",
	main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
## PLOT 2 CODE FOR GLOBAL ACTIVE KILOWATT POWER DRAW PER MINUTE OVER TWO DAYS 
png(file = "Plot2.png", width = 720, height = 720)
with(EDAW1Final, plot(DateTime, Global_active_power, type = "l",xlab = "",
	ylab = "Global Active Power (kilowatts)"))
dev.off()
## PLOT 3 CODE FOR SUB METERING USAGE (N = 3) PER MINUTE ACROSS TWO DAYS 
png(file = "Plot3.png", width = 720, height = 720)
with(EDAW1Final,plot(DateTime,Sub_metering_1,type="l",col="red",
	ylab = "Energy sub metering", xlab = ""))
with(EDAW1Final,lines(DateTime,Sub_metering_2,col="green"))
with(EDAW1Final,lines(DateTime,Sub_metering_3,col="blue"))
legend("topright", col = c("red", "green", "blue"), lty = 1,
	legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
## PLOT 4 CODE FOR DISPLAYING FOUR EXPLORATORY DATA GRAPHS -- SEE PLOTS 1-3
## PLUS VOLTAGE USAGE OVER SAME TWO DAY PERIOD
png(file = "Plot4.png", width = 720, height = 720)
par(mfrow = c(2, 2), mar = c(5, 4, 2, 1))
with(EDAW1Final, plot(DateTime, Global_active_power, type = "l",
	ylab = "Global active power", xlab = ""))
with(EDAW1Final, plot(DateTime, Voltage, type = "l"))
with(EDAW1Final,plot(DateTime,Sub_metering_1,type="l",col="red",
	ylab = "Energy sub metering", xlab = "", ))
with(EDAW1Final,lines(DateTime,Sub_metering_2,col="green"))
with(EDAW1Final,lines(DateTime,Sub_metering_3,col="blue"))
legend("topright", col = c("red", "green", "blue"), lty = 1,
	legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(EDAW1Final, plot(DateTime, Global_reactive_power, type = "l"))
dev.off()