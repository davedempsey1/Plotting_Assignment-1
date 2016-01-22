if(!file.exists("exdata-data-household_power_consumption.zip")) {
  temporaryfile <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temporaryfile)
  file <- unzip(temporaryfile)
  unlink(temporaryfile)
  #download and unzips source material
}
power <- read.table(file, header=T, sep=";")
power$Date <- as.Date(power$Date, format="%d/%m/%Y")
df <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))
df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))
#Puts source code into data frame

fourthplot <- function() {
  par(mfrow=c(2,2))
  #creates 2x2 window to show all 4 plots
  
  plot(df$timestamp,df$Global_active_power, type="l", xlab="", ylab="Global Active Power")
  #recreates plot 2 in upper left quadrant
  
  plot(df$timestamp,df$Voltage, type="l", xlab="datetime", ylab="Voltage")
  #Creates new plot in upper right quadrant
  
  plot(df$timestamp,df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(df$timestamp,df$Sub_metering_2,col="red")
  lines(df$timestamp,df$Sub_metering_3,col="blue")
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5)
  #recreates plot 3 in lower left quadrant
  
  plot(df$timestamp,df$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  #Creates new plots in lower right quadrant
  
  dev.copy(png, file="plot4.png")
  dev.off()
  #creates file
  
}
fourthplot()
#runs function