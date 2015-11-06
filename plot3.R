
# Download data to working directory
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              destfile = "El_Po_Co")

# unzip file and store in working directory
unzip("EL_Po_Co")

# Load data.table package to use fread()
library(data.table)

# Read in data converting "?" and other possible missing values. Name data frame EPC
EPC <- fread("household_power_consumption.txt", na.strings = c("NA","N/A","null","?"))

# Taking a look at data.
head(EPC)
str(EPC)
dim(EPC)
names(EPC)
class(EPC$Date)
summary(EPC)
sum(is.na(EPC))
7*25979         # Total Nas = 181853. 25979 NAs in each of 7 columns

# Subset EPC to contain only data for 1/22007 & 2/2/2007. Assign the name epc to subset.
epc <- subset(EPC, EPC$Date == "1/2/2007" | EPC$Date == "2/2/2007")

# Checking epc.
View(epc)
str(epc)
summary(epc)
sum(is.na(epc)) # epc does not have any NAs

# Load lubridate package to convert dates.
library(lubridate)

# Convert Date to YYY-MM-DD
epc$Date <- dmy(epc$Date)
class(epc$Date)

# Concatanate Date and Time. Assign to vector d_t
d_t <- paste(epc$Date, epc$Time)
class(d_t)
d_t <- as.POSIXlt(d_t)

# Draw plot as shown in plot 3 of instructions and save in a png file.
png("plot3.png")

plot(d_t, epc$Sub_metering_1,  type = "l", xlab = "", ylab = "")
lines(d_t, epc$Sub_metering_2, col = "red")
lines(d_t, epc$Sub_metering_3, col = "blue")
title(ylab = "Energy sub metering", cex.lab = 0.9)
legend("topright", lty=1, lwd=1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()

