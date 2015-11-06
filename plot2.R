
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

# Cocatanate Date and Time. Assign to vector d_t
d_t <- paste(epc$Date, epc$Time)
d_t <- as.POSIXlt(d_t)
class(d_t)

#  Draw plot as shown as plot 2 in instructions
plot(d_t, epc$Global_active_power, type = "l", xlab = "", ylab = "")
title(xlab = "", ylab = "Global Active Power (kilowatts)", cex.lab = 0.75, main.lab = 0.9)

# Copy plot in a png file
dev.copy(png,'plot2.png', width = 480, height = 480)
dev.off()
