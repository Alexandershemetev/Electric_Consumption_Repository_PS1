#1 Read the raw_data 
#                         C:\Users\Alex\Documents\COURSERA STUDIES\Exploratory_Data_Analysis\PS1_electirc_consumption\exdata_data_household_power_consumption
link_to_file <- "C:\\Users\\Alex\\Documents\\COURSERA STUDIES\\Exploratory_Data_Analysis\\PS1_electirc_consumption\\exdata_data_household_power_consumption\\household_power_consumption.txt"
# Previewing in Notepad++ results:
# Delimeter ";" Decimals separator "." 
raw_data <- read.table(link_to_file, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
str(raw_data)
raw_data$Date1 = as.Date(raw_data$Date, "%d/%m/%Y")
str(raw_data)
# my_raw_data_subset <- raw_data[raw_data$Date %in% c("1/2/2007","2/2/2007") ,]
my_raw_data_subset <- raw_data[raw_data$Date1 >= as.Date("2007-02-01") & raw_data$Date1 <= as.Date("2007-02-02"), ]
# View(my_raw_data_subset) #Looks OK - the subset as is expected. 
str(my_raw_data_subset)
library(chron)
# r1 <- strptime(v1, format = "%H:%M:%S")
my_raw_data_subset$DateTime <- paste(my_raw_data_subset$Date, my_raw_data_subset$Time, sep = " ")
my_raw_data_subset$Time1 <- strptime(my_raw_data_subset$DateTime, format = "%d/%m/%Y %H:%M:%S")

# my_raw_data_subset$Time1 <- strptime(my_raw_data_subset$Time, format = "%H:%M:%S")
# my_raw_data_subset$Date <- my_raw_data_subset$Date1 #If needed to clean these potentially obsolete columns (but the old columns may be useful for plotting 
# my_raw_data_subset$Time <- my_raw_data_subset$Time1
# my_raw_data_subset$Time1 = NULL 
# my_raw_data_subset$Date1 = NULL
# my_raw_data_subset$DateTime = NULL

# View(my_raw_data_subset)

# my_raw_data_subset$DateTime <- paste(my_raw_data_subset$Date, my_raw_data_subset$Time, sep = " ")

# df1 <- within(df1, { timestamp=strptime(paste(D, Time), "%Y/%m/%d%H:%M:%S") })
# my_raw_data_subset$DateTime <- within(my_raw_data_subset, { timestamp=strptime(paste(Date, Time), "%Y-%m-%d%H:%M:%S") })
# df1$TS <- as.POSIXct(paste(df1$D, df1$Time))
# my_raw_data_subset$DateTime <- as.POSIXct(paste(my_raw_data_subset$Date, my_raw_data_subset$Time))

str(my_raw_data_subset)

#str(my_raw_data_subset)

my_raw_data_subset$Global_active_power <- as.numeric(my_raw_data_subset$Global_active_power)
my_raw_data_subset$Sub_metering_1 <- as.numeric(my_raw_data_subset$Sub_metering_1)
my_raw_data_subset$Sub_metering_2 <- as.numeric(my_raw_data_subset$Sub_metering_2)
my_raw_data_subset$Sub_metering_3 <- as.numeric(my_raw_data_subset$Sub_metering_3)
my_raw_data_subset$Global_reactive_power <- as.numeric(my_raw_data_subset$Global_reactive_power)
my_raw_data_subset$Voltage <- as.numeric(my_raw_data_subset$Voltage)


#### PLOT 1: Frequency Histogram 

hist(my_raw_data_subset$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

png("C:\\Users\\Alex\\Documents\\COURSERA STUDIES\\Exploratory_Data_Analysis\\PS1_electirc_consumption\\plot1.png", width=480, height=480)
hist(my_raw_data_subset$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
# We will only be using raw_data from the dates 2007-02-01 and 2007-02-02. One alternative is to read the raw_data from just those dates rather than reading in the entire raw_dataset and subsetting to those dates.

#### Plot 2 - Weekdays electricity consumption 
# if(condition==X){
#    source("program_A.R")
# }else{
#    source("program_B.R")
# }
source("C:\\Users\\Alex\\Documents\\COURSERA STUDIES\\Exploratory_Data_Analysis\\PS1_electirc_consumption\\Plot2.R")
Sys.setenv("LANGUAGE"="En"); Sys.setlocale("LC_ALL", "English") #For devices who are not English-based
png("C:\\Users\\Alex\\Documents\\COURSERA STUDIES\\Exploratory_Data_Analysis\\PS1_electirc_consumption\\plot2.png", width=480, height=480)
plot(my_raw_data_subset$Time1, my_raw_data_subset$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()


#### Plot 3 - Sub-Meters (3 different consumption lines) plotting: 
my_raw_data_subset$Sub_metering_1 <- as.numeric(my_raw_data_subset$Sub_metering_1)
my_raw_data_subset$Sub_metering_2 <- as.numeric(my_raw_data_subset$Sub_metering_2)
my_raw_data_subset$Sub_metering_3 <- as.numeric(my_raw_data_subset$Sub_metering_3)
str(my_raw_data_subset)


png("C:\\Users\\Alex\\Documents\\COURSERA STUDIES\\Exploratory_Data_Analysis\\PS1_electirc_consumption\\plot3.png", width=480, height=480)
plot(my_raw_data_subset$Time1, my_raw_data_subset$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(my_raw_data_subset$Time1, my_raw_data_subset$Sub_metering_2, type="l", col="red")
lines(my_raw_data_subset$Time1, my_raw_data_subset$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()


#### Plot 4 - 4 Plots In 1 


png("C:\\Users\\Alex\\Documents\\COURSERA STUDIES\\Exploratory_Data_Analysis\\PS1_electirc_consumption\\plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(my_raw_data_subset$Time1, my_raw_data_subset$Global_active_power, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(my_raw_data_subset$Time1, my_raw_data_subset$Voltage <- as.numeric(my_raw_data_subset$Voltage), type="l", xlab="datetime", ylab="Voltage")

plot(my_raw_data_subset$Time1, my_raw_data_subset$Sub_metering_1, type="l", ylab="Energy Submetering", xlab="")
lines(my_raw_data_subset$Time1, my_raw_data_subset$Sub_metering_2, type="l", col="red")
lines(my_raw_data_subset$Time1, my_raw_data_subset$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(my_raw_data_subset$Time1, my_raw_data_subset$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()

