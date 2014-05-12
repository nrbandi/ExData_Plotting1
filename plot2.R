## Read the power consumption data in to data frame
pwrdata<-read.table("household_power_consumption.txt",header=TRUE,sep=";")

## Convert the 'Date' column from factor to a Date format
pwrdata$Date<-as.Date(pwrdata$Date,format='%d/%m/%Y')

## Then generate a subset of consumption data matching the dates 01-Feb-2007 or 02-Feb-2007 
pwrsubdata<-subset(pwrdata,pwrdata$Date=="2007-02-01" | pwrdata$Date=="2007-02-02")

## Within the subset apply 'striptime' on the 'Time' column to get the full timestamp
## Use the 'paste' function and columns 'Date' and 'Time' to get the full timestamp 
pwrsubdata$Time<-strptime(paste(pwrsubdata$Date,pwrsubdata$Time,sep=' '),format="%Y-%m-%d %H:%M:%S")

## Create PNG graphics device with the required dimensions
png(filename="plot2.png",width=480,height=480)

## Make a plot from 'Global Active Power' on the timeline 'Time'
## Parameter type="l" will set the graph type to line
## Parameters xlab and ylab will set both the axes labels
plot(pwrsubdata$Time,as.numeric(as.character(pwrsubdata$Global_active_power)),type="l",xlab="datetime",ylab="Global Active Power (kilowatts)")

##Close the graphics device
dev.off()
