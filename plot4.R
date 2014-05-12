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
png(filename="plot4.png",width=480,height=480)

##Set parameters mfrow to create a 2 by 2 array of plots
## Parameter cex will control maginifcation of plot realtive to default
par(mfrow = c(2, 2),cex=0.75)

## PLOT 1: Global Active Power usage on the selected timeline
plot(pwrsubdata$Time,as.numeric(as.character(pwrsubdata$Global_active_power)),type="l",xlab="",ylab="Global Active Power")

## PLOT 2: Voltage grpah on the selected timeline
plot(pwrsubdata$Time,as.numeric(as.character(pwrsubdata$Voltage)),type="l",xlab="datetime",ylab="Voltage")

## PLOT 3: Energy at the Sub meters
## Plot the first graph 'Sub_metering_1' with parameter type=l (for line)
## Parameters xlab and ylab are for setting the axes lables
## Parameter 'yaxt="n"' will make it NOT print the y-axis. This is required so that we can customize the y-axis scaling later.
plot(pwrsubdata$Time,as.numeric(as.character(pwrsubdata$Sub_metering_1)),type="l",xlab="",ylab="Energy sub metering",yaxt="n")

## Now, we make the y-axis scaling.
## Create a yticks variable with a sequence from 0 t 30 with step size 10
yticks<-seq(0,30,10)

## The axis function will apply the yticks to y-axis (first parameter=2)
axis(2,at=yticks)

## Add more lines to the same plot
## Plot second line graph for 'Sub_metering_2' with line color=Red
lines(pwrsubdata$Time,as.numeric(as.character(pwrsubdata$Sub_metering_2)),type="l",col="Red")

## Plot third line graph for 'Sub_metering_3' with line color=Blue
lines(pwrsubdata$Time,as.numeric(as.character(pwrsubdata$Sub_metering_3)),type="l",col="Blue")

##Finally, add legend at the top right corner of the graph
## SPecify color vector 'col' to match the graph line colors above
## Parameter 'bty="n"' will ensure that NO border line is drawn for legend
## Paramerter 'lty' and 'pch' will ensure legend type = line
legend("topright",col=c("Black","Red","Blue"),bty="n",lty=1,pch=NA,legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## PLOT 4: Global Reactive Power on the selected timeline
plot(pwrsubdata$Time,as.numeric(as.character(pwrsubdata$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")

##Close the graphics device
dev.off()