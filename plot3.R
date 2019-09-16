# Coursera Course: Exploratory Analysis
# Assignment 1 - Plot 3
# Date: 16.09.2019

Sys.setenv("LANGUAGE"="En") # This is needed for english labels

# Download the Individual household electric power consumption data set
library(sqldf)
ifile <- 'power_consumption.zip'
if (!(file.exists(ifile))){
    url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
    download.file(url,destfile=ifile,method='curl')
    unzip(ifile)
}

# Read subset of data 
sql_query = "SELECT * FROM file WHERE Date = '1/2/2007' OR Date = '2/2/2007'"
if (!exists('hpc')) {hpc<-read.csv2.sql("household_power_consumption.txt", sql = sql_query,na.Strings='?')
# Combine Date and Time to one 'Date-column and remove the Time column
hpc$Date <- strptime(paste(hpc$Date,hpc$Time),format='%d/%m/%Y %H:%M:%S')
hpc$Time <- NULL}

# Make plot 3
png(file='plot3.png',width = 480, height = 480, unit = "px")
par(mfrow=c(1,1))
plot(hpc$Date,hpc$Sub_metering_1,type='l',ylab='Energy sub metering',xlab='')
lines(hpc$Date,hpc$Sub_metering_2,col='red')
lines(hpc$Date,hpc$Sub_metering_3,col='blue')
legend('topright',col=c('black','red','blue'),legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),lty=1)
dev.off()


