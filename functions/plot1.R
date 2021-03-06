plot1<-function(){
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
  ##generate plot
  hist(hpcuse$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
  ##copy to file
  dev.copy(png,'plot1.png')
  dev.off()
}  