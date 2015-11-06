
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

# Checking epc.
View(epc) # Dates are in correct format.

# Draw histogram as shown in instructions.
hist(epc$Global_active_power, main = "Global Active Power",  xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", col = "red", cex.main = 0.9, cex.lab = 0.75)

# Copy the plot to a png file
dev.copy(png,'plot1.png', width = 480, height = 480)
dev.off()
dev.cur()
