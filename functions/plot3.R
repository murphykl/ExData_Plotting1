plot3<-function(){
  hpc<-read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")
  ##convert to date format
  hpc$Date<-as.Date(hpc$Date, "%d/%m/%Y")
  ##filter data to desired dates
  hpcuse<-subset(hpc, Date=="2007-02-01"| Date=="2007-02-02")
  ##create unified date-time column
  hpcuse$datetime<-paste(hpcuse$Date, hpcuse$Time)
  ##convert date-time column to date time format
  hpcuse$datetime<-strptime(hpcuse$datetime, "%Y-%m-%d %H:%M:%S")
  ##convert Global_active_power to numeric
  hpcuse$Global_active_power<-as.numeric(as.character(hpcuse$Global_active_power))
  ##convert sub_meterings to numeric
  hpcuse$Sub_metering_1<-as.numeric(as.character(hpcuse$Sub_metering_1))
  hpcuse$Sub_metering_2<-as.numeric(as.character(hpcuse$Sub_metering_2))
  hpcuse$Sub_metering_3<-as.numeric(as.character(hpcuse$Sub_metering_3))
  ##generate plot
  png("plot3.png")
  plot(hpcuse$datetime, hpcuse$Sub_metering_1, pch=".", xlab="", ylab="Energy sub metering")
  points(hpcuse$datetime, hpcuse$Sub_metering_1, pch=".", col="red")
  points(hpcuse$datetime, hpcuse$Sub_metering_3, pch=".", col="blue")
  lines(hpcuse$datetime, hpcuse$Sub_metering_1, type="l")
  lines(hpcuse$datetime, hpcuse$Sub_metering_2, type="l", col="red")
  lines(hpcuse$datetime, hpcuse$Sub_metering_3, type="l", col="blue")
  legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1), col=c("black", "red", "blue"))
  dev.off()
}  