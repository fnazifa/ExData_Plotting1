library(magrittr)
library(dplyr)
# reading the data
power <- read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                    na.strings = "?", 
                    colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
#converting date
power$Date <- as.Date(power$Date, "%d/%m/%Y")
power <- power[complete.cases(power),]

#merging two columns to another a new column date_time
power$date_time <- (paste(power$Date, power$Time))

# filtering and arranging the columns
subpower <- power %>% filter(Date >= "2007-2-1" & Date <="2007-2-2")
subpower <- subpower %>% select(-Date, -Time, date_time, everything())

# converting date_time standard
subpower$date_time <- as.POSIXct(subpower$date_time)

#plotting Global active power over time with line plot
plot(subpower$date_time, subpower$Global_active_power , type="l", ylab="Global Active Power (kilowatts)", xlab="")

# Add the PNG file and R code file
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()
