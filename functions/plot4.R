plot4<-function(){
  hpc<-read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")
  ##convert to date format
  hpc$Date<-as.Date(hpc$Date, "%d/%m/%Y")
  ##filter data to desired dates
  hpcuse<-subset(hpc, Date=="2007-02-01"| Date=="2007-02-02")
  ##create unified date-time column
  hpcuse$datetime<-paste(hpcuse$Date, hpcuse$Time)
  ##convert date-time column to date time format
  hpcuse$datetime<-strptime(hpcuse$datetime, "%Y-%m-%d %H:%M:%S")
  ##convert relevant columns to numeric
  hpcuse$Global_active_power<-as.numeric(as.character(hpcuse$Global_active_power))
  hpcuse$Global_reactive_power<-as.numeric(as.character(hpcuse$Global_reactive_power))
  hpcuse$Sub_metering_1<-as.numeric(as.character(hpcuse$Sub_metering_1))
  hpcuse$Sub_metering_2<-as.numeric(as.character(hpcuse$Sub_metering_2))
  hpcuse$Sub_metering_3<-as.numeric(as.character(hpcuse$Sub_metering_3))
  hpcuse$Voltage<-as.numeric(as.character(hpcuse$Voltage))
  ##generate plot
  png("plot4.png")
  par(mfcol= c(2,2))
  with(hpcuse, {
    plot(hpcuse$datetime, hpcuse$Global_active_power, pch=".", ylab="Global Active Power", xlab="")
    lines(hpcuse$datetime, hpcuse$Global_active_power, type="l")
    plot(hpcuse$datetime, hpcuse$Sub_metering_1, pch=".", xlab="", ylab="Energy sub metering")
    points(hpcuse$datetime, hpcuse$Sub_metering_2, pch=".", col="red")
    points(hpcuse$datetime, hpcuse$Sub_metering_3, pch=".", col="blue")
    lines(hpcuse$datetime, hpcuse$Sub_metering_1, type="l")
    lines(hpcuse$datetime, hpcuse$Sub_metering_2, type="l", col="red")
    lines(hpcuse$datetime, hpcuse$Sub_metering_3, type="l", col="blue")
    legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1), col=c("black", "red", "blue"), bty="n")
    plot(hpcuse$datetime, hpcuse$Voltage, pch=".", ylab="Voltage", xlab="datetime")
    lines(hpcuse$datetime, hpcuse$Voltage, type="l")
    plot(hpcuse$datetime, hpcuse$Global_reactive_power, pch=".", ylab="Global_reactive_power", xlab="datetime")
    lines(hpcuse$datetime, hpcuse$Global_reactive_power, type="l")
    dev.off()
  })  
}  
